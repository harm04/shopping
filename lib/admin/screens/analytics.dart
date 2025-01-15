
import 'package:flutter/material.dart';
import 'package:krushit_medical/models/sales.dart';
import 'package:krushit_medical/services/admin_service.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;
  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  void getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return 
    earnings == null || totalSales == null
        ? 
        const Center(
            child: CircularProgressIndicator(),
          )
        : 
        Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(62),
                child: AppBar(
                  flexibleSpace: Container(
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Admin',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                )),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Total Earnings: \$${totalSales.toString()}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
  }
}
