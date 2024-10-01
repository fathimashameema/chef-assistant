import 'dart:io';

import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_appbar.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/db_functions/add_categories.dart';
import 'package:chef_assistant/models/categories_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CategoriesAdd extends StatefulWidget {
  const CategoriesAdd({super.key});

  @override
  State<CategoriesAdd> createState() => _CategoriesAddState();
}

ValueNotifier<List<CategoriesModel>> categoryNotifier = ValueNotifier([]);

class _CategoriesAddState extends State<CategoriesAdd> {
  final _formKey = GlobalKey<FormState>();
  final _editFormkey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _editTitleController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _editTitleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          right: screenWidth * 0.39,
        ),
        child: IconButton(
          onPressed: () {
            addCategory();
          },
          icon: const Icon(
            Icons.add_circle_outline_rounded,
            color: PresetColors.white,
            size: 40,
          ),
        ),
      ),
      backgroundColor: PresetColors.black,
      appBar: CustomAppBar(
        // automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: Navigator.of(context).pop,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: customArrowBack(),
          ),
        ),
        title: Text(
          'Categories',
          style: customHeadingStyle(),
        ),
        centerTitle: true,
        backgroundColor: PresetColors.themegreen,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ValueListenableBuilder(
            valueListenable: categoryNotifier,
            builder: (context, value, child) {
              if (value.isEmpty) {
                return const Center(
                  child: Text('No categories added'),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: GridView.builder(
                      itemCount: value.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: constraints.maxWidth < 600 ? 2 : 4,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 30,
                        childAspectRatio:
                            constraints.maxWidth < 600 ? 0.7 : 0.8,
                      ),
                      itemBuilder: (context, index) {
                        final category = value[index];
                        return GridTile(
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
                            Positioned(
                              bottom: 5,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      editCategory(index);
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: PresetColors.offwhite,
                                      size: 18,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 40,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        deleteCategory(index);
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: PresetColors.offwhite,
                                      size: 18,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ));
                      }),
                );
              }
            },
          );
        },
      ),
    );
  }

  Future<void> deleteCategory(int index) async {
    await showDialog(
        context: context,
        builder: (ctx) {
          return customAlertDialogue(
            title: const Text('Delete category'),
            content:
                const Text('Are you sure you want to delete this Category?'),
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
                onPressed: () {
                  AddCategories().deleteCategory(index);
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

  Future<void> addCategory() async {
    File? pickedImage;
    Uint8List? imageData;

    return await showDialog(
      context: context,
      builder: (ctxt) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: PresetColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: GestureDetector(
                onTap: () async {
                  final ImagePicker imagePicker = ImagePicker();
                  final XFile? image =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    imageData = await image.readAsBytes();
                    setState(() {
                      pickedImage = File(image.path);
                    });
                  }
                },
                child: Container(
                  color: PresetColors.offwhite,
                  height: 230,
                  child: pickedImage == null
                      ? const Icon(Icons.image)
                      : kIsWeb
                          ? Image.memory(
                              imageData!,
                              fit: BoxFit.fill,
                            )
                          : Image.file(
                              pickedImage!,
                              fit: BoxFit.cover,
                            ),
                ),
              ),
              content: Form(
                key: _formKey,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Title field can't be empty";
                    } else {
                      return null;
                    }
                  },
                  style: const TextStyle(color: PresetColors.black),
                  controller: _titleController,
                  cursorColor: PresetColors.nudegrey,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      color: PresetColors.fadedgrey,
                      fontSize: 18,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: PresetColors.black,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: PresetColors.fadedgrey,
                      ),
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState != null &&
                        _formKey.currentState!.validate()) {
                      final category = CategoriesModel(
                        name: _titleController.text,
                        image: imageData,
                      );

                      if (await AddCategories().isItemExist(category)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Category already exist'),
                          ),
                        );
                        Navigator.of(context).pop();
                      } else {
                        AddCategories().addCategories(category: category);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }
                    }
                  },
                  child: Text(
                    'ok',
                    style: customButtonText(),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  Future<void> editCategory(int index) async {
    // ignore: unused_local_variable
    File? pickedImage;
    Uint8List? imageData = categoryNotifier.value[index].image;
    final category = categoryNotifier.value[index].name;
    _editTitleController.text = category;

    return await showDialog(
      context: context,
      builder: (ctxt) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: PresetColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: GestureDetector(
                onTap: () async {
                  final ImagePicker imagePicker = ImagePicker();
                  final XFile? image =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    imageData = await image.readAsBytes();
                    setState(() {
                      pickedImage = File(image.path);
                    });
                  }
                },
                child: Container(
                  color: PresetColors.offwhite,
                  height: 260,
                  child: Image.memory(
                    imageData!,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              content: Form(
                key: _editFormkey,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Title field can't be empty";
                    } else {
                      return null;
                    }
                  },
                  style: const TextStyle(color: PresetColors.black),
                  controller: _editTitleController,
                  cursorColor: PresetColors.nudegrey,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      color: PresetColors.fadedgrey,
                      fontSize: 18,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: PresetColors.black,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: PresetColors.fadedgrey,
                      ),
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    if (_editFormkey.currentState != null &&
                        _editFormkey.currentState!.validate()) {
                      final category = CategoriesModel(
                        name: _editTitleController.text,
                        image: imageData ?? categoryNotifier.value[index].image,
                      );
                      AddCategories()
                          .editCtegory(category: category, index: index);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    'ok',
                    style: customButtonText(),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}
