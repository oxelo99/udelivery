import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  build(context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 47, 47, 47)),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 33, 33, 33),
          title: const Text('Delivery'),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(15, 30, 20, 0),
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
              color: const Color.fromARGB(255, 66, 66, 66),
              child: Column(
                children: <Widget>[
                  //b: const Color.fromARGB(255, 47, 47, 47),
                  Image.asset('assets/Colina.jpg'),
                  Container(
                    margin: const EdgeInsets.fromLTRB( 0, 5, 0, 0),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            padding: const EdgeInsets.all(10),
                            alignment: FractionalOffset.centerLeft,
                            child: const Text('Colina',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  //fontFamily: 'Kanit',
                                ))),
                        Container(
                          alignment: FractionalOffset.bottomRight,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 237, 145, 67)),
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
            Container(
              margin: const EdgeInsets.fromLTRB(15, 30, 20, 0),
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
              color: const Color.fromARGB(255, 66, 66, 66),
              child: Column(
                children: <Widget>[
                  //b: const Color.fromARGB(255, 47, 47, 47),
                  Image.asset('assets/Memo.jpg'),
                  Container(
                    margin: const EdgeInsets.fromLTRB( 0, 5, 0, 0),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            padding: const EdgeInsets.all(10),
                            alignment: FractionalOffset.centerLeft,
                            child: const Text('Memo',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  //fontFamily: 'Kanit',
                                ))),
                        Container(
                          alignment: FractionalOffset.bottomRight,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                const Color.fromARGB(255, 237, 145, 67)),
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
//backgroundColor: Color.fromARGB(255, 47, 47, 47),
//backgroundColor: const Color.fromARGB(255, 33, 33, 33),
