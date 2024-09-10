final class CustomerConstants {
  CustomerConstants._();

  /// Localhost Constant
  static String baseUrl = 'http://127.0.0.1:3000/api/customer';
  static String errorMessage = 'Failed to load customers';

  /// Add Customer Constants
  static String errorAddCustomer = 'Failed to add customer';
  static String addCustomerText = 'Create a New Customer';
  static String addCustomerTitle = 'Add Customer Page';
  static String addCustomerSuccess = 'Customer Added Successfully!';

  /// Update Customer Constants
  static String updateCustomerDropdownHint = 'Select Customer ID';
  static String updateCustomerButtonText = 'Update Customer Information';
  static String updateCustomerParagraph =
      'Select a Customer ID from the dropdown menu and change the customer informations.';
  static String updateCustomerSuccess = 'Customer Updated Successfully!';
  static String errorUpdateCustomer = 'Failed to update customer';
  static String updateCustomerTitle = 'Update Customer Page';
  static String routeUpdateCustomer = 'Update Customer Information';

  /// Delete Customer Constants
  static String deleteCustomerTitle = 'Delete Customer Page';
  static String deleteCustomerSuccess = 'Customer Deleted Successfully!';
  static String errorDeleteCustomer = 'Failed to delete customer';
  static String confirmDeleteCustomer = 'Confirm Delete';
  static String confirmDeleteCustomerMessage = 'Are you sure delete this customer?';

  /// Label Constants
  static String labelTextName = 'Customer Name';
  static String labelTextPhone = 'Customer Phone';
  static String labelTextAddress = 'Customer Address';
  static String labelTextEmail = 'Customer E-mail';
  static String labelTextOrderName = 'Order Name';
  static String labelTextOrderId = 'Order Id';

  /// Home Page Constants
  static String homeTitle = 'Customer App Home Page';

  /// Route Constants
  static String errorCustomerNotFound = 'Customers not found';
  static String routeAllCustomers = 'Show All Customers';
  static String routeAddCustomer = 'Add a Customer';
  static String routeDeleteCustomer = 'Delete Customer';

  static String customersTitle = 'Customers';
  static String errorFetchCustomer = 'Failed to fetch customers';
}
