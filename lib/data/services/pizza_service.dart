import 'package:pizza/models/pizza.dart';
import 'package:pizza/models/size.dart';

class PizzaService {
  Future<List<pizza>> getAllPizzas() async {
    return [
      ...checkenPizzas,
      ...beefPizzas,
      ...cheesePizzas,
      ...mashroomPizzas,
    ];
  }

  Future<List<pizza>> getBeefPizzas() async {
    return beefPizzas;
  }

  Future<List<pizza>> getChickenPizzas() async {
    return checkenPizzas;
  }

  Future<List<pizza>> getMashrromPizzas() async {
    return mashroomPizzas;
  }

  Future<List<pizza>> getCheesePizzas() async {
    return cheesePizzas;
  }
}

List<pizza> checkenPizzas = [
  pizza(
    title: "The BBQ Chicken",
    subTitle: "Smoky, Savory, Crispy",
    image: "The BBQ Chicken Bacon Artisan.png",
    description:
        """A rich foundation of sweet, smoky barbecue sauce spread across hand-stretched, stone-baked artisanal crust. Loaded with tender pulled BBQ chicken, crispy crumbled bacon, slivered red onions, and ripe red and yellow cherry tomato jewels, all blanketed beneath bubbly melted mozzarella and crowned with fresh basil.""",
    sizes: [
      PizzaSize(
        name: "Small",
        price: 16.95,
        inch: 10,
        slices: 6,
        calories: 250,
      ),
      PizzaSize(
        name: "Medium",
        price: 21.95,
        inch: 12,
        slices: 8,
        calories: 300,
      ),
      PizzaSize(
        name: "Large",
        price: 25.95,
        inch: 14,
        slices: 10,
        calories: 350,
      ),
    ],
  ),

  pizza(
    title: "The Chicken Fusion",
    subTitle: "Herbal, Rustic, Spicy",
    image: "The Pesto & Artichoke Chicken Fusion no bg.png",
    description:
        """A vibrant, Mediterranean-inspired specialty crafted over an aromatic basil-pesto base and stone-baked crust. Topped with seasoned grilled chicken breast slices, tender marinated artichoke hearts, sweet sun-dried tomatoes, crumbles of creamy feta cheese, and toasted pine nuts, finished with a crown of fresh garden basil.""",
    sizes: [
      PizzaSize(
        name: "Small",
        price: 17.95,
        inch: 10,
        slices: 6,
        calories: 250,
      ),
      PizzaSize(
        name: "Medium",
        price: 21.95,
        inch: 12,
        slices: 8,
        calories: 300,
      ),
      PizzaSize(
        name: "Large",
        price: 25.95,
        inch: 14,
        slices: 10,
        calories: 350,
      ),
    ],
  ),

  pizza(
    title: "The Chicken Medley",
    subTitle: "Vibrant, Tangy, Charred",
    image: "The Pesto & Roasted Red Pepper Chicken Medley no bg.png",
    description:
        """A fragrant creation layered over an aromatic basil-pesto base and stone-baked artisanal crust. Generously topped with flame-roasted red pepper strips, tender grilled chicken breast fillets, chewy sun-dried tomatoes, and crumbles of creamy feta cheese, centered with a fresh sprig of basil.""",
    sizes: [
      PizzaSize(
        name: "Small",
        price: 17.95,
        inch: 10,
        slices: 6,
        calories: 250,
      ),
      PizzaSize(
        name: "Medium",
        price: 21.95,
        inch: 12,
        slices: 8,
        calories: 300,
      ),
      PizzaSize(
        name: "Large",
        price: 25.95,
        inch: 14,
        slices: 10,
        calories: 350,
      ),
    ],
  ),
];

List<pizza> beefPizzas = [
  pizza(
    title: "The Philly Steak",
    subTitle: "Savory, Cheesy, Bold",
    image: "The Philly Steak & Provolone Artisan no bg.png",
    description:
        """A steakhouse classic transformed into an artisanal pizza. Built over a rich, velvety provolone cream base on stone-baked crust, topped with tender seared sirloin steak strips, tender sautéed green bell peppers, and sweet yellow onions. Finished with melted provolone cheese, cracked black pepper, and a fresh basil garnish.""",
    sizes: [
      PizzaSize(
        name: "Small",
        price: 16.95,
        inch: 10,
        slices: 6,
        calories: 250,
      ),
      PizzaSize(
        name: "Medium",
        price: 21.95,
        inch: 12,
        slices: 8,
        calories: 300,
      ),
      PizzaSize(
        name: "Large",
        price: 25.95,
        inch: 14,
        slices: 10,
        calories: 350,
      ),
    ],
  ),

  pizza(
    title: "The Prime Rib Steakhouse",
    subTitle: "Hearty, Smoky, Gourmet",
    image: "The Prime Rib Steakhouse Artisan no bg.png",
    description:
        """A steakhouse classic transformed into an artisanal pizza. Built over a rich, velvety provolone cream base on stone-baked crust, topped with tender slow-roasted prime rib, savory caramelized mushrooms, and sweet caramelized onions. Finished with melted provolone cheese, a hint of truffle oil, and a fresh rosemary sprig.""",
    sizes: [
      PizzaSize(
        name: "Small",
        price: 16.95,
        inch: 10,
        slices: 6,
        calories: 250,
      ),
      PizzaSize(
        name: "Medium",
        price: 21.95,
        inch: 12,
        slices: 8,
        calories: 300,
      ),
      PizzaSize(
        name: "Large",
        price: 25.95,
        inch: 14,
        slices: 10,
        calories: 350,
      ),
    ],
  ),
];

List<pizza> cheesePizzas = [
  pizza(
    title: "The Rustic Three-Cheese",
    subTitle: "Classic, Golden, Molten",
    image: "The Rustic Three-Cheese Stone-Baked Pizza no bg.png",
    description:
        """A comforting masterpiece built upon a savory garlic-herb cream sauce and stone-baked artisanal crust, generously blanketed with a golden layer of premium mozzarella cheese. Finished with delicate shavings of authentic Italian Parmesan, a hint of aromatic oregano, and fresh basil leaves for a truly classic Italian experience.""",
    sizes: [
      PizzaSize(
        name: "Small",
        price: 16.95,
        inch: 10,
        slices: 6,
        calories: 250,
      ),
      PizzaSize(
        name: "Medium",
        price: 21.95,
        inch: 12,
        slices: 8,
        calories: 300,
      ),
      PizzaSize(
        name: "Large",
        price: 25.95,
        inch: 14,
        slices: 10,
        calories: 350,
      ),
    ],
  ),

  pizza(
    title: "The White Cheese",
    subTitle: "Decadent, Creamy, Pungent",
    image: "The Rustic White Three-Cheese & Gorgonzola no bg.png",
    description:
        """A luxurious creation layered over a rich garlic-herb cream sauce on a stone-baked artisanal crust. Generously topped with a sophisticated blend of melted mozzarella, creamy goat cheese, and tangy gorgonzola cheese, enhanced with hints of fresh thyme and basil.""",
    sizes: [
      PizzaSize(
        name: "Small",
        price: 16.95,
        inch: 10,
        slices: 6,
        calories: 250,
      ),
      PizzaSize(
        name: "Medium",
        price: 21.95,
        inch: 12,
        slices: 8,
        calories: 300,
      ),
      PizzaSize(
        name: "Large",
        price: 25.95,
        inch: 14,
        slices: 10,
        calories: 350,
      ),
    ],
  ),
];

List<pizza> mashroomPizzas = [
  pizza(
    title: "The Wild Mushroom",
    subTitle: "Earthy, Decadent, Aromatic",
    image: "The Truffle & Wild Mushroom Artisan no bg.png",
    description:
        """A luxurious creation layered over a rich garlic-herb cream sauce on a stone-baked artisanal crust. Generously topped with a sophisticated blend of melted mozzarella, creamy goat cheese, and tangy gorgonzola cheese, enhanced with hints of fresh thyme and basil.""",
    sizes: [
      PizzaSize(
        name: "Small",
        price: 16.95,
        inch: 10,
        slices: 6,
        calories: 250,
      ),
      PizzaSize(
        name: "Medium",
        price: 21.95,
        inch: 12,
        slices: 8,
        calories: 300,
      ),
      PizzaSize(
        name: "Large",
        price: 25.95,
        inch: 14,
        slices: 10,
        calories: 350,
      ),
    ],
  ),

  pizza(
    title: "The Mushroom & Rosemary",
    subTitle: "Savory, Creamy, Aromatic",
    image: "The Wild Mushroom & Rosemary Artisan no bg.png",
    description:
        """A luxurious creation layered over a rich cream sauce on a stone-baked artisanal crust. Generously topped with a sophisticated blend of melted mozzarella, creamy goat cheese, and tangy gorgonzola cheese, enhanced with hints of fresh thyme and basil.""",
    sizes: [
      PizzaSize(
        name: "Small",
        price: 16.95,
        inch: 10,
        slices: 6,
        calories: 250,
      ),
      PizzaSize(
        name: "Medium",
        price: 21.95,
        inch: 12,
        slices: 8,
        calories: 300,
      ),
      PizzaSize(
        name: "Large",
        price: 25.95,
        inch: 14,
        slices: 10,
        calories: 350,
      ),
    ],
  ),
];
