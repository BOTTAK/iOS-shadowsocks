extension Result {
  
  /// Return only error if exists
  var error: Error? {
    switch self {
    case .success:
      return nil
    case .failure(let error):
      return error
    }
  }
}
