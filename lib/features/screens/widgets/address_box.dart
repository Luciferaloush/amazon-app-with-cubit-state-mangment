import 'package:amazon_clone/helper/cache_helper.dart';
import 'package:flutter/material.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 114, 226, 221),
          Color.fromARGB(255, 162, 236, 233)
        ], stops: [
          0.5,
          1.0
        ]),
      ),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                "Delevery ${CacheHelper.getData(key: "name")}",
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 5, top: 2),
            child: Icon(Icons.arrow_drop_down_outlined),
          )
        ],
      ),
    );
  }
}
