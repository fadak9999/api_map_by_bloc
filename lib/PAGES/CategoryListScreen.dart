import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:api_map_by_bloc/bloc/api_bloc.dart';
import 'package:api_map_by_bloc/API/ApiService.dart';
import 'package:api_map_by_bloc/PAGES/LocationListScreen.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Categories'),
      ),
      body: BlocProvider(
        create: (context) => ApiBloc(ApiService())..add(FetchCategories()),
        child: Stack(
          children: [
            const Positioned.fill(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(31.99330933, 44.3153606),
                  zoom: 14.0,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 100,
              child: Container(
                color: Colors.black.withOpacity(0.7),
                child: BlocBuilder<ApiBloc, ApiState>(
                  builder: (context, state) {
                    if (state is CategoriesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CategoriesError) {
                      return Center(child: Text('Error: ${state.message}'));
                    } else if (state is CategoriesLoaded) {
                      final categories = state.categories;
                      if (categories.isEmpty) {
                        return const Center(child: Text('No categories found.'));
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, i) {
                          return Container(
                            width: 100,
                            margin: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LocationListScreen(category: categories[i]),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: _parseColor(categories[i].colorHex),
                                    child: const Icon(Icons.category_outlined, color: Colors.white),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    categories[i].name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const Center(child: Text('Loading...'));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _parseColor(String colorHex) {
    if (colorHex.isNotEmpty && colorHex.startsWith('#')) {
      try {
        return Color(int.parse(colorHex.replaceFirst('#', '0xff')));
      } catch (e) {
        return Colors.grey;
      }
    }
    return Colors.grey;
  }
}
