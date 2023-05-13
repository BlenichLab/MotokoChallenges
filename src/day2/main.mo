import Text "mo:base/Text";
import Time "mo:base/Time";
import Buffer "mo:base/Buffer";
import Debug "mo:base/Debug";
import Result "mo:base/Result";
import Bool "mo:base/Bool";             



actor {

  public type Time = Time.Time;

 type Homework = {
        title : Text;
        description : Text;
        pending : Time;
        completed : Bool;
    };


  let homeworkDiary = Buffer.Buffer<Homework>(0);


    public func addHomework(hWork: Homework) : async Nat {
        homeworkDiary.add(hWork);
        return (homeworkDiary.size() -1);
    };

     public func getHomework(hWorkID: Nat) : async Result.Result<Homework, Text> {
        if(homeworkDiary.size() <= hWorkID){
           return #err "La ID buscada no existe";
        };
         let hWork = homeworkDiary.get(hWorkID);

         return #ok hWork;
    };

    public func updateHomework(hWorkID: Nat, newhWork : Homework) : async Result.Result<(), Text> {
        if(homeworkDiary.size() <= hWorkID){
           return #err "La ID buscada no existe";
        };
         homeworkDiary.put(hWorkID, newhWork);

         return #ok ();
    };

    public func markAsComplete(hWorkID: Nat) : async Result.Result<(), Text> {
        if(homeworkDiary.size() <= hWorkID){
           return #err "La ID buscada no existe";
        };
        var changeHomeWork : Homework = homeworkDiary.get(hWorkID);
        var completedHomeWork : Homework = {
            title = changeHomeWork.title;
            description = changeHomeWork.description;
            pending = changeHomeWork.pending;
            completed = true;
        };

        homeworkDiary.put(hWorkID, completedHomeWork);

         return #ok ();
    };

     public func deleteHomework(hWorkID: Nat) : async Result.Result<(), Text> {
        if(homeworkDiary.size() <= hWorkID){
           return #err "La ID buscada no existe";
        };

         let remove = homeworkDiary.remove(hWorkID);

         return #ok ();
    };



     public func getAllHomework() : async [Homework] {
  
         return Buffer.toArray<Homework>(homeworkDiary);
    };


    public func getPendingHomework() : async [Homework] {
          var pendingHomework = Buffer.clone(homeworkDiary);
          pendingHomework.filterEntries(func(_, homeWork) = homeWork.completed == false);

          return Buffer.toArray<Homework>(pendingHomework);
         
    };

     public func searchHomework(searchTerm : Text) : async [Homework] {
          
          
        var searchHWorktitle = Buffer.clone(homeworkDiary);
        searchHWorktitle.filterEntries(func(_, homeWork) = homeWork.title == searchTerm or homeWork.description == searchTerm);
         return Buffer.toArray<Homework>(searchHWorktitle);
    };


};
