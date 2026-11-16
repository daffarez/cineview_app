enum SeatStatus { available, selected, booked }

class SeatModel {
  final String id;
  final String rowLabel;
  final int seatNumber;
  final double price;
  SeatStatus status;

  SeatModel({
    required this.id,
    required this.rowLabel,
    required this.seatNumber,
    required this.price,
    required this.status,
  });

  SeatModel copyWith({SeatStatus? status}) {
    return SeatModel(
      id: id,
      rowLabel: rowLabel,
      seatNumber: seatNumber,
      price: price,
      status: status ?? this.status,
    );
  }
}
