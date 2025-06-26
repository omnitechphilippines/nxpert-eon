import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../components/footer.dart';
import '../../../../components/header_banner.dart';
import '../../../../components/side_nav.dart';
import '../../../../components/custom_app_bar.dart';
import '../../../../components/product_master/add_product_modal.dart';
import '../../../../components/product_master/search_product_modal.dart';
import '../../../../components/product_master/product_table.dart';
import 'package:quickalert/quickalert.dart';
import '../models/product_model.dart';

class ProductMasterPage extends StatefulWidget {
  const ProductMasterPage({super.key});

  @override
  State<ProductMasterPage> createState() => _ProductMasterPageState();
}

class _ProductMasterPageState extends State<ProductMasterPage> {
  final List<Product> _products = [
    Product(
      productCode: 'P001',
      productName: 'Crank Case',
      productSpecification: 'Heavy-duty steel',
      productInternalCode: 'INT-001',
    ),
    Product(
      productCode: 'P002',
      productName: 'Crank Case 2',
      productSpecification: 'Rubber grip',
      productInternalCode: 'INT-002',
    ),
  ];

  void _addProduct(Product product) {
    setState(() {
      _products.add(product);
    });
  }

  void _updateProduct(int index, Product updatedProduct) {
    setState(() {
      _products[index] = updatedProduct;
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });

    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Deleted!',
      text: 'Product has been successfully deleted.',
      confirmBtnColor: Colors.green,
    );
  }

  @override
  Widget build(BuildContext context) {
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => showSearchProductModal(context),
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(150, 50),
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
                  onPressed: () => showAddProductModal(context, _addProduct),
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(150, 50),
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
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ProductTable(
                products: _products,
                onDelete: _deleteProduct,
                onUpdate: _updateProduct,
              ),
            ),
          ),
          const Footer(),
        ],
      ),
    );
  }
}
