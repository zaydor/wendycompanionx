import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:wendy_companion/modules/firebase_interactions.dart';
import 'models/spotify_data_models.dart';
import '../secrets.dart';

final Logger _logger = Logger();

void requestSpotifyCredentials() async {
  var client = http.Client();
  try {
    var response = await client.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'grant_type': 'client_credentials',
        'client_id': Secrets.spotifyClientId,
        'client_secret': Secrets.spotifyClientSecret,
      },
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var accessToken = jsonResponse['access_token'];

      // Fetch playlist using the access token
      Future<Playlist?> playlist = fetchPlaylist(accessToken);

      // convert playlist to json
      var playlistData = await playlist;
      var playlistJson = playlistData!.toJson(playlistData);
      var playlistTracks = playlistData.tracks.toJson(playlistData.tracks);

      _logger.i('playlistTracks: $playlistTracks');
      

      // var firebaseInteractions = FirebaseInteractions();
      // firebaseInteractions.setData('playlists', playlistJson);


      // firebaseInteractions.setData('tracks', playlistTracks);
      

      // push data to firebase
    } else {
      _logger.w('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    _logger.e('Error: $e');
  } finally {
    client.close();
  }
}

Future<Playlist?> fetchPlaylist(String accessToken) async {
  var client = http.Client();
  Playlist? playlist;
  List<TrackItem> allTracks = [];
  try {
    String? playlistUrl = 'https://api.spotify.com/v1/playlists/2vZX9OzU7tcqCt6TC4ZECE';

    while (true) {
      var playlistResponse = await client.get(
        Uri.parse(playlistUrl!),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (playlistResponse.statusCode == 200) {
        if (allTracks.isEmpty) {
          var playlistJson = jsonDecode(playlistResponse.body);
          playlist = Playlist.fromJson(playlistJson);
          allTracks.addAll(playlist.tracks.items);

          // Check if there are more tracks to fetch
          playlistUrl = playlist.tracks.next;
        } else {
          var playlistJson = jsonDecode(playlistResponse.body);
          Tracks tracks = Tracks.fromJson(playlistJson);
          allTracks.addAll(tracks.items);

          // Check if there are more tracks to fetch
          playlistUrl = tracks.next;
        }
        
        if (playlistUrl == null) {
          break;
        }
      } else {
        _logger.w('Failed to fetch playlist with status: ${playlistResponse.statusCode}');
        break;
      }
    }

    // Now you have all tracks in the playlist stored in `allTracks`
    _logger.i('Total tracks fetched: ${allTracks.length}');
  } catch (e) {
    _logger.e('Error: $e');
  } finally {
    client.close();
  }

  playlist?.tracks.items = allTracks;

  return playlist;
}