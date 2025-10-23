class PatientInfo {
  int id;
  String name;
  DateTime dateOfBirth;
  List<String> medicalConditions;

  PatientInfo({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    required this.medicalConditions,
  });
}