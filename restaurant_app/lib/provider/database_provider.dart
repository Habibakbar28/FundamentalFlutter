import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/utils/database_helper.dart';
import 'package:restaurant_app/utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getRestaurants();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _restaurants = [];
  List<Restaurant> get restaurants => _restaurants;

  void _getRestaurants() async {
    _restaurants = await databaseHelper.getRestaurants();
    if (_restaurants.length > 0) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addRestaurants(Restaurant restaurant) async {
    try {
      await databaseHelper.insertRestaurant(restaurant);
      _getRestaurants();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavourite(String id) async {
    final bookmarkedArticle = await databaseHelper.getRestaurantsById(id);
    return bookmarkedArticle.isNotEmpty;
  }

  void removeRestaurant(String id) async {
    try {
      await databaseHelper.removeRestaurant(id);
      _getRestaurants();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }



}