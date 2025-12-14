package mx.charts
{
   import flash.filters.DropShadowFilter;
   import mx.charts.chartClasses.CartesianChart;
   import mx.charts.chartClasses.DataTip;
   import mx.charts.chartClasses.IAxis;
   import mx.charts.renderers.LineRenderer;
   import mx.charts.styles.HaloDefaults;
   import mx.core.ClassFactory;
   import mx.core.IFlexModuleFactory;
   import mx.core.mx_internal;
   import mx.graphics.SolidColor;
   import mx.graphics.Stroke;
   import mx.styles.CSSStyleDeclaration;
   
   use namespace mx_internal;
   
   public class LineChart extends CartesianChart
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
       
      
      private var _moduleFactoryInitialized:Boolean = false;
      
      public function LineChart()
      {
         super();
         LinearAxis(horizontalAxis).autoAdjust = false;
         seriesFilters = [new DropShadowFilter()];
      }
      
      override public function set horizontalAxis(param1:IAxis) : void
      {
         if(param1 is CategoryAxis)
         {
            CategoryAxis(param1).padding = 0;
         }
         super.horizontalAxis = param1;
      }
      
      private function initStyles() : Boolean
      {
         var lineChartSeriesStyles:Array = null;
         var styleName:String = null;
         var o:CSSStyleDeclaration = null;
         var f:Function = null;
         HaloDefaults.init(styleManager);
         var lineChartStyle:CSSStyleDeclaration = HaloDefaults.createSelector("mx.charts.LineChart",styleManager);
         lineChartSeriesStyles = [];
         lineChartStyle.defaultFactory = function():void
         {
            this.axisColor = 14016221;
            this.chartSeriesStyles = lineChartSeriesStyles;
            this.dataTipRenderer = DataTip;
            this.fill = new SolidColor(16777215,0);
            this.calloutStroke = new Stroke(8947848,2);
            this.fontSize = 10;
            this.horizontalAxisStyleName = "hangingCategoryAxis";
            this.secondHorizontalAxisStyleName = "hangingCategoryAxis";
            this.secondVerticalAxisStyleName = "blockNumericAxis";
            this.textAlign = "left";
            this.verticalAxisStyleName = "blockNumericAxis";
            this.horizontalAxisStyleNames = ["hangingCategoryAxis"];
            this.verticalAxisStyleNames = ["blockNumericAxis"];
         };
         var n:int = HaloDefaults.defaultColors.length;
         var i:int = 0;
         while(i < n)
         {
            styleName = "haloLineSeries" + i;
            lineChartSeriesStyles[i] = styleName;
            o = HaloDefaults.createSelector("." + styleName,styleManager);
            f = function(param1:CSSStyleDeclaration, param2:Stroke):void
            {
               var o:CSSStyleDeclaration = param1;
               var stroke:Stroke = param2;
               o.defaultFactory = function():void
               {
                  this.lineStroke = stroke;
                  this.stroke = stroke;
                  this.lineSegmentRenderer = new ClassFactory(LineRenderer);
               };
            };
            f(o,new Stroke(HaloDefaults.defaultColors[i],3,1));
            i++;
         }
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
      
      override protected function initSecondaryMode() : void
      {
         super.initSecondaryMode();
         if(!secondVerticalAxis)
         {
            secondVerticalAxis = new LinearAxis();
         }
         if(!secondVerticalAxisRenderer)
         {
            secondVerticalAxisRenderer = new AxisRenderer();
         }
      }
   }
}
