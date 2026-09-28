import 'package:flutter/material.dart';
import 'package:pizza/views/home_page.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _buttonAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: Offset(0, -0.2),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _buttonAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: Offset(0, -0.1),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // image container
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.4,
            child: Image.asset(
              'assets/images/get-started.png',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitHeight,
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  spreadRadius: 75,
                  blurRadius: 30,
                  offset: Offset(0, 0),
                ),
              ],
            ),
          ),

          // text container
          SlideTransition(
            position: _slideAnimation,
            child: Container(
              margin: const EdgeInsets.only(top: 0),

              child: const Text(
                'Build Your\n Flavour, Step by Step',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // description container
          SlideTransition(
            position: _slideAnimation,
            child: Container(
              child: Text(
                'Stack fresh ingredients for pizza made you way',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ),

          // button container
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _buttonAnimation,
              child: Container(
                width: MediaQuery.of(context).size.width / 1.3,
                height: MediaQuery.of(context).size.height / 15,
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  child: const Text('Get Started'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
