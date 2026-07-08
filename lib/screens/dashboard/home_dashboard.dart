import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/game_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/game_provider.dart';
import '../../widgets/game_card.dart';
import '../../widgets/welcome_card.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../game/game_screen.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  int _selectedNavIndex = 0;
  bool _showAllGames = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final gameProvider = Provider.of<GameProvider>(context);
    final user = authProvider.user;
    final userName = user?.name ?? 'Guest';
    final userRole = user?.role ?? 'guest';
    final stars = gameProvider.getTotalStars();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Column(
        children: [
          _buildAppBar(stars),
          _buildSearchBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  WelcomeCard(
                    userName: userName,
                    userRole: _getRoleLabel(userRole),
                    starCount: stars,
                  ),
                  const SizedBox(height: 16),
                  _buildGamesSection(gameProvider),
                  const SizedBox(height: 16),
                  _buildTutorialCard(),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          BottomNavBar(
            selectedIndex: _selectedNavIndex,
            onTap: (index) {
              setState(() => _selectedNavIndex = index);
            },
          ),
        ],
      ),
    );
  }

  String _getRoleLabel(String role) {
    switch (role) {
      case 'parent':
        return 'Parent 👨‍👧';
      case 'teacher':
        return 'Teacher 👨‍🏫';
      case 'student':
        return 'Student 🧒';
      default:
        return 'Guest 👤';
    }
  }

  Widget _buildAppBar(int stars) {
    return Container(
      color: const Color(0xFF4CAF50),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            const Row(
              children: [
                Text('⭐', style: TextStyle(fontSize: 20, color: Colors.white)),
                SizedBox(width: 6),
                Text('KidLearn', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Text('⭐', style: TextStyle(fontSize: 14, color: Colors.white)),
                      const SizedBox(width: 4),
                      Text('$stars', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                _buildIconButton(Icons.emoji_events, () {}),
                _buildIconButton(Icons.settings, () {}),
                _buildIconButton(Icons.logout, () async {
                  await authLogout();
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> authLogout() async {
    await Provider.of<AuthProvider>(context, listen: false).logout();
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Widget _buildIconButton(IconData icon, VoidCallback onTap) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, color: Colors.white, size: 20),
        onPressed: onTap,
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: const TextField(
          decoration: InputDecoration(
            hintText: 'Search games...',
            hintStyle: TextStyle(color: Color(0xFF999999), fontSize: 14),
            prefixIcon: Icon(Icons.search, color: Color(0xFF999999), size: 20),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildGamesSection(GameProvider gameProvider) {
    final displayGames = _showAllGames ? gameProvider.games : gameProvider.games.take(8).toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 2))],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text('🎮', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 8),
                const Text('All Games', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2B2B2B))),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showAllGames = !_showAllGames;
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        _showAllGames ? 'Show Less' : 'See All',
                        style: const TextStyle(color: Color(0xFF58CC02), fontWeight: FontWeight.w700, fontSize: 13),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        _showAllGames ? Icons.keyboard_arrow_up : Icons.arrow_forward,
                        color: const Color(0xFF58CC02),
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!_showAllGames)
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: displayGames.length,
                itemBuilder: (context, index) {
                  return GameCard(
                    game: displayGames[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameScreen(game: displayGames[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.8,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: displayGames.length,
              itemBuilder: (context, index) {
                return GameCard(
                  game: displayGames[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameScreen(game: displayGames[index]),
                      ),
                    );
                  },
                );
              },
            ),
          const SizedBox(height: 8),
          if (!_showAllGames)
            Container(
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: List.generate(
                  8,
                  (index) => Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 4,
                      decoration: BoxDecoration(
                        color: index < 3 ? const Color(0xFF58CC02) : Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildTutorialCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.play_circle_outline, color: Colors.orange, size: 24),
              const SizedBox(width: 8),
              const Text('Watch Tutorial', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2B2B2B))),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: NetworkImage('https://img.youtube.com/vi/VeNp9hrqTlA/maxresdefault.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                const Center(child: Icon(Icons.play_circle_filled, color: Colors.red, size: 48)),
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8)],
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.play_arrow, color: Colors.red, size: 16),
                        SizedBox(width: 4),
                        Text('Watch on YouTube', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black87)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
