import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shoesshopingapp/data/cart_items.dart';
import 'package:shoesshopingapp/data/grocery_data.dart';
import 'package:shoesshopingapp/data/wishlist_items.dart';
import 'package:shoesshopingapp/features/home/models/home_product_data_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    // on<HomeProductWishlistButtonClickedEvent>(
    //     homeProductWishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(HomeLoadedSuccessState(
      products: GroceryData.groceryProducts.map((e) {
        return ProductDataModel(
          id: e['id'],
          name: e['name'],
          description: e['description'],
          price: e['price'],
          imageUrl: e['imageUrl'],
          details: ProductDetails(
            materialType: e['details']['materialType'],
            closureType: e['details']['closureType'],
            heelType: e['details']['heelType'],
            waterResistanceLevel: e['details']['waterResistanceLevel'],
            soleMaterial: e['details']['soleMaterial'],
            style: e['details']['style'],
            countryOfOrigin: e['details']['countryOfOrigin'],
          ),
        );
      }).toList(),
    ));
  }

  // FutureOr<void> homeProductWishlistButtonClickedEvent(
  //     HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
  //   print('Wishlist Product Clicked');
  //   wishlistItems.add(event.clickedProduct);
  //   emit(HomeProductItemWishlistedActionState());
  // }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Cart Product clicked');
    cartItems.add(event.clickedProduct);
    emit(HomeProductItemCartedActionState());
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Wishlist Navigate clicked');
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Cart Navigate clicked');
    emit(HomeNavigateToCartPageActionState());
  }
}
