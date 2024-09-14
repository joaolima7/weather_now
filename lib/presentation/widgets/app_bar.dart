import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../core/utils/conts.dart';
import '../components/search_bar_animated.dart';
import '../controllers/get_controller.dart';

class AppBarApp extends StatelessWidget {
  final _controller = GetIt.I<GetWeatherController>();

  @override
  Widget build(BuildContext context) {
    var _sizeWidth = MediaQuery.of(context).size.width;
    return AppBar(
      backgroundColor: const Color(0xFF000428),
      title: Obx(() => Row(
            children: [
              if (!_controller.isSearching.value)
                PopupMenuButton<String>(
                  onSelected: (String value) {
                    _controller.getWeatherByCityName(value);
                  },
                  itemBuilder: (BuildContext context) {
                    return savedCities.map((String city) {
                      return PopupMenuItem<String>(
                        value: city,
                        child: Text(city),
                      );
                    }).toList();
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _controller.weatherInfo.value.name,
                        style: TextStyle(
                          fontSize: _sizeWidth * .05,
                          color: Colors.white,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
            ],
          )),
      actions: [
        SearchAnimated(
          controller: _controller.txtController,
          onSuffixTap: _controller.suffixTapSearch,
          onSubmitted: (query) =>
              _controller.submitTapSearch(query), // Passa o query para a função
        ),
      ],
    );
  }
}
