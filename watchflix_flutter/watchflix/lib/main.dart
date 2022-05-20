import 'package:flutter/material.dart';
import 'package:watchflix/providers/entry.dart';
import 'package:watchflix/providers/watchlist.dart';
import 'package:watchflix/screens/navigation.dart';
import 'package:watchflix/screens/onboarding.dart';
import 'package:provider/provider.dart';

import 'providers/account.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AccountProvider()),
      ChangeNotifierProvider(create: (context) => EntryProvider()),
      ChangeNotifierProvider(create: (context) => WatchListProvider()),
    ],
    child: const Main(),
  ));
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'PkNetflix',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: FutureBuilder(
          future: context.read<AccountProvider>().isValid(),
          builder: (context, snapshot) =>
              context.watch<AccountProvider>().session == null
                  ? const OnboardingScreen()
                  : const NavScreen(),
        ));
  }
}
