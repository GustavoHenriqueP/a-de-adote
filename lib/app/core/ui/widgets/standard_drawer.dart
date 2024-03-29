import 'package:a_de_adote/app/core/constants/labels.dart';
import 'package:a_de_adote/app/core/ui/helpers/filters_state.dart';
import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:a_de_adote/app/pages/home/tabs_state.dart';
import 'package:a_de_adote/app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/alert_dialog_confirmation_message.dart';

class StandardDrawer extends StatefulWidget {
  const StandardDrawer({super.key});

  @override
  State<StandardDrawer> createState() => _StandardDrawerState();
}

class _StandardDrawerState extends State<StandardDrawer>
    with AlertDialogConfirmationMessage {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        } else {
          SharedPreferences sp = snapshot.data as SharedPreferences;

          return Drawer(
            child: Stack(
              children: [
                ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: const BoxDecoration(
                        color: ProjectColors.secondary,
                      ),
                      child: Center(
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/logos/logo_completo_white.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () async {
                        Navigator.of(context).pop();
                      },
                      title: Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            size: 22,
                            color: ProjectColors.secondaryDark,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            Labels.sobre,
                            style: ProjectFonts.pSecundaryDark.copyWith(
                              fontSize:
                                  MediaQuery.textScaleFactorOf(context) > 1
                                      ? 14
                                      : 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: context.read<AuthService>().ongUser != null &&
                          sp.get('userType') == 'ong'
                      ? ListTile(
                          tileColor: ProjectColors.primary,
                          onTap: () async {
                            final tabs =
                                Provider.of<TabsState>(context, listen: false);
                            final auth = Provider.of<AuthService>(context,
                                listen: false);
                            final navigator = Navigator.of(context);
                            bool? action =
                                await confirmAction(Labels.confirmacaoSair);
                            if (action == null || action == false) {
                              null;
                            } else {
                              FiltersState.tempOngFilters = null;
                              FiltersState.tempPetFilters = null;
                              FiltersState.ongCurrentFilters = null;
                              FiltersState.petCurrentFilters = null;
                              auth.signOut();
                              tabs.setTabIndex(0);
                              navigator.popAndPushNamed('/login');
                            }
                          },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.logout,
                                size: 22,
                                color: ProjectColors.light,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Sair',
                                style: ProjectFonts.pLight.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListTile(
                          tileColor: ProjectColors.secondary,
                          onTap: () {
                            sp.setString('userType', 'ong');
                            Navigator.popAndPushNamed(context, '/login');
                          },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.pets,
                                size: 22,
                                color: ProjectColors.light,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                Labels.souOng,
                                style: ProjectFonts.pLight.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
