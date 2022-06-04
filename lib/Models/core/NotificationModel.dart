class NotificationModel {
  String title;
  String description;
  String type;

  NotificationModel(
      {required this.description, required this.type, required this.title});
}

List<NotificationModel> Notifications = [
  NotificationModel(
      title: "Important Announcement",
      description: 'Lorem lpsum is simply dummy text. it is used for design',
      type: "Alert"),
  NotificationModel(
      title: "Voting ended for todays lunch",
      description: 'Lorem lpsum is simply dummy text of the',
      type: "Food"),
  NotificationModel(
      title: "Important Announcement",
      description: 'Lorem lpsum is simply dummy text of the',
      type: "Alert"),
  NotificationModel(
      title: "1 hour remaining for todays lunch voting",
      description: 'Lorem lpsum is simply dummy text of the',
      type: "Food"),
  NotificationModel(
      title: "Coin Awarded",
      description: 'Earned 100 coins for comming on time',
      type: "Coin"),
  NotificationModel(
      title: "1 hour extended for lunch voting for late Comers",
      description: 'Lorem lpsum is simply dummy text of the',
      type: "Food"),
  NotificationModel(
      title: "Important Announcement",
      description: 'Lorem lpsum is simply dummy text of the',
      type: "Alert"),
  NotificationModel(
      title: "Important Announcement",
      description:
          'Tommorow office will be off due to Independence Day celebrated on 14 auguest.Happy Independece',
      type: "Time"),
  NotificationModel(
      title: "Important Announcement",
      description: 'Lorem lpsum is simply dummy text of the',
      type: "Alert"),
];
