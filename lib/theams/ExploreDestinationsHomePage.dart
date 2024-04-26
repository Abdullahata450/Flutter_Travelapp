import 'package:flutter/material.dart';

class ExploreDestinationsHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore Destinations'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Featured Destinations Carousel
            _buildFeaturedDestinationsCarousel(),

            SizedBox(height: 20.0),

            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for destinations...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),

            SizedBox(height: 20.0),

            // Destination Categories
            Text(
              'Destination Categories',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10.0),

            // Category Buttons
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: [
                _buildCategoryButton(context, 'Cities'),
                _buildCategoryButton(context, 'Provinces'),
                _buildCategoryButton(context, 'Historical Sites'),
                // Add more category buttons as needed
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedDestinationsCarousel() {
    // Placeholder widget for the carousel
    return Container(
      height: 200.0,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Text(
          'Featured Destinations Carousel',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context, String categoryName) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to category-specific page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryPage(categoryName: categoryName),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal.shade50,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        categoryName,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}

// Category-specific page
class CategoryPage extends StatelessWidget {
  final String categoryName;

  const CategoryPage({Key? key, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: Center(
        child: Text('Category: $categoryName'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Explore Destinations App',
    theme: ThemeData(
      primaryColor: Colors.blue,
      hintColor: Colors.orange,
    ),
    home: ExploreDestinationsHomePage(),
  ));
}
