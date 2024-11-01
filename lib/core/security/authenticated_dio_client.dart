import 'package:dio/dio.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:app/core/security/jwt_checker.dart';
import 'package:app/core/security/request_new_access_token.dart';
import 'package:app/core/security/jwt_storage.dart';

class AuthenticatedDioClient {
  final Dio client = Dio();

  AuthenticatedDioClient() {
    // Add interceptor to handle token and refresh automatically
    client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Get the current access token
          String? accessToken = await getAccessToken();
          if (accessToken == null) {
            // Clear the access token
            await deleteAccessToken();
            await deleteRefreshToken();

            handler.reject(DioException(
              requestOptions: options,
              error: 'Access token is missing',
            ));

            // Redirect to login page

            return;
          }

          // Check if the access token is expired
          if (isTokenExpired(accessToken)) {
            bool success = await refreshAccessToken();
            if (success) {
              // Update access token
              accessToken = await getAccessToken();
            } else {
              // Clear the access token
              await deleteAccessToken();
              await deleteRefreshToken();

              handler.reject(DioException(
                requestOptions: options,
                error: 'Unable to refresh access token',
              ));

              // Redirect to login page

              return;
            }
          }

          // Add the authorization header with the access token
          options.headers['Authorization'] = 'Bearer $accessToken';
          handler.next(options);
        },
      ),
    );
  }

  // Example request methods using Dio
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return client.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) {
    return client.post(path, data: data);
  }

  // Additional HTTP methods can be added as needed
}
