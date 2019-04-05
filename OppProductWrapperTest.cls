@isTest
private with sharing class OppProductWrapperTest {
    
    @isTest
    private static void parameterizedConstructorTest() {
        Test.startTest();
        OppProductWrapper wrapper = new OppProductWrapper('00k8E000007bfNyQAI', '01t8E000008DH4HQAW', '01u8E00000UeOq8QAF', 'test', 5, 5, 5, 5);
        Test.stopTest();
    }

    @isTest
    private static void emptyConstructorTest() {
        Test.startTest();
        OppProductWrapper wrapper = new OppProductWrapper();
        Test.stopTest();
    }

}