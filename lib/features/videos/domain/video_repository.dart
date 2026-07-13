import '../../../shared/models/content_models.dart';
import '../data/video_service.dart';

class VideoRepository {
  final VideoService _service;

  VideoRepository({VideoService? service})
      : _service = service ?? VideoService();

  Future<List<Video>> getAllVideos() => _service.getAllVideos();

  Future<List<Video>> getVideosByCategoria(String categoria) =>
      _service.getVideosByCategoria(categoria);

  Future<Video?> getVideoById(String id) => _service.getVideoById(id);

  Future<List<Video>> searchVideos(String query) =>
      _service.searchVideos(query);

  List<String> getCategorias() => _service.getCategorias();

  String getCategoriaLabel(String key) => _service.getCategoriaLabel(key);
}
