import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/presentation/journeys/home/movie_tabbed/movie_tab_card_widget.dart';

class MovieListViewBuilder extends StatelessWidget {
  final List<MovieEntity> movies;
  final ScrollController scrollController;

  const MovieListViewBuilder(
      {Key key, @required this.movies, @required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Sizes.dimen_6.h),
      child: ListView.separated(
        controller: scrollController,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final MovieEntity movie = movies[index];
          return MovieTabCardWidget(
            movieId: movie.id,
            title: movie.title,
            posterPath: movie.posterPath,
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            width: Sizes.dimen_14.w,
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
      ),
    );
  }
}
