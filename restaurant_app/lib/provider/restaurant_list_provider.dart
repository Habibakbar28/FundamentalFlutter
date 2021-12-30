import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;
  Restaurants? _restaurantList;
  RestaurantSearch? _restaurantSearch;

  RestaurantListProvider({required this.apiService}) {
    buildRestaurant();
  }

  Restaurants get restaurant => _restaurantList!;
  RestaurantSearch get restaurantSearch => _restaurantSearch!;
  String _message = '';
  String get message => _message;
  ResultState? _state;
  ResultState get state => _state!;

  void buildRestaurant() {
    _getList();
  }

  void buildSearchRestaurant(String query) {
    _getList(query: query);
  }

  void _getList({String? query}) {
    Future<dynamic> list;
    if (query == null) {
      list = _listRestaurant();
    } else {
      list = _searchRestaurant(query);
    }

    list.then(
          (value) {
        if (query == null) {
          _restaurantList= value;
        } else {
          _restaurantSearch = value;
        }
      },
    );
  }

  Future<dynamic> _listRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final listRestaurant = await apiService.listRestaurant();
      if (listRestaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantList = listRestaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Pastikan Ponsel anda terhubung dengan internet';
    }
  }

  Future<dynamic> _searchRestaurant(String query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurantSearch = await apiService.restaurantSearch(query);
      if (restaurantSearch.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Hasil Pencarian Tidak ditemukan';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantSearch = restaurantSearch;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Ketik nama restaurant yang dicari';
    }
  }
}