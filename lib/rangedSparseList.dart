//
// Copyright (C) 2013 Edwin Bühler. All Rights Reserved.
//
// @author Edwin Bühler
//

/**
 * Sequences with the same value are compressed simply with [startIndex, numberOfValues, value].
 *[0,0,0,1,1,2,2,2,2,3] is store internal as [[0,3,0],[3,2,1],[5,4,2],[9,1,3]].
 *
 *     theList = new RangedSparseList.from([0,0,0,1,1,2,2,2,2,3]);
 *     theList.createScript()
 *     // Returns
 *     // 'new RangedSparseList.fromSparseList( [\n  [0,3,0],[3,2,1],[5,4,2],[9,1,3]\n]);'
 *
 */
class RangedSparseList<E> {
  List basicList = new List();
  var itemsLength = 0;
  RangedSparseList(){

  }

  /// Returns true if there is no value in the list.
  bool get isEmpty {
    return basicList.isEmpty;
  }

  bool get isNotEmpty => !isEmpty;

  E get first {
    if (length == 0) throw new StateError("No elements");
    return this[0];
  }

  E get last {
    if (length == 0) throw new StateError("No elements");
    return this[length - 1];
  }

  /// The number of values in the list.
  int get length {
    return itemsLength;
  }

  E operator[](int index) => this.elementAt(index);

  E elementAt(int index) {
    if (length <= index) throw new StateError("Not enough elements");
    // TODO workaround. Optimize
    var result;
    var startChunk, endChunk;
    for (var i = 0; i < basicList.length; i++) {
      startChunk = basicList[i][0];
      endChunk = startChunk + basicList[i][1];
      if ((index >= startChunk) && (index < endChunk)) {
        result = basicList[i][2];
        break;
      }
    }
    return result;
  }

  ///  Returns the uncompressed list.
  List get itemList {
    var theList = new List();
    var chunkSize;
    var chunkValue;
    basicList.forEach((each) {
      chunkSize = each[1];
      chunkValue = each[2];
      for (var i = 0; i < chunkSize; i++) {
        theList.add(chunkValue);
      }
    });
    return theList;
  }

  /// Creates a list and initializes it using the contents of other.
  factory RangedSparseList.from(List other) {
    var newList = new RangedSparseList();
    var currentValue, previousValue;
    var item;
    for (var i = 0; i < other.length; i++) {
      currentValue = other[i];
      if (previousValue != currentValue) {
        item = [i,1,currentValue];
        newList.basicList.add(item);
      } else {
        newList.basicList.last[1]++;
      }
      previousValue = currentValue;

    }
    newList.itemsLength = other.length;
    return newList;
  }
  /// Creates a list and initializes it using the contents of other.
  ///     new RangedSparseList.fromSparseList( [
  ///       [0, 3, 0],[3, 2, 1],[5, 4, 2],[9, 1, 3]
  ///     ]);
  factory RangedSparseList.fromSparseList(List other) {
    var newList = new RangedSparseList();
    other.forEach((each) {
      newList.basicList.add(each);
      newList.itemsLength = newList.itemsLength + each[1];
    });
    return newList;
  }
  /// Adds a new value to the end of this list.
  void add(value) {
    var item = [0,0,value];
    basicList.add(item);
    itemsLength++;
  }

  /// Adds a new value to the end of this list.
  void addItem (List aItem) {
    basicList.add(aItem);
    itemsLength = itemsLength + aItem[1];
  }

  /// Returns the Dart spript to include in source code.
  ///     new RangedSparseList.fromSparseList( [
  ///       [0, 3, 0],[3, 2, 1],[5, 4, 2],[9, 1, 3]
  ///     ]);
  String createScript() {
    var script = 'new RangedSparseList.fromSparseList( [\n  ';
    var each;
    var newEntry;
    var sSize = 0;
    for (var i = 0; i < basicList.length; i++) {
      each = basicList[i];
      newEntry = '[${each[0].toString()},${each[1].toString()},${each[2].toString()}]' ;
      script = script + newEntry;
      sSize = sSize + newEntry.length;
      if (i < (basicList.length - 1)) {
        script = script + ',';
        if (sSize > 80) {
          script = script + "\n  ";
          sSize = 0;
        }
      }
    };
    script = script + '\n]);';
    return script;
  }

}