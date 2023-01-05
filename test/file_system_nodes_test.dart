import 'package:flutter_test/flutter_test.dart';
import 'package:graphist_file_system/file_system_nodes.dart';

void main() {
  test("Windows disk names", () {
    final cNode = FileSystemFolderNode("C:");
    expect(cNode.label, "C:");

    final dNode = FileSystemFolderNode("D:\\");
    expect(dNode.label, "D:\\");
  });

  test("Regular file paths", () {
    final node = FileSystemFileNode("C:/someFile.txt");
    expect(node.label, "someFile.txt");
  });

  test("Regular folder paths (ending with /)", () {
    final node = FileSystemFolderNode("C:/someFolder/SomeSubfolder/");
    expect(node.label, "SomeSubfolder");
  });

  test("Regular folder paths", () {
    final node = FileSystemFolderNode("C:/someFolder/SomeSubfolder");
    expect(node.label, "SomeSubfolder");
  });
}
