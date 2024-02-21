import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import '../utils/strings.dart';
import '../../main.dart';

emptyFieldsWarning(context) {
  return FToast.toast(
    context,
    msg: MyString.oopsMsg,
    subMsg: "You must fill all Fields!",
    corner: 20.0,
    duration: 2000,
    padding: const EdgeInsets.all(20),
  );
}

nothingEnterOnUpdateTaskMode(context) {
  return FToast.toast(
    context,
    msg: MyString.oopsMsg,
    subMsg: "You must edit the tasks then try to update it!",
    corner: 20.0,
    duration: 3000,
    padding: const EdgeInsets.all(20),
  );
}

dynamic warningNoTask(BuildContext context) {
  return PanaraInfoDialog.showAnimatedGrow(
    context,
    title: MyString.oopsMsg,
    message:
        "There is no Task For Delete!\n Try adding some and then try to delete it!",
    buttonText: "Okay",
    onTapDismiss: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.warning,
  );
}

dynamic deleteAllTask(BuildContext context) {
  return PanaraConfirmDialog.show(
    context,
    title: MyString.areYouSure,
    message:
        "Do You really want to delete all tasks? You will no be able to undo this action!",
    confirmButtonText: "Yes",
    cancelButtonText: "No",
    onTapCancel: () {
      Navigator.pop(context);
    },
    onTapConfirm: () {
      BaseWidget.of(context).dataStore.box.clear();
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.error,
    barrierDismissible: false,
  );
}

String lottieURL = 'assets/lottie/1.json';
