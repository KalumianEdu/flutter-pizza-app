import 'package:pizza/data/interfaces/i_pizza_repo.dart';
import 'package:pizza/data/services/pizza_service.dart';
import 'package:pizza/models/pizza.dart';

class PizzaRepo implements IPizzaRepo {
  final PizzaService pizzaService;

  PizzaRepo({required this.pizzaService});

  @override
  Future<List<pizza>> getAllPizzas() async {
    return await pizzaService.getAllPizzas();
  }

  @override
  Future<List<pizza>> getBeefPizzas() async {
    return await pizzaService.getBeefPizzas();
  }

  @override
  Future<List<pizza>> getChickenPizzas() async {
    return await pizzaService.getChickenPizzas();
  }

  @override
  Future<List<pizza>> getMashrromPizzas() async {
    return await pizzaService.getMashrromPizzas();
  }

  @override
  Future<List<pizza>> getCheesePizzas() async {
    return await pizzaService.getCheesePizzas();
  }
}
