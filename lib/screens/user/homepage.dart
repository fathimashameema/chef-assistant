import 'package:carousel_slider/carousel_slider.dart';
import 'package:chef_assistant/customs/colors.dart';
import 'package:chef_assistant/customs/custom_chiplist.dart';
import 'package:chef_assistant/functions/login_status.dart';
import 'package:chef_assistant/customs/list_datas.dart';
import 'package:chef_assistant/screens/user/user_login.dart';
import 'package:chef_assistant/screens/user/user_profile/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isfocused = false;
  String? firstLetter;
  Map<int, bool> isHeartPressed = {};
  Map<int, bool> carousalheart = {};
  bool vegetarian = false;
  bool vegan = false;
  bool allrecipes = true;
  final List<String> filterItems = ['All Recipes', ' Vegetarian', 'Vegan'];
  TextEditingController _searchController = TextEditingController();

  void updateFirstLetter() {
    setState(() {
      if (LoginStatus().currentUser.isNotEmpty) {
        firstLetter = LoginStatus().currentUser[0].toUpperCase();
      } else {
        firstLetter = '';
      }
    });
  }

  @override
  void initState() {
    if (LoginStatus().isLogged) {
      updateFirstLetter();
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _searchController;
    // TODO: implement dispose
    super.dispose();
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
        // bottomNavigationBar:
        //     CustomBottomNavBar(items: navItems, onTap: (index) {}),
        backgroundColor: PresetColors.black,
        appBar: AppBar(
          // centerTitle: true,
          elevation: 0,
          toolbarHeight: 80,
          backgroundColor: PresetColors.themegreen,
          title: Image(
              width: screenWidth * 0.5,
              height: screenHeight * 0.5,
              image: AssetImage(
                  'assets/images/WhatsApp_Image_2024-08-08_at_00.18.03_d74232e0-removebg-preview.png')),
          actions: [
            if (LoginStatus().isLogged)
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (cntx) {
                    return UserProfile();
                  }));
                },
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: PresetColors.yellow,
                  child: Text(
                    firstLetter ?? '',
                    style: TextStyle(color: PresetColors.black),
                  ),
                ),
              )
            else
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => Userlogin()));
                },
                icon: Icon(
                  CupertinoIcons.profile_circled,
                  color: PresetColors.white,
                  size: 30,
                ),
              ),
            SizedBox(
              width: 40,
            )
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Container(
              width: double.infinity,
              height: 100,
              color: PresetColors.themegreen,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _searchController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: PresetColors.nudegrey,
                      hintText: 'Find your items ...',
                      hintStyle: TextStyle(
                        color: isfocused
                            ? PresetColors.fadedgrey
                            : PresetColors.offwhite,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: PresetColors.nudegrey,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: PresetColors.nudegrey,
                          )),
                      prefixIcon: Icon(
                        Icons.search,
                        color: PresetColors.white,
                        size: 20,
                      )),
                  onTap: () {
                    setState(() {
                      isfocused = true;
                    });
                  },
                  onTapOutside: (event) {
                    setState(() {
                      isfocused = false;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomChipList(
              listOfChipNames: filterItems,
            ),
            Padding(
                padding: const EdgeInsets.only(
                  left: 25.0,
                  top: 10,
                ),
                child: Text(
                  'Trending Now...',
                  style: GoogleFonts.ledger(
                      fontSize: 20, color: PresetColors.yellow),
                )),
            Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
              ),
              child: Text('Discover most accepted items',
                  style: GoogleFonts.ledger(
                    fontSize: 10,
                    color: PresetColors.white,
                  )),
            ),
            CarouselSlider(
              items: List.generate(Datas.carousalimages.length, (index) {
                return Builder(builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Card(
                      color: PresetColors.nudegrey,
                      margin: EdgeInsets.only(left: 25),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              Datas.carousalimages[index],
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: 200,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    Datas.carousaltext[index],
                                    style: GoogleFonts.ledger(
                                      fontSize: 20,
                                      color: PresetColors.white,
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        carousalheart[index] =
                                            !(carousalheart[index] ?? false);
                                      });
                                    },
                                    icon: Icon(
                                      CupertinoIcons.heart_fill,
                                      size: 20,
                                      color: (carousalheart[index] ?? false)
                                          ? PresetColors.red
                                          : PresetColors.white,
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              }),
              options: CarouselOptions(
                height: 300,
                autoPlay: true,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                  left: 25.0,
                  top: 10,
                ),
                child: Text(
                  'Recently added',
                  style: GoogleFonts.ledger(
                      fontSize: 20, color: PresetColors.yellow),
                )),
            Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
                bottom: 10,
              ),
              child: Text('Browse newly added items',
                  style: GoogleFonts.ledger(
                    fontSize: 10,
                    color: PresetColors.white,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Container(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: Datas.recentlyadded.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            color: PresetColors.nudegrey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadiusDirectional.vertical(
                                    top: Radius.circular(8)),
                                child: Image.asset(
                                  Datas.recentlyadded[index],
                                  fit: BoxFit.cover,
                                  height: 170,
                                  width: double.infinity,
                                ),
                              ),
                              Positioned(
                                top: 180,
                                left: 10,
                                child: SizedBox(
                                  width: 100,
                                  child: Text(
                                    Datas.recentlyaddedtext[index],
                                    style: GoogleFonts.ledger(
                                      fontSize: 15,
                                      color: PresetColors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        Datas().recentlyaddedcat[index],
                                        style: TextStyle(
                                          color: PresetColors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isHeartPressed[index] =
                                              !(isHeartPressed[index] ?? false);
                                        });
                                      },
                                      icon: Icon(
                                        CupertinoIcons.heart_fill,
                                        size: 15,
                                        color: (isHeartPressed[index] ?? false)
                                            ? PresetColors.red
                                            : PresetColors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    );
                  },
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                  left: 25.0,
                  top: 10,
                ),
                child: Text(
                  "Assistant Chef's Diet plan",
                  style: GoogleFonts.ledger(
                      fontSize: 20, color: PresetColors.yellow),
                )),
            Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
                bottom: 10,
              ),
              child: Text(
                  "Maintain your Health with Assistant Chef's master diet plan",
                  style: GoogleFonts.ledger(
                    fontSize: 10,
                    color: PresetColors.white,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20,
              ),
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: PresetColors.nudegrey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusDirectional.vertical(
                          top: Radius.circular(8)),
                      child: Image.asset(
                        'assets/images/pexels-photo-1640777.jpeg',
                        width: double.infinity,
                        height: 170,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Try our Healthy Diet plan to meet your goals....',
                        style: GoogleFonts.ledger(
                          color: PresetColors.white,
                          fontSize: 17,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                  left: 25.0,
                  top: 10,
                ),
                child: Text(
                  "Kitchen Hacks",
                  style: GoogleFonts.ledger(
                      fontSize: 20, color: PresetColors.yellow),
                )),
            Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
                bottom: 10,
              ),
              child: Text("Hacks to make your kitchen Heaven ",
                  style: GoogleFonts.ledger(
                    fontSize: 10,
                    color: PresetColors.white,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20,
              ),
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: PresetColors.nudegrey,
                  borderRadius: BorderRadiusDirectional.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadiusDirectional.horizontal(
                          start: Radius.circular(8),
                        ),
                        child: Image.asset(
                          'assets/images/pexels-photo-4259140.webp',
                          width: 200,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 150,
                      child: Text(
                        'Top Kitchen hacks you will wish you knew sooner',
                        style: GoogleFonts.ledger(
                            fontSize: 15, color: PresetColors.white),
                      ),
                    ),
                    SizedBox(
                      width: 35,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
