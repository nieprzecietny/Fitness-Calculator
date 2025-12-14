package mx.controls.listClasses
{
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import mx.core.FlexShape;
   import mx.core.UIComponent;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class AdvancedListBaseContentHolder extends UIComponent
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
       
      
      private var parentList:AdvancedListBase;
      
      private var maskShape:Shape;
      
      mx_internal var allowItemSizeChangeNotification:Boolean = true;
      
      public var leftOffset:Number = 0;
      
      public var topOffset:Number = 0;
      
      public var rightOffset:Number = 0;
      
      public var bottomOffset:Number = 0;
      
      public function AdvancedListBaseContentHolder(param1:AdvancedListBase)
      {
         super();
         this.parentList = param1;
         setStyle("backgroundColor","");
         setStyle("borderStyle","none");
      }
      
      override public function set focusPane(param1:Sprite) : void
      {
         var _loc2_:Graphics = null;
         if(param1)
         {
            if(!this.maskShape)
            {
               this.maskShape = new FlexShape();
               this.maskShape.name = "mask";
               _loc2_ = this.maskShape.graphics;
               _loc2_.beginFill(16777215);
               _loc2_.drawRect(-2,-2,width + 2,height + 2);
               _loc2_.endFill();
               addChild(this.maskShape);
            }
            this.maskShape.visible = false;
            param1.mask = this.maskShape;
         }
         else if(this.parentList.focusPane.mask == this.maskShape)
         {
            this.parentList.focusPane.mask = null;
         }
         this.parentList.focusPane = param1;
         param1.x = x;
         param1.y = y;
      }
      
      public function get heightExcludingOffsets() : Number
      {
         return height + this.topOffset - this.bottomOffset;
      }
      
      public function get widthExcludingOffsets() : Number
      {
         return width + this.leftOffset - this.rightOffset;
      }
      
      override public function invalidateSize() : void
      {
         if(this.allowItemSizeChangeNotification)
         {
            this.parentList.invalidateList();
         }
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
         if(this.maskShape)
         {
            this.maskShape.width = param1;
            this.maskShape.height = param2;
         }
      }
      
      mx_internal function getParentList() : AdvancedListBase
      {
         return this.parentList;
      }
   }
}
