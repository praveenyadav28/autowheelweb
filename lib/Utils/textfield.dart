// ignore_for_file: non_constant_identifier_names

import 'package:autowheelweb/Utils/colors.dart';
import 'package:autowheelweb/Utils/textstyle.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

Widget dropdownTextfield(
  String? labelText,
  Widget? widget,
) {
  return SizedBox(
    height: 50,
    child: TextFormField(
      readOnly: true,
      initialValue: " ",
      decoration: InputDecoration(
          fillColor: AppColor.colWhite,
          filled: true,
          suffix: SizedBox(width: double.infinity, child: widget),
          labelText: labelText,
          labelStyle: rubikTextStyle(16, FontWeight.w400, AppColor.colLabel),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.colBlack, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.colBlack, width: 1)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.colBlack, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.colBlack, width: 1))),
    ),
  );
}

TextFormField textformfiles(
  TextEditingController? controller, {
  Widget? label,
  TextInputType? keyboardType,
  int? maxLength,
  Widget? suffixIcon,
  Widget? prefixIcon,
  String? Function(String?)? validator,
  Function(String)? onChanged,
  Function(String)? onFieldSubmitted,
  String? labelText,
  bool readOnly = false,
}) {
  return TextFormField(
    onFieldSubmitted: onFieldSubmitted,
    textCapitalization: TextCapitalization.words,
    keyboardType: keyboardType,
    controller: controller,
    readOnly: readOnly,
    maxLength: maxLength,
    validator: validator,
    onChanged: onChanged,
    style: rubikTextStyle(16, FontWeight.w500, AppColor.colBlack),
    decoration: InputDecoration(
      suffixIcon: suffixIcon,
      labelText: labelText,
      counterText: "",
      filled: true,
      fillColor: AppColor.colWhite,
      prefixIcon: prefixIcon,
      label: label,
      labelStyle: rubikTextStyle(16, FontWeight.w400, AppColor.colLabel),
      isDense: true,
      contentPadding: const EdgeInsets.only(top: 28, left: 15, right: 10),
      border: InputBorder.none,
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: AppColor.colBlack)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: AppColor.colBlack, width: 1)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: AppColor.colBlack, width: 1)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: AppColor.colBlack, width: 1)),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: AppColor.colBlack),
      ),
    ),
  );
}

DropdownButtonHideUnderline searchDropDown(
    String hintText,
    List<DropdownMenuItem<Map<String, dynamic>>>? items,
    Map<String, dynamic>? value,
    Function(Map<String, dynamic>?)? onChanged,
    TextEditingController? controller,
    Function(String)? onChangedText,
    String hintTextInside,
    Function(bool)? onMenuStateChange) {
  return DropdownButtonHideUnderline(
    child: DropdownButton2<Map<String, dynamic>>(
      isExpanded: true,
      // ignore: prefer_const_constructors
      iconStyleData: IconStyleData(icon: Icon(Icons.keyboard_arrow_down)),
      alignment: Alignment.centerLeft,
      hint: Text(
        hintText,
        style: rubikTextStyle(16, FontWeight.w500, AppColor.colBlack),
      ),
      items: items,
      value: value,
      onChanged: onChanged,
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 40,
        width: 200,
      ),
      dropdownStyleData: const DropdownStyleData(
        maxHeight: 200,
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 40,
      ),
      dropdownSearchData: DropdownSearchData(
        searchController: controller,
        searchInnerWidgetHeight: 50,
        searchInnerWidget: Container(
          height: 50,
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 4,
            right: 8,
            left: 8,
          ),
          child: TextFormField(
            expands: true,
            readOnly: false,
            maxLines: null,
            controller: controller,
            onChanged: onChangedText,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              hintText: hintTextInside,
              hintStyle: const TextStyle(fontSize: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ),
      onMenuStateChange: onMenuStateChange,
    ),
  );
}

InkWell addDefaultButton(Function()? onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColor.colWhite,
          border: Border.all(
            width: 1,
            color: AppColor.colBlack,
          ),
        ),
        child: Icon(
          Icons.add,
          color: AppColor.colBlack,
        )),
  );
}

DropdownButton<Object> localDropdownButton(String hintText,BuildContext context, Object? value,
    List<DropdownMenuItem<Object>>? items, void Function(Object?)? onChanged) {
  return DropdownButton(
    underline: Container(),
    value: value,
     hint: Text(
        hintText,
        style: rubikTextStyle(16, FontWeight.w500, AppColor.colBlack),
      ),
    dropdownColor: AppColor.colWhite,
    icon: Icon(
      Icons.keyboard_arrow_down_outlined,
      size: MediaQuery.of(context).size.height * 0.030,
      color: AppColor.colBlack,
    ),
    isExpanded: true,
    items: items,
    onChanged: onChanged,
  );
}

Widget Button(String txt, Color? color) {
  return Container(
    height: 40,
    width: double.infinity,
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(20), color: color),
    child: Center(
        child: Text(txt,
            style: rubikTextStyle(16, FontWeight.w500, AppColor.colWhite))),
  );
}
