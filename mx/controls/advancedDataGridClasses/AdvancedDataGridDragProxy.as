package mx.controls.advancedDataGridClasses
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import mx.collections.IGroupingCollection;
   import mx.collections.IGroupingCollection2;
   import mx.controls.AdvancedDataGrid;
   import mx.controls.listClasses.BaseListData;
   import mx.controls.listClasses.IDropInListItemRenderer;
   import mx.controls.listClasses.IListItemRenderer;
   import mx.core.UIComponent;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class AdvancedDataGridDragProxy extends UIComponent
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
       
      
      public function AdvancedDataGridDragProxy()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         var _loc5_:IListItemRenderer = null;
         var _loc6_:UIComponent = null;
         var _loc7_:Object = null;
         var _loc8_:Number = NaN;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:Point = null;
         var _loc12_:AdvancedDataGridColumn = null;
         var _loc13_:IListItemRenderer = null;
         var _loc14_:String = null;
         var _loc15_:AdvancedDataGridListData = null;
         var _loc16_:Number = NaN;
         var _loc17_:String = null;
         var _loc18_:AdvancedDataGridRendererDescription = null;
         super.createChildren();
         var _loc1_:AdvancedDataGrid = AdvancedDataGrid(owner);
         var _loc2_:Array = _loc1_.selectedItems;
         var _loc3_:int = _loc2_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _loc1_.itemToItemRenderer(_loc2_[_loc4_]);
            if(_loc5_)
            {
               _loc7_ = _loc2_[_loc4_];
               _loc6_ = new UIComponent();
               addChild(DisplayObject(_loc6_));
               _loc6_.layoutDirection = _loc1_.layoutDirection;
               _loc8_ = 0;
               _loc9_ = _loc1_.visibleColumns.length;
               _loc10_ = 0;
               while(_loc10_ < _loc9_)
               {
                  _loc12_ = _loc1_.visibleColumns[_loc10_];
                  _loc13_ = _loc1_.getRenderer(_loc12_,_loc7_,true);
                  _loc14_ = _loc12_.itemToLabel(_loc7_);
                  if(_loc1_._rootModel && _loc12_.colNum == 0 && _loc1_._rootModel.canHaveChildren(_loc7_))
                  {
                     if(_loc1_._rootModel is IGroupingCollection && IGroupingCollection(_loc1_._rootModel).grouping)
                     {
                        _loc17_ = IGroupingCollection(_loc1_._rootModel).grouping.label;
                     }
                     if(_loc1_._rootModel is IGroupingCollection2 && IGroupingCollection2(_loc1_._rootModel).grouping)
                     {
                        _loc17_ = IGroupingCollection2(_loc1_._rootModel).grouping.label;
                     }
                     if(_loc1_.groupLabelFunction != null)
                     {
                        _loc14_ = _loc1_.groupLabelFunction(_loc7_,_loc12_);
                     }
                     else if(_loc17_ != null && _loc7_.hasOwnProperty(_loc17_))
                     {
                        _loc14_ = _loc7_[_loc17_];
                     }
                  }
                  _loc15_ = new AdvancedDataGridListData(_loc14_,_loc12_.dataField,_loc12_.colNum,"",_loc1_);
                  if(_loc13_ is IDropInListItemRenderer)
                  {
                     IDropInListItemRenderer(_loc13_).listData = !!_loc7_?_loc15_:null;
                  }
                  _loc13_.data = _loc7_;
                  _loc13_.styleName = _loc1_;
                  _loc13_.visible = true;
                  _loc6_.addChild(DisplayObject(_loc13_));
                  _loc16_ = _loc1_.getWidthOfItem(_loc13_,_loc12_,_loc10_);
                  _loc13_.setActualSize(_loc16_,_loc5_.height);
                  _loc13_.move(_loc8_,0);
                  _loc8_ = _loc8_ + _loc16_;
                  if(_loc1_.rendererProviders.length != 0)
                  {
                     _loc18_ = _loc1_.getRendererDescription(_loc7_,_loc12_,true);
                     if(_loc18_ && _loc18_.renderer)
                     {
                        if(_loc18_.columnSpan == 0)
                        {
                           break;
                        }
                        _loc10_ = _loc10_ + (_loc18_.columnSpan - 1);
                     }
                  }
                  _loc10_++;
               }
               _loc6_.setActualSize(_loc8_,_loc5_.height);
               _loc11_ = new Point(0,0);
               _loc11_ = DisplayObject(_loc5_).localToGlobal(_loc11_);
               _loc11_ = AdvancedDataGrid(owner).globalToLocal(_loc11_);
               _loc6_.y = _loc11_.y;
               measuredHeight = _loc6_.y + _loc6_.height;
               measuredWidth = _loc8_;
            }
            _loc4_++;
         }
         invalidateDisplayList();
      }
      
      override protected function measure() : void
      {
         var _loc3_:UIComponent = null;
         super.measure();
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         var _loc4_:int = 0;
         while(_loc4_ < numChildren)
         {
            _loc3_ = getChildAt(_loc4_) as UIComponent;
            if(_loc3_)
            {
               _loc1_ = Math.max(_loc1_,_loc3_.x + _loc3_.width);
               _loc2_ = Math.max(_loc2_,_loc3_.y + _loc3_.height);
            }
            _loc4_++;
         }
         measuredWidth = measuredMinWidth = _loc1_;
         measuredHeight = measuredMinHeight = _loc2_;
      }
   }
}
