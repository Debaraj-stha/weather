import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  TextEditingController controller = new TextEditingController();
  FocusNode focusNode = new FocusNode();
  void handleSearch() {
    debugPrint("Searching");
     Provider.of<provider>(context, listen: false).fetchApiData(controller.text);
  }

  @override
  void initState() {
    // TODO: implement initState
    final p =
        Provider.of<provider>(context, listen: false).fetchApiData("Dharan");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Container(
                child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              onFieldSubmitted: (val) {
                handleSearch();
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter location here...",
                  suffix: Icon(
                    Icons.search,
                    color: Colors.black26,
                  )),
            ))),
        body: Consumer<provider>(
          builder: (context, value, child) {
            if (value.data.length == 0) {
              debugPrint("data" + value.data.toString());
              return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "asset/43289.jpg",
                        ),
                        fit: BoxFit.cover)),
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              debugPrint("data${value.data.toString()}");
              final res = value.data[0];
              return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: value.data[0].current.condition.text
                                .contains("cloud")
                            ? AssetImage(
                                "asset/43289.jpg",
                              )
                            : AssetImage(
                                "asset/sunshine.jpg",
                              ),
                        fit: BoxFit.cover)),
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textBulder(res.location.name,
                              color: Colors.white, weight: FontWeight.w600),
                          SizedBox(
                            width: 5.0,
                          ),
                          textBulder(",", size: 20.0),
                          textBulder(res.location.country,
                              color: Colors.white, weight: FontWeight.w600),
                        ],
                      ),
                    ),
                    Center(child: textBulder("Last Updated:${res.current.lastUpdated}",size: 18.0,weight: FontWeight.w500),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textBulder("Feels like:${res.current.feelslikeC}"),
                        Image(
                            image: NetworkImage(
                                "https:" + res.current.condition.icon))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:9.0),
                      child: Center(child:textBulder(res.current.condition.text,size: 20.0,weight: FontWeight.w600) ,),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textBulder(res.current.feelslikeC.toString(),
                              size: 25.0,
                              weight: FontWeight.w700,
                              color: Colors.white),
                          textBulder("C",
                              size: 25.0,
                              weight: FontWeight.w700,
                              color: Colors.white)
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ));
  }

  Widget textBulder(String text,
      {color = Colors.white, weight = FontWeight.normal, size = 16.0}) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size, fontWeight: weight),
    );
  }
}
