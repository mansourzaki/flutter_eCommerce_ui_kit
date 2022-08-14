import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_ui_kit/models/category.dart';
import 'package:flutter_ecommerce_ui_kit/router.dart';
import 'package:flutter_ecommerce_ui_kit/screens/add_product_screen.dart';
import 'package:provider/provider.dart';
import '../providers/firestore_provider.dart';
import '../widgets/product_widget.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({Key? key,required this.category}) : super(key: key);
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () {
            AppRouter.NavigateToWidget(AddProductScreen(category: category));
          }, child: Icon(Icons.add)),
      body: Consumer<FireStoreProvider>(
        builder: ((context, provider, child) => provider.categories == null
            ? CircularProgressIndicator()
            : Container(
                child: GridView.builder(
                  itemCount: provider.products.length,
                  itemBuilder: (context, i) =>
                      PProcuctWidget(product: provider.products[i],category: category),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding:
                      EdgeInsets.only(top: 8, left: 6, right: 6, bottom: 12),
                ),
              )),
      ),
    );
  }
}
