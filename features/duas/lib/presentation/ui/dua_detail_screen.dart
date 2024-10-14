import 'package:common/utils/provider/preference_settings_provider.dart';
import 'package:dependencies/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:resources/styles/color.dart';
import 'package:resources/styles/text_styles.dart';

class DuaDetailScreen extends StatelessWidget {
  const DuaDetailScreen(
      {super.key, required this.content, required this.title});

  final String content;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenceSettingsProvider>(
        builder: (context, prefSetProvider, _) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor:
              prefSetProvider.isDarkTheme ? kBlackPurple : Colors.white,
          iconTheme: IconThemeData(
            color: prefSetProvider.isDarkTheme ? Colors.white : kGrey,
          ),
          title: Text(
            title,
            style: kHeading6.copyWith(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: kPurpleSecondary,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
              child: Column(
                children: [
                  // Row(
                  //   children: [
                  //     InkWell(
                  //       onTap: () => Navigator.pop(context),
                  //       child: const Icon(
                  //         Icons.arrow_back,
                  //         size: 24.0,
                  //         color: kGrey,
                  //       ),
                  //     ),
                  //     const SizedBox(width: 18.0),
                  //     Text(
                  //       title,
                  //       style: kHeading6.copyWith(
                  //         fontSize: 20.0,
                  //         fontWeight: FontWeight.bold,
                  //         color: kPurpleSecondary,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 24.0),
                  Text(
                    content,
                    textAlign: TextAlign.right,
                    style: kHeading6.copyWith(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w500,
                      color: prefSetProvider.isDarkTheme
                          ? Colors.white
                          : kDarkPurple,
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
