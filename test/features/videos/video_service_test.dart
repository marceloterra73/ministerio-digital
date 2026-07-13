import 'package:flutter_test/flutter_test.dart';
import 'package:ministerio_digital/features/videos/data/video_service.dart';

void main() {
  final service = VideoService();

  group('VideoService', () {
    test('getAllVideos returns non-empty list', () async {
      final videos = await service.getAllVideos();
      expect(videos, isNotEmpty);
    });

    test('getVideosByCategoria filters correctly', () async {
      final videos = await service.getVideosByCategoria('estudo');
      expect(videos, isNotEmpty);
      for (final v in videos) {
        expect(v.categoria, equals('estudo'));
      }
    });

    test('getCategorias returns non-empty list', () {
      final categorias = service.getCategorias();
      expect(categorias, isNotEmpty);
      expect(categorias, contains('pregacao'));
      expect(categorias, contains('louvor'));
    });

    test('searchVideos finds by title', () async {
      final videos = await service.searchVideos('Graça');
      expect(videos, isNotEmpty);
      expect(
        videos.any((v) => v.titulo.toLowerCase().contains('graça')),
        isTrue,
      );
    });
  });
}
