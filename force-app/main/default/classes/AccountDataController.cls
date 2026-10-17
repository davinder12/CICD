public with sharing class AccountDataController {
    /**
     * Retrieves a page of Account records.
     * @param pageSize Number of records per page (e.g., 5).
     * @param pageNumber 1‑based page index.
     * @return List of Account records for the requested page.
     */
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(Integer pageSize, Integer pageNumber) {
        if (pageSize == null) pageSize = 5;
        if (pageNumber == null || pageNumber < 1) pageNumber = 1;
        Integer offsetRows = (pageNumber - 1) * pageSize;
        return [SELECT Id, Name, Website, Fax FROM Account ORDER BY Name ASC LIMIT :pageSize OFFSET :offsetRows];
    }

    /**
     * Returns the total number of Account records in the org.
     */
    @AuraEnabled(cacheable=true)
    public static Integer getTotalAccountCount() {
        return [SELECT Count() FROM Account];
    }
}