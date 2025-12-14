package mx.charts.series
{
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import mx.charts.HitData;
   import mx.charts.chartClasses.DataDescription;
   import mx.charts.chartClasses.GraphicsUtilities;
   import mx.charts.chartClasses.IAxis;
   import mx.charts.chartClasses.InstanceCache;
   import mx.charts.chartClasses.PolarChart;
   import mx.charts.chartClasses.PolarTransform;
   import mx.charts.chartClasses.Series;
   import mx.charts.renderers.WedgeItemRenderer;
   import mx.charts.series.items.PieSeriesItem;
   import mx.charts.series.renderData.PieSeriesRenderData;
   import mx.charts.styles.HaloDefaults;
   import mx.collections.CursorBookmark;
   import mx.core.ClassFactory;
   import mx.core.ContextualClassFactory;
   import mx.core.IDataRenderer;
   import mx.core.IFactory;
   import mx.core.IFlexDisplayObject;
   import mx.core.IFlexModuleFactory;
   import mx.core.IUITextField;
   import mx.core.LayoutDirection;
   import mx.core.UIComponent;
   import mx.core.UITextField;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.graphics.IFill;
   import mx.graphics.IStroke;
   import mx.graphics.SolidColor;
   import mx.graphics.Stroke;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.ISimpleStyleClient;
   
   use namespace mx_internal;
   
   public class PieSeries extends Series
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
      
      private static const DROP_SHADOW_SIZE:Number = 6;
       
      
      private var _moduleFactoryInitialized:Boolean = false;
      
      private var _instanceCache:InstanceCache;
      
      private var _renderData:PieSeriesRenderData;
      
      private var _measuringField:IUITextField;
      
      private var _labelLayer:UIComponent;
      
      private var _labelCache:InstanceCache;
      
      private var _origin:Point;
      
      private var _radiusInPixelsAfterLabels:Number;
      
      private var _radiusInPixelsScaledForExplode:Number = 1;
      
      private var _innerRadiusInPixels:Number = 0;
      
      private var _innerRadiusInPixelsScaledForExplode:Number = 0;
      
      private var _maxExplodeRadiusRatio:Number = 0;
      
      private var _localFills:Array;
      
      private var _fillCount:int;
      
      private var _bAxesDirty:Boolean = false;
      
      private var _angularAxis:IAxis;
      
      private var _explodeRadius:Number = 0;
      
      private var _field:String = "";
      
      private var _1757871014_fillFunction:Function;
      
      private var _labelFunction:Function;
      
      private var _labelField:String;
      
      public var maxLabelRadius:Number = 0.6;
      
      private var _nameField:String = "";
      
      private var _outerRadius:Number = 1;
      
      private var _perWedgeExplodeRadius:Array;
      
      private var _reserveExplodeRadius:Number = 0;
      
      private var _startAngleRadians:Number = 0;
      
      public function PieSeries()
      {
         this._1757871014_fillFunction = this.defaultFillFunction;
         super();
         this._labelLayer = new UIComponent();
         this._labelLayer.styleName = this;
         this._labelCache = new InstanceCache(UITextField,this._labelLayer);
         this._labelCache.discard = true;
         this._labelCache.remove = true;
         this._labelCache.properties = {
            "autoSize":TextFieldAutoSize.LEFT,
            "selectable":false,
            "styleName":this
         };
         this.perWedgeExplodeRadius = [];
         this._instanceCache = new InstanceCache(null,this);
         this._instanceCache.properties = {"styleName":this};
         filters = [new DropShadowFilter(DROP_SHADOW_SIZE,45,0,60,DROP_SHADOW_SIZE,DROP_SHADOW_SIZE)];
         dataTransform = new PolarTransform();
      }
      
      override public function get items() : Array
      {
         return !!this._renderData?this._renderData.filteredCache:null;
      }
      
      override public function get labelContainer() : Sprite
      {
         return this._labelLayer;
      }
      
      override public function get legendData() : Array
      {
         var _loc3_:String = null;
         var _loc5_:PieSeriesLegendData = null;
         var _loc9_:PieSeriesItem = null;
         validateData();
         var _loc1_:Array = [];
         var _loc2_:Array = getStyle("fills");
         var _loc4_:int = 0;
         var _loc6_:IFactory = getStyle("legendMarkerRenderer");
         if(!_loc2_)
         {
            _loc2_ = [new SolidColor(0)];
         }
         var _loc7_:Array = !!this._renderData.filteredCache?this._renderData.filteredCache:this._renderData.cache;
         var _loc8_:int = _loc7_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc8_)
         {
            _loc9_ = _loc7_[_loc4_];
            _loc5_ = new PieSeriesLegendData();
            _loc5_.fill = GraphicsUtilities.fillFromStyle(_loc2_[_loc4_ % _loc2_.length]);
            if(this._nameField != null && this._nameField != "")
            {
               _loc5_.label = _loc9_.item[this._nameField];
            }
            else
            {
               _loc5_.label = null;
            }
            _loc5_.element = this;
            if(_loc6_)
            {
               _loc5_.marker = _loc6_.newInstance();
               if(_loc5_.marker is ISimpleStyleClient)
               {
                  (_loc5_.marker as ISimpleStyleClient).styleName = this;
               }
            }
            _loc1_[_loc4_] = _loc5_;
            _loc4_++;
         }
         return _loc1_;
      }
      
      override protected function get renderData() : Object
      {
         var _loc1_:Class = null;
         var _loc2_:PieSeriesRenderData = null;
         if(!this._renderData)
         {
            _loc1_ = this.renderDataType;
            _loc2_ = new _loc1_();
            _loc2_.cache = _loc2_.filteredCache = [];
            return _loc2_;
         }
         return this._renderData;
      }
      
      public function get angularAxis() : IAxis
      {
         return this._angularAxis;
      }
      
      public function set angularAxis(param1:IAxis) : void
      {
         this._angularAxis = param1;
         this._bAxesDirty = true;
         invalidateData();
      }
      
      public function get explodeRadius() : Number
      {
         return this._explodeRadius;
      }
      
      public function set explodeRadius(param1:Number) : void
      {
         this._explodeRadius = Math.max(0,Math.min(param1,1));
         invalidateData();
      }
      
      public function get field() : String
      {
         return this._field;
      }
      
      public function set field(param1:String) : void
      {
         this._field = param1;
         dataChanged();
      }
      
      public function get fillFunction() : Function
      {
         return this._fillFunction;
      }
      
      public function set fillFunction(param1:Function) : void
      {
         if(param1 == this._fillFunction)
         {
            return;
         }
         if(param1 != null)
         {
            this._fillFunction = param1;
         }
         else
         {
            this._fillFunction = this.defaultFillFunction;
         }
         invalidateDisplayList();
         legendDataChanged();
      }
      
      protected function get itemType() : Class
      {
         return PieSeriesItem;
      }
      
      public function get labelFunction() : Function
      {
         return this._labelFunction;
      }
      
      public function set labelFunction(param1:Function) : void
      {
         this._labelFunction = param1;
         invalidateDisplayList();
      }
      
      public function get labelField() : String
      {
         return this._labelField;
      }
      
      public function set labelField(param1:String) : void
      {
         this._labelField = param1;
         invalidateTransform();
      }
      
      public function get nameField() : String
      {
         return this._nameField;
      }
      
      public function set nameField(param1:String) : void
      {
         this._nameField = param1;
         dataChanged();
         legendDataChanged();
      }
      
      public function get outerRadius() : Number
      {
         return this._outerRadius;
      }
      
      public function set outerRadius(param1:Number) : void
      {
         this._outerRadius = param1;
         invalidateDisplayList();
      }
      
      public function get perWedgeExplodeRadius() : Array
      {
         return this._perWedgeExplodeRadius.concat();
      }
      
      public function set perWedgeExplodeRadius(param1:Array) : void
      {
         this._perWedgeExplodeRadius = param1.concat();
         var _loc2_:int = this._perWedgeExplodeRadius.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this._perWedgeExplodeRadius[_loc3_] = this._perWedgeExplodeRadius[_loc3_] is Number?Math.max(0,Math.min(this._perWedgeExplodeRadius[_loc3_],1)):undefined;
            _loc3_++;
         }
         invalidateData();
      }
      
      protected function get renderDataType() : Class
      {
         return PieSeriesRenderData;
      }
      
      public function get reserveExplodeRadius() : Number
      {
         return this._reserveExplodeRadius;
      }
      
      public function set reserveExplodeRadius(param1:Number) : void
      {
         this._reserveExplodeRadius = Math.max(0,Math.min(param1,1));
         invalidateData();
      }
      
      public function get startAngle() : Number
      {
         return this._startAngleRadians * 180 / Math.PI;
      }
      
      public function set startAngle(param1:Number) : void
      {
         var _loc2_:Number = 2 * Math.PI;
         this._startAngleRadians = param1 * Math.PI / 180 % _loc2_;
         if(param1 < 0)
         {
            this._startAngleRadians = this._startAngleRadians + _loc2_;
         }
         invalidateTransform();
      }
      
      private function initStyles() : Boolean
      {
         var pieFills:Array = null;
         HaloDefaults.init(styleManager);
         var seriesStyle:CSSStyleDeclaration = HaloDefaults.createSelector("mx.charts.series.PieSeries",styleManager);
         pieFills = [];
         var n:int = HaloDefaults.defaultFills.length;
         var i:int = 0;
         while(i < n)
         {
            pieFills[i] = HaloDefaults.defaultFills[i];
            i++;
         }
         seriesStyle.defaultFactory = function():void
         {
            this.calloutGap = 10;
            this.calloutStroke = new Stroke(0,0,1);
            this.fills = pieFills;
            this.innerRadius = 0;
            this.insideLabelSizeLimit = 9;
            this.itemRenderer = new ClassFactory(WedgeItemRenderer);
            this.labelPosition = "none";
            this.renderDirection = "counterClockwise";
            this.legendMarkerRenderer = new ClassFactory(PieSeriesLegendMarker);
            this.shadowDepth = 4;
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
         super.commitProperties();
         var _loc1_:Class = getStyle("textFieldClass");
         if(_loc1_ != null)
         {
            this._labelCache.factory = new ContextualClassFactory(_loc1_,moduleFactory);
         }
         else
         {
            this._labelCache.factory = new ContextualClassFactory(UITextField,moduleFactory);
         }
         if(dataTransform)
         {
            if(this._angularAxis)
            {
               dataTransform.setAxis(PolarTransform.ANGULAR_AXIS,this._angularAxis);
            }
         }
         var _loc2_:PolarChart = PolarChart(chart);
         if(_loc2_)
         {
            if(!this._angularAxis && dataTransform.axes[PolarTransform.ANGULAR_AXIS] != _loc2_.angularAxis)
            {
               PolarTransform(dataTransform).setAxis(PolarTransform.ANGULAR_AXIS,_loc2_.angularAxis);
            }
         }
         dataTransform.elements = [this];
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         this._measuringField = IUITextField(createInFontContext(UITextField));
         this._measuringField.visible = false;
         this._measuringField.styleName = this;
         this._measuringField.autoSize = TextFieldAutoSize.LEFT;
         addChild(DisplayObject(this._measuringField));
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         var _loc5_:int = 0;
         var _loc9_:PieSeriesItem = null;
         var _loc13_:IFlexDisplayObject = null;
         var _loc14_:Array = null;
         var _loc15_:Number = NaN;
         var _loc16_:Array = null;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:PieSeriesItem = null;
         var _loc20_:Rectangle = null;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         super.updateDisplayList(param1,param2);
         var _loc3_:PolarTransform = PolarTransform(dataTransform);
         var _loc4_:Graphics = graphics;
         _loc4_.clear();
         this._labelLayer.graphics.clear();
         if(!dataProvider)
         {
            this._labelCache.discard = true;
            this._labelCache.remove = true;
            this._labelCache.count = 0;
            this._labelCache.discard = false;
            this._labelCache.remove = false;
            return;
         }
         var _loc6_:PieSeriesRenderData = !!transitionRenderData?PieSeriesRenderData(transitionRenderData):this._renderData;
         if(!_loc6_ || !_loc6_.filteredCache)
         {
            return;
         }
         var _loc7_:Array = _loc6_.filteredCache;
         var _loc8_:int = _loc7_.length;
         if(_loc6_ == transitionRenderData && transitionRenderData.elementBounds)
         {
            _loc15_ = Math.PI * 2;
            _loc16_ = transitionRenderData.elementBounds;
            _loc8_ = _loc7_.length;
            _loc17_ = transitionRenderData.visibleRegion.left;
            _loc18_ = transitionRenderData.visibleRegion.right;
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc19_ = _loc7_[_loc5_];
               _loc20_ = _loc16_[_loc5_];
               _loc21_ = _loc20_.left;
               _loc22_ = _loc20_.width;
               if(_loc21_ < _loc17_)
               {
                  _loc22_ = Math.max(0,_loc22_ + _loc21_ - _loc17_);
                  _loc21_ = _loc17_;
               }
               else if(_loc21_ + _loc22_ > _loc18_)
               {
                  _loc21_ = Math.min(_loc18_,_loc21_);
                  _loc22_ = Math.max(0,_loc18_ - _loc21_);
               }
               _loc19_.startAngle = _loc21_;
               _loc19_.angle = _loc22_;
               _loc19_.innerRadius = _loc20_.top;
               _loc19_.outerRadius = _loc20_.bottom;
               _loc5_++;
            }
         }
         if(_loc6_.itemSum == 0)
         {
            this._labelCache.discard = true;
            this._labelCache.remove = true;
            this._labelCache.count = 0;
            this._labelCache.discard = false;
            this._labelCache.remove = false;
            this._instanceCache.count = 0;
            if(chart && (chart.showAllDataTips || chart.dataTipItemsSet))
            {
               chart.updateAllDataTips();
            }
            return;
         }
         var _loc10_:String = getStyle("labelPosition");
         if(getStyle("innerRadius") >= this._outerRadius || _loc6_ == transitionRenderData || _loc8_ == 0)
         {
            this._labelCache.discard = true;
            this._labelCache.remove = true;
            this._labelCache.count = 0;
            this._labelCache.discard = false;
            this._labelCache.remove = false;
         }
         else if(_loc10_ == "outside")
         {
            this.renderRadialLabels(_loc6_,_loc7_);
         }
         else if(_loc10_ == "inside" || _loc10_ == "insideWithCallout")
         {
            this.renderInternalLabels(_loc6_,_loc7_);
         }
         else if(_loc10_ == "callout")
         {
            this.renderCalloutLabels(_loc6_);
         }
         else
         {
            this._labelCache.discard = true;
            this._labelCache.remove = true;
            this._labelCache.count = 0;
            this._labelCache.discard = false;
            this._labelCache.remove = false;
         }
         var _loc11_:Array = getStyle("fills");
         var _loc12_:int = _loc11_.length;
         this._instanceCache.factory = getStyle("itemRenderer");
         this._instanceCache.count = _loc8_;
         _loc14_ = this._instanceCache.instances;
         _loc5_ = 0;
         while(_loc5_ < _loc8_)
         {
            _loc9_ = _loc7_[_loc5_];
            _loc13_ = _loc14_[_loc5_];
            _loc9_.fill = this.fillFunction(_loc9_,_loc5_);
            if(!_loc9_.fill)
            {
               _loc9_.fill = this.defaultFillFunction(_loc9_,_loc5_);
            }
            _loc13_.setActualSize(param1,param2);
            _loc9_.itemRenderer = _loc13_;
            (_loc13_ as IDataRenderer).data = _loc9_;
            if((_loc9_.itemRenderer as Object).hasOwnProperty("invalidateDisplayList"))
            {
               (_loc9_.itemRenderer as Object).invalidateDisplayList();
            }
            _loc5_++;
         }
         if(allSeriesTransform && chart)
         {
            chart.updateAllDataTips();
         }
      }
      
      override public function styleChanged(param1:String) : void
      {
         super.styleChanged(param1);
         if(param1 == null || param1 == "" || param1 == "fills")
         {
            invalidateDisplayList();
            legendDataChanged();
         }
         if(param1 == "labelPosition")
         {
            invalidateTransform();
         }
         if(param1 == "renderDirection")
         {
            invalidateTransform();
         }
         if(param1 == "itemRenderer")
         {
            this._instanceCache.remove = true;
            this._instanceCache.discard = true;
            this._instanceCache.count = 0;
            this._instanceCache.discard = false;
            this._instanceCache.remove = false;
         }
      }
      
      override public function notifyStyleChangeInChildren(param1:String, param2:Boolean) : void
      {
         super.notifyStyleChangeInChildren(param1,param2);
         this._labelLayer.styleChanged(param1);
         if(param2)
         {
            this._labelLayer.notifyStyleChangeInChildren(param1,param2);
         }
      }
      
      override public function getAllDataPoints() : Array
      {
         var _loc3_:uint = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc9_:PieSeriesItem = null;
         var _loc10_:Boolean = false;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:HitData = null;
         var _loc17_:Array = null;
         var _loc18_:Object = null;
         if(!this._renderData)
         {
            return [];
         }
         if(!this._renderData.filteredCache)
         {
            return [];
         }
         if(this._renderData.filteredCache.length == 0)
         {
            return [];
         }
         var _loc1_:Array = [];
         if(chart && chart.dataTipItemsSet && dataTipItems)
         {
            _loc1_ = dataTipItems;
         }
         else if(chart && chart.showAllDataTips && this._renderData.filteredCache)
         {
            _loc1_ = this._renderData.filteredCache;
         }
         else
         {
            _loc1_ = [];
         }
         var _loc2_:uint = _loc1_.length;
         var _loc4_:Number = this._innerRadiusInPixelsScaledForExplode;
         var _loc7_:String = getStyle("renderDirection");
         if(_loc7_ == "clockwise")
         {
            _loc6_ = this._renderData.filteredCache[_loc2_ - 1].startAngle;
         }
         else
         {
            _loc6_ = this._renderData.filteredCache[0].startAngle;
         }
         var _loc8_:Array = [];
         _loc3_ = 0;
         for(; _loc3_ < _loc2_; _loc3_++)
         {
            _loc9_ = _loc1_[_loc3_];
            if(this._renderData.filteredCache.indexOf(_loc9_) == -1)
            {
               _loc10_ = false;
               _loc11_ = this._renderData.filteredCache.length;
               _loc12_ = 0;
               while(_loc12_ < _loc11_)
               {
                  if(_loc9_.item == this._renderData.filteredCache[_loc12_].item)
                  {
                     _loc9_ = this._renderData.filteredCache[_loc12_];
                     _loc10_ = true;
                     break;
                  }
                  _loc12_++;
               }
               if(!_loc10_)
               {
                  continue;
               }
            }
            if(_loc9_)
            {
               _loc5_ = _loc9_.startAngle - _loc6_;
               if(_loc7_ == "clockwise")
               {
                  _loc13_ = _loc5_ + 2 * Math.PI - this._startAngleRadians + _loc9_.angle / 2;
               }
               else
               {
                  _loc13_ = _loc5_ + this._startAngleRadians + _loc9_.angle / 2;
               }
               _loc14_ = _loc9_.origin.x + Math.cos(_loc13_) * (_loc4_ + (this._radiusInPixelsScaledForExplode - _loc4_) * 0.5);
               _loc15_ = _loc9_.origin.y - Math.sin(_loc13_) * (_loc4_ + (this._radiusInPixelsScaledForExplode - _loc4_) * 0.5);
               _loc16_ = new HitData(createDataID(_loc9_.index),0,_loc14_,_loc15_,_loc9_);
               _loc16_.dataTipFunction = this.formatDataTip;
               _loc17_ = getStyle("fills");
               if(_loc17_)
               {
                  _loc18_ = PieSeriesItem(_loc16_.chartItem).fill;
                  _loc16_.contextColor = GraphicsUtilities.colorFromFill(_loc18_);
               }
               _loc8_.push(_loc16_);
               continue;
            }
         }
         return _loc8_;
      }
      
      override public function findDataPoints(param1:Number, param2:Number, param3:Number) : Array
      {
         var _loc7_:PieSeriesItem = null;
         var _loc13_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc17_:PieSeriesItem = null;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:HitData = null;
         var _loc24_:Array = null;
         var _loc25_:Object = null;
         if(interactive == false || !this._renderData)
         {
            return [];
         }
         var _loc4_:PolarTransform = PolarTransform(dataTransform);
         var _loc5_:int = this._renderData.filteredCache.length;
         var _loc6_:Point = _loc4_.origin;
         var _loc8_:Point = new Point(param1,param2);
         var _loc9_:Number = getStyle("innerRadius");
         var _loc10_:Number = this._innerRadiusInPixelsScaledForExplode;
         var _loc11_:Number = Math.PI * 2;
         if(_loc5_ == 0)
         {
            return [];
         }
         var _loc12_:Number = this.calcAngle(_loc8_.x - this._origin.x,_loc8_.y - this._origin.y);
         var _loc14_:String = getStyle("renderDirection");
         if(_loc14_ == "clockwise")
         {
            _loc13_ = this._renderData.filteredCache[_loc5_ - 1].startAngle;
         }
         else
         {
            _loc13_ = this._renderData.filteredCache[0].startAngle;
         }
         _loc12_ = _loc12_ - _loc13_;
         if(_loc12_ < 0)
         {
            _loc12_ = _loc12_ + _loc11_;
         }
         var _loc16_:int = 0;
         while(_loc16_ < _loc5_)
         {
            _loc17_ = this._renderData.filteredCache[_loc16_];
            _loc12_ = this.calcAngle(_loc8_.x - _loc17_.origin.x,_loc8_.y - _loc17_.origin.y);
            _loc12_ = _loc12_ - _loc13_;
            if(_loc12_ < 0)
            {
               _loc12_ = _loc12_ + _loc11_;
            }
            if(_loc14_ == "clockwise")
            {
               while(_loc12_ > _loc11_)
               {
                  _loc12_ = _loc12_ - _loc11_;
               }
            }
            _loc15_ = _loc17_.startAngle - _loc13_;
            if(_loc12_ >= _loc15_ && _loc12_ < _loc15_ + _loc17_.angle)
            {
               _loc7_ = _loc17_;
               break;
            }
            _loc16_++;
         }
         if(_loc7_)
         {
            _loc18_ = (param1 - _loc7_.origin.x) * (param1 - _loc7_.origin.x) + (param2 - _loc7_.origin.y) * (param2 - _loc7_.origin.y);
            _loc19_ = param3 * param3;
            if(_loc18_ < _loc10_ * _loc10_ - _loc19_ || _loc18_ > this._radiusInPixelsScaledForExplode * this._radiusInPixelsScaledForExplode + _loc19_)
            {
               return [];
            }
            if(_loc14_ == "clockwise")
            {
               _loc20_ = _loc15_ + 2 * Math.PI - this._startAngleRadians + _loc7_.angle / 2;
            }
            else
            {
               _loc20_ = _loc15_ + this._startAngleRadians + _loc7_.angle / 2;
            }
            _loc21_ = _loc7_.origin.x + Math.cos(_loc20_) * (_loc10_ + (this._radiusInPixelsScaledForExplode - _loc10_) * 0.5);
            _loc22_ = _loc7_.origin.y - Math.sin(_loc20_) * (_loc10_ + (this._radiusInPixelsScaledForExplode - _loc10_) * 0.5);
            _loc23_ = new HitData(createDataID(_loc7_.index),0,_loc21_,_loc22_,_loc7_);
            _loc23_.dataTipFunction = this.formatDataTip;
            _loc24_ = getStyle("fills");
            if(_loc24_)
            {
               _loc25_ = PieSeriesItem(_loc23_.chartItem).fill;
               _loc23_.contextColor = GraphicsUtilities.colorFromFill(_loc25_);
            }
            return [_loc23_];
         }
         return [];
      }
      
      override public function dataToLocal(... rest) : Point
      {
         var _loc2_:Object = {};
         var _loc3_:Array = [_loc2_];
         var _loc4_:int = rest.length;
         var _loc5_:PolarTransform = PolarTransform(dataTransform);
         if(_loc4_ > 0)
         {
            _loc2_["d0"] = rest[0];
            _loc5_.getAxis(PolarTransform.ANGULAR_AXIS).mapCache(_loc3_,"d0","v0");
         }
         if(_loc4_ > 1)
         {
            _loc2_["d1"] = rest[1];
            _loc5_.getAxis(PolarTransform.RADIAL_AXIS).mapCache(_loc3_,"d1","v1");
         }
         _loc5_.transformCache(_loc3_,"v0","s0","v1","s1");
         return new Point(_loc5_.origin.x + Math.cos(_loc2_.s0) * _loc2_.s1,_loc5_.origin.y - Math.sin(_loc2_.s0) * _loc2_.s1);
      }
      
      override public function localToData(param1:Point) : Array
      {
         var _loc2_:PolarTransform = PolarTransform(dataTransform);
         var _loc3_:Number = param1.x - _loc2_.origin.x;
         var _loc4_:Number = param1.y - _loc2_.origin.y;
         var _loc5_:Number = this.calcAngle(_loc3_,_loc4_);
         var _loc6_:Number = Math.sqrt(_loc3_ * _loc3_ + _loc4_ * _loc4_);
         var _loc7_:Array = _loc2_.invertTransform(_loc5_,_loc6_);
         return _loc7_;
      }
      
      override protected function updateData() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Class = null;
         var _loc1_:Class = this.renderDataType;
         this._renderData = new _loc1_();
         this._renderData.cache = [];
         if(dataProvider)
         {
            cursor.seek(CursorBookmark.FIRST);
            _loc2_ = 0;
            _loc3_ = this.itemType;
            while(!cursor.afterLast)
            {
               this._renderData.cache[_loc2_] = new _loc3_(this,cursor.current,_loc2_);
               _loc2_++;
               cursor.moveNext();
            }
            cacheDefaultValues(this._field,this._renderData.cache,"value");
         }
         super.updateData();
      }
      
      override protected function updateMapping() : void
      {
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         dataTransform.getAxis(PolarTransform.ANGULAR_AXIS).mapCache(this._renderData.cache,"value","number");
         var _loc1_:Number = 0;
         var _loc2_:int = this._renderData.cache.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this._renderData.cache[_loc3_].number;
            if(!isNaN(_loc4_))
            {
               _loc1_ = _loc1_ + this._renderData.cache[_loc3_].number;
            }
            _loc3_++;
         }
         this._renderData.itemSum = _loc1_;
         _loc1_ = _loc1_ / 100;
         if(_loc1_ == 0)
         {
            _loc1_ = 1;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this._renderData.cache[_loc3_].percentValue = this._renderData.cache[_loc3_].number / _loc1_;
            _loc3_++;
         }
         super.updateMapping();
      }
      
      override protected function updateFilter() : void
      {
         this._renderData.filteredCache = filterFunction(this._renderData.cache);
         legendDataChanged();
         super.updateFilter();
      }
      
      override protected function updateTransform() : void
      {
         var _loc3_:PieSeriesItem = null;
         var _loc4_:PieSeriesItem = null;
         var _loc5_:int = 0;
         var _loc11_:Object = null;
         var _loc15_:Number = NaN;
         var _loc17_:PieSeriesItem = null;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc1_:PolarTransform = PolarTransform(dataTransform);
         _loc1_.transformCache(this._renderData.filteredCache,"percentValue","angle",null,null);
         var _loc2_:int = this._renderData.filteredCache.length;
         if(_loc2_)
         {
            _loc3_ = this._renderData.filteredCache[0];
            _loc3_.startAngle = this._startAngleRadians;
            _loc5_ = 1;
            while(_loc5_ < _loc2_)
            {
               _loc4_ = this._renderData.filteredCache[_loc5_];
               _loc4_.startAngle = _loc3_.startAngle + _loc3_.angle;
               _loc3_ = _loc4_;
               _loc5_++;
            }
         }
         var _loc6_:PieSeriesRenderData = this._renderData;
         var _loc7_:Boolean = true;
         var _loc8_:Boolean = true;
         if(!_loc6_ || !_loc6_.filteredCache)
         {
            return;
         }
         var _loc9_:Array = _loc6_.filteredCache;
         var _loc10_:int = _loc9_.length;
         if(_loc10_ == 0)
         {
            this._labelCache.discard = true;
            this._labelCache.remove = true;
            this._labelCache.count = 0;
            this._labelCache.discard = false;
            this._labelCache.remove = false;
            return;
         }
         this._origin = _loc1_.origin;
         this._radiusInPixelsAfterLabels = _loc1_.radius - DROP_SHADOW_SIZE;
         if(this._perWedgeExplodeRadius && this._perWedgeExplodeRadius.length > 0)
         {
            _loc19_ = this._explodeRadius;
            if(isNaN(_loc19_))
            {
               _loc19_ = 0;
            }
            this._maxExplodeRadiusRatio = _loc19_;
            _loc5_ = 0;
            while(_loc5_ < _loc10_)
            {
               _loc20_ = this._perWedgeExplodeRadius[_loc5_] != null?Number(parseFloat(this._perWedgeExplodeRadius[_loc5_])):Number(0);
               if(isNaN(_loc20_))
               {
                  _loc20_ = 0;
               }
               this._maxExplodeRadiusRatio = Math.max(this._maxExplodeRadiusRatio,_loc19_ + _loc20_);
               _loc5_++;
            }
         }
         else if(!isNaN(this._explodeRadius) && this._explodeRadius != 0)
         {
            this._maxExplodeRadiusRatio = this._explodeRadius;
         }
         else
         {
            this._maxExplodeRadiusRatio = 0;
         }
         this._maxExplodeRadiusRatio = Math.max(this._maxExplodeRadiusRatio,this._reserveExplodeRadius);
         this._renderData.labelScale = 1;
         var _loc12_:String = getStyle("labelPosition");
         var _loc13_:Point = new Point(0,0);
         var _loc14_:Point = new Point(1,1);
         _loc13_ = localToGlobal(_loc13_);
         _loc14_ = localToGlobal(_loc14_);
         if(chart && chart.layoutDirection == LayoutDirection.RTL)
         {
            _loc15_ = _loc13_.x - _loc14_.x;
         }
         else
         {
            _loc15_ = _loc14_.x - _loc13_.x;
         }
         if(getStyle("fontSize") * _loc15_ < 2)
         {
            _loc12_ = "none";
         }
         if(getStyle("innerRadius") >= this._outerRadius)
         {
            this._renderData.labelData = null;
            this._labelCache.discard = true;
            this._labelCache.remove = true;
            this._labelCache.count = 0;
            this._labelCache.discard = false;
            this._labelCache.remove = false;
         }
         else if(_loc12_ == "outside")
         {
            this._renderData.labelData = this.measureRadialLabels(_loc9_);
         }
         else if(_loc12_ == "callout")
         {
            this._renderData.labelData = this.measureCalloutLabels(_loc9_);
         }
         else if(_loc12_ == "inside")
         {
            this._renderData.labelData = this.measureInternalLabels(false,_loc9_);
         }
         else if(_loc12_ == "insideWithCallout")
         {
            this._renderData.labelData = this.measureInternalLabels(true,_loc9_);
         }
         else
         {
            this._renderData.labelData = null;
            this._labelCache.discard = true;
            this._labelCache.remove = true;
            this._labelCache.count = 0;
            this._labelCache.discard = false;
            this._labelCache.remove = false;
         }
         var _loc16_:Number = getStyle("innerRadius");
         this._innerRadiusInPixels = this._radiusInPixelsAfterLabels * _loc16_;
         this._radiusInPixelsAfterLabels = this._radiusInPixelsAfterLabels * this._outerRadius;
         this._radiusInPixelsScaledForExplode = this._radiusInPixelsAfterLabels * (1 - this._maxExplodeRadiusRatio);
         this._innerRadiusInPixelsScaledForExplode = this._innerRadiusInPixels * (1 - this._maxExplodeRadiusRatio);
         var _loc18_:String = getStyle("renderDirection");
         if(this._perWedgeExplodeRadius && this._perWedgeExplodeRadius.length > 0 || this._explodeRadius != 0)
         {
            _loc8_ = false;
            _loc21_ = this.startAngle;
            _loc5_ = 0;
            while(_loc5_ < _loc10_)
            {
               _loc22_ = this.calculateExplodeRadiusForWedge(_loc5_);
               _loc17_ = _loc9_[_loc5_];
               if(!isNaN(_loc17_.startAngle))
               {
                  _loc21_ = _loc17_.startAngle;
               }
               _loc23_ = _loc9_[_loc5_].angle;
               if(_loc18_ == "clockwise")
               {
                  _loc24_ = 2 * Math.PI - (_loc23_ / 2 + _loc21_);
               }
               else
               {
                  _loc24_ = _loc23_ / 2 + _loc21_;
               }
               _loc17_.origin = new Point(this._origin.x + Math.cos(_loc24_) * _loc22_,this._origin.y + -Math.sin(_loc24_) * _loc22_);
               _loc21_ = _loc21_ + _loc23_;
               _loc5_++;
            }
         }
         if(_loc8_ || _loc7_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc17_ = _loc9_[_loc5_];
               if(_loc8_)
               {
                  _loc17_.origin = this._origin;
               }
               if(_loc7_)
               {
                  _loc17_.innerRadius = this._innerRadiusInPixelsScaledForExplode;
                  _loc17_.outerRadius = this._radiusInPixelsScaledForExplode;
               }
               _loc5_++;
            }
         }
         if(_loc18_ == "clockwise")
         {
            if(_loc2_)
            {
               _loc5_ = 0;
               while(_loc5_ < _loc2_)
               {
                  _loc17_ = this._renderData.filteredCache[_loc5_];
                  _loc17_.startAngle = 2 * Math.PI - (_loc17_.startAngle + _loc17_.angle);
                  _loc5_++;
               }
            }
         }
         super.updateTransform();
      }
      
      override public function getElementBounds(param1:Object) : void
      {
         var _loc5_:PieSeriesItem = null;
         var _loc2_:Array = [];
         var _loc3_:Array = param1.filteredCache;
         var _loc4_:int = _loc3_.length;
         var _loc6_:Number = Number.MAX_VALUE;
         var _loc7_:Number = Number.MIN_VALUE;
         var _loc8_:int = 0;
         while(_loc8_ < _loc4_)
         {
            _loc5_ = _loc3_[_loc8_];
            _loc2_.push(new Rectangle(_loc5_.startAngle,_loc5_.innerRadius,_loc5_.angle,_loc5_.outerRadius - _loc5_.innerRadius));
            _loc7_ = Math.max(_loc7_,_loc5_.startAngle + _loc5_.angle);
            _loc6_ = Math.min(_loc6_,_loc5_.startAngle);
            _loc8_++;
         }
         _loc5_ = _loc3_[_loc4_ - 1];
         param1.elementBounds = _loc2_;
         param1.bounds = new Rectangle(_loc6_,this._innerRadiusInPixelsScaledForExplode,_loc7_ - _loc6_,this._radiusInPixelsScaledForExplode - this._innerRadiusInPixelsScaledForExplode);
         param1.visibleRegion = new Rectangle(_loc6_,this._innerRadiusInPixelsScaledForExplode,_loc7_ - _loc6_,this._radiusInPixelsScaledForExplode - this._innerRadiusInPixelsScaledForExplode);
      }
      
      override public function beginInterpolation(param1:Object, param2:Object) : Object
      {
         var _loc9_:PieSeriesItem = null;
         var _loc10_:PieSeriesItem = null;
         var _loc3_:Object = initializeInterpolationData(param1.filteredCache,param2.filteredCache,{
            "angle":true,
            "startAngle":true,
            "innerRadius":true,
            "outerRadius":true
         },this.itemType,{
            "lastInvalidSrcValue":0,
            "lastInvalidSrcIndex":NaN,
            "lastInvalidDestValue":0,
            "lastInvalidDestIndex":NaN
         });
         var _loc4_:Point = PolarTransform(dataTransform).origin;
         var _loc5_:Array = param1.filteredCache;
         var _loc6_:Array = param2.filteredCache;
         var _loc7_:int = Math.max(_loc5_.length,_loc6_.length);
         var _loc8_:int = Math.min(_loc5_.length,_loc6_.length);
         var _loc11_:int = 0;
         while(_loc11_ < _loc8_)
         {
            _loc10_ = _loc6_[_loc11_];
            _loc9_ = _loc5_[_loc11_];
            _loc3_.interpolationSource[_loc11_].origin = _loc9_.origin;
            _loc3_.deltaCache[_loc11_].origin = new Point(_loc10_.origin.x - _loc9_.origin.x,_loc10_.origin.y - _loc9_.origin.y);
            _loc3_.cache[_loc11_].origin = _loc9_.origin.clone();
            _loc11_++;
         }
         if(_loc8_ < _loc5_.length)
         {
            _loc11_ = _loc8_;
            while(_loc11_ < _loc7_)
            {
               _loc9_ = _loc5_[_loc11_];
               _loc3_.interpolationSource[_loc11_].origin = _loc9_.origin;
               _loc3_.deltaCache[_loc11_].origin = new Point(_loc4_.x - _loc9_.origin.x,_loc4_.y - _loc9_.origin.y);
               _loc3_.cache[_loc11_].origin = _loc9_.origin.clone();
               _loc11_++;
            }
         }
         else
         {
            _loc11_ = _loc8_;
            while(_loc11_ < _loc7_)
            {
               _loc10_ = _loc6_[_loc11_];
               _loc3_.interpolationSource[_loc11_].origin = _loc4_;
               _loc3_.deltaCache[_loc11_].origin = new Point(_loc10_.origin.x - _loc4_.x,_loc10_.origin.y - _loc4_.y);
               _loc3_.cache[_loc11_].origin = _loc4_.clone();
               _loc11_++;
            }
         }
         var _loc12_:Object = param2.clone();
         _loc12_.cache = _loc3_.cache;
         _loc12_.filteredCache = _loc3_.cache;
         transitionRenderData = _loc12_;
         return _loc3_;
      }
      
      override public function interpolate(param1:Array, param2:Object) : void
      {
         var _loc9_:Number = NaN;
         var _loc10_:PieSeriesItem = null;
         var _loc11_:PieSeriesItem = null;
         var _loc12_:PieSeriesItem = null;
         super.interpolate(param1,param2);
         var _loc3_:int = param1.length;
         var _loc4_:Array = param2.interpolationSource;
         var _loc5_:Array = param2.deltaCache;
         var _loc6_:Array = param2.cache;
         var _loc7_:Object = param2.properties;
         _loc3_ = _loc6_.length;
         var _loc8_:int = 0;
         while(_loc8_ < _loc3_)
         {
            _loc9_ = param1[_loc8_];
            _loc10_ = _loc4_[_loc8_];
            _loc11_ = _loc5_[_loc8_];
            _loc12_ = _loc6_[_loc8_];
            _loc12_.origin.x = _loc10_.origin.x + _loc11_.origin.x * _loc9_;
            _loc12_.origin.y = _loc10_.origin.y + _loc11_.origin.y * _loc9_;
            _loc8_++;
         }
      }
      
      override protected function getMissingInterpolationValues(param1:Object, param2:Array, param3:Object, param4:Array, param5:Number, param6:Object) : void
      {
         var _loc7_:* = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         for(_loc7_ in param1)
         {
            _loc8_ = param1[_loc7_];
            _loc9_ = param3[_loc7_];
            if(_loc7_ == "startAngle")
            {
               if(isNaN(_loc8_))
               {
                  if(param6.lastInvalidSrcIndex != param5 - 1)
                  {
                     if(param5 == 0)
                     {
                        _loc11_ = param2.length;
                        _loc10_ = 0;
                        while(_loc10_ < _loc11_)
                        {
                           if(param2[_loc10_] != null && !isNaN(param2[_loc10_].startAngle))
                           {
                              param6.lastInvalidSrcValue = param2[_loc10_].startAngle + param2[_loc10_].angle;
                              break;
                           }
                           _loc10_++;
                        }
                     }
                     else
                     {
                        _loc10_ = param5 - 1;
                        while(_loc10_ >= 0)
                        {
                           if(param2[_loc10_] != null && !isNaN(param2[_loc10_].startAngle))
                           {
                              param6.lastInvalidSrcValue = param2[_loc10_].startAngle + param2[_loc10_].angle;
                              break;
                           }
                           _loc10_--;
                        }
                     }
                  }
                  _loc8_ = param6.lastInvalidSrcValue;
                  param6.lastInvalidSrcIndex = param5;
               }
               if(isNaN(_loc9_))
               {
                  if(param6.lastInvalidDestIndex != param5 - 1)
                  {
                     if(param5 == 0)
                     {
                        _loc11_ = param4.length;
                        _loc10_ = 0;
                        while(_loc10_ < _loc11_)
                        {
                           if(param4[_loc10_] != null && !isNaN(param4[_loc10_].startAngle))
                           {
                              param6.lastInvalidDestValue = param4[_loc10_].startAngle + param4[_loc10_].angle;
                              break;
                           }
                           _loc10_++;
                        }
                     }
                     else
                     {
                        _loc10_ = param5 - 1;
                        while(_loc10_ >= 0)
                        {
                           if(param4[_loc10_] != null && !isNaN(param4[_loc10_].startAngle))
                           {
                              param6.lastInvalidDestValue = param4[_loc10_].startAngle + param4[_loc10_].angle;
                              break;
                           }
                           _loc10_--;
                        }
                     }
                  }
                  _loc9_ = param6.lastInvalidDestValue;
                  param6.lastInvalidDestIndex = param5;
               }
            }
            else if(_loc7_ == "angle")
            {
               if(isNaN(_loc8_))
               {
                  _loc8_ = 0;
               }
               if(isNaN(_loc9_))
               {
                  _loc9_ = 0;
               }
            }
            else if(_loc7_ == "innerRadius")
            {
               if(isNaN(_loc8_))
               {
                  _loc8_ = this._innerRadiusInPixelsScaledForExplode;
               }
               if(isNaN(_loc9_))
               {
                  _loc9_ = this._innerRadiusInPixelsScaledForExplode;
               }
            }
            else if(_loc7_ == "outerRadius")
            {
               if(isNaN(_loc8_))
               {
                  _loc8_ = this._radiusInPixelsScaledForExplode;
               }
               if(isNaN(_loc9_))
               {
                  _loc9_ = this._radiusInPixelsScaledForExplode;
               }
            }
            else
            {
               if(isNaN(_loc8_))
               {
                  _loc8_ = 0;
               }
               if(isNaN(_loc9_))
               {
                  _loc9_ = 0;
               }
            }
            param1[_loc7_] = _loc8_;
            param3[_loc7_] = _loc9_;
         }
      }
      
      override public function getItemsInRegion(param1:Rectangle) : Array
      {
         var _loc6_:Number = NaN;
         var _loc9_:PieSeriesItem = null;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         if(interactive == false || !this._renderData)
         {
            return [];
         }
         var _loc2_:Array = [];
         var _loc3_:Rectangle = new Rectangle();
         var _loc4_:uint = this._renderData.filteredCache.length;
         var _loc5_:Number = this._innerRadiusInPixelsScaledForExplode;
         _loc3_.topLeft = globalToLocal(param1.topLeft);
         _loc3_.bottomRight = globalToLocal(param1.bottomRight);
         var _loc7_:String = getStyle("renderDirection");
         if(_loc7_ == "clockwise")
         {
            _loc6_ = this._renderData.filteredCache[_loc4_ - 1].startAngle;
         }
         else
         {
            _loc6_ = this._renderData.filteredCache[0].startAngle;
         }
         var _loc8_:int = 0;
         while(_loc8_ < _loc4_)
         {
            _loc9_ = this._renderData.filteredCache[_loc8_];
            _loc10_ = _loc9_.startAngle - _loc6_;
            if(_loc7_ == "clockwise")
            {
               _loc11_ = _loc10_ + 2 * Math.PI - this._startAngleRadians + _loc9_.angle / 2;
            }
            else
            {
               _loc11_ = _loc10_ + this._startAngleRadians + _loc9_.angle / 2;
            }
            _loc12_ = _loc9_.origin.x + Math.cos(_loc11_) * (_loc5_ + (this._radiusInPixelsScaledForExplode - _loc5_) * 0.5);
            _loc13_ = _loc9_.origin.y - Math.sin(_loc11_) * (_loc5_ + (this._radiusInPixelsScaledForExplode - _loc5_) * 0.5);
            if(_loc3_.contains(_loc12_,_loc13_))
            {
               _loc2_.push(_loc9_);
            }
            _loc8_++;
         }
         return _loc2_;
      }
      
      override public function describeData(param1:String, param2:uint) : Array
      {
         var _loc3_:DataDescription = null;
         validateData();
         if(param1 == PolarTransform.ANGULAR_AXIS)
         {
            _loc3_ = new DataDescription();
            _loc3_.boundedValues = null;
            _loc3_.min = 0;
            _loc3_.max = 100;
            return [_loc3_];
         }
         return [];
      }
      
      override protected function defaultFilterFunction(param1:Array) : Array
      {
         var _loc2_:Array = [];
         if(filterDataValues == "outsideRange" || filterDataValues == "nulls")
         {
            _loc2_ = param1.concat();
            stripNaNs(_loc2_,"number");
         }
         else if(filterDataValues == "none")
         {
            _loc2_ = param1;
         }
         return _loc2_;
      }
      
      private function defaultFillFunction(param1:PieSeriesItem, param2:Number) : IFill
      {
         this._localFills = getStyle("fills");
         this._fillCount = this._localFills.length;
         return GraphicsUtilities.fillFromStyle(this._localFills[param2 % this._fillCount]);
      }
      
      private function calculateExplodeRadiusForWedge(param1:int) : Number
      {
         var _loc2_:Number = this._perWedgeExplodeRadius && this._perWedgeExplodeRadius[param1] != null?Number(parseFloat(this._perWedgeExplodeRadius[param1])):Number(0);
         if(isNaN(_loc2_))
         {
            _loc2_ = 0;
         }
         return ((!!isNaN(this._explodeRadius)?0:this._explodeRadius) + _loc2_) * this._radiusInPixelsAfterLabels;
      }
      
      private function measureCalloutLabels(param1:Array) : Object
      {
         var _loc5_:PieSeriesItem = null;
         var _loc6_:String = null;
         var _loc2_:int = param1.length;
         var _loc3_:Number = this._startAngleRadians;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = param1[_loc4_];
            if(this._labelFunction != null)
            {
               this._measuringField.text = _loc5_.labelText = this._labelFunction(_loc5_.item,this._field,_loc4_,_loc5_.percentValue);
            }
            else if(this._labelField)
            {
               this._measuringField.text = _loc5_.labelText = _loc5_.item[this._labelField];
            }
            else
            {
               this._measuringField.text = _loc5_.labelText = _loc5_.value.toString();
            }
            _loc6_ = getStyle("renderDirection");
            if(_loc6_ == "clockwise")
            {
               _loc5_.labelAngle = (2 * Math.PI - (_loc3_ + _loc5_.angle / 2)) % (2 * Math.PI);
            }
            else
            {
               _loc5_.labelAngle = (_loc3_ + _loc5_.angle / 2) % (2 * Math.PI);
            }
            _loc5_.labelCos = Math.cos(_loc5_.labelAngle);
            _loc5_.labelSin = -Math.sin(_loc5_.labelAngle);
            _loc5_.labelWidth = this._measuringField.width;
            _loc5_.labelHeight = this._measuringField.height;
            _loc3_ = _loc3_ + _loc5_.angle;
            _loc4_++;
         }
         return this.auxMeasureCalloutLabels(this._renderData,param1);
      }
      
      private function auxMeasureCalloutLabels(param1:PieSeriesRenderData, param2:Array) : Object
      {
         var _loc12_:int = 0;
         var _loc13_:Number = NaN;
         var _loc15_:PieSeriesItem = null;
         var _loc16_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc3_:PolarTransform = PolarTransform(dataTransform);
         var _loc4_:int = param2.length;
         var _loc5_:Rectangle = new Rectangle(0,0,unscaledWidth,unscaledHeight);
         var _loc6_:Number = _loc3_.radius * this._outerRadius;
         var _loc7_:Number = this._startAngleRadians;
         var _loc8_:Array = [];
         var _loc9_:Array = [];
         var _loc10_:Number = 0;
         var _loc11_:Number = 0;
         var _loc14_:Number = param1.labelScale;
         var _loc17_:Number = getStyle("calloutGap");
         _loc12_ = 0;
         while(_loc12_ < _loc4_)
         {
            _loc15_ = param2[_loc12_];
            if((_loc15_.labelAngle + Math.PI / 2) % (2 * Math.PI) < Math.PI)
            {
               if(_loc15_.labelAngle > Math.PI)
               {
                  _loc15_.labelAngle = _loc15_.labelAngle - 2 * Math.PI;
               }
               _loc15_.labelX = 0;
               _loc6_ = Math.min(_loc6_,_loc5_.right - _loc15_.labelWidth - this._origin.x - _loc17_);
               _loc9_.push(_loc15_);
               _loc11_ = _loc11_ + _loc15_.labelHeight;
            }
            else
            {
               _loc15_.labelX = -_loc15_.labelWidth;
               _loc6_ = Math.min(_loc6_,this._origin.x - _loc15_.labelWidth - _loc17_);
               _loc8_.push(_loc15_);
               _loc10_ = _loc10_ + _loc15_.labelHeight;
            }
            _loc13_ = -_loc15_.labelHeight / 2 + this._origin.y + _loc15_.labelSin * _loc6_ * 1.1;
            if(_loc13_ < _loc5_.top)
            {
               _loc6_ = (_loc5_.top + _loc15_.labelHeight / 2 - this._origin.y) / (_loc15_.labelSin * 1.1);
            }
            if(_loc13_ > _loc5_.bottom - _loc15_.labelHeight)
            {
               _loc6_ = (_loc5_.bottom - _loc15_.labelHeight + _loc15_.labelHeight / 2 - this._origin.y) / (_loc15_.labelSin * 1.1);
            }
            _loc12_++;
         }
         _loc8_.sortOn("labelAngle",Array.NUMERIC);
         _loc9_.sortOn("labelAngle",Array.NUMERIC | Array.DESCENDING);
         if(_loc10_ > _loc5_.height)
         {
            _loc14_ = Math.min(_loc14_,_loc5_.height / _loc10_);
         }
         if(_loc11_ > _loc5_.height)
         {
            _loc14_ = Math.min(_loc14_,_loc5_.height / _loc11_);
         }
         if(_loc6_ < (1 - this.maxLabelRadius) * (_loc3_.radius * this._outerRadius))
         {
            _loc21_ = _loc3_.radius * this._outerRadius - _loc6_ - _loc17_;
            _loc6_ = (1 - this.maxLabelRadius) * (_loc3_.radius * this._outerRadius);
            _loc14_ = Math.min(_loc14_,(_loc3_.radius * this._outerRadius - _loc6_ - _loc17_) / _loc21_);
         }
         this._radiusInPixelsAfterLabels = _loc6_ / this._outerRadius;
         var _loc18_:Number = this._origin.x - _loc6_ - _loc17_;
         var _loc19_:Number = 0;
         _loc4_ = _loc8_.length;
         _loc12_ = 0;
         while(_loc12_ < _loc4_)
         {
            _loc15_ = _loc8_[_loc12_];
            _loc15_.labelX = _loc18_ + _loc15_.labelX * _loc14_;
            _loc13_ = -_loc15_.labelHeight / 2 + this._origin.y + _loc15_.labelSin * _loc6_ * 1.1;
            if(_loc13_ < _loc19_)
            {
               _loc13_ = _loc19_;
            }
            _loc15_.labelY = _loc13_;
            _loc19_ = _loc13_ + _loc15_.labelHeight;
            _loc12_++;
         }
         if(_loc19_ > _loc5_.bottom)
         {
            _loc16_ = _loc5_.bottom;
            _loc12_ = _loc4_ - 1;
            while(_loc12_ >= 0)
            {
               _loc15_ = _loc8_[_loc12_];
               if(_loc15_.labelY + _loc15_.labelHeight <= _loc16_)
               {
                  break;
               }
               _loc15_.labelY = _loc16_ - _loc15_.labelHeight;
               _loc16_ = _loc15_.labelY;
               _loc12_--;
            }
         }
         var _loc20_:Number = this._origin.x + _loc6_ + _loc17_;
         _loc19_ = 0;
         _loc4_ = _loc9_.length;
         _loc12_ = 0;
         while(_loc12_ < _loc4_)
         {
            _loc15_ = _loc9_[_loc12_];
            _loc15_.labelX = _loc20_;
            _loc13_ = -_loc15_.labelHeight / 2 + this._origin.y + _loc15_.labelSin * _loc6_ * 1.1;
            if(_loc13_ < _loc19_)
            {
               _loc13_ = _loc19_;
            }
            _loc15_.labelY = _loc13_;
            _loc19_ = _loc13_ + _loc15_.labelHeight;
            _loc12_++;
         }
         if(_loc19_ > _loc5_.bottom)
         {
            _loc16_ = _loc5_.bottom;
            _loc12_ = _loc4_ - 1;
            while(_loc12_ >= 0)
            {
               _loc15_ = _loc9_[_loc12_];
               if(_loc15_.labelY + _loc15_.labelHeight <= _loc16_)
               {
                  break;
               }
               _loc15_.labelY = _loc16_ - _loc15_.labelHeight;
               _loc16_ = _loc15_.labelY;
               _loc12_--;
            }
         }
         param1.labelScale = _loc14_;
         return {
            "leftStack":_loc8_,
            "rightStack":_loc9_
         };
      }
      
      private function renderCalloutLabels(param1:PieSeriesRenderData) : void
      {
         this._labelCache.discard = true;
         this._labelCache.remove = true;
         this._labelCache.count = 0;
         this._labelCache.discard = false;
         this._labelCache.remove = false;
         var _loc2_:Object = param1.labelData;
         if(!_loc2_)
         {
            return;
         }
         this._labelCache.count = _loc2_.leftStack.length + _loc2_.rightStack.length;
         this.auxRenderCalloutLabels(param1,param1.labelData,0);
      }
      
      private function auxRenderCalloutLabels(param1:PieSeriesRenderData, param2:Object, param3:Number) : void
      {
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:PieSeriesItem = null;
         var _loc17_:IUITextField = null;
         var _loc18_:Number = NaN;
         var _loc22_:Point = null;
         var _loc4_:PolarTransform = PolarTransform(dataTransform);
         var _loc5_:Rectangle = new Rectangle(0,0,unscaledWidth,unscaledHeight);
         var _loc6_:Array = param2.leftStack;
         var _loc7_:Array = param2.rightStack;
         var _loc8_:Graphics = this._labelLayer.graphics;
         var _loc9_:Array = this._labelCache.instances;
         var _loc10_:Number = this._innerRadiusInPixelsScaledForExplode;
         var _loc11_:Number = _loc10_ + (this._radiusInPixelsScaledForExplode - _loc10_) * 0.8;
         var _loc12_:IStroke = getStyle("calloutStroke");
         if(_loc12_)
         {
            GraphicsUtilities.setLineStyle(_loc8_,_loc12_);
         }
         var _loc13_:Number = getStyle("calloutGap");
         var _loc19_:Number = param1.labelScale;
         var _loc20_:Number = this._origin.x - this._radiusInPixelsAfterLabels - _loc13_;
         _loc15_ = _loc6_.length;
         _loc14_ = 0;
         while(_loc14_ < _loc15_)
         {
            _loc16_ = _loc6_[_loc14_];
            if(_loc16_.percentValue != 0)
            {
               _loc22_ = _loc16_.origin;
               _loc17_ = _loc16_.label = _loc9_[param3++];
               _loc17_.scaleX = _loc17_.scaleY = _loc19_;
               _loc17_.x = _loc16_.labelX;
               _loc17_.y = _loc16_.labelY;
               _loc17_.text = _loc16_.labelText;
               _loc18_ = _loc16_.labelSin == 0?Number(_loc20_):Number((_loc17_.y + _loc17_.height / 2 - _loc22_.y) / _loc16_.labelSin);
               if(_loc18_ >= _loc11_)
               {
                  if(_loc22_.y + _loc16_.labelSin * _loc18_ > _loc5_.top)
                  {
                     _loc8_.moveTo(_loc22_.x + _loc16_.labelCos * _loc11_,_loc22_.y + _loc16_.labelSin * _loc11_);
                     if(_loc22_.x + _loc16_.labelCos * _loc18_ > _loc20_)
                     {
                        _loc8_.lineTo(_loc22_.x + _loc16_.labelCos * _loc18_,_loc22_.y + _loc16_.labelSin * _loc18_);
                     }
                     else
                     {
                        _loc8_.lineTo(_loc22_.x + _loc16_.labelCos * this._radiusInPixelsScaledForExplode,_loc22_.y + _loc16_.labelSin * this._radiusInPixelsScaledForExplode);
                     }
                     _loc8_.lineTo(_loc20_,_loc22_.y + _loc16_.labelSin * _loc18_);
                  }
               }
               else if(_loc18_ > this._radiusInPixelsScaledForExplode * 0.2)
               {
                  if(_loc22_.y + _loc16_.labelSin * _loc18_ > _loc5_.top)
                  {
                     _loc8_.moveTo(_loc22_.x + _loc16_.labelCos * _loc18_,_loc22_.y + _loc16_.labelSin * _loc18_);
                     _loc8_.lineTo(_loc20_,_loc22_.y + _loc16_.labelSin * _loc18_);
                  }
               }
               else if(_loc22_.y + _loc16_.labelSin * _loc18_ > _loc5_.top)
               {
                  _loc8_.moveTo(_loc22_.x + _loc16_.labelCos * this._radiusInPixelsScaledForExplode * 0.2,_loc22_.y + _loc16_.labelSin * this._radiusInPixelsScaledForExplode * 0.2);
                  _loc8_.lineTo(_loc20_,_loc22_.y + _loc16_.labelSin * _loc18_);
               }
            }
            _loc14_++;
         }
         var _loc21_:Number = this._origin.x + this._radiusInPixelsAfterLabels + _loc13_;
         _loc15_ = _loc7_.length;
         _loc14_ = 0;
         while(_loc14_ < _loc15_)
         {
            _loc16_ = _loc7_[_loc14_];
            if(_loc16_.percentValue != 0)
            {
               _loc22_ = _loc16_.origin;
               _loc17_ = _loc16_.label = _loc9_[param3++];
               _loc17_.scaleX = _loc17_.scaleY = _loc19_;
               _loc17_.x = _loc16_.labelX;
               _loc17_.y = _loc16_.labelY;
               _loc17_.text = _loc16_.labelText;
               _loc18_ = (_loc17_.y + _loc17_.height / 2 - _loc22_.y) / _loc16_.labelSin;
               if(_loc18_ == Infinity || _loc18_ == -Infinity || isNaN(_loc18_))
               {
                  if(_loc22_.y + _loc16_.labelSin * _loc18_ > _loc5_.top)
                  {
                     _loc8_.moveTo(_loc22_.x + _loc16_.labelCos * _loc11_,_loc22_.y + _loc16_.labelSin * _loc11_);
                     _loc8_.lineTo(_loc21_,_loc22_.y + _loc16_.labelSin * _loc11_);
                  }
               }
               else if(_loc18_ >= _loc11_)
               {
                  if(_loc22_.y + _loc16_.labelSin * _loc18_ > _loc5_.top)
                  {
                     _loc8_.moveTo(_loc22_.x + _loc16_.labelCos * _loc11_,_loc22_.y + _loc16_.labelSin * _loc11_);
                     if(_loc22_.x + _loc16_.labelCos * _loc18_ < _loc21_)
                     {
                        _loc8_.lineTo(_loc22_.x + _loc16_.labelCos * _loc18_,_loc22_.y + _loc16_.labelSin * _loc18_);
                     }
                     else
                     {
                        _loc8_.lineTo(_loc22_.x + _loc16_.labelCos * this._radiusInPixelsScaledForExplode,_loc22_.y + _loc16_.labelSin * this._radiusInPixelsScaledForExplode);
                     }
                     _loc8_.lineTo(_loc21_,_loc22_.y + _loc16_.labelSin * _loc18_);
                  }
               }
               else if(_loc18_ > this._radiusInPixelsScaledForExplode * 0.2)
               {
                  if(_loc22_.y + _loc16_.labelSin * _loc18_ > _loc5_.top)
                  {
                     _loc8_.moveTo(_loc22_.x + _loc16_.labelCos * _loc18_,_loc22_.y + _loc16_.labelSin * _loc18_);
                     _loc8_.lineTo(_loc21_,_loc22_.y + _loc16_.labelSin * _loc18_);
                  }
               }
               else if(_loc22_.y + _loc16_.labelSin * _loc18_ > _loc5_.top)
               {
                  _loc8_.moveTo(_loc22_.x + _loc16_.labelCos * this._radiusInPixelsScaledForExplode * 0.2,_loc22_.y + _loc16_.labelSin * this._radiusInPixelsScaledForExplode * 0.2);
                  _loc8_.lineTo(_loc21_,_loc22_.y + _loc16_.labelSin * _loc18_);
               }
            }
            _loc14_++;
         }
      }
      
      private function renderRadialLabels(param1:PieSeriesRenderData, param2:Array) : void
      {
         var _loc5_:int = 0;
         var _loc6_:PieSeriesItem = null;
         var _loc7_:IUITextField = null;
         this._labelCache.discard = true;
         this._labelCache.remove = true;
         this._labelCache.count = 0;
         this._labelCache.remove = false;
         this._labelCache.discard = false;
         var _loc3_:int = param2.length;
         this._labelCache.count = _loc3_;
         var _loc4_:Array = this._labelCache.instances;
         var _loc8_:Number = param1.labelScale;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc6_ = param2[_loc5_];
            if(_loc6_.percentValue != 0)
            {
               _loc7_ = _loc4_[_loc5_];
               _loc6_.label = _loc7_;
               _loc7_.text = _loc6_.labelText;
               _loc7_.scaleX = _loc7_.scaleY = _loc8_;
               _loc7_.x = _loc6_.labelX;
               _loc7_.y = _loc6_.labelY;
            }
            _loc5_++;
         }
      }
      
      private function measureRadialLabels(param1:Array) : Object
      {
         var _loc10_:int = 0;
         var _loc11_:PieSeriesItem = null;
         var _loc12_:IUITextField = null;
         var _loc14_:String = null;
         var _loc15_:Number = NaN;
         var _loc2_:PolarTransform = PolarTransform(dataTransform);
         var _loc3_:int = param1.length;
         var _loc4_:Rectangle = new Rectangle(0,0,unscaledWidth,unscaledHeight);
         var _loc5_:Point = _loc2_.origin;
         var _loc6_:Array = this._labelCache.instances;
         var _loc7_:Number = _loc2_.radius * this._outerRadius;
         var _loc8_:Array = [];
         var _loc9_:Number = this._startAngleRadians;
         var _loc13_:Number = 1;
         _loc10_ = 0;
         while(_loc10_ < _loc3_)
         {
            _loc11_ = param1[_loc10_];
            if(this._labelFunction != null)
            {
               this._measuringField.text = _loc11_.labelText = this._labelFunction(param1[_loc10_].item,this._field,_loc10_,param1[_loc10_].percentValue);
            }
            else if(this._labelField)
            {
               this._measuringField.text = _loc11_.labelText = param1[_loc10_].item[this._labelField];
            }
            else
            {
               this._measuringField.text = _loc11_.labelText = param1[_loc10_].value.toString();
            }
            _loc14_ = getStyle("renderDirection");
            if(_loc14_ == "clockwise")
            {
               _loc11_.labelAngle = (2 * Math.PI - (_loc9_ + param1[_loc10_].angle / 2)) % (2 * Math.PI);
            }
            else
            {
               _loc11_.labelAngle = (_loc9_ + param1[_loc10_].angle / 2) % (2 * Math.PI);
            }
            _loc11_.labelCos = Math.cos(_loc11_.labelAngle);
            _loc11_.labelSin = -Math.sin(_loc11_.labelAngle);
            if(_loc11_.labelAngle < Math.PI)
            {
               _loc11_.labelY = -this._measuringField.height;
               _loc7_ = Math.min(_loc7_,(_loc5_.y - this._measuringField.height) / Math.abs(_loc11_.labelSin));
            }
            else
            {
               _loc11_.labelY = 0;
               _loc7_ = Math.min(_loc7_,(_loc4_.bottom - this._measuringField.height - _loc5_.y) / Math.abs(_loc11_.labelSin));
            }
            if((_loc11_.labelAngle + Math.PI / 2) % (2 * Math.PI) < Math.PI)
            {
               _loc11_.labelX = 0;
               _loc7_ = Math.min(_loc7_,(_loc4_.right - this._measuringField.width - _loc5_.x) / Math.abs(_loc11_.labelCos));
            }
            else
            {
               _loc11_.labelX = -this._measuringField.width;
               _loc7_ = Math.min(_loc7_,(_loc5_.x - this._measuringField.width) / Math.abs(_loc11_.labelCos));
            }
            _loc8_[_loc10_] = _loc11_;
            _loc9_ = _loc9_ + param1[_loc10_].angle;
            _loc10_++;
         }
         if(_loc7_ < (1 - this.maxLabelRadius) * (_loc2_.radius * this._outerRadius))
         {
            _loc15_ = _loc2_.radius * this._outerRadius - _loc7_;
            _loc7_ = (1 - this.maxLabelRadius) * (_loc2_.radius * this._outerRadius);
            _loc13_ = (_loc2_.radius * this._outerRadius - _loc7_) / _loc15_;
         }
         this._radiusInPixelsAfterLabels = _loc7_ / this._outerRadius;
         _loc10_ = 0;
         while(_loc10_ < _loc3_)
         {
            _loc11_ = _loc8_[_loc10_];
            _loc11_.labelX = _loc11_.labelX * _loc13_ + _loc5_.x + _loc11_.labelCos * _loc7_;
            _loc11_.labelY = _loc11_.labelY * _loc13_ + _loc5_.y + _loc11_.labelSin * _loc7_;
            _loc10_++;
         }
         this._renderData.labelScale = _loc13_;
         return null;
      }
      
      private function renderInternalLabels(param1:PieSeriesRenderData, param2:Array) : void
      {
         var _loc7_:int = 0;
         var _loc8_:PieSeriesItem = null;
         var _loc9_:IUITextField = null;
         this._labelCache.discard = true;
         this._labelCache.remove = true;
         this._labelCache.count = 0;
         this._labelCache.discard = false;
         this._labelCache.remove = false;
         var _loc3_:Object = param1.labelData;
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:Array = _loc3_.visibleLabels;
         var _loc5_:int = _loc4_.length;
         this._labelCache.count = !!_loc3_.renderCallouts?int(param2.length):int(_loc4_.length);
         var _loc6_:Array = this._labelCache.instances;
         var _loc10_:Number = param1.labelScale;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc8_ = _loc4_[_loc7_];
            if(_loc8_.percentValue != 0)
            {
               _loc9_ = _loc6_[_loc7_];
               _loc8_.label = _loc9_;
               _loc9_.text = _loc8_.labelText;
               _loc9_.scaleX = _loc9_.scaleY = _loc10_;
               _loc9_.x = _loc8_.labelX;
               _loc9_.y = _loc8_.labelY;
            }
            _loc7_++;
         }
         if(_loc3_.renderCallouts)
         {
            this.auxRenderCalloutLabels(param1,_loc3_.calloutLabelData,_loc4_.length);
         }
      }
      
      private function measureInternalLabels(param1:Boolean, param2:Array) : Object
      {
         var _loc13_:int = 0;
         var _loc15_:PieSeriesItem = null;
         var _loc16_:IUITextField = null;
         var _loc20_:String = null;
         var _loc21_:Number = NaN;
         var _loc22_:PieSeriesItem = null;
         var _loc23_:PieSeriesItem = null;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc3_:Object = null;
         var _loc4_:PolarTransform = PolarTransform(dataTransform);
         var _loc5_:int = param2.length;
         var _loc6_:Rectangle = new Rectangle(0,0,unscaledWidth,unscaledHeight);
         var _loc7_:Point = _loc4_.origin;
         var _loc8_:Array = [];
         var _loc9_:Array = [];
         var _loc10_:Number = this._radiusInPixelsAfterLabels * this._outerRadius * (1 - this._maxExplodeRadiusRatio) * 0.7;
         var _loc11_:Array = [];
         var _loc12_:Number = this._startAngleRadians;
         var _loc14_:Number = 1;
         _loc13_ = 0;
         while(_loc13_ < _loc5_)
         {
            _loc15_ = param2[_loc13_];
            if(this._labelFunction != null)
            {
               this._measuringField.text = _loc15_.labelText = this._labelFunction(param2[_loc13_].item,this._field,_loc13_,param2[_loc13_].percentValue);
            }
            else if(this._labelField)
            {
               this._measuringField.text = _loc15_.labelText = param2[_loc13_].item[this._labelField];
            }
            else
            {
               this._measuringField.text = _loc15_.labelText = param2[_loc13_].value.toString();
            }
            _loc20_ = getStyle("renderDirection");
            if(_loc20_ == "clockwise")
            {
               _loc15_.labelAngle = (2 * Math.PI - (_loc12_ + param2[_loc13_].angle / 2)) % (2 * Math.PI);
            }
            else
            {
               _loc15_.labelAngle = (_loc12_ + param2[_loc13_].angle / 2) % (2 * Math.PI);
            }
            _loc15_.labelCos = Math.cos(_loc15_.labelAngle);
            _loc15_.labelSin = -Math.sin(_loc15_.labelAngle);
            _loc15_.labelWidth = this._measuringField.width;
            _loc15_.labelHeight = this._measuringField.height;
            _loc21_ = this.calculateExplodeRadiusForWedge(_loc13_);
            _loc15_.labelX = _loc15_.labelCos * (_loc21_ + _loc10_) + _loc7_.x - _loc15_.labelWidth / 2;
            _loc15_.labelY = _loc15_.labelSin * (_loc21_ + _loc10_) + _loc7_.y - _loc15_.labelHeight / 2;
            if(_loc13_ > 0)
            {
               _loc15_.prev = _loc11_[_loc13_ - 1];
               _loc15_.prev.next = _loc15_;
            }
            _loc11_[_loc13_] = _loc15_;
            _loc12_ = _loc12_ + param2[_loc13_].angle;
            _loc13_++;
         }
         _loc11_[0].prev = _loc11_[_loc5_ - 1];
         _loc11_[_loc5_ - 1].next = _loc11_[0];
         var _loc17_:Array = _loc11_.concat();
         _loc17_.sortOn("angle",Array.NUMERIC);
         var _loc18_:Number = getStyle("insideLabelSizeLimit");
         _loc13_ = 0;
         var _loc19_:TextFormat = determineTextFormatFromStyles();
         while(_loc13_ < _loc17_.length)
         {
            _loc15_ = _loc17_[_loc13_];
            _loc16_ = _loc15_.label;
            _loc22_ = _loc15_.next;
            _loc23_ = _loc15_.prev;
            _loc24_ = 1;
            _loc25_ = Math.abs(_loc15_.labelX - _loc22_.labelX) / (_loc15_.labelWidth / 2 + _loc22_.labelWidth / 2);
            _loc26_ = Math.abs(_loc15_.labelY - _loc22_.labelY) / (_loc15_.labelHeight / 2 + _loc22_.labelHeight / 2);
            if(_loc25_ < 1 && _loc26_ < 1)
            {
               _loc24_ = Math.max(_loc25_,_loc26_);
            }
            _loc25_ = Math.abs(_loc15_.labelX - _loc23_.labelX) / (_loc15_.labelWidth / 2 + _loc23_.labelWidth / 2);
            _loc26_ = Math.abs(_loc15_.labelY - _loc23_.labelY) / (_loc15_.labelHeight / 2 + _loc23_.labelHeight / 2);
            if(_loc25_ < 1 && _loc26_ < 1)
            {
               _loc24_ = Math.min(_loc24_,Math.max(_loc25_,_loc26_));
            }
            if(_loc24_ * Number(_loc19_.size) < _loc18_)
            {
               _loc15_.prev.next = _loc15_.next;
               _loc15_.next.prev = _loc15_.prev;
               _loc8_.push(_loc15_);
               _loc17_.splice(_loc13_,1);
            }
            else
            {
               _loc9_.push(_loc15_);
               _loc14_ = Math.min(_loc14_,_loc24_);
               _loc13_++;
            }
         }
         _loc14_ = Math.max(0.6,_loc14_);
         this._renderData.labelScale = _loc14_;
         if(param1 == false)
         {
            _loc3_ = {
               "visibleLabels":_loc9_,
               "renderCallouts":false
            };
         }
         else
         {
            _loc3_ = {
               "visibleLabels":_loc9_,
               "renderCallouts":true,
               "calloutLabelData":this.auxMeasureCalloutLabels(this._renderData,_loc8_)
            };
         }
         return _loc3_;
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
      
      private function formatDataTip(param1:HitData) : String
      {
         var _loc2_:String = "";
         var _loc3_:String = "";
         if(this._nameField != "")
         {
            _loc3_ = PieSeriesItem(param1.chartItem).item[this._nameField];
         }
         if(_loc3_ != "")
         {
            _loc2_ = _loc2_ + ("<b>" + _loc3_ + ":</b> <b> " + Math.round(PieSeriesItem(param1.chartItem).percentValue * 10) / 10 + "%</b><BR/>");
         }
         else
         {
            _loc2_ = _loc2_ + ("<b>" + Math.round(PieSeriesItem(param1.chartItem).percentValue * 10) / 10 + "%</b><BR/>");
         }
         _loc2_ = _loc2_ + ("<i>(" + PieSeriesItem(param1.chartItem).value + ")</i>");
         return _loc2_;
      }
      
      mx_internal function getRadiusInPixels() : Number
      {
         return this._radiusInPixelsScaledForExplode;
      }
      
      mx_internal function getInnerRadiusInPixels() : Number
      {
         return this._innerRadiusInPixelsScaledForExplode;
      }
      
      [Bindable(event="propertyChange")]
      private function get _fillFunction() : Function
      {
         return this._1757871014_fillFunction;
      }
      
      private function set _fillFunction(param1:Function) : void
      {
         var _loc2_:Object = this._1757871014_fillFunction;
         if(_loc2_ !== param1)
         {
            this._1757871014_fillFunction = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_fillFunction",_loc2_,param1));
            }
         }
      }
   }
}

import mx.charts.chartClasses.LegendData;
import mx.graphics.IFill;

class PieSeriesLegendData extends LegendData
{
    
   
   public var fill:IFill;
   
   function PieSeriesLegendData()
   {
      super();
   }
}

import flash.display.Graphics;
import flash.geom.Rectangle;
import mx.core.IDataRenderer;
import mx.graphics.IFill;
import mx.graphics.IStroke;
import mx.skins.ProgrammaticSkin;

class PieSeriesLegendMarker extends ProgrammaticSkin implements IDataRenderer
{
    
   
   private var _data:Object;
   
   function PieSeriesLegendMarker()
   {
      super();
   }
   
   public function get data() : Object
   {
      return this._data;
   }
   
   public function set data(param1:Object) : void
   {
      this._data = param1;
      invalidateDisplayList();
   }
   
   override protected function updateDisplayList(param1:Number, param2:Number) : void
   {
      var _loc4_:IFill = null;
      super.updateDisplayList(param1,param2);
      var _loc3_:IStroke = getStyle("stroke");
      if(this._data != null && "fill" in this._data)
      {
         _loc4_ = this._data.fill;
      }
      else
      {
         _loc4_ = getStyle("fill");
      }
      var _loc5_:Graphics = graphics;
      _loc5_.clear();
      _loc5_.moveTo(0,0);
      if(_loc3_)
      {
         _loc3_.apply(_loc5_,null,null);
      }
      else
      {
         _loc5_.lineStyle(0,0,0);
      }
      if(_loc4_)
      {
         _loc4_.begin(_loc5_,new Rectangle(0,0,width,height),null);
      }
      _loc5_.lineTo(width,0);
      _loc5_.lineTo(width,height);
      _loc5_.lineTo(0,height);
      _loc5_.lineTo(0,0);
      if(_loc4_)
      {
         _loc4_.end(_loc5_);
      }
   }
}
