import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/functions/add_item.dart';
import 'package:chef_assistant/models/recipe_items.dart';
import 'package:chef_assistant/screens/admin/recipe_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:chef_assistant/models/user_items.dart';
import 'package:chef_assistant/functions/user_add_items.dart';

class AdminNotifications extends StatefulWidget {
  const AdminNotifications({super.key});

  @override
  State<AdminNotifications> createState() => _AdminNotificationsState();
}

class _AdminNotificationsState extends State<AdminNotifications> {
  late UserAddItems _userAddItems;

  @override
  void initState() {
    _userAddItems = UserAddItems();
    super.initState();
    _userAddItems.openUserItemBox();
  }

  @override
  void dispose() {
    _userAddItems.closeUserItemBox();
    super.dispose();
  }

  Future<void> deleteItem(int index) async {
    await showDialog(
        context: context,
        builder: (ctx) {
          return customAlertDialogue(
            title: const Text('Delete Item'),
            content: const Text('Are you sure you want to delete this item ?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: PresetColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await _userAddItems.deleteUserItems(index);

                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    color: PresetColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<void> approveRecipe(RecipeItems recipe, int index) async {
    await showDialog(
        context: context,
        builder: (ctx) {
          return customAlertDialogue(
            title: const Text('Add recipe'),
            content:
                const Text('Are you sure you want to add this recipe to the list?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: PresetColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await AddItem().addRecipe(recipe);
                  await _userAddItems.deleteUserItems(index);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    color: PresetColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: PresetColors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                'Notifications',
                style: homeHeadingStyle(),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _userAddItems.userItemNotifier,
                // valueListenable: Hive.box<UserItems>('userItems').listenable(),
                builder: (context, items, child) {
                  if (items.isEmpty) {
                    return const Center(
                      child: Text(
                        'No notifications yet',
                        style: TextStyle(
                            color: PresetColors.offwhite, fontSize: 16),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        UserItems recipe = items[index];
                        RecipeItems userRecipe = RecipeItems(
                          isVeg: recipe.isVeg,
                          title: recipe.title,
                          description: recipe.description,
                          prepTime: recipe.prepTime,
                          ingredients: recipe.ingredients,
                          directions: recipe.directions,
                          image: recipe.image,
                          categories: recipe.categories,
                        );

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return RecipeDetailPage(recipe: userRecipe);
                              }));
                            },
                            child: Card(
                              elevation: 8,
                              shadowColor: PresetColors.offwhite,
                              color: PresetColors.nudegrey,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0),
                                    ),
                                    child: SizedBox(
                                      height: screenHeight * 0.13,
                                      width: screenWidth * 0.4,
                                      child: recipe.image != null
                                          ? Image.memory(
                                              recipe.image!,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              'assets/images/default_food.jpg',
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: SizedBox(
                                      height: screenHeight * 0.09,
                                      width: screenWidth * 0.27,
                                      child: Text(
                                        recipe.title ?? 'Untitled',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        iconSize: 20,
                                        onPressed: () {
                                          approveRecipe(userRecipe, index);
                                        },
                                        icon: const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          deleteItem(index);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
