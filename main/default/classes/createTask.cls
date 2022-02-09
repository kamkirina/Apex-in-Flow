
global with sharing class createTask {
    
    @InvocableMethod
global static void createTask(List<Account> newAcc) {

 //create New Task at New Account
 List<Task> createNewTask = New List<Task>();
 for(Account ac : newAcc)
 {
 Task newTask = New Task(Subject='Negotiations with '+ac.Name, WhatId=ac.Id);
 createNewTask.add(newTask);
 }
 insert createNewTask;
    }
}
