// Copyright (C) 2013 Edwin Bühler. All Rights Reserved.
//
// @author Edwin Bühler
//

library rangedSparseList_filelist_test.dart;

import 'package:unittest/unittest.dart';

import '../lib/rangedSparseList.dart';
import 'testlist.dart';

main() {
var theList;
group("Create RangedSparseList with a test list", () {
    setUp((){
      theList = new RangedSparseList.from(unicodeCharacterCategory);
      print("unicodeCharacterCategory.length ${unicodeCharacterCategory.length}");
    });
    tearDown((){
    var s = theList.createScript();
    print("""RangedSparseList().from(unicodeCharacterCategory) 
        
        $s
        
""");
    print("rangedSparseList.length ${theList.basicList.length}");
    });
    test("RangedSparseList length = 917632", () => expect(theList.length, equals(unicodeCharacterCategory.length)) );

  });
}