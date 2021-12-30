import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/ui/restaurantfavourite_page.dart';
import 'package:restaurant_app/widget/card_list_restaurant.dart';

class RestaurantListPage extends StatefulWidget {
  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  final TextEditingController _search = TextEditingController();
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          height: 787,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Row(
                            children: [
                              Text(
                                "RESTAURANTnesia",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Expanded(child: Container()),
                              // Icon(Icons.favorite, color: Colors.red,)
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, RestaurantFavouritePage.routeName),
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Colors.white.withOpacity(0.5),
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.black54,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Consumer<RestaurantListProvider>(
                        builder: (context, state, _) => Container(
                          width: 360.0,
                          padding: EdgeInsets.all(0.0),
                          child: TextField(
                            controller: _search,
                            autocorrect: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              hintText: "Cari restaurant disini",
                              hintStyle: TextStyle(color: Colors.black),
                              filled: true,
                              fillColor: Color(0xff3E3F55).withOpacity(0.1),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                borderSide: BorderSide(
                                    color: Color(0xff3E3F55).withOpacity(0.1),
                                    width: 0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                borderSide: BorderSide(
                                    color: Color(0xff3E3F55).withOpacity(0.1),
                                    width: 0),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _searchText = value;
                              });
                              state.buildSearchRestaurant(_searchText);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  height: 300,
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(top: 30, bottom: 0),
                  margin: EdgeInsets.only(top: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Colors.white,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                    height: 530,
                    child: _searchText.isEmpty
                        ? Consumer<RestaurantListProvider>(
                            builder: (context, state, _) {
                              if (state.state == ResultState.Loading) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (state.state == ResultState.HasData) {
                                final restaurant = state.restaurant;
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: restaurant.restaurants.length,
                                  itemBuilder: (context, index) {
                                    final restaurantElement =
                                        restaurant.restaurants[index];
                                    return CardListRestaurant(
                                        restaurant: restaurantElement);
                                  },
                                );
                              } else if (state.state == ResultState.NoData) {
                                return Center(child: Text(state.message));
                              } else if (state.state == ResultState.Error) {
                                return Center(child: Text(state.message));
                              } else {
                                return Center(child: Text('Kesalahan Sistem'));
                              }
                            },
                          )
                        : Consumer<RestaurantListProvider>(
                            builder: (context, state, _) {
                              if (state.state == ResultState.Loading) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                if (state.state == ResultState.HasData) {
                                  final searchRestaurant =
                                      state.restaurantSearch;
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        searchRestaurant.restaurants.length,
                                    itemBuilder: (context, index) {
                                      final restaurantElement =
                                          searchRestaurant.restaurants[index];
                                      return CardListRestaurant(
                                          restaurant: restaurantElement);
                                    },
                                  );
                                } else if (state.state == ResultState.NoData) {
                                  return Center(
                                      child:
                                          Text('Restaurant tidak ditemukan'));
                                } else {
                                  return Center(
                                    child:
                                        Text('Ups tidak ada koneksi internet'),
                                  );
                                }
                              }
                            },
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
