import 'package:amazon_clone/features/admin/add_product_cubit/add_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

BlocProvider<AddProductCubit> showDrop(BuildContext context) {
  final cubit = BlocProvider.of<AddProductCubit>(context);
  return BlocProvider.value(
    value: cubit,
    child: BlocBuilder<AddProductCubit, AddProductState>(
      builder: (BuildContext context, AddProductState state) {
        return DropdownButton<String>(
          value: cubit.category,
          items: cubit.productCategories.map((String e) {
            return DropdownMenuItem<String>(
              value: e,
              child: Text(e),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              cubit.onChangedValue(newValue);
            }
          },
        );
      },
    ),
  );
}