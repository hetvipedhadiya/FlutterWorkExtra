import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_extra/models/expens.dart';

final formater = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titlecontroller.dispose();
    _amountcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyBoardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx,constraint){
      final width = constraint.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16,16,16,keyBoardSpace + 16),
            child: Column(
              children: [
                if(width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _titlecontroller,
                          maxLength: 50,
                          decoration: InputDecoration(
                            label: Text("title")
                          ),
                        ),
                      ),
                      SizedBox(width: 24,),
                      Expanded(
                        child: TextFormField(
                          controller: _amountcontroller,
                          keyboardType: TextInputType.number,
                          decoration:
                          InputDecoration(prefixText: '\$', label: Text("Amount")),
                        ),
                      ),
                    ],
                  )
                else
                    TextFormField(
                    controller: _titlecontroller,
                    maxLength: 50,
                    decoration: InputDecoration(
                    label: Text("title")
                ),
                ),

                if(width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                              ),
                            ),
                          )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value!;
                            });
                          }),
                      SizedBox(width: 24,),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(_selectedDate == null
                                ? 'No Selected'
                                : formater.format(_selectedDate!)),
                            IconButton(
                              onPressed: () async {
                                final firstDate = DateTime(DateTime.now().year - 1,
                                    DateTime.now().month, DateTime.now().day);
                                final pickedDate = await showDatePicker(
                                    context: context,
                                    firstDate: firstDate,
                                    lastDate: DateTime.now());
                                setState(() {
                                  _selectedDate = pickedDate;
                                });
                              },
                              icon: Icon(Icons.calendar_month),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                else
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _amountcontroller,
                        keyboardType: TextInputType.number,
                        decoration:
                        InputDecoration(prefixText: '\$', label: Text("Amount")),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_selectedDate == null
                              ? 'No Selected'
                              : formater.format(_selectedDate!)),
                          IconButton(
                            onPressed: () async {
                              final firstDate = DateTime(DateTime.now().year - 1,
                                  DateTime.now().month, DateTime.now().day);
                              final pickedDate = await showDatePicker(
                                  context: context,
                                  firstDate: firstDate,
                                  lastDate: DateTime.now());
                              setState(() {
                                _selectedDate = pickedDate;
                              });
                            },
                            icon: Icon(Icons.calendar_month),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                if(width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel")),
                      ElevatedButton(
                          onPressed: () {
                            final enteredAmount =
                            double.tryParse(_amountcontroller.text);
                            final isAmountValid =
                                enteredAmount == null || enteredAmount <= 0;
                            if (_titlecontroller.text.trim().isEmpty ||
                                isAmountValid ||
                                _selectedDate == null) {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Text("Invelid Input"),
                                  content: Text(
                                      "Please enter velid title , amount , date and category"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Okey"))
                                  ],
                                ),
                              );
                              return;
                            }
                            widget.onAddExpense(
                              Expense(
                                  title: _titlecontroller.text,
                                  amount: enteredAmount,
                                  date: _selectedDate!,
                                  category: _selectedCategory),
                            );
                            Navigator.pop(context);
                            // print(_titlecontroller.text);
                            // print(_amountcontroller.text);
                          },
                          child: Text("Save Expenses"))
                    ],
                  )
                else
                Row(
                  children: [
                    DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                            ),
                          ),
                        )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                        }),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel")),
                    ElevatedButton(
                        onPressed: () {
                          final enteredAmount =
                          double.tryParse(_amountcontroller.text);
                          final isAmountValid =
                              enteredAmount == null || enteredAmount <= 0;
                          if (_titlecontroller.text.trim().isEmpty ||
                              isAmountValid ||
                              _selectedDate == null) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text("Invelid Input"),
                                content: Text(
                                    "Please enter velid title , amount , date and category"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Okey"))
                                ],
                              ),
                            );
                            return;
                          }
                          widget.onAddExpense(
                            Expense(
                                title: _titlecontroller.text,
                                amount: enteredAmount,
                                date: _selectedDate!,
                                category: _selectedCategory),
                          );
                          Navigator.pop(context);
                          // print(_titlecontroller.text);
                          // print(_amountcontroller.text);
                        },
                        child: Text("Save Expenses"))
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });

  }
}
