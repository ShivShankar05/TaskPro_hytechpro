public class TaskProHomePageController {
    
    public List<String> options2{get;set;}
    public Double acr{get;set;}
    public String obj{get;set;}
    public String userId {get;set;}
    public List<sObject> objList {get; set;}
    public  List<List<Task>> lstTask {get;set;}
    public  List<Task> Tsklist {get;set;}
    
    public List<SelectOption> getObjs()
    {
        List<Schema.SObjectType> obj = Schema.getGlobalDescribe().Values();    
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', '--None--'));
        for(Schema.SObjectType f : obj)
        {      
            options.add(new SelectOption(f.getDescribe().getName(),f.getDescribe().getName()));
            system.debug(obj);
        }
        
        return options;
    }
    
    public List<SelectOption> getUserList() 
    {
        List<SelectOption> UsersList = new List<SelectOption>();
        UsersList.add(new SelectOption('', '--None--'));
        
        for (User usr: [select Name from User]) 
        {
            UsersList.add(new SelectOption(usr.Id, usr.Name));
        }
        return UsersList;
    }  
    
    
    public Pagereference Records()
    {       
        Tsklist = new List<Task>();
        Tsklist = [SELECT WhatId,WhoId,OwnerId,AccountId,Id,Priority,Status,Subject FROM Task where (what.type =:obj) OR (who.type =:obj)];
       /*objList = Database.query(query1);
        
        Set<id> obId = new Set<id>();  
        Map<id,List<Task>> MpTask = new Map<id,List<Task>>();
        
        for(sObject s : objList)
        {
           
            MpTask.put(s.id, new List<Task>());
            
        }
        
        for(Task t1 : [SELECT WhatId,WhoId,OwnerId,AccountId,Id,Priority,Status,Subject FROM Task where whatId =:MpTask.keySet()])
        {
            if(MpTask.containsKey(t1.whatId))
            {
                List<Task> AllTask = MpTask.get(t1.whatId);
                AllTask.add(t1);
                MpTask.put(t1.whatId,AllTask);
                
            }
          
            
        }
        lstTask = new List<List<task>>(mptask.values());
        Tsklist = new List<Task>();
        
        
        for(List<Task> obj : lstTask)
        {
            for(Task obj1: obj)
            {
                Tsklist.add(obj1);
            }
        }*/
        return null;
    }
    
    public List<String> getStat()
    {
        List<String> options = new List<String>();
        Schema.DescribeFieldResult fieldResult = Task.Status.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
        for( Schema.PicklistEntry f : ple)
        {
            options.add(f.getValue());
        }      
        Acr = (12/(Options.size())); 
        
        return options;
    }
    
    public list<User> getUsrPhoto()
    {
       List<User> usr = new List<User>();
       usr = [SELECT Id,Name,FullPhotoUrl FROM User];
       return usr;
    }
    
    public List<PieWedgeData> getPieData() {
        List<PieWedgeData> data = new List<PieWedgeData>();
        integer i=0;
        for(Task opp:[select id,status from task where what.type=:obj]){
            data.add(new PieWedgeData(opp.status,i++));       
       }
       
        return data;
    }
  
  // Wrapper class
      public class PieWedgeData {

        public String name { get; set; }
        public integer data { get; set; }

        public PieWedgeData(String name, integer data) {
            this.name = name;
            this.data = data;
        }
    }
  
}