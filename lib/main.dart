import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dynamic_localization/l10n/l10n.dart';
import 'package:flutter_dynamic_localization/locale_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(MyApp(title: 'Flutter Localizations'));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => LocaleProvider(),
      builder: (context, child) {
        final provider = Provider.of<LocaleProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: widget.title,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.green,
            primaryColor: Colors.greenAccent.shade400,
            appBarTheme: AppBarTheme(color: Colors.green),
          ),
          locale: provider.locale,
          supportedLocales: L10n.all,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home: HomePage(widget: widget),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final MyApp widget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.hello('Hades'),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  Provider.of<LocaleProvider>(context, listen: false)
                      .setLocale(Locale('en'));
                },
                child: Flag.fromCode(
                  FlagsCode.US,
                  height: 24,
                  width: 24,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Provider.of<LocaleProvider>(context, listen: false).setLocale(
                    Locale('vi'),
                  );
                },
                child: Flag.fromCode(
                  FlagsCode.VN,
                  height: 24,
                  width: 24,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Provider.of<LocaleProvider>(context, listen: false).setLocale(
                    Locale('es'),
                  );
                },
                child: Flag.fromCode(
                  FlagsCode.ES,
                  height: 24,
                  width: 24,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Provider.of<LocaleProvider>(context, listen: false).clearLocale();
            },
            child: Text('System'),
          ),
        ],
      ),
    );
  }
}
