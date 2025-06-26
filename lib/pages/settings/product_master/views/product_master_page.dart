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

class ProductMasterPage extends StatefulWidget {
  const ProductMasterPage({super.key});

  @override
  State<ProductMasterPage> createState() => _ProductMasterPageState();
}

class _ProductMasterPageState extends State<ProductMasterPage> {
  final List<Map<String, String>> _products = [
    {
      'code': 'P001',
      'name': 'Crank Case',
      'specification': 'Heavy-duty steel',
      'internalCode': 'INT-001',
    },
    {
      'code': 'P002',
      'name': 'Crank Case 2',
      'specification': 'Rubber grip',
      'internalCode': 'INT-002',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'NXPERT EON'),
      drawer: SideNav(
        currentRoute:
            GoRouter.of(
              context,
            ).routerDelegate.currentConfiguration.uri.toString(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const HeaderBanner(subtitle: 'PRODUCT MASTER'),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                //? Search Modal Button
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
                  onPressed: () => showAddProductModal(context),
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
                onDelete: (index) {
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
                },
              ),
            ),
          ),
          const Footer(),
        ],
      ),
    );
  }
}
