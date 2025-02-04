import 'package:common/utils/provider/preference_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:quran/domain/entities/surah_entity.dart';
import 'package:resources/constant/named_routes.dart';
import 'package:resources/styles/color.dart';
import 'package:resources/styles/text_styles.dart';

class ListSurahWidget extends StatelessWidget {
  final List<SurahEntity> surah;
  final PreferenceSettingsProvider prefSetProvider;

  const ListSurahWidget({
    super.key,
    required this.surah,
    required this.prefSetProvider,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: surah.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            NamedRoutes.detailScreen,
            arguments: {
              'surah': surah[index].number,
              'path': 'assets/surahs/surah_fatiah.json',
              'urduPath':
                  'assets/urdu_translations/t_surah_${surah[index].number}.json',
            },
          ),
          child: SurahWidget(
            surah: surah[index],
            prefSetProvider: prefSetProvider,
          ),
        );
      },
    );
  }
}

class SurahWidget extends StatelessWidget {
  final SurahEntity surah;
  final PreferenceSettingsProvider prefSetProvider;

  const SurahWidget({
    super.key,
    required this.surah,
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
              Stack(
                children: [
                  Image.asset(
                    'assets/icon_no.png',
                    width: 42.0,
                    color: kPurplePrimary,
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        surah.number.toString(),
                        style: kHeading6.copyWith(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: prefSetProvider.isDarkTheme
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 15.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    surah.name.transliteration.id,
                    style: kHeading6.copyWith(
                      fontSize: 16.0,
                      color: prefSetProvider.isDarkTheme
                          ? Colors.white
                          : Colors.black,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        surah.revelation.id,
                        style: kHeading6.copyWith(
                          color: kGrey.withOpacity(0.8),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      Icon(
                        Icons.circle,
                        color: kGrey.withOpacity(0.8),
                        size: 4,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        '${surah.numberOfVerses} Ayat',
                        style: kHeading6.copyWith(
                          color: kGrey.withOpacity(0.8),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Text(
                surah.name.short,
                style: kHeading6.copyWith(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: kPurplePrimary,
                ),
              ),
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
