import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pizza/models/pizza.dart';
import 'package:pizza/shared/custom_icon_menu.dart';
import 'package:pizza/viewmodels/home_view_model.dart';
import 'package:pizza/views/cart_view.dart';
import 'package:pizza/views/pizza_details_view.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _pizzaAnimatonCont;

  late Animation<double> _scale;
  late Animation<double> _fade;

  final ValueNotifier<int> menuIndex = ValueNotifier<int>(0);

  List<Animation<double>> animation = [];

  List<pizza> pizzas = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
      reverseDuration: const Duration(milliseconds: 600),
    );

    _pizzaAnimatonCont = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
      reverseDuration: const Duration(milliseconds: 600),
    );

    animation = List.generate(10, (index) {
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Interval(index * 0.1, 1)),
      );
    });

    _scale = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _pizzaAnimatonCont, curve: Curves.easeInOut),
    );
    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _pizzaAnimatonCont, curve: Curves.easeInOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      pizzas = await ref.read(homeViewModelProvider.notifier).getAllPizzas();
      setState(() {});
      _controller.forward();
      _pizzaAnimatonCont.forward();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          children: [
            // custom app bar with delivery section
            SizedBox(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FadeTransition(
                      opacity: animation[0],
                      child: Row(
                        children: [
                          // Avatar circle white background
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.black,
                            child: Icon(Icons.person, color: Colors.white),
                          ),

                          SizedBox(width: 20),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Deliver to",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),

                              Text(
                                "Alaziziyah/Hail",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    FadeTransition(
                      opacity: animation[1],
                      child: Row(
                        children: [
                          // notification
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.grey.shade100,

                            child: Icon(
                              Icons.notifications_none_outlined,
                              color: Colors.black,
                              size: 18,
                            ),
                          ),

                          SizedBox(width: 5),
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.grey.shade100,

                            child: InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.shopping_bag_outlined,
                                color: Colors.black,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  FadeTransition(
                    opacity: animation[2],
                    child: Text(
                      "Hungry?",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  SizedBox(width: 5),

                  FadeTransition(
                    opacity: animation[3],
                    child: Text(
                      "Order & Eat.",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Search container
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FadeTransition(
                opacity: animation[4],

                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey.shade200, width: 1),
                  ),

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      SizedBox(width: 10),
                      Icon(Icons.search, color: Colors.black),
                      Text("Search", style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            const SizedBox(height: 40),

            // tabs menu
            Container(
              height: 120,
              width: 600,

              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(250),
                  topRight: Radius.circular(250),
                ),
              ),
              child: Stack(
                children: [
                  // fist option all
                  Positioned(
                    left: MediaQuery.of(context).size.width / 2.3,
                    child: FadeTransition(
                      opacity: animation[5],
                      child: CustomIconMenu(
                        menuIndex: 0,
                        currentMenuIndex: menuIndex,
                        imagePath: 'assets/icons/all-icon.png',
                        iconData: Icons.grid_view,
                        name: "All",
                        onTap: () async {
                          if (menuIndex.value == 0) {
                            return;
                          }

                          pizzas = await ref
                              .read(homeViewModelProvider.notifier)
                              .getAllPizzas();

                          setState(() {
                            menuIndex.value = 0;
                            _pizzaAnimatonCont.forward(from: 0);
                          });
                        },
                      ),
                    ),
                  ),

                  // This for chicken menu
                  Positioned(
                    left: MediaQuery.of(context).size.width / 3.7,
                    top: 15,
                    child: FadeTransition(
                      opacity: animation[6],
                      child: CustomIconMenu(
                        menuIndex: 1,
                        currentMenuIndex: menuIndex,
                        imagePath: 'assets/icons/checken-icon.png',
                        name: "Checken",
                        onTap: () async {
                          pizzas = await ref
                              .read(homeViewModelProvider.notifier)
                              .getCheckenPizzas();

                          setState(() {
                            menuIndex.value = 1;
                            _pizzaAnimatonCont.forward(from: 0);
                          });
                        },
                      ),
                    ),
                  ),

                  // This for meat menu
                  Positioned(
                    left: MediaQuery.of(context).size.width / 8.5,
                    top: 40,
                    child: FadeTransition(
                      opacity: animation[7],
                      child: CustomIconMenu(
                        menuIndex: 2,
                        currentMenuIndex: menuIndex,
                        imagePath: 'assets/icons/beef-icon.png',
                        name: "Beef",
                        onTap: () async {
                          pizzas = await ref
                              .read(homeViewModelProvider.notifier)
                              .getBeefPizzas();

                          setState(() {
                            menuIndex.value = 2;

                            _pizzaAnimatonCont.forward(from: 0);
                          });
                        },
                      ),
                    ),
                  ),

                  // This for cheese menu
                  Positioned(
                    left: MediaQuery.of(context).size.width / 1.7,
                    top: 15,
                    child: FadeTransition(
                      opacity: animation[6],
                      child: CustomIconMenu(
                        menuIndex: 3,
                        currentMenuIndex: menuIndex,
                        imagePath: 'assets/icons/cheese-icon.png',
                        name: "Cheese",
                        onTap: () async {
                          pizzas = await ref
                              .read(homeViewModelProvider.notifier)
                              .getCheesePizzas();

                          setState(() {
                            menuIndex.value = 3;

                            _pizzaAnimatonCont.forward(from: 0);
                          });
                        },
                      ),
                    ),
                  ),

                  // This for Mashroom menu
                  Positioned(
                    left: MediaQuery.of(context).size.width / 1.34,
                    top: 40,
                    child: FadeTransition(
                      opacity: animation[7],
                      child: CustomIconMenu(
                        menuIndex: 4,
                        currentMenuIndex: menuIndex,
                        imagePath: 'assets/icons/mashroom-icon.png',
                        name: "Mashroom",
                        onTap: () async {
                          pizzas = await ref
                              .read(homeViewModelProvider.notifier)
                              .getMashroomPizzas();

                          setState(() {
                            menuIndex.value = 4;

                            _pizzaAnimatonCont.forward(from: 0);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                color: Colors.grey.shade200,
                child: GridView.builder(
                  padding: EdgeInsets.only(bottom: 100),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 250,
                    mainAxisSpacing: 0,

                    childAspectRatio: 2 / 2.5,
                  ),
                  itemCount: pizzas.length,
                  itemBuilder: (context, index) {
                    final currentPizza = pizzas[index];
                    return ScaleTransition(
                      scale: _scale,
                      child: FadeTransition(
                        opacity: _fade,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            decoration: BoxDecoration(
                              // color: Colors.blue,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PizzaDetailsView(
                                    currentPizza: currentPizza,
                                  ),
                                ),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // container
                                  Positioned(
                                    bottom: 0,

                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                          5,
                                      width:
                                          MediaQuery.of(context).size.width /
                                          2.4,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),

                                  // pizza image,
                                  Positioned(
                                    top: -20,

                                    child: RotationTransition(
                                      turns: Tween(
                                        begin: 0.0,
                                        end: 1.0,
                                      ).animate(_fade),
                                      child: Hero(
                                        tag: 'pizza-image${currentPizza.image}',
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            400,
                                          ),
                                          child: Image.asset(
                                            'assets/images/pizzas-images/${currentPizza.image}',
                                            height: 170,
                                            width: 150,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // name,
                                  Positioned(
                                    bottom: 65,

                                    child: Text(
                                      currentPizza.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                                  // sub title
                                  Positioned(
                                    bottom: 46,

                                    child: Text(
                                      currentPizza.subTitle,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),

                                  // price and add to cart button
                                  Positioned(
                                    bottom: 10,
                                    left: 10,
                                    right: 10,

                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // price
                                        Row(
                                          children: [
                                            Text(
                                              "\$",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.deepOrangeAccent,
                                              ),
                                            ),
                                            Text(
                                              currentPizza.sizes[0].price
                                                  .toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),

                                        // button
                                        Container(
                                          height: 25,
                                          width: 25,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(
                                              400,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FadeTransition(
        opacity: animation[6],
        child: Container(
          margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.house, color: Colors.white),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.card_giftcard, color: Colors.white),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
