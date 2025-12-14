package mx.controls.advancedDataGridClasses
{
   import mx.controls.listClasses.IListItemRenderer;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class AdvancedDataGridHeaderInfo
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
       
      
      public var column:AdvancedDataGridColumn;
      
      public var parent:AdvancedDataGridHeaderInfo;
      
      public var index:int;
      
      public var depth:int;
      
      public var children:Array;
      
      public var headerItem:IListItemRenderer;
      
      public var internalLabelFunction:Function;
      
      public var columnSpan:int;
      
      public var actualColNum:int;
      
      public var visible:Boolean;
      
      public var visibleChildren:Array;
      
      public var visibleIndex:int;
      
      public function AdvancedDataGridHeaderInfo(param1:AdvancedDataGridColumn, param2:AdvancedDataGridHeaderInfo, param3:int, param4:int, param5:Array = null, param6:Function = null, param7:IListItemRenderer = null)
      {
         super();
         this.column = param1;
         this.parent = param2;
         this.index = param3;
         this.depth = param4;
         this.children = param5;
         this.internalLabelFunction = param6;
         this.headerItem = param7;
      }
   }
}
