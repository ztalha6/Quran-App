import 'package:common/utils/provider/preference_settings_provider.dart';
import 'package:dependencies/provider/provider.dart';
import 'package:dependencies/show_up_animation/show_up_animation.dart';
import 'package:flutter/material.dart';
import 'package:resources/styles/color.dart';
import 'package:resources/styles/text_styles.dart';
import 'package:quran/domain/entities/prayers_entity.dart';
import 'package:intl/intl.dart';

class PrayersScreen extends StatefulWidget {
  const PrayersScreen({super.key});

  @override
  State<PrayersScreen> createState() => _PrayersScreenState();
}

class _PrayersScreenState extends State<PrayersScreen> {
  List<Map<String, dynamic>> nextPrayers = [];

  @override
  void initState() {
    DateTime now = DateTime.now();
    DateFormat dateFormat =
        DateFormat('hh:mm a'); // Parse times like "5:00 AM", "1:00 PM"

// Convert prayer times to DateTime today
    List<Map<String, dynamic>> prayerTimes =
        PrayersEntity.prayers.map((prayer) {
      String cleanedTime = prayer.time
          .trim()
          .replaceAll(' ', ' '); // Remove any special characters
      DateTime prayerTime = dateFormat.parse(cleanedTime);
      // Adjust the prayer time to today's date
      prayerTime = DateTime(
          now.year, now.month, now.day, prayerTime.hour, prayerTime.minute);
      return {
        'name': prayer.name,
        'time': prayerTime,
        'timeString': dateFormat.format(prayerTime)
      }; // Format the time as a string};
    }).toList();

    // Find next two prayers after current time
    nextPrayers =
        prayerTimes.where((prayer) => prayer['time'].isAfter(now)).toList();

    // If less than two prayers remaining, include prayers from the next day
    if (nextPrayers.length < 2) {
      nextPrayers.addAll(prayerTimes.take(2 - nextPrayers.length));
    }

    // Get the next 2 prayers
    nextPrayers = nextPrayers.take(2).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenceSettingsProvider>(
        builder: (context, prefSetProvider, _) {
      return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 32.0, horizontal: 28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShowUpAnimation(
                    child: Text(
                      'Prayer Time',
                      style: kHeading6.copyWith(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: kPurpleSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  ShowUpAnimation(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Today',
                          style: kHeading6.copyWith(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                            color: prefSetProvider.isDarkTheme
                                ? Colors.white
                                : kBlackPurple,
                            letterSpacing: 0.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  ShowUpAnimation(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: kPurplePrimary.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 50,
                            offset: const Offset(
                                0, 18), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Image.asset('assets/prayer_time_banner.png'),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  nextPrayers[0]['name'],
                                  style: kHeading6.copyWith(
                                    fontSize: 16.0,
                                    color: prefSetProvider.isDarkTheme
                                        ? Colors.white
                                        : Colors.white,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  nextPrayers[0]['timeString'],
                                  style: kHeading6.copyWith(
                                    fontSize: 32.0,
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Next Pray: ${nextPrayers[1]['name']}',
                                  style: kHeading6.copyWith(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                                ),
                                Text(
                                  nextPrayers[1]['timeString'],
                                  style: kHeading6.copyWith(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 44.0),
                  ShowUpAnimation(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 1.8,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: PrayersEntity.prayers.length,
                        itemBuilder: (BuildContext context, int index) {
                          final prayer = PrayersEntity.prayers[index];
                          return PrayerWidget(
                            dua: prayer,
                            prefSetProvider: prefSetProvider,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class PrayerWidget extends StatelessWidget {
  final PrayersEntity dua;
  final PreferenceSettingsProvider prefSetProvider;

  const PrayerWidget({
    super.key,
    required this.dua,
    required this.prefSetProvider,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                dua.assetImage,
                scale: 2.3,
                color: kPurplePrimary,
              ),
              const SizedBox(width: 20),
              Text(
                dua.name,
                style: kHeading6.copyWith(
                  fontSize: 16.0,
                  color:
                      prefSetProvider.isDarkTheme ? Colors.white : Colors.black,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: kPurplePrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    dua.time,
                    style: kHeading6.copyWith(
                      fontSize: 16.0,
                      color: prefSetProvider.isDarkTheme
                          ? Colors.white
                          : kPurplePrimary,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Divider(
              thickness: 1,
              color: kGrey.withOpacity(0.25),
            ),
          ),
        ],
      ),
    );
  }
}
