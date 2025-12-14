package mx.controls.advancedDataGridClasses
{
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class AdvancedDataGridBaseSelectionData
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
       
      
      mx_internal var nextSelectionData:AdvancedDataGridBaseSelectionData;
      
      mx_internal var prevSelectionData:AdvancedDataGridBaseSelectionData;
      
      public var approximate:Boolean;
      
      public var data:Object;
      
      public var rowIndex:int;
      
      public var columnIndex:int;
      
      public function AdvancedDataGridBaseSelectionData(param1:Object, param2:int, param3:int, param4:Boolean)
      {
         super();
         this.data = param1;
         this.rowIndex = param2;
         this.columnIndex = param3;
         this.approximate = param4;
      }
   }
}
