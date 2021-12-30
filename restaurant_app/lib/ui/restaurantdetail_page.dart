import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/data/model/restaurant_review.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_app/widget/card_review.dart';
import 'package:restaurant_app/widget/favourite_button_widget.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant,}) : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  void initState() {
    super.initState();
    print(widget.restaurant.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 75,
        elevation: 0.0,
        title: Text('RESTAURANTnesia'),
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
        actions: <Widget> [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: FavouriteButtonWidget(restaurant: widget.restaurant),
          ),
        ],
      ),
      body: ChangeNotifierProvider<RestaurantDetailProvider>(
          create: (_) => RestaurantDetailProvider(apiService: ApiService(), id: widget.restaurant.id),
        child: SingleChildScrollView(
          child: Consumer<RestaurantDetailProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.Loading) {
                return Center(
                    child: Column(
                      children: const [
                        SizedBox(height: 400,),
                        CircularProgressIndicator()
                      ],
                    )
                );
              } else {
                if (state.state == ResultState.HasData) {
                  final restaurant = state.detailRestaurant;
                  return Column(
                    children: [
                      Hero(
                          tag: ApiService.imgUrl + restaurant.pictureId,
                          child: Image.network(ApiService.imgUrl + restaurant.pictureId)
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restaurant.name,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            Divider(color: Colors.grey),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  size: 15.0,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 5.0),
                                Text(
                                  restaurant.city,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ],
                            ),
                            Divider(color: Colors.grey),
                            Text(
                              restaurant.description,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Divider(color: Colors.grey),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.stars,
                                  size: 15.0,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 5.0),
                                Text(
                                  restaurant.rating.toString(),
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                            Divider(color: Colors.grey),
                            Text(
                              'Daftar Makanan',
                              style: Theme.of(context).textTheme.headline6,),
                            Divider(color: Colors.grey),
                            Container(
                              height: 125,
                              margin: EdgeInsets.only(top: 10),
                              child: ListView(
                                  scrollDirection: Axis.vertical,
                                  children: restaurant.menus.foods.map((foods) {
                                    return Text(
                                      foods.name,
                                      style: Theme.of(context).textTheme.bodyText2,
                                    );
                                  }).toList()),
                            ),
                            Divider(color: Colors.grey),
                            Text(
                              'Daftar Minuman',
                              style: Theme.of(context).textTheme.headline6,),
                            Divider(color: Colors.grey),
                            Container(
                              height: 125,
                              margin: EdgeInsets.only(top: 10),
                              child: ListView(
                                  scrollDirection: Axis.vertical,
                                  children: restaurant.menus.drinks.map((drinks) {
                                    return Text(
                                      drinks.name,
                                      style: Theme.of(context).textTheme.bodyText2,
                                    );
                                  }).toList()),
                            ),
                            Divider(color: Colors.grey),
                            Text(
                              'Review',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Divider(color: Colors.grey),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: restaurant.customerReviews.length,
                                itemBuilder: (context, index) {
                                  final ReviewCostumer restaurantElement = ReviewCostumer(name: restaurant.customerReviews[index].name, review: restaurant.customerReviews[index].review, date: restaurant.customerReviews[index].date);
                                  return CardReviewRestaurant(review: restaurantElement);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (state.state == ResultState.Error) {
                  return Center(
                    child: Text('Gagal memuat data'),
                  );
                } else {
                  return Center(child: Text(''),);
                }
              }
            }
          )
        ),
      )
    );
  }
}