import 'package:bankapp/color/color.dart';
import 'package:bankapp/components/texttypes.dart';
import 'package:bankapp/profile/profile.dart';
import 'package:bankapp/ui/card.dart';
import 'package:bankapp/ui/chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;
  var cards = <Map<String, String>>[
    {'title': 'Balance', 'amount': '\$800.65', 'change': '+\$20.50'},
    {'title': 'Income', 'amount': '\$400.35', 'change': '-\$70.50'},
    {'title': 'Expense', 'amount': '\$950.05', 'change': '+\$50'},
  ].obs;

  void navigateTo(int index) {
    Widget page;
    switch (index) {
      case 0:
        page = HomeView();
        break;
      case 1:
        page = ChartView();
        break;
      case 2:
        page = const CardView();
        break;
      default:
        page = HomeView();
    }
    Get.off(() => page);
  }

  void showAddWidgetDialog(BuildContext context) {
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    final changeController = TextEditingController();

    Get.defaultDialog(
      title: 'Add New Transaction',
      content: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Example: Income",
                style: TextStyles.example,
              )),
          TextField(
            controller: amountController,
            decoration: const InputDecoration(labelText: 'Amount'),
          ),
          TextField(
            controller: changeController,
            decoration: const InputDecoration(labelText: 'Change'),
          ),
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Example: +\$15',
                style: TextStyles.example,
              )),
        ],
      ),
      textCancel: 'Cancel',
      textConfirm: 'Add',
      onCancel: () {},
      onConfirm: () {
        if (titleController.text.isNotEmpty &&
            amountController.text.isNotEmpty &&
            changeController.text.isNotEmpty) {
          final newCard = {
            'title': titleController.text,
            'amount': amountController.text,
            'change': changeController.text,
          };
          cards.add(newCard);
          Get.back();
        }
      },
    );
  }

  var counterValue = 0.obs;
  TextEditingController amountValue = TextEditingController();
  List<Map<String, dynamic>> historyData = [];

  void addValue() {
    counterValue++;
    update();
    print(counterValue);
  }

  void addAmount() {
    print(amountValue.text);
    counterValue.value = counterValue.value + int.parse(amountValue.text);
    Get.snackbar("Amount Status", "Amount Added",
        snackPosition: SnackPosition.TOP);
    historyData.add({"amount": amountValue.text, "type": "Credit"});
    update();
    print(historyData);
  }

  void subAmount() {
    print(amountValue.text);
    counterValue.value = counterValue.value - int.parse(amountValue.text);
    historyData.add({"amount": amountValue.text, "type": "Debit"});
    print(historyData);
    update();
  }
}

class HomeView extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  HomeView({Key? key}) : super(key: key);

  Widget _buildCard(String title, String amount, String change) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_outward_sharp,
                    size: 20,
                    color: AppColors.black,
                  ),
                )),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(amount),
            const SizedBox(height: 5),
            Text(change),
          ],
        ),
      ),
    );
  }

  Widget _buildAddWidgetCard(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => homeController.showAddWidgetDialog(context),
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Icon(Icons.add, size: 30),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Row(
          children: [
            Image.network(
              'https://static.vecteezy.com/system/resources/previews/021/363/337/original/bank-icon-for-your-website-mobile-presentation-and-logo-design-free-vector.jpg',
              height: 60,
            ),
            const SizedBox(width: 10),
            const Text(
              'MY BANK',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.green,
              ),
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: AppColors.green),
                accountName: Text(
                  "Inaaya Saqib",
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: Text("inaayasaqib.46292@gmail.com"),
                currentAccountPictureSize: Size.square(40),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 25, 159, 43),
                  child: Text(
                    "",
                    style: TextStyle(fontSize: 30.0, color: Colors.black),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: AppColors.green),
              title: const Text(' My Profile '),
              onTap: () {
                Get.to(const Profile());
              },
            ),
            ListTile(
              leading: const Icon(Icons.help, color: AppColors.green),
              title: const Text(' Help Center '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: AppColors.green),
              title: const Text(' Pin setting'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.perm_device_information_sharp,
                  color: AppColors.green),
              title: const Text(' Addition Information '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit, color: AppColors.green),
              title: const Text(' Edit Profile '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: AppColors.green),
              title: const Text('LogOut'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: AppColors.green.withOpacity(0.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: Obx(() {
              return GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: AppColors.green,
                color: AppColors.green,
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.bar_chart,
                    text: 'Transfer chart',
                  ),
                  GButton(
                    icon: Icons.credit_card_sharp,
                    text: ' My cards',
                  ),
                ],
                selectedIndex: homeController.selectedIndex.value,
                onTabChange: (index) {
                  homeController.navigateTo(index);
                },
              );
            }),
          ),
        ),
      ),
      backgroundColor: AppColors.white,
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 600,
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Good morning',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Inaaya Saqib',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: homeController.cards.take(2).map((card) {
                            return _buildCard(
                                card['title']!, card['amount']!, card['change']!);
                          }).toList(),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            ...homeController.cards.skip(2).map((card) {
                              return _buildCard(card['title']!, card['amount']!,
                                  card['change']!);
                            }).toList(),
                            _buildAddWidgetCard(context),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            ...homeController.cards.skip(4).map((card) { return _buildAddWidgetCard(context);} ),
                          ],
                        ),
                         const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
