import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../add_product_cubit/add_product_cubit.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  late AddProductCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<AddProductCubit>(context);
    _cubit.getEarnings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddProductCubit, AddProductState>(
        builder: (context, state) {
          if (state is EarningsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EarningsLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: BarChart(BarChartData(
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(toY: _cubit.earnings.mobileEarnings ?? 0, color: Colors.blue),
                    ],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(toY: _cubit.earnings.essentials ?? 0, color: Colors.green),
                    ],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(toY: _cubit.earnings.appliances ?? 0, color: Colors.red),
                    ],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [
                      BarChartRodData(toY: _cubit.earnings.booksEarnings ?? 0, color: Colors.yellow),
                    ],
                  ),
                  BarChartGroupData(
                    x: 4,
                    barRods: [
                      BarChartRodData(toY: _cubit.earnings.fashionEarnings ?? 0, color: Colors.orange),
                    ],
                  ),
                ],
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: true),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true, reservedSize: 38, getTitlesWidget: (value, meta) {
                      switch (value.toInt()) {
                        case 0:
                          return const Text('Mobiles');
                        case 1:
                          return const Text('Essentials');
                        case 2:
                          return const Text('Appliances');
                        case 3:
                          return const Text('Books');
                        case 4:
                          return const Text('Fashion');
                        default:
                          return const Text('');
                      }
                    }),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                ),
                gridData: const FlGridData(show: true),
                barTouchData: BarTouchData(enabled: true),
              )),
            );
          } else {
            return const Center(child: Text('Error loading earnings data'));
          }
        },
      ),
    );
  }
}