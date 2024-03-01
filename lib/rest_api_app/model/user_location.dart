class UserLocation {
  final String? city;
  final String? state;

  final String? country;
  final String? postcode;
  final LocationStreet? street;
  final LocationCoordinates? coordinates;
  final LocationTimeZone? timezone;

  UserLocation(
      {this.city,
      this.state,
      this.country,
      this.postcode,
      this.street,
      this.coordinates,
      this.timezone});

  factory UserLocation.fromMap(Map<String, dynamic> e) {
    final coordinates = LocationCoordinates(
      latitude: e['coordinates']['latitude'],
      longitude: e['coordinates']['longitude'],
    );
    final street = LocationStreet(
      name: e['street']['name'],
      number: e['street']['number'],
    );
    final timezone = LocationTimeZone(
      description: e['description'],
      offset: e['offset'],
    );
    return UserLocation(
      city: e['city'],
      coordinates: coordinates,
      country: e['country'],
      postcode: e['postcode'].toString(), //Some post code are string also
      state: e['state'],
      street: street,
      timezone: timezone,
    );
  }
}

class LocationCoordinates {
  final String? latitude;
  final String? longitude;

  LocationCoordinates({this.latitude, this.longitude});
}

class LocationTimeZone {
  final String? offset;
  final String? description;

  LocationTimeZone({this.offset, this.description});
}

class LocationStreet {
  final int? number;
  final String? name;

  LocationStreet({this.name, this.number});
}
