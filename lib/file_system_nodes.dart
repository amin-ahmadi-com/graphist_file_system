import 'dart:io';

import 'package:graphist/graphist.dart';
import 'package:path/path.dart';
import 'package:tuple/tuple.dart';

import 'file_system_relations.dart';

enum FileSystemNodeType {
  folder,
  file,
}

abstract class FileSystemNode extends Node {
  final String path;

  FileSystemNode(FileSystemNodeType type, this.path)
      : super(
          type: type.toString(),
          properties: {
            "path": path,
            "name": basename(path).isNotEmpty ? basename(path) : path,
          },
          labelProperty: "name",
          uniqueProperty: "path",
          urlProperty: "path",
          icon: NodeIcon(
            fontFamily: "MaterialIcons",
            codePoint: type == FileSystemNodeType.folder
                ? 0xe2a3 // https://api.flutter.dev/flutter/material/Icons/folder-constant.html
                : 0xe0a2, // https://api.flutter.dev/flutter/material/Icons/article-constant.html
          ),
        );
}

class FileSystemFolderNode extends FileSystemNode {
  FileSystemFolderNode(String path) : super(FileSystemNodeType.folder, path);

  @override
  Future<Iterable<Tuple2<Relation, Node>>> get relatives async {
    return Directory(path).list().where((e) {
      return !FileSystemEntity.isLinkSync(path);
    }).map<Tuple2<Relation, Node>>((e) {
      Node n;
      Relation r;
      if (FileSystemEntity.isDirectorySync(e.path)) {
        n = FileSystemFolderNode(e.path);
      } else {
        n = FileSystemFileNode(e.path);
      }
      r = FileSystemContainsRelation(id, n.id);
      return Tuple2(r, n);
    }).toList();
  }
}

class FileSystemFileNode extends FileSystemNode {
  FileSystemFileNode(String path) : super(FileSystemNodeType.file, path);
}
