Dart Ranged Sparse List
---

[![Build Status](https://drone.io/github.com/Fulnir/sparse-list.dart/status.png)](https://drone.io/github.com/Fulnir/sparse-list.dart/latest)


Sequences with the same value are compressed simply with [startIndex, numberOfValues, value].
[0,0,0,1,1,2,2,2,2,3] is store internal as [[0,3,0],[3,2,1],[5,4,2],[9,1,3]].

```dart
theList = new RangedSparseList.from([0,0,0,1,1,2,2,2,2,3]);
theList.createScript()
// Returns
// 'new RangedSparseList.fromSparseList( [\n  [0,3,0],[3,2,1],[5,4,2],[9,1,3]\n]);'
```

The library unicode_helper uses the SparseList to store the unicode table.
(which has a file size of 26KB instead the uncompressed standard Dart list with 1.8MB)
