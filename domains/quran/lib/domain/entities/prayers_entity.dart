class PrayersEntity {
  final String assetImage;
  final String name;
  final String time;

  PrayersEntity(
      {required this.assetImage, required this.name, required this.time});

  static List<PrayersEntity> prayers = [
    PrayersEntity(
      assetImage: 'assets/fajar_icon.png',
      name: 'Fajar',
      time: '05:00 AM',
    ),
    PrayersEntity(
      assetImage: 'assets/duhar_icon.png',
      name: 'Duhar',
      time: '01:00 PM',
    ),
    PrayersEntity(
      assetImage: 'assets/asr_icon.png',
      name: 'Asr',
      time: '04:30 PM',
    ),
    PrayersEntity(
      assetImage: 'assets/magrib_icon.png',
      name: 'Magrib',
      time: '06:00 PM',
    ),
    PrayersEntity(
      assetImage: 'assets/isha_icon.png',
      name: 'Isha',
      time: '08:00 PM',
    ),
  ];
}
