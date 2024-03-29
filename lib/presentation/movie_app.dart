import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_app/common/constants/languages.dart';
import 'package:movie_app/common/constants/route_constants.dart';
import 'package:movie_app/common/screenutil/screenutil.dart';
import 'package:movie_app/di/get_it.dart';
import 'package:movie_app/presentation/blocs/language/language_bloc.dart';
import 'package:movie_app/presentation/fade_page_route_builder.dart';
import 'package:movie_app/presentation/routes.dart';
import 'package:movie_app/presentation/themes/app_color.dart';
import 'package:movie_app/presentation/themes/theme_text.dart';
import 'package:movie_app/presentation/wiredash_app.dart';

import 'app_localizations.dart';

class MovieApp extends StatefulWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();
  @override
  _MovieAppState createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  LanguageBloc _languageBloc;

  @override
  void initState() {
    super.initState();
    _languageBloc = getItInstance<LanguageBloc>();
    _languageBloc.add(LoadPreferredLanguageEvent());
  }

  @override
  void dispose() {
    _languageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return BlocProvider<LanguageBloc>.value(
      value: _languageBloc,
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          if (state is LanguageLoaded)
            return WiredashApp(
              languageCode: state.locale.languageCode,
              navigatorKey: widget._navigatorKey,
              child: MaterialApp(
                navigatorKey: widget._navigatorKey,
                debugShowCheckedModeBanner: false,
                title: 'Movie Trailers',
                theme: ThemeData(
                  unselectedWidgetColor: AppColor.royalBlue,
                  primaryColor: AppColor.vulcan,
                  accentColor: AppColor.royalBlue,
                  scaffoldBackgroundColor: AppColor.vulcan,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  textTheme: ThemeText.getTextTheme(),
                  appBarTheme: const AppBarTheme(elevation: 0),
                ),
                supportedLocales:
                    Languages.languages.map((e) => Locale(e.code)).toList(),
                locale: state.locale,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                builder: (context, child) {
                  return child;
                },
                initialRoute: RouteList.initial,
                onGenerateRoute: (RouteSettings settings) {
                  final route = Routes.getRoutes(settings);
                  final WidgetBuilder builder = route[settings.name];
                  return FadePageRouteBuilder(
                    builder: builder,
                    settings: settings,
                  );
                },
              ),
            );
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
