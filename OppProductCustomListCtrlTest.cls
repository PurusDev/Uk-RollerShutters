@isTest
private with sharing class OppProductCustomListCtrlTest {
    
    @isTest
    private static void getOppProductsTest() {
        Account acc = new Account(
            Name = 'TestAcc'
        );
        insert acc;
        
        Opportunity opp = new Opportunity(
            RecordTypeId = '0128E0000005yUZQAY',
            Name = 'TestOpp',
            CloseDate = Date.today().addDays(1),
            StageName = 'Survey',
            Pricebook2Id = Test.getStandardPricebookId()
        );
        insert opp;

        Product2 product = new Product2(
            Name = 'TestProduct'
        );
        insert product;

        PricebookEntry standardPrice = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(), 
            Product2Id = product.Id,
            UnitPrice = 10000, 
            IsActive = true
        );
        insert standardPrice;
        
        OpportunityLineItem oli = new OpportunityLineItem(
            OpportunityId = opp.Id,
            PricebookEntryId = standardPrice.Id,
            Quantity = 1,
            UnitPrice = 1
        );
        insert oli;

        Test.startTest();
        System.assertEquals(1, OppProductCustomListCtrl.getOppProducts(opp.Id).size());
        Test.stopTest();
    }

    @isTest
    private static void updateEntriesAndOpportunityProductsTest() {
        Account acc = new Account(
            Name = 'TestAcc'
        );
        insert acc;
        
        Opportunity opp = new Opportunity(
            RecordTypeId = '0128E0000005yUZQAY',
            Name = 'TestOpp',
            CloseDate = Date.today().addDays(1),
            StageName = 'Survey',
            Pricebook2Id = Test.getStandardPricebookId()
        );
        insert opp;

        Product2 product = new Product2(
            Name = 'TestProduct'
        );
        insert product;

        PricebookEntry standardPrice = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(), 
            Product2Id = product.Id,
            UnitPrice = 10000, 
            IsActive = true
        );
        insert standardPrice;
        
        OpportunityLineItem oli = new OpportunityLineItem(
            OpportunityId = opp.Id,
            PricebookEntryId = standardPrice.Id,
            Quantity = 1,
            UnitPrice = 1
        );
        insert oli;

        oli.UnitPrice = 50;

        Test.startTest();
        List<OpportunityLineItem> oliList = new List<OpportunityLineItem> { oli };
        List<PricebookEntry> pbEntriesList = new List<PricebookEntry> { standardPrice };
        System.assertEquals(true, OppProductCustomListCtrl.updateEntriesAndOpportunityProducts(JSON.serialize(pbEntriesList), JSON.serialize(oliList)));
        Test.stopTest();
    }

}