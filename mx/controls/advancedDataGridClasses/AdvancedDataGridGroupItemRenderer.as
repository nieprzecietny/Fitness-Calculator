package mx.controls.advancedDataGridClasses
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import mx.controls.AdvancedDataGrid;
   import mx.controls.listClasses.BaseListData;
   import mx.controls.listClasses.IDropInListItemRenderer;
   import mx.controls.listClasses.IListItemRenderer;
   import mx.core.IDataRenderer;
   import mx.core.IFlexDisplayObject;
   import mx.core.IFlexModuleFactory;
   import mx.core.IFontContextComponent;
   import mx.core.ILayoutDirectionElement;
   import mx.core.IToolTip;
   import mx.core.IUITextField;
   import mx.core.SpriteAsset;
   import mx.core.UIComponent;
   import mx.core.UITextField;
   import mx.core.mx_internal;
   import mx.events.AdvancedDataGridEvent;
   import mx.events.FlexEvent;
   import mx.events.ToolTipEvent;
   
   use namespace mx_internal;
   
   public class AdvancedDataGridGroupItemRenderer extends UIComponent implements IDataRenderer, IDropInListItemRenderer, IListItemRenderer, IFontContextComponent
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
       
      
      private var listOwner:AdvancedDataGrid;
      
      protected var icon:IFlexDisplayObject;
      
      protected var label:IUITextField;
      
      private var _data:Object;
      
      protected var disclosureIcon:IFlexDisplayObject;
      
      private var _listData:AdvancedDataGridListData;
      
      public function AdvancedDataGridGroupItemRenderer()
      {
         super();
         mouseEnabled = false;
      }
      
      [Bindable("dataChange")]
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set data(param1:Object) : void
      {
         this._data = param1;
         invalidateProperties();
         dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
      }
      
      public function get fontContext() : IFlexModuleFactory
      {
         return moduleFactory;
      }
      
      public function set fontContext(param1:IFlexModuleFactory) : void
      {
         this.moduleFactory = param1;
      }
      
      [Bindable("dataChange")]
      public function get listData() : BaseListData
      {
         return this._listData;
      }
      
      public function set listData(param1:BaseListData) : void
      {
         this._listData = AdvancedDataGridListData(param1);
         invalidateProperties();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         this.createLabel(-1);
         addEventListener(ToolTipEvent.TOOL_TIP_SHOW,this.toolTipShowHandler);
      }
      
      override protected function commitProperties() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:AdvancedDataGridColumn = null;
         var _loc5_:Boolean = false;
         var _loc6_:Class = null;
         var _loc7_:* = undefined;
         var _loc8_:SpriteAsset = null;
         var _loc9_:Class = null;
         super.commitProperties();
         if(hasFontContextChanged() && this.label != null)
         {
            _loc3_ = getChildIndex(DisplayObject(this.label));
            this.removeLabel();
            this.createLabel(_loc3_);
         }
         if(this.icon)
         {
            _loc1_ = this.icon.x;
            removeChild(DisplayObject(this.icon));
            this.icon = null;
         }
         if(this.disclosureIcon)
         {
            _loc2_ = this.disclosureIcon.x;
            this.disclosureIcon.removeEventListener(MouseEvent.MOUSE_DOWN,this.disclosureMouseDownHandler);
            removeChild(DisplayObject(this.disclosureIcon));
            this.disclosureIcon = null;
         }
         if(this._data != null)
         {
            this.listOwner = AdvancedDataGrid(this._listData.owner);
            _loc4_ = this.listOwner.columns[this._listData.columnIndex];
            if(this._listData.disclosureIcon)
            {
               _loc6_ = this._listData.disclosureIcon;
               _loc7_ = new _loc6_();
               if(!(_loc7_ is InteractiveObject))
               {
                  _loc8_ = new SpriteAsset();
                  _loc8_.addChild(_loc7_ as DisplayObject);
                  this.disclosureIcon = _loc8_ as IFlexDisplayObject;
               }
               else
               {
                  this.disclosureIcon = _loc7_;
               }
               if(this.disclosureIcon is ILayoutDirectionElement)
               {
                  ILayoutDirectionElement(this.disclosureIcon).layoutDirection = null;
               }
               addChild(this.disclosureIcon as DisplayObject);
               if(_loc2_)
               {
                  this.disclosureIcon.x = _loc2_;
               }
               this.disclosureIcon.addEventListener(MouseEvent.MOUSE_DOWN,this.disclosureMouseDownHandler);
            }
            if(this._listData.icon)
            {
               _loc9_ = this._listData.icon;
               this.icon = new _loc9_();
               addChild(DisplayObject(this.icon));
               if(_loc1_)
               {
                  this.icon.x = _loc1_;
               }
            }
            this.label.text = this._listData.label;
            this.label.multiline = this.listOwner.variableRowHeight;
            this.label.wordWrap = this.listOwner.columnWordWrap(_loc4_);
            _loc5_ = this.listOwner.showDataTips;
            if(_loc4_.showDataTips == true)
            {
               _loc5_ = true;
            }
            if(_loc4_.showDataTips == false)
            {
               _loc5_ = false;
            }
            if(_loc5_)
            {
               if(!(this._data is AdvancedDataGridColumn) && (this.label.textWidth > this.label.width || _loc4_.dataTipFunction || _loc4_.dataTipField || this.listOwner.dataTipFunction || this.listOwner.dataTipField))
               {
                  toolTip = _loc4_.itemToDataTip(this._data);
               }
               else
               {
                  toolTip = null;
               }
            }
            else
            {
               toolTip = null;
            }
         }
         else
         {
            this.label.text = " ";
            toolTip = null;
         }
         invalidateDisplayList();
      }
      
      override protected function measure() : void
      {
         super.measure();
         var _loc1_:Number = !!this._data?Number(this._listData.indent):Number(0);
         if(this.disclosureIcon)
         {
            _loc1_ = _loc1_ + this.disclosureIcon.width;
         }
         if(this.icon)
         {
            _loc1_ = _loc1_ + this.icon.measuredWidth;
         }
         if(this.label.width < 4 || this.label.height < 4)
         {
            this.label.width = 4;
            this.label.height = 16;
         }
         if(isNaN(explicitWidth))
         {
            _loc1_ = _loc1_ + this.label.getExplicitOrMeasuredWidth();
            measuredWidth = _loc1_;
         }
         else
         {
            this.label.width = Math.max(explicitWidth - _loc1_,4);
         }
         measuredHeight = this.label.getExplicitOrMeasuredHeight();
         if(this.icon && this.icon.measuredHeight > measuredHeight)
         {
            measuredHeight = this.icon.measuredHeight;
         }
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         var _loc5_:Number = NaN;
         super.updateDisplayList(param1,param2);
         var _loc3_:Number = !!this._data?Number(this._listData.indent):Number(0);
         if(this.disclosureIcon)
         {
            this.disclosureIcon.x = _loc3_;
            _loc3_ = this.disclosureIcon.x + this.disclosureIcon.width;
            this.disclosureIcon.setActualSize(this.disclosureIcon.width,this.disclosureIcon.height);
            this.disclosureIcon.visible = !!this._data?Boolean(this._listData.hasChildren):false;
            if(this.disclosureIcon.visible)
            {
               this.disclosureIcon.visible = _loc3_ < param1;
            }
         }
         if(this.icon)
         {
            this.icon.x = _loc3_;
            _loc3_ = this.icon.x + this.icon.measuredWidth;
            this.icon.setActualSize(this.icon.measuredWidth,this.icon.measuredHeight);
            if(this.icon.x > param1)
            {
               this.icon.visible = false;
            }
            else if(_loc3_ > param1)
            {
               this.icon.setActualSize(param1 - this.icon.x,this.icon.measuredHeight);
            }
         }
         this.label.x = _loc3_;
         this.label.setActualSize(param1 - _loc3_,param2);
         var _loc4_:String = getStyle("verticalAlign");
         if(_loc4_ == "top")
         {
            this.label.y = 0;
            if(this.icon)
            {
               this.icon.y = 0;
            }
            if(this.disclosureIcon)
            {
               this.disclosureIcon.y = 0;
            }
         }
         else if(_loc4_ == "bottom")
         {
            this.label.y = param2 - this.label.height + 2;
            if(this.icon)
            {
               this.icon.y = param2 - this.icon.height;
            }
            if(this.disclosureIcon)
            {
               this.disclosureIcon.y = param2 - this.disclosureIcon.height;
            }
         }
         else
         {
            this.label.y = (param2 - this.label.height) / 2;
            if(this.icon)
            {
               this.icon.y = (param2 - this.icon.height) / 2;
            }
            if(this.disclosureIcon)
            {
               this.disclosureIcon.y = (param2 - this.disclosureIcon.height) / 2;
            }
         }
         if(this.data && parent)
         {
            if(!enabled)
            {
               _loc5_ = getStyle("disabledColor");
            }
            else if(this.listOwner.isItemHighlighted(this.listData.uid))
            {
               _loc5_ = getStyle("textRollOverColor");
            }
            else if(this.listOwner.isItemSelected(this.listData.uid))
            {
               _loc5_ = getStyle("textSelectedColor");
            }
            else
            {
               _loc5_ = getStyle("color");
            }
            this.label.setColor(_loc5_);
         }
      }
      
      protected function createLabel(param1:int) : void
      {
         if(!this.label)
         {
            this.label = IUITextField(createInFontContext(UITextField));
            this.label.styleName = this;
            if(param1 == -1)
            {
               addChild(DisplayObject(this.label));
            }
            else
            {
               addChildAt(DisplayObject(this.label),param1);
            }
         }
      }
      
      protected function removeLabel() : void
      {
         if(this.label != null)
         {
            removeChild(DisplayObject(this.label));
            this.label = null;
         }
      }
      
      private function toolTipShowHandler(param1:ToolTipEvent) : void
      {
         var _loc2_:IToolTip = param1.toolTip;
         var _loc3_:int = DisplayObject(systemManager).mouseX + 11;
         var _loc4_:int = DisplayObject(systemManager).mouseY + 22;
         var _loc5_:Point = new Point(_loc3_,_loc4_);
         _loc5_ = DisplayObject(systemManager).localToGlobal(_loc5_);
         _loc5_ = DisplayObject(systemManager.getSandboxRoot()).globalToLocal(_loc5_);
         _loc2_.move(_loc5_.x,_loc5_.y + (height - _loc2_.height) / 2);
         var _loc6_:Rectangle = _loc2_.screen;
         var _loc7_:Number = _loc6_.x + _loc6_.width;
         if(_loc2_.x + _loc2_.width > _loc7_)
         {
            _loc2_.move(_loc7_ - _loc2_.width,_loc2_.y);
         }
      }
      
      private function disclosureMouseDownHandler(param1:Event) : void
      {
         param1.stopPropagation();
         if(this.listOwner.isOpening || !this.listOwner.enabled)
         {
            return;
         }
         var _loc2_:Boolean = this._listData.open;
         this._listData.open = !_loc2_;
         this.listOwner.dispatchAdvancedDataGridEvent(AdvancedDataGridEvent.ITEM_OPENING,this._listData.item,this,param1,!_loc2_,true,true);
      }
      
      mx_internal function getLabel() : IUITextField
      {
         return this.label;
      }
      
      mx_internal function getDisclosureIcon() : IFlexDisplayObject
      {
         return this.disclosureIcon;
      }
   }
}
