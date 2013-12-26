// $ cd /Users/ed/Documents/Developing/dart/RangedSparseList
// $ dart tool/hop_runner.dart --color docs --allow-dirty
//
library sparse_list.hop_runner;


import 'package:hop/hop.dart';
import 'package:hop/hop_tasks.dart';
import '../test/sparse_list_test.dart' as the_tests;


void main(List<String> args) {

  addTask('test', createUnitTestTask(the_tests.main()));

  addTask('docs', createDartDocTask(['lib/sparse_list.dart'],
      linkApi: true,
      excludeLibs: ['logging']));

  runHop(args, paranoid: false);
}