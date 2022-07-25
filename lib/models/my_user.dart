class MyUser{
  final String uid;
  final String? propic;
  final String? username;
  final bool? isAdmin;
  final bool? isSubscribed;
  final int? numberOfEvents;

  MyUser({
    required this.uid,
    this.propic,
    this.username,
    this.isAdmin,
    this.isSubscribed,
    this.numberOfEvents,
  });
}
