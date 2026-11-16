import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/seat_model.dart';
import 'seat_provider.dart';

class SeatMapScreen extends ConsumerWidget {
  const SeatMapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seats = ref.watch(seatListProvider);
    final selectedSeats = seats
        .where((s) => s.status == SeatStatus.selected)
        .toList();
    final totalPrice = selectedSeats.fold(0.0, (sum, seat) => sum + seat.price);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Seats - Standard Theater'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Cinema screen indicator
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            height: 35,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.red.withOpacity(0.1),
                  Colors.red.withOpacity(0.6),
                  Colors.red.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.redAccent, width: 1.5),
            ),
            child: const Center(
              child: Text(
                'SCREEN',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),

          // Seat map with zoom and pan
          Expanded(
            child: InteractiveViewer(
              boundaryMargin: const EdgeInsets.all(50),
              minScale: 0.5,
              maxScale: 2.0,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildSeatGrid(context, ref, seats),
                ),
              ),
            ),
          ),

          // Footer information and checkout panel
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xFF1E1E1E),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${selectedSeats.length} Seats Selected',
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rp ${totalPrice.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE50914),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: selectedSeats.isEmpty
                      ? null
                      : () {
                          // Continue to payment or a simulated checkout view.
                        },
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Render the seat grid by row.
  Widget _buildSeatGrid(
    BuildContext context,
    WidgetRef ref,
    List<SeatModel> seats,
  ) {
    // Group seats by row (A, B, C, etc.).
    final Map<String, List<SeatModel>> groupedByRow = {};
    for (var seat in seats) {
      groupedByRow.putIfAbsent(seat.rowLabel, () => []).add(seat);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: groupedByRow.entries.map((entry) {
        final rowLabel = entry.key;
        final rowSeats = entry.value;

        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Row label on the left
              SizedBox(
                width: 24,
                child: Text(
                  rowLabel,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 8),
              // Seat buttons for this row
              ...rowSeats.map((seat) => _buildSeatButton(context, ref, seat)),
              const SizedBox(width: 8),
              // Optional row label on the right for visual balance
              SizedBox(
                width: 24,
                child: Text(
                  rowLabel,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // Individual seat button
  Widget _buildSeatButton(BuildContext context, WidgetRef ref, SeatModel seat) {
    Color buttonColor;
    Color textColor = Colors.white;

    switch (seat.status) {
      case SeatStatus.booked:
        buttonColor = Colors.grey[800]!;
        textColor = Colors.grey[600]!;
        break;
      case SeatStatus.selected:
        buttonColor = const Color(0xFFE50914);
        break;
      case SeatStatus.available:
      default:
        buttonColor = const Color(0xFF3F3F46);
        break;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 32,
      height: 32,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        onPressed: seat.status == SeatStatus.booked
            ? null
            : () {
                ref
                    .read(seatListProvider.notifier)
                    .toggleSeatSelection(seat.id);
              },
        child: Text(
          '${seat.seatNumber}',
          style: TextStyle(
            fontSize: 11,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
