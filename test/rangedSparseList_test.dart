//
// Copyright (C) 2013 Edwin Bühler. All Rights Reserved.
//
// @author Edwin Bühler
//
library rangedSparseList_test.dart;

import 'package:unittest/unittest.dart';
import 'package:logging/logging.dart' ;
import '../lib/rangedSparseList.dart';

main() {
  hierarchicalLoggingEnabled = true;
  Logger.root.onRecord.listen((LogRecord r) {
    print( '${r.loggerName}(${r.level}): ${r.message}');
  });

  var theList;

  group("Create empty RangeIndexList", () {
    setUp((){
      theList = new RangedSparseList();
    });
    tearDown((){
    });

    test("RangedSparseList is RangedSparseList", () => expect((theList is RangedSparseList), isTrue) );
    test("RangedSparseList isEmpty", () => expect(theList.isEmpty, isTrue) );
    test("RangedSparseList length = 0", () => expect(theList.length, equals(0)));
  });

  group("Create RangedSparseList with a list", () {
    setUp((){
      theList = new RangedSparseList.from([0,0,0,1,1,2,2,2,2,3]);
      print("RangedSparseList().from([0,0,0,1,1,2,2,2,2,3]) ${theList.basicList}");
    });
    tearDown((){
    });
    test("RangedSparseList length = 10", () => expect(theList.length, equals(10)) );
    test("RangedSparseList basicList = 4", () => expect(theList.basicList.length, equals(4)) );
  });
  group("Create RangedSparseList with a sparselist script", () {
    setUp((){
      theList = new RangedSparseList.fromSparseList( [[0,3,0],[3,2,1],[5,4,2],[9,1,3]]);
      print("RangedSparseList().fromSparseList()) ${theList.basicList}");
    });
    tearDown((){
    });
    test("RangedSparseList length = 10", () => expect(theList.length, equals(10)) );
    test("RangedSparseList basicList = 4", () => expect(theList.basicList.length, equals(4)) );
    test("RangedSparseList itemList", () => expect(theList.itemList, equals([0,0,0,1,1,2,2,2,2,3])) );
  });
  group("Create RangedSparseList with one entry", () {
    setUp((){
      theList = new RangedSparseList();
      theList.add(1);
    });
    tearDown((){
    });
    test("RangedSparseList length = 1", () => expect(theList.length, equals(1)) );
  });

  group("Return content", () {
    setUp((){
      theList = new RangedSparseList.from([0,0,0,1,1,2,2,2,2,3]);
    });
    tearDown((){
    });
    test("RangedSparseList itemList", () => expect(theList.itemList, equals([0,0,0,1,1,2,2,2,2,3])) );
    test("RangedSparseList createScript()", () => expect(theList.createScript(), equals('new RangedSparseList.fromSparseList( [\n  [0,3,0],[3,2,1],[5,4,2],[9,1,3]\n]);')) );
  });
  group("Return element", () {
    setUp((){
      theList = new RangedSparseList.from([0,0,0,1,1,4,2,2,2,2,3]);
    });
    tearDown((){
    });
    test("RangedSparseList operator[]", () => expect(theList[0], equals(0)));
    test("RangedSparseList operator[]", () => expect(theList[1], equals(0)));
    test("RangedSparseList operator[]", () => expect(theList[2], equals(0)));
    test("RangedSparseList operator[]", () => expect(theList[3], equals(1)));
    test("RangedSparseList operator[]", () => expect(theList[4], equals(1)));
    test("RangedSparseList operator[]", () => expect(theList[5], equals(4)));
    test("RangedSparseList operator[]", () => expect(theList[6], equals(2)));
    test("RangedSparseList operator[]", () => expect(theList[7], equals(2)));
    test("RangedSparseList operator[]", () => expect(theList[8], equals(2)));
    test("RangedSparseList operator[]", () => expect(theList[9], equals(2)));
    test("RangedSparseList operator[]", () => expect(theList[10], equals(3)));
    test("RangedSparseList operator[] throws Error", () => expect(theList[11] is StateError, isTrue));
  });
}