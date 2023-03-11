extension CompactMap<T, E> on Map<T, E> {
  Iterable<V> compactMap<V>(V? Function(MapEntry<T, E>) f) sync* {
    for (final entry in entries) {
      final extracted = f(entry);
      if (extracted != null) {
        yield extracted;
      }
    }
  }
}
