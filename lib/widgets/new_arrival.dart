
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/product.dart';

class NewArrival extends StatelessWidget {
  const NewArrival({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.0,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            // Todo
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 160,
                width: double.infinity,
                child: Hero(
                  tag: UniqueKey(),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: product.image,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  product.name,
                  style: TextStyle(fontSize: 14),
                ),
                subtitle: Text('\$${product.price}',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w700)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
