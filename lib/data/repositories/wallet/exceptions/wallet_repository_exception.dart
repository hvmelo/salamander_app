class WalletRepositoryException implements Exception {
  const WalletRepositoryException(
      [this.message = 'An unknown error has ocurred']);

  /// The associated error message.
  final String message;
}

class CreateWalletFailure extends WalletRepositoryException {
  const CreateWalletFailure([String message = 'An unknown error has ocurred'])
      : super(message);

  factory CreateWalletFailure.fromCode(String code) {
    switch (code) {
      case 'write-wallet-error':
        return const CreateWalletFailure(
          'Error while creating the wallet. Please try again',
        );
      default:
        return const CreateWalletFailure();
    }
  }
}
