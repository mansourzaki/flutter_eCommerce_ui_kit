import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/product.dart';

class Productdetails extends StatelessWidget {
  const Productdetails({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 220,
            width: double.infinity,
            child: CachedNetworkImage(imageUrl: product.image),
          ),
          Text('Description: ${product.description}'),
          SizedBox(
            height: 15,
          ),
          Text('Price: ${product.price}'),
        ],
      ),
    );
  }
}
