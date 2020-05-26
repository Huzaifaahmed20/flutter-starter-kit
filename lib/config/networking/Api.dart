import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_starter_kit/provider/PostsProvider/PostsModel.dart';

class _ApiBaseHelper {
  static final String baseUrl = 'https://jsonplaceholder.typicode.com';
  static final _ApiBaseHelper _singleton = _ApiBaseHelper._internal();

  factory _ApiBaseHelper() {
    return _singleton;
  }

  Dio dio;

  _ApiBaseHelper._internal() {
    BaseOptions options = new BaseOptions(
      baseUrl: baseUrl,
      followRedirects: false,
      validateStatus: (status) => status == 200,
    );
    dio = Dio(options);

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      options.headers['token'] = 'YOUR_TOKEN_HERE';
      return options;
    }, onResponse: (Response response) async {
      return response;
    }, onError: (DioError e) async {
      return e;
    }));
  }

  Future<dynamic> get(
      {@required String url, Map<String, dynamic> params}) async {
    print('Api Get, url $url');
    try {
      final response = (await dio.get(url, queryParameters: params)).data;
      return response;
    } catch (e) {
      throw e;
    }
  }
}





class Api {
  _ApiBaseHelper _api;
  static final Api _singleton = Api._internal();

  factory Api() {
    return _singleton;
  }

  Api._internal() {
    _api = _ApiBaseHelper();
  }

  Future<List<PostsModel>> getPosts() async {
    final List res = await _api.get(url: '/posts');
    final postsData = res
        .map((i) => PostsModel(
              id: i['id'],
              userId: i['userId'],
              title: i['title'],
              body: i['body'],
            ))
        .toList();

    return postsData;
  }

  Future<PostsModel> getPost(int id) async {
    final PostsModel res = await _api.get(url: '/posts/$id');
    return PostsModel(
      id: res.id,
      userId: res.userId,
      title: res.title,
      body: res.body,
    );
  }
}
