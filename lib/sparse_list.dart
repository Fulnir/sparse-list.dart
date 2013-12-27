//
// Copyright (C) 2013 Edwin Bühler. All Rights Reserved.
//
// @author Edwin Bühler
//

/**
 * This list class is slow and only useful for very large arrays with chunks of the same value.
 *
 * Sequences with the same value are compressed simply with [startIndex, numberOfValues, value].
 * [0,0,0,1,1,2,2,2,2,3] is store internal as [[0,3,0],[3,2,1],[5,4,2],[9,1,3]].
 *
 *     theList = new SparseList.from([0,0,0,1,1,2,2,2,2,3]);
 *     theList.createScript()
 *     // Returns
 *     // 'new SparseList.fromSparseList( [\n  [0,3,0],[3,2,1],[5,4,2],[9,1,3]\n]);'
 *
 */

class SparseList<E> {
  List basicList = new List();
  var itemsLength = 0;
  SparseList(){

  }

  /// Returns true if there is no value in the list.
  bool get isEmpty {
    return basicList.isEmpty;
  }

  /// Returns true if there is at least one element in this collection.
  bool get isNotEmpty => !isEmpty;

  /// Returns the first element.
  E get first {
    if (itemsLength == 0) throw new StateError("No elements");
    return elementAt(0);
  }

  /// Returns the last element.
  E get last {
    if (itemsLength == 0) throw new StateError("No elements");
    return elementAt(itemsLength - 1);
  }

  /// The number of values in the list.
  int get length {
    return itemsLength;
  }

  /// Returns the value at the given index.
  E operator[](int index) => this.elementAt(index);

  E elementAt(int index) {
    return basicList[_chunkPositionForElementAt(index)][2];
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
  ///Creates a List containing the elements of this Iterable.
  ///
  ///The elements are in iteration order. The list is fixed-length if growable is false.
  List<E> toList({ bool growable: true }) {
    List<E> result;
    result = new List.from(itemList, growable: growable );
    return result;
  }
  /// Applies the function f to each element of this collection.
  void forEach(void action(E element)) {
    int length = itemsLength;
    var chunkSize;
    var chunkValue;
    basicList.forEach((each) {
      chunkSize = each[1];
      chunkValue = each[2];
      for (var i = 0; i < chunkSize; i++) {
        action(chunkValue);
        if (length != itemsLength) {
          throw new ConcurrentModificationError(this);
        }
      }
    });
  }

  /// Creates a list and initializes it using the contents of other.
  factory SparseList.from(List other) {
    var newList = new SparseList();
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
  ///     new SparseList.fromSparseList( [
  ///       [0, 3, 0],[3, 2, 1],[5, 4, 2],[9, 1, 3]
  ///     ]);
  factory SparseList.fromSparseList(List other) {
    var newList = new SparseList();
    other.forEach((each) {
      newList.basicList.add(each);
      newList.itemsLength = newList.itemsLength + each[1];
    });
    return newList;
  }

  int _chunkPositionForElementAt(int index) {
    if (length <= index) throw new StateError("Not enough elements");
    var result;
    var startChunk, endChunk;
    var fuzzyPosition = ((index * basicList.length) / itemsLength).round();
    //print("fuzzyPosition $fuzzyPosition = round (index $index * basicList.length ${basicList.length}) / itemsLength $itemsLength ");
    if (fuzzyPosition >= basicList.length) {
      fuzzyPosition = basicList.length - 1;
    }
    var fuzzyChunk = basicList[fuzzyPosition];
    // TODO Workaround. Optimize with bigger and then smaller steps ?
    if (index >= fuzzyChunk[0]) {
      // forwards
      for (var i = fuzzyPosition; i < basicList.length; i++) {
        startChunk = basicList[i][0];
        endChunk = startChunk + basicList[i][1];
        if ((index >= startChunk) && (index < endChunk)) {
          result = i;
          break;
        }
      }
    } else {
      // backwards
      ;
      for (var i = (fuzzyPosition - 1); i < basicList.length; i--) {
        startChunk = basicList[i][0];
        endChunk = startChunk + basicList[i][1];
        if ((index >= startChunk) && (index < endChunk)) {
          result = i;
          break;
        }
      }
    }
    return result;
  }

  List _chunkAt(int index) {
    return basicList[_chunkPositionForElementAt(index)];
  }

  /// Set the value at the given index.
  void operator[]=(int index, var value) {
    var oldChunkPosition = _chunkPositionForElementAt(index);
    var currentChunk = basicList[oldChunkPosition];
    var currentValue = currentChunk[2];
    if (value != currentValue) {
      var updatedChunk = [currentChunk[0],(index - currentChunk[0]),currentValue];
      var newElementChunk = [index,1,value];
      var newRestChunk = [(index + 1),(currentChunk[1] - updatedChunk[1] - 1),currentValue];
      //print("currentChunk $currentChunk updatedChunk $updatedChunk newElementChunk $newElementChunk newRestChunk $newRestChunk ");
      if(newRestChunk[1] > 0)  {
        basicList.insert((oldChunkPosition + 1), newRestChunk);
      }
      basicList.insert((oldChunkPosition + 1), newElementChunk);
      if(updatedChunk[1] == 0) {
        basicList.removeAt(oldChunkPosition);
      } else {
        basicList[oldChunkPosition] = updatedChunk;
      }
    }
  }
  // TODO use operator[]= code for insert()

  /// Adds a new value to the end of this list.
  void add(value) {
    // TODO replace last chunk if posible.
    var item = [0,0,value];
    basicList.add(item);
    itemsLength++;
  }

  /// Adds a new value to the end of this list.
  void addItem (List aItem) {
    basicList.add(aItem);
    itemsLength = itemsLength + aItem[1];
  }

  /// Returns the Dart script to include in source code.
  ///     new SparseList.fromSparseList( [
  ///       [0, 3, 0],[3, 2, 1],[5, 4, 2],[9, 1, 3]
  ///     ]);
  String createScript() {
    var script = 'new SparseList.fromSparseList( [\n  ';
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