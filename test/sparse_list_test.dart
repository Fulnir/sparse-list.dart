//
// Copyright (C) 2013 Edwin Bühler. All Rights Reserved.
//
// @author Edwin Bühler
//
library SparseList_test.dart;

import 'package:unittest/unittest.dart';
import 'package:logging/logging.dart' ;
import '../lib/sparse_list.dart';

main() {
  hierarchicalLoggingEnabled = true;
  Logger.root.onRecord.listen((LogRecord r) {
    print( '${r.loggerName}(${r.level}): ${r.message}');
  });

  var theList;

  group("Create empty RangeIndexList", () {
    setUp((){
      theList = new SparseList();
    });
    tearDown((){
    });

    test("SparseList is SparseList", () => expect((theList is SparseList), isTrue) );
    test("SparseList isEmpty", () => expect(theList.isEmpty, isTrue) );
    test("SparseList length = 0", () => expect(theList.length, equals(0)));
  });

  group("Create SparseList with a list", () {
    setUp((){
      theList = new SparseList.from([0,0,0,1,1,2,2,2,2,3]);
      print("SparseList().from([0,0,0,1,1,2,2,2,2,3]) ${theList.basicList}");
    });
    tearDown((){
    });
    test("SparseList length = 10", () => expect(theList.length, equals(10)) );
    test("SparseList basicList = 4", () => expect(theList.basicList.length, equals(4)) );
    test("SparseList first = 0", () => expect(theList.first, equals(0)) );
    test("SparseList last = 3", () => expect(theList.last, equals(3)) );

  });
  group("first and last", () {
    setUp((){
      theList = new SparseList.from([4,0,0,1,1,2,2,2,2,7]);
    });
    tearDown((){
    });
    test("SparseList first = 4", () => expect(theList.first, equals(4)) );
    test("SparseList last = 7", () => expect(theList.last, equals(7)) );

  });
  group("Create SparseList with a sparselist script", () {
    setUp((){
      theList = new SparseList.fromSparseList( [[0,3,0],[3,2,1],[5,4,2],[9,1,3]]);
      print("SparseList().fromSparseList()) ${theList.basicList}");
    });
    tearDown((){
    });
    test("SparseList length = 10", () => expect(theList.length, equals(10)) );
    test("SparseList basicList = 4", () => expect(theList.basicList.length, equals(4)) );
    test("SparseList itemList", () => expect(theList.itemList, equals([0,0,0,1,1,2,2,2,2,3])) );
  });
  group("Create SparseList with one entry", () {
    setUp((){
      theList = new SparseList();
      theList.add(1);
    });
    tearDown((){
    });
    test("SparseList length = 1", () => expect(theList.length, equals(1)) );
  });

  group("Return content", () {
    setUp((){
      theList = new SparseList.from([0,0,0,1,1,2,2,2,2,3]);
    });
    tearDown((){
    });
    test("SparseList itemList", () => expect(theList.itemList, equals([0,0,0,1,1,2,2,2,2,3])) );
    test("SparseList itemList", () => expect(theList.toList(), equals([0,0,0,1,1,2,2,2,2,3])) );
    test("SparseList itemList", () => expect(theList.toList(growable:false), equals([0,0,0,1,1,2,2,2,2,3])) );
    test("SparseList createScript()", () => expect(theList.createScript(), equals('new SparseList.fromSparseList( [\n  [0,3,0],[3,2,1],[5,4,2],[9,1,3]\n]);')) );
  });
  group("Return element", () {
    setUp((){
      theList = new SparseList.from([0,0,0,1,1,4,2,2,2,2,3]);
    });
    tearDown((){
    });
    test("SparseList operator[]", () => expect(theList[0], equals(0)));
    test("SparseList operator[]", () => expect(theList[1], equals(0)));
    test("SparseList operator[]", () => expect(theList[2], equals(0)));
    test("SparseList operator[]", () => expect(theList[3], equals(1)));
    test("SparseList operator[]", () => expect(theList[4], equals(1)));
    test("SparseList operator[]", () => expect(theList[5], equals(4)));
    test("SparseList operator[]", () => expect(theList[6], equals(2)));
    test("SparseList operator[]", () => expect(theList[7], equals(2)));
    test("SparseList operator[]", () => expect(theList[8], equals(2)));
    test("SparseList operator[]", () => expect(theList[9], equals(2)));
    test("SparseList operator[]", () => expect(theList[10], equals(3)));
   // test("SparseList operator[] throws Error", () => expect(theList[11] is StateError, isTrue));
  });
  group("forEach()", () {
    setUp((){
      theList = new SparseList.from([0,0,0,1,1,2,2,2,2,3]);
    });
    tearDown((){
    });
    test("SparseList forEach()", () {
      var i = 0;
      var test = [0,0,0,1,1,2,2,2,2,3];
      theList.forEach((e) {
        print("e $e i $i");
        expect(e, equals(test[i++])) ;
      });

    });

    group("Change element", () {
      setUp((){
        theList = new SparseList.from([0,0,0,1,1,2,2,2,2,3]);
      });
      tearDown((){
      });
      test("Set element at 4 = 1", () {
        theList[4] = 1;
        expect(theList.itemList, equals([0,0,0,1,1,2,2,2,2,3]));
      });
      test("Set element at 4 = 5", () {
        theList[4] = 4;
        expect(theList.itemList, equals([0,0,0,1,4,2,2,2,2,3]));
      });
      test("Set element at 0 = 5", () {
        theList[0] = 5;
        expect(theList.itemList, equals([5,0,0,1,1,2,2,2,2,3]));
      });
      test("Set element at 9 = 5", () {
        theList[9] = 5;
        expect(theList.itemList, equals([0,0,0,1,1,2,2,2,2,5]));
      });
    });

  });
}