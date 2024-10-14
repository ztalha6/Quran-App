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
      time: '9:00 AM',
    ),
    PrayersEntity(
      assetImage: 'assets/duhar_icon.png',
      name: 'Duhar',
      time: '10:00 AM',
    ),
    PrayersEntity(
      assetImage: 'assets/asr_icon.png',
      name: 'Asr',
      time: '11:00 AM',
    ),
    PrayersEntity(
      assetImage: 'assets/magrib_icon.png',
      name: 'Magrib',
      time: '10:00 AM',
    ),
    PrayersEntity(
      assetImage: 'assets/isha_icon.png',
      name: 'Isha',
      time: '11:00 AM',
    ),
  ];
}
