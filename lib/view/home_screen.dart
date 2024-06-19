import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app_srk/common/app_strings.dart';
import 'package:task_app_srk/view/home_controller.dart';
import 'package:task_app_srk/view/practice_view_local/practice_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = Get.put<HomeController>(HomeController());

  @override
  void initState() {
    homeController.getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          AppStrings.atm,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(const PracticeScreen());
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      body: GetBuilder(
        init: HomeController(),
        builder: (controller) => SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(AppStrings.atmAmount),
                          Text("${controller.totalAmount}"),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          const Text(AppStrings.ruppesFirst),
                          Text("${controller.dominateAmount['100'] ?? 0}"),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          const Text(AppStrings.ruppesSecond),
                          Text("${controller.dominateAmount['200'] ?? 0}"),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          const Text(AppStrings.ruppesThird),
                          Text("${controller.dominateAmount['500'] ?? 0}"),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          const Text(AppStrings.ruppesFor),
                          Text("${controller.dominateAmount['10'] ?? 0}"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.amount,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  labelText: AppStrings.enterAmount,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onChanged: (value) {
                  controller.totalAmountMethod(value);
                  controller.withdrawCalculation(controller.totalAmount);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  if (controller.amount.text.isEmpty) {
                    Get.snackbar('Fille',
                        "Please enter data other  wise not withdraw amiount");
                  } else {
                    controller.dominateListDateShowMethod();
                    controller.saveDataList();
                  }
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                      child: Text(
                    AppStrings.withdraw,
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(AppStrings.latestTransaction),
              const SizedBox(
                height: 10,
              ),
              Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(AppStrings.atmAmount),
                          Text(controller.dataList.isNotEmpty
                              ? "${controller.dataList[0]['totalAmount'] ?? 0}"
                              : 'Lod..'),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          const Text(AppStrings.ruppesFirst),
                          Text(controller.dataList.isNotEmpty
                              ? "${controller.dataList[0]['dominations']['100'] ?? 0}"
                              : "Load.."),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          const Text(AppStrings.ruppesSecond),
                          Text(controller.dataList.isNotEmpty
                              ? "${controller.dataList[0]['dominations']['200'] ?? 0}"
                              : "Load.."),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          const Text(AppStrings.ruppesThird),
                          Text(controller.dataList.isNotEmpty
                              ? "${controller.dataList[0]['dominations']['500'] ?? 0}"
                              : "Load.."),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          const Text(AppStrings.ruppesFor),
                          Text(controller.dataList.isNotEmpty
                              ? "${controller.dataList[0]['dominations']['10'] ?? 0}"
                              : "Load.."),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              controller.dataList.isNotEmpty
                  ? const Text(AppStrings.yourTransaction)
                  : const SizedBox(),
              const SizedBox(
                height: 10,
              ),
              controller.dataList.isNotEmpty
                  ? SizedBox(
                      height: 200,
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      child: Text(
                                    AppStrings.atmAmount,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                                  Text(
                                    AppStrings.ruppesFirst,
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    AppStrings.ruppesSecond,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    AppStrings.ruppesThird,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    AppStrings.ruppesFor,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.dataList.length,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  itemBuilder: (context, index) {
                                    final record = controller.dataList[index];

                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 70,
                                            child: Text(
                                              "Rs ${formatIndianCurrency(record['totalAmount'])}",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          const Spacer(),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: formatIndianCurrency(record[
                                                                'totalAmount'])
                                                            .length >=
                                                        5
                                                    ? 8
                                                    : 0),
                                            child: Text(
                                              formatIndianCurrency(
                                                  record['dominations']
                                                          ['100'] ??
                                                      0),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          const Spacer(),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: formatIndianCurrency(record[
                                                                'totalAmount'])
                                                            .length >=
                                                        5
                                                    ? 8
                                                    : 0),
                                            child: Text(
                                              formatIndianCurrency(
                                                  record['dominations']
                                                          ['200'] ??
                                                      0),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          const Spacer(),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: formatIndianCurrency(record[
                                                                'totalAmount'])
                                                            .length >=
                                                        5
                                                    ? 8
                                                    : 0),
                                            child: Text(
                                              formatIndianCurrency(
                                                  record['dominations']
                                                          ['500'] ??
                                                      0),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(formatIndianCurrency(
                                              record['dominations']['10'] ??
                                                  0)),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        )),
      ),
    );
  }

  String formatIndianCurrency(int amount) {
    if (amount >= 10000000) {
      return '${(amount / 10000000).toStringAsFixed(2)} Cr';
    } else if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(2)} Lakh';
    } else {
      return '$amount';
    }
  }
}
