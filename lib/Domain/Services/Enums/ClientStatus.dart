enum ClientStatus {
  loggedIn,
  loggedOut,

  /// When trying to log in using the saved token for the first time after running the app. Is never
  /// used after the splash screen (probably).
  trying,
}
