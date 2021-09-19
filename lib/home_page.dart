import 'package:flutter/material.dart';
import 'package:projetbadr/trend_screen.dart';

import 'aceeuil_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 0;
  final List<Widget> screens = [AcceuilScreen(), TrendScreen()];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = AcceuilScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageStorage(bucket: bucket, child: currentScreen),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.indigoAccent, Colors.lightBlue])),
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = AcceuilScreen();
                        currentTab = 0;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.home_sharp,
                          color: currentTab == 0 ? Colors.white : Colors.black,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Acceuil',
                          style: TextStyle(
                              color: currentTab == 0
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = TrendScreen();
                        currentTab = 1;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_border_outlined,
                          size: 22,
                          color: currentTab == 1 ? Colors.white : Colors.black,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Favoris',
                          style: TextStyle(
                              color: currentTab == 1
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        SizedBox(
                          width: 30,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
