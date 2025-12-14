package mx.controls.advancedDataGridClasses
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextLineMetrics;
   import mx.controls.AdvancedDataGrid;
   import mx.controls.listClasses.BaseListData;
   import mx.controls.listClasses.IDropInListItemRenderer;
   import mx.controls.listClasses.IListItemRenderer;
   import mx.core.ClassFactory;
   import mx.core.IDataRenderer;
   import mx.core.IFactory;
   import mx.core.IInvalidating;
   import mx.core.IToolTip;
   import mx.core.IUITextField;
   import mx.core.UIComponent;
   import mx.core.UITextField;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.ToolTipEvent;
   
   use namespace mx_internal;
   
   public class AdvancedDataGridHeaderRenderer extends UIComponent implements IDataRenderer, IDropInListItemRenderer, IListItemRenderer
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
       
      
      private var grid:AdvancedDataGrid;
      
      private var oldUnscaledWidth:Number = -1;
      
      private var partsSeparatorSkinClass:Class;
      
      private var partsSeparatorSkin:DisplayObject;
      
      private var sortItemRendererInstance:UIComponent;
      
      private var sortItemRendererChanged:Boolean = false;
      
      protected var label:IUITextField;
      
      protected var background:Sprite;
      
      private var _data:Object;
      
      private var _sortItemRenderer:IFactory;
      
      private var _listData:AdvancedDataGridListData;
      
      public function AdvancedDataGridHeaderRenderer()
      {
         super();
         tabEnabled = false;
         addEventListener(ToolTipEvent.TOOL_TIP_SHOW,this.toolTipShowHandler);
      }
      
      override public function get baselinePosition() : Number
      {
         return this.label.baselinePosition;
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
      
      public function get sortItemRenderer() : IFactory
      {
         return this._sortItemRenderer;
      }
      
      public function set sortItemRenderer(param1:IFactory) : void
      {
         this._sortItemRenderer = param1;
         this.sortItemRendererChanged = true;
         invalidateSize();
         invalidateDisplayList();
         dispatchEvent(new Event("sortItemRendererChanged"));
      }
      
      [Bindable("dataChange")]
      public function get listData() : BaseListData
      {
         return this._listData;
      }
      
      public function set listData(param1:BaseListData) : void
      {
         this._listData = AdvancedDataGridListData(param1);
         this.grid = AdvancedDataGrid(this._listData.owner);
         invalidateProperties();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         if(!this.label)
         {
            this.label = IUITextField(createInFontContext(UITextField));
            addChild(DisplayObject(this.label));
         }
         if(!this.background)
         {
            this.background = new UIComponent();
            addChild(this.background);
         }
      }
      
      override protected function commitProperties() : void
      {
         var _loc2_:AdvancedDataGridColumn = null;
         var _loc3_:Boolean = false;
         super.commitProperties();
         if(!initialized)
         {
            this.label.styleName = this;
         }
         if(!this.sortItemRendererInstance || this.sortItemRendererChanged)
         {
            if(!this.sortItemRenderer)
            {
               this.sortItemRenderer = ClassFactory(this.grid.sortItemRenderer);
            }
            if(this.sortItemRenderer)
            {
               this.sortItemRendererInstance = this.sortItemRenderer.newInstance();
               addChild(DisplayObject(this.sortItemRendererInstance));
            }
            this.sortItemRendererChanged = false;
         }
         var _loc1_:Class = this.partsSeparatorSkinClass;
         if(!this.partsSeparatorSkinClass || this.partsSeparatorSkinClass != this.grid.getStyle("headerSortSeparatorSkin"))
         {
            this.partsSeparatorSkinClass = this.grid.getStyle("headerSortSeparatorSkin");
         }
         if(this.grid.sortExpertMode || this.partsSeparatorSkinClass != _loc1_)
         {
            if(this.partsSeparatorSkin)
            {
               removeChild(this.partsSeparatorSkin);
            }
            if(!this.grid.sortExpertMode)
            {
               this.partsSeparatorSkin = new this.partsSeparatorSkinClass();
               addChild(this.partsSeparatorSkin);
            }
         }
         if(this.partsSeparatorSkin)
         {
            this.partsSeparatorSkin.visible = !(this._data is AdvancedDataGridColumnGroup);
         }
         if(this._data != null)
         {
            this.label.text = !!this.listData.label?this.listData.label:" ";
            this.label.multiline = this.grid.variableRowHeight;
            if(this._data is AdvancedDataGridColumn)
            {
               this.label.wordWrap = this.grid.columnHeaderWordWrap(this._data as AdvancedDataGridColumn);
            }
            else
            {
               this.label.wordWrap = this.grid.wordWrap;
            }
            if(this._data is AdvancedDataGridColumn)
            {
               _loc2_ = this._data as AdvancedDataGridColumn;
               _loc3_ = this.grid.showDataTips;
               if(_loc2_.showDataTips == true)
               {
                  _loc3_ = true;
               }
               if(_loc2_.showDataTips == false)
               {
                  _loc3_ = false;
               }
               if(_loc3_)
               {
                  if(this.label.textWidth > this.label.width || _loc2_.dataTipFunction || _loc2_.dataTipField || this.grid.dataTipFunction || this.grid.dataTipField)
                  {
                     toolTip = _loc2_.itemToDataTip(this._data);
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
         }
         else
         {
            this.label.text = " ";
            toolTip = null;
         }
         if(this.sortItemRendererInstance is IInvalidating)
         {
            IInvalidating(this.sortItemRendererInstance).invalidateProperties();
         }
      }
      
      override protected function measure() : void
      {
         var _loc12_:TextLineMetrics = null;
         super.measure();
         var _loc1_:int = getStyle("paddingLeft");
         var _loc2_:int = getStyle("paddingRight");
         var _loc3_:int = getStyle("paddingTop");
         var _loc4_:int = getStyle("paddingBottom");
         var _loc5_:Number = !!this.sortItemRendererInstance?Number(this.sortItemRendererInstance.getExplicitOrMeasuredWidth()):Number(0);
         var _loc6_:Number = !!this.sortItemRendererInstance?Number(this.sortItemRendererInstance.getExplicitOrMeasuredHeight()):Number(0);
         if(this.grid.sortExpertMode && this.getFieldSortInfo() == null)
         {
            _loc5_ = 0;
            _loc6_ = 0;
         }
         var _loc7_:Number = getStyle("horizontalGap");
         if(_loc5_ == 0)
         {
            _loc7_ = 0;
         }
         var _loc8_:Number = 0;
         var _loc9_:Number = 0;
         var _loc10_:Number = 0;
         var _loc11_:Number = 0;
         if(!isNaN(explicitWidth))
         {
            _loc10_ = explicitWidth;
            _loc8_ = _loc10_ - _loc5_ - _loc7_ - (!!this.partsSeparatorSkin?this.partsSeparatorSkin.width + 10:0) - _loc1_ - _loc2_;
            this.label.width = _loc8_;
            _loc9_ = this.label.textHeight + UITextField.TEXT_HEIGHT_PADDING;
         }
         else
         {
            _loc12_ = measureText(this.label.text);
            _loc8_ = _loc12_.width + UITextField.TEXT_WIDTH_PADDING;
            _loc9_ = _loc12_.height + UITextField.TEXT_HEIGHT_PADDING;
            _loc10_ = _loc8_ + _loc7_ + (!!this.partsSeparatorSkin?this.partsSeparatorSkin.width:0) + _loc5_;
         }
         _loc11_ = Math.max(_loc9_,_loc6_);
         _loc11_ = Math.max(_loc11_,!!this.partsSeparatorSkin?Number(this.partsSeparatorSkin.height):Number(0));
         _loc10_ = _loc10_ + (_loc1_ + _loc2_);
         _loc11_ = _loc11_ + (_loc3_ + _loc4_);
         measuredMinWidth = measuredWidth = _loc10_;
         measuredMinHeight = measuredHeight = _loc11_;
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         var _loc17_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         super.updateDisplayList(param1,param2);
         if(param1 == 0)
         {
            return;
         }
         var _loc3_:int = getStyle("paddingLeft");
         var _loc4_:int = getStyle("paddingRight");
         var _loc5_:int = getStyle("paddingTop");
         var _loc6_:int = getStyle("paddingBottom");
         var _loc7_:Number = !!this.sortItemRendererInstance?Number(this.sortItemRendererInstance.getExplicitOrMeasuredWidth()):Number(0);
         var _loc8_:Number = !!this.sortItemRendererInstance?Number(this.sortItemRendererInstance.getExplicitOrMeasuredHeight()):Number(0);
         if(this.sortItemRendererInstance)
         {
            this.sortItemRendererInstance.setActualSize(_loc7_,_loc8_);
         }
         if(this.grid.sortExpertMode && this.getFieldSortInfo() == null)
         {
            _loc7_ = 0;
            _loc8_ = 0;
         }
         var _loc9_:Number = getStyle("horizontalGap");
         if(_loc7_ == 0)
         {
            _loc9_ = 0;
         }
         var _loc10_:TextLineMetrics = measureText("w");
         var _loc11_:TextLineMetrics = measureText(this.label.text);
         var _loc12_:Number = _loc11_.width + UITextField.TEXT_WIDTH_PADDING;
         var _loc13_:int = param1 - _loc7_ - _loc9_ - _loc3_ - _loc4_;
         if(_loc13_ < 0)
         {
            _loc13_ = 0;
         }
         var _loc14_:Boolean = false;
         if(_loc13_ < _loc12_)
         {
            _loc14_ = true;
            _loc12_ = _loc13_;
         }
         var _loc15_:Number = this.label.textHeight + UITextField.TEXT_HEIGHT_PADDING;
         var _loc16_:int = param2 - _loc5_ - _loc6_;
         if(_loc16_ < _loc15_)
         {
            _loc14_ = true;
            _loc15_ = _loc16_;
         }
         this.label.setActualSize(_loc12_,_loc15_);
         if(_loc14_ && !this.label.multiline)
         {
            this.label.truncateToFit();
         }
         var _loc18_:String = getStyle("horizontalAlign");
         if(_loc18_ == "left")
         {
            _loc17_ = _loc3_;
         }
         else if(_loc18_ == "right")
         {
            _loc17_ = param1 - _loc4_ - _loc7_ - _loc9_ - _loc12_;
         }
         else
         {
            _loc17_ = (param1 - _loc12_ - _loc3_ - _loc4_ - _loc9_ - _loc7_) / 2 + _loc3_;
         }
         _loc17_ = Math.max(_loc17_,0);
         var _loc20_:String = getStyle("verticalAlign");
         if(_loc20_ == "top")
         {
            _loc19_ = _loc5_;
         }
         else if(_loc20_ == "bottom")
         {
            _loc19_ = param2 - _loc15_ - _loc6_ + 2;
         }
         else
         {
            _loc19_ = (param2 - _loc15_ - _loc6_ - _loc5_) / 2 + _loc5_;
         }
         _loc19_ = Math.max(_loc19_,0);
         this.label.x = Math.round(_loc17_);
         this.label.y = Math.round(_loc19_);
         if(this.sortItemRendererInstance)
         {
            _loc22_ = param1 - _loc7_ - _loc4_;
            _loc23_ = (param2 - _loc8_ - _loc5_ - _loc6_) / 2 + _loc5_;
            this.sortItemRendererInstance.x = Math.round(_loc22_);
            this.sortItemRendererInstance.y = Math.round(_loc23_);
         }
         graphics.clear();
         if(this.sortItemRendererInstance && !this.grid.sortExpertMode && !(this._data is AdvancedDataGridColumnGroup))
         {
            if(!this.partsSeparatorSkinClass)
            {
               graphics.lineStyle(1,getStyle("separatorColor") !== undefined?uint(getStyle("separatorColor")):uint(13421772));
               graphics.moveTo(this.sortItemRendererInstance.x - 1,1);
               graphics.lineTo(this.sortItemRendererInstance.x - 1,param2 - 1);
            }
            else
            {
               this.partsSeparatorSkin.x = this.sortItemRendererInstance.x - _loc9_ - this.partsSeparatorSkin.width;
               this.partsSeparatorSkin.y = (param2 - this.partsSeparatorSkin.height) / 2;
            }
         }
         if(this.data && parent)
         {
            if(!enabled)
            {
               _loc21_ = getStyle("disabledColor");
            }
            else if(this.grid.isItemHighlighted(this.listData.uid))
            {
               _loc21_ = getStyle("textRollOverColor");
            }
            else if(this.grid.isItemSelected(this.listData.uid))
            {
               _loc21_ = getStyle("textSelectedColor");
            }
            else
            {
               _loc21_ = getStyle("color");
            }
            this.label.setColor(_loc21_);
         }
         if(this.background)
         {
            this.background.graphics.clear();
            this.background.graphics.beginFill(16777215,0);
            this.background.graphics.drawRect(0,0,param1,param2);
            this.background.graphics.endFill();
            setChildIndex(DisplayObject(this.background),0);
         }
      }
      
      public function mouseEventToHeaderPart(param1:MouseEvent) : String
      {
         var _loc2_:Point = new Point(param1.stageX,param1.stageY);
         _loc2_ = globalToLocal(_loc2_);
         return _loc2_.x < this.sortItemRendererInstance.x?AdvancedDataGrid.HEADER_TEXT_PART:AdvancedDataGrid.HEADER_ICON_PART;
      }
      
      protected function getFieldSortInfo() : SortInfo
      {
         return this.grid.getFieldSortInfo(this.grid.columns[this.listData.columnIndex]);
      }
      
      protected function toolTipShowHandler(param1:ToolTipEvent) : void
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
      
      mx_internal function getLabel() : IUITextField
      {
         return this.label;
      }
   }
}
