import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qhub/Domain/Core/Client/Client.dart';
import 'package:qhub/Domain/Core/Failure.dart';
import 'package:qhub/Domain/Feed/Post.dart';
import 'package:qhub/Domain/Locators.dart';

final _dio = locator.get<Client>().dio;

/// Attemts to submit post. If succeeds, returns its id.
Future<Either<Failure, String>> submitPost({
  required String community,
  required String title,
  required String body,
  required String imageUri,
}) async {
  try {
    if (title.isEmpty) {
      return Left(
        Failure(type: FailureType.submitPostTitleEmpty, message: Some('Title is empty')),
      );
    }

    if (!await communityExists(community)) {
      return Left(Failure(
        type: FailureType.submitPostCommunityNotSelected,
        message: Some('community "$community" does not exist'),
      ));
    }

    final resp = await _dio.post('/global', data: {
      'hub': community,
      'title': title,
      'content': body,
      'image': imageUri,
      'image_title': '',
      'image_description': '',
    });

    Map<String, dynamic> data = resp.data;

    return Right((data['id'] as int).toString());
  } catch (e) {
    print('[submitPost] error: $e');
    return Left(Failure.any('Failed to submit post'));
  }
}

// The server uses image names provided by client-side app ...
const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
final _r = Random.secure();
String _generateRandomString() {
  return String.fromCharCodes(
    Iterable.generate(20, (_) => _chars.codeUnitAt(_r.nextInt(_chars.length))),
  );
}

// TODO: implement
Future<Either<Failure, String>> uploadImage(File imageFile, [CancelToken? cancelToken]) async {
  try {
    final uri = _generateRandomString();

    Uint8List imageBytes = imageFile.readAsBytesSync();

    print("[api.dart] imageBytes.length: ${imageBytes.length}");
    await _dio.post(
      '/upload/$uri',
      options: Options(
        sendTimeout: 1000000,
        headers: {
          'Accept': "*/*",
          'Content-Length': imageBytes.length,
          'Connection': 'keep-alive',
          'User-Agent': 'ClinicPlush'
        },
      ),
      data: Stream.fromIterable(imageBytes.map((e) => [e])),
    );

    return Right(uri);
  } catch (e) {
    print('[uploadImage] error: $e');
    return Left(Failure.any('Failed to upload the image'));
  }
}

Future<bool> communityExists(String name) async {
  return true;
}

Future<Either<Failure, Post>> loadPost(String id) async {
  try {
    Map<String, dynamic> resp = (await _dio.get('/global/$id')).data;

    final imageString = resp['image'] as String;
    final Option<String> imageOption = imageString.isEmpty ? None() : Some(imageString);

    final result = Post(
      id: id,
      title: resp['title'],
      body: resp['content'],
      author: resp['author'],
      upvotes: 10,
      downvotes: 2,
      community: resp['hub'],
      imageUri: imageOption.fold(() => None(), (a) => Some(a.substring(7))), // just- ...
    );

    return Right(result);
  } catch (e) {
    print('[loadPost] error: $e');
    return Left(Failure.any('Problems fetching the post'));
  }
}

/// Loads and returns a list of [amount] posts with the [offset]
Future<Either<Failure, List<Post>>> loadMorePosts(int amount, [int offset = 0]) async {
  try {
    Map<String, dynamic> resp = (await _dio.get('/query?l=$amount&o=$offset')).data;

    List<dynamic> respPosts = resp['result'];

    final result = <Post>[];
    for (List<dynamic> post in respPosts) {
      String id = post[0].toString();
      Map<String, dynamic> postData = post[1];

      final imageString = postData['image'] as String;
      final Option<String> imageOption = imageString.isEmpty ? None() : Some(imageString);

      result.add(Post(
        id: id,
        title: postData['title'],
        body: postData['content'],
        author: postData['author'],
        upvotes: 10,
        downvotes: 2,
        community: postData['hub'],
        imageUri: imageOption.fold(() => None(), (a) => Some(a.substring(7))), // just- ...
      ));
    }

    return Right(result);
  } catch (e) {
    print('[loadMorePosts] error: $e');
    return Left(Failure.any('Failed to load posts'));
  }
}

Future<bool> verifyUsernameNotTaken(String username) async {
  var usernameCopy = username;
  if (await Future<bool>.delayed(Duration(seconds: 2), () => false)) {
    // Username field might change by the time the response arrives, in which case the warning will not
    // be relevant.
    if (username == usernameCopy) {
      return false;
    }
  }
  return true;
}
