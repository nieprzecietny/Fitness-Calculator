package mx.collections
{
   public interface IGroupingCollection2 extends IHierarchicalData
   {
       
      
      function get grouping() : Grouping;
      
      function set grouping(param1:Grouping) : void;
      
      function refresh(param1:Boolean = false, param2:Boolean = false) : Boolean;
      
      function cancelRefresh() : void;
   }
}
