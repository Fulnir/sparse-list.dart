Dart Unicode Helper
---

Copyright (C) 2013 Edwin Bühler. All Rights Reserved.

Author: Edwin Bühler <fulnir@gmail.com>

This library is a workaround for non ascii characters.

Some simple functions like isLetter(int charCode) checking a unicode table with a given unicode
value.

### Functions

```dart
bool isLetter(int c);
bool isUppercase(int c);
bool isLowercase(int c);
bool isDigit(int c);
bool isCurrency(int c);
bool isSeparator(int c);
bool isControl(int c);
```

### Table codes

```
Lu Letter, Uppercase
Ll Letter, Lowercase
Lt Letter, Titlecase
Lm Letter, Modifier
Lo Letter, Other
Mn Mark, Non-Spacing
Mc Mark, Spacing Combining
Me Mark, Enclosing
Nd Number, Decimal
Nl Number, Letter
No Number, Other
Pc Punctuation, Connector
Pd Punctuation, Dash
Ps Punctuation, Open
Pe Punctuation, Close
Pi Punctuation, Initial quote (may behave like Ps or Pe depending on usage)
Pf Punctuation, Final quote (may behave like Ps or Pe depending on usage)
Po Punctuation, Other
Sm Symbol, Math
Sc Symbol, Currency
Sk Symbol, Modifier
So Symbol, Other
Zs Separator, Space
Zl Separator, Line
Zp Separator, Paragraph
Cc Other, Control
Cf Other, Format
Cs Other, Surrogate
Co Other, Private Use
Cn Other, Not Assigned (no characters in the file have this property)
```