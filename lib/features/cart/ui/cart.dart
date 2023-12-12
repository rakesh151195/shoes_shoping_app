import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesshopingapp/features/cart/bloc/cart_bloc.dart';
import 'package:shoesshopingapp/features/cart/ui/cart_tile_widget.dart';
import 'package:shoesshopingapp/features/payment/paymentprocess.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Items'),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listener: (context, state) {},
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              final successState = state as CartSuccessState;
              double? totalPrice;

              if (successState.cartItems.isNotEmpty) {
                totalPrice = successState.cartItems
                    .map((item) => item.price)
                    .reduce((value, element) => value + element);
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: successState.cartItems.length,
                      itemBuilder: (context, index) {
                        var item = successState.cartItems[index];
                        return Column(
                          children: [
                            CartTileWidget(
                              cartBloc: cartBloc,
                              productDataModel: item,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  if (successState.cartItems.isNotEmpty)
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Payment()));
                              },
                              child: Text(
                                  'Total Price: \$${totalPrice?.toStringAsFixed(2)}'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (successState.cartItems.isEmpty)
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(16.0),
                        child: const Text('Your cart is empty.',
                            style: TextStyle(
                              color: Colors.black,
                            )),
                      ),
                    ),
                ],
              );

            default:
          }
          return Container();
        },
      ),
    );
  }
}
