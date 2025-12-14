package mx.controls.advancedDataGridClasses
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import mx.controls.AdvancedDataGridBaseEx;
   import mx.controls.TextInput;
   import mx.controls.listClasses.IListItemRenderer;
   import mx.core.ClassFactory;
   import mx.core.IEmbeddedFontRegistry;
   import mx.core.IFactory;
   import mx.core.IFlexModuleFactory;
   import mx.core.IIMESupport;
   import mx.core.Singleton;
   import mx.core.mx_internal;
   import mx.formatters.Formatter;
   import mx.styles.CSSStyleDeclaration;
   import mx.utils.StringUtil;
   
   use namespace mx_internal;
   
   public class AdvancedDataGridColumn extends CSSStyleDeclaration implements IIMESupport
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
      
      private static var noEmbeddedFonts:Boolean;
      
      private static var _embeddedFontRegistry:IEmbeddedFontRegistry;
      
      private static var _defaultItemEditorFactory:IFactory;
       
      
      mx_internal var owner:AdvancedDataGridBaseEx;
      
      mx_internal var explicitWidth:Number;
      
      private var oldEmbeddedFontContext:IFlexModuleFactory = null;
      
      private var fontPropertiesSet:Boolean = false;
      
      private var hasFontContextBeenSaved:Boolean = false;
      
      mx_internal var colNum:Number;
      
      mx_internal var preferredWidth:Number = 100;
      
      public var sortDescending:Boolean = false;
      
      private var _itemRenderer:IFactory;
      
      private var _dataField:String;
      
      private var _dataTipField:String;
      
      private var _dataTipFunction:Function;
      
      public var draggable:Boolean = true;
      
      public var editable:Boolean = true;
      
      public var itemEditor:IFactory;
      
      public var editorDataField:String = "text";
      
      public var editorHeightOffset:Number = 0;
      
      public var editorWidthOffset:Number = 0;
      
      public var editorXOffset:Number = 0;
      
      public var editorYOffset:Number = 0;
      
      public var editorUsesEnterKey:Boolean = false;
      
      private var _headerRenderer:IFactory;
      
      private var _headerText:String;
      
      private var _headerWordWrap;
      
      private var _imeMode:String;
      
      public var rendererIsEditor:Boolean = false;
      
      private var _labelFunction:Function;
      
      private var _minWidth:Number = 20;
      
      public var resizable:Boolean = true;
      
      private var _showDataTips;
      
      public var sortable:Boolean = true;
      
      private var _sortCompareFunction:Function;
      
      private var _visible:Boolean = true;
      
      private var _width:Number = 100;
      
      private var _wordWrap;
      
      private var _styleFunction:Function;
      
      private var _formatter:Formatter;
      
      public function AdvancedDataGridColumn(param1:String = null)
      {
         this.itemEditor = defaultItemEditorFactory;
         super();
         if(param1)
         {
            this.dataField = param1;
            this.headerText = param1;
         }
      }
      
      private static function get embeddedFontRegistry() : IEmbeddedFontRegistry
      {
         if(!_embeddedFontRegistry && !noEmbeddedFonts)
         {
            try
            {
               _embeddedFontRegistry = IEmbeddedFontRegistry(Singleton.getInstance("mx.core::IEmbeddedFontRegistry"));
            }
            catch(e:Error)
            {
               noEmbeddedFonts = true;
            }
         }
         return _embeddedFontRegistry;
      }
      
      mx_internal static function get defaultItemEditorFactory() : IFactory
      {
         if(!_defaultItemEditorFactory)
         {
            _defaultItemEditorFactory = new ClassFactory(TextInput);
         }
         return _defaultItemEditorFactory;
      }
      
      [Bindable("itemRendererChanged")]
      public function get itemRenderer() : IFactory
      {
         return this._itemRenderer;
      }
      
      public function set itemRenderer(param1:IFactory) : void
      {
         this._itemRenderer = param1;
         if(this.owner)
         {
            this.owner.invalidateList();
            this.owner.columnRendererChanged(this);
         }
         dispatchEvent(new Event("itemRendererChanged"));
      }
      
      [Bindable("dataFieldChanged")]
      public function get dataField() : String
      {
         return this._dataField;
      }
      
      public function set dataField(param1:String) : void
      {
         this._dataField = param1;
         if(this.owner)
         {
            this.owner.invalidateList();
         }
         dispatchEvent(new Event("dataFieldChanged"));
      }
      
      [Bindable("dataTipFieldChanged")]
      public function get dataTipField() : String
      {
         return this._dataTipField;
      }
      
      public function set dataTipField(param1:String) : void
      {
         this._dataTipField = param1;
         if(this.owner)
         {
            this.owner.invalidateList();
         }
         dispatchEvent(new Event("dataTipChanged"));
      }
      
      [Bindable("dataTipFunctionChanged")]
      public function get dataTipFunction() : Function
      {
         return this._dataTipFunction;
      }
      
      public function set dataTipFunction(param1:Function) : void
      {
         this._dataTipFunction = param1;
         if(this.owner)
         {
            this.owner.invalidateList();
         }
         dispatchEvent(new Event("labelFunctionChanged"));
      }
      
      [Bindable("headerRendererChanged")]
      public function get headerRenderer() : IFactory
      {
         return this._headerRenderer;
      }
      
      public function set headerRenderer(param1:IFactory) : void
      {
         this._headerRenderer = param1;
         if(this.owner)
         {
            this.owner.invalidateList();
            this.owner.columnRendererChanged(this);
         }
         dispatchEvent(new Event("headerRendererChanged"));
      }
      
      [Bindable("headerTextChanged")]
      public function get headerText() : String
      {
         return this._headerText != null?this._headerText:this.dataField;
      }
      
      public function set headerText(param1:String) : void
      {
         this._headerText = param1;
         if(this.owner)
         {
            this.owner.invalidateList();
         }
         dispatchEvent(new Event("headerTextChanged"));
      }
      
      public function get headerWordWrap() : *
      {
         return this._headerWordWrap;
      }
      
      public function set headerWordWrap(param1:*) : void
      {
         this._headerWordWrap = param1;
         if(this.owner)
         {
            this.owner.invalidateList();
         }
      }
      
      public function get enableIME() : Boolean
      {
         return false;
      }
      
      public function get imeMode() : String
      {
         return this._imeMode;
      }
      
      public function set imeMode(param1:String) : void
      {
         this._imeMode = param1;
      }
      
      [Bindable("labelFunctionChanged")]
      public function get labelFunction() : Function
      {
         return this._labelFunction;
      }
      
      public function set labelFunction(param1:Function) : void
      {
         this._labelFunction = param1;
         if(this.owner)
         {
            this.owner.invalidateList();
         }
         dispatchEvent(new Event("labelFunctionChanged"));
      }
      
      [Bindable("minWidthChanged")]
      public function get minWidth() : Number
      {
         return this._minWidth;
      }
      
      public function set minWidth(param1:Number) : void
      {
         this._minWidth = param1;
         if(this.owner)
         {
            this.owner.invalidateList();
         }
         if(this._width < param1)
         {
            this._width = param1;
         }
         dispatchEvent(new Event("minWidthChanged"));
      }
      
      public function get showDataTips() : *
      {
         return this._showDataTips;
      }
      
      public function set showDataTips(param1:*) : void
      {
         this._showDataTips = param1;
         if(this.owner)
         {
            this.owner.invalidateList();
         }
      }
      
      [Bindable("sortCompareFunctionChanged")]
      public function get sortCompareFunction() : Function
      {
         return this._sortCompareFunction;
      }
      
      public function set sortCompareFunction(param1:Function) : void
      {
         this._sortCompareFunction = param1;
         dispatchEvent(new Event("sortCompareFunctionChanged"));
      }
      
      public function get visible() : Boolean
      {
         return this._visible;
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(this._visible != param1)
         {
            this._visible = param1;
            if(this.owner)
            {
               this.owner.columnsInvalid = true;
               this.owner.invalidateProperties();
               this.owner.invalidateSize();
               this.owner.invalidateList();
            }
         }
      }
      
      [Bindable("widthChanged")]
      public function get width() : Number
      {
         return this._width;
      }
      
      public function set width(param1:Number) : void
      {
         var _loc2_:Boolean = false;
         this.explicitWidth = param1;
         this.preferredWidth = param1;
         if(this.owner != null)
         {
            _loc2_ = this.resizable;
            this.resizable = false;
            this.owner.resizeColumn(this.colNum,param1);
            this.resizable = _loc2_;
         }
         else
         {
            this._width = param1;
         }
         dispatchEvent(new Event("widthChanged"));
      }
      
      public function get wordWrap() : *
      {
         return this._wordWrap;
      }
      
      public function set wordWrap(param1:*) : void
      {
         this._wordWrap = param1;
         if(this.owner)
         {
            this.owner.invalidateList();
         }
      }
      
      public function get styleFunction() : Function
      {
         return this._styleFunction;
      }
      
      public function set styleFunction(param1:Function) : void
      {
         this._styleFunction = param1;
         if(this.owner)
         {
            this.owner.invalidateDisplayList();
         }
      }
      
      public function get formatter() : Formatter
      {
         return this._formatter;
      }
      
      public function set formatter(param1:Formatter) : void
      {
         this._formatter = param1;
         if(this.owner)
         {
            this.owner.invalidateDisplayList();
         }
      }
      
      override mx_internal function addStyleToProtoChain(param1:Object, param2:DisplayObject, param3:Object = null) : Object
      {
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         var _loc4_:AdvancedDataGridBaseEx = this.owner;
         var _loc5_:IListItemRenderer = IListItemRenderer(param2);
         param1 = super.addStyleToProtoChain(param1,param2);
         if(_loc5_.data && _loc5_.data is AdvancedDataGridColumn)
         {
            _loc7_ = _loc4_.getStyle("headerStyleName");
            if(_loc7_)
            {
               if(_loc7_ is String)
               {
                  _loc7_ = this.owner.styleManager.getMergedStyleDeclaration(String(_loc7_));
               }
               if(_loc7_ is CSSStyleDeclaration)
               {
                  param1 = _loc7_.addStyleToProtoChain(param1,param2);
               }
            }
            _loc7_ = getStyle("headerStyleName");
            if(_loc7_)
            {
               if(_loc7_ is String)
               {
                  _loc7_ = this.owner.styleManager.getMergedStyleDeclaration(String(_loc7_));
               }
               if(_loc7_ is CSSStyleDeclaration)
               {
                  param1 = _loc7_.addStyleToProtoChain(param1,param2);
               }
            }
         }
         if(!this.fontPropertiesSet)
         {
            this.fontPropertiesSet = true;
            this.saveFontContext(!!this.owner?this.owner.moduleFactory:null);
         }
         return param1;
      }
      
      override public function setStyle(param1:String, param2:*) : void
      {
         this.fontPropertiesSet = false;
         var _loc3_:Object = getStyle(param1);
         var _loc4_:Boolean = false;
         if(factory == null && defaultFactory == null && !overrides && _loc3_ !== param2)
         {
            _loc4_ = true;
         }
         super.setLocalStyle(param1,param2);
         if(param1 == "headerStyleName")
         {
            if(this.owner)
            {
               this.owner.regenerateStyleCache(true);
               this.owner.notifyStyleChangeInChildren("headerStyleName",true);
            }
            return;
         }
         if(this.owner)
         {
            if(_loc4_)
            {
               this.owner.regenerateStyleCache(true);
            }
            if(this.hasFontContextChanged(this.owner.moduleFactory))
            {
               this.owner.columnRendererChanged(this);
            }
            this.owner.invalidateList();
         }
      }
      
      mx_internal function setWidth(param1:Number) : void
      {
         this._width = param1;
      }
      
      private function applyFormatting(param1:String) : String
      {
         var _loc2_:String = null;
         if(this.formatter != null && param1 != null)
         {
            _loc2_ = this.formatter.format(param1);
            if(this.formatter.error)
            {
               return null;
            }
            return _loc2_;
         }
         return param1;
      }
      
      public function itemToLabel(param1:Object, param2:Boolean = true) : String
      {
         var _loc3_:String = this.itemToLabelWithoutFormatting(param1);
         if(param2)
         {
            return this.applyFormatting(_loc3_);
         }
         return _loc3_;
      }
      
      private function itemToLabelWithoutFormatting(param1:Object) : String
      {
         var data:Object = param1;
         var headerInfo:AdvancedDataGridHeaderInfo = this.owner.getHeaderInfo(this);
         if(headerInfo.internalLabelFunction != null)
         {
            data = headerInfo.internalLabelFunction(data,this);
         }
         if(!data)
         {
            return " ";
         }
         if(this.labelFunction != null)
         {
            return this.labelFunction(data,this);
         }
         if(this.owner.labelFunction != null)
         {
            return this.owner.labelFunction(data,this);
         }
         if(typeof data == "object" || typeof data == "xml")
         {
            try
            {
               data = data[this.dataField];
            }
            catch(e:Error)
            {
               data = null;
            }
         }
         if(data is String)
         {
            return String(data);
         }
         try
         {
            return data.toString();
         }
         catch(e:Error)
         {
         }
         return " ";
      }
      
      public function itemToDataTip(param1:Object) : String
      {
         var field:String = null;
         var data:Object = param1;
         if(this.dataTipFunction != null)
         {
            return this.dataTipFunction(data);
         }
         if(this.owner.dataTipFunction != null)
         {
            return this.owner.dataTipFunction(data);
         }
         if(data is AdvancedDataGridColumn)
         {
            return AdvancedDataGridColumn(data).headerText;
         }
         if(typeof data == "object" || typeof data == "xml")
         {
            field = this.dataTipField;
            if(!field)
            {
               field = this.owner.dataTipField;
            }
            try
            {
               if(data[field] != null)
               {
                  data = data[field];
               }
               else if(data[this.dataField] != null)
               {
                  data = data[this.dataField];
               }
            }
            catch(e:Error)
            {
               data = null;
            }
         }
         if(data is String)
         {
            return String(data);
         }
         try
         {
            return data.toString();
         }
         catch(e:Error)
         {
         }
         return " ";
      }
      
      private function saveFontContext(param1:IFlexModuleFactory) : void
      {
         this.hasFontContextBeenSaved = true;
         var _loc2_:String = StringUtil.trimArrayElements(getStyle("fontFamily"),",");
         var _loc3_:String = getStyle("fontWeight");
         var _loc4_:String = getStyle("fontStyle");
         var _loc5_:* = _loc3_ == "bold";
         var _loc6_:* = _loc4_ == "italic";
         this.oldEmbeddedFontContext = noEmbeddedFonts || !embeddedFontRegistry?null:embeddedFontRegistry.getAssociatedModuleFactory(_loc2_,_loc5_,_loc6_,this,param1,this.owner.systemManager);
      }
      
      mx_internal function hasFontContextChanged(param1:IFlexModuleFactory) : Boolean
      {
         if(!this.hasFontContextBeenSaved)
         {
            return false;
         }
         var _loc2_:String = StringUtil.trimArrayElements(getStyle("fontFamily"),",");
         var _loc3_:String = getStyle("fontWeight");
         var _loc4_:String = getStyle("fontStyle");
         var _loc5_:* = _loc3_ == "bold";
         var _loc6_:* = _loc4_ == "italic";
         var _loc7_:IFlexModuleFactory = noEmbeddedFonts || !embeddedFontRegistry?null:embeddedFontRegistry.getAssociatedModuleFactory(_loc2_,_loc5_,_loc6_,this,param1,this.owner.systemManager);
         return _loc7_ != this.oldEmbeddedFontContext;
      }
      
      protected function copyProperties(param1:AdvancedDataGridColumn) : void
      {
         param1.defaultFactory = this.defaultFactory;
         param1.editable = this.editable;
         param1.editorDataField = this.editorDataField;
         param1.editorHeightOffset = this.editorHeightOffset;
         param1.editorUsesEnterKey = this.editorUsesEnterKey;
         param1.editorWidthOffset = this.editorWidthOffset;
         param1.editorXOffset = this.editorXOffset;
         param1.editorYOffset = this.editorYOffset;
         param1.factory = this.factory;
         param1.itemEditor = this.itemEditor;
         param1.rendererIsEditor = this.rendererIsEditor;
         param1.resizable = this.resizable;
         param1.sortable = this.sortable;
         param1.sortDescending = this.sortDescending;
         param1.dataField = this.dataField;
         param1.dataTipField = this.dataTipField;
         param1.dataTipFunction = this.dataTipFunction;
         param1.formatter = this.formatter;
         param1.headerRenderer = this.headerRenderer;
         param1.headerText = this.headerText;
         param1.headerWordWrap = this.headerWordWrap;
         param1.imeMode = this.imeMode;
         param1.itemRenderer = this.itemRenderer;
         param1.labelFunction = this.labelFunction;
         param1.minWidth = this.minWidth;
         param1.showDataTips = this.showDataTips;
         param1.sortCompareFunction = this.sortCompareFunction;
         param1.styleFunction = this.styleFunction;
         param1.visible = this.visible;
         param1.width = this.width;
         param1.wordWrap = this.wordWrap;
         param1.setStyle("backgroundColor",this.getStyle("backgroundColor"));
         param1.setStyle("headerStyleName",this.getStyle("headerStyleName"));
         param1.setStyle("paddingLeft",this.getStyle("paddingLeft"));
         param1.setStyle("paddingRight",this.getStyle("paddingRight"));
         param1.setStyle("color",this.getStyle("color"));
         param1.setStyle("disabledColor",this.getStyle("disabledColor"));
         param1.setStyle("fontAntiAliasType",this.getStyle("fontAntiAliasType"));
         param1.setStyle("fontFamily",this.getStyle("fontFamily"));
         param1.setStyle("fontGridFitType",this.getStyle("fontGridFitType"));
         param1.setStyle("fontSharpness",this.getStyle("fontSharpness"));
         param1.setStyle("fontSize",this.getStyle("fontSize"));
         param1.setStyle("fontStyle",this.getStyle("fontStyle"));
         param1.setStyle("fontThickness",this.getStyle("fontThickness"));
         param1.setStyle("fontWeight",this.getStyle("fontWeight"));
         param1.setStyle("kerning",this.getStyle("kerning"));
         param1.setStyle("letterSpacing",this.getStyle("letterSpacing"));
         param1.setStyle("textAlign",this.getStyle("textAlign"));
         param1.setStyle("textDecoration",this.getStyle("textDecoration"));
         param1.setStyle("textIndent",this.getStyle("textIndent"));
      }
      
      public function clone() : AdvancedDataGridColumn
      {
         var _loc1_:AdvancedDataGridColumn = new AdvancedDataGridColumn();
         this.copyProperties(_loc1_);
         return _loc1_;
      }
   }
}
