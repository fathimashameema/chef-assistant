import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_appbar.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/functions/add_categories.dart';
import 'package:chef_assistant/screens/admin/admin_category/category_items.dart';
import 'package:chef_assistant/screens/admin/categories_add.dart';
import 'package:flutter/material.dart';

class AdminCategories extends StatefulWidget {
  const AdminCategories({super.key});

  @override
  State<AdminCategories> createState() => _AdminCategoriesState();
}

class _AdminCategoriesState extends State<AdminCategories> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AddCategories().getCategories();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: PresetColors.black,
      appBar: CustomAppBar(
        title: Text(
          'Categories',
          style: customHeadingStyle(),
        ),
        centerTitle: true,
        backgroundColor: PresetColors.themegreen,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) =>const CategoriesAdd()));
              },
              icon:const Icon(
                Icons.add,
                color: PresetColors.white,
                size: 30,
              )),
         const SizedBox(
            width: 20,
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: categoryNotifier,
        builder: (context, value, child) {
          if (value.isEmpty) {
            return const Center(
              child: Text(
                'No categories found',
                style: TextStyle(color: PresetColors.offwhite),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(40.0),
              child: GridView.builder(
                  itemCount: value.length,
                  gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    final category = value[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return CategoryItems(category: category.name);
                        }));
                      },
                      child: GridTile(
                          child: Stack(
                        children: [
                          Positioned.fill(
                            child: Opacity(
                              opacity: 0.5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: category.image != null
                                    ? Image.memory(
                                        category.image!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        'assets/images/category cooking pot.jpg',
                                        fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  category.name,
                                  style: customCategoryText(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                    );
                  }),
            );
          }
        },
      ),
    );
  }
}