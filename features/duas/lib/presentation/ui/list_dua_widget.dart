import 'package:common/utils/provider/preference_settings_provider.dart';
import 'package:duas/presentation/ui/dua_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:quran/domain/entities/dua_entity.dart';
import 'package:resources/styles/color.dart';
import 'package:resources/styles/text_styles.dart';

class ListDuaWidget extends StatelessWidget {
  final List<DuaEntity> duas;
  final PreferenceSettingsProvider prefSetProvider;

  const ListDuaWidget({
    super.key,
    required this.duas,
    required this.prefSetProvider,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: duas.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DuaDetailScreen(
                      content: duas[index].content,
                      title: duas[index].name,
                    )));
          },
          child: DuaWidget(
            dua: duas[index],
            number: index + 1,
            prefSetProvider: prefSetProvider,
          ),
        );
      },
    );
  }
}

class DuaWidget extends StatelessWidget {
  final DuaEntity dua;
  final int number;
  final PreferenceSettingsProvider prefSetProvider;

  const DuaWidget({
    super.key,
    required this.dua,
    required this.number,
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
                        number.toString(),
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
                    dua.name,
                    style: kHeading6.copyWith(
                      fontSize: 16.0,
                      color: prefSetProvider.isDarkTheme
                          ? Colors.white
                          : Colors.black,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     Text(
                  //       dua.revelation.id,
                  //       style: kHeading6.copyWith(
                  //         color: kGrey.withOpacity(0.8),
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w400,
                  //       ),
                  //     ),
                  //     const SizedBox(width: 4.0),
                  //     Icon(
                  //       Icons.circle,
                  //       color: kGrey.withOpacity(0.8),
                  //       size: 4,
                  //     ),
                  //     const SizedBox(width: 4.0),
                  //     Text(
                  //       '${dua.numberOfVerses} Ayat',
                  //       style: kHeading6.copyWith(
                  //         color: kGrey.withOpacity(0.8),
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w400,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
              const Spacer(),
              Icon(Icons.keyboard_arrow_right_rounded)
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
