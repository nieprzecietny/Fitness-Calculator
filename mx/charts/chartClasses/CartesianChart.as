package mx.charts.chartClasses
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.ui.Keyboard;
   import mx.charts.AxisRenderer;
   import mx.charts.ChartItem;
   import mx.charts.GridLines;
   import mx.charts.LinearAxis;
   import mx.charts.events.ChartItemEvent;
   import mx.charts.styles.HaloDefaults;
   import mx.collections.ArrayCollection;
   import mx.collections.ICollectionView;
   import mx.collections.IList;
   import mx.collections.ListCollectionView;
   import mx.collections.XMLListCollection;
   import mx.core.IFlexModuleFactory;
   import mx.core.IUIComponent;
   import mx.core.UIComponent;
   import mx.core.mx_internal;
   import mx.graphics.SolidColor;
   import mx.graphics.Stroke;
   import mx.styles.CSSStyleDeclaration;
   
   use namespace mx_internal;
   
   public class CartesianChart extends ChartBase
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
       
      
      private var _moduleFactoryInitialized:Boolean = false;
      
      private var _transformBounds:Rectangle;
      
      private var _computedGutters:Rectangle;
      
      private var _bAxisLayoutDirty:Boolean = true;
      
      private var _bgridLinesStyleNameDirty:Boolean = true;
      
      private var _defaultGridLines:GridLines;
      
      private var _bAxisStylesDirty:Boolean = true;
      
      private var _bAxesRenderersDirty:Boolean = false;
      
      private var _bDualMode:Boolean = false;
      
      private var _labelElements2:Array;
      
      private var _allSeries:Array;
      
      private var _leftRenderers:Array;
      
      private var _rightRenderers:Array;
      
      private var _topRenderers:Array;
      
      private var _bottomRenderers:Array;
      
      private var _horizontalAxis:IAxis;
      
      public var horizontalAxisRatio:Number = 0.33;
      
      private var _horizontalAxisRenderer:IAxisRenderer;
      
      private var _horizontalAxisRenderers:Array;
      
      private var _secondDataProvider:ICollectionView;
      
      private var _secondHorizontalAxis:IAxis;
      
      private var _secondHorizontalAxisRenderer:IAxisRenderer;
      
      private var _series2:Array;
      
      private var _userSeries2:Array;
      
      private var _secondVerticalAxis:IAxis;
      
      private var _secondVerticalAxisRenderer:IAxisRenderer;
      
      private var _verticalAxis:IAxis;
      
      public var verticalAxisRatio:Number = 0.33;
      
      private var _verticalAxisRenderer:IAxisRenderer;
      
      private var _verticalAxisRenderers:Array;
      
      public function CartesianChart()
      {
         this._transformBounds = new Rectangle();
         this._computedGutters = new Rectangle();
         this._allSeries = [];
         this._leftRenderers = [];
         this._rightRenderers = [];
         this._topRenderers = [];
         this._bottomRenderers = [];
         this._horizontalAxisRenderers = [];
         this._verticalAxisRenderers = [];
         super();
         this.horizontalAxis = new LinearAxis();
         this.verticalAxis = new LinearAxis();
         this._series2 = this._userSeries2 = [];
         transforms = [new CartesianTransform()];
         var _loc1_:GridLines = new GridLines();
         this.backgroundElements = [_loc1_];
         this._defaultGridLines = _loc1_;
         addEventListener("axisPlacementChange",this.axisPlacementChangeHandler);
      }
      
      override public function set backgroundElements(param1:Array) : void
      {
         super.backgroundElements = param1;
         this._defaultGridLines = null;
      }
      
      override protected function setChartState(param1:uint) : void
      {
         if(chartState == param1)
         {
            return;
         }
         var _loc2_:uint = chartState;
         super.setChartState(param1);
         if(this._horizontalAxisRenderer)
         {
            this._horizontalAxisRenderer.chartStateChanged(_loc2_,param1);
         }
         if(this._verticalAxisRenderer)
         {
            this._verticalAxisRenderer.chartStateChanged(_loc2_,param1);
         }
         if(this._secondHorizontalAxisRenderer)
         {
            this._secondHorizontalAxisRenderer.chartStateChanged(_loc2_,param1);
         }
         if(this._secondVerticalAxisRenderer)
         {
            this._secondVerticalAxisRenderer.chartStateChanged(_loc2_,param1);
         }
         var _loc3_:uint = this._horizontalAxisRenderers.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            this._horizontalAxisRenderers[_loc4_].chartStateChanged(_loc2_,param1);
            _loc4_++;
         }
         _loc3_ = this._verticalAxisRenderers.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            this._verticalAxisRenderers[_loc4_].chartStateChanged(_loc2_,param1);
            _loc4_++;
         }
      }
      
      override protected function get dataRegion() : Rectangle
      {
         return this._transformBounds;
      }
      
      override public function get selectedChartItems() : Array
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:Array = [];
         var _loc2_:int = this._allSeries.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this._allSeries[_loc3_].selectedItems.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc1_.push(this._allSeries[_loc3_].selectedItems[_loc5_]);
               _loc5_++;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function get computedGutters() : Rectangle
      {
         return this._computedGutters;
      }
      
      public function get horizontalAxis() : IAxis
      {
         return this._horizontalAxis;
      }
      
      public function set horizontalAxis(param1:IAxis) : void
      {
         this._horizontalAxis = param1;
         this._bAxesRenderersDirty = true;
         invalidateData();
         invalidateProperties();
      }
      
      public function get horizontalAxisRenderer() : IAxisRenderer
      {
         return this._horizontalAxisRenderer;
      }
      
      public function set horizontalAxisRenderer(param1:IAxisRenderer) : void
      {
         if(this._horizontalAxisRenderer)
         {
            if(DisplayObject(this._horizontalAxisRenderer).parent == this)
            {
               removeChild(DisplayObject(this._horizontalAxisRenderer));
            }
            this._horizontalAxisRenderer.otherAxes = null;
         }
         this._horizontalAxisRenderer = param1;
         if(this._horizontalAxisRenderer.axis)
         {
            this.horizontalAxis = this._horizontalAxisRenderer.axis;
         }
         this._horizontalAxisRenderer.horizontal = true;
         this._bAxesRenderersDirty = true;
         this._bAxisStylesDirty = true;
         invalidateChildOrder();
         invalidateProperties();
      }
      
      public function get horizontalAxisRenderers() : Array
      {
         return this._horizontalAxisRenderers;
      }
      
      public function set horizontalAxisRenderers(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this._horizontalAxisRenderers)
         {
            _loc2_ = this._horizontalAxisRenderers.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if(DisplayObject(this._horizontalAxisRenderers[_loc3_]).parent == this)
               {
                  removeChild(DisplayObject(this._horizontalAxisRenderers[_loc3_]));
               }
               this._horizontalAxisRenderers[_loc3_].otherAxes = null;
               _loc3_++;
            }
         }
         this._horizontalAxisRenderers = param1;
         _loc2_ = param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this._horizontalAxisRenderers[_loc3_].horizontal = true;
            _loc3_++;
         }
         invalidateProperties();
         this._bAxesRenderersDirty = true;
         this._bAxisStylesDirty = true;
         invalidateChildOrder();
         invalidateProperties();
      }
      
      public function get secondDataProvider() : Object
      {
         return this._secondDataProvider;
      }
      
      public function set secondDataProvider(param1:Object) : void
      {
         if(param1 is Array)
         {
            param1 = new ArrayCollection(param1 as Array);
         }
         else if(!(param1 is ICollectionView))
         {
            if(param1 is IList)
            {
               param1 = new ListCollectionView(param1 as IList);
            }
            else if(param1 is XMLList)
            {
               param1 = new XMLListCollection(XMLList(param1));
            }
            else if(param1 != null)
            {
               param1 = new ArrayCollection([param1]);
            }
            else
            {
               param1 = new ArrayCollection();
            }
         }
         this._secondDataProvider = ICollectionView(param1);
         if(!this._bDualMode)
         {
            this.initSecondaryMode();
         }
         invalidateData();
      }
      
      public function get secondHorizontalAxis() : IAxis
      {
         return this._secondHorizontalAxis;
      }
      
      public function set secondHorizontalAxis(param1:IAxis) : void
      {
         this._secondHorizontalAxis = param1;
         if(!this._bDualMode)
         {
            this.initSecondaryMode();
         }
         this._bAxesRenderersDirty = true;
         invalidateData();
         invalidateProperties();
      }
      
      public function get secondHorizontalAxisRenderer() : IAxisRenderer
      {
         return this._secondHorizontalAxisRenderer;
      }
      
      public function set secondHorizontalAxisRenderer(param1:IAxisRenderer) : void
      {
         if(this._secondHorizontalAxisRenderer)
         {
            if(DisplayObject(this._secondHorizontalAxisRenderer).parent == this)
            {
               removeChild(DisplayObject(this._secondHorizontalAxisRenderer));
            }
            this._secondHorizontalAxisRenderer.otherAxes = null;
         }
         this._secondHorizontalAxisRenderer = param1;
         if(!this._bDualMode)
         {
            this.initSecondaryMode();
         }
         this._secondHorizontalAxisRenderer.horizontal = true;
         if(this._secondHorizontalAxisRenderer.axis)
         {
            this.secondHorizontalAxis = this._secondHorizontalAxisRenderer.axis;
         }
         this._bAxesRenderersDirty = true;
         this._bAxisStylesDirty = true;
         invalidateChildOrder();
         invalidateProperties();
      }
      
      public function get secondSeries() : Array
      {
         return this._series2;
      }
      
      public function set secondSeries(param1:Array) : void
      {
         param1 = param1 == null?[]:param1;
         this._userSeries2 = param1;
         var _loc2_:int = param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(param1[_loc3_] is Series)
            {
               (param1[_loc3_] as Series).owner = this;
            }
            _loc3_++;
         }
         if(!this._bDualMode)
         {
            this.initSecondaryMode();
         }
         invalidateSeries();
         invalidateData();
         legendDataChanged();
      }
      
      public function get secondVerticalAxis() : IAxis
      {
         return this._secondVerticalAxis;
      }
      
      public function set secondVerticalAxis(param1:IAxis) : void
      {
         this._secondVerticalAxis = param1;
         if(!this._bDualMode)
         {
            this.initSecondaryMode();
         }
         this._bAxesRenderersDirty = true;
         invalidateData();
         invalidateProperties();
      }
      
      public function get secondVerticalAxisRenderer() : IAxisRenderer
      {
         return this._secondVerticalAxisRenderer;
      }
      
      public function set secondVerticalAxisRenderer(param1:IAxisRenderer) : void
      {
         if(this._secondVerticalAxisRenderer)
         {
            if(DisplayObject(this._secondVerticalAxisRenderer).parent == this)
            {
               removeChild(DisplayObject(this._secondVerticalAxisRenderer));
            }
         }
         this._secondVerticalAxisRenderer = param1;
         if(this._secondVerticalAxisRenderer.axis)
         {
            this.secondVerticalAxis = this._secondVerticalAxisRenderer.axis;
         }
         this._secondVerticalAxisRenderer.horizontal = false;
         this._bAxisStylesDirty = true;
         this._bAxesRenderersDirty = true;
         invalidateChildOrder();
         invalidateProperties();
      }
      
      public function get verticalAxis() : IAxis
      {
         return this._verticalAxis;
      }
      
      public function set verticalAxis(param1:IAxis) : void
      {
         this._verticalAxis = param1;
         this._bAxesRenderersDirty = true;
         invalidateData();
         invalidateChildOrder();
         invalidateProperties();
      }
      
      public function get verticalAxisRenderer() : IAxisRenderer
      {
         return this._verticalAxisRenderer;
      }
      
      public function set verticalAxisRenderer(param1:IAxisRenderer) : void
      {
         if(this._verticalAxisRenderer)
         {
            if(DisplayObject(this._verticalAxisRenderer).parent == this)
            {
               removeChild(DisplayObject(this._verticalAxisRenderer));
            }
         }
         this._verticalAxisRenderer = param1;
         if(this._verticalAxisRenderer.axis)
         {
            this.verticalAxis = this._verticalAxisRenderer.axis;
         }
         this._verticalAxisRenderer.horizontal = false;
         this._bAxisStylesDirty = true;
         this._bAxesRenderersDirty = true;
         invalidateChildOrder();
         invalidateProperties();
      }
      
      public function get verticalAxisRenderers() : Array
      {
         return this._verticalAxisRenderers;
      }
      
      public function set verticalAxisRenderers(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this._verticalAxisRenderers)
         {
            _loc2_ = this._verticalAxisRenderers.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if(DisplayObject(this._verticalAxisRenderers[_loc3_]).parent == this)
               {
                  removeChild(DisplayObject(this._verticalAxisRenderers[_loc3_]));
               }
               _loc3_++;
            }
         }
         this._verticalAxisRenderers = param1;
         _loc2_ = param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this._verticalAxisRenderers[_loc3_].horizontal = false;
            _loc3_++;
         }
         invalidateProperties();
         this._bAxisStylesDirty = true;
         this._bAxesRenderersDirty = true;
         invalidateProperties();
      }
      
      private function initStyles() : Boolean
      {
         HaloDefaults.init(styleManager);
         var cartesianChartStyle:CSSStyleDeclaration = HaloDefaults.createSelector("mx.charts.chartClasses.CartesianChart",styleManager);
         cartesianChartStyle.defaultFactory = function():void
         {
            this.axisColor = 14016221;
            this.chartSeriesStyles = HaloDefaults.chartBaseChartSeriesStyles;
            this.dataTipRenderer = DataTip;
            this.fill = new SolidColor(16777215,0);
            this.calloutStroke = new Stroke(8947848,2);
            this.fontSize = 10;
            this.horizontalAxisStyleName = "blockCategoryAxis";
            this.secondHorizontalAxisStyleName = "blockCategoryAxis";
            this.secondVerticalAxisStyleName = "blockNumericAxis";
            this.verticalAxisStyleName = "blockNumericAxis";
            this.horizontalAxisStyleNames = ["blockCategoryAxis"];
            this.verticalAxisStyleNames = ["blockNumericAxis"];
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
         styleManager.registerInheritingStyle("axisTitleStyleName");
      }
      
      override protected function commitProperties() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Series = null;
         var _loc5_:Object = null;
         if(this._horizontalAxisRenderers.length == 0 && !this._horizontalAxisRenderer)
         {
            this.horizontalAxisRenderer = new AxisRenderer();
         }
         if(this._verticalAxisRenderers.length == 0 && !this._verticalAxisRenderer)
         {
            this.verticalAxisRenderer = new AxisRenderer();
         }
         if(this._bAxesRenderersDirty)
         {
            _loc1_ = dataTipLayerIndex - 1;
            if(this._horizontalAxisRenderer)
            {
               addChild(DisplayObject(this._horizontalAxisRenderer));
            }
            if(this._verticalAxisRenderer)
            {
               addChild(DisplayObject(this._verticalAxisRenderer));
            }
            if(this._secondHorizontalAxisRenderer)
            {
               addChild(DisplayObject(this._secondHorizontalAxisRenderer));
            }
            if(this._secondVerticalAxisRenderer)
            {
               addChild(DisplayObject(this._secondVerticalAxisRenderer));
            }
            invalidateDisplayList();
            if(_transforms)
            {
               CartesianTransform(_transforms[0]).setAxis(CartesianTransform.HORIZONTAL_AXIS,this._horizontalAxis);
               CartesianTransform(_transforms[0]).setAxis(CartesianTransform.VERTICAL_AXIS,this._verticalAxis);
               if(_transforms.length > 1)
               {
                  CartesianTransform(_transforms[1]).setAxis(CartesianTransform.HORIZONTAL_AXIS,this._secondHorizontalAxis == null?this._horizontalAxis:this._secondHorizontalAxis);
                  CartesianTransform(_transforms[1]).setAxis(CartesianTransform.VERTICAL_AXIS,this._secondVerticalAxis == null?this._verticalAxis:this._secondVerticalAxis);
               }
            }
            if(this._horizontalAxisRenderer)
            {
               this._horizontalAxisRenderer.axis = this._horizontalAxis;
            }
            if(this._verticalAxisRenderer)
            {
               this._verticalAxisRenderer.axis = this._verticalAxis;
            }
            if(this._secondHorizontalAxisRenderer)
            {
               this._secondHorizontalAxisRenderer.axis = this._secondHorizontalAxis == null?this._horizontalAxis:this._secondHorizontalAxis;
            }
            if(this._secondVerticalAxisRenderer)
            {
               if(!this._secondVerticalAxis)
               {
                  this._secondVerticalAxisRenderer.axis = this._verticalAxis;
               }
               else
               {
                  this._secondVerticalAxisRenderer.axis = this._secondVerticalAxis;
               }
            }
            this.updateMultipleAxesRenderers();
            _loc2_ = series.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = series[_loc3_];
               if(_loc4_)
               {
                  _loc4_.invalidateProperties();
               }
               _loc3_++;
            }
            _loc2_ = this._series2.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = this._series2[_loc3_];
               if(_loc4_)
               {
                  _loc4_.invalidateProperties();
               }
               _loc3_++;
            }
            _loc2_ = annotationElements.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc5_ = annotationElements[_loc3_];
               if(_loc5_)
               {
                  if(_loc5_ is IDataCanvas)
                  {
                     _loc5_.invalidateProperties();
                  }
               }
               _loc3_++;
            }
            _loc2_ = backgroundElements.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc5_ = backgroundElements[_loc3_];
               if(_loc5_)
               {
                  if(_loc5_ is IDataCanvas)
                  {
                     _loc5_.invalidateProperties();
                  }
               }
               _loc3_++;
            }
            this._bAxesRenderersDirty = false;
         }
         if(this._bAxisStylesDirty)
         {
            if(this._horizontalAxisRenderer && this._horizontalAxisRenderer is DualStyleObject)
            {
               DualStyleObject(this._horizontalAxisRenderer).internalStyleName = getStyle("horizontalAxisStyleName");
            }
            if(this._verticalAxisRenderer && this._verticalAxisRenderer is DualStyleObject)
            {
               DualStyleObject(this._verticalAxisRenderer).internalStyleName = getStyle("verticalAxisStyleName");
            }
            if(this._secondHorizontalAxisRenderer && this._secondHorizontalAxisRenderer is DualStyleObject)
            {
               DualStyleObject(this._secondHorizontalAxisRenderer).internalStyleName = getStyle("secondHorizontalAxisStyleName");
            }
            if(this._secondVerticalAxisRenderer && this._secondVerticalAxisRenderer is DualStyleObject)
            {
               DualStyleObject(this._secondVerticalAxisRenderer).internalStyleName = getStyle("secondVerticalAxisStyleName");
            }
            this.updateMultipleAxesStyles();
            this._bAxisStylesDirty = false;
         }
         if(this._bgridLinesStyleNameDirty)
         {
            if(this._defaultGridLines)
            {
               this._defaultGridLines.internalStyleName = getStyle("gridLinesStyleName");
            }
            this._bgridLinesStyleNameDirty = false;
         }
         super.commitProperties();
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
         this.updateAxisLayout(param1,param2);
         advanceEffectState();
      }
      
      override public function styleChanged(param1:String) : void
      {
         if(param1 == null || this._horizontalAxisRenderer && param1 == "horizontalAxisStyleName")
         {
            this._bAxisStylesDirty = true;
            invalidateDisplayList();
         }
         if(param1 == null || this._verticalAxisRenderer && param1 == "verticalAxisStyleName")
         {
            this._bAxisStylesDirty = true;
            invalidateDisplayList();
         }
         if(param1 == null || this._secondHorizontalAxisRenderer && param1 == "secondHorizontalAxisStyleName")
         {
            this._bAxisStylesDirty = true;
            invalidateDisplayList();
         }
         if(param1 == null || this._secondVerticalAxisRenderer && param1 == "secondVerticalAxisStyleName")
         {
            this._bAxisStylesDirty = true;
            invalidateDisplayList();
         }
         if(this._defaultGridLines && param1 == "gridLinesStyleName")
         {
            this._bgridLinesStyleNameDirty = true;
            this._defaultGridLines.internalStyleName = getStyle("gridLinesStyleName");
            invalidateDisplayList();
         }
         if(param1 == null || param1.indexOf("gutter") == 0)
         {
            this._bAxisLayoutDirty = true;
            invalidateDisplayList();
         }
         if(param1 == null || this._horizontalAxisRenderers.length > 0 && param1 == "horizontalAxisStyleNames")
         {
            this._bAxisStylesDirty = true;
            invalidateDisplayList();
         }
         if(param1 == null || this._verticalAxisRenderers.length > 0 && param1 == "verticalAxisStyleNames")
         {
            this._bAxisStylesDirty = true;
            invalidateDisplayList();
         }
         super.styleChanged(param1);
      }
      
      override mx_internal function updateData() : void
      {
         if(dataProvider != null)
         {
            applyDataProvider(ICollectionView(dataProvider),_transforms[0]);
         }
         if(this._secondDataProvider != null && _transforms.length >= 2)
         {
            applyDataProvider(this._secondDataProvider,_transforms[1]);
         }
      }
      
      override mx_internal function updateSeries() : void
      {
         var _loc2_:int = 0;
         var _loc4_:DisplayObject = null;
         var _loc5_:IChartElement = null;
         var _loc6_:UIComponent = null;
         var _loc1_:Array = applySeriesSet(series,_transforms[0]);
         if(this._userSeries2 != null && _transforms.length >= 2)
         {
            this._series2 = applySeriesSet(this._userSeries2,_transforms[1]);
         }
         var _loc3_:int = !!_loc1_?int(_loc1_.length):0;
         removeElements(_backgroundElementHolder,true);
         removeElements(_seriesFilterer,false);
         removeElements(_annotationElementHolder,true);
         addElements(backgroundElements,_transforms[0],_backgroundElementHolder);
         allElements = backgroundElements.concat();
         addElements(_loc1_,_transforms[0],_seriesFilterer);
         allElements = allElements.concat(_loc1_);
         addElements(this._series2,_transforms[1],_seriesFilterer);
         allElements = allElements.concat(this._series2);
         labelElements = [];
         var _loc7_:int = _loc1_.length;
         _loc2_ = 0;
         while(_loc2_ < _loc7_)
         {
            _loc5_ = _loc1_[_loc2_] as IChartElement;
            if(_loc5_)
            {
               Series(_loc5_).invalidateProperties();
               _loc6_ = UIComponent(_loc5_.labelContainer);
               if(_loc6_)
               {
                  labelElements.push(_loc6_);
               }
            }
            _loc2_++;
         }
         _loc7_ = this._series2.length;
         _loc2_ = 0;
         while(_loc2_ < _loc7_)
         {
            _loc5_ = this._series2[_loc2_] as IChartElement;
            if(_loc5_)
            {
               Series(_loc5_).invalidateProperties();
               _loc6_ = UIComponent(_loc5_.labelContainer);
               if(_loc6_)
               {
                  labelElements.push(_loc6_);
               }
            }
            _loc2_++;
         }
         addElements(labelElements,_transforms[0],_annotationElementHolder);
         allElements = allElements.concat(labelElements);
         addElements(annotationElements,_transforms[0],_annotationElementHolder);
         allElements = allElements.concat(annotationElements);
         _transforms[0].elements = annotationElements.concat(_loc1_).concat(backgroundElements);
         if(_transforms.length >= 2)
         {
            _transforms[1].elements = this._series2;
         }
         this._allSeries = this.findSeriesObjects(series);
         if(this.secondSeries)
         {
            this._allSeries = this._allSeries.concat(this.findSeriesObjects(this.secondSeries));
         }
         invalidateData();
         invalidateSeriesStyles();
      }
      
      override mx_internal function updateAxisOrder(param1:int) : int
      {
         if(this._horizontalAxisRenderer)
         {
            setChildIndex(DisplayObject(this._horizontalAxisRenderer),param1++);
         }
         if(this._verticalAxisRenderer)
         {
            setChildIndex(DisplayObject(this._verticalAxisRenderer),param1++);
         }
         if(this._secondHorizontalAxisRenderer)
         {
            setChildIndex(DisplayObject(this._secondHorizontalAxisRenderer),param1++);
         }
         if(this._secondVerticalAxisRenderer)
         {
            setChildIndex(DisplayObject(this._secondVerticalAxisRenderer),param1++);
         }
         var _loc2_:int = this._horizontalAxisRenderers.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            setChildIndex(DisplayObject(this._horizontalAxisRenderers[_loc3_]),param1++);
            _loc3_++;
         }
         _loc2_ = this._verticalAxisRenderers.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            setChildIndex(DisplayObject(this._verticalAxisRenderers[_loc3_]),param1++);
            _loc3_++;
         }
         return param1;
      }
      
      override public function dataToLocal(... rest) : Point
      {
         var _loc2_:Object = {};
         var _loc3_:Array = [_loc2_];
         var _loc4_:int = rest.length;
         if(_loc4_ > 0)
         {
            _loc2_["d0"] = rest[0];
            _transforms[0].getAxis(CartesianTransform.HORIZONTAL_AXIS).mapCache(_loc3_,"d0","v0");
         }
         if(_loc4_ > 1)
         {
            _loc2_["d1"] = rest[1];
            _transforms[0].getAxis(CartesianTransform.VERTICAL_AXIS).mapCache(_loc3_,"d1","v1");
         }
         _transforms[0].transformCache(_loc3_,"v0","s0","v1","s1");
         return new Point(_loc2_.s0 + this._transformBounds.left,_loc2_.s1 + this._transformBounds.top);
      }
      
      override public function localToData(param1:Point) : Array
      {
         var _loc2_:Array = _transforms[0].invertTransform(param1.x - this._transformBounds.left,param1.y - this._transformBounds.top);
         return _loc2_;
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
            _loc2_ = getPreviousSeriesItem(this._allSeries);
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
            _loc2_ = getNextSeriesItem(this._allSeries);
         }
         return _loc2_;
      }
      
      override public function getNextItem(param1:String) : ChartItem
      {
         if(param1 == ChartBase.HORIZONTAL)
         {
            return getNextSeriesItem(this._allSeries);
         }
         if(param1 == ChartBase.VERTICAL)
         {
            return getNextSeries(this._allSeries);
         }
         return null;
      }
      
      override public function getPreviousItem(param1:String) : ChartItem
      {
         if(param1 == ChartBase.HORIZONTAL)
         {
            return getPreviousSeriesItem(this._allSeries);
         }
         if(param1 == ChartBase.VERTICAL)
         {
            return getPreviousSeries(this._allSeries);
         }
         return null;
      }
      
      override mx_internal function getSeriesTransformState(param1:Object) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1 is StackedSeries)
         {
            _loc3_ = (param1 as StackedSeries).series.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_ = this.getSeriesTransformState((param1 as StackedSeries).series[_loc4_]);
               if(_loc2_)
               {
                  return true;
               }
               _loc4_++;
            }
            return false;
         }
         return param1.getTransformState();
      }
      
      override mx_internal function updateKeyboardCache() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc1_:int = _transforms.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc4_ = _transforms[_loc2_].elements.length;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               if(_transforms[_loc2_].elements[_loc3_] is Series && this.getSeriesTransformState(_transforms[_loc2_].elements[_loc3_]) == true)
               {
                  return;
               }
               _loc3_++;
            }
            _loc2_++;
         }
         var _loc5_:Array = [];
         var _loc6_:Array = [];
         var _loc9_:Boolean = false;
         var _loc10_:int = 0;
         _loc1_ = this._allSeries.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc7_ = this._allSeries[_loc2_].items;
            if(_loc7_ && this._allSeries[_loc2_].selectedItems.length > 0)
            {
               _loc9_ = true;
               _loc4_ = _loc7_.length;
               _loc3_ = 0;
               while(_loc3_ < _loc4_)
               {
                  _loc5_.push(_loc7_[_loc3_].item);
                  _loc3_++;
               }
               _loc10_ = _loc10_ + this._allSeries[_loc2_].selectedItems.length;
               _loc4_ = this._allSeries[_loc2_].selectedItems.length;
               _loc3_ = 0;
               while(_loc3_ < _loc4_)
               {
                  _loc8_ = _loc5_.indexOf(this._allSeries[_loc2_].selectedItems[_loc3_].item);
                  if(_loc8_ != -1)
                  {
                     _loc6_.push(this._allSeries[_loc2_].items[_loc8_]);
                  }
                  _loc3_++;
               }
               _loc5_ = [];
               this._allSeries[_loc2_].emptySelectedItems();
            }
            _loc2_++;
         }
         if(_loc9_)
         {
            selectSpecificChartItems(_loc6_);
            if(_loc10_ != _loc6_.length)
            {
               dispatchEvent(new ChartItemEvent(ChartItemEvent.CHANGE,null,null,this));
            }
         }
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
            param1.stopImmediatePropagation();
            handleNavigation(_loc2_,param1);
         }
      }
      
      override protected function measure() : void
      {
         super.measure();
         if(this._horizontalAxisRenderer)
         {
            measuredMinHeight = this._horizontalAxisRenderer.minHeight + 40;
         }
         if(this._verticalAxisRenderer)
         {
            measuredMinWidth = this._verticalAxisRenderer.minWidth + 40;
         }
         if(this._secondHorizontalAxisRenderer)
         {
            measuredMinHeight = measuredMinHeight + this._secondHorizontalAxisRenderer.minHeight;
         }
         if(this._secondVerticalAxisRenderer)
         {
            measuredMinWidth = measuredMinWidth + this._secondVerticalAxisRenderer.minWidth;
         }
         var _loc1_:int = this._horizontalAxisRenderers.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            measuredMinHeight = measuredMinHeight + (this._horizontalAxisRenderers[_loc2_].minHeight + 40);
            _loc2_++;
         }
         _loc1_ = this._verticalAxisRenderers.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            measuredMinWidth = measuredMinWidth + (this._verticalAxisRenderers[_loc2_].minWidth + 40);
            _loc2_++;
         }
      }
      
      protected function updateAxisLayout(param1:Number, param2:Number) : void
      {
         var _loc21_:Array = null;
         var _loc22_:String = null;
         var _loc23_:String = null;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:Array = null;
         var _loc31_:Rectangle = null;
         var _loc32_:DisplayObject = null;
         var _loc3_:Number = getStyle("paddingLeft");
         var _loc4_:Number = getStyle("paddingRight");
         var _loc5_:Number = getStyle("paddingTop");
         var _loc6_:Number = getStyle("paddingBottom");
         var _loc7_:Object = getStyle("gutterLeft");
         var _loc8_:Object = getStyle("gutterRight");
         var _loc9_:Object = getStyle("gutterTop");
         var _loc10_:Object = getStyle("gutterBottom");
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:uint = this._horizontalAxisRenderers.length;
         var _loc14_:uint = this._verticalAxisRenderers.length;
         var _loc15_:uint = this._leftRenderers.length;
         var _loc16_:uint = this._rightRenderers.length;
         var _loc17_:uint = this._bottomRenderers.length;
         var _loc18_:uint = this._topRenderers.length;
         var _loc19_:Object = {};
         var _loc20_:Object = {
            "left":0,
            "top":0,
            "right":0,
            "bottom":0
         };
         if(!isNaN(this.horizontalAxisRatio))
         {
            if(this._horizontalAxisRenderer)
            {
               this._horizontalAxisRenderer.heightLimit = this.horizontalAxisRatio * param2;
            }
            _loc11_ = 0;
            while(_loc11_ < _loc13_)
            {
               this._horizontalAxisRenderers[_loc11_].heightLimit = this.horizontalAxisRatio * param2;
               _loc11_++;
            }
         }
         if(!isNaN(this.verticalAxisRatio))
         {
            if(this._verticalAxisRenderer)
            {
               this._verticalAxisRenderer.heightLimit = this.verticalAxisRatio * param1;
            }
            _loc11_ = 0;
            while(_loc11_ < _loc14_)
            {
               this._verticalAxisRenderers[_loc11_].heightLimit = this.verticalAxisRatio * param1;
               _loc11_++;
            }
         }
         if(this._horizontalAxisRenderer)
         {
            this._horizontalAxisRenderer.setActualSize(param1 - _loc3_ - _loc4_,param2 - _loc5_ - _loc6_);
            this._horizontalAxisRenderer.move(_loc3_,_loc5_);
         }
         _loc11_ = 0;
         while(_loc11_ < _loc13_)
         {
            this._horizontalAxisRenderers[_loc11_].setActualSize(param1 - _loc3_ - _loc4_,param2 - _loc5_ - _loc6_);
            this._horizontalAxisRenderers[_loc11_].move(_loc3_,_loc5_);
            _loc11_++;
         }
         if(this._verticalAxisRenderer)
         {
            this._verticalAxisRenderer.setActualSize(param1 - _loc3_ - _loc4_,param2 - _loc5_ - _loc6_);
            this._verticalAxisRenderer.move(_loc3_,_loc5_);
         }
         _loc11_ = 0;
         while(_loc11_ < _loc14_)
         {
            this._verticalAxisRenderers[_loc11_].setActualSize(param1 - _loc3_ - _loc4_,param2 - _loc5_ - _loc6_);
            this._verticalAxisRenderers[_loc11_].move(_loc3_,_loc5_);
            _loc11_++;
         }
         if(this._secondHorizontalAxisRenderer)
         {
            this._secondHorizontalAxisRenderer.setActualSize(param1 - _loc3_ - _loc4_,param2 - _loc5_ - _loc6_);
            this._secondHorizontalAxisRenderer.move(_loc3_,_loc5_);
         }
         if(this._secondVerticalAxisRenderer)
         {
            this._secondVerticalAxisRenderer.setActualSize(param1 - _loc3_ - _loc4_,param2 - _loc5_ - _loc6_);
            this._secondVerticalAxisRenderer.move(_loc3_,_loc5_);
         }
         if(_loc14_ == 0 && _loc13_ == 0)
         {
            if(this._horizontalAxisRenderer.placement == "")
            {
               this._horizontalAxisRenderer.placement = "bottom";
            }
            if(this._verticalAxisRenderer.placement == "")
            {
               this._verticalAxisRenderer.placement = "left";
            }
            if(this._secondHorizontalAxisRenderer)
            {
               _loc22_ = this._horizontalAxisRenderer.placement;
               switch(_loc22_)
               {
                  case "left":
                  case "bottom":
                     this._secondHorizontalAxisRenderer.placement = "right";
                     break;
                  case "top":
                  case "right":
                     this._secondHorizontalAxisRenderer.placement = "left";
               }
            }
            if(this._secondVerticalAxisRenderer)
            {
               _loc23_ = this._verticalAxisRenderer.placement;
               switch(_loc23_)
               {
                  case "left":
                  case "bottom":
                     this._secondVerticalAxisRenderer.placement = "top";
                     break;
                  case "top":
                  case "right":
                     this._secondVerticalAxisRenderer.placement = "bottom";
               }
            }
            this._computedGutters = new Rectangle();
            if(_loc7_ != null)
            {
               this._computedGutters.left = Number(_loc7_);
               _loc19_.left = false;
            }
            if(_loc8_ != null)
            {
               this._computedGutters.right = Number(_loc8_);
               _loc19_.right = false;
            }
            if(_loc9_ != null)
            {
               this._computedGutters.top = Number(_loc9_);
               _loc19_.top = false;
            }
            if(_loc10_ != null)
            {
               this._computedGutters.bottom = Number(_loc10_);
               _loc19_.bottom = false;
            }
            _loc21_ = [];
            _loc21_.push(this._verticalAxisRenderer);
            if(this._secondVerticalAxisRenderer)
            {
               _loc21_.push(this._secondVerticalAxisRenderer);
            }
            this._horizontalAxisRenderer.otherAxes = _loc21_;
            if(this._secondHorizontalAxisRenderer)
            {
               this._secondHorizontalAxisRenderer.otherAxes = _loc21_;
            }
            this._computedGutters = this._verticalAxisRenderer.adjustGutters(this._computedGutters,_loc19_);
            if(this._secondVerticalAxisRenderer)
            {
               this._computedGutters = this._secondVerticalAxisRenderer.adjustGutters(this._computedGutters,_loc19_);
            }
            if(this._secondHorizontalAxisRenderer)
            {
               this._computedGutters = this._secondHorizontalAxisRenderer.adjustGutters(this._computedGutters,_loc19_);
            }
            this._computedGutters = this._horizontalAxisRenderer.adjustGutters(this._computedGutters,_loc19_);
            this._verticalAxisRenderer.gutters = this._computedGutters;
            if(this._secondVerticalAxisRenderer)
            {
               this._secondVerticalAxisRenderer.gutters = this._computedGutters;
            }
            if(this._secondHorizontalAxisRenderer)
            {
               this._secondHorizontalAxisRenderer.gutters = this._computedGutters;
            }
         }
         else
         {
            this._computedGutters = new Rectangle();
            if(_loc7_ != null)
            {
               _loc20_.left = Number(_loc7_) / _loc15_;
               _loc19_.left = false;
            }
            if(_loc8_ != null)
            {
               _loc20_.right = Number(_loc8_) / _loc16_;
               _loc19_.right = false;
            }
            if(_loc9_ != null)
            {
               _loc20_.top = Number(_loc9_) / _loc18_;
               _loc19_.top = false;
            }
            if(_loc10_ != null)
            {
               _loc20_.bottom = Number(_loc10_) / _loc17_;
               _loc19_.bottom = false;
            }
            _loc24_ = 0;
            _loc25_ = 0;
            _loc26_ = 0;
            _loc27_ = 0;
            _loc28_ = 0;
            _loc29_ = 0;
            _loc11_ = 0;
            while(_loc11_ < _loc15_)
            {
               if(_loc20_.left == 0)
               {
                  this._computedGutters.left = 0;
               }
               else
               {
                  this._computedGutters.left = _loc20_.left * (_loc11_ + 1);
               }
               this._computedGutters = this._leftRenderers[_loc11_].adjustGutters(this._computedGutters,_loc19_);
               _loc31_ = this._computedGutters.clone();
               if(_loc31_.top > _loc28_)
               {
                  _loc28_ = _loc31_.top;
               }
               if(_loc31_.bottom > _loc29_)
               {
                  _loc29_ = _loc31_.bottom;
               }
               if(_loc20_.left == 0)
               {
                  _loc31_.left = _loc31_.left + _loc24_;
               }
               if(_loc31_.left > param1)
               {
                  _loc31_.left = param1;
               }
               this._leftRenderers[_loc11_].gutters = _loc31_;
               if(_loc20_.left == 0)
               {
                  _loc24_ = _loc24_ + this._computedGutters.left;
               }
               _loc11_++;
            }
            if(_loc24_ > param1)
            {
               _loc24_ = param1;
            }
            if(_loc20_.left == 0)
            {
               this._computedGutters.left = _loc24_;
            }
            else
            {
               this._computedGutters.left = Number(_loc7_);
            }
            _loc11_ = 0;
            while(_loc11_ < _loc16_)
            {
               if(_loc20_.right == 0)
               {
                  this._computedGutters.right = 0;
               }
               else
               {
                  this._computedGutters.right = _loc20_.right * (_loc11_ + 1);
               }
               this._computedGutters = this._rightRenderers[_loc11_].adjustGutters(this._computedGutters,_loc19_);
               _loc31_ = this._computedGutters.clone();
               if(_loc31_.top > _loc28_)
               {
                  _loc28_ = _loc31_.top;
               }
               if(_loc31_.bottom > _loc29_)
               {
                  _loc29_ = _loc31_.bottom;
               }
               if(_loc20_.right == 0)
               {
                  _loc31_.right = _loc31_.right + _loc25_;
               }
               if(_loc31_.right > param1)
               {
                  _loc31_.right = param1;
               }
               this._rightRenderers[_loc11_].gutters = _loc31_;
               if(_loc20_.right == 0)
               {
                  _loc25_ = _loc25_ + this._computedGutters.right;
               }
               _loc11_++;
            }
            if(_loc25_ > param1)
            {
               _loc25_ = param1;
            }
            if(_loc20_.right == 0)
            {
               this._computedGutters.right = _loc25_;
            }
            else
            {
               this._computedGutters.right = Number(_loc8_);
            }
            _loc30_ = [];
            if(_loc15_ > 0)
            {
               _loc30_.push(this._leftRenderers[_loc15_ - 1]);
            }
            if(_loc16_ > 0)
            {
               _loc30_.push(this._rightRenderers[_loc16_ - 1]);
            }
            _loc11_ = 0;
            while(_loc11_ < _loc17_)
            {
               if(_loc20_.bottom == 0)
               {
                  this._computedGutters.bottom = 0;
               }
               else
               {
                  this._computedGutters.bottom = _loc20_.bottom * (_loc11_ + 1);
               }
               this._bottomRenderers[_loc11_].otherAxes = _loc30_;
               this._computedGutters = this._bottomRenderers[_loc11_].adjustGutters(this._computedGutters,_loc19_);
               _loc31_ = this._computedGutters.clone();
               if(_loc20_.bottom == 0)
               {
                  _loc31_.bottom = _loc31_.bottom + _loc26_;
               }
               if(_loc31_.bottom > param2)
               {
                  _loc31_.bottom = param2;
               }
               this._bottomRenderers[_loc11_].gutters = _loc31_;
               if(_loc20_.bottom == 0)
               {
                  _loc26_ = _loc26_ + this._computedGutters.bottom;
               }
               _loc11_++;
            }
            if(_loc26_ > param2)
            {
               _loc26_ = param2;
            }
            _loc11_ = 0;
            while(_loc11_ < _loc18_)
            {
               if(_loc20_.top == 0)
               {
                  this._computedGutters.top = 0;
               }
               else
               {
                  this._computedGutters.top = _loc20_.top * (_loc11_ + 1);
               }
               this._topRenderers[_loc11_].otherAxes = _loc30_;
               this._computedGutters = this._topRenderers[_loc11_].adjustGutters(this._computedGutters,_loc19_);
               _loc31_ = this._computedGutters.clone();
               if(_loc20_.top == 0)
               {
                  _loc31_.top = _loc31_.top + _loc27_;
               }
               if(_loc31_.top > param2)
               {
                  _loc31_.top = param2;
               }
               this._topRenderers[_loc11_].gutters = _loc31_;
               if(_loc20_.top == 0)
               {
                  _loc27_ = _loc27_ + this._computedGutters.top;
               }
               _loc11_++;
            }
            if(_loc27_ > param2)
            {
               _loc27_ = param2;
            }
            if(_loc20_.bottom == 0)
            {
               this._computedGutters.bottom = _loc26_;
            }
            else
            {
               this._computedGutters.bottom = Number(_loc10_);
            }
            if(_loc20_.top == 0)
            {
               this._computedGutters.top = _loc27_;
            }
            else
            {
               this._computedGutters.top = Number(_loc9_);
            }
            if(_loc18_ == 0)
            {
               this._computedGutters.top = this._computedGutters.top + _loc28_;
            }
            if(_loc17_ == 0)
            {
               this._computedGutters.bottom = this._computedGutters.bottom + _loc29_;
            }
            _loc11_ = 0;
            while(_loc11_ < _loc15_)
            {
               _loc31_ = this._leftRenderers[_loc11_].gutters;
               _loc31_.top = this._computedGutters.top;
               _loc31_.bottom = this._computedGutters.bottom;
               this._leftRenderers[_loc11_].gutters = _loc31_;
               _loc11_++;
            }
            _loc11_ = 0;
            while(_loc11_ < _loc16_)
            {
               _loc31_ = this._rightRenderers[_loc11_].gutters;
               _loc31_.top = this._computedGutters.top;
               _loc31_.bottom = this._computedGutters.bottom;
               this._rightRenderers[_loc11_].gutters = _loc31_;
               _loc11_++;
            }
         }
         this._transformBounds = new Rectangle(this._computedGutters.left + _loc3_,this._computedGutters.top + _loc5_,param1 - this._computedGutters.right - _loc4_ - (this._computedGutters.left + _loc3_),param2 - this._computedGutters.bottom - _loc6_ - (this._computedGutters.top + _loc5_));
         if(_transforms)
         {
            _loc12_ = _transforms.length;
            _loc11_ = 0;
            while(_loc11_ < _loc12_)
            {
               _transforms[_loc11_].pixelWidth = this._transformBounds.width;
               _transforms[_loc11_].pixelHeight = this._transformBounds.height;
               _loc11_++;
            }
         }
         _loc12_ = allElements.length;
         _loc11_ = 0;
         while(_loc11_ < _loc12_)
         {
            _loc32_ = allElements[_loc11_];
            if(_loc32_ is IUIComponent)
            {
               (_loc32_ as IUIComponent).setActualSize(this._transformBounds.width,this._transformBounds.height);
            }
            else
            {
               _loc32_.width = this._transformBounds.width;
               _loc32_.height = this._transformBounds.height;
            }
            if(_loc32_ is Series && Series(_loc32_).dataTransform)
            {
               CartesianTransform(Series(_loc32_).dataTransform).pixelWidth = this._transformBounds.width;
               CartesianTransform(Series(_loc32_).dataTransform).pixelHeight = this._transformBounds.height;
            }
            if(_loc32_ is IDataCanvas && (_loc32_ as Object).dataTransform)
            {
               CartesianTransform((_loc32_ as Object).dataTransform).pixelWidth = this._transformBounds.width;
               CartesianTransform((_loc32_ as Object).dataTransform).pixelHeight = this._transformBounds.height;
            }
            _loc11_++;
         }
         if(_seriesHolder.mask)
         {
            _seriesHolder.mask.width = this._transformBounds.width;
            _seriesHolder.mask.height = this._transformBounds.height;
         }
         if(_backgroundElementHolder.mask)
         {
            _backgroundElementHolder.mask.width = this._transformBounds.width;
            _backgroundElementHolder.mask.height = this._transformBounds.height;
         }
         if(_annotationElementHolder.mask)
         {
            _annotationElementHolder.mask.width = this._transformBounds.width;
            _annotationElementHolder.mask.height = this._transformBounds.height;
         }
         _seriesHolder.x = this._transformBounds.left;
         _seriesHolder.y = this._transformBounds.top;
         _backgroundElementHolder.move(this._transformBounds.left,this._transformBounds.top);
         _annotationElementHolder.move(this._transformBounds.left,this._transformBounds.top);
         this._bAxisLayoutDirty = false;
      }
      
      private function findSeriesObjects(param1:Array) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:int = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(param1[_loc4_] is StackedSeries)
            {
               _loc2_ = _loc2_.concat(this.findSeriesObjects(param1[_loc4_].series));
            }
            else
            {
               _loc2_.push(param1[_loc4_]);
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      mx_internal function adjustAxesPlacements() : void
      {
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc1_:Array = [];
         var _loc2_:Array = [];
         this._leftRenderers = [];
         this._rightRenderers = [];
         this._bottomRenderers = [];
         this._topRenderers = [];
         var _loc3_:uint = this._horizontalAxisRenderers.length;
         var _loc4_:uint = this._verticalAxisRenderers.length;
         var _loc11_:int = 0;
         while(_loc11_ < _loc3_)
         {
            if(this._horizontalAxisRenderers[_loc11_].placement == "bottom")
            {
               this._bottomRenderers.push(this._horizontalAxisRenderers[_loc11_]);
            }
            else if(this._horizontalAxisRenderers[_loc11_].placement == "top")
            {
               this._topRenderers.push(this._horizontalAxisRenderers[_loc11_]);
            }
            else
            {
               _loc1_.push(this._horizontalAxisRenderers[_loc11_]);
            }
            _loc11_++;
         }
         _loc11_ = 0;
         while(_loc11_ < _loc4_)
         {
            if(this._verticalAxisRenderers[_loc11_].placement == "left")
            {
               this._leftRenderers.push(this._verticalAxisRenderers[_loc11_]);
            }
            else if(this._verticalAxisRenderers[_loc11_].placement == "right")
            {
               this._rightRenderers.push(this._verticalAxisRenderers[_loc11_]);
            }
            else
            {
               _loc2_.push(this._verticalAxisRenderers[_loc11_]);
            }
            _loc11_++;
         }
         if(this._horizontalAxisRenderer)
         {
            if(this._horizontalAxisRenderer.placement == "bottom")
            {
               this._bottomRenderers.push(this._horizontalAxisRenderer);
            }
            else if(this._horizontalAxisRenderer.placement == "top")
            {
               this._topRenderers.push(this._horizontalAxisRenderer);
            }
            else
            {
               _loc1_.push(this._horizontalAxisRenderer);
            }
         }
         if(this._verticalAxisRenderer)
         {
            if(this._verticalAxisRenderer.placement == "left")
            {
               this._leftRenderers.push(this._verticalAxisRenderer);
            }
            else if(this._verticalAxisRenderer.placement == "right")
            {
               this._rightRenderers.push(this._verticalAxisRenderer);
            }
            else
            {
               _loc2_.push(this._verticalAxisRenderer);
            }
         }
         if(this._secondHorizontalAxisRenderer)
         {
            if(this._secondHorizontalAxisRenderer.placement == "bottom")
            {
               this._bottomRenderers.push(this._secondHorizontalAxisRenderer);
            }
            else if(this._secondHorizontalAxisRenderer.placement == "top")
            {
               this._topRenderers.push(this._secondHorizontalAxisRenderer);
            }
            else
            {
               _loc1_.push(this._secondHorizontalAxisRenderer);
            }
         }
         if(this._secondVerticalAxisRenderer)
         {
            if(this._secondVerticalAxisRenderer.placement == "left")
            {
               this._leftRenderers.push(this._secondVerticalAxisRenderer);
            }
            else if(this._secondVerticalAxisRenderer.placement == "right")
            {
               this._rightRenderers.push(this._secondVerticalAxisRenderer);
            }
            else
            {
               _loc2_.push(this._secondVerticalAxisRenderer);
            }
         }
         _loc5_ = this._leftRenderers.length;
         _loc6_ = this._rightRenderers.length;
         _loc7_ = this._topRenderers.length;
         _loc8_ = this._bottomRenderers.length;
         _loc9_ = _loc1_.length;
         _loc10_ = _loc2_.length;
         var _loc12_:uint = 0;
         if(_loc5_ > _loc6_)
         {
            _loc12_ = 0;
            while(_loc12_ < _loc5_ - _loc6_ && _loc12_ < _loc10_)
            {
               this._rightRenderers.push(_loc2_[_loc12_]);
               _loc2_[_loc12_].placement = "right";
               _loc12_++;
            }
         }
         else if(_loc5_ < _loc6_)
         {
            _loc12_ = 0;
            while(_loc12_ < _loc6_ - _loc5_ && _loc12_ < _loc10_)
            {
               this._leftRenderers.push(_loc2_[_loc12_]);
               _loc2_[_loc12_].placement = "left";
               _loc12_++;
            }
         }
         _loc11_ = _loc12_;
         while(_loc11_ < _loc10_)
         {
            if(_loc11_ % 2 == 0)
            {
               this._leftRenderers.push(_loc2_[_loc11_]);
               _loc2_[_loc11_].placement = "left";
            }
            else
            {
               this._rightRenderers.push(_loc2_[_loc11_]);
               _loc2_[_loc11_].placement = "right";
            }
            _loc11_++;
         }
         if(_loc8_ > _loc7_)
         {
            _loc12_ = 0;
            while(_loc12_ < _loc8_ - _loc7_ && _loc12_ < _loc9_)
            {
               this._topRenderers.push(_loc1_[_loc12_]);
               _loc1_[_loc12_].placement = "top";
               _loc12_++;
            }
         }
         else if(_loc7_ < _loc8_)
         {
            _loc12_ = 0;
            while(_loc12_ < _loc7_ - _loc8_ && _loc12_ < _loc9_)
            {
               this._bottomRenderers.push(_loc1_[_loc12_]);
               _loc1_[_loc12_].placement = "bottom";
               _loc12_++;
            }
         }
         _loc11_ = _loc12_;
         while(_loc11_ < _loc9_)
         {
            if(_loc11_ % 2 == 0)
            {
               this._bottomRenderers.push(_loc1_[_loc11_]);
               _loc1_[_loc11_].placement = "bottom";
            }
            else
            {
               this._topRenderers.push(_loc1_[_loc11_]);
               _loc1_[_loc11_].placement = "top";
            }
            _loc11_++;
         }
      }
      
      private function updateMultipleAxesStyles() : void
      {
         var _loc1_:Array = getStyle("horizontalAxisStyleNames");
         var _loc2_:Array = getStyle("verticalAxisStyleNames");
         var _loc3_:uint = this._horizontalAxisRenderers.length;
         var _loc4_:uint = _loc1_.length;
         var _loc5_:uint = _loc2_.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_)
         {
            if(this._horizontalAxisRenderers[_loc6_] is DualStyleObject)
            {
               DualStyleObject(this._horizontalAxisRenderers[_loc6_]).internalStyleName = _loc1_[_loc6_ % _loc4_];
            }
            _loc6_++;
         }
         _loc3_ = this._verticalAxisRenderers.length;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            if(this._verticalAxisRenderers[_loc6_] is DualStyleObject)
            {
               DualStyleObject(this._verticalAxisRenderers[_loc6_]).internalStyleName = _loc2_[_loc6_ % _loc5_];
            }
            _loc6_++;
         }
      }
      
      private function updateMultipleAxesRenderers() : void
      {
         var _loc1_:uint = this._horizontalAxisRenderers.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            addChild(DisplayObject(this._horizontalAxisRenderers[_loc2_]));
            _loc2_++;
         }
         _loc1_ = this._verticalAxisRenderers.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            addChild(DisplayObject(this._verticalAxisRenderers[_loc2_]));
            _loc2_++;
         }
         this.adjustAxesPlacements();
         invalidateDisplayList();
      }
      
      private function axisPlacementChangeHandler(param1:Event) : void
      {
         this.adjustAxesPlacements();
         invalidateDisplayList();
      }
      
      protected function initSecondaryMode() : void
      {
         this._bDualMode = true;
         transforms = [_transforms[0],new CartesianTransform()];
      }
      
      public function getSecondAxis(param1:String) : IAxis
      {
         return transforms[0].getAxis(param1);
      }
      
      public function setSecondAxis(param1:String, param2:IAxis) : void
      {
         transforms[0].setAxis(param1,param2);
      }
      
      mx_internal function measureLabels() : Object
      {
         return null;
      }
      
      mx_internal function getLeftMostRenderer() : IAxisRenderer
      {
         var _loc1_:int = this._leftRenderers.length;
         if(_loc1_ > 0)
         {
            return this._leftRenderers[_loc1_ - 1];
         }
         return null;
      }
      
      mx_internal function getRightMostRenderer() : IAxisRenderer
      {
         var _loc1_:int = this._rightRenderers.length;
         if(_loc1_ > 0)
         {
            return this._rightRenderers[_loc1_ - 1];
         }
         return null;
      }
      
      mx_internal function getTopMostRenderer() : IAxisRenderer
      {
         var _loc1_:int = this._topRenderers.length;
         if(_loc1_ > 0)
         {
            return this._topRenderers[_loc1_ - 1];
         }
         return null;
      }
      
      mx_internal function getBottomMostRenderer() : IAxisRenderer
      {
         var _loc1_:int = this._bottomRenderers.length;
         if(_loc1_ > 0)
         {
            return this._bottomRenderers[_loc1_ - 1];
         }
         return null;
      }
   }
}
