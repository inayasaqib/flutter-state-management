import 'package:bankapp/color/color.dart';
import 'package:bankapp/ui/chart.dart';
import 'package:bankapp/ui/homeview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CardView extends StatelessWidget {
  const CardView({super.key});

  @override
  Widget build(BuildContext context) {
    final CardController controller = Get.put(CardController());
    const int selectedIndex = 2;

    void _navigateTo(int index) {
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

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => page));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'My Cards',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Here are your available cards:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: BankCard(
                    cardHolder: 'Inaaya',
                    cardNumber: '1234 5678 9012 3456',
                    validThru: '12/24',
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: BankCard(
                    cardHolder: 'Inaaya',
                    cardNumber: '2345 6789 0123 4567',
                    validThru: '11/25',
                    color: AppColors.green,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            child: Text(
              'Transactions',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Enter Title',
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: controller.priceController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Enter Price',
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: controller.addText,
                  child: const Text('Submit Entry'),
                ),
              ],
            ),
          ),
          Obx(() {
            return SingleChildScrollView(
              child: Column(
                children: controller.historyData.map((data) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 4.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(2, 2),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.receipt,
                                size: 15, color: Colors.black54),
                            const SizedBox(width: 10),
                            Text(
                              data['name']!,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          data['price']!,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          }),
          const Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  InfoCard(
                    title: 'Bill',
                    icon: Icons.monetization_on_sharp,
                    price: '\$120.00',
                  ),
                  InfoCard(
                    title: 'Shopping',
                    icon: Icons.monetization_on_sharp,
                    price: '\$80.00',
                  ),
                  InfoCard(
                    title: 'Monthly Fee',
                    icon: Icons.monetization_on_sharp,
                    price: '\$60.00',
                  ),
                  InfoCard(
                    title: 'Pay Contact',
                    icon: Icons.monetization_on_sharp,
                    price: '\$40.00',
                  ),
                  InfoCard(
                    title: 'Education',
                    icon: Icons.monetization_on_sharp,
                    price: '\$93.40',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.green,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(0.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.black,
              color: Colors.black,
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
              selectedIndex: selectedIndex,
              onTabChange: (index) {
                _navigateTo(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class BankCard extends StatelessWidget {
  final String cardHolder;
  final String cardNumber;
  final String validThru;
  final Color color;

  const BankCard({
    super.key,
    required this.cardHolder,
    required this.cardNumber,
    required this.validThru,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      height: 150,
      width: 300,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(2, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              cardHolder,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              cardNumber,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'VALID THRU',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      validThru,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.credit_card,
                  color: Colors.white70,
                  size: 24,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String price;

  const InfoCard({
    super.key,
    required this.title,
    required this.icon,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(2, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 24, color: Colors.black54),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          Text(
            price,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class CardController extends GetxController {
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var historyData = [].obs;

  void addText() {
    String nameValue = nameController.text;
    String priceValue = priceController.text;
    if (nameValue.isNotEmpty && priceValue.isNotEmpty) {
      Get.snackbar("Text Status", "Entry Submitted",
          snackPosition: SnackPosition.TOP);
      historyData.add({"Icon":const Icon(Icons.monetization_on_rounded),"name": nameValue, "price": priceValue});
      nameController.clear();
      priceController.clear();
    } else {
      Get.snackbar("Error", "Name and price cannot be empty",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    }
  }
}
