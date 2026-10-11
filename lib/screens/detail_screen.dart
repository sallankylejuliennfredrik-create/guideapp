
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/heritage_site.dart';

const Color _forest = Color(0xFF214C3A);
const Color _forestDark = Color(0xFF163729);
const Color _cream = Color(0xFFF7F5EF);
const Color _gold = Color(0xFFE8B968);
const Color _muted = Color(0xFF777D75);
const Color _border = Color(0xFFE7E4DB);

class DetailScreen extends StatefulWidget {
  final HeritageSite site;
  final String? heroTag;

  const DetailScreen({
    super.key,
    required this.site,
    this.heroTag,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isFavorite = false;

  HeritageSite get site => widget.site;

  Future<void> _openMaps() async {
    final query = Uri.encodeComponent(site.location);
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$query',
    );

    try {
      if (!await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      )) {
        _showSnack('Could not open Maps.');
      }
    } catch (_) {
      _showSnack('Could not open Maps.');
    }
  }

  Future<void> _callContact() async {
    final uri = Uri.parse('tel:${site.contact}');

    try {
      if (!await launchUrl(uri)) {
        _showSnack('Could not start a call.');
      }
    } catch (_) {
      _showSnack('Could not start a call.');
    }
  }

  void _showSnack(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _cream,
      extendBody: true,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Immersive photo header
          SliverAppBar(
            expandedHeight: 370,
            pinned: true,
            stretch: true,
            backgroundColor: _forestDark,
            foregroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            leadingWidth: 64,
            leading: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: _CircleButton(
                icon: Icons.arrow_back_rounded,
                onTap: () => Navigator.maybePop(context),
              ),
            ),
            actions: [
              _CircleButton(
                icon: Icons.share_outlined,
                onTap: () => _showSnack(
                  'Sharing coming soon.',
                ),
              ),
              const SizedBox(width: 10),
              _CircleButton(
                icon: _isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                iconColor: _isFavorite
                    ? const Color(0xFFFF8C83)
                    : Colors.white,
                onTap: () {
                  setState(() {
                    _isFavorite = !_isFavorite;
                  });

                  _showSnack(
                    _isFavorite
                        ? 'Added to your saved places.'
                        : 'Removed from saved places.',
                  );
                },
              ),
              const SizedBox(width: 16),
            ],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: widget.heroTag ?? site.name,
                    child: Image.asset(
                      site.image,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: _forestDark,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.landscape_rounded,
                          color: Colors.white54,
                          size: 72,
                        ),
                      ),
                    ),
                  ),

                  // Image contrast overlay
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0x66000000),
                          Colors.transparent,
                          Color(0x22000000),
                          Color(0xE6000000),
                        ],
                        stops: [0, 0.28, 0.58, 1],
                      ),
                    ),
                  ),

                  // Photo caption
                  Positioned(
                    left: 24,
                    right: 24,
                    bottom: 35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: _gold,
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.explore_rounded,
                                size: 14,
                                color: _forestDark,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                site.category.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.2,
                                  color: _forestDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          site.name,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 31,
                            height: 1.12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.7,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 14,
                                color: Colors.black38,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              color: _gold,
                              size: 17,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                site.location,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Main content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 130),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Intro heading
                  const Text(
                    'DISCOVER THIS DESTINATION',
                    style: TextStyle(
                      color: _muted,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.6,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'A place worth remembering.',
                    style: TextStyle(
                      color: _forestDark,
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 22),

                  // Location card
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: _openMaps,
                      child: Container(
                        padding: const EdgeInsets.all(17),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: _border),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 49,
                              width: 49,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8EFE7),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Icon(
                                Icons.location_on_rounded,
                                color: _forest,
                                size: 25,
                              ),
                            ),
                            const SizedBox(width: 13),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'LOCATION',
                                    style: TextStyle(
                                      fontSize: 9,
                                      letterSpacing: 1.3,
                                      fontWeight: FontWeight.w800,
                                      color: _muted,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    site.location,
                                    style: const TextStyle(
                                      color: _forestDark,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                      height: 1.4,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    'Tap to explore on Google Maps',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: _muted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_outward_rounded,
                              size: 19,
                              color: _forest,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // About section
                  const _SectionHeader(
                    eyebrow: 'THE STORY',
                    title: 'About this place',
                    icon: Icons.auto_stories_rounded,
                  ),
                  const SizedBox(height: 14),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(19),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(19),
                      border: Border.all(color: _border),
                    ),
                    child: Text(
                      site.description.isNotEmpty
                          ? site.description
                          : 'No description is available yet. '
                              'Check back later for more information '
                              'about this destination.',
                      style: const TextStyle(
                        color: Color(0xFF525B52),
                        fontSize: 14,
                        height: 1.85,
                      ),
                    ),
                  ),

                  // Contact section
                  if (site.contact.isNotEmpty) ...[
                    const SizedBox(height: 30),
                    const _SectionHeader(
                      eyebrow: 'GET IN TOUCH',
                      title: 'Contact information',
                      icon: Icons.support_agent_rounded,
                    ),
                    const SizedBox(height: 14),
                    Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(19),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(19),
                        onTap: _callContact,
                        child: Container(
                          padding: const EdgeInsets.all(17),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(19),
                            border: Border.all(color: _border),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8EFE7),
                                  borderRadius:
                                      BorderRadius.circular(15),
                                ),
                                child: const Icon(
                                  Icons.call_rounded,
                                  color: _forest,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 13),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'CONTACT NUMBER',
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 1.2,
                                        color: _muted,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      site.contact,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: _forestDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_rounded,
                                color: _forest,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 30),

                  // Closing note
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(19),
                    decoration: BoxDecoration(
                      color: _forestDark,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.eco_rounded,
                          color: _gold,
                          size: 25,
                        ),
                        SizedBox(width: 13),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Travel with purpose.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Respect local traditions, preserve '
                                'heritage, and help keep every '
                                'destination beautiful.',
                                style: TextStyle(
                                  color: Colors.white70,
                                  height: 1.6,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Fixed bottom actions
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 13, 20, 12),
          decoration: BoxDecoration(
            color: _cream,
            border: const Border(
              top: BorderSide(color: _border),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 15,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _isFavorite = !_isFavorite;
                    });

                    _showSnack(
                      _isFavorite
                          ? 'Added to your saved places.'
                          : 'Removed from saved places.',
                    );
                  },
                  icon: Icon(
                    _isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    size: 19,
                  ),
                  label: Text(
                    _isFavorite ? 'Saved' : 'Save place',
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _forest,
                    side: const BorderSide(color: _border),
                    backgroundColor: Colors.white,
                    minimumSize: const Size(0, 53),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: FilledButton.icon(
                  onPressed: _openMaps,
                  icon: const Icon(
                    Icons.directions_rounded,
                    size: 20,
                  ),
                  label: const Text('Explore on Maps'),
                  style: FilledButton.styleFrom(
                    backgroundColor: _forest,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(0, 53),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;

  const _CircleButton({
    required this.icon,
    required this.onTap,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.35),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          height: 42,
          width: 42,
          child: Icon(
            icon,
            color: iconColor,
            size: 21,
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String eyebrow;
  final String title;
  final IconData icon;

  const _SectionHeader({
    required this.eyebrow,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 47,
          width: 47,
          decoration: BoxDecoration(
            color: const Color(0xFFE6EDE5),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(
            icon,
            color: _forest,
            size: 23,
          ),
        ),
        const SizedBox(width: 13),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eyebrow,
                style: const TextStyle(
                  color: _muted,
                  fontSize: 9,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  color: _forestDark,
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
