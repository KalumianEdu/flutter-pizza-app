import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pizza/models/pizza.dart';
import 'package:pizza/models/size.dart';
import 'package:pizza/viewmodels/home_view_model.dart';
import 'package:pizza/views/cart_view.dart';

class PizzaDetailsView extends StatefulWidget {
  final pizza currentPizza;
  const PizzaDetailsView({super.key, required this.currentPizza});

  @override
  State<PizzaDetailsView> createState() => _PizzaDetailsViewState();
}

class _PizzaDetailsViewState extends State<PizzaDetailsView>
    with TickerProviderStateMixin {
  int currentSize = 0;
  late PizzaSize currentPizzaSize;

  late AnimationController _controller;
  late Animation<double> scaleAnimation;
  late Animation<Offset> _slide;
  List<Animation<double>> animation = [];
  late AnimationController _pizzaAnimatonCont;
  late Animation<Offset> _slidePizza;
  late AnimationController _fabSlideDownCont;
  late AnimationController _pizzaAnimationSlideDown;
  late Animation<Offset> _slideDownPizza;
  late Animation<double> _turns;
  late Animation<double> _scaleAnimationPizzaSlideDown;

  late Animation<Offset> _slideDownFab;

  bool showOverlay = false;
  bool hasAnimationCompleted = false;
  bool slideDownButtonTriggered = false;

  @override
  void initState() {
    super.initState();
    currentPizzaSize = widget.currentPizza.sizes[0];
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _pizzaAnimatonCont = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
      reverseDuration: const Duration(milliseconds: 500),
    );

    _fabSlideDownCont = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
      reverseDuration: const Duration(milliseconds: 200),
    );

    _slidePizza = Tween<Offset>(begin: Offset(0, 0), end: Offset(-0.5, 0))
        .animate(
          CurvedAnimation(parent: _pizzaAnimatonCont, curve: Curves.easeInOut),
        );

    _turns = Tween<double>(begin: 0, end: -2).animate(
      CurvedAnimation(parent: _pizzaAnimatonCont, curve: Curves.easeInOut),
    );

    _pizzaAnimationSlideDown = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
      reverseDuration: const Duration(milliseconds: 500),
    );

    _slideDownPizza =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-0.3, 1.65)).animate(
          CurvedAnimation(
            parent: _pizzaAnimationSlideDown,
            curve: Curves.easeInOut,
          ),
        );

    _scaleAnimationPizzaSlideDown = Tween<double>(begin: 1, end: 0.2).animate(
      CurvedAnimation(
        parent: _pizzaAnimationSlideDown,
        curve: Curves.easeInOut,
      ),
    );

    _slideDownFab = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, -0.15),
    ).animate(CurvedAnimation(parent: _fabSlideDownCont, curve: Curves.easeIn));

    animation = List.generate(10, (index) {
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Interval(index * 0.1, 1)),
      );
    });

    scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _slide = Tween<Offset>(
      begin: Offset(0.0, 0.1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();

    _pizzaAnimatonCont.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        _fabSlideDownCont.forward();
        await Future.delayed(const Duration(milliseconds: 300));
        _pizzaAnimationSlideDown.forward();
      }
    });

    _pizzaAnimationSlideDown.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        hasAnimationCompleted = true;
        setState(() {});
        await Future.delayed(const Duration(milliseconds: 500));
        slideDownButtonTriggered = true;
        setState(() {});

        await Future.delayed(const Duration(milliseconds: 300));
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => CartView(currentPizza: widget.currentPizza),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _pizzaAnimatonCont.dispose();
    _fabSlideDownCont.dispose();
    _pizzaAnimationSlideDown.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ScaleTransition(
                      scale: scaleAnimation,
                      child: FadeTransition(
                        opacity: animation[0],
                        child: Container(
                          padding: EdgeInsets.all(0),
                          margin: EdgeInsets.only(left: 16, right: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.arrow_back_ios_new, size: 20),
                            onPressed: () => Navigator.pop(context),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    ScaleTransition(
                      scale: scaleAnimation,

                      child: FadeTransition(
                        opacity: animation[0],
                        child: Container(
                          padding: EdgeInsets.all(0),
                          margin: EdgeInsets.only(left: 16, right: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.favorite_border, size: 20),
                            onPressed: () {},
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              //. title and sub-title
              SlideTransition(
                position: _slide,
                child: FadeTransition(
                  opacity: animation[1],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.currentPizza.title,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          widget.currentPizza.subTitle,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // two section first info [price and cal and size] second about [pizza image]
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SlideTransition(
                    position: _slide,
                    child: FadeTransition(
                      opacity: animation[2],
                      child: Container(
                        margin: EdgeInsets.only(left: 20, top: 40),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            // price
                            Row(
                              children: [
                                Text(
                                  "\$",
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                      255,
                                      228,
                                      106,
                                      36,
                                    ),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.start,
                                ),

                                TweenAnimationBuilder(
                                  tween: Tween<double>(
                                    begin: 0,
                                    end: currentPizzaSize.price,
                                  ),
                                  duration: const Duration(milliseconds: 500),
                                  builder: (context, value, child) {
                                    return Text(
                                      value.toStringAsFixed(2),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            // cal
                            Column(
                              children: [
                                Text(
                                  "Calories",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),

                                TweenAnimationBuilder(
                                  tween: Tween<double>(
                                    begin: 0,
                                    end: currentPizzaSize.calories.toDouble(),
                                  ),
                                  duration: const Duration(milliseconds: 500),
                                  builder: (context, value, child) {
                                    return Text(
                                      value.toStringAsFixed(0),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            // size
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Diameter / Portion",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  "${currentPizzaSize.inch}' / ${currentPizzaSize.slices} Slices",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Stack(
                    children: [
                      Positioned(
                        child: Hero(
                          tag: 'pizza-image${widget.currentPizza.image}',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(400),
                            child: Image.asset(
                              'assets/images/pizzas-images/${widget.currentPizza.image}',
                              height: 290,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // sizes buttons
              SlideTransition(
                position: _slide,
                child: FadeTransition(
                  opacity: animation[4],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1. Size
                        Text(
                          "Size",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade700,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildSizeButt(0),
                            _buildSizeButt(1),
                            _buildSizeButt(2),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // description
              SlideTransition(
                position: _slide,
                child: FadeTransition(
                  opacity: animation[5],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade700,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          widget.currentPizza.description,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            height: 1.2, // for better readability
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Overlay
          if (showOverlay)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),

                child: Container(color: Colors.black.withOpacity(0.35)),
              ),
            ),

          // Widget that should stay visible
          if (showOverlay)
            if (!hasAnimationCompleted)
              Positioned(
                top: 160,
                right: 0,
                child: SlideTransition(
                  position: _slideDownPizza,
                  child: ScaleTransition(
                    scale: _scaleAnimationPizzaSlideDown,
                    child: SlideTransition(
                      position: _slideDownFab,
                      child: SlideTransition(
                        position: _slidePizza,
                        child: RotationTransition(
                          turns: _turns,

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(400),
                            child: Image.asset(
                              'assets/images/pizzas-images/${widget.currentPizza.image}',
                              height: 290,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      floatingActionButton: FadeTransition(
        opacity: animation[6],
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 300),
          offset: slideDownButtonTriggered
              ? const Offset(0, 2)
              : const Offset(0, 0),
          curve: Curves.ease,

          child: SlideTransition(
            position: _slide,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.only(bottom: 0, left: 20, right: 20),
              height: 50,
              width: showOverlay
                  ? hasAnimationCompleted
                        ? 50
                        : 200
                  : MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: showOverlay
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                children: [
                  // 1. Animated Container for the Plus/Minus buttons
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInSine,
                    height: 50,
                    // Shrink width to 0 when clicked
                    width: showOverlay ? 0 : 110,
                    clipBehavior: Clip
                        .hardEdge, // Prevents overflow errors while shrinking
                    decoration: BoxDecoration(
                      color: showOverlay ? Colors.transparent : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade400, width: 1),
                    ),
                    // SingleChildScrollView prevents the Row from complaining about lack of space during animation
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      child: SizedBox(
                        width:
                            110, // Hardcoded width to keep inner layout stable
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // minus btn
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.remove, color: Colors.black),
                            ),
                            const Text(
                              "1",
                              style: TextStyle(color: Colors.black),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.transparent,
                                child: Icon(Icons.add, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // 2. Animate the spacing away as well
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: showOverlay ? 0 : 50,
                  ),

                  // 3. Expanded now wraps the InkWell (Fixes layout error)
                  Container(
                    margin: showOverlay
                        ? EdgeInsets.zero
                        : EdgeInsets.symmetric(horizontal: 30),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          showOverlay = true; // Trigger the shrink animation
                          // showOverlay = !showOverlay;
                        });
                        _pizzaAnimatonCont.forward();
                      },
                      child: Row(
                        // Center the cart text dynamically as it takes over the space
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_bag_rounded, color: Colors.white),
                          if (!hasAnimationCompleted) SizedBox(width: 10),
                          Text(
                            hasAnimationCompleted ? "" : "Add to cart",

                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSizeButt(int index) {
    String title = index == 0
        ? "Small"
        : index == 1
        ? "Medium"
        : "Large";
    return InkWell(
      onTap: () {
        setState(() {
          currentSize = index;
          currentPizzaSize = widget.currentPizza.sizes[index];
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
          color: currentSize == index
              ? const Color.fromARGB(255, 228, 106, 36)
              : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: currentSize == index ? Colors.white : Colors.black,

            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
