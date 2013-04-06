/*
Author      : David Pier
Created Date: February 2013
Description : Test class for LeadFirstActivityDate Trigger
*/ 

@isTest
public class LeadFirstActivityDateTest {
    static testMethod void myUnitTest() {
        //Create a test Lead
        Lead ld = new Lead();
            ld.FirstName = 'TestFirstName';
            ld.LastName = 'TestLastName';
            ld.Company = 'TestCompany';
        insert ld;
        //Assert that First_Activity_Date__c = Null
        System.assertEquals(ld.First_Activity_Date__c, null);

        //Create a test user
        list<Profile> p1 = [SELECT Id FROM Profile WHERE Name like 'System Administrator'];
        
        User u1 = new User();
            u1.FirstName = 'fName';
            u1.LastName = 'lName';
            u1.Email = 'Test1234567@mail.com';
            u1.Username = 'Test1234567@mail.com';
            u1.Alias ='Test123';
            u1.CommunityNickname = 't123';
            u1.TimeZoneSidKey ='America/New_York';
            u1.LocaleSidKey = 'en_US';
            u1.EmailEncodingKey = 'UTF-8';
            u1.ProfileId = p1[0].id;
            u1.LanguageLocaleKey = 'en_US';
            u1.Country = 'United Kingdom';
        insert u1;

        /*
        //Create a test Contact
        Contact ct = new Contact();
            ct.FirstName = 'TestFirstName';
            ct.LastName = 'TestLastName';
        insert ct;
        */

        //Create a test Task
        Task tk = new Task();
            tk.Subject = 'TestSubject';
            tk.ActivityDate = date.today();
            tk.OwnerId = u1.Id;
            tk.Status = 'Completed';
            tk.WhoId = ld.Id;
        insert tk;

        //Assert that First_Activity_Date__c != null
        ld = [SELECT Id, First_Activity_Date__c FROM Lead WHERE Id = :ld.Id limit 1];
        System.assert(ld.First_Activity_Date__c != null);
    }
}