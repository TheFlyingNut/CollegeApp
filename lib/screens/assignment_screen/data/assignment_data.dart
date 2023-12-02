class AssignmentData {
  final String subjectName;
  final String topicName;
  final String assignDate;
  final String lastDate;
  final String status;

  AssignmentData(this.subjectName, this.topicName, this.assignDate,
      this.lastDate, this.status);
}

List<AssignmentData> assignment = [
  AssignmentData(
      'CSI', 'Pixel Paranoia', '17 Nov 2021', '20 Nov 2021', 'Pending'),
  AssignmentData(
      'GDSC', 'Summer of Code', '11 Nov 2021', '20 Nov 2021', 'Applied'),
  AssignmentData('CSI', 'Code for good', '21 Oct 2021', '27 Oct 2021',
      'applied'),
  AssignmentData(
      'ACM', 'CodeTHon', '17 Sep 2021', '30 Sep 2021', 'Pending'),
];
