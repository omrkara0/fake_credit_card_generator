import 'package:fake_credit_card_generator/controller/mycontroller.dart';
import 'package:fake_credit_card_generator/model/CardModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final controller = Get.put(MyController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Fake Credit Card Generator",
                style: GoogleFonts.robotoSlab(fontSize: 50),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              Form(
                key: _formKey,
                child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter card';
                    }
                    return null;
                  },
                  isExpanded: true,
                  iconSize: 25,
                  icon: Icon(
                    Icons.arrow_drop_down_circle_outlined,
                    color: Colors.grey,
                  ),
                  value: controller.dropdownValue.value,
                  items: controller.items
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  hint: Text("Select card type"),
                  onChanged: (String? newValue) {
                    controller.dropdownValue.value = newValue;
                  },
                )),
              ),
              Spacer(),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await controller.getData();
                    } else {}
                  },
                  child: Text("Generate"),
                ),
              ),
              Expanded(
                flex: 4,
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.cards.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SelectableText(
                              controller.cards[index].card ?? "",
                              style: GoogleFonts.lato(fontSize: 18),
                            ),
                            SelectableText(
                              controller.cards[index].number ?? "",
                              style: GoogleFonts.lato(fontSize: 18),
                            ),
                          ],
                        ),
                      );
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
