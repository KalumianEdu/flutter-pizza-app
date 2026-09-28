import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pizza/core/providers/provider.dart';
import 'package:pizza/data/repositories/pizza_repo.dart';
import 'package:pizza/models/pizza.dart';

class HomeViewModel extends Notifier<List<pizza>> {
  late final PizzaRepo _pizzaRepo;

  @override
  List<pizza> build() {
    _pizzaRepo = ref.read(pizzaRepoProvider);
    return [];
  }

  Future<List<pizza>> getAllPizzas() async {
    try {
      final pizzas = await _pizzaRepo.getAllPizzas();
      return pizzas;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<pizza>> getCheckenPizzas() async {
    try {
      final pizzas = await _pizzaRepo.getChickenPizzas();
      return pizzas;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<pizza>> getBeefPizzas() async {
    try {
      final pizzas = await _pizzaRepo.getBeefPizzas();
      return pizzas;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<pizza>> getCheesePizzas() async {
    try {
      final pizzas = await _pizzaRepo.getCheesePizzas();
      return pizzas;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<pizza>> getMashroomPizzas() async {
    try {
      final pizzas = await _pizzaRepo.getMashrromPizzas();
      return pizzas;
    } catch (e) {
      throw Exception(e);
    }
  }
}

final homeViewModelProvider = NotifierProvider<HomeViewModel, List<pizza>>(() {
  return HomeViewModel();
});
