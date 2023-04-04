import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ColinaMenu.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final DefineColors primarySW = DefineColors();

  @override
  build(context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData(
        //primaryColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: primarySW.lightPrimaryColor,
          //accentColor: Colors.pink,
          backgroundColor: Colors.white,
          errorColor: Colors.red,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.kanitTextTheme(),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: primarySW.darkPrimaryColor,
          backgroundColor: const Color.fromARGB(255, 48, 48, 48),

        ),
        textTheme: GoogleFonts.kanitTextTheme().apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),

      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  @override
  build(context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: const Color.fromARGB(255, 33, 33, 33),
        title: const Text('Delivery'),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(15, 30, 20, 0),
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                    boxShadow:  const[
                      BoxShadow(
                        //color: Colors.grey.withOpacity(0.5),
                        spreadRadius:1,
                        blurRadius: 5,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ]
                ),
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
                              child: const Text('Colina',
                                  style: TextStyle(
                                    //color: Colors.white,
                                    fontSize: 20,
                                    //fontFamily: 'Kanit',
                                  ))),
                          Container(
                            alignment: FractionalOffset.bottomRight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).brightness == Brightness.dark
                                    ? Theme.of(context).colorScheme.primary
                                    : const Color.fromARGB(255, 241, 148, 58),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const ColinaMenu()));
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
                decoration:  BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                    boxShadow: const [
                      BoxShadow(
                        //color: Colors.grey.withOpacity(0.5),
                        spreadRadius:1,
                        blurRadius: 5,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ]
                ),
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
                              child: const Text('Memo',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ))),
                          Container(
                            alignment: FractionalOffset.bottomRight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).brightness == Brightness.dark
                                    ? Theme.of(context).colorScheme.primary
                                    : const Color.fromARGB(255, 241, 148, 58),
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
      ),
    );
  }
}

class DefineColors {
  MaterialColor lightPrimaryColor =  const MaterialColor(
    0xFF18A640,
    <int, Color>{
      50: Color(0xFFF2F9F2),
      100: Color(0xFFDBF1DB),
      200: Color(0xFFB8E8B8),
      300: Color(0xFF94DF94),
      400: Color(0xFF76D876),
      500: Color(0xFF58CF58),
      600: Color(0xFF50C950),
      700: Color(0xFF46C146),
      800: Color(0xFF3CB83C),
      900: Color(0xFF2B9C2B),
    },
  );

  MaterialColor darkPrimaryColor = const MaterialColor(0xFF212121, {
    50: Color(0xFFECEFF1),
    100: Color(0xFFCFD8DC),
    200: Color(0xFFB0BEC5),
    300: Color(0xFF90A4AE),
    400: Color(0xFF78909C),
    500: Color(0xFF607D8B),
    600: Color(0xFF546E7A),
    700: Color(0xFF455A64),
    800: Color(0xFF37474F),
    900: Color(0xFF263238),
    },
  );
}
//backgroundColor: Color.fromARGB(255, 47, 47, 47),
//backgroundColor: const Color.fromARGB(255, 33, 33, 33),