import 'package:bill_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:bill_app/screens/landing_screen.dart';
import 'package:provider/provider.dart';
import 'package:bill_app/providers/product_provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'api/UserSheetApi.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  var directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init('${directory.path}');

  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<Product>('products');
  await Hive.openBox<Transaction>('transactions');
  UserSheetApi.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductProvider>(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
          fontFamily: 'Sans',
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
          /* dark theme settings */
        ),
        home: LandingScreen(),
      ),
    );
  }
}
