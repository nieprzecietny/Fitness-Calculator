package mx.collections
{
   public interface IGroupingCollection extends IHierarchicalData
   {
       
      
      function get grouping() : Grouping;
      
      function set grouping(param1:Grouping) : void;
      
      function refresh(param1:Boolean = false) : Boolean;
      
      function cancelRefresh() : void;
   }
}
