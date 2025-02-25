import 'package:common/utils/provider/preference_settings_provider.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/provider/provider.dart';
import 'package:dependencies/show_up_animation/show_up_animation.dart';
import 'package:detail_surah/presentation/bloc/bloc.dart';
import 'package:detail_surah/presentation/cubits/last_read/last_read_cubit.dart';
import 'package:detail_surah/presentation/ui/widget/banner_verses_widget.dart';
import 'package:detail_surah/presentation/ui/widget/kashmiri_verse_widget.dart';
import 'package:detail_surah/presentation/ui/widget/verses_widget.dart';
import 'package:flutter/material.dart';
import 'package:resources/styles/color.dart';
import 'package:resources/styles/text_styles.dart';

class DetailSurahScreen extends StatefulWidget {
  final int id;
  final String kashmiriTranslationFilePath;
  final String urduTranslationFilePath;

  const DetailSurahScreen({
    super.key,
    required this.id,
    required this.kashmiriTranslationFilePath,
    required this.urduTranslationFilePath,
  });

  @override
  State<DetailSurahScreen> createState() => _DetailSurahScreenState();
}

class _DetailSurahScreenState extends State<DetailSurahScreen> {
  bool isTilawatMode = false;
  bool showEnglishTranslation = false;
  bool showUrduTranslation = true;
  bool showKashmiriTasfeer = false;

  void showOptionsBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
          child: Wrap(
            children: [
              ListTile(
                title: const Text(
                  "Enable/Disable Tilawat mode",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  setState(() {
                    isTilawatMode = !isTilawatMode;
                    showEnglishTranslation = false;
                    showUrduTranslation = true;
                    showKashmiriTasfeer = false;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(
                  "Show English Translation",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  setState(() {
                    isTilawatMode = false;
                    showEnglishTranslation = true;
                    showUrduTranslation = false;
                    showKashmiriTasfeer = false;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(
                  "Show Urdu Translation",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  setState(() {
                    isTilawatMode = false;
                    showEnglishTranslation = false;
                    showUrduTranslation = true;
                    showKashmiriTasfeer = false;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(
                  "Kashmiri Tafseer",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  setState(() {
                    showKashmiriTasfeer = !showKashmiriTasfeer;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<DetailSurahBloc>().add(FetchDetailSurah(
            id: widget.id,
            kashmiriTranslationFilePath: widget.kashmiriTranslationFilePath,
            urduTranslationFilePath: widget.urduTranslationFilePath,
          ));
      context.read<LastReadCubit>().getLastRead();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenceSettingsProvider>(
      builder: (context, prefSetProvider, _) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
              child: BlocBuilder<DetailSurahBloc, DetailSurahState>(
                builder: (context, state) {
                  final status = state.statusDetailSurah.status;

                  if (status.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: prefSetProvider.isDarkTheme
                            ? Colors.white
                            : kPurplePrimary,
                      ),
                    );
                  } else if (status.isNoData || status.isError) {
                    return Center(child: Text(state.statusDetailSurah.message));
                  } else if (status.isHasData) {
                    final surah = state.statusDetailSurah.data;
                    final translations = state.kashmiriTranslations;
                    final urduTranslations = state.urduTranslations;

                    if (context.read<LastReadCubit>().state.data.isEmpty) {
                      context.read<LastReadCubit>().addLastRead(surah!);
                    } else {
                      context.read<LastReadCubit>().updateLastRead(surah!);
                    }

                    return Column(
                      children: [
                        ShowUpAnimation(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () => Navigator.pop(context),
                                    child: const Icon(
                                      Icons.arrow_back,
                                      size: 24.0,
                                      color: kGrey,
                                    ),
                                  ),
                                  const SizedBox(width: 18.0),
                                  Text(
                                    surah.name.transliteration.id,
                                    style: kHeading6.copyWith(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: prefSetProvider.isDarkTheme
                                          ? Colors.white
                                          : kPurpleSecondary,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: Colors.black,
                                ),
                                onPressed: showOptionsBottomSheet,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                BannerVersesWidget(
                                  surah: surah,
                                  prefSetProvider: prefSetProvider,
                                ),
                                const SizedBox(height: 30.0),
                                ShowUpAnimation(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        child: isTilawatMode
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text.rich(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  TextSpan(
                                                    children: [
                                                      for (int i = 0;
                                                          i <
                                                              surah.verses
                                                                  .length;
                                                          i++) ...[
                                                        TextSpan(
                                                          text: surah.verses[i]
                                                                  .text.arab +
                                                              " ",
                                                          style: kHeading6
                                                              .copyWith(
                                                            fontSize: 28.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 2.2,
                                                          ),
                                                        ),
                                                        WidgetSpan(
                                                          alignment:
                                                              PlaceholderAlignment
                                                                  .middle,
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                              right: 6.0,
                                                              left: 6.0,
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        12.0,
                                                                    vertical:
                                                                        4.0),
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  kPurpleSecondary
                                                                      .withAlpha(
                                                                          50),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50.0),
                                                              border: Border.all(
                                                                  color:
                                                                      kPurplePrimary,
                                                                  width: 1.5),
                                                            ),
                                                            child: Text(
                                                              surah
                                                                  .verses[i]
                                                                  .number
                                                                  .inSurah
                                                                  .toString(),
                                                              style: kHeading6
                                                                  .copyWith(
                                                                fontSize: 18.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const TextSpan(
                                                            text:
                                                                " "), // Add space after verse number
                                                      ],
                                                    ],
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            : showKashmiriTasfeer
                                                ? ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount: state
                                                        .kashmiriTranslations
                                                        .entries
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return KashmiriVerseWidget(
                                                        arabicVerse: state
                                                            .kashmiriTranslations
                                                            .keys
                                                            .toList()[index],
                                                        kashmiriTranslation: state
                                                            .kashmiriTranslations[state
                                                                .kashmiriTranslations
                                                                .keys
                                                                .toList()[index]]
                                                            .toString(),
                                                      );
                                                    },
                                                  )
                                                : ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount:
                                                        surah.verses.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return VersesWidget(
                                                        verses:
                                                            surah.verses[index],
                                                        prefSetProvider:
                                                            prefSetProvider,
                                                        surah: surah.name
                                                            .transliteration.id,
                                                        kashmiriTranslation:
                                                            translations[surah
                                                                    .verses[
                                                                        index]
                                                                    .number
                                                                    .inSurah] ??
                                                                "",
                                                        urduTranslation:
                                                            urduTranslations[surah
                                                                    .verses[
                                                                        index]
                                                                    .number
                                                                    .inSurah] ??
                                                                "",
                                                        showUrduTranslation:
                                                            showUrduTranslation,
                                                        showEnglishTranslation:
                                                            showEnglishTranslation,
                                                      );
                                                    },
                                                  ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: Text('Error BLoC'));
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
