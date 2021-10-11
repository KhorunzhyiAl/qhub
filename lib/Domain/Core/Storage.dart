import 'package:dartz/dartz.dart';
import 'package:qhub/domain/feed/post.dart';
import 'package:sqflite/sqflite.dart';

/// Don't use this. Use [_db] to safely get an instance.
Database? _dbSecret;

/// Checks if the database has been initialized - if not, initializes it - and returns it.
Future<Database> get _db async {
  if (_dbSecret == null) {
    _dbSecret = await openDatabase('userConfig.db', version: 2, onCreate: (db, version) {
      db.execute('''CREATE TABLE Settings (
          theme TEXT
        );''');
      // db.execute('''REPLACE INTO Settings(theme)  VALUES("light");''');
    }, onUpgrade: (db, old, cur) {
      print('[Storage.dart] Needs to upgrade the databse: old = $old; cur = $cur');
      db.execute('''CREATE TABLE Settings (
          theme TEXT
        );''');
      // db.execute('''REPLACE INTO Settings(theme)  VALUES("light");''');
    });
  }
  return _dbSecret!;
}

/// Optionally, call this at the start of the application so that the ui displays the correct info
/// as soon as the app runs.
/// If not called, nothing scary happens. Just the ui will have the light (default) theme for the 
/// first 500ms while the database is being opened.
Future<void> initStorage() async {
  await _db;
}

Future<Option<String>> retrieveThemeName() async {
  final res = await (await _db).query('Settings', columns: ['theme']);
  if (res.length > 0) {
    final val = res[0]['theme'];

    return val != null ? Some(val.toString()) : None();
  } else {
    return None();
  }
}

Future<void> saveThemeName(String name) async {
  await (await _db).update('Settings', {'theme': name});
}

Future<Post> retrieveSavedPost() async {
  return Post.empty();
}

Future<void> savePost(Post post) async {
  return;
}

Future<List<Post>> retrieveSavedPosts() async {
  return List.empty();
}
