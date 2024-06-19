import 'package:flutter/material.dart';


///<<<<----------------- First posioned set ----------------->>>.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController amountController = TextEditingController();
  int totalAmount = 0;
  Map<int, int> dominateAmount = {};
  List<Map<String, dynamic>> transactions = [];

  void totalAmountMethod(String value) {
    setState(() {
      totalAmount = int.tryParse(value) ?? 0;
    });
  }

  void withdrawCalculation(int amount) {
    // Your logic for withdrawal calculation
  }

  void addTransaction() {
    setState(() {
      transactions.insert(0, {
        'totalAmount': totalAmount,
        'denominations': Map<int, int>.from(dominateAmount)
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'ATM',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: SafeArea(
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
                    children: [
                      Column(
                        children: [
                          const Text('ATM Amount'),
                          Text("$totalAmount"),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          const Text('R100'),
                          Text("${dominateAmount[100] ?? 0}"),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          const Text('R200'),
                          Text("${dominateAmount[200] ?? 0}"),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          const Text('R500'),
                          Text("${dominateAmount[500] ?? 0}"),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          const Text('R10'),
                          Text("${dominateAmount[10] ?? 0}"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter Amount',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onChanged: (value) {
                  totalAmountMethod(value);
                  withdrawCalculation(totalAmount);
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: addTransaction,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                      child: Text(
                        'Withdraw',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Latest Transaction'),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          const Text('ATM Amount'),
                          Text("$totalAmount"),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          const Text('R100'),
                          Text("${dominateAmount[100] ?? 0}"),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          const Text('R200'),
                          Text("${dominateAmount[200] ?? 0}"),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          const Text('R500'),
                          Text("${dominateAmount[500] ?? 0}"),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          const Text('R10'),
                          Text("${dominateAmount[10] ?? 0}"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Your Transactions'),
              const SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: Card(
                  child: ListView.builder(
                    itemCount: transactions.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('ATM Amount'),
                            Text('R100'),
                            Text('R200'),
                            Text('R500'),
                            Text('R10'),
                          ],
                        );
                      } else {
                        final record = transactions[index - 1];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${record['totalAmount']}'),
                              Text('${record['denominations'][100] ?? 0}'),
                              Text('${record['denominations'][200] ?? 0}'),
                              Text('${record['denominations'][500] ?? 0}'),
                              Text('${record['denominations'][10] ?? 0}'),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
