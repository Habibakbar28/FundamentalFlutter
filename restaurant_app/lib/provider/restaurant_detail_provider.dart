import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';



enum ResultState { Loading, NoData, HasData, Error }

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  Restaurant? _detailRestaurant;
  String? _message;
  ResultState? _state;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _getDetailRestaurant(id);
  }

  Restaurant get detailRestaurant => _detailRestaurant!;
  String get message => _message!;
  ResultState get state => _state!;

  Future<dynamic> _getDetailRestaurant(String restaurantId) async{
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final detailRestaurantResponse = await apiService.detailRestaurant(restaurantId);
      _state = ResultState.HasData;
      notifyListeners();
      return _detailRestaurant = detailRestaurantResponse.restaurant;
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Oops.. Somethings wrong..\nError: $e';
    }
  }
}