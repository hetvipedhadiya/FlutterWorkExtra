

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extra/models/expens.dart';
import 'package:intl/intl.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense,{super.key});

  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20
        ),
        child: Column
          (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title,style: Theme.of(context).textTheme.titleLarge,),

            const SizedBox(height: 4,),

            Row(
              children: [
                Text('\$${expense.amount.toStringAsFixed(2)}'),

                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    SizedBox(width: 8),
                    Text(expense.formattedDate)
                    

                  ],
                )


              ],
            )
          ],
        )
      ),
    );
  }
}
