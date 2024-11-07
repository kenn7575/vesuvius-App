import 'package:app/core/security/get_device_id.dart';
import 'package:dio/dio.dart';
import 'package:app/core/security/jwt_checker.dart';
import 'package:app/core/security/request_new_access_token.dart';
import 'package:app/core/security/jwt_storage.dart';
import 'package:flutter/material.dart';

class AuthenticatedDioClient {
  final Dio client = Dio();
  final ValueNotifier<bool> isAuthenticated = ValueNotifier(false);

  AuthenticatedDioClient() {
    client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Get the current access token
          String? accessToken = await getAccessToken();

          if (accessToken == null) {
            // if the access token is null, refresh the access token
            bool success = await refreshAccessToken();

            // if the refresh token is not valid, reject the request
            if (!success) {
              isAuthenticated.value = false;
              handler.reject(DioException(
                requestOptions: options,
                error: 'Unable to refresh access token. Please login again.',
              ));
              return;
            } else {
              // if the refresh token is valid, update value notifier
              accessToken = await getAccessToken();
              isAuthenticated.value = true;
            }
          }

          if (accessToken == null) {
            isAuthenticated.value = false;
            handler.reject(DioException(
              requestOptions: options,
              error: 'Unable to refresh access token. Please login again.',
            ));
            return;
          }

          // Check if the access token is expired
          if (isTokenExpired(accessToken)) {
            bool success = await refreshAccessToken();
            if (success) {
              // Update access token
              isAuthenticated.value = true;
              accessToken = await getAccessToken();
            } else {
              isAuthenticated.value = false;
              handler.reject(DioException(
                requestOptions: options,
                error: 'Unable to refresh access token. Please login again.',
              ));
              return;
            }
          }

          // Add the authorization header with the access token
          options.headers['Authorization'] = 'Bearer $accessToken';
          String deviceId = await getDeviceId();
          options.headers['audience'] = deviceId;

          handler.next(options);
        },
      ),
    );
  }
}
