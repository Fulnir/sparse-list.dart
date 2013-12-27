// Start tests for JUnit (Jenkins-CI).

library sparse_list_test_junit;

import 'package:junitconfiguration/junitconfiguration.dart';
import 'sparse_lis_test.dart' as all_tests;

void main() {
  JUnitConfiguration.install();
  all_tests.main();
}