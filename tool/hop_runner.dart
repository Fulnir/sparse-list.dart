// $ cd
// $ dart tool/hop_runner.dart --color docs --allow-dirty
//
library rangedSparseList.hop_runner;

import 'dart:io';
import 'package:hop/hop.dart';
import 'package:hop/hop_tasks.dart';
import '../test/rangedSparseList_test.dart' as the_tests;


void main(List<String> args) {

  addTask('test', createUnitTestTask(the_tests.main()));

  addTask('docs', createDartDocTask(['lib/rangedSparseList.dart']));
 /* addTask('docs', createDartDocTask(['lib/rangedSparseList.dart'],
      linkApi: true,
      excludeLibs: ['meta', 'metadata'])); */

  runHop(args, paranoid: false);
}