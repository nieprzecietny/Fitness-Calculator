package mx.charts.renderers
{
   import flash.display.Graphics;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import mx.charts.ChartItem;
   import mx.charts.chartClasses.GraphicsUtilities;
   import mx.charts.series.items.PieSeriesItem;
   import mx.core.IDataRenderer;
   import mx.core.mx_internal;
   import mx.graphics.IFill;
   import mx.graphics.IStroke;
   import mx.graphics.SolidColor;
   import mx.skins.ProgrammaticSkin;
   import mx.utils.ColorUtil;
   
   use namespace mx_internal;
   
   public class WedgeItemRenderer extends ProgrammaticSkin implements IDataRenderer
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
      
      private static const SHADOW_INSET:Number = 8;
       
      
      private var _data:PieSeriesItem;
      
      public function WedgeItemRenderer()
      {
         super();
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set data(param1:Object) : void
      {
         this._data = PieSeriesItem(param1);
         invalidateDisplayList();
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         var _loc14_:uint = 0;
         var _loc17_:Point = null;
         super.updateDisplayList(param1,param2);
         var _loc3_:Graphics = graphics;
         _loc3_.clear();
         if(!this._data)
         {
            return;
         }
         var _loc4_:IStroke = getStyle("stroke");
         var _loc5_:IStroke = getStyle("radialStroke");
         var _loc6_:Number = this._data.outerRadius;
         var _loc7_:Number = this._data.innerRadius;
         var _loc8_:Point = this._data.origin;
         var _loc9_:Number = this._data.angle;
         var _loc10_:Number = this._data.startAngle;
         if(_loc4_ && !isNaN(_loc4_.weight))
         {
            _loc6_ = _loc6_ - Math.max(_loc4_.weight / 2,SHADOW_INSET);
         }
         else
         {
            _loc6_ = _loc6_ - SHADOW_INSET;
         }
         _loc6_ = Math.max(_loc6_,_loc7_);
         var _loc11_:Rectangle = new Rectangle(_loc8_.x - _loc6_,_loc8_.y - _loc6_,2 * _loc6_,2 * _loc6_);
         var _loc12_:IFill = this._data.fill;
         var _loc13_:String = this._data.currentState;
         switch(_loc13_)
         {
            case ChartItem.FOCUSED:
            case ChartItem.ROLLOVER:
               if(styleManager.isValidStyleValue(getStyle("itemRollOverColor")))
               {
                  _loc14_ = getStyle("itemRollOverColor");
               }
               else
               {
                  _loc14_ = ColorUtil.adjustBrightness2(GraphicsUtilities.colorFromFill(_loc12_),-20);
               }
               _loc12_ = new SolidColor(_loc14_);
               break;
            case ChartItem.DISABLED:
               if(styleManager.isValidStyleValue(getStyle("itemDisabledColor")))
               {
                  _loc14_ = getStyle("itemDisabledColor");
               }
               else
               {
                  _loc14_ = ColorUtil.adjustBrightness2(GraphicsUtilities.colorFromFill(_loc12_),20);
               }
               _loc12_ = new SolidColor(GraphicsUtilities.colorFromFill(_loc14_));
               break;
            case ChartItem.FOCUSEDSELECTED:
            case ChartItem.SELECTED:
               if(styleManager.isValidStyleValue(getStyle("itemSelectionColor")))
               {
                  _loc14_ = getStyle("itemSelectionColor");
               }
               else
               {
                  _loc14_ = ColorUtil.adjustBrightness2(GraphicsUtilities.colorFromFill(_loc12_),-30);
               }
               _loc12_ = new SolidColor(_loc14_);
         }
         var _loc15_:Point = new Point(_loc8_.x + Math.cos(_loc10_) * _loc6_,_loc8_.y - Math.sin(_loc10_) * _loc6_);
         var _loc16_:Point = new Point(_loc8_.x + Math.cos(_loc10_ + _loc9_) * _loc6_,_loc8_.y - Math.sin(_loc10_ + _loc9_) * _loc6_);
         _loc3_.moveTo(_loc16_.x,_loc16_.y);
         _loc12_.begin(_loc3_,_loc11_,null);
         GraphicsUtilities.setLineStyle(_loc3_,_loc5_);
         if(_loc7_ == 0)
         {
            _loc3_.lineTo(_loc8_.x,_loc8_.y);
            _loc3_.lineTo(_loc15_.x,_loc15_.y);
         }
         else
         {
            _loc17_ = new Point(_loc8_.x + Math.cos(_loc10_ + _loc9_) * _loc7_,_loc8_.y - Math.sin(_loc10_ + _loc9_) * _loc7_);
            _loc3_.lineTo(_loc17_.x,_loc17_.y);
            GraphicsUtilities.setLineStyle(_loc3_,_loc4_);
            GraphicsUtilities.drawArc(_loc3_,_loc8_.x,_loc8_.y,_loc10_ + _loc9_,-_loc9_,_loc7_,_loc7_,true);
            GraphicsUtilities.setLineStyle(_loc3_,_loc5_);
            _loc3_.lineTo(_loc15_.x,_loc15_.y);
         }
         GraphicsUtilities.setLineStyle(_loc3_,_loc4_);
         GraphicsUtilities.drawArc(_loc3_,_loc8_.x,_loc8_.y,_loc10_,_loc9_,_loc6_,_loc6_,true);
         _loc12_.end(_loc3_);
      }
   }
}
