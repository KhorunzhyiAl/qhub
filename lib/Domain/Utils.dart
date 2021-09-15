class Utils {

  // static const SERVER_ADDRESS = 'http://192.168.1.107:8000';
  static const SERVER_ADDRESS = 'http://31.202.127.215:8000';


  static String createImageUrl(String imageId) {
    return '$SERVER_ADDRESS/upload/$imageId';
  }
}