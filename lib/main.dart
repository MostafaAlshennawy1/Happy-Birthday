import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:confetti/confetti.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Birthday Celebration',
      theme: ThemeData(
        fontFamily: 'FredokaOne',
      ),
      home: const BirthdayScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> with TickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _heartAnimationController;
  late Animation<double> _heartAnimation;
  late TextEditingController _nameController;

  // --- State variable for the name ---
  String _currentName = "Mostafa";
  bool _wishMade = false;

  void _resetWish() {
    setState(() {
      _wishMade = false;
    });
  }

  // --- Function to show name change dialog ---
  void _showNameDialog() {
    _nameController.text = _currentName;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF9E7F4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Who are we celebrating?", style: TextStyle(color: Color(0xFF4C3E8A))),
        content: TextField(
          controller: _nameController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Enter name",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF8759E)),
            onPressed: () {
              setState(() {
                if (_nameController.text.isNotEmpty) {
                  _currentName = _nameController.text;
                }
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
    _nameController = TextEditingController();

    _heartAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _heartAnimation = Tween<double>(begin: 50.0, end: 58.0).animate(
      CurvedAnimation(
        parent: _heartAnimationController,
        curve: Curves.easeInOut,
      ),
    );
    _heartAnimationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _heartAnimationController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF9E7F4), Color(0xFFFAD7D7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              image: DecorationImage(
                image: AssetImage("assets/images/mostafa-birthday-background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              numberOfParticles: 35,
              gravity: 0.3,
              colors: const [Color(0xFFADFFC1), Color(0xFFF8759E), Colors.lightBlue, Colors.orange, Colors.purple],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTopBar(),
                  const Spacer(flex: 2),
                  _buildBirthdayText(),
                  const Spacer(flex: 3),
                  _buildGlassCakeContainer(screenWidth, screenHeight),
                  const Spacer(flex: 4),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: _wishMade ? _buildWishMadeUI() : _buildMakeAWishButton(),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side: Back or Edit Name
          _wishMade
              ? IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFFF8759E)),
            onPressed: _resetWish,
          )
              : IconButton(
            icon: const Icon(Icons.edit, color: Color(0xFF4C3E8A)),
            onPressed: _showNameDialog, // Button to change name
          ),
          // Right side: Celebrate
          if (!_wishMade)
            ElevatedButton(
              onPressed: () => _confettiController.play(),
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFF4C3E8A),
                backgroundColor: const Color(0xFFADFFC1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text('Celebrate!'),
            ),
        ],
      ),
    );
  }

  Widget _buildBirthdayText() {
    const textStyle = TextStyle(fontSize: 48, color: Color(0xFF4C3E8A), fontWeight: FontWeight.bold, height: 1.1);
    final nameBaseStyle = TextStyle(
      fontWeight: FontWeight.bold,
      foreground: Paint()
        ..style = PaintingStyle.fill
        ..color = const Color(0xFFF8759E),
      shadows: [
        const Shadow(color: Color.fromARGB(255, 255, 221, 143), offset: Offset(0, 4), blurRadius: 10),
      ],
    );

    return Column(
      children: [
        const Text('Happy', style: textStyle),
        const Text('Birthday', style: textStyle),
        AnimatedBuilder(
          animation: _heartAnimation,
          builder: (context, child) {
            return Text(
              '$_currentName!',
              style: nameBaseStyle.copyWith(
                fontSize: _heartAnimation.value,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildGlassCakeContainer(double width, double height) {
    return GlassmorphicContainer(
      width: width * 0.75,
      height: height * 0.3,
      borderRadius: 25,
      blur: 20,
      alignment: Alignment.center,
      border: 1.5,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white.withOpacity(0.2), Colors.white.withOpacity(0.05)],
        stops: const [0.1, 1],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white.withOpacity(0.5), Colors.white.withOpacity(0.1)],
      ),
      child: Center(
        child: Image.asset(
          _wishMade ? 'assets/images/mostafa-birthday-cake-with-fire.png' : 'assets/images/mostafa-birthday-cake.png',
          fit: BoxFit.contain,
          width: width * 0.9,
        ),
      ),
    );
  }

  Widget _buildMakeAWishButton() {
    return Container(
      key: const ValueKey('make_wish_button'),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF8759E).withOpacity(0.5),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: () => setState(() => _wishMade = true),
        icon: Image.asset('assets/images/mostafa-matchstick-icon.png', width: 40, height: 55),
        label: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text('Make a Wish!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color(0xFF4C3E8A),
          backgroundColor: const Color(0xFFF8759E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          minimumSize: const Size(240, 55),
        ),
      ),
    );
  }

  Widget _buildWishMadeUI() {
    return Column(
      key: const ValueKey('wish_made_ui'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF9C4),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.yellow.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
          ),
          child: const Text(
            '✨ Your wish is my\ncommand! ✨',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF4C3E8A), fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'May all your dreams come true, $_currentName!\n🎉❤️', // Uses dynamic name
          textAlign: TextAlign.center,
          style: const TextStyle(color: Color(0xFF4C3E8A), fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ],
    );
  }
}