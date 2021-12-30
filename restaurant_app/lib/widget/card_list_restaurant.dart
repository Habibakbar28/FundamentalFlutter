import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/ui/restaurantdetail_page.dart';

class CardListRestaurant extends StatelessWidget{
  final Restaurant restaurant;
  const CardListRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image.network(
          restaurant.getImageId(),
          width: 100,
        ),
      ),
      title: Text(restaurant.name),
      subtitle: Text('rating  ' + restaurant.rating.toString()),
      onTap: () => {
      Navigator.pushNamed(context, RestaurantDetailPage.routeName,
      arguments: restaurant)
      },
    );
  }
}