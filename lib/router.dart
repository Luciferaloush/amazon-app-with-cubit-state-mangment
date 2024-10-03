import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/features/address/screen/address_screen.dart';
import 'package:amazon_clone/features/admin/screens/add_product.dart';
import 'package:amazon_clone/features/admin/screens/admin_screen.dart';
import 'package:amazon_clone/features/auth/screen/user_profile_page.dart';
import 'package:amazon_clone/features/order_details/screen/order_screen.dart';
import 'package:amazon_clone/features/product_details/screen/product_details.dart';
import 'package:amazon_clone/features/screens/category_screen.dart';
import 'package:amazon_clone/features/screens/home_screen.dart';
import 'package:amazon_clone/features/search/screen/search_screen.dart';
import 'package:amazon_clone/model/cart.dart';
import 'package:amazon_clone/model/product.dart';

import './utils/error_screen/not_exist.dart';
import 'package:flutter/material.dart';
import 'features/auth/screen/auth_screen.dart';
import 'model/order.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());
    case ScreenDoesNotExist.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());

    case UserProfilePage.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const UserProfilePage());
    case BottomNavBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BottomNavBar());
    case AdminScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => AdminScreen());
    case AddProduct.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddProduct());
    case CategoryScreen.routeName:
      var category = routeSettings.arguments as String?;
      if (category == null) {
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const ScreenDoesNotExist());
      }
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryScreen(
                category: category,
              ));

    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String?;
      if (searchQuery == null) {
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const ScreenDoesNotExist());
      }
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SearchScreen(
                searchQuery: searchQuery,
              ));
    case ProductDetailsScreen.routeName:
      var product = routeSettings.arguments as Product?;
      if (product == null) {
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const ScreenDoesNotExist());
      }
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductDetailsScreen(
                product: product,
              ));

    case AddressScreen.routeName:
      final args = routeSettings.arguments as Map<String, dynamic>;
      final totalPrice = args['totalPrice'] as String;
      final cart = args['cart'] as List<Cart>;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => AddressScreen(
                totalPrice: totalPrice,
                cart: cart,
              ));
    case OrderScreen.routeName:
      var order = routeSettings.arguments as Order?;
      if (order == null) {
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const ScreenDoesNotExist());
      }
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => OrderScreen(
                order: order,
              ));

    default:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const ScreenDoesNotExist());
  }
}
