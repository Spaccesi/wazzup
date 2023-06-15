import 'package:flutter/widgets.dart' show BuildContext;
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;

extension Locale on BuildContext {
  String? get locale => AppLocalizations.of(this).localeName;
}
