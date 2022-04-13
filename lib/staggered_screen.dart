// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:yt_pkg_staggered_grid_view/global_enums.dart';

class StaggeredScreen extends StatelessWidget {
  final GridType selectedGrid;
  final String title;

  const StaggeredScreen({
    Key? key,
    required this.selectedGrid,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white,),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: getGrid(),
      ),
    );
  }

  Widget getGrid() {
    switch (selectedGrid) {
      case GridType.staggered: return getStaggeredGrid();
      case GridType.masonry: return getMasonryGrid();
      case GridType.quilted: return getQuiltedGrid();
      case GridType.woven: return getWovenGrid();
      case GridType.staired: return getStairedGrid();
      case GridType.aligned: return getAlignedGrid();
      default: return getStaggeredGrid();
    }
  }

  /// grid properties:
  ///   - Evenly divided in n columns
  ///   - Small number of items
  ///   - Not scrollable
  /// tile properties:
  ///   - Must occupy 1 to n columns
  /// placement: top-most & then left-most
  Widget getStaggeredGrid() {
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: Tile(index: 0),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: Tile(index: 1),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Tile(index: 2),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Tile(index: 3),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 4,
          mainAxisCellCount: 2,
          child: Tile(index: 4),
        ),
      ],
    );
  }

  /// Grid properties:
  ///   - Evenly divided in n columns
  /// Tile properties:
  ///   - Must occupy 1 column only
  /// placement: top-most & then left-most
  Widget getMasonryGrid() {
    return MasonryGridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      itemBuilder: (context, index) {
        return Tile(
          index: index,
          extent: (index % 5 + 1) * 100,
        );
      },
    );
  }

  /// Grid properties:
  ///   - Evenly divided in n columns
  ///   - height of each row is equal to the width of each column
  ///   - A pattern defines the size of the tiles & different mode of repetition are possible
  /// Tile properties:
  ///   - Must occupy 1 to n columns
  ///   - Must occupy 1 or more entire rows
  /// Placement algorithm: Top-most & then left-most
  Widget getQuiltedGrid() {
    return GridView.custom(
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: [
          QuiltedGridTile(2, 2),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 2),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
            (context, index) => Tile(index: index),
      ),
    );
  }

  /// items are displayed in containers of varying ratios to create a rhythmic layout
  /// Grid properties:
  ///   - Evenly divided in n columns
  ///   - The height the rows is the maximum height of the tiles
  ///   - A pattern defines the size of the tiles
  ///   - size of the tiles follows the pattern in a 'z' sequence.
  /// Tile properties:
  ///   - height is defined by an aspectRatio (width/height)
  ///   - width is defined by a crossAxisRatio (width/column's width) between 0 (exclusive) and 1 (inclusive)
  ///   - Each tile can define how it is aligned within the available space
  /// Placement algorithm: Top-most & then left-most
  Widget getWovenGrid() {
    return GridView.custom(
      gridDelegate: SliverWovenGridDelegate.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        pattern: [
          WovenGridTile(1),
          WovenGridTile(
            5 / 7,
            crossAxisRatio: 0.9,
            alignment: AlignmentDirectional.centerEnd,
          ),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
            (context, index) => Tile(index: index),
      ),
    );
  }

  /// Uses alternating container sizes and ratios to create a rhythmic effect.
  /// It's another kind of woven grid layout.
  /// Grid properties:
  ///   - A pattern defines the size of the tiles
  ///   - Each tile is shifted from the previous one by a margin in both axis
  ///   - The placement follows a 'z' sequence
  /// Tile properties:
  ///   - height: defined by aspectRatio (width/height)
  ///   - width: defined by crossAxisRatio (width/available horizontal space) between 0 (exclusive) and 1 (inclusive)
  /// Placement algorithm: 'z' sequence
  Widget getStairedGrid() {
    return GridView.custom(
      gridDelegate: SliverStairedGridDelegate(
        crossAxisSpacing: 48,
        mainAxisSpacing: 24,
        startCrossAxisDirectionReversed: true,
        pattern: [
          StairedGridTile(0.5, 1),
          StairedGridTile(0.5, 3 / 4),
          StairedGridTile(1.0, 10 / 4),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
            (context, index) => Tile(index: index),
      ),
    );
  }

  /// Also called CSS Grid, which is common grid layout on the web.
  /// Each item within a track has the maximum cross axis extent of its siblings.
  /// Grid properties:
  ///   - Evenly divided in n columns
  ///   - The rows can have different heights
  /// Tile properties:
  ///   - Must occupy 1 column only
  ///   - Each tile has the same height as the tallest one of the row.
  /// Placement algorithm: Top-most & then left-most
  Widget getAlignedGrid() {
    return AlignedGridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      itemBuilder: (context, index) {
        return Tile(
          index: index,
          extent: (index % 7 + 1) * 30,
        );
      },
    );
  }

}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
  }) : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      color: backgroundColor ?? Colors.redAccent,
      height: extent,
      child: Center(
        child: CircleAvatar(
          minRadius: 20,
          maxRadius: 20,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: Text('$index', style: const TextStyle(fontSize: 20)),
        ),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }
}