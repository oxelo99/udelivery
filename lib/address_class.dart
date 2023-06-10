
class Address {
  String complex;
  String buildingNumber;
  String floor;
  String room;

  Address({required this.complex,
    required this.buildingNumber,
    required this.floor,
    required this.room});

  Address.late({
    this.complex = '',
    this.buildingNumber = '',
    this.floor = '',
    this.room = '',
  });

  Map<String, dynamic> toMap(){
    return{
      'Building Number': buildingNumber,
      'Floor': floor,
      'Room': room,
      'Complex': complex,
    };
  }
}