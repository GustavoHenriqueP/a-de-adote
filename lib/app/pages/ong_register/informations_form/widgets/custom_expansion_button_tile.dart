import 'package:a_de_adote/app/core/ui/styles/project_colors.dart';
import 'package:a_de_adote/app/core/ui/styles/project_fonts.dart';
import 'package:flutter/material.dart';

import 'helpers/address_fields_helper_state.dart';

// ignore: must_be_immutable
class CustomExpansionButtonTile extends StatefulWidget {
  final String title;
  final Widget body;
  final EdgeInsets? bodyPadding;

  const CustomExpansionButtonTile({
    super.key,
    required this.title,
    required this.body,
    this.bodyPadding,
  });

  @override
  State<CustomExpansionButtonTile> createState() =>
      _CustomExpansionButtonTileState();
}

class _CustomExpansionButtonTileState extends State<CustomExpansionButtonTile>
    with TickerProviderStateMixin {
  final ValueNotifier<bool> _isExpanded = ValueNotifier(false);
  late final AnimationController _controllerBody;

  @override
  void initState() {
    super.initState();
    _controllerBody = AnimationController(vsync: this);
    _controllerBody.duration = const Duration(milliseconds: 200);
  }

  @override
  void dispose() {
    _controllerBody.dispose();
    _isExpanded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isExpanded,
      builder: (BuildContext context, bool expanded, Widget? child) {
        return Column(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(6),
              onTap: () {
                _isExpanded.value = !_isExpanded.value;
                AddressFieldsHelperState.bodyIsVisible = _isExpanded.value;

                if (!expanded) {
                  _controllerBody.forward();
                } else {
                  _controllerBody.reverse();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(milliseconds: 800),
                      content: Text('Endereço completo não será salvo!'),
                    ),
                  );
                }
              },
              child: Container(
                height: 37.5,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ProjectColors.secondaryDark,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: ProjectFonts.pLightBold,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ProjectColors.light.withOpacity(0.3),
                        ),
                        child: Icon(
                          expanded ? Icons.remove : Icons.add,
                          color: ProjectColors.primaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: expanded,
              child: Align(
                alignment: Alignment.centerLeft,
                child: SlideTransition(
                  position: Tween<Offset>(
                          begin: const Offset(-1, 0), end: const Offset(0, 0))
                      .animate(
                    CurvedAnimation(
                      parent: _controllerBody,
                      curve: Curves.linear,
                    ),
                  ),
                  child: Padding(
                    padding: widget.bodyPadding ?? const EdgeInsets.all(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: widget.body,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
