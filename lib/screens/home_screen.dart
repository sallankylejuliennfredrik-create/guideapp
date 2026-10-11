
import 'package:flutter/material.dart';

import '../data/heritage_data.dart';
import '../widgets/heritage_card.dart';
import 'favorites_screen.dart';

const Color _forest = Color(0xFF214C3A);
const Color _forestDark = Color(0xFF163729);
const Color _cream = Color(0xFFF7F5EF);
const Color _gold = Color(0xFFE8B968);
const Color _muted = Color(0xFF777D75);
const Color _border = Color(0xFFE7E4DB);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  String searchQuery = '';
  String selectedCategory = 'All';

  final List<String> categories = const [
    'All',
    'Natural',
    'Historical',
    'Religious',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  int _countForCategory(String category) {
    if (category == 'All') return heritageSites.length;

    return heritageSites
        .where((site) => site.category == category)
        .length;
  }

  void _clearFilters() {
    setState(() {
      searchQuery = '';
      selectedCategory = 'All';
      _searchController.clear();
    });
  }

  void _openFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const FavoritesScreen(),
      ),
    ).then((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final query = searchQuery.trim().toLowerCase();

    final filteredSites = heritageSites.where((site) {
      final matchesSearch = query.isEmpty ||
          site.name.toLowerCase().contains(query) ||
          site.category.toLowerCase().contains(query);

      final matchesCategory = selectedCategory == 'All' ||
          site.category == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();

    final favoritesCount =
        heritageSites.where((site) => site.isFavorite).length;

    final hasActiveFilters =
        query.isNotEmpty || selectedCategory != 'All';

    return Scaffold(
      backgroundColor: _cream,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top navigation
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 16, 8),
              child: Row(
                children: [
                  Container(
                    height: 46,
                    width: 46,
                    decoration: BoxDecoration(
                      color: _forest,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.explore_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PANGASINAN',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.1,
                            color: _forestDark,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'HERITAGE & TRAVEL GUIDE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.3,
                            color: _muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: _openFavorites,
                      child: SizedBox(
                        height: 46,
                        width: 46,
                        child: Center(
                          child: Badge(
                            isLabelVisible: favoritesCount > 0,
                            label: Text('$favoritesCount'),
                            backgroundColor: const Color(0xFFC94F48),
                            child: const Icon(
                              Icons.favorite_border_rounded,
                              color: _forestDark,
                              size: 23,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: CustomScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                slivers: [
                  // Hero section
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        16, 12, 16, 22,
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [_forest, _forestDark],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: _forest.withValues(alpha: 0.15),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              right: -22,
                              top: -20,
                              child: Icon(
                                Icons.account_balance_rounded,
                                size: 155,
                                color: Colors.white.withValues(
                                  alpha: 0.055,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 11,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(
                                      alpha: 0.12,
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(30),
                                    border: Border.all(
                                      color: Colors.white.withValues(
                                        alpha: 0.14,
                                      ),
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.waving_hand_rounded,
                                        color: _gold,
                                        size: 14,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        'DISCOVER THE EXTRAORDINARY',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 9,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 18),
                                const Text(
                                  'Every place has\na story to tell.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 29,
                                    height: 1.15,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.7,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Explore the natural wonders, historic '
                                  'landmarks, and sacred places of '
                                  'Pangasinan.',
                                  style: TextStyle(
                                    color: Colors.white.withValues(
                                      alpha: 0.77,
                                    ),
                                    fontSize: 12,
                                    height: 1.6,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_rounded,
                                      size: 15,
                                      color: _gold,
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      'Pangasinan, Philippines',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 11,
                                        vertical: 7,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _gold,
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        '${heritageSites.length} PLACES',
                                        style: const TextStyle(
                                          color: _forestDark,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 0.5,
                                        ),
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

                  // Search field
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(17),
                          border: Border.all(color: _border),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(
                                alpha: 0.025,
                              ),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          textInputAction: TextInputAction.search,
                          onChanged: (value) {
                            setState(() => searchQuery = value);
                          },
                          decoration: InputDecoration(
                            hintText: 'Find a place or category...',
                            hintStyle: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF999D96),
                            ),
                            prefixIcon: const Icon(
                              Icons.search_rounded,
                              color: _forest,
                              size: 23,
                            ),
                            suffixIcon: searchQuery.isNotEmpty
                                ? IconButton(
                                    tooltip: 'Clear search',
                                    onPressed: () {
                                      setState(() {
                                        searchQuery = '';
                                        _searchController.clear();
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.close_rounded,
                                      size: 20,
                                    ),
                                  )
                                : null,
                            filled: true,
                            fillColor: Colors.transparent,
                            contentPadding:
                                const EdgeInsets.symmetric(
                              vertical: 17,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                              borderSide: const BorderSide(
                                color: _forest,
                                width: 1.3,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Section heading
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        20, 25, 20, 12,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Explore heritage',
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w800,
                                    color: _forestDark,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  hasActiveFilters
                                      ? '${filteredSites.length} matching '
                                          'place${filteredSites.length == 1 ? '' : 's'}'
                                      : 'Find your next memorable destination',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: _muted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (hasActiveFilters)
                            TextButton(
                              onPressed: _clearFilters,
                              style: TextButton.styleFrom(
                                foregroundColor: _forest,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                              ),
                              child: const Text(
                                'Reset',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  // Category filters
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 43,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        itemCount: categories.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(width: 9),
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          final isSelected =
                              selectedCategory == category;
                          final count = _countForCategory(category);

                          return ChoiceChip(
                            selected: isSelected,
                            showCheckmark: false,
                            onSelected: (_) {
                              setState(() {
                                selectedCategory = category;
                              });
                            },
                            avatar: isSelected
                                ? const Icon(
                                    Icons.check_rounded,
                                    size: 15,
                                    color: Colors.white,
                                  )
                                : null,
                            label: Text('$category  $count'),
                            labelStyle: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : _forestDark,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                            backgroundColor: Colors.white,
                            selectedColor: _forest,
                            side: BorderSide(
                              color: isSelected ? _forest : _border,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(
                    child: SizedBox(height: 18),
                  ),

                  // Heritage cards and empty states
                  if (heritageSites.isEmpty)
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: _EmptyState(
                        icon: Icons.map_outlined,
                        title: 'Your journey starts here',
                        subtitle:
                            'New heritage destinations will appear here.',
                      ),
                    )
                  else if (filteredSites.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: _EmptyState(
                        icon: Icons.travel_explore_rounded,
                        title: 'No places found',
                        subtitle: query.isNotEmpty
                            ? 'We couldn’t find anything matching '
                                '"$searchQuery". Try another keyword.'
                            : 'There are no places in this category yet.',
                        actionLabel: 'Clear filters',
                        onAction: _clearFilters,
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(
                        16, 0, 16, 28,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final site = filteredSites[index];

                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: 14,
                              ),
                              child: HeritageCard(
                                site: site,
                                onFavorite: () {
                                  setState(() {
                                    site.isFavorite =
                                        !site.isFavorite;
                                  });
                                },
                              ),
                            );
                          },
                          childCount: filteredSites.length,
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

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  const _EmptyState({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 86,
              width: 86,
              decoration: BoxDecoration(
                color: const Color(0xFFE6EDE5),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Icon(
                icon,
                size: 38,
                color: _forest,
              ),
            ),
            const SizedBox(height: 22),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w800,
                color: _forestDark,
              ),
            ),
            const SizedBox(height: 9),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                height: 1.6,
                color: _muted,
              ),
            ),
            if (actionLabel != null) ...[
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: Text(actionLabel!),
                style: FilledButton.styleFrom(
                  backgroundColor: _forest,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 13,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
