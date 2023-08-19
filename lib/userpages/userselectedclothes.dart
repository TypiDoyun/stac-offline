import 'package:flutter/material.dart';

class UserSelectedClothesPage extends StatefulWidget {
  const UserSelectedClothesPage({Key? key}) : super(key: key);

  @override
  State<UserSelectedClothesPage> createState() =>
      _UserSelectedClothesPageState();
}

class _UserSelectedClothesPageState extends State<UserSelectedClothesPage> {
  final PageController _pageController = PageController();

  final image = [
    'assets/images/clothesImage1.jpeg',
    'assets/images/clothesImage2.jpeg',
    'assets/images/clothesImage3.jpeg'
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: PageView.builder(
                    itemCount: image.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                          // Make the height same as width for a square
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            image: DecorationImage(
                              image: AssetImage(image[index]),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            // Replace with actual image asset path
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Product Title',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '\$100',
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Product Description...',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // PG
                    },
                    child: const Text('Add to Cart'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final bool isActive;

  const Indicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.white.withOpacity(0.8) : Colors.grey,
      ),
    );
  }
}
