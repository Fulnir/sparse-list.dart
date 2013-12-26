Dart Ranged Sparse List
---

Copyright (C) 2013 Edwin Bühler. All Rights Reserved.

Author: Edwin Bühler <fulnir@gmail.com>


Sequences with the same value are compressed simply with [startIndex, numberOfValues, value].
[0,0,0,1,1,2,2,2,2,3] is store internal as [[0,3,0],[3,2,1],[5,4,2],[9,1,3]].

```dart
theList = new RangedSparseList.from([0,0,0,1,1,2,2,2,2,3]);
theList.createScript()
// Returns
// 'new RangedSparseList.fromSparseList( [\n  [0,3,0],[3,2,1],[5,4,2],[9,1,3]\n]);'
```


