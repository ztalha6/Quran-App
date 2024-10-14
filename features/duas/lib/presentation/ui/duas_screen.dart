import 'package:common/utils/provider/preference_settings_provider.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/provider/provider.dart';
import 'package:dependencies/show_up_animation/show_up_animation.dart';
import 'package:duas/presentation/bloc/duas_bloc.dart';
import 'package:flutter/material.dart';
import 'package:resources/styles/color.dart';
import 'package:resources/styles/text_styles.dart';

import 'list_dua_widget.dart';

class DuaScreen extends StatefulWidget {
  const DuaScreen({super.key});

  @override
  State<DuaScreen> createState() => _DuaScreenState();
}

class _DuaScreenState extends State<DuaScreen> {
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
              children: [
                ShowUpAnimation(
                  child: Row(
                    children: [
                      // InkWell(
                      //   onTap: () => Navigator.pop(context),
                      //   child: const Icon(
                      //     Icons.arrow_back,
                      //     size: 24.0,
                      //     color: kGrey,
                      //   ),
                      // ),
                      // const SizedBox(width: 18.0),
                      Text(
                        'Duas',
                        style: kHeading6.copyWith(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: kPurpleSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24.0),
                BlocBuilder<DuasBloc, DuasState>(
                  builder: (context, state) {
                    final status = state.statusDua.status;

                    if (status.isLoading) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: prefSetProvider.isDarkTheme
                            ? Colors.white
                            : kPurplePrimary,
                      ));
                    } else if (status.isNoData) {
                      return Center(child: Text(state.statusDua.message));
                    } else if (status.isError) {
                      return Center(child: Text(state.statusDua.message));
                    } else if (status.isHasData) {
                      final dua = state.statusDua.data ?? [];
                      return ShowUpAnimation(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 1.6,
                          child: ListDuaWidget(
                            duas: dua,
                            prefSetProvider: prefSetProvider,
                          ),
                        ),
                      );
                    } else {
                      return const Center(child: Text('Error BLoC'));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
