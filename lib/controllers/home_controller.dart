import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../models/country_model.dart';

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
          'https://restcountries.com/v3.1/all?fields=name,capital,currencies,flags';
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final countries = data
            .map((json) => CountryModel.fromJson(json))
            .toList();

        // Urutkan nama negara secara abjad (A-Z)
        countries.sort((a, b) => a.name.compareTo(b.name));

        countryList.assignAll(countries);
        filteredList.assignAll(countries);
      }
    } catch (e) {
      errorMessage('Gagal mengambil data. Periksa koneksi internetmu.');
    } finally {
      isLoading(false);
    }
  }

  // Bonus: Fitur Filter/Pencarian Negara
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
