LanguageManager
===============

Language manager is singletone class which can help you manage app language. It is usefull if You need have different language within the app then on the device. The best advantage of LanguageManager is that You still can use common methods to set localized text and titles, for example NSLocalizedStringFromTable. With LaguageManager it always returns localized string compatible with appLanguage property.

#USAGE

1. Register available languages in AppDelegate

```objective-c
[[LanguageManager sharedManager] registerAvailableLanguages:@[@"pl",@"en"] 
                                        withDefaultLanguage:@"en"];
```

2. Register block to update UI

```objective-c
ViewController *viewController = (ViewController*)self.window.rootViewController;
[[LanguageManager sharedManager] registerRefreshUIBlock:^{
        [viewController methodWhereYouSetLocalizedTexts];
}];
```
3. Set localized text

```objective-c
self.textLabel.text = NSLocalizedStringFromTable(@"key", @"Texts", nil);
```

4. Change language

```objective-c
[[LanguageManager sharedManager] setAppLanguage:@"pl"];
```

#SAMPLE

You can download sample project where You can check how it work.
