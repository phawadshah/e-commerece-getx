// ignore_for_file: constant_identifier_names, unused_field

part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const INITIAL = _Paths.SPLASH;

  static const SPLASH = _Paths.SPLASH;
  static const BASE = _Paths.BASE;
  static const HOME = _Paths.HOME;
  static const CATEGORIES = _Paths.CATEGORIES;
  static const SEARCH = _Paths.SEARCH;
  static const PRODCUTS = _Paths.PRODCUTS;
  static const PRODUCTDETAILS = _Paths.PRODUCTDETAILS;
  static const CART = _Paths.CART;
  static const WISHLIST = _Paths.WISHLIST;
  static const SIGNUP = _Paths.SIGNUP;
  static const LOGIN = _Paths.LOGIN;
  static const PROFILE = _Paths.PROFILE;
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
  static const SIGNUP = '/sign-up';
  static const LOGIN = '/log-in';
  static const PROFILE = '/profile';
}
