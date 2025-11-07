import 'package:flutter/material.dart';
import 'package:baza_gibdd_gai/gen/l10n.dart';

extension LocalizationExtension on BuildContext {
  S get l10n => S.of(this);
}
