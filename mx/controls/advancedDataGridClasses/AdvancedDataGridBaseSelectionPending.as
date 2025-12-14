package mx.controls.advancedDataGridClasses
{
   import mx.collections.CursorBookmark;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class AdvancedDataGridBaseSelectionPending
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
       
      
      public var bookmark:CursorBookmark;
      
      public var index:int;
      
      public var anchorIndex:int;
      
      public var columnIndex:int;
      
      public var anchorColumnIndex:int;
      
      public var offset:int;
      
      public var placeHolder:CursorBookmark;
      
      public var stopData:Object;
      
      public var transition:Boolean;
      
      public function AdvancedDataGridBaseSelectionPending(param1:int, param2:int, param3:int, param4:int, param5:Object, param6:Boolean, param7:CursorBookmark, param8:CursorBookmark, param9:int)
      {
         super();
         this.index = param1;
         this.anchorIndex = param2;
         this.columnIndex = param3;
         this.stopData = param5;
         this.transition = param6;
         this.placeHolder = param7;
         this.bookmark = param8;
         this.offset = param9;
      }
   }
}
