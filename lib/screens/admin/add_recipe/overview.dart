import 'dart:io';

import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_styles.dart';
import 'package:chef_assistant/screens/admin/add_recipe/recipe_values.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Overview extends StatefulWidget {
  const Overview({
    super.key,
  });

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  String? selectedValue;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController prepTimeController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  File? _pickedImage;
  bool? isVeg;
  @override
  void initState() {
    setState(() {
      selectedValue = null;
    });
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    prepTimeController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final Uint8List imageData = await image.readAsBytes();
      setState(() {
        _pickedImage = File(image.path);
        RecipeValues.obj.image = imageData;
      });
      print(RecipeValues.obj.image);
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
                    onTap: pickImage,
                    child: Container(
                      height: constraints.maxWidth < 600
                          ? screenHeight * 0.27
                          : screenHeight * 0.6,
                      color: PresetColors.offwhite,
                      child: _pickedImage == null
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
                                )
                              ],
                            )
                          : kIsWeb
                              ? Image.memory(
                                  RecipeValues.obj.image!,
                                  fit: BoxFit.fill,
                                )
                              : Image.file(
                                  _pickedImage!,
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
                              )),
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
                              )),
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
                              )),
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
                                  color: PresetColors.white, fontSize: 15),
                            ),
                            SizedBox(
                              width: screenWidth * 0.35,
                            ),
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
                                  color: PresetColors.white, fontSize: 15),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
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
                                  // title: Text('Incorrect information'),
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
                            RecipeValues.obj.description =
                                descriptionController.text;
                            RecipeValues.obj.prepTime = prepTimeController.text;
                            RecipeValues.obj.title = titleController.text;
                            RecipeValues.obj.isVeg = isVeg;
                            print(RecipeValues.obj.description);
                            descriptionController.clear();
                            titleController.clear();
                            prepTimeController.clear();
                            DefaultTabController.of(context).animateTo(
                                duration: const Duration(milliseconds: 700), 1);
                          }
                        }
                      },
                      style: saveButtonStyle(),
                      child: Text(
                        'Save Recipe',
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
