import 'package:flutter/material.dart';
import 'package:in_app_localisation/app_translations_delegate.dart';
import 'package:in_app_localisation/application.dart';
import 'package:in_app_localisation/language_selector_icon_button.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_translations.dart';

void main() {
  runApp(LocalisedApp());
}

class LocalisedApp extends StatefulWidget {
  @override
  LocalisedAppState createState() {
    return new LocalisedAppState();
  }
}

class LocalisedAppState extends State<LocalisedApp> {
  AppTranslationsDelegate _newLocaleDelegate;
  AppTranslations appTranslations;

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
    application.onLocaleChanged(Locale(languagesMap['Malay']));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            LanguageSelectorIconButton(),
          ],
          title: Text("Localised App"),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Text(appTranslations != null ? appTranslations.text("tab_home"):"NA"),
                Text(appTranslations != null ? appTranslations.text("tab_profile"):"NA"),
              ],
            ),
          ),
        ),
      ),
      localizationsDelegates: [
        _newLocaleDelegate,
        //provides localised strings
        GlobalMaterialLocalizations.delegate,
        //provides RTL support
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("en", ""),
        const Locale("es", ""),
        const Locale("ms", ""),
      ],
    );
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
      _newLocaleDelegate.load(locale).then((val){
        appTranslations = val;
        print(appTranslations.text("title_select_language"));
      });
    });
  }
}
