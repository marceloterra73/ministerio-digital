import '../../../shared/models/content_models.dart';
import '../data/podcast_service.dart';

class PodcastRepository {
  final PodcastService _service;

  PodcastRepository({PodcastService? service})
      : _service = service ?? PodcastService();

  Future<List<Podcast>> getAllPodcasts() => _service.getAllPodcasts();

  Future<List<Podcast>> getPodcastsByCategoria(String categoria) =>
      _service.getPodcastsByCategoria(categoria);

  Future<Podcast?> getPodcastById(String id) => _service.getPodcastById(id);

  Future<List<Podcast>> searchPodcasts(String query) =>
      _service.searchPodcasts(query);

  List<String> getCategorias() => _service.getCategorias();

  String getCategoriaLabel(String key) => _service.getCategoriaLabel(key);
}
