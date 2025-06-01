import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extra/chart.dart';
import 'package:flutter_extra/expenses_list.dart';
import 'package:flutter_extra/models/expens.dart';
import 'package:flutter_extra/new_expenses.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});



  @override
  State<Expenses> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expenses> {
  final List<Expense> _ragisteredExpenses = [
    Expense(title: 'Flutter Course', amount: 12.22, date: DateTime.now(), category: Category.work),
    Expense(title: 'Chinema', amount: 12.22, date: DateTime.now(), category: Category.leisure)
  ];

  void addExpense(Expense expense){
  setState(() {
    _ragisteredExpenses.add(expense);
  });
  }

  void removeExpense(Expense expense){
    final expenseIndex = _ragisteredExpenses.indexOf(expense);

    setState(() {
      _ragisteredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text("Expanse Deleted"),
        action: SnackBarAction(label: 'Undo', onPressed: (){
          setState(() {
            _ragisteredExpenses.insert(expenseIndex, expense);
          });
        }),
      ),);
  }
  @override
  Widget build(BuildContext context) {
   // MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
    Widget mainContent =  Center(child: Text("No Expense Found Start Adding Now!!!"),);

    if(_ragisteredExpenses.isNotEmpty){
       mainContent =  ExpensesList(
        expenses: _ragisteredExpenses,onRemoveExpense: removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Expenses Tracker"),
        actions: [
          IconButton(onPressed: (){
            showModalBottomSheet(
              useSafeArea: true,
              isScrollControlled: true,
              context: context, builder: (ctx) =>
              NewExpense(onAddExpense: addExpense,),
            );
          }, icon: Icon(Icons.add))
        ],
      ),
      body: width < 600 ? Column(
        children: [
          Chart(expenses: _ragisteredExpenses
          ),
          Expanded(child: mainContent

          )
        ],
      ) : Row(
        children: [
          Expanded(
            child: Chart(expenses: _ragisteredExpenses
            ),
          ),
          Expanded(child: mainContent

          )
        ],
      ),
    );
  }
}
