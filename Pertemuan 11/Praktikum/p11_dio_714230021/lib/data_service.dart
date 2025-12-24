import 'package:flutter/widgets.dart';
import 'user.dart';
import 'package:dio/dio.dart';

class DataService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://reqres.in/api',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'x-api-key':
            'reqres_bbca121c38f748198e21e44314b34e2b',
      },
    ),
  );

  Future<dynamic> getUsers() async {
    try {
      final res = await dio.get('/users');

      debugPrint('STATUS: ${res.statusCode}');
      debugPrint('DATA: ${res.data}');
      return res.data;
    } catch (e) {
      debugPrint('ERROR: $e');
      return null;
    }
  }

  Future<UserCreate?> postUser(UserCreate user) async {
    try {
      final response = await dio.post(
        '/users',
        data: user.toMap(),
      );

      debugPrint('STATUS: ${response.statusCode}');
      debugPrint('DATA   : ${response.data}');

      // ReqRes biasanya mengembalikan 201 (Created) untuk POST create user
      if (response.statusCode == 201) {
        return UserCreate.fromJson(response.data);
      }

      return null;
    } on DioException catch (e) {
      // Melihat error detail dari server
      debugPrint('DIO ERROR STATUS: ${e.response?.statusCode}');
      debugPrint('DIO ERROR DATA  : ${e.response?.data}');
      return null;
    } catch (e) {
      debugPrint('ERROR: $e');
      return null;
    }
  }

  Future<UserUpdate?> putUser(String idUser, String name, String job) async {
    try {
      final response = await dio.put(
        '/users/$idUser',
        data: {'name': name, 'job': job},
      );

      debugPrint('STATUS: ${response.statusCode}');
      debugPrint('DATA   : ${response.data}');

      if (response.statusCode == 200) {
        // Parsing ke Model UserUpdate
        return UserUpdate.fromJson(response.data);
      }

      return null;
    } on DioException catch (e) {
      debugPrint('DIO ERROR STATUS: ${e.response?.statusCode}');
      debugPrint('DIO ERROR DATA  : ${e.response?.data}');
      return null;
    } catch (e) {
      debugPrint('ERROR: $e');
      return null;
    }
  }

  Future<dynamic> deleteUser(String idUser) async {
    try {
      final response = await dio.delete('/users/$idUser');

      debugPrint('STATUS: ${response.statusCode}');
      debugPrint('DATA   : ${response.data}');

      // ReqRes mengembalikan 204 (No Content) untuk DELETE
      if (response.statusCode == 204) {
        return 'Delete user success'; // Mengembalikan string karena di reqres response-nya null
      }

      return null;
    } on DioException catch (e) {
      // Melihat error detail dari server
      debugPrint('DIO ERROR STATUS: ${e.response?.statusCode}');
      debugPrint('DIO ERROR DATA  : ${e.response?.data}');
      return null;
    } catch (e) {
      debugPrint('ERROR: $e');
      return null;
    }
  }

  Future<Iterable<User>?> getUserModel() async {
    try {
      var response = await dio.get('/users');

      if (response.statusCode == 200) {
        final users = (response.data['data'] as List)
            .map((user) => User.fromJson(user))
            .toList();

        return users;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
