import 'package:flod/widget/form_input_field.dart';
import 'package:flutter/material.dart';

class Item {
  String name;
  double price;
  Item({required this.name, required this.price});
}

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Item> items = [];
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _itemController;
  late TextEditingController _priceController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _itemController = TextEditingController();
    _priceController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FormInputField(
                      itemController: _itemController,
                      hintText: 'Item',
                      ValidateMessage: 'please provide the item name',
                      KeyboardType: TextInputType.text),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: FormInputField(
                          itemController: _priceController,
                          hintText: 'Price',
                          ValidateMessage: 'please provide the item price',
                          KeyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                        ),
                      ),
                      IconButton(
                        alignment: Alignment.topRight,
                        icon: Icon(
                          Icons.subdirectory_arrow_left,
                          size: 40,
                          textDirection: TextDirection.rtl,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            items.add(Item(
                              name: _itemController.text,
                              price: double.parse(_priceController.text),
                            ));
                            setState(() {
                              _itemController.clear();
                              _priceController.clear();
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    child: Expanded(
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('Item')),
                          DataColumn(label: Text('price'))
                        ],
                        rows: [
                          ...items.map(
                            (element) => DataRow(
                              cells: [
                                DataCell(Text(element.name)),
                                DataCell(Text(element.price.toString()))
                              ],
                            ),
                          ),
                          DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  'Total price',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataCell(Text(items
                                  .fold<double>(
                                      0, (prev, price) => prev + price.price)
                                  .toString())),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _itemController.dispose();
    _priceController.dispose();
  }
}
