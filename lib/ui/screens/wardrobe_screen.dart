// --- Updated Wardrobe Screen Widget ---
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamourous/controllers/auth_controller.dart';
import 'package:glamourous/controllers/wardrobe_controller.dart';
import 'package:glamourous/models/category.dart';
import 'package:glamourous/routes/app_routes.dart';

class WardrobeScreen extends StatefulWidget {
  const WardrobeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _WardrobeScreenState();
}

class _WardrobeScreenState extends State<WardrobeScreen> {
  final WardrobeController controller = Get.put(WardrobeController());
  final AuthController authController = Get.put(AuthController());
  int selectedIndex = 0;
  final Color accentColor = const Color(0xFF26A69A); // Matching the teal in the image

  // GlobalKey to open the drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Attach the key here
      drawer: _buildDrawer(), // Define the drawer below
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer(); // Opens the menu
          },
        ),
        title: const Text(
          'My Wardrobe',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton(
              onPressed: () => Get.toNamed(Routes.ADD_ITEM),
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.zero,
                minimumSize: const Size(40, 40),
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Tabs
          Container(
            height: 60,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Obx(() => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    Category category = controller.categories[index];
                    return GestureDetector(
                      onTap: () {
                        controller.changeCategory(category);
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? accentColor.withOpacity(0.15)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                              color: selectedIndex == index
                                  ? accentColor
                                  : Colors.transparent,
                              width: 1.0),
                        ),
                        child: Text(
                          category.name,
                          style: TextStyle(
                            color: selectedIndex == index
                                ? accentColor
                                : Colors.grey[700],
                            fontWeight: selectedIndex == index
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    );
                  },
                )),
          ),
          const Divider(height: 1, color: Colors.grey),
          // Wardrobe Items Grid
          Expanded(
            child: Obx(() => GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: controller.wardrobeItems.length,
                  itemBuilder: (context, index) {
                    final item = controller.wardrobeItems[index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.ITEM_DETAILS, arguments: [item]);
                      },
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12.0)),
                                child: Image.network(
                                  item.imageUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image,
                                          size: 50, color: Colors.grey),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800],
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) Get.toNamed(Routes.OUTFITS);
        },
        selectedItemColor: accentColor,
        unselectedItemColor: Colors.grey[600],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.checkroom), label: 'Wardrobe'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_fix_high), label: 'Outfits'),
        ],
      ),
    );
  }

  // --- UI Component for the Menu Drawer ---
  Widget _buildDrawer() {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.75, // Adjust width
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Obx(
        () => Column(
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: accentColor.withOpacity(0.1),
                    child: Icon(Icons.person_outline, color: accentColor, size: 35),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Text(
                      //   'John Doe',
                      //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      // ),
                      Text(
                        authController.currentUser.value?.email ?? '',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(indent: 20, endIndent: 20),
            // Menu Items
            _drawerItem(Icons.person_outline, 'My Profile', () {}),
            _drawerItem(Icons.settings_outlined, 'Settings', () {}),
            _drawerItem(Icons.help_outline, 'Help & Support', () {}),
            const Spacer(), // Pushes Log Out to bottom
            _drawerItem(Icons.door_front_door_outlined, 'Log Out', () {
              authController.signOut();
            }),
            const SizedBox(height: 30),
          ],
        ),
      )
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: accentColor),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
    );
  }

  void _showAddItemMenu(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xFFF5F7F8), // Light grey background
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Wardrobe',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.cancel_outlined, color: accentColor, size: 28),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // 1. Question Card
            _buildMenuCard(
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Text(
                  'What would you like to add?',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // 2. Single Item Card
            GestureDetector(
              onTap: () {
                Get.back(); // Close menu
                Get.toNamed('/addItem'); // Navigate to your add item screen
              },
              child: _buildMenuCard(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.checkroom_outlined, size: 50, color: accentColor),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Single Item', 
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            Text('Add one piece of clothing, shoes, or accessory at a time.',
                              style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 3. Full Closet Card
            _buildMenuCard(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.grid_view_rounded, size: 50, color: accentColor),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Full Closet/Section', 
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('Capture a photo of multiple items, and we\'ll segment them all.',
                              style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  // Helper widget to keep code clean and maintain consistent card styling
  Widget _buildMenuCard({required Widget child}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}