import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timbu_design_app/product_provider/provider.dart';
import 'package:timbu_design_app/screens/storepage.dart';

import 'product_provider/cart_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timbu Design App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const StorePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
//           scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47)),


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// // import 'package:timbu_design_app/models/product.dart';
// import 'package:timbu_design_app/screens/storepage.dart';

// import 'controller/provider.dart';
// import 'service/timbu_api_service.dart';

// void main() {
//   final apiService = ApiService();
//   runApp(
//     MyApp(),
//   );
// }

// // ignore: use_key_in_widget_constructors
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => ProductProvider(),
//       builder: (context, child) {
//         return const MaterialApp(
//           debugShowCheckedModeBanner: false,
//           home: StorePage(),
//         );
//       },
      
//     );
//   }
// }
