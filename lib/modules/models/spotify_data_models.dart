class Playlist {
  final String description;
  final Followers followers;
  final String href;
  final String id;
  final List<Image> images;
  final String name;
  final Owner owner;
  final bool public;
  final Tracks tracks;
  final String type;
  final String uri;

  Playlist({
    required this.description,
    required this.followers,
    required this.href,
    required this.id,
    required this.images,
    required this.name,
    required this.owner,
    required this.public,
    required this.tracks,
    required this.type,
    required this.uri,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      description: json['description'],
      followers: Followers.fromJson(json['followers']),
      href: json['href'],
      id: json['id'],
      images: (json['images'] as List).map((i) => Image.fromJson(i)).toList(),
      name: json['name'],
      owner: Owner.fromJson(json['owner']),
      public: json['public'],
      tracks: Tracks.fromJson(json['tracks']),
      type: json['type'],
      uri: json['uri'],
    );
  }
}

class Followers {
  final String? href;
  final int total;

  Followers({this.href, required this.total});

  factory Followers.fromJson(Map<String, dynamic> json) {
    return Followers(
      href: json['href'],
      total: json['total'],
    );
  }
}

class Image {
  final String url;
  final int? height;
  final int? width;

  Image({required this.url, this.height, this.width});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      url: json['url'],
      height: json['height'],
      width: json['width'],
    );
  }
}

class Owner {
  final String href;
  final String id;
  final String uri;
  final String displayName;

  Owner({
    required this.href,
    required this.id,
    required this.uri,
    required this.displayName,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      href: json['href'],
      id: json['id'],
      uri: json['uri'],
      displayName: json['display_name'],
    );
  }
}

class Tracks {
  final String href;
  final int limit;
  final String? next;
  final int offset;
  final String? previous;
  final int total;
  final List<TrackItem> items;

  Tracks({
    required this.href,
    required this.limit,
    this.next,
    required this.offset,
    this.previous,
    required this.total,
    required this.items,
  });

  factory Tracks.fromJson(Map<String, dynamic> json) {
    return Tracks(
      href: json['href'],
      limit: json['limit'],
      next: json['next'],
      offset: json['offset'],
      previous: json['previous'],
      total: json['total'],
      items: (json['items'] as List).map((i) => TrackItem.fromJson(i)).toList(),
    );
  }
}

class TrackItem {
  final String addedAt;
  final AddedBy addedBy;
  final bool isLocal;
  final Track track;

  TrackItem({
    required this.addedAt,
    required this.addedBy,
    required this.isLocal,
    required this.track,
  });

  factory TrackItem.fromJson(Map<String, dynamic> json) {
    return TrackItem(
      addedAt: json['added_at'],
      addedBy: AddedBy.fromJson(json['added_by']),
      isLocal: json['is_local'],
      track: Track.fromJson(json['track']),
    );
  }
}

class AddedBy {
  final String href;
  final String id;
  final String uri;

  AddedBy({
    required this.href,
    required this.id,
    required this.uri,
  });

  factory AddedBy.fromJson(Map<String, dynamic> json) {
    return AddedBy(
      href: json['href'],
      id: json['id'],
      uri: json['uri'],
    );
  }
}

class Track {
  final Album album;
  final List<Artist> artists;
  final int durationMs;
  final String href;
  final String id;
  final String name;
  final int popularity;
  final String type;
  final String uri;
  final bool isLocal;

  Track({
    required this.album,
    required this.artists,
    required this.durationMs,
    required this.href,
    required this.id,
    required this.name,
    required this.popularity,
    required this.type,
    required this.uri,
    required this.isLocal,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      album: Album.fromJson(json['album']),
      artists: (json['artists'] as List).map((i) => Artist.fromJson(i)).toList(),
      durationMs: json['duration_ms'],
      href: json['href'],
      id: json['id'],
      name: json['name'],
      popularity: json['popularity'],
      type: json['type'],
      uri: json['uri'],
      isLocal: json['is_local'],
    );
  }
}

class Album {
  final String albumType;
  final int totalTracks;
  final String href;
  final String id;
  final List<Image> images;
  final String name;
  final String releaseDate;
  final String type;
  final String uri;
  final List<Artist> artists;

  Album({
    required this.albumType,
    required this.totalTracks,
    required this.href,
    required this.id,
    required this.images,
    required this.name,
    required this.releaseDate,
    required this.type,
    required this.uri,
    required this.artists,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      albumType: json['album_type'],
      totalTracks: json['total_tracks'],
      href: json['href'],
      id: json['id'],
      images: (json['images'] as List).map((i) => Image.fromJson(i)).toList(),
      name: json['name'],
      releaseDate: json['release_date'],
      type: json['type'],
      uri: json['uri'],
      artists: (json['artists'] as List).map((i) => Artist.fromJson(i)).toList(),
    );
  }
}

class Artist {
  final String href;
  final String id;
  final String name;
  final String uri;

  Artist({
    required this.href,
    required this.id,
    required this.name,
    required this.uri,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      href: json['href'],
      id: json['id'],
      name: json['name'],
      uri: json['uri'],
    );
  }
}