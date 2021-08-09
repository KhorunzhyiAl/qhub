enum ClientStatus {
  loggedIn,
  loggedOut,

  // The initial value, while trying to log in automatically with a saved token. Not used after that
  starting,
}
