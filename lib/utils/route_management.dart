import 'package:get/get.dart';
import 'package:liefermars/screens/account_screens/account_setting_screen.dart';
import 'package:liefermars/screens/account_screens/change_password_screen.dart';
import 'package:liefermars/screens/address_screens/my_address_screen.dart';
import 'package:liefermars/screens/auth_screens/forget_password_screen.dart';
import 'package:liefermars/screens/auth_screens/login_screen.dart';
import 'package:liefermars/screens/auth_screens/signup_screen.dart';
import 'package:liefermars/screens/dashboard_screens/filter_screen.dart';
import 'package:liefermars/screens/general_screens/credit_card_screen.dart';
import 'package:liefermars/screens/general_screens/data_privacy_screen.dart';
import 'package:liefermars/screens/general_screens/delivery_location_screen.dart';
import 'package:liefermars/screens/general_screens/inbox_screens.dart';
import 'package:liefermars/screens/general_screens/restaurant_general_terms_and_condition.dart';
import 'package:liefermars/screens/general_screens/review_screen.dart';
import 'package:liefermars/screens/general_screens/terms_and_condition_screen.dart';
import 'package:liefermars/screens/order_screens/order_detail_screen.dart';
import '../screens/account_screens/account_screen.dart';
import '../screens/account_screens/delete_account_screen.dart';
import '../screens/account_screens/profile_data_screen.dart';
import '../screens/account_screens/profile_screen.dart';
import '../screens/address_screens/edit_address_screen.dart';
import '../screens/auth_screens/reset_password_screen.dart';
import '../screens/auth_screens/splash_screen.dart';
import '../screens/auth_screens/welcome_screen.dart';
import '../screens/dashboard_screens/dashboard_screen.dart';
import '../screens/dashboard_screens/delivery_list_screen.dart';
import '../screens/dashboard_screens/delivery_screen.dart';
import '../screens/dashboard_screens/home_screen.dart';
import '../screens/dashboard_screens/pickup_screen.dart';
import '../screens/dashboard_screens/product_info_screen.dart';
import '../screens/dashboard_screens/restaurant_detail_screen.dart';
import '../screens/dashboard_screens/restaurant_information_screen.dart';
import '../screens/dashboard_screens/restaurant_review_screen.dart';
import '../screens/general_screens/become_a_partner_screen.dart';
import '../screens/general_screens/colophon_screen.dart';
import '../screens/general_screens/recommand_restaurant_screen.dart';
import '../screens/general_screens/submit_review_screen.dart';
import '../screens/general_screens/support_screen.dart';
import '../screens/order_screens/checkout_screen.dart';
import '../screens/order_screens/order_screen.dart';
import '../screens/order_screens/order_view_screen.dart';
import '../screens/order_screens/payment_done_screen.dart';
import '../screens/order_screens/payment_method_screen.dart';
import 'app_constants.dart';
import 'screen_bindings.dart';

class RouteGenerator {
  static List<GetPage> getPages() {
    return [
      GetPage(
        name: kSplashScreen,
        page: () => const SplashScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kLoginScreen,
        page: () => const LoginScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kSignupScreen,
        page: () => const SignUpScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kForgetPasswordScreen,
        page: () => const ForgetPasswordScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kAccountSettingScreen,
        page: () => const AccountSettingScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kAccountScreen,
        page: () => const AccountScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kChangePasswordScreen,
        page: () => const ChangePasswordScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kOrdersScreen,
        page: () => const OrdersScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kOrderDetailScreen,
        page: () => const OrderDetailScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kMyAddressScreen,
        page: () => const MyAddressScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kEditAddressScreen,
        page: () => const EditAddressScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kInboxScreen,
        page: () => const InboxScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kCreditCardScreen,
        page: () => const CreditCardScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kReviewScreen,
        page: () => const ReviewScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kDashboardScreen,
        page: () => const DashboardScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kHomeScreen,
        page: () => const HomeScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kPickUpScreen,
        page: () => const PickUpScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kDeliveryScreen,
        page: () => const DeliveryScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kFilterScreen,
        page: () => const FilterScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kTermsAndConditionScreen,
        page: () => const TermsAndConditionScreen(),
      ),
      GetPage(
        name: kDataPrivacyScreen,
        page: () => const DataPrivacyScreen(),
      ),
      GetPage(
        name: kColophonScreen,
        page: () => const ColophonScreen(),
      ),
      GetPage(
        name: kRestaurantGeneralTermsAndConditionScreen,
        page: () => const RestaurantGeneralTermsAndConditionScreen(),
      ),
      GetPage(
        name: kDeliveryLocationScreen,
        page: () => const DeliveryLocationScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kSubmitReviewScreen,
        page: () => const SubmitReviewScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kProfileScreen,
        page: () => const ProfileScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kSupportScreen,
        page: () => const SupportScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kRestaurantDetailScreen,
        page: () => const RestaurantDetailScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kRestaurantInformationScreen,
        page: () => const RestaurantInformationScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kOrderViewScreen,
        page: () => const OrderViewScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kCheckOutScreen,
        page: () => const CheckOutScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kPaymentMethodScreen,
        page: () => const PaymentMethodScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kProductInfoScreen,
        page: () => const ProductInfoScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kDeliveryListScreen,
        page: () => const DeliveryListScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kProfileDataScreen,
        page: () => const ProfileDataScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kResetPasswordScreen,
        page: () => const ResetPasswordScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kBecomeAPartnerScreen,
        page: () => const BecomeAPartnerScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kRecommendRestaurantScreen,
        page: () => const RecommendRestaurantScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kRestaurantReviewScreen,
        page: () => const RestaurantReviewScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kPaymentDoneScreen,
        page: () => const PaymentDoneScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kWelcomeScreen,
        page: () => const WelcomeScreen(),
        binding: ScreenBindings(),
      ),
      GetPage(
        name: kDeleteAccountScreen,
        page: () => const DeleteAccountScreen(),
        binding: ScreenBindings(),
      ),
    ];
  }
}
