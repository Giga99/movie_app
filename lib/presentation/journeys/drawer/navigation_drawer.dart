import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/languages.dart';
import 'package:movie_app/common/constants/route_constants.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/constants/translation_constants.dart';
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/common/extensions/string_extensions.dart';
import 'package:movie_app/presentation/blocs/language/language_bloc.dart';
import 'package:movie_app/presentation/journeys/drawer/navigation_expanded_list_tile.dart';
import 'package:movie_app/presentation/journeys/drawer/navigation_list_item.dart';
import 'package:movie_app/presentation/widgets/app_dialog.dart';
import 'package:movie_app/presentation/widgets/logo.dart';
import 'package:wiredash/wiredash.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            blurRadius: 4,
          ),
        ],
      ),
      width: Sizes.dimen_300.w,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: Sizes.dimen_8.h,
                bottom: Sizes.dimen_18.h,
                left: Sizes.dimen_8.w,
                right: Sizes.dimen_8.w,
              ),
              child: Logo(height: Sizes.dimen_20.h),
            ),
            NavigationListItem(
              title: TranslationConstants.favoriteMovies.t(context),
              onPressed: () {
                Navigator.of(context).pushNamed(RouteList.favorite);
              },
            ),
            NavigationExpandedListItem(
              title: TranslationConstants.language.t(context),
              children: Languages.languages.map((e) => e.value).toList(),
              onPressed: (index) {
                BlocProvider.of<LanguageBloc>(context).add(
                  ToggleLanguageEvent(
                    Languages.languages[index],
                  ),
                );
              },
            ),
            NavigationListItem(
              title: TranslationConstants.feedback.t(context),
              onPressed: () {
                Navigator.of(context).pop();
                Wiredash.of(context).show();
              },
            ),
            NavigationListItem(
              title: TranslationConstants.about.t(context),
              onPressed: () {
                Navigator.of(context).pop();
                _showDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AppDialog(
        title: TranslationConstants.about,
        description: TranslationConstants.aboutDescription,
        buttonText: TranslationConstants.okay,
        child: Image.asset(
          'assets/pngs/tmdb_logo.png',
          height: Sizes.dimen_32.h,
        ),
      ),
    );
  }
}
