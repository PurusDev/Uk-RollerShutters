public with sharing class OppProductWrapper {

    @AuraEnabled
    public String oppProduct_entry { get; set; }
    @AuraEnabled
    public Id oppItemId { get; set; }
    @AuraEnabled
    public Id prodId { get; set; }
    @AuraEnabled
    public Id pbEntryId { get; set; }
    @AuraEnabled
    public String prodName { get; set; }
    @AuraEnabled
    public Decimal salesPrice { get; set; }
    @AuraEnabled
    public Decimal purchasePrice { get; set; }
    @AuraEnabled
    public Decimal margin { get; set; }
    @AuraEnabled
    public Decimal roi { get; set; }
    @AuraEnabled
    public String link { get; set; }

    public OppProductWrapper(Id oliId, Id productId, Id entryId, String name, Decimal salesP, Decimal purchaseP, Decimal marg, Decimal roiVal) {
        oppItemId = oliId;
        prodId = productId;
        pbEntryId = entryId;
        prodName = name;
        salesPrice = salesP;
        purchasePrice = purchaseP;
        margin = marg;
        roi = roiVal == null ? null : roiVal / 100;
        link = '/' + oppItemId;
        oppProduct_entry = oppItemId + ':' + entryId;
    }

    public OppProductWrapper() {}
    
}