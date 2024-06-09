import 'package:bankapp/color/color.dart';
import 'package:bankapp/components/textComponents.dart';
import 'package:bankapp/components/texttypes.dart';
import 'package:bankapp/ui/card.dart';
import 'package:bankapp/ui/homeview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ChartViewcontroller extends GetxController {
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
        page =  HomeView();
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
       const  Align(alignment:Alignment.centerLeft, child: Text("Example: Income", style: TextStyles.example,)),
          TextField(
            controller: amountController,
            decoration: const InputDecoration(labelText: 'Amount'),
          ),
          TextField(
            controller: changeController,
            decoration: const InputDecoration(labelText: 'Change'),
          ),
        const Align(alignment:Alignment.centerLeft, child: Text('Example: +\$15', style: TextStyles.example,)),
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

class ChartView extends StatelessWidget {
  ChartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChartViewcontroller chartcontroller = Get.put(ChartViewcontroller());
      final int _selectedIndex = 0;
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
        page =  HomeView();
    }

   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
  }

    print("Calling Build Method");
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            GetBuilder<ChartViewcontroller>(builder: (homeController) {
              return Center(
                  child: TextComponent(
                      textComponentValue: "${homeController.counterValue}"));
            }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildBar(0.3, 'Jan'),
                    _buildBar(0.5, 'Feb'),
                    _buildBar(0.4, 'Mar'),
                    _buildBar(0.5, 'April'),
                    _buildBar(0.3, 'May'),
                    _buildBar(0.2, 'June'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: chartcontroller.amountValue,
                      decoration: InputDecoration(
                        hintText: 'Enter amount',
                        hintStyle: const TextStyle(color: Colors.white54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white24,
                      ),
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                    ),
                    Obx(() => Center(
                            child: TextComponent(
                          textComponentValue: "${chartcontroller.counterValue}",
                        ))),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            chartcontroller.addAmount();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary),
                          child: const Text("Credit", style: TextStyle(color: AppColors.black),),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            chartcontroller.subAmount();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondary),
                          child: const Text("Debit", style: TextStyle(color: AppColors.black),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: GetBuilder<ChartViewcontroller>(builder: (contexta) {
                        return ListView.builder(
                          itemCount: chartcontroller.historyData.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                "${chartcontroller.historyData[index]["amount"]}",
                                style: const TextStyle(color: Colors.white),
                              ),
                              trailing: chartcontroller.historyData[index]["type"] ==
                                      "Debit"
                                  ? const Icon(Icons.arrow_downward_outlined,
                                      color: Colors.red)
                                  : const Icon(Icons.arrow_upward_outlined,
                                      color: Colors.green),
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
              tabBackgroundColor: AppColors.black,
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
              selectedIndex: _selectedIndex,
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

Widget _buildBar(double heightFraction, String label) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 50,
        height: 400 * heightFraction,
        color: AppColors.green,
      ),
      const SizedBox(height: 5),
      Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    ],
  );
}
