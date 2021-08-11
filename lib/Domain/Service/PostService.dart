import 'package:qhub/Domain/Locators.dart';
import 'package:qhub/Domain/Service/Client.dart';
import 'package:qhub/Domain/Elements/Post.dart';

class PostService {
  final String id;

  PostService(this.id);

  Post load() {
    final dio = locator<Client>().dio;
    throw UnimplementedError();
  }

  void upvote() {}

  void downvote() {}
}
