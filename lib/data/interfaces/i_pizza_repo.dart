import 'package:pizza/models/pizza.dart';

abstract class IPizzaRepo {
  Future<List<pizza>> getAllPizzas();
  Future<List<pizza>> getBeefPizzas();
  Future<List<pizza>> getChickenPizzas();
  Future<List<pizza>> getMashrromPizzas();
  Future<List<pizza>> getCheesePizzas();
}
