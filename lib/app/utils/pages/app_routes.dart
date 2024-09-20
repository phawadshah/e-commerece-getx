// ignore_for_file: constant_identifier_names, unused_field

part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const INITIAL = Routes.SPLASH;

  static const SPLASH = _Paths.SPLASH;
  static const BASE = _Paths.BASE;
  static const HOME = _Paths.HOME;
  static const CATEGORIES = _Paths.CATEGORIES;
  static const SEARCH = _Paths.SEARCH;
  static const PRODCUTS = _Paths.PRODCUTS;
  static const PRODUCTDETAILS = _Paths.PRODUCTDETAILS;
  static const CART = _Paths.CART;
  static const WISHLIST = _Paths.WISHLIST;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/';
  static const BASE = '/base';
  static const HOME = '/home';
  static const CATEGORIES = '/categories';
  static const SEARCH = '/search';
  static const PRODCUTS = '/products';
  static const PRODUCTDETAILS = '/product-details';
  static const CART = '/cart';
  static const WISHLIST = '/wishlist';
}
