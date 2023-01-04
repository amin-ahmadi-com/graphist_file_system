import 'package:graphist/graphist.dart';

enum FileSystemRelationType {
  contains,
}

class FileSystemContainsRelation extends Relation {
  FileSystemContainsRelation(String fromNodeId, String toNodeId)
      : super(
          type: FileSystemRelationType.contains.toString(),
          properties: {"name": "Contains"},
          fromNodeId: fromNodeId,
          toNodeId: toNodeId,
          labelProperty: "name",
        );
}
