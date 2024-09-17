import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../core/utils/conts.dart';
import '../components/search_bar_animated.dart';
import '../controllers/controller_api.dart';

class AppBarApp extends StatelessWidget {
  final _controller = GetIt.I<GetWeatherApiController>();

  @override
  Widget build(BuildContext context) {
    var _sizeWidth = MediaQuery.of(context).size.width;
    return AppBar(
      backgroundColor: const Color(0xFF000428),
      title: Obx(() => Row(
            children: [
              if (!_controller.isSearching.value)
                GestureDetector(
                  onTap: () => _showLocationOptions(context),
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
          onSubmitted: (query) => _controller.submitTapSearch(query),
        ),
      ],
    );
  }

  void _showLocationOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF000428),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true, // Permite ajustar a altura do BottomSheet
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.4,
          maxChildSize: 0.4,
          minChildSize: 0.2,
          expand: false,
          builder: (context, scrollController) {
            return SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF000428),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      ListTile(
                        leading:
                            const Icon(Icons.my_location, color: Colors.white),
                        title: const Text('Localização Atual',
                            style: TextStyle(color: Colors.white)),
                        onTap: () {
                          Navigator.pop(context);
                          _controller.getWeatherByLocation();
                        },
                      ),
                      const Divider(color: Colors.white24),
                      ...savedCities.map((String city) {
                        return ListTile(
                          leading: const Icon(Icons.location_city,
                              color: Colors.white),
                          title: Text(city,
                              style: const TextStyle(color: Colors.white)),
                          onTap: () {
                            Navigator.pop(context);
                            _controller.getWeatherByCityName(city);
                          },
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
