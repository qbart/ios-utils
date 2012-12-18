#ios-utils

## I18n
I18n is tiny wrapper for `NSLocalizedString`.

### Examples
Let's say you have `Localizable.strings` file with your translations.

#### Simple usage      
    [I18n t:@"common.save"]

It will look for `"common.save"` key in Localizable.strings:

    "common.save" = "Save";

#### Singular / Plural
To use pluralization you need to specify `count` parameter

    [I18n t:@"person" count:1] //"Person"
    [I18n t:@"person" count:2] //"People"
    ...
    [I18n t:@"person" count:10] //"People"

It will look for `"person-(one|other)"` key in Localizable.strings:

    "person-one" = "Person";
    "person-other" = "People";


#### Dynamic variables
Sometimes you might want to add dynamic variables into your translation i.e. somebody's name

    [I18n t:@"hello" dict:@{@"name": @"Bart"}]

It will look for `"hello"` key in Localizable.strings and replace all occurrences of `{{name}}` with `Bart` string - you can define more key-value pairs in `dict` param:

    "hello" = "Hello {{name}}!";

#### Mixed
To use singular/plural mode and additionally have dynamic variables you can do it like this:

    [I18n t:@"message" count:1 dict:@{@"name": @"Bart"}]
    ...
    [I18n t:@"message" count:5 dict:@{@"name": @"Bart"}]

It will look for `"message-(one|other)"` key in Localizable.strings and replace all dynamic variables with appropriate strings:

    "message-one" = "{{name}}! You have new message";
    "message-other" = "{{name}}! You have new messages";

## Utils

### Formatting dates

To format `NSDate*` you could use:

    [Utils formatDate: [[NSDate alloc] init] format: @"dd-MM-yyyy HH:mm"]

### Relative time between two dates

    [Utils relativeDateTimeString:TIME now:NOW]

This method is equivalent to Android `getRelativeTimeSpanString` method. Behavior has been taken from Android core and it works almost the same way.

