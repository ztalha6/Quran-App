import 'package:common/utils/provider/preference_settings_provider.dart';
import 'package:dependencies/provider/provider.dart';
import 'package:dependencies/show_up_animation/show_up_animation.dart';
import 'package:flutter/material.dart';
import 'package:resources/styles/color.dart';
import 'package:resources/styles/text_styles.dart';
import 'package:quran/domain/entities/prayers_entity.dart';

class PrayersScreen extends StatelessWidget {
  const PrayersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenceSettingsProvider>(
        builder: (context, prefSetProvider, _) {
      return Scaffold(
        body: SafeArea(
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
                const SizedBox(height: 44.0),
                ShowUpAnimation(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 1.8,
                    child: ListView.builder(
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
