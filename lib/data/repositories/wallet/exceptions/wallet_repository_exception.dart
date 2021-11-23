class CreateWalletFailure implements Exception {
  const CreateWalletFailure([
    this.message = 'An unknown exception occurred.',
  ]);

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

  /// The associated error message.
  final String message;
}
