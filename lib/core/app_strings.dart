abstract class AppStrings {
  static const String appTitle = 'PIZZERIA';
  static const String welcomeBack = 'Welcome back';
  static const String signInSubtitle = 'Sign in to order the best pizza around';
  static const String signInGoogle = 'Sign in with Google';
  static const String searchHint = 'Search pizza...';
  static const String cartTitle = 'CART';
  static const String cartEmpty = 'Your cart is empty';
  static const String totalLabel = 'Total:';
  static const String orderNow = 'Order Now';
  static const String orderPlaced = 'Order placed successfully!';
  static const String expectedDelivery = 'Expected delivery: 30-45 minutes';
  static const String backToMenu = 'Back to menu';
  static const String profileTitle = 'Profile';
  static const String guestUser = 'Guest';
  static const String noEmailAvailable = 'No email available';
  static const String logout = 'Logout';
  static const String orderHistoryLabel = 'Order History';
  static const String orderHistoryEmpty = 'You haven\'t ordered anything yet.';
  static const String delivered = 'Delivered';
  static const String orderDate = 'Date:';
  static String addedToCart(String pizzaName) => '$pizzaName added to cart!';
  static String orderNumber(String orderId) => 'Order #${orderId.substring(orderId.length - 5)}';
}
