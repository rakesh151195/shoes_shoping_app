import 'package:flutter/material.dart';
import 'package:shoesshopingapp/features/home/bloc/home_bloc.dart';
import 'package:shoesshopingapp/features/home/models/home_product_data_model.dart';
import 'package:shoesshopingapp/features/home/ui/detailscreen.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final ProductDetails productDetails;
  final HomeBloc homeBloc;
  const ProductTileWidget(
      {super.key,
      required this.productDataModel,
      required this.homeBloc,
      required this.productDetails});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsScreen(
                      cartBloc: homeBloc,
                      productDataModel: productDataModel,
                      productDetails: productDetails,
                    )))
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(productDataModel.imageUrl))),
            ),
            const SizedBox(height: 20),
            Text(productDataModel.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(productDataModel.description),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$${productDataModel.price}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          homeBloc.add(HomeProductCartButtonClickedEvent(
                              clickedProduct: productDataModel));
                        },
                        icon: const Icon(Icons.shopping_bag_outlined)),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
