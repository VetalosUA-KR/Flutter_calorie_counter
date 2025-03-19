import 'package:flutter/material.dart';
import 'package:flutterhelloworld/model/meal.dart';
import 'package:flutterhelloworld/repository/remote/open_food_facts_api.dart';
import 'package:flutterhelloworld/repository/remote/product_model.dart';

class MealScreen extends StatefulWidget {
  final Function(Meal) onAddMeal;
  final MealType mealType;

  const MealScreen({
    super.key,
    required this.onAddMeal,
    required this.mealType,
  });

  @override
  _MealScreenState createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  final OpenFoodFactsApi _api = OpenFoodFactsApi();
  final TextEditingController _searchController = TextEditingController();
  List<Product> _products = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  String _searchQuery = '';
  String? _errorMessage; // Добавляем переменную для хранения ошибки

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final newQuery = _searchController.text.trim();
    if (newQuery != _searchQuery) {
      setState(() {
        _searchQuery = newQuery;
        _products.clear();
        _currentPage = 1;
        _hasMore = true;
        _errorMessage = null; // Сбрасываем ошибку при новом поиске
      });
      _loadProducts();
    }
  }

  Future<void> _loadProducts() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null; // Сбрасываем ошибку перед новым запросом
    });

    try {
      /*final response = await _api.searchProducts(
        query: _searchQuery.isEmpty ? null : _searchQuery,
        page: _currentPage,
        pageSize: 20,
        sortAlphabetically: true,
      );*/
      final response = await _api.searchProducts(
        query: _searchQuery.isEmpty ? null : _searchQuery,
        page: _currentPage,
        pageSize: 20,
      );

      setState(() {
        _products.addAll(response.products ?? []);
        _currentPage++;
        _hasMore = (response.products?.length ?? 0) == 20;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load products: $e'; // Сохраняем сообщение об ошибке
      });
    }
  }

  void _addMeal(Product product) {
    final meal = Meal(
      name: product.productName ?? 'Unknown Product',
      calories: product.nutriments?.energyKcal ?? 0,
      type: widget.mealType,
      protein: product.nutriments?.proteins ?? 0.0,
      fat: product.nutriments?.fat ?? 0.0,
      carbs: product.nutriments?.carbohydrates ?? 0.0,
    );
    widget.onAddMeal(meal);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Meal'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products (e.g., apple)',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: _errorMessage != null
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadProducts, // Кнопка для повторной попытки
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
                : NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (!_isLoading &&
                    _hasMore &&
                    scrollInfo.metrics.pixels >=
                        scrollInfo.metrics.maxScrollExtent * 0.8) {
                  _loadProducts();
                }
                return false;
              },
              child: ListView.builder(
                itemCount: _products.length + (_hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _products.length) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final product = _products[index];
                  return ListTile(
                    leading: product.imageUrl != null
                        ? Image.network(
                      product.imageUrl!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.fastfood),
                    )
                        : const Icon(Icons.fastfood),
                    title: Text(product.productName ?? 'Unknown Product'),
                    subtitle: Text(
                      'Calories: ${product.nutriments?.energyKcal?.toStringAsFixed(0) ?? 'N/A'} kcal/100g',
                    ),
                    onTap: () => _addMeal(product),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}