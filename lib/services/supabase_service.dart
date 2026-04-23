import 'package:supabase_flutter/supabase_flutter.dart';

import 'dart:math';

double calculateDistance(lat1, lon1, lat2, lon2) {
  const R = 6371;

  var dLat = (lat2 - lat1) * pi / 180;
  var dLon = (lon2 - lon1) * pi / 180;

  var a =
      sin(dLat / 2) * sin(dLat / 2) +
          cos(lat1 * pi / 180) *
              cos(lat2 * pi / 180) *
              sin(dLon / 2) *
              sin(dLon / 2);

  var c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return R * c;
}

class SupabaseService {
  final supabase = Supabase.instance.client;

  // ===============================
  // 🔍 FETCH AVAILABLE VENUES
  // ===============================
  Future<List<Map<String, dynamic>>> getAvailableVenues({
    required String location,
    required int guests,
  }) async {
    try {
      final response = await supabase
          .from('venues')
          .select()
          .ilike('location', '%$location%') // 🔥 FIX HERE
          .gte('capacity', guests)
          .eq('available', true);

      print("✅ Venues fetched: $response");

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print("❌ Error fetching venues: $e");
      return [];
    }
  }


  Future<List<Map<String, dynamic>>> getNearbyVenues({
    required double userLat,
    required double userLng,
    required int guests,
  }) async {
    final response = await supabase.from('venues').select();

    final List<Map<String, dynamic>> allVenues =
    List<Map<String, dynamic>>.from(response);

    final nearby = allVenues.where((venue) {
      final distance = calculateDistance(
        userLat,
        userLng,
        venue['latitude'],
        venue['longitude'],
      );

      venue['distance'] = distance; // 🔥 add distance to each venue

      return distance <= 20 &&
          venue['capacity'] >= guests &&
          venue['available'] == true;
    }).toList();

    // 👉 sort by nearest
    nearby.sort((a, b) => a['distance'].compareTo(b['distance']));

    return nearby;
  }

  // ===============================
  // 📝 INSERT BOOKING (later use)
  // ===============================
  Future<void> insertBooking({
    required String location,
    required String date,
    required int guests,
  }) async {
    try {
      await supabase.from('bookings').insert({
        'location': location,
        'event_date': date,
        'guests': guests,
      });

      print("✅ Booking inserted");
    } catch (e) {
      print("❌ Error inserting booking: $e");
    }
  }
}