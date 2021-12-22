import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:untitled9/prodict/apiprodact.dart';
import 'Login.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  getposts() async {
    List<products> posts = [];
    var url = Uri.parse('https://retail.amit-learning.com/api/products');
    var resp = await http.get(url);
    var respbody = jsonDecode(resp.body)["products"];
    print(respbody);
    for (var i in respbody) {

      posts.add(products(i["avatar"], i["name"]));
    }
    return posts;
  }
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 240, 249, 1),
      appBar: AppBar(title: Text("home screen",textAlign: TextAlign.center, ),
        centerTitle: true,
        actions: [Icon(Icons.add_shopping_cart)],
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>Login()));
          },
        ),



      ),
      body: ListView (
        children: [

          CarouselSlider(

              items:[
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage("https://thumbor.forbes.com/thumbor/fit-in/1200x0/filters%3Aformat%28jpg%29/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F5d95d03767dd830006a295b6%2F0x0.jpg"),
                        fit: BoxFit.cover,
                      )
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlwJAfe4rFq-4KU2ZyoRx4AjZaRJJuMgG_Ywa8IULTZmkqX37kMJBh1jiIXTwXKExOQFs&usqp=CAU"),
                        fit: BoxFit.cover,
                      )
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage("https://m.economictimes.com/thumb/msid-87033842,width-1200,height-900,resizemode-4,imgsize-574369/consumer-goods.jpg"),
                        fit: BoxFit.cover,
                      )
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage("https://www.imagar.com/wp-content/uploads/2020/07/Desarrollo-web-ecommerce-1.jpg"),
                        fit: BoxFit.cover,
                      )
                  ),
                ),
              ], options: CarouselOptions(
            height: 150,
            aspectRatio: 16/9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
          ),





          Container(
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder(
              future:getposts() ,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return GridView.builder(
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
                  itemCount: snapshot.data.length,

                  itemBuilder: (BuildContext context, int index) {
                    return GridTile(


                        child:
                    Image.network("${snapshot.data[index].avatar}"),
                        footer:Container(
                          padding:EdgeInsets.all(9.0),
                          alignment: Alignment.bottomCenter,
                          color:Colors.deepOrange.withOpacity(0.3),
                          child:Text("${snapshot.data[index].name}"),
                        )
                    );
                  },


                );

            },

            )
          ),



        ],
      ),




    );


  }
}
