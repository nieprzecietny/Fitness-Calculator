package mx.controls.advancedDataGridClasses
{
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class SortInfo
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
      
      public static const PROPOSEDSORT:String = "proposedSort";
      
      public static const ACTUALSORT:String = "actualSort";
       
      
      public var sequenceNumber:int;
      
      public var descending:Boolean;
      
      public var status:String;
      
      public function SortInfo(param1:int = -1, param2:Boolean = false, param3:String = "actualSort")
      {
         super();
         this.sequenceNumber = param1;
         this.descending = param2;
         this.status = param3;
      }
   }
}
