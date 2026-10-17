 @isTest(SeeAllData=false)
 private class AccountDataControllerTest {
     @testSetup
     static void setupData() {
         List<Account> accounts = new List<Account>();
         for (Integer i = 1; i <= 15; i++) {
             accounts.add(new Account(
                 Name = 'Test Account ' + i,
                 Website = 'https://example.com/' + i,
                 Fax = '123-456-' + i
             ));
         }
         insert accounts;
     }
 
     static testmethod void testGetAccountsDefaultParams() {
         Test.startTest();
         List<Account> result = AccountDataController.getAccounts(null, null);
         Test.stopTest();
         System.assertEquals(5, result.size(), 'Default page size should be 5');
         System.assertEquals('Test Account 1', result[0].Name, 'First record should be first alphabetical');
     }
 
     static testmethod void testGetAccountsSpecificPage() {
         Test.startTest();
         List<Account> page2 = AccountDataController.getAccounts(5, 2);
         Test.stopTest();
         System.assertEquals(5, page2.size(), 'Page size 5 should return 5 records');
         System.assertEquals('Test Account 6', page2[0].Name, 'Second page should start with 6th record');
     }
 
     static testmethod void testGetAccountsEdgeCases() {
         Test.startTest();
         // pageNumber less than 1 should default to 1
         List<Account> result = AccountDataController.getAccounts(5, 0);
         Test.stopTest();
         System.assertEquals(5, result.size(), 'Page number less than 1 defaults to first page');
         System.assertEquals('Test Account 1', result[0].Name);
 
         // pageSize null defaults to 5
         List<Account> result2 = AccountDataController.getAccounts(null, 3);
         System.assertEquals(5, result2.size(), 'Null pageSize defaults to 5');
         System.assertEquals('Test Account 11', result2[0].Name);
     }
 
     static testmethod void testGetTotalAccountCount() {
         Test.startTest();
         Integer count = AccountDataController.getTotalAccountCount();
         Test.stopTest();
         System.assertEquals(15, count, 'Total account count should match inserted records');
     }
 }