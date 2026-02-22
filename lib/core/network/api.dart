import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:loynova_assessment/core/exceptions/app_exception.dart';

class DioWrapper {
  final Dio dio;

  DioWrapper(this.dio);

  void connectionChecker(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionError) {
      throw NetworkException('Please check your internet connection');
    }

    throw ServerException(
      e.response?.data?['message'] ?? 'Unexpected error',
      code: e.response?.statusCode?.toString(),
    );
  }

  Future<Response> _validate(Response res) async {
    if (res.statusCode == 500) {
      throw ServerException(
        'Server Error',
        code: (res.statusCode ?? 500).toString(),
      );
    }

    return res;
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    bool attachToken = true,
  }) async {
    try {
      // if (_inRequest) throw 'please_wait_another_response'.tr;

      final res = await dio.get(
        path,

        queryParameters: query,
        options: Options(headers: {'Accept': 'application/json', ...headers}),
        onReceiveProgress: (ds, sd) {},
      );
      return _validate(res);
    } on DioException catch (e, st) {
      log(e.toString());
      log(st.toString());
      connectionChecker(e);
      rethrow;
    } finally {}
  }

  Future<Response> post(
    String path, {
    Object body = const {},
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    String? contentType,
    bool attachToken = true,
  }) async {
    try {
      final res = await dio.post(
        path,

        data: body,
        queryParameters: query,
        options: Options(
          headers: {'Accept': 'application/json', ...headers},
          contentType: contentType,
        ),
        onSendProgress: (count, total) {
          log('count : $count');
          log('total : $total');
          log('percentage : ${((count / total) * 100).toStringAsFixed(0)}');
        },
      );
      return _validate(res);
    } on DioException catch (e, st) {
      log(e.toString());
      log(st.toString());
      connectionChecker(e);
      rethrow;
    } finally {}
  }

  Future<Response> put(
    String path, {
    dynamic body = const {},
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    bool attachToken = true,
  }) async {
    try {
      final res = await dio.put(
        path,

        data: body,
        queryParameters: query,
        options: Options(headers: {'Accept': 'application/json', ...headers}),
      );
      return _validate(res);
    } on DioException catch (e, st) {
      log(e.toString());
      log(st.toString());
      connectionChecker(e);
      rethrow;
    } finally {}
  }

  Future<Response> patch(
    String path, {
    dynamic body = const {},
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    bool attachToken = true,
  }) async {
    try {
      final res = await dio.patch(
        path,

        data: body,
        queryParameters: query,
        options: Options(headers: {'Accept': 'application/json', ...headers}),
      );
      return _validate(res);
    } on DioException catch (e, st) {
      log(e.toString());
      log(st.toString());
      connectionChecker(e);
      rethrow;
    } finally {}
  }

  Future<Response> delete(
    String path, {
    dynamic body = const {},
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    bool attachToken = true,
  }) async {
    try {
      final res = await dio.delete(
        path,

        data: body,
        queryParameters: query,
        options: Options(headers: {'Accept': 'application/json', ...headers}),
      );
      return _validate(res);
    } on DioException catch (e, st) {
      log(e.toString());
      log(st.toString());
      connectionChecker(e);
      rethrow;
    } finally {}
  }
}

abstract class ApiClient {
  Future<Response> get(
    String path, {
    Map<String, dynamic> headers,
    Map<String, dynamic> query,
    bool attachToken,
  });

  Future<Response> post(
    String path, {
    Object body,
    Map<String, dynamic> headers,
    Map<String, dynamic> query,
    String? contentType,
    bool attachToken,
  });

  Future<Response> put(
    String path, {
    dynamic body,
    Map<String, dynamic> headers,
    Map<String, dynamic> query,
    bool attachToken,
  });

  Future<Response> patch(
    String path, {
    dynamic body,
    Map<String, dynamic> headers,
    Map<String, dynamic> query,
    bool attachToken,
  });

  Future<Response> delete(
    String path, {
    dynamic body,
    Map<String, dynamic> headers,
    Map<String, dynamic> query,
    bool attachToken,
  });

  Future<Response> download({required String url, required String savePath});
}

class DioApiClient implements ApiClient {
  final DioWrapper dioWrapper;

  DioApiClient(this.dioWrapper);

  @override
  Future<Response> get(
    String path, {
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    bool attachToken = true,
  }) {
    return dioWrapper.get(
      path,
      headers: headers,
      query: query,
      attachToken: attachToken,
    );
  }

  @override
  Future<Response> post(
    String path, {
    Object body = const {},
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    String? contentType,
    bool attachToken = true,
  }) {
    return dioWrapper.post(
      path,
      body: body,
      headers: headers,
      query: query,
      contentType: contentType,
      attachToken: attachToken,
    );
  }

  @override
  Future<Response> put(
    String path, {
    dynamic body = const {},
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    bool attachToken = true,
  }) {
    return dioWrapper.put(
      path,
      body: body,
      headers: headers,
      query: query,
      attachToken: attachToken,
    );
  }

  @override
  Future<Response> patch(
    String path, {
    dynamic body = const {},
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    bool attachToken = true,
  }) {
    return dioWrapper.patch(
      path,
      body: body,
      headers: headers,
      query: query,
      attachToken: attachToken,
    );
  }

  @override
  Future<Response> delete(
    String path, {
    dynamic body = const {},
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
    bool attachToken = true,
  }) {
    return dioWrapper.delete(
      path,
      body: body,
      headers: headers,
      query: query,
      attachToken: attachToken,
    );
  }

  @override
  Future<Response> download({required String url, required String savePath}) {
    return dioWrapper.dio.download(
      url,
      savePath,
      onReceiveProgress: (count, total) {
        log((count / total * 100).toStringAsFixed(0));
      },
    );
  }
}
