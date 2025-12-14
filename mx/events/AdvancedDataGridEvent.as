package mx.events
{
   import flash.events.Event;
   import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
   import mx.controls.listClasses.IListItemRenderer;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class AdvancedDataGridEvent extends Event
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
      
      public static const ITEM_CLOSE:String = "itemClose";
      
      public static const ITEM_EDIT_BEGIN:String = "itemEditBegin";
      
      public static const ITEM_EDIT_END:String = "itemEditEnd";
      
      public static const ITEM_FOCUS_IN:String = "itemFocusIn";
      
      public static const ITEM_FOCUS_OUT:String = "itemFocusOut";
      
      public static const ITEM_EDIT_BEGINNING:String = "itemEditBeginning";
      
      public static const ITEM_OPEN:String = "itemOpen";
      
      public static const ITEM_OPENING:String = "itemOpening";
      
      public static const COLUMN_STRETCH:String = "columnStretch";
      
      public static const HEADER_DRAG_OUTSIDE:String = "headerDragOutside";
      
      public static const HEADER_DROP_OUTSIDE:String = "headerDropOutside";
      
      public static const HEADER_RELEASE:String = "headerRelease";
      
      public static const SORT:String = "sort";
       
      
      public var animate:Boolean;
      
      public var columnIndex:int;
      
      public var dataField:String;
      
      public var dispatchEvent:Boolean;
      
      public var item:Object;
      
      public var itemRenderer:IListItemRenderer;
      
      public var localX:Number;
      
      public var multiColumnSort:Boolean;
      
      public var removeColumnFromSort:Boolean;
      
      public var opening:Boolean;
      
      public var reason:String;
      
      public var rowIndex:int;
      
      public var triggerEvent:Event;
      
      public var column:AdvancedDataGridColumn;
      
      public var headerPart:String;
      
      public function AdvancedDataGridEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:int = -1, param5:String = null, param6:int = -1, param7:String = null, param8:IListItemRenderer = null, param9:Number = NaN, param10:Boolean = false, param11:Boolean = false, param12:Object = null, param13:Event = null, param14:String = null)
      {
         super(param1,param2,param3);
         this.columnIndex = param4;
         this.dataField = param5;
         this.rowIndex = param6;
         this.reason = param7;
         this.itemRenderer = param8;
         this.localX = param9;
         this.multiColumnSort = param10;
         this.removeColumnFromSort = param11;
         this.item = param12;
         this.triggerEvent = param13;
         this.headerPart = param14;
      }
      
      override public function clone() : Event
      {
         return new AdvancedDataGridEvent(type,bubbles,cancelable,this.columnIndex,this.dataField,this.rowIndex,this.reason,this.itemRenderer,this.localX,this.multiColumnSort,this.removeColumnFromSort,this.item,this.triggerEvent,this.headerPart);
      }
   }
}
