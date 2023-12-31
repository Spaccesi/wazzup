import 'package:flutter/widgets.dart' show BuildContext;
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;

extension Localization on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this);
}

// flutter gen-l10n