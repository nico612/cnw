import 'package:cniao/common/values/colors.dart';
import 'package:cniao/common/values/font_size.dart';
import 'package:cniao/theme/style.dart';
import 'package:flutter/material.dart';

typedef DropDownListCallback = void Function(int index);

class DropDownList extends StatelessWidget {
  const DropDownList(
      {super.key,
      required this.menus,
      required this.selectedIndex,
      this.onTap});

  final List<String> menus;
  final int selectedIndex;
  final DropDownListCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: menus
          .asMap()
          .map((index, title) => MapEntry(
              index,
              CellForMenus(title,
                  hasSepLine: index != menus.length - 1,
                  isSelected: index == selectedIndex,
                  onTap: () => onTap?.call(index))
              ))
          .values
          .toList(),
    );
  }
}

class CellForMenus extends StatelessWidget {
  const CellForMenus(this.title,
      {super.key,
      this.hasSepLine = true,
      this.isSelected = false,
      this.index = 0,
      this.onTap});

  final String title;
  final bool hasSepLine;
  final bool isSelected;
  final int index;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: AppFontSize.normalSp,
                          color: isSelected
                              ? AppColors.primaryColor
                              : AppColors.black),
                    ),
                  ),
                  isSelected
                      ? Icon(
                          Icons.done_rounded,
                          size: AppFontSize.normalSp,
                          color: AppColors.primaryColor,
                        )
                      : Container()
                ],
              ),
            ),
          ),
          hasSepLine
              ? const Divider(
                  height: 0.5,
                  indent: 15.0,
                  endIndent: 15,
                  color: Style.gray6,
                )
              : Container()
        ],
      ),
    );
  }
}
