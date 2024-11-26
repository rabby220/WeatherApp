import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weather_app/app/controllers/dashBoard_controller.dart';
import 'package:weather_app/app/utils/appColor.dart';

DashBoardController controller = Get.put(DashBoardController());

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        //Search button is here...
        _buildActionButton(
            onPressed: () {
              controller.updateCity(context);
            },
            text: 'Search',
            color: AppColor.blueColor),

        //Cancel Button is here...
        _buildActionButton(
            onPressed: () {
              Navigator.pop(context);
              controller.searchCityController.clear();
            },
            text: 'Cancel',
            color: AppColor.redColor),
      ],
      title: const Text('Search Location'),
      content: TextFormField(
        keyboardType: TextInputType.text,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]*$')),
          LengthLimitingTextInputFormatter(20)
        ],
        controller: controller.searchCityController,
        decoration: const InputDecoration(
          errorBorder: InputBorder.none,
          hintText: "Enter city or location name...",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

Widget _buildActionButton({
  required VoidCallback onPressed,
  required String text,
  required Color color,
}) {
  return MaterialButton(
    onPressed: onPressed,
    color: color,
    child: Text(text),
  );
}
