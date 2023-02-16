class Family {
  final String id;
  final List<String> memberIds;
  final List<dynamic> metaData;
  Family({
    required this.id,
    required this.memberIds,
    required this.metaData,
  });
}

//sequence of the family in which the member is kept is important. Make the sequence age wise.Relations are mapped via matrix to keep unique relations reflexive in nature.  
// Family(id: '1', memberCount: [
//       '',
//       '',
//       '',
//       ''
//     ], metadata: [
//       [0, 1, 2, 3],
//       [-1, 0, 4, 5],
//       [-2, -4, 0, 6],
//       [-3, -5, -6, 0],
//     ])

//relations 
//  final List<List<String>> _relations = [
//     ['SELF', 'SELF'],
//     ['HUSBAND', 'WIFE'],
//     ['FATHER', 'SON'],
//     ['FATHER', 'DAUGHTER'],
//     ['MOTHER', 'SON'],
//     ['MOTHER', 'DAUGHTER'],
//     ['BROTHER', 'SISTER'],
//   ];