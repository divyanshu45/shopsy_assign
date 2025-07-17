import 'dart:convert';
import '../models/product.dart';

class ProductRepository {
  Future<List<Product>> getProducts() async {
    try {
      final String response = '''[
    {
      "id": 1,
  "name": "iPhone 15 Pro",
  "description": "Latest iPhone with A17 Pro chip, titanium design, and advanced camera system. Perfect for photography and professional use.",
  "price": 999.99,
  "imageUrl": "https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=500",
  "category": "Electronics",
  "rating": 4.8,
  "stock": 25
},
  {
  "id": 2,
  "name": "Samsung Galaxy S24",
  "description": "Flagship Android phone with AI features, excellent camera, and long battery life. Great for productivity and entertainment.",
  "price": 799.99,
  "imageUrl": "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500",
  "category": "Electronics",
  "rating": 4.6,
  "stock": 30
  },
  {
  "id": 3,
  "name": "Nike Air Max 270",
  "description": "Comfortable running shoes with Air Max technology. Perfect for daily wear and light exercise.",
  "price": 149.99,
  "imageUrl": "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500",
  "category": "Footwear",
  "rating": 4.5,
  "stock": 50
  },
  {
  "id": 4,
  "name": "MacBook Pro 14",
  "description": "Powerful laptop with M3 chip, Retina display, and all-day battery life. Ideal for professionals and creatives.",
  "price": 1999.99,
  "imageUrl": "https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=500",
  "category": "Electronics",
  "rating": 4.9,
  "stock": 15
  },
  {
  "id": 5,
  "name": "Adidas Ultraboost 23",
  "description": "Premium running shoes with Boost technology for maximum comfort and energy return.",
  "price": 189.99,
  "imageUrl": "https://images.unsplash.com/photo-1549298916-b41d501d3772?w=500",
  "category": "Footwear",
  "rating": 4.7,
  "stock": 40
  },
  {
  "id": 6,
  "name": "Sony WH-1000XM5",
  "description": "Industry-leading noise canceling headphones with exceptional sound quality and comfort.",
  "price": 399.99,
  "imageUrl": "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500",
  "category": "Electronics",
  "rating": 4.8,
  "stock": 35
  },
  {
  "id": 7,
  "name": "Levi's 501 Jeans",
  "description": "Classic straight-leg jeans made from premium denim. Timeless style that never goes out of fashion.",
  "price": 79.99,
  "imageUrl": "https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=500",
  "category": "Clothing",
  "rating": 4.4,
  "stock": 60
  },
  {
  "id": 8,
  "name": "Apple Watch Series 9",
  "description": "Advanced smartwatch with health monitoring, fitness tracking, and seamless iOS integration.",
  "price": 449.99,
  "imageUrl": "https://images.unsplash.com/photo-1434493789847-2f02dc6ca35d?w=500",
  "category": "Electronics",
  "rating": 4.7,
  "stock": 28
  },
  {
  "id": 9,
  "name": "Champion Hoodie",
  "description": "Comfortable cotton hoodie perfect for casual wear and layering. Available in multiple colors.",
  "price": 59.99,
  "imageUrl": "https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=500",
  "category": "Clothing",
  "rating": 4.3,
  "stock": 45
  },
  {
  "id": 10,
  "name": "Kindle Paperwhite",
  "description": "Waterproof e-reader with adjustable warm light and weeks of battery life. Perfect for reading enthusiasts.",
  "price": 149.99,
  "imageUrl": "https://images.unsplash.com/photo-1592496431122-2349e0fbc666?w=500",
  "category": "Electronics",
  "rating": 4.6,
  "stock": 22
  }
  ]''';
      final List<dynamic> data = json.decode(response);
      return data.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<Product?> getProductById(int id) async {
    try {
      final products = await getProducts();
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
}
