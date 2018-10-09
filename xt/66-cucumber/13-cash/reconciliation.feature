@weasel
Feature: Reconciliation
  As a LedgerSMB user I want to be able to create a new bank reconciliation
  report, save it, review it and delete it.

Background:
  Given a standard test company
    And a logged in admin user

Scenario: Create new reconciliation report, update and save.
  When I navigate the menu and select the item at "Cash > Reconciliation"
  Then I should see the New Reconciliation Report screen.
  When I select "1060 Checking Account" from the drop down "Account"
   And I enter "100.00" into "Statement Balance"
   And I enter "2018-01-01" into "Statement Date"
   And I press "Create New Report"
  Then I should see the Reconciliation Report screen
   And I should see these Reconciliation Report headings:
       | Heading                     | Contents              |
       | Account                     | 1060 Checking Account |
       | Statement Date              | 2018-01-01            |
       | Beginning Statement Balance | 0.00                  |
       | Ending Statement Balance    | 100.00                |
       | Variance                    | -100.00               |
       | Less Outstanding Checks     | 0.00                  |
       | Ending GL Balance           | 100.00                |
       | Report Generated By         | test-user-admin       |
  When I change the "Ending Statement Balance" to "101.00"
   And I press "Update"
   And I wait for the page to load
  Then I should see the Reconciliation Report screen
   And I should see these Reconciliation Report headings:
       | Heading                     | Contents              |
       | Account                     | 1060 Checking Account |
       | Statement Date              | 2018-01-01            |
       | Beginning Statement Balance | 0.00                  |
       | Ending Statement Balance    | 101.00                |
       | Variance                    | -101.00               |
       | Less Outstanding Checks     | 0.00                  |
       | Ending GL Balance           | 101.00                |
       | Report Generated By         | test-user-admin       |
  When I press "Save"
  Then I should see the Search Reconciliation Reports screen

Scenario: Search for reconciliation report and delete it,
  When I navigate the menu and select the item at "Cash > Reports > Reconciliation"
  Then I should see the Search Reconciliation Reports screen
  When I press "Search"
  Then I should see the Reconciliation Search Report screen
   And I expect the report to contain 1 row
   And I expect the 'Account' report column to contain '1060 Checking Account' for Statement Date '2018-01-01'
   And I expect the 'Statement Balance' report column to contain '101.00' for Statement Date '2018-01-01'
   And I expect the 'Approved' report column to contain '0' for Statement Date '2018-01-01'
   And I expect the 'Submitted' report column to contain '0' for Statement Date '2018-01-01'
   And I expect the 'Entered By' report column to contain '1' for Statement Date '2018-01-01'
   And I expect the 'Approved By' report column to contain '' for Statement Date '2018-01-01'
  When I click the "2018-01-01" link
  Then I should see the Reconciliation Report screen
  When I press "Delete"
  Then I should see the Search Reconciliation Reports screen
  When I press "Search"
  Then I should see the Reconciliation Search Report screen
   And I expect the report to contain 0 rows

