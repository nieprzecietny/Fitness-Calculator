package mx.controls.advancedDataGridClasses
{
   import flash.events.Event;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class AdvancedDataGridColumnGroup extends AdvancedDataGridColumn
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
       
      
      public var children:Array;
      
      public var childrenDragEnabled:Boolean = true;
      
      private var _width:Number = 100;
      
      public function AdvancedDataGridColumnGroup(param1:String = null)
      {
         this.children = [];
         super(param1);
      }
      
      override public function get width() : Number
      {
         if(this.children && this.children.length > 0)
         {
            return this._width;
         }
         return super.width;
      }
      
      override public function set width(param1:Number) : void
      {
         if(this.children && this.children.length > 0)
         {
            this._width = param1;
            dispatchEvent(new Event("widthChanged"));
         }
         else
         {
            super.width = param1;
         }
      }
      
      override protected function copyProperties(param1:AdvancedDataGridColumn) : void
      {
         super.copyProperties(param1);
         AdvancedDataGridColumnGroup(param1).childrenDragEnabled = this.childrenDragEnabled;
      }
      
      override public function clone() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumnGroup = new AdvancedDataGridColumnGroup();
         this.copyProperties(_loc1_);
         var _loc2_:int = this.children.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_.children[_loc3_] = this.children[_loc3_].clone();
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function itemToData(param1:Object) : *
      {
         var data:Object = param1;
         if(!data)
         {
            return null;
         }
         if(labelFunction != null)
         {
            data = labelFunction(data,this);
            return data;
         }
         if(typeof data == "object" || typeof data == "xml")
         {
            try
            {
               if(dataField != null)
               {
                  data = data[dataField];
               }
            }
            catch(e:Error)
            {
               data = null;
            }
         }
         return data;
      }
   }
}
