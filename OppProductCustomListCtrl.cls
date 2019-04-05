public with sharing class OppProductCustomListCtrl {

    @AuraEnabled
    public static List<OppProductWrapper> getOppProducts(Id oppId) {
        // return [
        //     SELECT Name, Quantity, UnitPrice, Margin__c, MarginPercent__c, Purchase_Price_del__c
        //     FROM OpportunityLineItem
        //     WHERE OpportunityId = :oppId
        // ];
        Id pricebookId = [SELECT Pricebook2Id FROM Opportunity WHERE Id = :oppId].Pricebook2Id;

        List<OpportunityLineItem> oppItems = [
            SELECT UnitPrice, Name, Quantity, Margin__c, ROI__c, Product2Id
            FROM OpportunityLineItem
            WHERE OpportunityId = :oppId
        ];
        
        List<Id> prodIds = new List<Id>();
        for (OpportunityLineItem oli : oppItems) {
             prodIds.add(oli.Product2Id);           
        }

        List<PricebookEntry> pbEntries = [
            SELECT Purchase_Price__c, Product2Id
            FROM PricebookEntry
            WHERE Product2Id IN :prodIds
                AND Pricebook2Id = :pricebookId
        ];
        
        List<OppProductWrapper> wrappers = new List<OppProductWrapper>();
        for (OpportunityLineItem oli : oppItems) {
            for (PricebookEntry entry : pbEntries) {
                if (oli.Product2Id == entry.Product2Id) {
                    wrappers.add(new OppProductWrapper(oli.Id, oli.Product2Id, entry.Id, oli.Name, oli.UnitPrice, entry.Purchase_Price__c, oli.Margin__c, oli.ROI__c));
                }
            }
        }

        return wrappers;
    }

    // @AuraEnabled
    // public static Boolean updateOpportunityProducts(List<OpportunityLineItem> oppProducts) {
    //     try {
    //         update oppProducts;
    //         return true;
    //     } catch(Exception e) {
    //         System.debug(e.getMessage());
    //         return false;
    //     }
    // }
    
    @AuraEnabled
    public static Boolean updateEntriesAndOpportunityProducts(String entries, String oppItems) {
        try {
            List<OpportunityLineItem> parsedItems = (List<OpportunityLineItem>)System.JSON.deserialize(oppItems, List<OpportunityLineItem>.class);
            if (!parsedItems.isEmpty()) {
                update parsedItems;
            }

            List<PricebookEntry> parsedEntries = (List<PricebookEntry>)System.JSON.deserialize(entries, List<PricebookEntry>.class);
            if (!parsedEntries.isEmpty()) {
                update parsedEntries;
            }

            return true;
        } catch(Exception e) {
            System.debug(e.getMessage());
            return false;
        }
    }

}