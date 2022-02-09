
global with sharing class updateTask {
    
    @InvocableMethod
    global static void updateTask(List<Account> newAcc) {

       // get IDs from SObjectScriptRow    
        set<Id> updateList = new set<Id>();
        for(Account acc : newAcc)
        {
            updateList.add(acc.Id);
        }
    

       
        AggregateResult[] groupedResult = [SELECT COUNT(Id) numberOfTask, WhatId FROM Task 
                                        WHERE WhatId IN : newAcc GROUP BY WhatId];   

    List<Id> updateTaskList = New List<Id>();
        //for numberOfTask grater than 3 create list of Tasks for update
    for(AggregateResult result : groupedResult)
    {
         if (Integer.valueOf(result.get('numberOfTask')) > 3){
          updateTaskList.add((Id)result.get('WhatId'));   }
    }

    // assign all Tasks to one user
    List<Task> updTask= [SELECT Id, LastModifiedById, OwnerId FROM Task WHERE WhatId IN: updateTaskList];
        for(Task ts: updTask )
    {  ts.OwnerId = ts.LastModifiedById;        
    }

    update updTask;
    
    }
}
