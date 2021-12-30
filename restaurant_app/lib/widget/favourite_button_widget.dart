import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/provider/database_provider.dart';

class FavouriteButtonWidget extends StatelessWidget {
  const FavouriteButtonWidget({Key? key, required this.restaurant})
      : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, value, child) {
        return FutureBuilder<bool>(
          future: value.isFavourite(restaurant.id),
          builder: (context, snapshot) {
            bool isFavourite = snapshot.data ?? false;
            return isFavourite
                ? InkWell(
                    child: Icon(Icons.favorite),
                    onTap: () {
                      value.removeRestaurant(restaurant.id);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${restaurant.name} berhasil dihapus dari Favourites')));
                    },
                  )
                : InkWell(
                    child: Icon(Icons.favorite_border),
                    onTap: () {
                      value.addRestaurants(restaurant);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${restaurant.name} berhasil ditambahkan ke Favourites')));
                      print(value.restaurants.length);
                    },
                  );
          },
        );
      },
    );
  }
}
