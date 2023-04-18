import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'colina_menu.dart';
import 'theme_data.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final Icon logout = const Icon(Icons.logout);

  @override
  build(context) {
    Color textColor() {
      if (MediaQuery.of(context).platformBrightness == Brightness.light) {
        return Colors.black;
      } else {
        return Colors.white;
      }
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: logout)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(15, 30, 20, 0),
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: const [
                    BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ]),
              child: Column(
                children: <Widget>[
                  Image.asset('assets/Colina.jpg'),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            padding: const EdgeInsets.all(10),
                            alignment: FractionalOffset.centerLeft,
                            child: Text('Colina',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: textColor(),
                                ))),
                        Container(
                          alignment: FractionalOffset.bottomRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).canvasColor,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ColinaMenu()));
                            },
                            child: const Text('Comanda'),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(15, 30, 20, 0),
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: const [
                    BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ]),
              child: Column(
                children: <Widget>[
                  //b: const Color.fromARGB(255, 47, 47, 47),
                  Image.asset('assets/Memo.jpg'),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            padding: const EdgeInsets.all(10),
                            alignment: FractionalOffset.centerLeft,
                            child: Text('Memo',
                                style: TextStyle(
                                  color: textColor(),
                                  fontSize: 20,
                                ))),
                        Container(
                          alignment: FractionalOffset.bottomRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).canvasColor,
                            ),
                            onPressed: () {},
                            child: const Text('Comanda'),
                            // color: Color.fromARGB(1, 1, 1, 1),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
