package mx.charts
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mx.charts.chartClasses.ChartBase;
   import mx.charts.events.LegendMouseEvent;
   import mx.charts.styles.HaloDefaults;
   import mx.collections.ArrayCollection;
   import mx.collections.ICollectionView;
   import mx.collections.IList;
   import mx.collections.ListCollectionView;
   import mx.containers.Tile;
   import mx.core.EdgeMetrics;
   import mx.core.IFlexModuleFactory;
   import mx.core.IUIComponent;
   import mx.core.ScrollPolicy;
   import mx.core.mx_internal;
   import mx.styles.CSSStyleDeclaration;
   
   use namespace mx_internal;
   
   public class Legend extends Tile
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
      
      private static var legendItemLinkage:LegendItem = null;
       
      
      private var _moduleFactoryInitialized:Boolean = false;
      
      private var _preferredMajorAxisLength:Number;
      
      private var _actualMajorAxisLength:Number;
      
      private var _childrenDirty:Boolean = false;
      
      private var _unscaledWidth:Number;
      
      private var _unscaledHeight:Number;
      
      private var _dataProviderChanged:Boolean = false;
      
      private var _dataProvider:Object;
      
      public var legendItemClass:Class;
      
      public function Legend()
      {
         this.legendItemClass = LegendItem;
         super();
         direction = "vertical";
         addEventListener(MouseEvent.CLICK,this.childMouseEventHandler);
         addEventListener(MouseEvent.MOUSE_OVER,this.childMouseEventHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.childMouseEventHandler);
         addEventListener(MouseEvent.MOUSE_UP,this.childMouseEventHandler);
         addEventListener(MouseEvent.MOUSE_DOWN,this.childMouseEventHandler);
         this._dataProvider = new ArrayCollection();
      }
      
      override public function get horizontalScrollPolicy() : String
      {
         return ScrollPolicy.OFF;
      }
      
      override public function set horizontalScrollPolicy(param1:String) : void
      {
      }
      
      override public function get verticalScrollPolicy() : String
      {
         return ScrollPolicy.OFF;
      }
      
      override public function set verticalScrollPolicy(param1:String) : void
      {
      }
      
      [Bindable("collectionChange")]
      public function get dataProvider() : Object
      {
         return this._dataProvider;
      }
      
      public function set dataProvider(param1:Object) : void
      {
         if(this._dataProvider is ChartBase)
         {
            this._dataProvider.removeEventListener("legendDataChanged",this.legendDataChangedHandler);
         }
         this._dataProvider = !!param1?param1:[];
         if(this._dataProvider is ChartBase)
         {
            this._dataProvider.addEventListener("legendDataChanged",this.legendDataChangedHandler,false,0,true);
         }
         else if(!(this._dataProvider is ICollectionView))
         {
            if(this._dataProvider is IList)
            {
               this._dataProvider = new ListCollectionView(IList(this._dataProvider));
            }
            else if(this._dataProvider is Array)
            {
               this._dataProvider = new ArrayCollection(this._dataProvider as Array);
            }
            else if(this._dataProvider != null)
            {
               this._dataProvider = new ArrayCollection([this._dataProvider]);
            }
            else
            {
               this._dataProvider = new ArrayCollection();
            }
         }
         invalidateProperties();
         invalidateSize();
         this._childrenDirty = true;
         dispatchEvent(new Event("collectionChange"));
      }
      
      private function initStyles() : Boolean
      {
         HaloDefaults.init(styleManager);
         var o:CSSStyleDeclaration = HaloDefaults.createSelector("mx.charts.Legend",styleManager);
         o.defaultFactory = function():void
         {
            this.borderStyle = "none";
            this.horizontalGap = 20;
            this.maintainAspectRatio = true;
            this.paddingBottom = 5;
            this.paddingLeft = 5;
            this.paddingRight = 5;
            this.paddingTop = 5;
            this.verticalGap = 7;
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
         if(this._childrenDirty)
         {
            this.populateFromArray(this._dataProvider);
            this._childrenDirty = false;
         }
      }
      
      override protected function measure() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:EdgeMetrics = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Array = null;
         var _loc15_:int = 0;
         var _loc16_:Boolean = false;
         super.measure();
         findCellSize();
         _loc1_ = cellWidth;
         _loc2_ = cellHeight;
         var _loc9_:int = this.numChildren;
         if(_loc9_ > 0)
         {
            _loc12_ = getStyle("horizontalGap");
            _loc13_ = getStyle("verticalGap");
            _loc5_ = viewMetricsAndPadding;
            if(direction == "vertical")
            {
               _loc16_ = false;
               if(!isNaN(explicitHeight))
               {
                  _loc4_ = explicitHeight - _loc5_.top - _loc5_.bottom;
                  _loc16_ = true;
               }
               else if(!isNaN(this._actualMajorAxisLength))
               {
                  _loc4_ = this._actualMajorAxisLength * cellHeight + (this._actualMajorAxisLength - 1) * _loc13_;
                  this._actualMajorAxisLength = NaN;
                  _loc16_ = true;
               }
               if(_loc16_)
               {
                  _loc14_ = this.calcColumnWidthsForHeight(_loc4_);
                  _loc3_ = 0;
                  _loc6_ = _loc14_.length;
                  _loc8_ = _loc6_;
                  _loc7_ = 0;
                  while(_loc7_ < _loc8_)
                  {
                     _loc3_ = _loc3_ + _loc14_[_loc7_];
                     _loc7_++;
                  }
                  _loc3_ = _loc3_ + (_loc6_ - 1) * _loc12_;
                  _loc15_ = Math.min(_loc9_,Math.max(1,Math.floor((_loc4_ + _loc13_) / (cellHeight + _loc13_))));
                  _loc4_ = _loc15_ * cellHeight + (_loc15_ - 1) * _loc13_;
                  this._preferredMajorAxisLength = _loc15_;
               }
               else
               {
                  _loc4_ = _loc9_ * cellHeight + (_loc9_ - 1) * _loc13_;
                  _loc3_ = cellWidth;
                  this._preferredMajorAxisLength = _loc9_;
               }
            }
            else
            {
               if(!isNaN(explicitWidth))
               {
                  _loc3_ = explicitWidth - _loc5_.left - _loc5_.right;
               }
               else if(!isNaN(this._actualMajorAxisLength))
               {
                  _loc3_ = this._actualMajorAxisLength - _loc5_.left - _loc5_.right;
                  this._actualMajorAxisLength = NaN;
               }
               else
               {
                  _loc3_ = screen.width - _loc5_.left - _loc5_.right;
               }
               _loc14_ = this.calcColumnWidthsForWidth(_loc3_);
               _loc3_ = 0;
               _loc6_ = _loc14_.length;
               _loc8_ = _loc6_;
               _loc7_ = 0;
               while(_loc7_ < _loc8_)
               {
                  _loc3_ = _loc3_ + _loc14_[_loc7_];
                  _loc7_++;
               }
               _loc3_ = _loc3_ + (_loc6_ - 1) * _loc12_;
               _loc15_ = Math.ceil(_loc9_ / _loc6_);
               _loc4_ = _loc15_ * cellHeight + (_loc15_ - 1) * _loc13_;
               this._preferredMajorAxisLength = _loc6_;
            }
         }
         else
         {
            _loc3_ = _loc1_;
            _loc4_ = _loc2_;
         }
         _loc5_ = viewMetricsAndPadding;
         var _loc10_:Number = _loc5_.left + _loc5_.right;
         var _loc11_:Number = _loc5_.top + _loc5_.bottom;
         _loc1_ = _loc1_ + _loc10_;
         _loc3_ = _loc3_ + _loc10_;
         _loc2_ = _loc2_ + _loc11_;
         _loc4_ = _loc4_ + _loc11_;
         measuredMinWidth = _loc1_;
         measuredMinHeight = _loc2_;
         measuredWidth = _loc3_;
         measuredHeight = _loc4_;
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
         this._unscaledWidth = param1;
         this._unscaledHeight = param2;
         if(isNaN(cellWidth))
         {
            findCellSize();
         }
         if(direction == "vertical")
         {
            this.layoutVertical();
         }
         else
         {
            this.layoutHorizontal();
         }
      }
      
      private function addLegendItem(param1:Object) : void
      {
         var _loc2_:Class = this.legendItemClass;
         var _loc3_:LegendItem = new _loc2_();
         _loc3_.marker = param1.marker;
         if(param1.label != "")
         {
            _loc3_.label = param1.label;
         }
         if(param1.element)
         {
            _loc3_.element = param1.element;
         }
         if("fill" in param1)
         {
            _loc3_.setStyle("fill",param1["fill"]);
         }
         _loc3_.markerAspectRatio = param1.aspectRatio;
         _loc3_.legendData = param1;
         _loc3_.percentWidth = 100;
         _loc3_.percentHeight = 100;
         addChild(_loc3_);
         _loc3_.setStyle("backgroundColor",15658751);
      }
      
      private function populateFromArray(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(param1 is ChartBase)
         {
            param1 = param1.legendData;
         }
         removeAllChildren();
         var _loc3_:int = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_] as Array;
            if(!_loc5_)
            {
               _loc2_ = param1[_loc4_];
               this.addLegendItem(_loc2_);
            }
            else
            {
               _loc6_ = _loc5_.length;
               _loc7_ = 0;
               while(_loc7_ < _loc6_)
               {
                  _loc2_ = _loc5_[_loc7_];
                  this.addLegendItem(_loc2_);
                  _loc7_++;
               }
            }
            _loc4_++;
         }
         this._actualMajorAxisLength = NaN;
      }
      
      private function findHorizontalAlignValue() : Number
      {
         var _loc1_:String = getStyle("horizontalAlign");
         if(_loc1_ == "center")
         {
            return 0.5;
         }
         if(_loc1_ == "right")
         {
            return 1;
         }
         return 0;
      }
      
      private function findVerticalAlignValue() : Number
      {
         var _loc1_:String = getStyle("verticalAlign");
         if(_loc1_ == "middle")
         {
            return 0.5;
         }
         if(_loc1_ == "bottom")
         {
            return 1;
         }
         return 0;
      }
      
      private function widthPadding(param1:Number) : Number
      {
         var _loc2_:EdgeMetrics = viewMetricsAndPadding;
         var _loc3_:Number = _loc2_.left + _loc2_.right;
         if(param1 > 1 && direction == "horizontal")
         {
            _loc3_ = _loc3_ + getStyle("horizontalGap") * (param1 - 1);
         }
         return _loc3_;
      }
      
      private function heightPadding(param1:Number) : Number
      {
         var _loc2_:EdgeMetrics = viewMetricsAndPadding;
         var _loc3_:Number = _loc2_.top + _loc2_.bottom;
         if(param1 > 1 && direction == "vertical")
         {
            _loc3_ = _loc3_ + getStyle("verticalGap") * (param1 - 1);
         }
         return _loc3_;
      }
      
      private function calcColumnWidthsForHeight(param1:Number) : Array
      {
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:IUIComponent = null;
         var _loc9_:int = 0;
         var _loc2_:Number = numChildren;
         var _loc3_:Number = getStyle("verticalGap");
         if(isNaN(_loc3_))
         {
            _loc3_ = 0;
         }
         var _loc4_:int = Math.min(_loc2_,Math.max(1,Math.floor((param1 + _loc3_) / (cellHeight + _loc3_))));
         var _loc5_:int = _loc4_ == 0?0:int(Math.ceil(_loc2_ / _loc4_));
         if(_loc5_ <= 1)
         {
            _loc6_ = [cellWidth];
         }
         else
         {
            _loc6_ = [];
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               _loc6_[_loc7_] = 0;
               _loc7_++;
            }
            _loc7_ = 0;
            while(_loc7_ < _loc2_)
            {
               _loc8_ = IUIComponent(getChildAt(_loc7_));
               _loc9_ = Math.floor(_loc7_ / _loc4_);
               _loc6_[_loc9_] = Math.max(_loc6_[_loc9_],_loc8_.getExplicitOrMeasuredWidth());
               _loc7_++;
            }
         }
         return _loc6_;
      }
      
      private function layoutVertical() : void
      {
         var _loc14_:IUIComponent = null;
         var _loc15_:int = 0;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc1_:Number = numChildren;
         var _loc2_:EdgeMetrics = viewMetricsAndPadding;
         var _loc3_:Number = getStyle("horizontalGap");
         var _loc4_:Number = getStyle("verticalGap");
         var _loc5_:String = getStyle("horizontalAlign");
         var _loc6_:String = getStyle("verticalAlign");
         var _loc7_:Number = _loc2_.left;
         var _loc8_:Number = _loc2_.top;
         var _loc9_:Number = unscaledHeight - _loc2_.bottom;
         var _loc10_:int = Math.min(_loc1_,Math.max(1,Math.floor((_loc9_ - _loc8_ + _loc4_) / (cellHeight + _loc4_))));
         var _loc11_:Array = [];
         _loc11_ = this.calcColumnWidthsForHeight(_loc9_ - _loc8_);
         var _loc12_:int = _loc11_.length;
         var _loc13_:Number = 0;
         while(_loc13_ < _loc1_)
         {
            _loc14_ = IUIComponent(getChildAt(_loc13_));
            _loc15_ = Math.floor(_loc13_ / _loc10_);
            _loc16_ = _loc11_[_loc15_];
            if(_loc14_.percentWidth > 0)
            {
               _loc17_ = Math.min(_loc16_,_loc16_ * _loc14_.percentWidth / 100);
            }
            else
            {
               _loc17_ = _loc14_.getExplicitOrMeasuredWidth();
            }
            if(_loc14_.percentHeight > 0)
            {
               _loc18_ = Math.min(cellHeight,cellHeight * _loc14_.percentHeight / 100);
            }
            else
            {
               _loc18_ = _loc14_.getExplicitOrMeasuredHeight();
            }
            _loc14_.setActualSize(_loc17_,_loc18_);
            _loc19_ = Math.floor(calcHorizontalOffset(_loc14_.width,_loc5_));
            _loc20_ = Math.floor(calcVerticalOffset(_loc14_.height,_loc6_));
            _loc14_.move(_loc7_ + _loc19_,_loc8_ + _loc20_);
            if(_loc13_ % _loc10_ == _loc10_ - 1)
            {
               _loc8_ = _loc2_.top;
               _loc7_ = _loc7_ + (_loc16_ + _loc3_);
            }
            else
            {
               _loc8_ = _loc8_ + (cellHeight + _loc4_);
            }
            _loc13_++;
         }
         if(_loc10_ != this._preferredMajorAxisLength)
         {
            this._actualMajorAxisLength = _loc10_;
            invalidateSize();
         }
      }
      
      private function calcColumnWidthsForWidth(param1:Number) : Array
      {
         var _loc7_:Array = null;
         var _loc10_:IUIComponent = null;
         var _loc11_:Number = NaN;
         var _loc12_:int = 0;
         var _loc2_:Number = numChildren;
         var _loc3_:Number = getStyle("horizontalGap");
         var _loc4_:Number = 0;
         var _loc5_:Number = param1;
         var _loc6_:int = 0;
         var _loc8_:Number = 0;
         while(_loc8_ < _loc2_)
         {
            _loc10_ = IUIComponent(getChildAt(_loc8_));
            _loc11_ = _loc10_.getExplicitOrMeasuredWidth();
            if(_loc4_ + _loc11_ > _loc5_)
            {
               break;
            }
            _loc4_ = _loc4_ + (_loc11_ + _loc3_);
            _loc6_++;
            _loc8_++;
         }
         var _loc9_:Boolean = true;
         while(_loc6_ > 1 && _loc9_)
         {
            _loc7_ = [];
            _loc8_ = 0;
            while(_loc8_ < _loc6_)
            {
               _loc7_[_loc8_] = 0;
               _loc8_++;
            }
            _loc8_ = 0;
            while(_loc8_ < _loc2_)
            {
               _loc12_ = _loc8_ % _loc6_;
               _loc7_[_loc12_] = Math.max(_loc7_[_loc12_],IUIComponent(getChildAt(_loc8_)).getExplicitOrMeasuredWidth());
               _loc8_++;
            }
            _loc4_ = 0;
            _loc8_ = 0;
            while(_loc8_ < _loc6_)
            {
               if(_loc4_ + _loc7_[_loc8_] > _loc5_)
               {
                  break;
               }
               _loc4_ = _loc4_ + (_loc7_[_loc8_] + _loc3_);
               _loc8_++;
            }
            if(_loc8_ == _loc6_)
            {
               _loc9_ = false;
            }
            else
            {
               _loc6_--;
            }
         }
         if(_loc6_ <= 1)
         {
            _loc6_ = 1;
            _loc7_ = [cellWidth];
         }
         return _loc7_;
      }
      
      private function layoutHorizontal() : void
      {
         var _loc11_:Array = null;
         var _loc13_:IUIComponent = null;
         var _loc14_:int = 0;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc1_:Number = numChildren;
         var _loc2_:EdgeMetrics = viewMetricsAndPadding;
         var _loc3_:Number = getStyle("horizontalGap");
         var _loc4_:Number = getStyle("verticalGap");
         var _loc5_:String = getStyle("horizontalAlign");
         var _loc6_:String = getStyle("verticalAlign");
         var _loc7_:Number = _loc2_.left;
         var _loc8_:Number = this._unscaledWidth - _loc2_.right;
         var _loc9_:Number = _loc2_.top;
         var _loc10_:int = 0;
         _loc11_ = this.calcColumnWidthsForWidth(_loc8_ - _loc7_);
         _loc10_ = _loc11_.length;
         var _loc12_:Number = 0;
         while(_loc12_ < _loc1_)
         {
            _loc13_ = IUIComponent(getChildAt(_loc12_));
            _loc14_ = _loc12_ % _loc10_;
            _loc15_ = _loc11_[_loc14_];
            if(_loc13_.percentWidth > 0)
            {
               _loc16_ = Math.min(_loc15_,_loc15_ * _loc13_.percentWidth / 100);
            }
            else
            {
               _loc16_ = _loc13_.getExplicitOrMeasuredWidth();
            }
            if(_loc13_.percentHeight > 0)
            {
               _loc17_ = Math.min(cellHeight,cellHeight * _loc13_.percentHeight / 100);
            }
            else
            {
               _loc17_ = _loc13_.getExplicitOrMeasuredHeight();
            }
            _loc13_.setActualSize(_loc16_,_loc17_);
            _loc18_ = Math.floor(calcHorizontalOffset(_loc13_.width,_loc5_));
            _loc19_ = Math.floor(calcVerticalOffset(_loc13_.height,_loc6_));
            _loc13_.move(_loc7_ + _loc18_,_loc9_ + _loc19_);
            if(_loc14_ == _loc10_ - 1)
            {
               _loc7_ = _loc2_.left;
               _loc9_ = _loc9_ + (cellHeight + _loc4_);
            }
            else
            {
               _loc7_ = _loc7_ + (_loc11_[_loc14_] + _loc3_);
            }
            _loc12_++;
         }
         if(_loc10_ != this._preferredMajorAxisLength)
         {
            this._actualMajorAxisLength = this._unscaledWidth;
            invalidateSize();
         }
      }
      
      private function legendDataChangedHandler(param1:Event = null) : void
      {
         invalidateProperties();
         invalidateSize();
         this._childrenDirty = true;
      }
      
      private function childMouseEventHandler(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = DisplayObject(param1.target);
         while(_loc2_ != this && _loc2_.parent != this)
         {
            _loc2_ = _loc2_.parent;
         }
         if(_loc2_ is LegendItem)
         {
            dispatchEvent(new LegendMouseEvent(param1.type,param1,LegendItem(_loc2_)));
         }
      }
   }
}
