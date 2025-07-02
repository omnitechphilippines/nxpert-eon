import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/quickalert.dart';

import '../../../../components/footer.dart';
import '../../../../components/header_banner.dart';
import '../../../../components/side_nav.dart';
import '../../../../components/custom_app_bar.dart';
import '../../../../components/product_master/add_product_modal.dart';
import '../../../../components/product_master/product_table.dart';
import '../../../../components/product_master/search_product_modal.dart';
import '../models/product_model.dart';
import '../controllers/product_master_controller.dart';

class ProductMasterPage extends StatefulWidget {
  const ProductMasterPage({super.key});

  @override
  State<ProductMasterPage> createState() => _ProductMasterPageState();
}

class _ProductMasterPageState extends State<ProductMasterPage> {
  final ProductMasterController _controller = ProductMasterController();
  List<Product> _products = []; 
  bool _isLoading = true;
  String _error = '';
  int _currentPage = 1;
  int _entriesPerPage = 10;
  int _totalCount = 0;

  // Filters (if needed later)
  // Example: String? _filterCode;

  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final response = await _controller.getProducts(
        page: _currentPage,
        limit: _entriesPerPage,
      );
      setState(() {
        _products = response.products;
        _totalCount = response.totalCount;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load products: $e';
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final int totalPages =
        _totalCount == 0 ? 1 : (_totalCount / _entriesPerPage).ceil();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'NXPERT EON'),
      drawer: SideNav(
        currentRoute: GoRouter.of(context)
            .routerDelegate
            .currentConfiguration
            .uri
            .toString(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const HeaderBanner(subtitle: 'PRODUCT MASTER'),

          // Top Controls
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text("Show "),
                    DropdownButton<int>(
                      value: _entriesPerPage,
                      items: [5, 10, 25, 50, 100]
                          .map((count) => DropdownMenuItem<int>(
                                value: count,
                                child: Text('$count'),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _entriesPerPage = value;
                            _currentPage = 1;
                          });
                          _loadProducts();
                        }
                      },
                    ),
                    const Text(" entries"),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => showSearchProductModal(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(150, 50),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.search),
                          SizedBox(width: 8),
                          Text('Search'),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => showAddProductModal(context, (_) {
                        _currentPage = 1;
                        _loadProducts();
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          title: 'Added!',
                          text: 'Product has been successfully added.',
                          confirmBtnColor: Colors.green,
                        );
                      }),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(150, 50),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add),
                          SizedBox(width: 8),
                          Text('Add Product'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Table / Loader / Error
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _error.isNotEmpty
                      ? Center(child: Text(_error))
                      : ProductTable(
                          products: _products,
                          onDelete: (index) async {
                            _currentPage = 1;
                            await _loadProducts();
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              title: 'Deleted!',
                              text: 'Product has been successfully deleted.',
                              confirmBtnColor: Colors.green,
                            );
                          },
                          onUpdate: (index, updatedProduct) async {
                            _currentPage = 1;
                            await _loadProducts();
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              title: 'Updated!',
                              text: 'Product has been successfully updated.',
                              confirmBtnColor: Colors.green,
                            );
                          },
                        ),
            ),
          ),

          // Pagination Controls
          if (!_isLoading && _error.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _products.isEmpty
                        ? 'Showing 0 entries'
                        : 'Showing ${((_currentPage - 1) * _entriesPerPage) + 1} '
                            'to ${((_currentPage - 1) * _entriesPerPage) + _products.length} '
                            'of $_totalCount entries',
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: _currentPage > 1
                            ? () {
                                setState(() => _currentPage--);
                                _loadProducts();
                              }
                            : null,
                        child: const Text("Previous"),
                      ),
                      Text('Page $_currentPage of $totalPages'),
                      TextButton(
                        onPressed: (_currentPage * _entriesPerPage < _totalCount)
                            ? () {
                                setState(() => _currentPage++);
                                _loadProducts();
                              }
                            : null,
                        child: const Text("Next"),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          const Footer(),
        ],
      ),
    );
  }
}
