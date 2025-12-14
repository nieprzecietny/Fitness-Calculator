package mx.collections
{
   import flash.events.IEventDispatcher;
   
   public interface IHierarchicalData extends IEventDispatcher
   {
       
      
      function canHaveChildren(param1:Object) : Boolean;
      
      function hasChildren(param1:Object) : Boolean;
      
      function getChildren(param1:Object) : Object;
      
      function getData(param1:Object) : Object;
      
      function getRoot() : Object;
   }
}
