trigger updatePhonenumber on Contact (after insert,after update) {
	List<Account> updatedlists = new List<Account>();  //Triggers return a list 
    Set<Id> idsofacnt = new Set<Id>();       //Ids till new insert set
	for (Contact c : Trigger.new) {
		 idsofacnt.add(c.AccountId);
      }
    Map<Id,Account> aMap = new Map<Id,Account>([Select Id, Phone, (Select Id, Name from Contacts where Is_Primary__c = true) from Account where Id in :idsofacnt]);
    for (Contact c : Trigger.new) {

        if (c.Is_Primary__c && aMap.get(c.AccountId)!=null) {

            Account updacc = aMap.get(c.AccountId);

            updacc.Phone = c.phone;

       		updatedlists.add(updacc);
         }

}
    update updatedlists; //If not empty then update
}