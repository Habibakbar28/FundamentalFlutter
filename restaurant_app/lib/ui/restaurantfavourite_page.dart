import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/widget/card_list_restaurant.dart';

class RestaurantFavouritePage extends StatelessWidget {
  const RestaurantFavouritePage({Key? key}) : super(key: key);

  static const routeName = '/restaurantfavourite_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 75,
        elevation: 0.0,
        title: Text('Favorite Restaurant'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.yellow, Colors.white],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight
              )
          ),
        ),
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: value.restaurants.length,
            itemBuilder: (context, index) {
              return CardListRestaurant(restaurant: value.restaurants[index],);
            },
          );
        },
      ),
    );
  }
}
