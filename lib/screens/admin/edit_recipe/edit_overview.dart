import 'dart:typed_data';
import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/models/recipe_items.dart';
import 'package:chef_assistant/screens/admin/edit_recipe/edit_recipe_values.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditOverview extends StatefulWidget {
  final RecipeItems recipe;
  final int index;

  const EditOverview({
    super.key,
    required this.index,
    required this.recipe,
  });

  @override
  State<EditOverview> createState() => _EditOverviewState();
}

class _EditOverviewState extends State<EditOverview> {
  String? selectedValue;
  final _formkey = GlobalKey<FormState>();
  late TextEditingController descriptionController;
  late TextEditingController prepTimeController;
  late TextEditingController titleController;
  bool? isVeg;
  late RecipeItems recipe;
  // ignore: unused_field
  File? _pickedImage;
  Uint8List? _imageData;

  @override
  void initState() {
    recipe = widget.recipe;
    descriptionController = TextEditingController(text: recipe.description);
    prepTimeController = TextEditingController(text: recipe.prepTime);
    titleController = TextEditingController(text: recipe.title);

    // Set the initial isVeg value based on the recipe data
    isVeg = recipe.isVeg;
    selectedValue = isVeg == true ? 'Vegan' : 'Non-veg';

    _imageData = recipe.image;

    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    prepTimeController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final Uint8List imageData = await image.readAsBytes();
      setState(() {
        _pickedImage = File(image.path);
        _imageData = imageData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: PresetColors.black,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 35.0,
                    top: 40,
                    right: 35,
                    bottom: 10,
                  ),
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: constraints.maxWidth < 600
                          ? screenHeight * 0.27
                          : screenHeight * 0.6,
                      color: PresetColors.offwhite,
                      child: _imageData == null
                          ? const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_outlined,
                                  size: 30,
                                  color: PresetColors.fadedgrey,
                                ),
                                Text(
                                  'Add Image',
                                  style: TextStyle(
                                    color: PresetColors.fadedgrey,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            )
                          : Image.memory(
                              _imageData!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Title field can't be empty";
                            }
                            return null;
                          },
                          controller: titleController,
                          minLines: 1,
                          maxLines: null,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.multiline,
                          decoration: customInputDecoration(
                            hintText: 'Add Title',
                            prefixIcon: const Icon(
                              Icons.add_box_outlined,
                              color: PresetColors.white,
                              size: 28,
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: descriptionController,
                          minLines: 1,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: customInputDecoration(
                            hintText: 'Short Description',
                            prefixIcon: const Icon(
                              Icons.list_alt_outlined,
                              color: PresetColors.white,
                              size: 28,
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: prepTimeController,
                          minLines: 1,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: customInputDecoration(
                            hintText: 'Preparation Time',
                            prefixIcon: const Icon(
                              Icons.access_time_outlined,
                              color: PresetColors.white,
                              size: 28,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        Row(
                          children: [
                            Radio(
                              activeColor: PresetColors.yellow,
                              value: 'Non-veg',
                              groupValue: selectedValue,
                              onChanged: (String? value) {
                                setState(() {
                                  isVeg = false;
                                  selectedValue = value;
                                });
                              },
                            ),
                            const Text(
                              'Non-veg',
                              style: TextStyle(
                                color: PresetColors.white,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.35),
                            Radio(
                              activeColor: PresetColors.yellow,
                              value: 'Vegan',
                              groupValue: selectedValue,
                              onChanged: (String? value) {
                                setState(() {
                                  isVeg = true;
                                  selectedValue = value;
                                });
                              },
                            ),
                            const Text(
                              'Vegan',
                              style: TextStyle(
                                color: PresetColors.white,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: SizedBox(
                    width: constraints.maxWidth < 600
                        ? screenWidth * 0.5
                        : screenWidth * 0.3,
                    child: TextButton(
                      onPressed: () {
                        if (_formkey.currentState != null &&
                            _formkey.currentState!.validate()) {
                          if (selectedValue == null) {
                            showDialog(
                              context: context,
                              builder: (ctx) {
                                return customAlertDialogue(
                                  content: const Text(
                                      "Please select if Vegan or Non-veg"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'ok',
                                        style: TextStyle(
                                          color: PresetColors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            EditRecipeValues.obj.descrption =
                                descriptionController.text;
                            EditRecipeValues.obj.prepTime =
                                prepTimeController.text;
                            EditRecipeValues.obj.title = titleController.text;
                            EditRecipeValues.obj.isVeg = isVeg;

                            // Only set the image if one was picked or if the existing one is not null
                            if (_imageData != null) {
                              EditRecipeValues.obj.image = _imageData;
                            }

                            // Clear the fields after editing
                            descriptionController.clear();
                            titleController.clear();
                            prepTimeController.clear();
                            DefaultTabController.of(context).animateTo(1,
                                duration: const Duration(milliseconds: 700));
                          }
                        }
                      },
                      style: saveButtonStyle(),
                      child: Text(
                        'Edit Recipe',
                        style: saveButtonText(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: constraints.maxWidth < 600
                      ? screenHeight * 0.1
                      : screenHeight * 0.2,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
