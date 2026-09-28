import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pizza/data/repositories/pizza_repo.dart';
import 'package:pizza/data/services/pizza_service.dart';

final pizzaServiceProvider = Provider<PizzaService>((ref) => PizzaService());
final pizzaRepoProvider = Provider<PizzaRepo>(
  (ref) => PizzaRepo(pizzaService: ref.read(pizzaServiceProvider)),
);
