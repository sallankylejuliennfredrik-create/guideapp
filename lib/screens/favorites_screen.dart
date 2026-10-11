
import 'package:flutter/material.dart';

import '../data/heritage_data.dart';
import '../widgets/heritage_card.dart';

const Color _forest = Color(0xFF214C3A);
const Color _forestDark = Color(0xFF163729);
const Color _cream = Color(0xFFF7F5EF);
const Color _gold = Color(0xFFE8B968);
const Color _muted = Color(0xFF777D75);
const Color _border = Color(0xFFE7E4DB);

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() =>
      _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final favorites = heritageSites
        .where((site) => site.isFavorite)
        .toList();

    return Scaffold(
      backgroundColor: _cream,
      body: SafeArea(
        child: Column(
          children: [
            // Custom navigation header
            Padding(
              padding: const EdgeInsets.fromLTRB(
                16, 12, 20, 8,
              ),
              child: Row(
                children: [
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () => Navigator.maybePop(context),
                      child: const SizedBox(
                        height: 45,
                        width: 45,
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: _forestDark,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Collection',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                            color: _forestDark,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'PANGASINAN HERITAGE GUIDE',
                          style: TextStyle(
                            color: _muted,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8E8E4),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.favorite_rounded,
                      color: Color(0xFFC94F48),
                      size: 23,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: favorites.isEmpty
                  ? const _EmptyFavorites()
                  : CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        // Collection overview
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                              20, 20, 20, 22,
                            ),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(23),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    _forest,
                                    _forestDark,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius:
                                    BorderRadius.circular(25),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    right: -15,
                                    top: -18,
                                    child: Icon(
                                      Icons.bookmark_rounded,
                                      size: 125,
                                      color: Colors.white
                                          .withValues(alpha: 0.06),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 11,
                                          vertical: 7,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _gold,
                                          borderRadius:
                                              BorderRadius.circular(9),
                                        ),
                                        child: const Row(
                                          mainAxisSize:
                                              MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons
                                                  .favorite_rounded,
                                              size: 13,
                                              color: _forestDark,
                                            ),
                                            SizedBox(width: 6),
                                            Text(
                                              'SAVED DESTINATIONS',
                                              style: TextStyle(
                                                color: _forestDark,
                                                fontSize: 9,
                                                fontWeight:
                                                    FontWeight.w900,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        '${favorites.length}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 43,
                                          height: 1,
                                          fontWeight:
                                              FontWeight.w900,
                                          letterSpacing: -1,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        favorites.length == 1
                                            ? 'One special place saved for later.'
                                            : 'Special places worth visiting '
                                                'and remembering.',
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12,
                                          height: 1.6,
                                        ),
                                      ),
                                      const SizedBox(height: 18),
                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.explore_rounded,
                                            size: 15,
                                            color: _gold,
                                          ),
                                          SizedBox(width: 7),
                                          Text(
                                            'Your next adventure starts here',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11,
                                              fontWeight:
                                                  FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // List heading
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                              20, 0, 20, 15,
                            ),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    'Places you love',
                                    style: TextStyle(
                                      color: _forestDark,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(
                                    horizontal: 11,
                                    vertical: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE6EDE5),
                                    borderRadius:
                                        BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '${favorites.length} SAVED',
                                    style: const TextStyle(
                                      color: _forest,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.7,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Favorite heritage cards
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(
                            16, 0, 16, 24,
                          ),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final site = favorites[index];

                                return Padding(
                                  padding:
                                      const EdgeInsets.only(
                                    bottom: 14,
                                  ),
                                  child: HeritageCard(
                                    site: site,
                                    onFavorite: () {
                                      setState(() {
                                        site.isFavorite = false;
                                      });
                                    },
                                  ),
                                );
                              },
                              childCount: favorites.length,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Decorative heart illustration
            Container(
              height: 125,
              width: 125,
              decoration: BoxDecoration(
                color: const Color(0xFFE8EFE7),
                borderRadius: BorderRadius.circular(38),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.favorite_rounded,
                    size: 70,
                    color: _forest.withValues(alpha: 0.12),
                  ),
                  const Icon(
                    Icons.favorite_border_rounded,
                    size: 54,
                    color: _forest,
                  ),
                  const Positioned(
                    top: 23,
                    right: 24,
                    child: Icon(
                      Icons.auto_awesome_rounded,
                      size: 19,
                      color: Color(0xFFD6A34F),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'Your story starts here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _forestDark,
                fontSize: 24,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.7,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'You haven’t saved any destinations yet. '
              'Discover the beautiful places of Pangasinan '
              'and keep your favorites close.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _muted,
                fontSize: 13,
                height: 1.8,
              ),
            ),
            const SizedBox(height: 26),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => Navigator.maybePop(context),
                icon: const Icon(
                  Icons.explore_rounded,
                  size: 19,
                ),
                label: const Text('Explore destinations'),
                style: FilledButton.styleFrom(
                  backgroundColor: _forest,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(0, 54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'SAVE THE PLACES THAT INSPIRE YOU',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _muted,
                fontSize: 9,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
