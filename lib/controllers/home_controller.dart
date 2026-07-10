import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../models/country_model.dart';
import 'dart:convert';

class HomeController extends GetxController {
  final Dio _dio = Dio();

  // State reaktif GetX (.obs)
  var isLoading = true.obs;
  var countryList = <CountryModel>[].obs;
  var filteredList = <CountryModel>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCountries();
  }

  // Mengambil data dari REST API
  Future<void> fetchCountries() async {
    try {
      isLoading(true);
      errorMessage('');

      const url =
          'https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/json/countries.json';

      print("🌍 REQUEST URL: $url");

      final response = await _dio.get(url);

      print(response.statusCode);
      print(response.data);

      if (response.statusCode == 200) {
        print("📥 RESPON DARI API: ${response.data}");

        final List<dynamic> dataList = response.data is String
            ? jsonDecode(response.data)
            : response.data;

        final countries = dataList
            .map((json) => CountryModel.fromJson(json as Map<String, dynamic>))
            .toList();

        countries.sort((a, b) => a.name.compareTo(b.name));

        countryList.assignAll(countries);
        filteredList.assignAll(countries);
      }
    } catch (e) {
      print("❌ ERROR DIO: $e");

      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Pencarian Negara
  void searchCountry(String query) {
    if (query.isEmpty) {
      filteredList.assignAll(countryList);
    } else {
      filteredList.assignAll(
        countryList.where(
          (country) =>
              country.name.toLowerCase().contains(query.toLowerCase()) ||
              country.capital.toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }
  }
}
