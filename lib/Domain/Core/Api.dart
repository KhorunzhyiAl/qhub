import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:qhub/Domain/Core/Client/Client.dart';
import 'package:qhub/Domain/Core/Failure.dart';
import 'package:qhub/Domain/Feed/Post.dart';
import 'package:qhub/Domain/Locators.dart';

/// Attemts to submit post. If succeeds, returns its id.
Future<Either<Failure, String>> submitPost({
  required String community,
  required String title,
  required String body,
}) async {
  if (title.isEmpty) {
    return Left(
      Failure(type: FailureType.submitPostTitleEmpty, message: Some('Title is empty')),
    );
  }

  if (!await communityExists(community)) {
    return Left(Failure(
      type: FailureType.submitPostCommunityNotSelected,
      message: Some('community "$community" does not exis'),
    ));
  }

  final dio = locator.get<Client>().dio;

  final resp = await dio.post('/global', data: {
    'hub': community,
    'title': title,
    'content': body,
    'image': '',
    'image_title': '',
    'image_description': '',
  });

  Map<String, dynamic> data = resp.data;

  return Right((data['id'] as int).toString());
}

Future<bool> communityExists(String name) async {
  return true;
}

Future<Either<Failure, Post>> loadPost(String id) async {
  final result = Post(
      id: id,
      title:
          """Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam""",
      body:
          """Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.

The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.
""",
      author: 'author',
      upvotes: 10,
      downvotes: 2,
      community: 'hubname',
      imageUri: Some('imageid'),
    );

    return Right(result);
}

  /// Loads and returns a list of [amount] posts with the [offset]
  Future<List<Post>> loadMorePosts(int amount, [int offset = 0]) async {
    final result = <Post>[];

    await Future.delayed(Duration(seconds: 2));

    final ra = Random.secure();
    for (int i = 0; i < amount; ++i) {
      result.add(Post(
        id: '$i',
        title:
            """Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam""",
        body:
            """Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.

The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.
""",
        author: 'author',
        upvotes: 10,
        downvotes: 2,
        community: 'hubname',
        imageUri: ra.nextBool() ? None() : Some('imageid'),
      ));
    }

    return result;
  }

    Future<bool> verifyUsernameNotTaken(String username) async {
    var usernameCopy = username;
    if (await Future<bool>.delayed(Duration(seconds: 2), () => false)) {
      // Username might change by the time the response arrives, in which case the warning will not
      // be relevant.
      if (username == usernameCopy) {
        return false;
      }
    }
    return true;
  }

