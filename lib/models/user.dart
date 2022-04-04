class AppUser {
  final String uid;

  AppUser(this.uid);
}

class AppUserData {
  final String uid;
  final String name;
  final int MsgCoin;

  AppUserData({required this.uid, required this.name, required this.MsgCoin});
}