import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_ui_kit/models/category.dart';
import 'package:flutter_ecommerce_ui_kit/providers/auth_provider.dart';
import 'package:flutter_ecommerce_ui_kit/router.dart';
import 'package:flutter_ecommerce_ui_kit/screens/add_category.dart';
import 'package:flutter_ecommerce_ui_kit/screens/add_product_screen.dart';
import 'package:flutter_ecommerce_ui_kit/screens/all_products_screen.dart';
import 'package:provider/provider.dart';

import '../providers/firestore_provider.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () async {
            // AppRouter.NavigateToWidget(AddProductScreen(
            //   category: category,
            // ));
            context.read<FireStoreProvider>().getAllProductsFromCategory(category.id!);
            AppRouter.NavigateToWidget(AllProductsScreen(
              category: category,
            ));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: (MediaQuery.of(context).size.width / 2) - 70,
                width: double.infinity,
                child: Stack(children: [
                  Container(
                    width: double.infinity,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: category.imageUrl,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.black54,
                          child: IconButton(
                              icon: Icon(
                                Icons.delete,
                                size: 15,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                context
                                    .read<FireStoreProvider>()
                                    .deletCategory(category);
                              }),
                        ),
                      )),
                ]),
              ),
              ListTile(
                title: Text(
                  category.name,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    AppRouter.NavigateToWidget(AddCategory(
                      isEditing: true,
                      category: category,
                    ));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
