import 'package:flutter/foundation.dart';
import 'package:flutter_starter_kit/provider/PostsProvider/PostsModel.dart';

import '../../config/networking/Api.dart';

class PostProvider extends ChangeNotifier {
  Api api = Api();

  Future<List<PostsModel>> fetchPosts() async {
    final List<PostsModel> response = await api.getPosts();
    notifyListeners();
    return response;
  }
}
