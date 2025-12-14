package mx.charts.chartClasses
{
   import flash.display.DisplayObject;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.ui.Keyboard;
   import mx.charts.ChartItem;
   import mx.charts.LinearAxis;
   import mx.charts.events.ChartItemEvent;
   import mx.charts.styles.HaloDefaults;
   import mx.core.IFlexModuleFactory;
   import mx.core.IUIComponent;
   import mx.core.mx_internal;
   import mx.graphics.SolidColor;
   import mx.graphics.Stroke;
   import mx.styles.CSSStyleDeclaration;
   
   use namespace mx_internal;
   
   public class PolarChart extends ChartBase
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
       
      
      private var _moduleFactoryInitialized:Boolean = false;
      
      private var axisLayoutDirty:Boolean = true;
      
      private var _axisDirty:Boolean = false;
      
      private var _angularAxis:IAxis;
      
      public function PolarChart()
      {
         super();
         transforms = [new PolarTransform()];
         var _loc1_:LinearAxis = new LinearAxis();
         _loc1_.autoAdjust = false;
         this.angularAxis = _loc1_;
      }
      
      public function get angularAxis() : IAxis
      {
         return this._angularAxis;
      }
      
      public function set angularAxis(param1:IAxis) : void
      {
         _transforms[0].setAxis(PolarTransform.ANGULAR_AXIS,param1);
         this._angularAxis = param1;
         this._axisDirty = true;
         invalidateData();
         invalidateProperties();
      }
      
      public function get radialAxis() : IAxis
      {
         return _transforms[0].getAxis(PolarTransform.RADIAL_AXIS);
      }
      
      public function set radialAxis(param1:IAxis) : void
      {
         _transforms[0].setAxis(PolarTransform.RADIAL_AXIS,param1);
         this._axisDirty = true;
         invalidateData();
         invalidateProperties();
      }
      
      private function initStyles() : Boolean
      {
         HaloDefaults.init(styleManager);
         var polarChartStyle:CSSStyleDeclaration = HaloDefaults.createSelector("mx.charts.chartClasses.PolarChart",styleManager);
         polarChartStyle.defaultFactory = function():void
         {
            this.dataTipRenderer = DataTip;
            this.fill = new SolidColor(16777215,0);
            this.calloutStroke = new Stroke(8947848,2);
            this.fontSize = 10;
         };
         return true;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this._moduleFactoryInitialized)
         {
            return;
         }
         this._moduleFactoryInitialized = true;
         this.initStyles();
      }
      
      override protected function commitProperties() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         super.commitProperties();
         if(this._axisDirty == true)
         {
            _loc1_ = series.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               series[_loc2_].invalidateProperties();
               _loc2_++;
            }
            _loc1_ = annotationElements.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = annotationElements[_loc2_];
               if(_loc3_)
               {
                  if(_loc3_ is IDataCanvas)
                  {
                     _loc3_.invalidateProperties();
                  }
               }
               _loc2_++;
            }
            _loc1_ = backgroundElements.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = backgroundElements[_loc2_];
               if(_loc3_)
               {
                  if(_loc3_ is IDataCanvas)
                  {
                     _loc3_.invalidateProperties();
                  }
               }
               _loc2_++;
            }
            this._axisDirty = false;
         }
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         var _loc8_:int = 0;
         var _loc10_:DisplayObject = null;
         super.updateDisplayList(param1,param2);
         this._angularAxis.getLabelEstimate();
         var _loc3_:Number = getStyle("paddingLeft");
         var _loc4_:Number = getStyle("paddingRight");
         var _loc5_:Number = getStyle("paddingTop");
         var _loc6_:Number = getStyle("paddingBottom");
         var _loc7_:Rectangle = new Rectangle(_loc3_,_loc5_,param1 - _loc3_ - _loc4_,param2 - _loc5_ - _loc6_);
         var _loc9_:int = _transforms.length;
         _loc8_ = 0;
         while(_loc8_ < _loc9_)
         {
            _transforms[_loc8_].setSize(_loc7_.width,_loc7_.height);
            _loc8_++;
         }
         _loc9_ = allElements.length;
         _loc8_ = 0;
         while(_loc8_ < _loc9_)
         {
            _loc10_ = allElements[_loc8_];
            if(_loc10_ is IUIComponent)
            {
               (_loc10_ as IUIComponent).setActualSize(_loc7_.width,_loc7_.height);
            }
            else
            {
               _loc10_.width = _loc7_.width;
               _loc10_.height = _loc7_.height;
            }
            if(_loc10_ is Series)
            {
               PolarTransform((_loc10_ as Series).dataTransform).setSize(_loc7_.width,_loc7_.height);
            }
            if(_loc10_ is IDataCanvas)
            {
               PolarTransform((_loc10_ as Object).dataTransform).setSize(_loc7_.width,_loc7_.height);
            }
            _loc8_++;
         }
         if(_seriesHolder.mask)
         {
            _seriesHolder.mask.width = _loc7_.width;
            _seriesHolder.mask.height = _loc7_.height;
         }
         if(_backgroundElementHolder.mask)
         {
            _backgroundElementHolder.mask.width = _loc7_.width;
            _backgroundElementHolder.mask.height = _loc7_.height;
         }
         if(_annotationElementHolder.mask)
         {
            _annotationElementHolder.mask.width = _loc7_.width;
            _annotationElementHolder.mask.height = _loc7_.height;
         }
         _seriesHolder.move(_loc7_.left,_loc7_.top);
         _backgroundElementHolder.move(_loc7_.left,_loc7_.top);
         _annotationElementHolder.move(_loc7_.left,_loc7_.top);
         this.axisLayoutDirty = false;
         advanceEffectState();
      }
      
      override public function dataToLocal(... rest) : Point
      {
         var _loc2_:Object = {};
         var _loc3_:Array = [_loc2_];
         var _loc4_:int = rest.length;
         if(_loc4_ > 0)
         {
            _loc2_["d0"] = rest[0];
            _transforms[0].getAxis(PolarTransform.ANGULAR_AXIS).mapCache(_loc3_,"d0","v0");
         }
         if(_loc4_ > 1)
         {
            _loc2_["d1"] = rest[1];
            _transforms[0].getAxis(PolarTransform.RADIAL_AXIS).mapCache(_loc3_,"d1","v1");
         }
         _transforms[0].transformCache(_loc3_,"v0","s0","v1","s1");
         return new Point(_transforms[0].origin.x + Math.cos(_loc2_.s0) * _loc2_.s1,_transforms[0].origin.y - Math.sin(_loc2_.s0) * _loc2_.s1);
      }
      
      override public function localToData(param1:Point) : Array
      {
         var _loc2_:Number = param1.x - _transforms[0].origin.x;
         var _loc3_:Number = param1.y - _transforms[0].origin.y;
         var _loc4_:Number = this.calcAngle(_loc2_,_loc3_);
         var _loc5_:Number = Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_);
         var _loc6_:Array = _transforms[0].invertTransform(_loc4_,_loc5_);
         return _loc6_;
      }
      
      override protected function get dataRegion() : Rectangle
      {
         return getBounds(this);
      }
      
      override public function getLastItem(param1:String) : ChartItem
      {
         var _loc2_:ChartItem = null;
         if(_caretItem)
         {
            _loc2_ = Series(_caretItem.element).items[Series(_caretItem.element).items.length - 1];
         }
         else
         {
            _loc2_ = getPreviousSeriesItem(series);
         }
         return _loc2_;
      }
      
      override public function getFirstItem(param1:String) : ChartItem
      {
         var _loc2_:ChartItem = null;
         if(_caretItem)
         {
            _loc2_ = Series(_caretItem.element).items[0];
         }
         else
         {
            _loc2_ = getNextSeriesItem(series);
         }
         return _loc2_;
      }
      
      override public function getNextItem(param1:String) : ChartItem
      {
         if(param1 == ChartBase.HORIZONTAL)
         {
            return getNextSeriesItem(series);
         }
         if(param1 == ChartBase.VERTICAL)
         {
            return getNextSeries(series);
         }
         return null;
      }
      
      override public function getPreviousItem(param1:String) : ChartItem
      {
         if(param1 == ChartBase.HORIZONTAL)
         {
            return getPreviousSeriesItem(series);
         }
         if(param1 == ChartBase.VERTICAL)
         {
            return getPreviousSeries(series);
         }
         return null;
      }
      
      override protected function keyDownHandler(param1:KeyboardEvent) : void
      {
         if(selectionMode == "none")
         {
            return;
         }
         var _loc2_:ChartItem = null;
         var _loc3_:Boolean = false;
         switch(param1.keyCode)
         {
            case Keyboard.UP:
               _loc2_ = this.getNextItem(ChartBase.VERTICAL);
               break;
            case Keyboard.DOWN:
               _loc2_ = this.getPreviousItem(ChartBase.VERTICAL);
               break;
            case Keyboard.LEFT:
               _loc2_ = this.getPreviousItem(ChartBase.HORIZONTAL);
               break;
            case Keyboard.RIGHT:
               _loc2_ = this.getNextItem(ChartBase.HORIZONTAL);
               break;
            case Keyboard.END:
            case Keyboard.PAGE_DOWN:
               _loc2_ = this.getLastItem(ChartBase.HORIZONTAL);
               break;
            case Keyboard.HOME:
            case Keyboard.PAGE_UP:
               _loc2_ = this.getFirstItem(ChartBase.HORIZONTAL);
               break;
            case Keyboard.SPACE:
               handleSpace(param1);
               param1.stopPropagation();
               return;
         }
         if(_loc2_)
         {
            param1.stopPropagation();
            handleNavigation(_loc2_,param1);
         }
      }
      
      override mx_internal function handleShift(param1:ChartItem) : void
      {
         var _loc2_:Series = Series(_anchorItem.element);
         var _loc3_:Series = Series(param1.element);
         if(_loc2_ != _loc3_)
         {
            return;
         }
         var _loc4_:int = _loc2_.items.indexOf(_anchorItem);
         var _loc5_:int = _loc3_.items.indexOf(param1);
         var _loc6_:int = _loc2_.items.length;
         if(_loc4_ > _loc5_)
         {
            _loc4_ = 0;
            _loc5_ = _loc6_ - 1;
         }
         var _loc7_:ChartItem = _anchorItem;
         clearSelection();
         _anchorItem = _loc7_;
         var _loc8_:int = _loc4_;
         while(_loc8_ <= _loc5_)
         {
            _loc2_.addItemtoSelection(_loc2_.items[_loc8_]);
            _loc8_++;
         }
         _selectedSeries = _loc2_;
         _caretItem = param1;
      }
      
      override mx_internal function updateKeyboardCache() : void
      {
         var _loc2_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         var _loc10_:int = 0;
         var _loc1_:int = _transforms.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = _transforms[_loc3_].elements.length;
            _loc10_ = 0;
            while(_loc10_ < _loc2_)
            {
               if(_transforms[_loc3_].elements[_loc10_] is Series && getSeriesTransformState(_transforms[_loc3_].elements[_loc10_]) == true)
               {
                  return;
               }
               _loc10_++;
            }
            _loc3_++;
         }
         var _loc4_:Array = [];
         var _loc5_:Array = [];
         var _loc8_:Boolean = false;
         var _loc9_:int = 0;
         _loc1_ = series.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc6_ = series[_loc3_].items;
            if(_loc6_ && series[_loc3_].selectedItems.length > 0)
            {
               _loc8_ = true;
               _loc2_ = _loc6_.length;
               _loc10_ = 0;
               while(_loc10_ < _loc2_)
               {
                  _loc4_.push(_loc6_[_loc10_].item);
                  _loc10_++;
               }
               _loc9_ = _loc9_ + series[_loc3_].selectedItems.length;
               _loc2_ = series[_loc3_].selectedItems.length;
               _loc10_ = 0;
               while(_loc10_ < _loc2_)
               {
                  _loc7_ = _loc4_.indexOf(series[_loc3_].selectedItems[_loc10_].item);
                  if(_loc7_ != -1)
                  {
                     _loc5_.push(series[_loc3_].items[_loc7_]);
                  }
                  _loc10_++;
               }
               _loc4_ = [];
               series[_loc3_].emptySelectedItems();
            }
            _loc3_++;
         }
         if(_loc8_)
         {
            selectSpecificChartItems(_loc5_);
            if(_loc9_ != _loc5_.length)
            {
               dispatchEvent(new ChartItemEvent(ChartItemEvent.CHANGE,null,null,this));
            }
         }
      }
      
      private function calcAngle(param1:Number, param2:Number) : Number
      {
         var _loc4_:Number = NaN;
         var _loc3_:Number = Math.PI * 2;
         var _loc5_:Number = Math.atan(-param2 / param1);
         if(param1 < 0)
         {
            _loc4_ = _loc5_ + Math.PI;
         }
         else if(param2 < 0)
         {
            _loc4_ = _loc5_;
         }
         else
         {
            _loc4_ = _loc5_ + _loc3_;
         }
         return _loc4_;
      }
   }
}
