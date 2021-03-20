import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  // final String url = "https://restcountries.eu/rest/v2/all";

  // Future<List<GetCountries>> getCountries() async {
  //   List<GetCountries> ret;
  //   var response = await http.get(url);

  //   print('response - ${response.body}');
  //   //List<dynamic> data2 = json.decode(response.body);
  //   ret = getCountriesFromJson(response.body);
  //   // data2.forEach((ele) {
  //   //   GetCountries getC = GetCountries();
  //   //   getC.toJson();
  //   //   GetCountries.fromJson(ele);
  //   //   ret.add(getC);
  //   // });

  //   // ret = getCountriesFromJson(json.decode(response.body));

  //   // data2.forEach((ele) {
  //   //   GetCountries getCountries = new GetCountries();
  //   //   print('ele - $ele');

  //   //   ret.add(ele);
  //   // });

  //   print('ret - $ret');

  //   return ret;
  // }
}
