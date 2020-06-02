abstract class DAO<T> {
  Future<List<T>> findAll();

  Stream<List<T>> findAllStream();

  Future<T> findElementsById(int id);

  Future<T> deleteById(int id);
}
