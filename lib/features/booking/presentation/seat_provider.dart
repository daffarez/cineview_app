import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/seat_model.dart';

final seatListProvider = StateNotifierProvider<SeatNotifier, List<SeatModel>>((
  ref,
) {
  return SeatNotifier();
});

class SeatNotifier extends StateNotifier<List<SeatModel>> {
  SeatNotifier() : super(_generateRegularSeats());

  static List<SeatModel> _generateRegularSeats() {
    final List<SeatModel> seats = [];
    const rows = ['A', 'B', 'C', 'D', 'E', 'F', 'G'];
    const double standardPrice = 45000.0;

    for (var row in rows) {
      for (int i = 1; i <= 12; i++) {
        // mocked booked seat
        final bool isBooked =
            (row == 'B' && i >= 5 && i <= 8) || (row == 'E' && i == 3);

        seats.add(
          SeatModel(
            id: '$row-$i',
            rowLabel: row,
            seatNumber: i,
            price: standardPrice,
            status: isBooked ? SeatStatus.booked : SeatStatus.available,
          ),
        );
      }
    }
    return seats;
  }

  void toggleSeatSelection(String seatId) {
    state = state.map((seat) {
      if (seat.id == seatId) {
        if (seat.status == SeatStatus.booked) return seat;

        final newStatus = seat.status == SeatStatus.selected
            ? SeatStatus.available
            : SeatStatus.selected;

        return seat.copyWith(status: newStatus);
      }
      return seat;
    }).toList();
  }
}
