import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/firestore_provider.dart';
import '../widgets/category_widget.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Categories'),
      ),
      body: Consumer<FireStoreProvider>(
        builder: ((context, provider, child) => provider.categories == null
            ? CircularProgressIndicator()
            : Container(
                child: GridView.builder(
                  itemCount: provider.categories!.length,
                  itemBuilder: (context, i) =>
                      CategoryWidget(category: provider.categories![i]),
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
