package mx.controls
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.GradientType;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import flash.utils.getTimer;
   import mx.collections.CursorBookmark;
   import mx.collections.ICollectionView;
   import mx.collections.IViewCursor;
   import mx.collections.ItemResponder;
   import mx.collections.Sort;
   import mx.collections.SortField;
   import mx.collections.errors.ItemPendingError;
   import mx.controls.advancedDataGridClasses.AdvancedDataGridBase;
   import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
   import mx.controls.advancedDataGridClasses.AdvancedDataGridDragProxy;
   import mx.controls.advancedDataGridClasses.AdvancedDataGridHeaderInfo;
   import mx.controls.advancedDataGridClasses.AdvancedDataGridHeaderRenderer;
   import mx.controls.advancedDataGridClasses.AdvancedDataGridItemRenderer;
   import mx.controls.advancedDataGridClasses.AdvancedDataGridListData;
   import mx.controls.advancedDataGridClasses.AdvancedDataGridSortItemRenderer;
   import mx.controls.advancedDataGridClasses.SortInfo;
   import mx.controls.listClasses.IDropInListItemRenderer;
   import mx.controls.listClasses.IListItemRenderer;
   import mx.controls.listClasses.ListBaseSeekPending;
   import mx.controls.listClasses.ListBaseSelectionData;
   import mx.controls.listClasses.ListRowInfo;
   import mx.controls.scrollClasses.ScrollBar;
   import mx.core.ClassFactory;
   import mx.core.ContextualClassFactory;
   import mx.core.EdgeMetrics;
   import mx.core.EventPriority;
   import mx.core.FlexShape;
   import mx.core.FlexSprite;
   import mx.core.IBorder;
   import mx.core.IFactory;
   import mx.core.IFlexDisplayObject;
   import mx.core.IFlexModuleFactory;
   import mx.core.IIMESupport;
   import mx.core.IInvalidating;
   import mx.core.IPropertyChangeNotifier;
   import mx.core.IUIComponent;
   import mx.core.LayoutDirection;
   import mx.core.ScrollPolicy;
   import mx.core.UIComponent;
   import mx.core.UIComponentGlobals;
   import mx.core.mx_internal;
   import mx.events.AdvancedDataGridEvent;
   import mx.events.AdvancedDataGridEventReason;
   import mx.events.CollectionEvent;
   import mx.events.CollectionEventKind;
   import mx.events.DragEvent;
   import mx.events.IndexChangedEvent;
   import mx.events.ListEvent;
   import mx.events.SandboxMouseEvent;
   import mx.events.ScrollEvent;
   import mx.events.ScrollEventDetail;
   import mx.events.ScrollEventDirection;
   import mx.managers.CursorManagerPriority;
   import mx.managers.IFocusManager;
   import mx.managers.IFocusManagerComponent;
   import mx.skins.halo.DataGridColumnDropIndicator;
   import mx.styles.ISimpleStyleClient;
   import mx.utils.ObjectUtil;
   import mx.utils.StringUtil;
   
   use namespace mx_internal;
   
   public class AdvancedDataGridBaseEx extends AdvancedDataGridBase implements IIMESupport
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
      
      public static var useOldDGHeaderBGLogic:Boolean = false;
       
      
      private var dontEdit:Boolean = false;
      
      private var losingFocus:Boolean = false;
      
      private var _focusPane:Sprite;
      
      private var inEndEdit:Boolean = false;
      
      private var collectionUpdatesDisabled:Boolean = false;
      
      private var resizeGraphic:IFlexDisplayObject;
      
      private var startX:Number;
      
      private var minX:Number;
      
      private var lastPt:Point;
      
      private var separators:Array;
      
      protected var lockedSeparators:Array;
      
      private var resizingColumn:AdvancedDataGridColumn;
      
      private var sortIndex:int = -1;
      
      private var sortColumn:AdvancedDataGridColumn;
      
      private var sortDirection:String;
      
      private var lastSortIndex:int = -1;
      
      private var lastItemDown:IListItemRenderer;
      
      protected var movingColumn:AdvancedDataGridColumn;
      
      protected var dropColumnIndex:int = -1;
      
      mx_internal var columnDropIndicator:IFlexDisplayObject;
      
      private var displayWidth:Number;
      
      private var separatorAffordance:Number = 3;
      
      protected var displayableColumns:Array;
      
      protected var generatedColumns:Boolean = true;
      
      protected var measuringObjects:Dictionary;
      
      private var resizeCursorID:int = 0.0;
      
      private var actualRowIndex:int;
      
      private var actualColIndex:int;
      
      private var manualSort:Boolean;
      
      protected var orderedHeadersList:Array;
      
      protected var headerInfoInitialized:Boolean = false;
      
      protected var isKeyPressed:Boolean = false;
      
      private var lookAheadCache:String = "";
      
      private var previousTime:uint;
      
      private var headerBGSkinChanged:Boolean = false;
      
      private var headerSepSkinChanged:Boolean = false;
      
      private var columnsChanged:Boolean = false;
      
      private var subContentScrolled:Boolean = false;
      
      private var minColumnWidthInvalid:Boolean = false;
      
      private var bEditedItemPositionChanged:Boolean = false;
      
      private var _proposedEditedItemPosition;
      
      private var lastEditedItemPosition;
      
      private var _headerWordWrapPresent:Boolean = false;
      
      private var _originalExplicitHeaderHeight:Boolean = false;
      
      private var _originalHeaderHeight:Number = 0;
      
      private var dropIndexFound:Boolean = false;
      
      private var isHeaderDragOutside:Boolean = false;
      
      mx_internal var selectedHeaderInfo:AdvancedDataGridHeaderInfo;
      
      private var _draggableColumns:Boolean = true;
      
      private var _imeMode:String = null;
      
      private var _minColumnWidth:Number;
      
      public var itemEditorInstance:IListItemRenderer;
      
      private var _headerIndex:int = -1;
      
      private var _editable:String = "";
      
      private var _editedItemPosition:Object;
      
      public var lookAheadDuration:Number = 400;
      
      public var resizableColumns:Boolean = true;
      
      public var sortableColumns:Boolean = true;
      
      private var _sortExpertMode:Boolean = false;
      
      public function AdvancedDataGridBaseEx()
      {
         this.orderedHeadersList = [];
         super();
         _columns = [];
         headerRenderer = new ClassFactory(AdvancedDataGridHeaderRenderer);
         sortItemRenderer = new ClassFactory(AdvancedDataGridSortItemRenderer);
         setRowHeight(20);
         addEventListener(AdvancedDataGridEvent.ITEM_EDIT_BEGINNING,this.itemEditorItemEditBeginningHandler,false,EventPriority.DEFAULT_HANDLER);
         addEventListener(AdvancedDataGridEvent.ITEM_EDIT_BEGIN,this.itemEditorItemEditBeginHandler,false,EventPriority.DEFAULT_HANDLER);
         addEventListener(AdvancedDataGridEvent.ITEM_EDIT_END,this.itemEditorItemEditEndHandler,false,EventPriority.DEFAULT_HANDLER);
         addEventListener(AdvancedDataGridEvent.HEADER_RELEASE,this.headerReleaseHandler,false,EventPriority.DEFAULT_HANDLER);
         addEventListener(AdvancedDataGridEvent.SORT,this.sortHandler,false,EventPriority.DEFAULT_HANDLER);
         addEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
      }
      
      override public function get itemRenderer() : IFactory
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:* = false;
         var _loc5_:* = false;
         var _loc6_:IFlexModuleFactory = null;
         var _loc7_:Class = null;
         if(super.itemRenderer == null)
         {
            _loc1_ = StringUtil.trimArrayElements(getStyle("fontFamily"),",");
            _loc2_ = getStyle("fontWeight");
            _loc3_ = getStyle("fontStyle");
            _loc4_ = _loc2_ == "bold";
            _loc5_ = _loc3_ == "italic";
            _loc6_ = getFontContext(_loc1_,_loc4_,_loc5_);
            _loc7_ = getStyle("defaultDataGridItemRenderer");
            if(!_loc7_)
            {
               _loc7_ = AdvancedDataGridItemRenderer;
            }
            super.itemRenderer = new ContextualClassFactory(_loc7_,_loc6_);
         }
         return super.itemRenderer;
      }
      
      override public function get baselinePosition() : Number
      {
         var _loc1_:Number = 0;
         if(border && border is IBorder)
         {
            _loc1_ = IBorder(border).borderMetrics.top;
         }
         return _loc1_ + measureText(" ").ascent;
      }
      
      override public function get columnCount() : int
      {
         if(_columns)
         {
            return _columns.length;
         }
         return 0;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         if(this.itemEditorInstance)
         {
            this.endEdit(AdvancedDataGridEventReason.OTHER);
         }
         invalidateDisplayList();
      }
      
      override public function set horizontalScrollPosition(param1:Number) : void
      {
         var _loc3_:CursorBookmark = null;
         if(!initialized || listItems.length == 0)
         {
            super.horizontalScrollPosition = param1;
            return;
         }
         var _loc2_:int = super.horizontalScrollPosition;
         super.horizontalScrollPosition = param1;
         columnsInvalid = true;
         this.calculateColumnSizes();
         if(itemsSizeChanged)
         {
            return;
         }
         if(_loc2_ != param1)
         {
            removeClipMask();
            if(getOptimumColumns() == visibleColumns)
            {
               visibleData = {};
               scrollAreaChanged = true;
               if(iterator)
               {
                  _loc3_ = iterator.bookmark;
               }
               this.makeRowsAndColumns(0,0,listContent.width,listContent.height,0,0);
               if(iterator && _loc3_)
               {
                  iterator.seek(_loc3_,0);
               }
            }
            else
            {
               this.subContentScrolled = true;
            }
            this.updateSubContent();
            this.updateHeaderSearchList();
            addClipMask(false);
            invalidateDisplayList();
         }
      }
      
      override public function set verticalScrollPosition(param1:Number) : void
      {
         super.verticalScrollPosition = param1;
         if(variableRowHeight)
         {
            this.drawHorizontalSeparators();
         }
      }
      
      override public function set focusPane(param1:Sprite) : void
      {
         super.focusPane = param1;
         if(param1)
         {
            param1.scrollRect = !!listSubContent?listSubContent.scrollRect:null;
         }
         if(!param1 && this._focusPane)
         {
            this._focusPane.mask = null;
         }
         this._focusPane = param1;
      }
      
      override public function set horizontalScrollPolicy(param1:String) : void
      {
         super.horizontalScrollPolicy = param1;
         columnsInvalid = true;
         itemsSizeChanged = true;
         invalidateDisplayList();
      }
      
      override public function set lockedColumnCount(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1 > super.lockedColumnCount)
         {
            _loc2_ = super.lockedColumnCount;
            while(_loc2_ < param1)
            {
               _loc4_ = listItems.length;
               _loc3_ = 0;
               while(_loc3_ < _loc4_)
               {
                  if(listItems[_loc3_] && listItems[_loc3_][_loc2_])
                  {
                     delete columnMap[listItems[_loc3_][_loc2_].name];
                  }
                  _loc3_++;
               }
               _loc2_++;
            }
         }
         else if(param1 < super.lockedColumnCount)
         {
            _loc2_ = param1;
            while(_loc2_ < super.lockedColumnCount)
            {
               _loc4_ = listItems.length;
               _loc3_ = 0;
               while(_loc3_ < _loc4_)
               {
                  if(listItems[_loc3_] && listItems[_loc3_][_loc2_])
                  {
                     delete columnMap[listItems[_loc3_][_loc2_].name];
                  }
                  _loc3_++;
               }
               _loc2_++;
            }
         }
         super.lockedColumnCount = param1;
         this.updateSubContent();
         itemsSizeChanged = true;
         columnsInvalid = true;
         this.horizontalScrollPosition = super.horizontalScrollPosition;
      }
      
      override protected function get dragImage() : IUIComponent
      {
         var _loc1_:AdvancedDataGridDragProxy = new AdvancedDataGridDragProxy();
         _loc1_.owner = this;
         _loc1_.moduleFactory = moduleFactory;
         return _loc1_;
      }
      
      [Bindable("columnsChanged")]
      public function get columns() : Array
      {
         return _columns.slice(0);
      }
      
      public function set columns(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:AdvancedDataGridColumn = null;
         purgeHeaderRenderers();
         _loc2_ = _columns.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.columnRendererChanged(_columns[_loc3_]);
            _loc3_++;
         }
         freeItemRenderersTable = new Dictionary(false);
         itemRendererToFactoryMap = new Dictionary(true);
         columnMap = {};
         _columns = param1.slice(0);
         columnsInvalid = true;
         this.generatedColumns = false;
         _loc2_ = param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = _columns[_loc3_];
            _loc4_.owner = this;
            _loc4_.colNum = _loc3_;
            _loc3_++;
         }
         this.updateSortIndexAndDirection();
         itemsSizeChanged = true;
         this.columnsChanged = true;
         invalidateDisplayList();
         dispatchEvent(new Event("columnsChanged"));
      }
      
      public function get draggableColumns() : Boolean
      {
         return this._draggableColumns;
      }
      
      public function set draggableColumns(param1:Boolean) : void
      {
         this._draggableColumns = param1;
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
      
      public function get minColumnWidth() : Number
      {
         return this._minColumnWidth;
      }
      
      public function set minColumnWidth(param1:Number) : void
      {
         this._minColumnWidth = param1;
         this.minColumnWidthInvalid = true;
         itemsSizeChanged = true;
         columnsInvalid = true;
         invalidateDisplayList();
      }
      
      public function get editedItemRenderer() : IListItemRenderer
      {
         if(!this.itemEditorInstance)
         {
            return null;
         }
         return listItems[this.actualRowIndex][this.actualColIndex];
      }
      
      mx_internal function set headerIndex(param1:int) : void
      {
         this._headerIndex = param1;
         dispatchEvent(new ListEvent(ListEvent.CHANGE));
      }
      
      mx_internal function get headerIndex() : int
      {
         return this._headerIndex;
      }
      
      public function get editable() : String
      {
         return this._editable;
      }
      
      public function set editable(param1:String) : void
      {
         this._editable = "";
         if(!param1)
         {
            return;
         }
         var _loc2_:Array = param1.split(" ");
         var _loc3_:int = _loc2_.length;
         var _loc4_:Boolean = true;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_ && _loc4_)
         {
            switch(_loc2_[_loc5_])
            {
               case "item":
               case "group":
               case "summary":
                  this._editable = this._editable + (_loc2_[_loc5_] + " ");
                  break;
               case "true":
                  this._editable = "item" + " ";
                  _loc4_ = false;
                  break;
               case "false":
                  this._editable = "" + " ";
                  _loc4_ = false;
                  break;
               case "all":
                  this._editable = "item group summary" + " ";
                  _loc4_ = false;
            }
            _loc5_++;
         }
         this._editable = this._editable.slice(0,-1);
      }
      
      [Bindable("itemFocusIn")]
      public function get editedItemPosition() : Object
      {
         if(this._editedItemPosition)
         {
            return {
               "rowIndex":this._editedItemPosition.rowIndex,
               "columnIndex":this._editedItemPosition.columnIndex
            };
         }
         return this._editedItemPosition;
      }
      
      public function set editedItemPosition(param1:Object) : void
      {
         if(!param1)
         {
            this.setEditedItemPosition(null);
            return;
         }
         var _loc2_:Object = {
            "rowIndex":param1.rowIndex,
            "columnIndex":param1.columnIndex
         };
         this.setEditedItemPosition(_loc2_);
      }
      
      public function get sortExpertMode() : Boolean
      {
         return this._sortExpertMode;
      }
      
      public function set sortExpertMode(param1:Boolean) : void
      {
         this._sortExpertMode = param1;
         this.invalidateHeaders();
         invalidateProperties();
         invalidateDisplayList();
      }
      
      override public function set dataProvider(param1:Object) : void
      {
         if(this.itemEditorInstance)
         {
            this.endEdit(AdvancedDataGridEventReason.OTHER);
         }
         this.lastEditedItemPosition = null;
         super.dataProvider = param1;
         invalidateProperties();
      }
      
      override protected function findKey(param1:int) : Boolean
      {
         var _loc2_:int = param1;
         var _loc3_:uint = getTimer();
         var _loc4_:String = String.fromCharCode(_loc2_);
         if(!(_loc2_ >= 33 && _loc2_ <= 126))
         {
            return false;
         }
         var _loc5_:Number = _selectedIndex;
         if(_loc3_ - this.previousTime < this.lookAheadDuration)
         {
            _loc4_ = this.lookAheadCache + _loc4_;
            this.lookAheadCache = _loc4_;
            this.previousTime = _loc3_;
            if(_selectedIndex > 0)
            {
               _loc5_ = _selectedIndex;
               _selectedIndex--;
            }
         }
         else
         {
            this.previousTime = _loc3_;
            this.lookAheadCache = _loc4_;
         }
         var _loc6_:Boolean = findString(_loc4_);
         if(!_loc6_ && _selectedIndex != _loc5_)
         {
            _selectedIndex = _loc5_;
         }
         return _loc6_;
      }
      
      override protected function measure() : void
      {
         super.measure();
         var _loc1_:EdgeMetrics = viewMetrics;
         var _loc2_:int = this.columns.length;
         if(_loc2_ == 0)
         {
            measuredWidth = DEFAULT_MEASURED_WIDTH;
            measuredMinWidth = DEFAULT_MEASURED_MIN_WIDTH;
            return;
         }
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            if(this.columns[_loc5_].visible)
            {
               _loc3_ = _loc3_ + this.columns[_loc5_].preferredWidth;
               if(isNaN(this._minColumnWidth))
               {
                  _loc4_ = _loc4_ + this.columns[_loc5_].minWidth;
               }
            }
            _loc5_++;
         }
         if(!isNaN(this._minColumnWidth))
         {
            _loc4_ = _loc2_ * this._minColumnWidth;
         }
         measuredWidth = _loc3_ + _loc1_.left + _loc1_.right;
         measuredMinWidth = _loc4_ + _loc1_.left + _loc1_.right;
         if(verticalScrollPolicy == ScrollPolicy.AUTO && verticalScrollBar && verticalScrollBar.visible)
         {
            measuredWidth = measuredWidth - verticalScrollBar.minWidth;
            measuredMinWidth = measuredMinWidth - verticalScrollBar.minWidth;
         }
         if(horizontalScrollPolicy == ScrollPolicy.AUTO && horizontalScrollBar && horizontalScrollBar.visible)
         {
            measuredHeight = measuredHeight - horizontalScrollBar.minHeight;
            measuredMinHeight = measuredMinHeight - horizontalScrollBar.minHeight;
         }
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         var _loc5_:EdgeMetrics = null;
         var _loc6_:Number = NaN;
         var _loc7_:Class = null;
         var _loc8_:IFlexDisplayObject = null;
         var _loc3_:Boolean = false;
         if(this.displayWidth != param1 - viewMetrics.right - viewMetrics.left)
         {
            this.displayWidth = param1 - viewMetrics.right - viewMetrics.left;
            columnsInvalid = true;
            _loc3_ = true;
         }
         this.calculateColumnSizes();
         if(_loc3_)
         {
            this.updateSubContent();
         }
         if(rendererChanged)
         {
            purgeItemRenderers();
         }
         super.updateDisplayList(param1,param2);
         if(horizontalScrollPolicy != ScrollPolicy.OFF && getOptimumColumns() != visibleColumns && !itemsSizeChanged && !bSelectionChanged && !scrollAreaChanged && this.subContentScrolled)
         {
            this.configureScrollBars();
            this.subContentScrolled = false;
         }
         if(collection && collection.length)
         {
            setRowCount(listItems.length);
            if(headerInfos && headerInfos.length)
            {
               setColumnCount(headerInfos.length);
            }
            else
            {
               setColumnCount(0);
            }
         }
         if(_horizontalScrollPolicy == ScrollPolicy.OFF)
         {
            _loc5_ = borderMetrics;
            _loc6_ = !!headerRowInfo.length?Number(headerRowInfo[0].height):Number(headerHeight);
            if(verticalScrollBar != null && verticalScrollBar.visible && headerVisible && roomForScrollBar(verticalScrollBar,param1 - _loc5_.left - _loc5_.right,param2 - _loc6_ - _loc5_.top - _loc5_.bottom))
            {
               verticalScrollBar.move(verticalScrollBar.x,viewMetrics.top + _loc6_);
               verticalScrollBar.setActualSize(verticalScrollBar.width,param2 - viewMetrics.top - viewMetrics.bottom - _loc6_);
               verticalScrollBar.visible = verticalScrollBar.height >= verticalScrollBar.minHeight;
            }
         }
         if(this.bEditedItemPositionChanged)
         {
            this.bEditedItemPositionChanged = false;
            this.commitEditedItemPosition(this._proposedEditedItemPosition);
            this._proposedEditedItemPosition = undefined;
            itemsSizeChanged = false;
         }
         var _loc4_:UIComponent = UIComponent(listContent.getChildByName("headerBG"));
         if(this.headerBGSkinChanged)
         {
            this.headerBGSkinChanged = false;
            if(_loc4_)
            {
               listContent.removeChild(_loc4_);
            }
            _loc4_ = null;
         }
         if(!_loc4_)
         {
            _loc4_ = new UIComponent();
            _loc4_.name = "headerBG";
            listContent.addChildAt(DisplayObject(_loc4_),listContent.getChildIndex(selectionLayer));
            _loc7_ = getStyle("headerBackgroundSkin");
            if(_loc7_ != null)
            {
               _loc8_ = new _loc7_();
               if(_loc8_ is ISimpleStyleClient)
               {
                  ISimpleStyleClient(_loc8_).styleName = this;
               }
               _loc4_.addChild(DisplayObject(_loc8_));
            }
         }
         if(headerVisible)
         {
            _loc4_.visible = true;
            if(useOldDGHeaderBGLogic)
            {
               this.drawHeaderBackground(_loc4_);
            }
            else if(_loc4_.numChildren > 0)
            {
               this.drawHeaderBackgroundSkin(IFlexDisplayObject(_loc4_.getChildAt(0)));
            }
         }
         else
         {
            _loc4_.visible = false;
         }
         this.drawRowBackgrounds();
         if(headerVisible)
         {
            this.drawSeparators();
         }
         else
         {
            this.clearSeparators();
         }
         this.drawLinesAndColumnBackgrounds();
      }
      
      override protected function adjustListContent(param1:Number = -1, param2:Number = -1) : void
      {
         super.adjustListContent(param1,param2);
         this.updateSubContent();
      }
      
      override protected function moveSelectionHorizontally(param1:uint, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:Number = NaN;
         var _loc6_:int = 0;
         var _loc7_:ScrollEvent = null;
         var _loc5_:Boolean = false;
         if(param2 && param1 == Keyboard.PAGE_UP)
         {
            _loc4_ = Math.max(horizontalScrollPosition - (visibleColumns.length - lockedColumnCount),0);
            if(_loc4_ != horizontalScrollPosition)
            {
               _loc5_ = true;
            }
         }
         else if(param2 && param1 == Keyboard.PAGE_DOWN)
         {
            _loc6_ = Math.min(maxHorizontalScrollPosition,this.columns.length - 1);
            _loc4_ = Math.min(horizontalScrollPosition + (visibleColumns.length - lockedColumnCount),_loc6_);
            if(_loc4_ != horizontalScrollPosition)
            {
               _loc5_ = true;
            }
         }
         else
         {
            super.moveSelectionHorizontally(param1,param2,param3);
         }
         if(_loc5_)
         {
            _loc7_ = new ScrollEvent(ScrollEvent.SCROLL);
            _loc7_.detail = ScrollEventDetail.THUMB_POSITION;
            _loc7_.direction = ScrollEventDirection.HORIZONTAL;
            _loc7_.delta = _loc4_ - horizontalScrollPosition;
            _loc7_.position = _loc4_;
            this.horizontalScrollPosition = _loc4_;
            dispatchEvent(_loc7_);
            if(this.headerIndex != -1)
            {
               this.unselectColumnHeader(this.headerIndex);
            }
         }
      }
      
      override protected function makeRowsAndColumns(param1:Number, param2:Number, param3:Number, param4:Number, param5:int, param6:int, param7:Boolean = false, param8:uint = 0) : Point
      {
         var _loc12_:AdvancedDataGridColumn = null;
         var _loc13_:IListItemRenderer = null;
         var _loc14_:ListRowInfo = null;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         listContent.allowItemSizeChangeNotification = false;
         listSubContent.allowItemSizeChangeNotification = false;
         if(headerVisible && itemsSizeChanged)
         {
            this.calculateHeaderHeight();
         }
         var _loc9_:Point = super.makeRowsAndColumns(param1,param2,param3,param4,param5,param6,param7,param8);
         var _loc10_:Array = getOptimumColumns();
         if(this.itemEditorInstance)
         {
            this.itemEditorInstance.parent.setChildIndex(DisplayObject(this.itemEditorInstance),this.itemEditorInstance.parent.numChildren - 1);
            _loc12_ = _loc10_[this.actualColIndex];
            _loc13_ = listItems[this.actualRowIndex][this.actualColIndex];
            _loc14_ = rowInfo[this.actualRowIndex];
            if(_loc13_ && !_loc12_.rendererIsEditor)
            {
               _loc15_ = _loc12_.editorXOffset;
               _loc16_ = _loc12_.editorYOffset;
               _loc17_ = _loc12_.editorWidthOffset;
               _loc18_ = _loc12_.editorHeightOffset;
               this.itemEditorInstance.move(_loc13_.x + _loc15_,_loc14_.y + _loc16_);
               this.itemEditorInstance.setActualSize(Math.min(_loc12_.width + _loc17_,listContent.width - listContent.x - this.itemEditorInstance.x),Math.min(_loc14_.height + _loc18_,listContent.height - listContent.y - this.itemEditorInstance.y));
            }
         }
         var _loc11_:Sprite = Sprite(listSubContent.getChildByName("lines"));
         if(_loc11_)
         {
            listSubContent.setChildIndex(_loc11_,listSubContent.numChildren - 1);
         }
         listContent.allowItemSizeChangeNotification = variableRowHeight;
         listSubContent.allowItemSizeChangeNotification = variableRowHeight;
         return _loc9_;
      }
      
      override protected function commitProperties() : void
      {
         if(columnsInvalid)
         {
            if(this.columnsChanged && !this.headerInfoInitialized)
            {
               this.headerInfoInitialized = true;
               headerInfos = this.initializeHeaderInfo(this.columns);
               this.headerInfoInitialized = false;
               this.columnsChanged = false;
            }
            this.columnsChanged = false;
            visibleHeaderInfos = this.updateVisibleHeaders();
            this.updateHeaderSearchList();
            this.createDisplayableColumns();
         }
         super.commitProperties();
         this.measureItems();
      }
      
      override public function measureWidthOfItems(param1:int = -1, param2:int = 0) : Number
      {
         var _loc3_:Number = 0;
         var _loc4_:int = !!this.columns?int(this.columns.length):0;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if(this.columns[_loc5_].visible)
            {
               _loc3_ = _loc3_ + this.columns[_loc5_].width;
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      override public function measureHeightOfItems(param1:int = -1, param2:int = 0) : Number
      {
         return this.measureHeightOfItemsUptoMaxHeight(param1,param2);
      }
      
      override protected function calculateRowHeight(param1:Object, param2:Number, param3:Boolean = false) : Number
      {
         var _loc4_:IListItemRenderer = null;
         var _loc5_:AdvancedDataGridColumn = null;
         var _loc7_:int = 0;
         var _loc6_:int = this.columns.length;
         var _loc8_:int = 0;
         if(param3 && visibleColumns.length == _columns.length)
         {
            return param2;
         }
         var _loc9_:Number = getStyle("paddingTop");
         var _loc10_:Number = getStyle("paddingBottom");
         if(!this.measuringObjects)
         {
            this.measuringObjects = new Dictionary(false);
         }
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            if(param3 && _loc8_ < visibleColumns.length && visibleColumns[_loc8_].colNum == this.columns[_loc7_].colNum)
            {
               _loc8_++;
            }
            else
            {
               _loc5_ = this.columns[_loc7_];
               if(_loc5_.visible)
               {
                  _loc4_ = this.getMeasuringRenderer(_loc5_,false,param1);
                  this.setupRendererFromData(_loc5_,_loc4_,param1);
                  param2 = Math.max(param2,_loc4_.getExplicitOrMeasuredHeight() + _loc10_ + _loc9_);
               }
            }
            _loc7_++;
         }
         return param2;
      }
      
      override protected function scrollHandler(param1:Event) : void
      {
         var _loc2_:ScrollBar = null;
         var _loc3_:Number = NaN;
         if(param1.target == verticalScrollBar || param1.target == horizontalScrollBar)
         {
            if(param1 is ScrollEvent)
            {
               if(!liveScrolling && ScrollEvent(param1).detail == ScrollEventDetail.THUMB_TRACK)
               {
                  return;
               }
               if(this.itemEditorInstance)
               {
                  this.endEdit(AdvancedDataGridEventReason.OTHER);
               }
               _loc2_ = ScrollBar(param1.target);
               _loc3_ = _loc2_.scrollPosition;
               if(_loc2_ == verticalScrollBar)
               {
                  this.verticalScrollPosition = _loc3_;
               }
               else if(_loc2_ == horizontalScrollBar)
               {
                  this.horizontalScrollPosition = _loc3_;
               }
               super.scrollHandler(param1);
            }
         }
      }
      
      override protected function configureScrollBars() : void
      {
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc1_:Object = horizontalScrollBar;
         var _loc2_:Object = verticalScrollBar;
         var _loc3_:int = listItems.length;
         if(_loc3_ + headerItems.length == 0)
         {
            if(_loc1_ || _loc2_)
            {
               setScrollBarProperties(0,0,0,0);
            }
            return;
         }
         if(_loc3_ > 1 && rowInfo[_loc3_ - 1].y + rowInfo[_loc3_ - 1].height > listContent.height)
         {
            _loc3_--;
         }
         var _loc6_:int = verticalScrollPosition - lockedRowCount;
         var _loc7_:int = 0;
         while(_loc3_ && listItems[_loc3_ - 1].length == 0)
         {
            if(collection && _loc3_ + _loc6_ >= collection.length)
            {
               _loc3_--;
               _loc7_++;
               continue;
            }
            break;
         }
         if(verticalScrollPosition > 0 && _loc7_ > 0)
         {
            if(this.adjustVerticalScrollPositionDownward(Math.max(_loc3_,1)))
            {
               return;
            }
         }
         _loc4_ = [!!collection?collection.length - lockedRowCount:0,Math.max(_loc3_ - lockedRowCount,1)];
         var _loc8_:int = visibleColumns.length;
         var _loc9_:AdvancedDataGridHeaderInfo = this.getHeaderInfo(visibleColumns[visibleColumns.length - 1]);
         var _loc10_:int = _loc9_.headerItem.x;
         if(visibleColumns.length - 1 > lockedColumnCount)
         {
            _loc10_ = this.getAdjustedXPos(_loc10_);
         }
         if(_loc8_ > 1 && visibleColumns[_loc8_ - 1] == this.displayableColumns[this.displayableColumns.length - 1] && _loc10_ + visibleColumns[_loc8_ - 1].width > this.displayWidth)
         {
            _loc8_--;
         }
         _loc5_ = [this.displayableColumns.length - lockedColumnCount,Math.max(_loc8_ - lockedColumnCount,1)];
         setScrollBarProperties(_loc5_[0],_loc5_[1],_loc4_[0],_loc4_[1]);
         if((!verticalScrollBar || !verticalScrollBar.visible) && collection && collection.length - lockedRowCount > _loc3_ - lockedRowCount)
         {
            maxVerticalScrollPosition = collection.length - lockedRowCount - (_loc3_ - lockedRowCount);
         }
         if((!horizontalScrollBar || !horizontalScrollBar.visible) && this.displayableColumns.length - lockedColumnCount > _loc8_ - lockedColumnCount)
         {
            maxHorizontalScrollPosition = this.displayableColumns.length - lockedColumnCount - (_loc8_ - lockedColumnCount);
         }
      }
      
      override protected function scrollVertically(param1:int, param2:int, param3:Boolean) : void
      {
         iterator.seek(CursorBookmark.CURRENT,lockedRowCount);
         super.scrollVertically(param1,param2,param3);
         iterator.seek(CursorBookmark.CURRENT,-lockedRowCount);
      }
      
      override public function calculateDropIndex(param1:DragEvent = null) : int
      {
         var _loc2_:IListItemRenderer = null;
         var _loc3_:Point = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1)
         {
            _loc3_ = new Point(param1.localX,param1.localY);
            _loc3_ = DisplayObject(param1.target).localToGlobal(_loc3_);
            _loc3_ = listContent.globalToLocal(_loc3_);
            _loc4_ = listItems.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               if(rowInfo[_loc5_].y <= _loc3_.y && _loc3_.y <= rowInfo[_loc5_].y + rowInfo[_loc5_].height)
               {
                  _loc2_ = listItems[_loc5_][0];
                  break;
               }
               _loc5_++;
            }
            if(_loc2_)
            {
               lastDropIndex = itemRendererToIndex(_loc2_);
            }
            else
            {
               lastDropIndex = !!collection?int(collection.length):0;
            }
         }
         return lastDropIndex;
      }
      
      override protected function calculateDropIndicatorY(param1:Number, param2:int) : Number
      {
         var _loc3_:int = 0;
         var _loc4_:Number = !!headerVisible?Number(headerHeight):Number(0);
         if(param1 && listItems[param2].length && listItems[param2][0])
         {
            return listItems[param2][0].y - 1;
         }
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            if(listItems[_loc3_].length)
            {
               _loc4_ = _loc4_ + rowInfo[_loc3_].height;
               _loc3_++;
               continue;
            }
            break;
         }
         return _loc4_;
      }
      
      override protected function drawRowBackgrounds() : void
      {
         var _loc2_:Array = null;
         var _loc1_:Sprite = Sprite(listContent.getChildByName("rowBGs"));
         if(!_loc1_)
         {
            _loc1_ = new FlexSprite();
            _loc1_.mouseEnabled = false;
            _loc1_.name = "rowBGs";
            listContent.addChildAt(_loc1_,0);
         }
         _loc2_ = getStyle("alternatingItemColors");
         if(!_loc2_ || _loc2_.length == 0)
         {
            return;
         }
         styleManager.getColorNames(_loc2_);
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = verticalScrollPosition;
         var _loc6_:int = 0;
         var _loc7_:int = listItems.length;
         while(_loc3_ < lockedRowCount && _loc3_ < _loc7_)
         {
            this.drawRowBackground(_loc1_,_loc4_++,rowInfo[_loc3_].y,rowInfo[_loc3_].height,_loc2_[_loc6_ % _loc2_.length],_loc6_);
            _loc3_++;
            _loc6_++;
            _loc5_++;
         }
         while(_loc3_ < _loc7_)
         {
            this.drawRowBackground(_loc1_,_loc4_++,rowInfo[_loc3_].y,rowInfo[_loc3_].height,_loc2_[_loc5_ % _loc2_.length],_loc5_);
            _loc3_++;
            _loc5_++;
         }
         while(_loc1_.numChildren > _loc4_)
         {
            _loc1_.removeChildAt(_loc1_.numChildren - 1);
         }
      }
      
      override protected function mouseEventToItemRenderer(param1:MouseEvent) : IListItemRenderer
      {
         var _loc2_:IListItemRenderer = null;
         var _loc3_:Point = null;
         var _loc4_:Number = NaN;
         if(param1.target == highlightIndicator || param1.target == listContent)
         {
            _loc3_ = new Point(param1.stageX,param1.stageY);
            _loc3_ = listContent.globalToLocal(_loc3_);
            _loc4_ = 0;
            if(headerVisible)
            {
               _loc2_ = this.findHeaderRenderer(_loc3_);
            }
            if(!_loc2_ && rowInfo.length != 0)
            {
               _loc2_ = this.findRenderer(_loc3_,listItems,rowInfo,rowInfo[0].y);
            }
         }
         if(!_loc2_)
         {
            _loc2_ = super.mouseEventToItemRenderer(param1);
         }
         return _loc2_ == this.itemEditorInstance?null:_loc2_;
      }
      
      override public function styleChanged(param1:String) : void
      {
         super.styleChanged(param1);
         var _loc2_:Boolean = false;
         if(param1 == "headerBackgroundSkin")
         {
            _loc2_ = true;
            this.headerBGSkinChanged = true;
         }
         else if(param1 == "headerSortSeparatorSkin")
         {
            _loc2_ = true;
         }
         else if(param1 == "headerSeparatorSkin")
         {
            this.headerSepSkinChanged = true;
            _loc2_ = true;
         }
         if(_loc2_)
         {
            itemsSizeChanged = true;
         }
      }
      
      override protected function selectItem(param1:IListItemRenderer, param2:Boolean, param3:Boolean, param4:Boolean = true) : Boolean
      {
         var _loc5_:Boolean = super.selectItem(param1,param2,param3,param4);
         if(param1.data is AdvancedDataGridColumn)
         {
            _selectedItem = null;
         }
         return _loc5_;
      }
      
      override mx_internal function addSelectionData(param1:String, param2:ListBaseSelectionData) : void
      {
         if(param2.data is AdvancedDataGridColumn)
         {
            return;
         }
         super.addSelectionData(param1,param2);
      }
      
      override public function itemToLabel(param1:Object) : String
      {
         return this.displayableColumns[this.sortIndex == -1?0:this.sortIndex].itemToLabel(param1);
      }
      
      private function updateSubContent() : void
      {
         if(!visibleColumns || getOptimumColumns() == visibleColumns)
         {
            listSubContent.scrollRect = null;
            listSubContent.x = 0;
            return;
         }
         var _loc1_:Number = 0;
         var _loc2_:int = 0;
         while(_loc2_ < lockedColumnCount)
         {
            _loc1_ = _loc1_ + this.displayableColumns[_loc2_].width;
            _loc2_++;
         }
         var _loc3_:Number = 0;
         if(visibleColumns.length > lockedColumnCount)
         {
            _loc2_ = lockedColumnCount;
            while(_loc2_ < lockedColumnCount + horizontalScrollPosition)
            {
               _loc3_ = _loc3_ + this.displayableColumns[_loc2_].width;
               _loc2_++;
            }
         }
         if(horizontalScrollPosition == 0)
         {
            listSubContent.scrollRect = null;
            listSubContent.x = 0;
         }
         else
         {
            if(lockedColumnCount > 0)
            {
               listSubContent.x = _loc1_;
            }
            else
            {
               listSubContent.x = 0;
            }
            if(_loc1_ > 0)
            {
               listSubContent.scrollRect = new Rectangle(_loc1_ + _loc3_,0,listContent.width - _loc1_,listContent.height);
            }
            else
            {
               listSubContent.scrollRect = new Rectangle(_loc3_,0,listContent.width,listContent.height);
            }
         }
      }
      
      protected function updateVisibleHeaders() : Array
      {
         var _loc3_:int = 0;
         var _loc1_:Array = [];
         var _loc2_:int = !!headerInfos?int(headerInfos.length):0;
         var _loc4_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            headerInfos[_loc3_].visible = headerInfos[_loc3_].column.visible;
            if(headerInfos[_loc3_].visible)
            {
               _loc1_.push(headerInfos[_loc3_]);
               headerInfos[_loc3_].actualColNum = _loc4_++;
               headerInfos[_loc3_].columnSpan = 1;
            }
            else
            {
               headerInfos[_loc3_].actualColNum = NaN;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      protected function updateHeaderSearchList() : void
      {
         var _loc1_:int = !!visibleHeaderInfos?int(visibleHeaderInfos.length):0;
         this.orderedHeadersList = [];
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this.orderedHeadersList.push(visibleHeaderInfos[_loc2_]);
            _loc2_++;
         }
      }
      
      protected function initializeHeaderInfo(param1:Array) : Array
      {
         var _loc5_:AdvancedDataGridHeaderInfo = null;
         var _loc2_:Array = [];
         var _loc3_:int = this.columns.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = new AdvancedDataGridHeaderInfo(this.columns[_loc4_],null,_loc4_,0);
            _loc2_.push(_loc5_);
            _loc4_++;
         }
         return _loc2_;
      }
      
      mx_internal function getMeasuringRenderer(param1:AdvancedDataGridColumn, param2:Boolean, param3:Object) : IListItemRenderer
      {
         var _loc4_:IFactory = columnItemRendererFactory(param1,param2,param3);
         var _loc5_:IListItemRenderer = this.measuringObjects[_loc4_];
         if(!_loc5_)
         {
            _loc5_ = columnItemRenderer(param1,param2,param3);
            _loc5_.visible = false;
            _loc5_.styleName = param1;
            listContent.addChild(DisplayObject(_loc5_));
            this.measuringObjects[_loc4_] = _loc5_;
         }
         return _loc5_;
      }
      
      mx_internal function setupRendererFromData(param1:AdvancedDataGridColumn, param2:IListItemRenderer, param3:Object) : void
      {
         var _loc4_:AdvancedDataGridListData = AdvancedDataGridListData(makeListData(param3,itemToUID(param3),0,param1.colNum,param1));
         if(param2 is IDropInListItemRenderer)
         {
            if(param3 != null)
            {
               IDropInListItemRenderer(param2).listData = makeListData(param3,itemToUID(param3),0,param1.colNum,param1);
            }
            else
            {
               IDropInListItemRenderer(param2).listData = null;
            }
         }
         param2.data = param3;
         if(param2 is IInvalidating)
         {
            IInvalidating(param2).invalidateSize();
         }
         param2.explicitWidth = getWidthOfItem(param2,param1,currentColNum);
         UIComponentGlobals.layoutManager.validateClient(param2,true);
      }
      
      mx_internal function measureHeightOfItemsUptoMaxHeight(param1:int = -1, param2:int = 0, param3:Number = -1) : Number
      {
         var item:IListItemRenderer = null;
         var c:AdvancedDataGridColumn = null;
         var n:int = 0;
         var j:int = 0;
         var data:Object = null;
         var index:int = param1;
         var count:int = param2;
         var maxHeight:Number = param3;
         if(!this.columns.length)
         {
            return rowHeight * count;
         }
         var h:Number = 0;
         var ch:Number = 0;
         var paddingTop:Number = getStyle("paddingTop");
         var paddingBottom:Number = getStyle("paddingBottom");
         if(!this.measuringObjects)
         {
            this.measuringObjects = new Dictionary(false);
         }
         var lockedCount:int = lockedRowCount;
         if(headerVisible && count > 0 && index == -1)
         {
            h = this.calculateHeaderHeight();
            if(maxHeight != -1 && h > maxHeight)
            {
               setRowCount(0);
               return 0;
            }
         }
         var bookmark:CursorBookmark = !!iterator?iterator.bookmark:null;
         var bMore:Boolean = iterator != null;
         if(index != -1 && iterator)
         {
            try
            {
               iterator.seek(CursorBookmark.FIRST,index);
            }
            catch(e:ItemPendingError)
            {
               bMore = false;
            }
         }
         if(lockedCount > 0 && collectionIterator)
         {
            try
            {
               collectionIterator.seek(CursorBookmark.FIRST,0);
            }
            catch(e:ItemPendingError)
            {
               bMore = false;
            }
         }
         var i:int = 0;
         while(i < count)
         {
            if(bMore)
            {
               data = lockedCount > 0?collectionIterator.current:iterator.current;
               ch = 0;
               n = this.columns.length;
               j = 0;
               while(j < n)
               {
                  c = this.columns[j];
                  if(c.visible)
                  {
                     item = this.getMeasuringRenderer(c,false,data);
                     this.setupRendererFromData(c,item,data);
                     ch = Math.max(ch,!!variableRowHeight?Number(item.getExplicitOrMeasuredHeight() + paddingBottom + paddingTop):Number(rowHeight));
                  }
                  j++;
               }
            }
            if(maxHeight != -1 && (h + ch > maxHeight || !bMore))
            {
               try
               {
                  if(iterator)
                  {
                     iterator.seek(bookmark,0);
                  }
               }
               catch(e:ItemPendingError)
               {
               }
               count = i;
               setRowCount(count);
               return h;
            }
            h = h + ch;
            if(iterator)
            {
               try
               {
                  bMore = iterator.moveNext();
                  if(lockedCount > 0)
                  {
                     collectionIterator.moveNext();
                     lockedCount--;
                  }
               }
               catch(e:ItemPendingError)
               {
                  bMore = false;
               }
            }
            i++;
         }
         if(iterator)
         {
            try
            {
               iterator.seek(bookmark,0);
            }
            catch(e:ItemPendingError)
            {
            }
         }
         return h;
      }
      
      protected function calculateHeaderHeight() : Number
      {
         var _loc1_:IListItemRenderer = null;
         var _loc2_:AdvancedDataGridColumn = null;
         var _loc3_:AdvancedDataGridListData = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(!this.columns.length)
         {
            return rowHeight;
         }
         var _loc4_:Number = 0;
         var _loc7_:Number = getStyle("paddingTop");
         var _loc8_:Number = getStyle("paddingBottom");
         if(!this.measuringObjects)
         {
            this.measuringObjects = new Dictionary(false);
         }
         if(headerVisible)
         {
            _loc4_ = 0;
            _loc5_ = this.columns.length;
            if(this._headerWordWrapPresent)
            {
               _headerHeight = this._originalHeaderHeight;
               _explicitHeaderHeight = this._originalExplicitHeaderHeight;
            }
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc2_ = this.columns[_loc6_];
               if(_loc2_.visible)
               {
                  _loc1_ = this.getMeasuringRenderer(_loc2_,true,null);
                  _loc3_ = AdvancedDataGridListData(makeListData(_loc2_,uid,0,_loc2_.colNum,_loc2_));
                  rowMap[_loc1_.name] = _loc3_;
                  if(_loc1_ is IDropInListItemRenderer)
                  {
                     IDropInListItemRenderer(_loc1_).listData = _loc3_;
                  }
                  _loc1_.data = _loc2_;
                  _loc1_.explicitWidth = _loc2_.width;
                  UIComponentGlobals.layoutManager.validateClient(_loc1_,true);
                  _loc4_ = Math.max(_loc4_,!!_explicitHeaderHeight?Number(headerHeight):Number(_loc1_.getExplicitOrMeasuredHeight() + _loc8_ + _loc7_));
                  if(columnHeaderWordWrap(_loc2_))
                  {
                     this._headerWordWrapPresent = true;
                  }
               }
               _loc6_++;
            }
            if(this._headerWordWrapPresent)
            {
               this._originalHeaderHeight = _headerHeight;
               this._originalExplicitHeaderHeight = _explicitHeaderHeight;
               headerHeight = _loc4_;
            }
         }
         return _loc4_;
      }
      
      protected function getAdjustedXPos(param1:int) : int
      {
         if(listSubContent.scrollRect)
         {
            if(listSubContent.x == 0)
            {
               param1 = param1 - listSubContent.scrollRect.x;
            }
            else
            {
               param1 = param1 - (listSubContent.scrollRect.x - listSubContent.x);
            }
         }
         return param1;
      }
      
      mx_internal function getHeaderInfo(param1:AdvancedDataGridColumn) : AdvancedDataGridHeaderInfo
      {
         return headerInfos[param1.colNum];
      }
      
      mx_internal function getHeaderInfoAt(param1:int) : AdvancedDataGridHeaderInfo
      {
         if(headerInfos)
         {
            return headerInfos[param1];
         }
         return null;
      }
      
      protected function getNumColumns() : int
      {
         if(headerItems && headerItems[0])
         {
            return headerItems[0].length;
         }
         return -1;
      }
      
      private function adjustVerticalScrollPositionDownward(param1:int) : Boolean
      {
         var item:IListItemRenderer = null;
         var c:AdvancedDataGridColumn = null;
         var n:int = 0;
         var j:int = 0;
         var bMore:Boolean = false;
         var data:Object = null;
         var rowCount:int = param1;
         var bookmark:CursorBookmark = iterator.bookmark;
         var h:Number = 0;
         var ch:Number = 0;
         var paddingTop:Number = getStyle("paddingTop");
         var paddingBottom:Number = getStyle("paddingBottom");
         h = rowInfo[rowCount - 1].y + rowInfo[rowCount - 1].height;
         h = listContent.height - h;
         var numRows:int = 0;
         try
         {
            if(iterator.afterLast)
            {
               iterator.seek(CursorBookmark.LAST,0);
            }
            else
            {
               bMore = iterator.movePrevious();
            }
         }
         catch(e:ItemPendingError)
         {
            bMore = false;
         }
         if(!bMore)
         {
            super.verticalScrollPosition = 0;
            try
            {
               iterator.seek(CursorBookmark.FIRST,0);
               if(!iteratorValid)
               {
                  iteratorValid = true;
                  lastSeekPending = null;
               }
            }
            catch(e:ItemPendingError)
            {
               lastSeekPending = new ListBaseSeekPending(CursorBookmark.FIRST,0);
               e.addResponder(new ItemResponder(seekPendingResultHandler,seekPendingFailureHandler,lastSeekPending));
               iteratorValid = false;
               invalidateList();
               return true;
            }
            updateList();
            return true;
         }
         while(h > 0 && bMore)
         {
            if(bMore)
            {
               data = iterator.current;
               ch = 0;
               n = this.columns.length;
               j = 0;
               while(j < n)
               {
                  c = this.columns[j];
                  if(c.visible)
                  {
                     if(variableRowHeight)
                     {
                        item = this.getMeasuringRenderer(c,false,data);
                        this.setupRendererFromData(c,item,data);
                     }
                     ch = Math.max(ch,!!variableRowHeight?Number(item.getExplicitOrMeasuredHeight() + paddingBottom + paddingTop):Number(rowHeight));
                  }
                  j++;
               }
            }
            h = h - ch;
            try
            {
               bMore = iterator.movePrevious();
               numRows++;
            }
            catch(e:ItemPendingError)
            {
               bMore = false;
               continue;
            }
         }
         if(h < 0)
         {
            numRows--;
         }
         iterator.seek(bookmark,0);
         this.verticalScrollPosition = Math.max(0,verticalScrollPosition - numRows);
         if(numRows > 0 && !variableRowHeight)
         {
            this.configureScrollBars();
         }
         return numRows > 0;
      }
      
      mx_internal function shiftColumns(param1:int, param2:int, param3:Event = null) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:IndexChangedEvent = null;
         var _loc8_:int = 0;
         var _loc9_:AdvancedDataGridColumn = null;
         var _loc10_:AdvancedDataGridHeaderInfo = null;
         var _loc4_:Array = headerInfos;
         if(param2 >= 0 && param1 != param2)
         {
            _loc5_ = param1 < param2?1:-1;
            _loc6_ = param1;
            while(_loc6_ != param2)
            {
               _loc8_ = _loc6_ + _loc5_;
               _loc9_ = _columns[_loc6_];
               _columns[_loc6_] = _columns[_loc8_];
               _columns[_loc8_] = _loc9_;
               _columns[_loc6_].colNum = _loc6_;
               _columns[_loc8_].colNum = _loc8_;
               _loc10_ = _loc4_[_loc6_];
               _loc4_[_loc6_] = _loc4_[_loc8_];
               _loc4_[_loc8_] = _loc10_;
               _loc4_[_loc6_].index = _loc4_[_loc6_].index - _loc5_;
               _loc4_[_loc8_].index = _loc4_[_loc8_].index + _loc5_;
               _loc6_ = _loc6_ + _loc5_;
            }
            if(this.sortIndex == param1)
            {
               this.sortIndex = this.sortIndex + (param2 - param1);
            }
            else if(param1 < this.sortIndex && this.sortIndex <= param2 || param2 <= this.sortIndex && this.sortIndex < param1)
            {
               this.sortIndex = this.sortIndex - _loc5_;
            }
            if(this.lastSortIndex == param1)
            {
               this.lastSortIndex = this.lastSortIndex + (param2 - param1);
            }
            else if(param1 < this.lastSortIndex && this.lastSortIndex <= param2 || param2 <= this.lastSortIndex && this.lastSortIndex < param1)
            {
               this.lastSortIndex = this.lastSortIndex - _loc5_;
            }
            columnsInvalid = true;
            itemsSizeChanged = true;
            visibleHeaderInfos = this.updateVisibleHeaders();
            this.updateHeaderSearchList();
            this.createDisplayableColumns();
            invalidateDisplayList();
            _loc7_ = new IndexChangedEvent(IndexChangedEvent.HEADER_SHIFT);
            _loc7_.oldIndex = param1;
            _loc7_.newIndex = param2;
            _loc7_.triggerEvent = param3;
            dispatchEvent(_loc7_);
         }
      }
      
      private function generateCols() : void
      {
         var col:AdvancedDataGridColumn = null;
         var newCols:Array = null;
         var cols:Array = null;
         var info:Object = null;
         var itmObj:Object = null;
         var p:String = null;
         var n:int = 0;
         var colName:Object = null;
         var i:int = 0;
         if(collection.length > 0)
         {
            newCols = [];
            if(dataProvider)
            {
               try
               {
                  iterator.seek(CursorBookmark.FIRST);
               }
               catch(e:ItemPendingError)
               {
                  lastSeekPending = new ListBaseSeekPending(CursorBookmark.FIRST,0);
                  e.addResponder(new ItemResponder(generateColumnsPendingResultHandler,seekPendingFailureHandler,lastSeekPending));
                  iteratorValid = false;
                  return;
               }
               info = ObjectUtil.getClassInfo(iterator.current,["uid","mx_internal_uid"]);
               if(info)
               {
                  cols = info.properties;
               }
            }
            if(!cols)
            {
               itmObj = iterator.current;
               for(p in itmObj)
               {
                  if(p != "uid")
                  {
                     col = new AdvancedDataGridColumn();
                     col.dataField = p;
                     newCols.push(col);
                  }
               }
            }
            else
            {
               n = cols.length;
               i = 0;
               while(i < n)
               {
                  colName = cols[i];
                  if(colName is QName)
                  {
                     colName = QName(colName).localName;
                  }
                  col = new AdvancedDataGridColumn();
                  col.dataField = String(colName);
                  newCols.push(col);
                  i++;
               }
            }
            this.columns = newCols;
            this.generatedColumns = true;
         }
      }
      
      private function generateColumnsPendingResultHandler(param1:Object, param2:ListBaseSeekPending) : void
      {
         if(this.columns.length == 0)
         {
            this.generateCols();
         }
         seekPendingResultHandler(param1,param2);
      }
      
      protected function createDisplayableColumns() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this.displayableColumns = null;
         _loc2_ = _columns.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.displayableColumns && _columns[_loc1_].visible)
            {
               this.displayableColumns.push(_columns[_loc1_]);
            }
            else if(!this.displayableColumns && !_columns[_loc1_].visible)
            {
               this.displayableColumns = new Array(_loc1_);
               _loc3_ = 0;
               while(_loc3_ < _loc1_)
               {
                  this.displayableColumns[_loc3_] = _columns[_loc3_];
                  _loc3_++;
               }
            }
            _loc1_++;
         }
         if(!this.displayableColumns)
         {
            this.displayableColumns = _columns;
         }
      }
      
      private function calculateColumnSizes() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:AdvancedDataGridColumn = null;
         var _loc6_:Number = NaN;
         var _loc7_:AdvancedDataGridColumn = null;
         var _loc8_:Number = NaN;
         var _loc9_:int = 0;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc4_:Number = 0;
         if(this.columns.length == 0)
         {
            visibleColumns = [];
            return;
         }
         if(columnsInvalid)
         {
            columnsInvalid = false;
            visibleColumns = [];
            if(this.minColumnWidthInvalid)
            {
               _loc2_ = this.columns.length;
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  this.columns[_loc3_].minWidth = this.minColumnWidth;
                  _loc3_++;
               }
               this.minColumnWidthInvalid = false;
            }
            if(horizontalScrollPolicy == ScrollPolicy.OFF)
            {
               _loc2_ = this.displayableColumns.length;
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  visibleColumns.push(this.displayableColumns[_loc3_]);
                  _loc3_++;
               }
            }
            else
            {
               _loc2_ = this.displayableColumns.length;
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  if(!(_loc3_ >= lockedColumnCount && _loc3_ < lockedColumnCount + horizontalScrollPosition))
                  {
                     _loc5_ = this.displayableColumns[_loc3_];
                     if(_loc5_.preferredWidth < _loc5_.minWidth)
                     {
                        _loc5_.preferredWidth = _loc5_.minWidth;
                     }
                     if(_loc4_ < this.displayWidth)
                     {
                        visibleColumns.push(_loc5_);
                        _loc4_ = _loc4_ + (!!isNaN(_loc5_.explicitWidth)?_loc5_.preferredWidth:_loc5_.explicitWidth);
                        if(_loc5_.width != _loc5_.preferredWidth)
                        {
                           _loc5_.setWidth(_loc5_.preferredWidth);
                        }
                     }
                     else
                     {
                        if(visibleColumns.length == 0)
                        {
                           visibleColumns.push(this.displayableColumns[0]);
                        }
                        break;
                     }
                  }
                  _loc3_++;
               }
            }
         }
         if(horizontalScrollPolicy == ScrollPolicy.OFF)
         {
            _loc9_ = 0;
            _loc10_ = 0;
            _loc2_ = visibleColumns.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if(visibleColumns[_loc3_].resizable)
               {
                  if(!isNaN(visibleColumns[_loc3_].explicitWidth))
                  {
                     _loc10_ = _loc10_ + visibleColumns[_loc3_].width;
                  }
                  else
                  {
                     _loc9_++;
                     _loc10_ = _loc10_ + visibleColumns[_loc3_].minWidth;
                  }
               }
               else
               {
                  _loc10_ = _loc10_ + visibleColumns[_loc3_].width;
               }
               _loc4_ = _loc4_ + visibleColumns[_loc3_].width;
               _loc3_++;
            }
            _loc12_ = this.displayWidth;
            if(this.displayWidth > _loc10_ && _loc9_)
            {
               _loc2_ = visibleColumns.length;
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  if(visibleColumns[_loc3_].resizable && isNaN(visibleColumns[_loc3_].explicitWidth))
                  {
                     _loc7_ = visibleColumns[_loc3_];
                     if(_loc4_ > this.displayWidth)
                     {
                        _loc11_ = (_loc7_.width - _loc7_.minWidth) / (_loc4_ - _loc10_);
                     }
                     else
                     {
                        _loc11_ = _loc7_.width / _loc4_;
                     }
                     _loc8_ = _loc7_.width - (_loc4_ - this.displayWidth) * _loc11_;
                     _loc13_ = visibleColumns[_loc3_].minWidth;
                     visibleColumns[_loc3_].setWidth(_loc8_ > _loc13_?_loc8_:_loc13_);
                  }
                  _loc12_ = _loc12_ - visibleColumns[_loc3_].width;
                  _loc3_++;
               }
               if(_loc12_ && _loc7_)
               {
                  _loc7_.setWidth(_loc7_.width + _loc12_);
               }
            }
            else
            {
               _loc2_ = visibleColumns.length;
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  _loc7_ = visibleColumns[_loc3_];
                  _loc11_ = _loc7_.width / _loc4_;
                  _loc8_ = this.displayWidth * _loc11_;
                  _loc7_.setWidth(_loc8_);
                  _loc7_.explicitWidth = NaN;
                  _loc12_ = _loc12_ - _loc8_;
                  _loc3_++;
               }
               if(_loc12_ && _loc7_)
               {
                  _loc7_.setWidth(_loc7_.width + _loc12_);
               }
            }
         }
         else
         {
            _loc4_ = 0;
            _loc2_ = visibleColumns.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if(_loc4_ > this.displayWidth)
               {
                  visibleColumns.splice(_loc3_);
                  break;
               }
               _loc4_ = _loc4_ + (!!isNaN(visibleColumns[_loc3_].explicitWidth)?visibleColumns[_loc3_].preferredWidth:visibleColumns[_loc3_].explicitWidth);
               _loc3_++;
            }
            if(visibleColumns.length == 0)
            {
               return;
            }
            _loc3_ = visibleColumns[visibleColumns.length - 1].colNum + 1;
            if(_loc4_ < this.displayWidth && _loc3_ < this.displayableColumns.length)
            {
               _loc2_ = this.displayableColumns.length;
               while(_loc3_ < _loc2_ && _loc4_ < this.displayWidth)
               {
                  _loc5_ = this.displayableColumns[_loc3_];
                  visibleColumns.push(_loc5_);
                  _loc4_ = _loc4_ + (!!isNaN(_loc5_.explicitWidth)?_loc5_.preferredWidth:_loc5_.explicitWidth);
                  _loc3_++;
               }
            }
            else if(_loc4_ < this.displayWidth && horizontalScrollPosition > 0)
            {
               while(_loc4_ < this.displayWidth && horizontalScrollPosition > 0)
               {
                  _loc5_ = this.displayableColumns[lockedColumnCount + horizontalScrollPosition - 1];
                  _loc6_ = !!isNaN(_loc5_.explicitWidth)?Number(_loc5_.preferredWidth):Number(_loc5_.explicitWidth);
                  if(_loc6_ < this.displayWidth - _loc4_)
                  {
                     visibleColumns.splice(lockedColumnCount,0,_loc5_);
                     _loc14_.super.horizontalScrollPosition = super.horizontalScrollPosition - 1;
                     _loc4_ = _loc4_ + _loc6_;
                     continue;
                  }
                  break;
               }
            }
            _loc7_ = visibleColumns[visibleColumns.length - 1];
            _loc6_ = !!isNaN(_loc7_.explicitWidth)?Number(_loc7_.preferredWidth):Number(_loc7_.explicitWidth);
            _loc8_ = _loc6_ + this.displayWidth - _loc4_;
            if(_loc7_ == this.displayableColumns[this.displayableColumns.length - 1] && _loc7_.resizable && _loc8_ >= _loc7_.minWidth && _loc8_ > _loc6_)
            {
               _loc7_.setWidth(_loc8_);
               maxHorizontalScrollPosition = this.displayableColumns.length - visibleColumns.length;
            }
            else if(visibleColumns.length == this.displayableColumns.length)
            {
               maxHorizontalScrollPosition = 0;
               super.horizontalScrollPosition = 0;
            }
            else if(lockedColumnCount < visibleColumns.length)
            {
               maxHorizontalScrollPosition = this.displayableColumns.length - visibleColumns.length + 1;
            }
            else
            {
               maxHorizontalScrollPosition = Math.max(0,this.displayableColumns.length - lockedColumnCount + 1);
               super.horizontalScrollPosition = Math.min(horizontalScrollPosition,maxHorizontalScrollPosition);
            }
         }
      }
      
      mx_internal function resizeColumn(param1:int, param2:Number) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:AdvancedDataGridColumn = null;
         var _loc7_:Number = NaN;
         var _loc8_:Array = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         if(!visibleColumns || visibleColumns.length == 0)
         {
            this.columns[param1].setWidth(param2);
            this.columns[param1].preferredWidth = param2;
            return;
         }
         if(param2 < this.columns[param1].minWidth)
         {
            param2 = this.columns[param1].minWidth;
         }
         if(_horizontalScrollPolicy == ScrollPolicy.ON || _horizontalScrollPolicy == ScrollPolicy.AUTO)
         {
            this.columns[param1].setWidth(param2);
            this.columns[param1].explicitWidth = param2;
            this.columns[param1].preferredWidth = param2;
            columnsInvalid = true;
         }
         else
         {
            _loc3_ = visibleColumns.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if(param1 == visibleColumns[_loc4_].colNum)
               {
                  break;
               }
               _loc4_++;
            }
            if(_loc4_ >= visibleColumns.length)
            {
               return;
            }
            param1 = _loc4_;
            _loc5_ = 0;
            _loc8_ = getOptimumColumns();
            _loc4_ = param1 + 1;
            while(_loc4_ < _loc3_)
            {
               if(_loc8_[_loc4_].resizable)
               {
                  _loc5_ = _loc5_ + visibleColumns[_loc4_].width;
               }
               _loc4_++;
            }
            _loc9_ = _loc8_[param1].width - param2 + _loc5_;
            if(_loc5_)
            {
               _loc8_[param1].setWidth(param2);
               _loc8_[param1].explicitWidth = param2;
            }
            _loc10_ = 0;
            _loc4_ = param1 + 1;
            while(_loc4_ < _loc3_)
            {
               if(_loc8_[_loc4_].resizable)
               {
                  _loc7_ = Math.floor(visibleColumns[_loc4_].width * _loc9_ / _loc5_);
                  if(_loc7_ < visibleColumns[_loc4_].minWidth)
                  {
                     _loc7_ = visibleColumns[_loc4_].minWidth;
                  }
                  _loc8_[_loc4_].setWidth(_loc7_);
                  _loc10_ = _loc10_ + _loc8_[_loc4_].width;
                  _loc6_ = _loc8_[_loc4_];
               }
               _loc4_++;
            }
            if(_loc10_ > _loc9_)
            {
               _loc7_ = _loc8_[param1].width - _loc10_ + _loc9_;
               if(_loc7_ < _loc8_[param1].minWidth)
               {
                  _loc7_ = _loc8_[param1].minWidth;
               }
               _loc8_[param1].setWidth(_loc7_);
            }
            else if(_loc6_)
            {
               _loc6_.setWidth(_loc6_.width - _loc10_ + _loc9_);
            }
         }
         itemsSizeChanged = true;
         this.updateSubContent();
         invalidateDisplayList();
      }
      
      protected function drawHeaderBackground(param1:UIComponent) : void
      {
         var _loc9_:EdgeMetrics = null;
         var _loc10_:Number = NaN;
         var _loc2_:Number = this.displayWidth;
         if(verticalScrollBar != null && _horizontalScrollPolicy == ScrollPolicy.OFF && headerVisible)
         {
            _loc9_ = borderMetrics;
            _loc10_ = unscaledWidth - (_loc9_.left + _loc9_.right);
            _loc2_ = _loc10_;
            maskShape.width = _loc10_;
         }
         var _loc3_:Number = !!headerRowInfo.length?Number(headerRowInfo[0].height):Number(headerHeight);
         var _loc4_:Graphics = param1.graphics;
         _loc4_.clear();
         var _loc5_:Array = getStyle("headerColors");
         styleManager.getColorNames(_loc5_);
         var _loc6_:Matrix = new Matrix();
         _loc6_.createGradientBox(_loc2_,_loc3_ + 1,Math.PI / 2,0,0);
         _loc5_ = [_loc5_[0],_loc5_[0],_loc5_[1]];
         var _loc7_:Array = [0,60,255];
         var _loc8_:Array = [1,1,1];
         _loc4_.beginGradientFill(GradientType.LINEAR,_loc5_,_loc8_,_loc7_,_loc6_);
         _loc4_.lineStyle(0,0,0);
         _loc4_.moveTo(0,0);
         _loc4_.lineTo(_loc2_,0);
         _loc4_.lineTo(_loc2_,_loc3_ - 0.5);
         _loc4_.lineStyle(0,getStyle("borderColor"),100);
         _loc4_.lineTo(0,_loc3_ - 0.5);
         _loc4_.lineStyle(0,0,0);
         _loc4_.endFill();
      }
      
      private function drawHeaderBackgroundSkin(param1:IFlexDisplayObject) : void
      {
         var _loc4_:EdgeMetrics = null;
         var _loc5_:Number = NaN;
         var _loc2_:Number = this.displayWidth;
         if(verticalScrollBar != null && _horizontalScrollPolicy == ScrollPolicy.OFF && headerVisible)
         {
            _loc4_ = borderMetrics;
            _loc5_ = unscaledWidth - (_loc4_.left + _loc4_.right);
            _loc2_ = _loc5_;
            maskShape.width = _loc5_;
         }
         var _loc3_:Number = !!headerRowInfo.length?Number(headerRowInfo[0].height):Number(headerHeight);
         param1.setActualSize(_loc2_,_loc3_);
      }
      
      protected function drawRowBackground(param1:Sprite, param2:int, param3:Number, param4:Number, param5:uint, param6:int) : void
      {
         var _loc7_:Shape = null;
         if(param2 < param1.numChildren)
         {
            _loc7_ = Shape(param1.getChildAt(param2));
         }
         else
         {
            _loc7_ = new FlexShape();
            _loc7_.name = "background";
            param1.addChild(_loc7_);
         }
         _loc7_.y = param3;
         param4 = Math.min(param4,listContent.height - param3);
         var _loc8_:Graphics = _loc7_.graphics;
         _loc8_.clear();
         _loc8_.beginFill(param5,getStyle("backgroundAlpha"));
         _loc8_.drawRect(0,0,this.displayWidth,param4);
         _loc8_.endFill();
      }
      
      protected function drawColumnBackground(param1:Sprite, param2:int, param3:uint, param4:AdvancedDataGridColumn) : void
      {
         var _loc5_:Shape = null;
         _loc5_ = Shape(param1.getChildByName(param2.toString()));
         if(!_loc5_)
         {
            _loc5_ = new FlexShape();
            param1.addChild(_loc5_);
            _loc5_.name = param2.toString();
         }
         var _loc6_:Graphics = _loc5_.graphics;
         _loc6_.clear();
         if(param2 >= lockedColumnCount && param2 < lockedColumnCount + horizontalScrollPosition)
         {
            return;
         }
         _loc6_.beginFill(param3);
         var _loc7_:Object = rowInfo[listItems.length - 1];
         var _loc8_:AdvancedDataGridHeaderInfo = this.getHeaderInfo(getOptimumColumns()[param2]);
         var _loc9_:Number = _loc8_.headerItem.x;
         if(param2 >= lockedColumnCount)
         {
            _loc9_ = this.getAdjustedXPos(_loc9_);
         }
         var _loc10_:Number = headerRowInfo[0].y;
         if(headerVisible)
         {
            _loc10_ = _loc10_ + headerRowInfo[0].height;
         }
         var _loc11_:Number = Math.min(_loc7_.y + _loc7_.height,listContent.height - _loc10_);
         _loc6_.drawRect(_loc9_,_loc10_,_loc8_.headerItem.width,listContent.height - _loc10_);
         _loc6_.endFill();
      }
      
      private function drawHorizontalSeparator(param1:Sprite, param2:int, param3:uint, param4:Number) : void
      {
         var _loc10_:IFlexDisplayObject = null;
         var _loc11_:IFlexDisplayObject = null;
         var _loc12_:IFlexDisplayObject = null;
         var _loc13_:IFlexDisplayObject = null;
         var _loc14_:Class = null;
         var _loc15_:ISimpleStyleClient = null;
         var _loc16_:Number = NaN;
         var _loc5_:Boolean = false;
         if(lockedRowCount > 0 && param2 == lockedRowCount - 1)
         {
            _loc5_ = true;
         }
         var _loc6_:String = "hSeparator" + param2;
         var _loc7_:String = "hLockedSeparator" + param2;
         var _loc8_:String = !!_loc5_?_loc7_:_loc6_;
         var _loc9_:String = !!_loc5_?"horizontalLockedSeparatorSkin":"horizontalSeparatorSkin";
         _loc10_ = IFlexDisplayObject(param1.getChildByName(_loc6_));
         _loc11_ = IFlexDisplayObject(param1.getChildByName(_loc7_));
         _loc13_ = !!_loc5_?_loc11_:_loc10_;
         _loc12_ = !!_loc5_?_loc10_:_loc11_;
         if(_loc12_)
         {
            param1.removeChild(DisplayObject(_loc12_));
         }
         if(!_loc13_)
         {
            _loc14_ = Class(getStyle(_loc9_));
            if(_loc14_)
            {
               _loc13_ = IFlexDisplayObject(new _loc14_());
               _loc13_.name = _loc8_;
               _loc15_ = _loc13_ as ISimpleStyleClient;
               if(_loc15_)
               {
                  _loc15_.styleName = this;
               }
               param1.addChild(DisplayObject(_loc13_));
            }
         }
         if(_loc13_)
         {
            _loc16_ = !isNaN(_loc13_.measuredHeight)?Number(_loc13_.measuredHeight):Number(1);
            _loc13_.setActualSize(this.displayWidth,_loc16_);
            _loc13_.move(0,param4);
         }
         else
         {
            this.drawHorizontalLine(param1,param2,param3,param4);
         }
      }
      
      protected function drawHorizontalLine(param1:Sprite, param2:int, param3:uint, param4:Number) : void
      {
         var _loc5_:Graphics = param1.graphics;
         if(lockedRowCount > 0 && param2 == lockedRowCount - 1)
         {
            _loc5_.lineStyle(1,0);
         }
         else
         {
            _loc5_.lineStyle(1,param3);
         }
         _loc5_.moveTo(0,param4);
         _loc5_.lineTo(this.displayWidth,param4);
      }
      
      private function drawVerticalSeparator(param1:Sprite, param2:int, param3:uint, param4:Number, param5:Number) : void
      {
         var _loc11_:IFlexDisplayObject = null;
         var _loc12_:IFlexDisplayObject = null;
         var _loc13_:IFlexDisplayObject = null;
         var _loc14_:IFlexDisplayObject = null;
         var _loc15_:Class = null;
         var _loc16_:ISimpleStyleClient = null;
         var _loc17_:Number = NaN;
         var _loc6_:Boolean = false;
         if(lockedColumnCount > 0 && param2 == lockedColumnCount - 1)
         {
            _loc6_ = true;
         }
         var _loc7_:String = "vSeparator" + param2;
         var _loc8_:String = "vLockedSeparator" + param2;
         var _loc9_:String = !!_loc6_?_loc8_:_loc7_;
         var _loc10_:String = !!_loc6_?"verticalLockedSeparatorSkin":"verticalSeparatorSkin";
         _loc11_ = IFlexDisplayObject(param1.getChildByName(_loc7_));
         _loc12_ = IFlexDisplayObject(param1.getChildByName(_loc8_));
         _loc14_ = !!_loc6_?_loc12_:_loc11_;
         _loc13_ = !!_loc6_?_loc11_:_loc12_;
         if(_loc13_)
         {
            param1.removeChild(DisplayObject(_loc13_));
         }
         if(!_loc14_)
         {
            _loc15_ = Class(getStyle(_loc10_));
            if(_loc15_)
            {
               _loc14_ = IFlexDisplayObject(new _loc15_());
               _loc14_.name = _loc9_;
               _loc16_ = _loc14_ as ISimpleStyleClient;
               if(_loc16_)
               {
                  _loc16_.styleName = this;
               }
               param1.addChild(DisplayObject(_loc14_));
            }
         }
         if(_loc14_)
         {
            _loc17_ = !isNaN(_loc14_.measuredWidth)?Number(_loc14_.measuredWidth):Number(1);
            _loc14_.setActualSize(_loc17_,listContent.height);
            _loc14_.move(param4,param5);
         }
         else
         {
            this.drawVerticalLine(param1,param2,param3,param4);
         }
      }
      
      protected function drawVerticalLine(param1:Sprite, param2:int, param3:uint, param4:Number) : void
      {
         var _loc5_:Graphics = param1.graphics;
         if(lockedColumnCount > 0 && param2 == lockedColumnCount - 1)
         {
            _loc5_.lineStyle(1,0,100);
         }
         else
         {
            _loc5_.lineStyle(1,param3,100);
         }
         var _loc6_:Number = 0;
         if(headerVisible)
         {
            if(lockedColumnCount > 0 && param2 == lockedColumnCount - 1)
            {
               _loc5_.moveTo(param4,1);
               _loc5_.lineTo(param4,headerItems[0][param2].height);
            }
            else
            {
               _loc6_ = headerItems[0][param2].height;
            }
         }
         _loc5_.moveTo(param4,_loc6_);
         _loc5_.lineTo(param4,listContent.height);
      }
      
      protected function drawLinesAndColumnBackgrounds() : void
      {
         var _loc4_:Sprite = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:AdvancedDataGridColumn = null;
         var _loc8_:Object = null;
         var _loc9_:Shape = null;
         var _loc10_:Graphics = null;
         var _loc11_:DisplayObject = null;
         var _loc1_:Sprite = this.getLines();
         _loc1_.graphics.clear();
         var _loc2_:uint = this.getNumColumns();
         _loc2_ = _loc2_ != -1?uint(_loc2_):uint(visibleColumns.length);
         var _loc3_:Array = getOptimumColumns();
         if(_loc2_ > _loc3_.length)
         {
            _loc2_ = _loc3_.length;
         }
         this.drawHorizontalSeparators();
         this.drawVerticalSeparators();
         if(headerInfos && this.hasHeaderItemsCreated(0) && this.hasHeaderItemsCreated(_loc2_ - 1))
         {
            _loc4_ = Sprite(listContent.getChildByName("colBGs"));
            _loc5_ = -1;
            _loc6_ = 0;
            while(_loc6_ < _loc2_)
            {
               _loc7_ = _loc3_[_loc6_];
               if(enabled)
               {
                  _loc8_ = _loc7_.getStyle("backgroundColor");
               }
               else
               {
                  _loc8_ = _loc7_.getStyle("backgroundDisabledColor");
               }
               if(_loc8_ !== null && !isNaN(Number(_loc8_)))
               {
                  if(!_loc4_)
                  {
                     _loc4_ = new FlexSprite();
                     _loc4_.mouseEnabled = false;
                     _loc4_.name = "colBGs";
                     listContent.addChildAt(_loc4_,listContent.getChildIndex(listContent.getChildByName("rowBGs")) + 1);
                  }
                  this.drawColumnBackground(_loc4_,_loc6_,Number(_loc8_),_loc7_);
                  _loc5_ = _loc6_;
               }
               else if(_loc4_)
               {
                  _loc9_ = Shape(_loc4_.getChildByName(_loc6_.toString()));
                  if(_loc9_)
                  {
                     _loc10_ = _loc9_.graphics;
                     _loc10_.clear();
                     _loc4_.removeChild(_loc9_);
                  }
               }
               _loc6_++;
            }
            if(_loc4_ && _loc4_.numChildren)
            {
               while(_loc4_.numChildren)
               {
                  _loc11_ = _loc4_.getChildAt(_loc4_.numChildren - 1);
                  if(parseInt(_loc11_.name) > _loc5_)
                  {
                     _loc4_.removeChild(_loc11_);
                     continue;
                  }
                  break;
               }
            }
         }
      }
      
      protected function drawHorizontalSeparators() : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:uint = getStyle("horizontalGridLineColor");
         var _loc2_:Sprite = this.getLockedContent();
         var _loc3_:Sprite = Sprite(_loc2_.getChildByName("lockedHorizontalLines"));
         if(_loc3_)
         {
            _loc3_.graphics.clear();
            while(_loc3_.numChildren)
            {
               _loc3_.removeChildAt(0);
            }
         }
         if(getStyle("horizontalGridLines") || lockedRowCount > 0 && lockedRowCount < listItems.length)
         {
            if(!_loc3_)
            {
               _loc3_ = new UIComponent();
               _loc3_.name = "lockedHorizontalLines";
               _loc2_.addChild(_loc3_);
            }
            if(getStyle("horizontalGridLines"))
            {
               _loc4_ = listItems.length;
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  this.drawHorizontalSeparator(_loc3_,_loc5_,_loc1_,rowInfo[_loc5_].y + rowInfo[_loc5_].height);
                  _loc5_++;
               }
            }
            else
            {
               this.drawHorizontalSeparator(_loc3_,lockedRowCount - 1,_loc1_,rowInfo[lockedRowCount - 1].y + rowInfo[lockedRowCount - 1].height);
            }
         }
      }
      
      protected function drawVerticalSeparators() : void
      {
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:AdvancedDataGridHeaderInfo = null;
         var _loc1_:Sprite = this.getLines();
         var _loc2_:Sprite = this.getLockedContent();
         var _loc3_:Sprite = Sprite(_loc2_.getChildByName("lockedVerticalLines"));
         if(!_loc3_)
         {
            _loc3_ = new UIComponent();
            _loc3_.name = "lockedVerticalLines";
            _loc2_.addChild(_loc3_);
         }
         var _loc4_:UIComponent = UIComponent(_loc2_.getChildByName("lockedHeaderLines"));
         if(_loc4_)
         {
            _loc10_ = _loc2_.getChildIndex(DisplayObject(_loc4_));
            if(_loc10_ > _loc2_.getChildIndex(DisplayObject(_loc3_)))
            {
               _loc2_.setChildIndex(_loc3_,_loc10_);
            }
         }
         _loc3_.graphics.clear();
         while(_loc3_.numChildren)
         {
            _loc3_.removeChildAt(0);
         }
         var _loc5_:Number = headerVisible && headerRowInfo && headerRowInfo[0]?Number(headerRowInfo[0].height):Number(0);
         var _loc6_:uint = Math.min(!!visibleColumns?Number(visibleColumns.length):Number(0),Math.max(0,lockedColumnCount));
         var _loc7_:Boolean = getStyle("verticalGridLines");
         var _loc8_:uint = getStyle("verticalGridLineColor");
         if(_loc7_ && _loc6_)
         {
            _loc11_ = 0;
            while(_loc11_ < _loc6_)
            {
               this.drawVerticalSeparator(_loc3_,_loc11_,_loc8_,this.getHeaderInfo(visibleColumns[_loc11_]).headerItem.x + visibleColumns[_loc11_].width,_loc5_);
               _loc11_++;
            }
         }
         var _loc9_:Sprite = this.getLinesBody(_loc1_,"verticalLines");
         _loc9_.graphics.clear();
         while(_loc9_.numChildren)
         {
            _loc9_.removeChildAt(0);
         }
         _loc6_ = visibleColumns.length;
         if(_loc6_ > visibleColumns.length)
         {
            _loc6_ = visibleColumns.length;
         }
         _loc7_ = getStyle("verticalGridLines");
         _loc8_ = getStyle("verticalGridLineColor");
         if(_loc7_ && headerInfos && this.hasHeaderItemsCreated(0) && this.hasHeaderItemsCreated(_loc6_ - 1))
         {
            _loc12_ = Math.max(0,lockedColumnCount);
            _loc11_ = _loc12_;
            while(_loc11_ < _loc6_ - 1)
            {
               _loc13_ = this.getHeaderInfo(visibleColumns[_loc11_]);
               this.drawVerticalSeparator(_loc9_,this.absoluteToVisibleColumnIndex(visibleColumns[_loc11_].colNum),_loc8_,_loc13_.headerItem.x + visibleColumns[_loc11_].width,_loc5_);
               _loc11_++;
            }
         }
         if(!_loc7_ && lockedColumnCount > 0 && lockedColumnCount < _loc6_)
         {
            this.drawVerticalSeparator(_loc9_,lockedColumnCount - 1,_loc8_,this.getHeaderInfo(visibleColumns[lockedColumnCount - 1]).headerItem.x + visibleColumns[lockedColumnCount - 1].width,0);
         }
      }
      
      private function getLockedContent() : Sprite
      {
         var _loc1_:Sprite = Sprite(listContent.getChildByName("lockedContent"));
         if(!_loc1_)
         {
            _loc1_ = new UIComponent();
            _loc1_.name = "lockedContent";
            _loc1_.cacheAsBitmap = true;
            _loc1_.mouseEnabled = false;
            listContent.addChild(_loc1_);
         }
         listContent.setChildIndex(_loc1_,listContent.numChildren - 1);
         return _loc1_;
      }
      
      private function getLines() : Sprite
      {
         var _loc1_:Sprite = Sprite(listSubContent.getChildByName("lines"));
         if(!_loc1_)
         {
            _loc1_ = new UIComponent();
            _loc1_.name = "lines";
            _loc1_.cacheAsBitmap = true;
            _loc1_.mouseEnabled = false;
            listSubContent.addChild(_loc1_);
         }
         listSubContent.setChildIndex(_loc1_,listSubContent.numChildren - 1);
         return _loc1_;
      }
      
      private function getLinesBody(param1:Sprite, param2:String) : Sprite
      {
         var _loc3_:Sprite = Sprite(param1.getChildByName(param2));
         if(!_loc3_)
         {
            _loc3_ = new UIComponent();
            _loc3_.name = param2;
            param1.addChild(_loc3_);
         }
         return _loc3_;
      }
      
      protected function clearSeparators() : void
      {
         if(!this.separators)
         {
            return;
         }
         var _loc1_:Sprite = Sprite(listSubContent.getChildByName("lines"));
         var _loc2_:Sprite = Sprite(_loc1_.getChildByName("header"));
         if(_loc2_)
         {
            while(_loc2_.numChildren)
            {
               _loc2_.removeChildAt(_loc2_.numChildren - 1);
               this.separators.pop();
            }
         }
         var _loc3_:Sprite = this.getLockedContent();
         _loc2_ = Sprite(_loc3_.getChildByName("lockedHeaderLines"));
         if(_loc2_)
         {
            while(_loc2_.numChildren)
            {
               _loc2_.removeChildAt(_loc2_.numChildren - 1);
               this.lockedSeparators.pop();
            }
         }
      }
      
      protected function drawSeparators() : void
      {
         var _loc1_:Sprite = this.getLines();
         _loc1_.graphics.clear();
         var _loc2_:Array = getOptimumColumns();
         if(this.headerSepSkinChanged)
         {
            this.headerSepSkinChanged = false;
            this.clearSeparators();
         }
         if(!this.separators)
         {
            this.separators = [];
            this.lockedSeparators = [];
         }
         _loc1_ = Sprite(listSubContent.getChildByName("lines"));
         var _loc3_:int = 0;
         var _loc4_:* = false;
         var _loc5_:int = Math.max(0,_loc2_.length - 1);
         var _loc6_:Sprite = this.getLockedContent();
         var _loc7_:UIComponent = UIComponent(_loc6_.getChildByName("lockedHeaderLines"));
         var _loc8_:UIComponent = UIComponent(_loc1_.getChildByName("header"));
         if(_loc2_ && _loc2_.length > 0)
         {
            if(lockedColumnCount > 0)
            {
               _loc3_ = Math.min(lockedColumnCount,_loc2_.length);
               _loc4_ = _loc3_ == _loc2_.length;
               if(_loc4_)
               {
                  _loc3_--;
               }
               _loc5_ = _loc5_ - _loc3_;
               if(!_loc4_)
               {
                  _loc5_++;
               }
               if(!_loc7_)
               {
                  _loc7_ = new UIComponent();
                  _loc7_.name = "lockedHeaderLines";
                  _loc6_.addChild(_loc7_);
               }
            }
            if(_loc7_)
            {
               this.createHeaderSeparators(_loc3_,this.lockedSeparators,_loc7_);
            }
            if(!_loc8_)
            {
               _loc8_ = new UIComponent();
               _loc8_.name = "header";
               _loc1_.addChild(_loc8_);
            }
            this.createHeaderSeparators(_loc5_,this.separators,_loc8_);
         }
         if(_loc7_)
         {
            this.removeExtraSeparators(_loc3_,this.lockedSeparators,_loc7_);
         }
         if(_loc8_)
         {
            this.removeExtraSeparators(_loc5_,this.separators,_loc8_);
         }
      }
      
      protected function getSeparator(param1:int, param2:Array, param3:UIComponent) : UIComponent
      {
         var _loc4_:UIComponent = null;
         var _loc5_:IFlexDisplayObject = null;
         var _loc6_:Class = null;
         if(param1 < param3.numChildren)
         {
            _loc4_ = UIComponent(param3.getChildAt(param1));
            _loc5_ = IFlexDisplayObject(_loc4_.getChildAt(0));
         }
         else
         {
            _loc6_ = getStyle("headerSeparatorSkin");
            _loc5_ = new _loc6_();
            if(_loc5_ is ISimpleStyleClient)
            {
               ISimpleStyleClient(_loc5_).styleName = this;
            }
            _loc4_ = new UIComponent();
            _loc4_.addChild(DisplayObject(_loc5_));
            param3.addChild(_loc4_);
            DisplayObject(_loc4_).addEventListener(MouseEvent.MOUSE_OVER,this.columnResizeMouseOverHandler);
            DisplayObject(_loc4_).addEventListener(MouseEvent.MOUSE_OUT,this.columnResizeMouseOutHandler);
            DisplayObject(_loc4_).addEventListener(MouseEvent.MOUSE_DOWN,this.columnResizeMouseDownHandler);
            param2.push(_loc4_);
         }
         return _loc4_;
      }
      
      protected function createHeaderSeparators(param1:int, param2:Array, param3:UIComponent) : void
      {
         var _loc6_:int = 0;
         var _loc7_:UIComponent = null;
         var _loc8_:IFlexDisplayObject = null;
         var _loc4_:Array = getOptimumColumns();
         var _loc5_:int = 0;
         while(_loc5_ < param1)
         {
            _loc6_ = lockedColumnCount > 0 && param2 != this.lockedSeparators?int(_loc5_ + lockedColumnCount - 1):int(_loc5_);
            _loc7_ = this.getSeparator(_loc5_,param2,param3);
            _loc8_ = IFlexDisplayObject(_loc7_.getChildAt(0));
            if(!headerItems || !headerItems[0] || !headerItems[0][_loc6_])
            {
               _loc7_.visible = false;
            }
            else
            {
               _loc7_.visible = true;
               _loc7_.x = headerItems[0][_loc6_].x + _loc4_[_loc6_].width - Math.round(_loc7_.measuredWidth / 2 + 0.5);
               if(_loc5_ > 0)
               {
                  _loc7_.x = Math.max(_loc7_.x,param2[_loc5_ - 1].x + Math.round(_loc7_.measuredWidth / 2 + 0.5));
               }
               _loc7_.y = 0;
               _loc8_.setActualSize(_loc8_.measuredWidth,!!headerRowInfo.length?Number(headerRowInfo[0].height):Number(headerHeight));
               _loc7_.graphics.clear();
               _loc7_.graphics.beginFill(16777215,0);
               _loc7_.graphics.drawRect(-this.separatorAffordance,0,_loc8_.measuredWidth + this.separatorAffordance,headerHeight);
               _loc7_.graphics.endFill();
            }
            _loc5_++;
         }
      }
      
      private function removeExtraSeparators(param1:int, param2:Array, param3:UIComponent) : void
      {
         while(param3.numChildren > param1)
         {
            param3.removeChildAt(param3.numChildren - 1);
            param2.pop();
         }
      }
      
      private function updateSortIndexAndDirection() : void
      {
         if(!this.sortableColumns)
         {
            this.lastSortIndex = this.sortIndex;
            this.sortIndex = -1;
            if(this.lastSortIndex != this.sortIndex)
            {
               invalidateDisplayList();
            }
            return;
         }
         if(!dataProvider)
         {
            return;
         }
         var _loc1_:ICollectionView = ICollectionView(dataProvider);
         var _loc2_:Sort = _loc1_.sort;
         if(!_loc2_)
         {
            this.sortIndex = this.lastSortIndex = -1;
            return;
         }
         var _loc3_:Array = _loc2_.fields;
         if(!_loc3_)
         {
            return;
         }
         if(_loc3_.length != 1)
         {
            this.lastSortIndex = this.sortIndex;
            this.sortIndex = -1;
            if(this.lastSortIndex != this.sortIndex)
            {
               invalidateDisplayList();
            }
            return;
         }
         var _loc4_:SortField = _loc3_[0];
         var _loc5_:int = _columns.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            if(_columns[_loc6_].dataField == _loc4_.name)
            {
               this.sortIndex = !!_columns[_loc6_].sortable?int(_loc6_):-1;
               this.sortDirection = !!_loc4_.descending?"DESC":"ASC";
               return;
            }
            _loc6_++;
         }
      }
      
      private function setEditedItemPosition(param1:Object) : void
      {
         this.bEditedItemPositionChanged = true;
         this._proposedEditedItemPosition = param1;
         invalidateDisplayList();
      }
      
      private function commitEditedItemPosition(param1:Object) : void
      {
         var _loc13_:IListItemRenderer = null;
         var _loc15_:String = null;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:ListEvent = null;
         if(!enabled || !this.editable.length)
         {
            return;
         }
         if(this.itemEditorInstance && param1 && this.itemEditorInstance is IFocusManagerComponent && this._editedItemPosition.rowIndex == param1.rowIndex && this._editedItemPosition.columnIndex == param1.columnIndex)
         {
            IFocusManagerComponent(this.itemEditorInstance).setFocus();
            return;
         }
         if(this.itemEditorInstance)
         {
            if(!param1)
            {
               _loc15_ = AdvancedDataGridEventReason.OTHER;
            }
            else
            {
               _loc15_ = !this.editedItemPosition || param1.rowIndex == this.editedItemPosition.rowIndex?AdvancedDataGridEventReason.NEW_COLUMN:AdvancedDataGridEventReason.NEW_ROW;
            }
            if(!this.endEdit(_loc15_) && _loc15_ != AdvancedDataGridEventReason.OTHER)
            {
               return;
            }
         }
         this._editedItemPosition = param1;
         if(!param1)
         {
            return;
         }
         if(this.dontEdit)
         {
            return;
         }
         var _loc2_:int = param1.rowIndex;
         var _loc3_:int = param1.columnIndex;
         if(this.displayableColumns.length != _columns.length)
         {
            _loc16_ = this.displayableColumns.length;
            _loc17_ = 0;
            while(_loc17_ < _loc16_)
            {
               if(this.displayableColumns[_loc17_].colNum >= _loc3_)
               {
                  _loc3_ = _loc17_;
                  break;
               }
               _loc17_++;
            }
            if(_loc17_ == this.displayableColumns.length)
            {
               _loc3_ = 0;
            }
         }
         var _loc4_:Boolean = false;
         if(selectedIndex != param1.rowIndex)
         {
            commitSelectedIndex(param1.rowIndex);
            _loc4_ = true;
         }
         var _loc5_:int = lockedRowCount;
         var _loc6_:int = verticalScrollPosition + listItems.length - 1;
         var _loc7_:int = rowInfo[listItems.length - 1].y + rowInfo[listItems.length - 1].height > listContent.height?1:0;
         if(_loc2_ > _loc5_)
         {
            if(_loc2_ < verticalScrollPosition + _loc5_)
            {
               this.verticalScrollPosition = _loc2_ - _loc5_;
            }
            else
            {
               while(_loc2_ > _loc6_ || _loc2_ == _loc6_ && _loc2_ > verticalScrollPosition + _loc5_ && _loc7_)
               {
                  if(verticalScrollPosition == maxVerticalScrollPosition)
                  {
                     break;
                  }
                  this.verticalScrollPosition = Math.min(verticalScrollPosition + (_loc2_ > _loc6_?_loc2_ - _loc6_:_loc7_),maxVerticalScrollPosition);
                  _loc6_ = verticalScrollPosition + listItems.length - 1;
                  _loc7_ = rowInfo[listItems.length - 1].y + rowInfo[listItems.length - 1].height > listContent.height?1:0;
               }
            }
            this.actualRowIndex = _loc2_ - verticalScrollPosition;
         }
         else
         {
            if(_loc2_ == _loc5_)
            {
               this.verticalScrollPosition = 0;
            }
            this.actualRowIndex = _loc2_;
         }
         var _loc8_:EdgeMetrics = borderMetrics;
         var _loc9_:uint = visibleColumns.length;
         var _loc10_:int = horizontalScrollPosition + _loc9_ - 1;
         var _loc11_:AdvancedDataGridHeaderInfo = this.getHeaderInfo(visibleColumns[visibleColumns.length - 1]);
         var _loc12_:int = _loc11_.headerItem.x + _loc11_.column.width > listContent.width?1:0;
         if(_loc3_ > lockedColumnCount)
         {
            if(_loc3_ < horizontalScrollPosition + lockedColumnCount)
            {
               this.horizontalScrollPosition = _loc3_ - lockedColumnCount;
            }
            else
            {
               while(_loc3_ > _loc10_ || _loc3_ == _loc10_ && _loc3_ > horizontalScrollPosition + lockedColumnCount && _loc12_)
               {
                  if(horizontalScrollPosition == maxHorizontalScrollPosition)
                  {
                     break;
                  }
                  this.horizontalScrollPosition = Math.min(horizontalScrollPosition + (_loc3_ > _loc10_?_loc3_ - _loc10_:_loc12_),maxHorizontalScrollPosition);
                  _loc10_ = horizontalScrollPosition + visibleColumns.length - 1;
                  _loc11_ = this.getHeaderInfo(visibleColumns[visibleColumns.length - 1]);
                  _loc12_ = _loc11_.headerItem.x + _loc11_.headerItem.width > listContent.width?1:0;
               }
            }
            this.actualColIndex = this.absoluteToVisibleColumnIndex(this.displayToAbsoluteColumnIndex(_loc3_));
         }
         else
         {
            if(_loc3_ == lockedColumnCount)
            {
               this.horizontalScrollPosition = 0;
            }
            this.actualColIndex = _loc3_;
         }
         if(listItems[this.actualRowIndex] && listItems[this.actualRowIndex][this.actualColIndex])
         {
            _loc13_ = listItems[this.actualRowIndex][this.actualColIndex];
         }
         if(!_loc13_)
         {
            this.commitEditedItemPosition(null);
            return;
         }
         if(_loc4_)
         {
            _loc18_ = new ListEvent(ListEvent.CHANGE);
            _loc18_.columnIndex = param1.columnIndex;
            _loc18_.rowIndex = param1.rowIndex;
            _loc18_.itemRenderer = _loc13_;
            dispatchEvent(_loc18_);
         }
         var _loc14_:AdvancedDataGridEvent = new AdvancedDataGridEvent(AdvancedDataGridEvent.ITEM_EDIT_BEGIN,false,true);
         _loc14_.columnIndex = this.displayableColumns[_loc3_].colNum;
         _loc14_.rowIndex = this._editedItemPosition.rowIndex;
         _loc14_.itemRenderer = _loc13_;
         dispatchEvent(_loc14_);
         this.lastEditedItemPosition = this._editedItemPosition;
         if(this.bEditedItemPositionChanged)
         {
            this.bEditedItemPositionChanged = false;
            this.commitEditedItemPosition(this._proposedEditedItemPosition);
            this._proposedEditedItemPosition = undefined;
         }
         if(!this.itemEditorInstance)
         {
            this.commitEditedItemPosition(null);
         }
      }
      
      public function createItemEditor(param1:int, param2:int) : void
      {
         var _loc4_:IListItemRenderer = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:IFactory = null;
         var _loc14_:Class = null;
         var _loc15_:String = null;
         var _loc16_:String = null;
         var _loc17_:String = null;
         var _loc18_:* = false;
         var _loc19_:* = false;
         var _loc20_:IFlexModuleFactory = null;
         if(this.displayableColumns.length != _columns.length)
         {
            _loc6_ = this.displayableColumns.length;
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               if(this.displayableColumns[_loc7_].colNum >= param1)
               {
                  param1 = _loc7_;
                  break;
               }
               _loc7_++;
            }
            if(_loc7_ == this.displayableColumns.length)
            {
               param1 = 0;
            }
         }
         var _loc3_:AdvancedDataGridColumn = this.displayableColumns[param1];
         if(param2 > lockedRowCount)
         {
            param2 = param2 - verticalScrollPosition;
         }
         if(param1 > lockedColumnCount)
         {
            param1 = param1 - horizontalScrollPosition;
         }
         _loc4_ = listItems[this.actualRowIndex][this.actualColIndex];
         var _loc5_:ListRowInfo = rowInfo[this.actualRowIndex];
         if(_loc4_ is IDropInListItemRenderer)
         {
            IDropInListItemRenderer(_loc4_).listData.label = _loc3_.itemToLabel(_loc4_.data,false);
         }
         if(!_loc3_.rendererIsEditor)
         {
            _loc8_ = 0;
            _loc9_ = -2;
            _loc10_ = 0;
            _loc11_ = 4;
            if(!this.itemEditorInstance)
            {
               _loc13_ = _loc3_.itemEditor;
               if(_loc13_ == AdvancedDataGridColumn.defaultItemEditorFactory)
               {
                  _loc14_ = getStyle("defaultDataGridItemEditor");
                  if(_loc14_)
                  {
                     _loc15_ = StringUtil.trimArrayElements(_loc3_.getStyle("fontFamily"),",");
                     _loc16_ = _loc3_.getStyle("fontWeight");
                     _loc17_ = _loc3_.getStyle("fontStyle");
                     _loc18_ = _loc16_ == "bold";
                     _loc19_ = _loc17_ == "italic";
                     _loc20_ = getFontContext(_loc15_,_loc18_,_loc19_);
                     _loc13_ = _loc3_.itemEditor = new ContextualClassFactory(_loc14_,_loc20_);
                  }
               }
               _loc8_ = _loc3_.editorXOffset;
               _loc9_ = _loc3_.editorYOffset;
               _loc10_ = _loc3_.editorWidthOffset;
               _loc11_ = _loc3_.editorHeightOffset;
               this.itemEditorInstance = _loc13_.newInstance();
               this.itemEditorInstance.owner = this;
               this.itemEditorInstance.styleName = _loc3_;
               addRendererToContentArea(this.itemEditorInstance,_loc3_);
            }
            this.itemEditorInstance.parent.setChildIndex(DisplayObject(this.itemEditorInstance),this.itemEditorInstance.parent.numChildren - 1);
            this.itemEditorInstance.visible = true;
            _loc12_ = _loc4_.x + _loc8_;
            this.itemEditorInstance.move(_loc12_,_loc5_.y + _loc9_);
            this.itemEditorInstance.setActualSize(this.editedItemRenderer.width + _loc10_,Math.min(_loc5_.height + _loc11_,listContent.height - listContent.y - this.itemEditorInstance.y));
            DisplayObject(this.itemEditorInstance).addEventListener(FocusEvent.FOCUS_OUT,this.itemEditorFocusOutHandler);
            this.layoutItemEditor();
         }
         else
         {
            this.itemEditorInstance = _loc4_;
         }
         DisplayObject(this.itemEditorInstance).addEventListener(KeyboardEvent.KEY_DOWN,this.editorKeyDownHandler);
         systemManager.getSandboxRoot().addEventListener(MouseEvent.MOUSE_DOWN,this.editorMouseDownHandler,true,0,true);
         systemManager.getSandboxRoot().addEventListener(SandboxMouseEvent.MOUSE_DOWN_SOMEWHERE,this.editorMouseDownHandler,false,0,true);
         systemManager.addEventListener(Event.RESIZE,this.editorStageResizeHandler,true,0,true);
      }
      
      private function findNextItemRenderer(param1:Boolean) : Boolean
      {
         var _loc7_:IListItemRenderer = null;
         var _loc8_:Object = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:Object = null;
         var _loc12_:String = null;
         var _loc13_:AdvancedDataGridEvent = null;
         if(!this.lastEditedItemPosition)
         {
            return false;
         }
         if(!this.editable.length)
         {
            this.loseFocus();
            return false;
         }
         if(this._proposedEditedItemPosition !== undefined)
         {
            return false;
         }
         this._editedItemPosition = this.lastEditedItemPosition;
         var _loc2_:int = this._editedItemPosition.rowIndex;
         var _loc3_:int = this._editedItemPosition.columnIndex;
         var _loc4_:Boolean = false;
         var _loc5_:int = !!param1?-1:1;
         var _loc6_:int = collection.length - 1;
         while(!_loc4_)
         {
            _loc3_ = _loc3_ + _loc5_;
            if(_loc3_ >= _columns.length || _loc3_ < 0)
            {
               _loc3_ = _loc3_ < 0?int(_columns.length - 1):0;
               _loc2_ = _loc2_ + _loc5_;
               if(_loc2_ > _loc6_ || _loc2_ < 0)
               {
                  this.loseFocus();
                  return false;
               }
            }
            _loc8_ = this.absoluteToVisibleIndices(_loc2_,_loc3_);
            _loc9_ = _loc8_.rowIndex;
            _loc10_ = _loc8_.columnIndex;
            if(_loc10_ > -1)
            {
               if(_loc9_ == listItems.length)
               {
                  _loc9_--;
               }
               else if(_loc9_ == -1)
               {
                  _loc9_ = 0;
               }
               _loc7_ = null;
               if(listItems[_loc9_] && listItems[_loc9_][_loc10_])
               {
                  _loc7_ = listItems[_loc9_][_loc10_];
               }
               if(_loc7_ && !_loc7_.visible)
               {
                  continue;
               }
            }
            _loc11_ = this.rowNumberToData(_loc2_);
            if(_loc11_ == null)
            {
               return true;
            }
            if(this.isDataEditable(_loc11_))
            {
               if(_columns[_loc3_].editable && _columns[_loc3_].visible)
               {
                  _loc4_ = true;
                  _loc12_ = _loc2_ == this._editedItemPosition.rowIndex?AdvancedDataGridEventReason.NEW_COLUMN:AdvancedDataGridEventReason.NEW_ROW;
                  if(!this.itemEditorInstance || this.endEdit(_loc12_))
                  {
                     _loc13_ = new AdvancedDataGridEvent(AdvancedDataGridEvent.ITEM_EDIT_BEGINNING,false,true);
                     _loc13_.columnIndex = _loc3_;
                     _loc13_.dataField = _columns[_loc3_].dataField;
                     _loc13_.rowIndex = _loc2_;
                     dispatchEvent(_loc13_);
                  }
               }
            }
         }
         return _loc4_;
      }
      
      private function loseFocus() : void
      {
         this.setEditedItemPosition(null);
         this.losingFocus = true;
         setFocus();
      }
      
      public function destroyItemEditor() : void
      {
         var _loc1_:AdvancedDataGridEvent = null;
         if(this.itemEditorInstance)
         {
            DisplayObject(this.itemEditorInstance).removeEventListener(KeyboardEvent.KEY_DOWN,this.editorKeyDownHandler);
            systemManager.getSandboxRoot().removeEventListener(MouseEvent.MOUSE_DOWN,this.editorMouseDownHandler,true);
            systemManager.getSandboxRoot().removeEventListener(SandboxMouseEvent.MOUSE_DOWN_SOMEWHERE,this.editorMouseDownHandler);
            systemManager.removeEventListener(Event.RESIZE,this.editorStageResizeHandler,true);
            _loc1_ = new AdvancedDataGridEvent(AdvancedDataGridEvent.ITEM_FOCUS_OUT);
            _loc1_.columnIndex = this._editedItemPosition.columnIndex;
            _loc1_.rowIndex = this._editedItemPosition.rowIndex;
            _loc1_.itemRenderer = this.itemEditorInstance;
            dispatchEvent(_loc1_);
            if(!_columns[this._editedItemPosition.columnIndex].rendererIsEditor)
            {
               if(this.itemEditorInstance && this.itemEditorInstance is UIComponent)
               {
                  UIComponent(this.itemEditorInstance).drawFocus(false);
               }
               this.itemEditorInstance.parent.removeChild(DisplayObject(this.itemEditorInstance));
            }
            this.itemEditorInstance = null;
            this._editedItemPosition = null;
         }
      }
      
      protected function endEdit(param1:String) : Boolean
      {
         if(!this.editedItemRenderer)
         {
            return true;
         }
         this.inEndEdit = true;
         var _loc2_:AdvancedDataGridEvent = new AdvancedDataGridEvent(AdvancedDataGridEvent.ITEM_EDIT_END,false,true);
         _loc2_.columnIndex = this.editedItemPosition.columnIndex;
         _loc2_.dataField = _columns[this.editedItemPosition.columnIndex].dataField;
         _loc2_.rowIndex = this.editedItemPosition.rowIndex;
         _loc2_.itemRenderer = this.editedItemRenderer;
         _loc2_.reason = param1;
         dispatchEvent(_loc2_);
         this.dontEdit = this.itemEditorInstance != null;
         if(!this.dontEdit && param1 == AdvancedDataGridEventReason.CANCELLED)
         {
            this.losingFocus = true;
            setFocus();
         }
         this.inEndEdit = false;
         return !_loc2_.isDefaultPrevented();
      }
      
      mx_internal function columnRendererChanged(param1:AdvancedDataGridColumn) : void
      {
         var _loc2_:IListItemRenderer = null;
         var _loc4_:Array = null;
         var _loc3_:IFactory = columnItemRendererFactory(param1,true,null);
         if(this.measuringObjects)
         {
            _loc2_ = this.measuringObjects[_loc3_];
            if(_loc2_)
            {
               _loc2_.parent.removeChild(DisplayObject(_loc2_));
               this.measuringObjects[_loc3_] = null;
            }
            _loc3_ = columnItemRendererFactory(param1,false,null);
            _loc2_ = this.measuringObjects[_loc3_];
            if(_loc2_)
            {
               _loc2_.parent.removeChild(DisplayObject(_loc2_));
               this.measuringObjects[_loc3_] = null;
            }
         }
         if(freeItemRenderersTable[param1])
         {
            _loc4_ = freeItemRenderersTable[param1][param1.itemRenderer] as Array;
            if(_loc4_)
            {
               while(_loc4_.length)
               {
                  _loc2_ = _loc4_.pop();
                  _loc2_.parent.removeChild(DisplayObject(_loc2_));
               }
            }
            _loc4_ = freeItemRenderersTable[param1][!!param1.headerRenderer?param1.headerRenderer:headerRenderer] as Array;
            if(_loc4_)
            {
               while(_loc4_.length)
               {
                  _loc2_ = _loc4_.pop();
                  _loc2_.parent.removeChild(DisplayObject(_loc2_));
               }
            }
         }
         rendererChanged = true;
         invalidateDisplayList();
      }
      
      protected function getPossibleDropPositions(param1:AdvancedDataGridColumn) : Array
      {
         var _loc2_:int = !!visibleColumns?int(visibleColumns.length):0;
         var _loc3_:Array = [];
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_.push(this.getHeaderInfo(visibleColumns[_loc4_]));
            _loc4_++;
         }
         return _loc3_;
      }
      
      protected function hasHeaderItemsCreated(param1:int = -1) : Boolean
      {
         if(param1 == -1)
         {
            return headerItems && headerItems[0] && headerItems[0][0];
         }
         return headerItems && headerItems[0] && headerItems[0][param1];
      }
      
      protected function columnDraggingMouseMoveHandler(param1:MouseEvent) : void
      {
         var _loc2_:IListItemRenderer = null;
         var _loc4_:Sprite = null;
         var _loc6_:int = 0;
         var _loc11_:AdvancedDataGridHeaderInfo = null;
         var _loc16_:IListItemRenderer = null;
         var _loc17_:AdvancedDataGridListData = null;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:EdgeMetrics = null;
         var _loc22_:Number = NaN;
         var _loc23_:AdvancedDataGridHeaderInfo = null;
         var _loc24_:Graphics = null;
         var _loc25_:EdgeMetrics = null;
         var _loc26_:Class = null;
         var _loc27_:AdvancedDataGridEvent = null;
         var _loc28_:AdvancedDataGridHeaderInfo = null;
         if(!param1.buttonDown)
         {
            this.columnDraggingMouseUpHandler(param1);
            return;
         }
         var _loc3_:AdvancedDataGridColumn = this.movingColumn;
         var _loc5_:int = 0;
         if(isNaN(this.startX))
         {
            this.startX = param1.stageX;
            this.lastItemDown = null;
            _loc16_ = columnItemRenderer(_loc3_,true,null);
            _loc16_.name = "headerDragProxy";
            _loc17_ = AdvancedDataGridListData(makeListData(_loc3_,null,0,_loc3_.colNum,_loc3_));
            if(_loc16_ is IDropInListItemRenderer)
            {
               IDropInListItemRenderer(_loc16_).listData = _loc17_;
            }
            listContent.addChild(DisplayObject(_loc16_));
            _loc6_ = this.orderedHeadersList.length;
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _loc2_ = this.orderedHeadersList[_loc5_].headerItem;
               if(_loc2_ && _loc2_.data == this.movingColumn)
               {
                  break;
               }
               _loc5_++;
            }
            _loc18_ = _loc2_.height + cachedPaddingBottom + cachedPaddingTop;
            _loc19_ = _loc2_.getExplicitOrMeasuredWidth();
            _loc20_ = _loc2_.x;
            if(this.orderedHeadersList[_loc5_].actualColNum >= lockedColumnCount)
            {
               _loc20_ = this.getAdjustedXPos(_loc2_.x);
               if(horizontalScrollPosition > 0 && this.orderedHeadersList[_loc5_].actualColNum - horizontalScrollPosition < lockedColumnCount)
               {
                  _loc22_ = 0;
                  if(lockedColumnCount > 0)
                  {
                     _loc23_ = this.getHeaderInfo(this.columns[lockedColumnCount - 1]);
                     _loc22_ = _loc23_.headerItem.x + this.columns[lockedColumnCount - 1].width;
                  }
                  else
                  {
                     _loc22_ = 0;
                  }
                  _loc19_ = _loc19_ - (_loc22_ - _loc20_);
                  _loc20_ = _loc22_;
               }
            }
            _loc16_.data = _loc3_;
            _loc16_.styleName = getStyle("headerDragProxyStyleName");
            UIComponentGlobals.layoutManager.validateClient(_loc16_,true);
            _loc16_.setActualSize(_loc19_,!!_explicitHeaderHeight?Number(headerHeight):Number(_loc16_.getExplicitOrMeasuredHeight()));
            _loc16_.move(_loc20_,_loc2_.y);
            _loc4_ = new FlexSprite();
            _loc4_.name = "columnDragOverlay";
            _loc4_.alpha = 0.6;
            listContent.addChildAt(_loc4_,listContent.getChildIndex(selectionLayer));
            _loc21_ = viewMetrics;
            _loc4_.x = _loc20_;
            _loc4_.y = _loc2_.y - cachedPaddingTop;
            if(_loc19_ > 0)
            {
               _loc24_ = _loc4_.graphics;
               _loc24_.beginFill(getStyle("disabledColor"));
               _loc24_.drawRect(0,0,_loc19_,unscaledHeight - _loc21_.bottom - _loc4_.y);
               _loc24_.endFill();
            }
            _loc4_ = Sprite(selectionLayer.getChildByName("headerSelection"));
            if(_loc4_)
            {
               _loc4_.width = _loc19_;
            }
            if(!listContent.mask)
            {
               _loc25_ = borderMetrics;
               listContent.scrollRect = new Rectangle(0,0,unscaledWidth - _loc25_.left - _loc25_.right,unscaledHeight - _loc25_.top - _loc25_.bottom);
            }
            return;
         }
         var _loc7_:Number = param1.stageX - this.startX;
         var _loc8_:Number = layoutDirection == LayoutDirection.LTR?Number(Number(_loc7_)):Number(-_loc7_);
         _loc4_ = Sprite(selectionLayer.getChildByName("headerSelection"));
         if(_loc4_)
         {
            _loc4_.x = _loc4_.x + _loc8_;
         }
         _loc2_ = IListItemRenderer(listContent.getChildByName("headerDragProxy"));
         if(_loc2_)
         {
            _loc2_.move(_loc2_.x + _loc8_,_loc2_.y);
         }
         this.startX = this.startX + _loc7_;
         var _loc9_:Point = new Point(param1.stageX,param1.stageY);
         _loc9_ = listContent.globalToLocal(_loc9_);
         this.lastPt = _loc9_;
         var _loc10_:Array = this.getPossibleDropPositions(this.movingColumn);
         _loc6_ = _loc10_.length;
         var _loc12_:Number = _loc10_[0].headerItem.x;
         var _loc13_:Number = _loc12_;
         var _loc14_:Boolean = false;
         this.dropIndexFound = false;
         var _loc15_:int = 0;
         while(_loc15_ < _loc6_)
         {
            _loc11_ = _loc10_[_loc15_];
            if(_loc11_.actualColNum >= lockedColumnCount)
            {
               _loc14_ = true;
            }
            _loc13_ = _loc13_ + _loc11_.column.width;
            if(_loc14_ && _loc11_.actualColNum + _loc11_.columnSpan - horizontalScrollPosition <= lockedColumnCount)
            {
               _loc12_ = _loc13_;
            }
            else
            {
               if(_loc14_)
               {
                  _loc12_ = this.getAdjustedXPos(_loc12_);
               }
               if(_loc9_.x >= _loc12_ && _loc9_.x < _loc12_ + _loc11_.column.width)
               {
                  this.dropIndexFound = true;
                  this.isHeaderDragOutside = false;
                  if(_loc9_.x > _loc12_ + _loc11_.column.width / 2 || _loc14_ && _loc11_.actualColNum - horizontalScrollPosition < lockedColumnCount)
                  {
                     _loc12_ = _loc12_ + _loc11_.column.width;
                     _loc15_++;
                  }
                  if(this.dropColumnIndex != _loc15_)
                  {
                     this.dropColumnIndex = _loc15_;
                     if(!this.columnDropIndicator)
                     {
                        _loc26_ = getStyle("columnDropIndicatorSkin");
                        if(!_loc26_)
                        {
                           _loc26_ = DataGridColumnDropIndicator;
                        }
                        this.columnDropIndicator = IFlexDisplayObject(new _loc26_());
                        if(this.columnDropIndicator is ISimpleStyleClient)
                        {
                           ISimpleStyleClient(this.columnDropIndicator).styleName = this;
                        }
                        listContent.addChild(DisplayObject(this.columnDropIndicator));
                     }
                     listContent.setChildIndex(DisplayObject(this.columnDropIndicator),listContent.numChildren - 1);
                     this.columnDropIndicator.x = _loc12_ - 2;
                     this.columnDropIndicator.y = _loc2_.y;
                     this.columnDropIndicator.setActualSize(3,listContent.height - _loc2_.y);
                  }
                  this.columnDropIndicator.visible = true;
                  break;
               }
               _loc12_ = _loc13_;
            }
            _loc15_++;
         }
         if(!this.dropIndexFound && this.isHeaderDragOutside == false)
         {
            this.isHeaderDragOutside = true;
            _loc27_ = new AdvancedDataGridEvent(AdvancedDataGridEvent.HEADER_DRAG_OUTSIDE,false,true);
            _loc28_ = this.getHeaderInfo(this.movingColumn);
            _loc27_.column = this.movingColumn;
            _loc27_.columnIndex = -1;
            _loc27_.itemRenderer = _loc28_.headerItem;
            _loc27_.triggerEvent = param1;
            dispatchEvent(_loc27_);
         }
      }
      
      protected function columnDraggingMouseUpHandler(param1:Event) : void
      {
         if(!this.movingColumn)
         {
            return;
         }
         var _loc2_:int = this.movingColumn.colNum;
         if(this.dropColumnIndex >= 0)
         {
            if(this.dropColumnIndex >= visibleColumns.length)
            {
               this.dropColumnIndex = visibleColumns.length - 1;
            }
            else if(_loc2_ < visibleColumns[this.dropColumnIndex].colNum)
            {
               this.dropColumnIndex--;
            }
            this.dropColumnIndex = visibleColumns[this.dropColumnIndex].colNum;
         }
         this.shiftColumns(_loc2_,this.dropColumnIndex,param1 as MouseEvent);
         this.unsetColumnDragParameters();
      }
      
      protected function unsetColumnDragParameters() : void
      {
         var _loc1_:DisplayObject = systemManager.getSandboxRoot();
         _loc1_.removeEventListener(MouseEvent.MOUSE_MOVE,this.columnDraggingMouseMoveHandler,true);
         _loc1_.removeEventListener(MouseEvent.MOUSE_UP,this.columnDraggingMouseUpHandler,true);
         _loc1_.removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE,this.columnDraggingMouseUpHandler);
         systemManager.deployMouseShields(false);
         var _loc2_:IListItemRenderer = IListItemRenderer(listContent.getChildByName("headerDragProxy"));
         if(_loc2_)
         {
            listContent.removeChild(DisplayObject(_loc2_));
         }
         var _loc3_:Sprite = Sprite(selectionLayer.getChildByName("headerSelection"));
         if(_loc3_)
         {
            selectionLayer.removeChild(_loc3_);
         }
         if(this.columnDropIndicator)
         {
            this.columnDropIndicator.visible = false;
         }
         _loc3_ = Sprite(listContent.getChildByName("columnDragOverlay"));
         if(_loc3_)
         {
            listContent.removeChild(_loc3_);
         }
         listContent.scrollRect = null;
         addClipMask(false);
         this.startX = NaN;
         this.movingColumn = null;
         this.dropColumnIndex = -1;
      }
      
      protected function isDraggingAllowed(param1:AdvancedDataGridColumn) : Boolean
      {
         return param1.draggable;
      }
      
      public function getFieldSortInfo(param1:AdvancedDataGridColumn) : SortInfo
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1 && collection && collection.sort)
         {
            if(!param1.dataField)
            {
               _loc2_ = itemToUID(param1);
            }
            _loc3_ = collection.sort.fields.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if(param1.dataField && collection.sort.fields[_loc4_].name == param1.dataField || _loc2_ && collection.sort.fields[_loc4_].name == _loc2_)
               {
                  return new SortInfo(_loc4_ + 1,collection.sort.fields[_loc4_].descending);
               }
               _loc4_++;
            }
         }
         return null;
      }
      
      protected function isDataEditable(param1:Object) : Boolean
      {
         return true;
      }
      
      protected function invalidateRenderer(param1:IListItemRenderer) : void
      {
         var _loc2_:IInvalidating = param1 as IInvalidating;
         if(_loc2_)
         {
            _loc2_.invalidateProperties();
            _loc2_.invalidateSize();
            _loc2_.invalidateDisplayList();
         }
      }
      
      protected function invalidateHeaders() : void
      {
         var _loc1_:int = this.orderedHeadersList.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this.invalidateRenderer(this.orderedHeadersList[_loc2_].headerItem);
            _loc2_++;
         }
      }
      
      protected function rowNumberToData(param1:int) : Object
      {
         var _loc2_:IViewCursor = collection.createCursor();
         _loc2_.seek(CursorBookmark.FIRST,param1);
         if(_loc2_.afterLast)
         {
            return null;
         }
         return _loc2_.current;
      }
      
      private function findNextEnterItemRenderer(param1:KeyboardEvent) : void
      {
         var _loc6_:Object = null;
         if(this._proposedEditedItemPosition !== undefined)
         {
            return;
         }
         this._editedItemPosition = this.lastEditedItemPosition;
         var _loc2_:int = this._editedItemPosition.rowIndex;
         var _loc3_:int = this._editedItemPosition.columnIndex;
         var _loc4_:int = _loc2_;
         while(true)
         {
            _loc4_ = _loc4_ + (!!param1.shiftKey?-1:1);
            if(_loc4_ < collection.length && _loc4_ >= 0)
            {
               _loc2_ = _loc4_;
               _loc6_ = this.rowNumberToData(_loc4_);
               if(_loc6_ == null)
               {
                  this.setEditedItemPosition(null);
                  return;
               }
               if(this.isDataEditable(_loc6_))
               {
                  var _loc5_:AdvancedDataGridEvent = new AdvancedDataGridEvent(AdvancedDataGridEvent.ITEM_EDIT_BEGINNING,false,true);
                  _loc5_.columnIndex = _loc3_;
                  _loc5_.dataField = _columns[_loc3_].dataField;
                  _loc5_.rowIndex = _loc2_;
                  dispatchEvent(_loc5_);
                  return;
               }
               continue;
            }
            break;
         }
         this.setEditedItemPosition(null);
      }
      
      protected function findSortField(param1:String) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(collection && collection.sort)
         {
            _loc2_ = collection.sort.fields.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if(collection.sort.fields[_loc3_]["name"] == param1)
               {
                  return _loc3_;
               }
               _loc3_++;
            }
         }
         return -1;
      }
      
      protected function addSortField(param1:String, param2:int, param3:ICollectionView) : void
      {
         var _loc9_:Sort = null;
         var _loc10_:String = null;
         var _loc4_:AdvancedDataGridColumn = this.columns[param2];
         if(!_loc4_.sortable)
         {
            return;
         }
         var _loc5_:AdvancedDataGridHeaderInfo = this.getHeaderInfo(_loc4_);
         if(_loc5_ && _loc5_.internalLabelFunction != null && _loc4_.sortCompareFunction == null)
         {
            return;
         }
         var _loc6_:Boolean = _loc4_.sortDescending;
         var _loc7_:Boolean = false;
         if(!param3.sort || !param3.sort.fields)
         {
            _loc7_ = true;
            _loc9_ = new Sort();
            _loc9_.fields = [];
            param3.sort = _loc9_;
         }
         else if(param3.sort.fields.length == 0)
         {
            _loc7_ = true;
         }
         if(_loc7_)
         {
            this.lastSortIndex = this.sortIndex;
            this.sortIndex = param2;
            this.sortColumn = _loc4_;
            _loc10_ = !!_loc6_?"DESC":"ASC";
            this.sortDirection = _loc10_;
         }
         else
         {
            this.lastSortIndex = -1;
            this.sortIndex = -1;
            this.sortColumn = null;
            this.sortDirection = null;
         }
         _loc4_.sortDescending = _loc6_;
         var _loc8_:SortField = new SortField(param1);
         _loc8_.descending = _loc6_;
         if(_loc4_.sortCompareFunction != null)
         {
            _loc8_.compareFunction = _loc4_.sortCompareFunction;
         }
         param3.sort.fields.push(_loc8_);
      }
      
      protected function removeSortField(param1:String, param2:int, param3:ICollectionView) : void
      {
         var _loc4_:AdvancedDataGridColumn = this.columns[param2];
         if(!param3 || !param3.sort || !param3.sort.fields || !param3.sort.fields.length)
         {
            return;
         }
         var _loc5_:int = -1;
         var _loc6_:int = param3.sort.fields.length;
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            if(param3.sort.fields[_loc7_].name == _loc4_.dataField)
            {
               _loc5_ = _loc7_;
               break;
            }
            _loc7_++;
         }
         if(_loc5_ != -1)
         {
            param3.sort.fields.splice(_loc5_,1);
         }
      }
      
      private function flipSortOrder(param1:String, param2:int, param3:ICollectionView) : String
      {
         var _loc4_:AdvancedDataGridColumn = null;
         if(param3.sort)
         {
            _loc4_ = this.columns[param2];
            param3.sort.fields[this.findSortField(param1)]["descending"] = !param3.sort.fields[this.findSortField(param1)]["descending"];
            if(param3.sort.fields[this.findSortField(param1)]["descending"])
            {
               _loc4_.sortDescending = true;
               return "DESC";
            }
            _loc4_.sortDescending = false;
            return "ASC";
         }
         return null;
      }
      
      private function findRenderer(param1:Point, param2:Array, param3:Array, param4:Number = 0) : IListItemRenderer
      {
         var _loc5_:IListItemRenderer = null;
         var _loc11_:int = 0;
         var _loc6_:Number = 0;
         var _loc7_:int = 0;
         var _loc8_:int = param2.length;
         var _loc9_:Array = getOptimumColumns();
         var _loc10_:int = 0;
         while(_loc10_ < _loc8_)
         {
            if(param2[_loc10_].length)
            {
               if(param1.y < param4 + param3[_loc10_].height)
               {
                  _loc7_ = param2[_loc10_].length;
                  if(_loc7_ == 1)
                  {
                     _loc5_ = param2[_loc10_][0];
                     break;
                  }
                  _loc6_ = 0;
                  _loc11_ = 0;
                  while(_loc11_ < _loc7_)
                  {
                     _loc6_ = _loc6_ + _loc9_[_loc11_].width;
                     if(param1.x < _loc6_)
                     {
                        _loc5_ = param2[_loc10_][_loc11_];
                        break;
                     }
                     _loc11_++;
                  }
                  if(_loc5_)
                  {
                     break;
                  }
               }
            }
            param4 = param4 + param3[_loc10_].height;
            _loc10_++;
         }
         return _loc5_;
      }
      
      private function findHeaderRenderer(param1:Point) : IListItemRenderer
      {
         var _loc2_:IListItemRenderer = null;
         var _loc9_:int = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:int = 0;
         var _loc6_:int = headerItems.length;
         var _loc7_:Array = getOptimumColumns();
         var _loc8_:int = 0;
         while(_loc8_ < _loc6_)
         {
            if(headerItems[_loc8_].length)
            {
               if(param1.y < _loc3_ + headerRowInfo[_loc8_].height)
               {
                  _loc5_ = headerItems[_loc8_].length;
                  if(_loc5_ == 1)
                  {
                     _loc2_ = headerItems[_loc8_][0];
                     break;
                  }
                  _loc4_ = 0;
                  _loc9_ = 0;
                  while(_loc9_ < lockedColumnCount)
                  {
                     _loc4_ = _loc4_ + _loc7_[_loc9_].width;
                     if(param1.x < _loc4_)
                     {
                        _loc2_ = headerItems[_loc8_][_loc9_];
                        break;
                     }
                     _loc9_++;
                  }
                  if(_loc2_)
                  {
                     break;
                  }
                  _loc9_ = lockedColumnCount + horizontalScrollPosition;
                  while(_loc9_ < _loc5_)
                  {
                     _loc4_ = _loc4_ + _loc7_[_loc9_].width;
                     if(param1.x < _loc4_)
                     {
                        _loc2_ = headerItems[_loc8_][_loc9_];
                        break;
                     }
                     _loc9_++;
                  }
               }
            }
            _loc3_ = _loc3_ + headerRowInfo[_loc8_].height;
            _loc8_++;
         }
         return _loc2_;
      }
      
      mx_internal function getSeparators() : Array
      {
         return this.separators;
      }
      
      mx_internal function getLockedSeparators() : Array
      {
         return this.lockedSeparators;
      }
      
      private function measureItems() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Object = null;
         var _loc4_:IListItemRenderer = null;
         var _loc5_:AdvancedDataGridColumn = null;
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(itemsNeedMeasurement)
         {
            itemsNeedMeasurement = false;
            if(isNaN(explicitRowHeight))
            {
               if(iterator && this.columns.length > 0)
               {
                  if(!this.measuringObjects)
                  {
                     this.measuringObjects = new Dictionary(false);
                  }
                  visibleColumns = this.columns;
                  columnsInvalid = true;
                  _loc1_ = getStyle("paddingTop");
                  _loc2_ = getStyle("paddingBottom");
                  _loc3_ = iterator.current;
                  _loc6_ = 0;
                  _loc7_ = this.columns.length;
                  _loc8_ = 0;
                  while(_loc8_ < _loc7_)
                  {
                     _loc5_ = this.columns[_loc8_];
                     if(_loc5_.visible)
                     {
                        _loc4_ = this.getMeasuringRenderer(_loc5_,false,_loc3_);
                        this.setupRendererFromData(_loc5_,_loc4_,_loc3_);
                        _loc6_ = Math.max(_loc6_,_loc4_.getExplicitOrMeasuredHeight() + _loc2_ + _loc1_);
                     }
                     _loc8_++;
                  }
                  setRowHeight(Math.max(_loc6_,20));
               }
               else
               {
                  setRowHeight(20);
               }
            }
         }
      }
      
      protected function layoutItemEditor() : void
      {
      }
      
      public function moveFocusToHeader(param1:int = -1) : void
      {
         if(!headerVisible || this.headerIndex != -1)
         {
            return;
         }
         if(visibleColumns.length > 0)
         {
            if(param1 == -1)
            {
               param1 = visibleColumns[0].colNum;
            }
            this.selectedHeaderInfo = this.getHeaderInfo(this.columns[param1]);
            this.headerIndex = param1;
            this.selectColumnHeader(this.headerIndex);
         }
      }
      
      protected function selectColumnHeader(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Sprite = null;
         var _loc6_:IListItemRenderer = null;
         var _loc7_:Graphics = null;
         _loc2_ = -1;
         _loc3_ = visibleColumns.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(visibleColumns[_loc4_].colNum == param1)
            {
               _loc2_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         if(_loc2_ == -1)
         {
            _loc2_ = 0;
            this.headerIndex = visibleColumns[0].colNum;
         }
         _loc5_ = Sprite(selectionLayer.getChildByName("headerKeyboardSelection"));
         if(!_loc5_)
         {
            _loc5_ = new FlexSprite();
            _loc5_.name = "headerKeyboardSelection";
            selectionLayer.addChild(_loc5_);
         }
         _loc6_ = this.selectedHeaderInfo.headerItem;
         if(_loc6_)
         {
            _loc7_ = _loc5_.graphics;
            _loc7_.clear();
            _loc7_.beginFill(isPressed || this.isKeyPressed?uint(getStyle("selectionColor")):uint(getStyle("rollOverColor")));
            _loc7_.drawRect(0,0,visibleColumns[_loc2_].width,_loc6_.height + cachedPaddingTop + cachedPaddingBottom - 0.5);
            _loc7_.endFill();
            _loc5_.x = this.getAdjustedXPos(_loc6_.x);
            _loc5_.y = _loc6_.y - cachedPaddingTop;
            caretIndex = -1;
            isPressed = false;
            this.selectItem(this.selectedHeaderInfo.headerItem,false,false);
         }
      }
      
      protected function unselectColumnHeader(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:Sprite = null;
         _loc3_ = Sprite(selectionLayer.getChildByName("headerKeyboardSelection"));
         if(_loc3_)
         {
            selectionLayer.removeChild(_loc3_);
         }
         this.selectedHeaderInfo = null;
         if(param2)
         {
            caretIndex = 0;
            isPressed = false;
            this.selectItem(listItems[caretIndex][0],false,false);
         }
      }
      
      protected function isHeaderItemRenderer(param1:IListItemRenderer) : Boolean
      {
         if(param1 != null && param1.data is AdvancedDataGridColumn)
         {
            return true;
         }
         return false;
      }
      
      protected function absoluteToDisplayColumnIndex(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = this.displayableColumns.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(this.displayableColumns[_loc3_].colNum == param1)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      protected function displayToAbsoluteColumnIndex(param1:int) : int
      {
         return this.displayableColumns[param1].colNum;
      }
      
      protected function absoluteToVisibleColumnIndex(param1:int) : int
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = getOptimumColumns();
         _loc3_ = _loc2_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_[_loc4_].colNum == param1)
            {
               return _loc4_;
            }
            _loc4_++;
         }
         return -1;
      }
      
      protected function visibleToAbsoluteColumnIndex(param1:int) : int
      {
         var _loc2_:Array = null;
         _loc2_ = getOptimumColumns();
         return _loc2_[param1].colNum;
      }
      
      protected function isColumnFullyVisible(param1:int, param2:int = -1) : Boolean
      {
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = false;
         var _loc7_:Number = NaN;
         if(param2 == -1)
         {
            param2 = verticalScrollPosition;
         }
         _loc3_ = this.absoluteToVisibleIndices(param2,param1);
         _loc4_ = _loc3_.rowIndex;
         _loc5_ = _loc3_.columnIndex;
         if(_loc4_ < 0)
         {
            return false;
         }
         _loc6_ = _loc5_ != -1;
         if(_loc6_)
         {
            if(listItems.length >= 1 && visibleColumns.length >= 1)
            {
               _loc7_ = listItems[_loc4_][_loc5_].x;
               if(getOptimumColumns() == this.displayableColumns && _loc5_ > lockedColumnCount)
               {
                  _loc7_ = this.getAdjustedXPos(_loc7_);
               }
               if(_loc7_ + listItems[_loc4_][_loc5_].width > listContent.width)
               {
                  _loc6_ = false;
               }
            }
         }
         return _loc6_;
      }
      
      protected function viewDisplayableColumnAtOffset(param1:int, param2:int, param3:int = -1, param4:Boolean = true) : int
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Object = null;
         var _loc10_:IListItemRenderer = null;
         _loc5_ = this.absoluteToDisplayColumnIndex(param1);
         if(_loc5_ == -1)
         {
            return -1;
         }
         _loc6_ = this.displayableColumns.length;
         _loc7_ = _loc5_ + param2;
         while(true)
         {
            if(!(_loc7_ >= 0 && _loc7_ <= _loc6_ - 1))
            {
               return -1;
            }
            if(param3 > -1)
            {
               _loc9_ = this.absoluteToVisibleIndices(param3,this.displayToAbsoluteColumnIndex(_loc7_));
               if(listItems[_loc9_.rowIndex])
               {
                  _loc10_ = listItems[_loc9_.rowIndex][_loc9_.columnIndex];
               }
               if(_loc10_ && !_loc10_.visible)
               {
                  _loc7_ = _loc7_ + param2;
                  continue;
               }
               break;
            }
            break;
         }
         _loc8_ = this.displayToAbsoluteColumnIndex(_loc7_);
         if(_loc8_ < 0 || _loc8_ > this.columns.length - 1)
         {
            return -1;
         }
         if(param4)
         {
            if(!this.isColumnFullyVisible(_loc8_))
            {
               this.scrollToViewColumn(_loc8_,param1);
            }
         }
         return _loc8_;
      }
      
      protected function scrollToViewColumn(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:ScrollEvent = null;
         if(param1 == param2)
         {
            return;
         }
         _loc5_ = this.absoluteToDisplayColumnIndex(param1);
         _loc6_ = this.absoluteToDisplayColumnIndex(param2);
         _loc7_ = _loc5_ - _loc6_;
         _loc8_ = Math.max(0,horizontalScrollPosition + _loc7_);
         if(lockedColumnCount > 0 && param2 == lockedColumnCount - 1)
         {
            _loc8_ = 0;
         }
         _loc9_ = new ScrollEvent(ScrollEvent.SCROLL);
         _loc9_.detail = ScrollEventDetail.THUMB_POSITION;
         _loc9_.direction = ScrollEventDirection.HORIZONTAL;
         _loc9_.delta = _loc7_;
         _loc9_.position = _loc8_;
         dispatchEvent(_loc9_);
         this.horizontalScrollPosition = _loc8_;
      }
      
      protected function absoluteToVisibleIndices(param1:int, param2:int) : Object
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         _loc3_ = -1;
         _loc4_ = -1;
         if((param1 < lockedRowCount || param1 >= verticalScrollPosition) && param1 <= verticalScrollPosition + (!!listItems.length?listItems.length - 1:0))
         {
            if(param1 >= lockedRowCount && param1 >= verticalScrollPosition)
            {
               _loc3_ = param1 - verticalScrollPosition;
            }
            else
            {
               _loc3_ = param1;
            }
         }
         if(_loc3_ > -1)
         {
            _loc5_ = visibleColumns;
            if(_loc5_ && _loc5_.length > 0)
            {
               if(param2 >= _loc5_[0].colNum && param2 <= _loc5_[_loc5_.length - 1].colNum)
               {
                  if(param2 >= lockedColumnCount)
                  {
                     _loc4_ = this.absoluteToVisibleColumnIndex(param2);
                  }
                  else
                  {
                     _loc4_ = param2;
                  }
               }
            }
         }
         return {
            "rowIndex":_loc3_,
            "columnIndex":_loc4_
         };
      }
      
      protected function colNumToIndex(param1:int) : int
      {
         if(getOptimumColumns() == visibleColumns)
         {
            return this.absoluteToVisibleColumnIndex(param1);
         }
         if(getOptimumColumns() == this.displayableColumns)
         {
            return this.absoluteToDisplayColumnIndex(param1);
         }
         return -1;
      }
      
      protected function indexToColNum(param1:int) : int
      {
         if(getOptimumColumns() == visibleColumns)
         {
            return this.visibleToAbsoluteColumnIndex(param1);
         }
         if(getOptimumColumns() == this.displayableColumns)
         {
            return this.displayToAbsoluteColumnIndex(param1);
         }
         return -1;
      }
      
      override protected function collectionChangeHandler(param1:Event) : void
      {
         var _loc2_:CollectionEvent = null;
         var _loc3_:Object = null;
         var _loc4_:CollectionEvent = null;
         if(iterator == null)
         {
            return;
         }
         if(param1 is CollectionEvent)
         {
            _loc2_ = CollectionEvent(param1);
            if(_loc2_.kind == CollectionEventKind.EXPAND)
            {
               param1.stopPropagation();
            }
            if(_loc2_.kind == CollectionEventKind.UPDATE)
            {
               param1.stopPropagation();
               itemsSizeChanged = true;
               invalidateDisplayList();
            }
            if(_loc2_.kind == CollectionEventKind.RESET)
            {
               if(this.generatedColumns)
               {
                  this.generateCols();
               }
               this.updateSortIndexAndDirection();
            }
            else if(_loc2_.kind == CollectionEventKind.REFRESH && !this.manualSort)
            {
               this.updateSortIndexAndDirection();
            }
            else if(_loc2_.kind == CollectionEventKind.REMOVE)
            {
               if(this.editedItemPosition)
               {
                  if(collection.length == 0)
                  {
                     if(this.itemEditorInstance)
                     {
                        this.endEdit(AdvancedDataGridEventReason.CANCELLED);
                     }
                     this.setEditedItemPosition(null);
                  }
                  else if(_loc2_.location <= this.editedItemPosition.rowIndex)
                  {
                     _loc3_ = this.editedItemPosition;
                     if(_loc2_.location == this.editedItemPosition.rowIndex && this.itemEditorInstance)
                     {
                        this.endEdit(AdvancedDataGridEventReason.CANCELLED);
                     }
                     if(this.inEndEdit)
                     {
                        this._editedItemPosition = {
                           "columnIndex":this.editedItemPosition.columnIndex,
                           "rowIndex":Math.max(0,this.editedItemPosition.rowIndex - _loc2_.items.length)
                        };
                     }
                     else
                     {
                        this.setEditedItemPosition({
                           "columnIndex":_loc3_.columnIndex,
                           "rowIndex":Math.max(0,_loc3_.rowIndex - _loc2_.items.length)
                        });
                     }
                  }
               }
            }
            else if(_loc2_.kind == CollectionEventKind.REPLACE)
            {
               if(this.editedItemPosition)
               {
                  if(_loc2_.location == this.editedItemPosition.rowIndex && this.itemEditorInstance)
                  {
                     this.endEdit(AdvancedDataGridEventReason.CANCELLED);
                  }
               }
            }
         }
         super.collectionChangeHandler(param1);
         if(param1 is CollectionEvent)
         {
            _loc4_ = CollectionEvent(param1);
            if(_loc4_.kind == CollectionEventKind.ADD)
            {
               if(collection.length == 1)
               {
                  if(this.generatedColumns)
                  {
                     this.generateCols();
                  }
               }
            }
         }
      }
      
      override protected function mouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:IListItemRenderer = null;
         var _loc3_:int = 0;
         var _loc4_:IListItemRenderer = null;
         var _loc5_:AdvancedDataGridHeaderInfo = null;
         var _loc6_:int = 0;
         var _loc7_:Sprite = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Graphics = null;
         var _loc12_:Number = NaN;
         var _loc13_:AdvancedDataGridHeaderInfo = null;
         if(this.movingColumn)
         {
            return;
         }
         if(!enabled || !selectable)
         {
            return;
         }
         if(enabled && headerVisible && this.getNumColumns() && !isPressed)
         {
            _loc2_ = this.mouseEventToItemRenderer(param1);
            _loc3_ = this.orderedHeadersList.length;
            _loc6_ = 0;
            while(_loc6_ < _loc3_ && _loc2_)
            {
               _loc4_ = this.orderedHeadersList[_loc6_].headerItem;
               if(_loc4_ == _loc2_)
               {
                  _loc5_ = this.orderedHeadersList[_loc6_];
                  if(this.orderedHeadersList[_loc6_].column.sortable)
                  {
                     _loc7_ = Sprite(selectionLayer.getChildByName("headerSelection"));
                     if(!_loc7_)
                     {
                        _loc7_ = new FlexSprite();
                        _loc7_.name = "headerSelection";
                        selectionLayer.addChild(_loc7_);
                     }
                     _loc8_ = _loc2_.height + cachedPaddingBottom + cachedPaddingTop;
                     _loc9_ = _loc2_.getExplicitOrMeasuredWidth();
                     _loc10_ = _loc2_.x;
                     if(_loc5_.actualColNum >= lockedColumnCount)
                     {
                        _loc10_ = this.getAdjustedXPos(_loc2_.x);
                        if(horizontalScrollPosition > 0 && _loc5_.actualColNum - horizontalScrollPosition < lockedColumnCount)
                        {
                           _loc12_ = 0;
                           if(lockedColumnCount > 0)
                           {
                              _loc13_ = this.getHeaderInfo(this.columns[lockedColumnCount - 1]);
                              _loc12_ = _loc13_.headerItem.x + this.columns[lockedColumnCount - 1].width;
                           }
                           else
                           {
                              _loc12_ = 0;
                           }
                           _loc9_ = _loc9_ - (_loc12_ - _loc10_);
                           _loc10_ = _loc12_;
                        }
                     }
                     _loc11_ = _loc7_.graphics;
                     _loc11_.clear();
                     _loc11_.beginFill(getStyle("rollOverColor"));
                     _loc11_.drawRect(0,0,_loc9_,_loc8_ - 0.5);
                     _loc11_.endFill();
                     _loc7_.x = _loc10_;
                     _loc7_.y = _loc2_.y - cachedPaddingTop;
                  }
                  return;
               }
               _loc6_++;
            }
         }
         if(param1.buttonDown)
         {
            this.lastItemDown = _loc2_;
         }
         else
         {
            this.lastItemDown = null;
         }
         super.mouseOverHandler(param1);
      }
      
      override protected function mouseOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:IListItemRenderer = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:IListItemRenderer = null;
         var _loc6_:int = 0;
         var _loc7_:Sprite = null;
         if(this.movingColumn)
         {
            return;
         }
         _loc3_ = getOptimumColumns();
         if(enabled && headerVisible && listItems.length)
         {
            _loc2_ = this.mouseEventToItemRenderer(param1);
            if(!_loc2_)
            {
               _loc4_ = _loc3_.length;
               _loc6_ = 0;
               while(_loc6_ < _loc4_)
               {
                  if(_loc3_[_loc6_].colNum == this.sortIndex)
                  {
                     _loc2_ = this.getHeaderInfo(_loc3_[_loc6_]).headerItem;
                  }
                  _loc6_++;
               }
            }
            _loc4_ = this.orderedHeadersList.length;
            _loc6_ = 0;
            while(_loc6_ < _loc4_ && _loc2_)
            {
               _loc5_ = this.orderedHeadersList[_loc6_].headerItem;
               if(_loc5_ == _loc2_)
               {
                  if(this.orderedHeadersList[_loc6_].column.sortable)
                  {
                     _loc7_ = Sprite(selectionLayer.getChildByName("headerSelection"));
                     if(_loc7_)
                     {
                        selectionLayer.removeChild(_loc7_);
                     }
                  }
                  return;
               }
               _loc6_++;
            }
         }
         if(param1.buttonDown)
         {
            this.lastItemDown = _loc2_;
         }
         else
         {
            this.lastItemDown = null;
         }
         super.mouseOutHandler(param1);
      }
      
      override protected function mouseDownHandler(param1:MouseEvent) : void
      {
         var _loc2_:IListItemRenderer = null;
         var _loc3_:Sprite = null;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var _loc7_:IListItemRenderer = null;
         var _loc8_:int = 0;
         var _loc9_:AdvancedDataGridHeaderInfo = null;
         var _loc10_:AdvancedDataGridColumn = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Graphics = null;
         var _loc15_:Number = NaN;
         var _loc16_:AdvancedDataGridHeaderInfo = null;
         var _loc17_:DisplayObject = null;
         var _loc18_:Point = null;
         var _loc19_:Boolean = false;
         var _loc20_:Point = null;
         _loc2_ = this.mouseEventToItemRenderer(param1);
         var _loc4_:Array = getOptimumColumns();
         if(enabled && (this.sortableColumns || this.draggableColumns) && headerVisible && this.hasHeaderItemsCreated())
         {
            _loc6_ = this.orderedHeadersList.length;
            _loc8_ = 0;
            while(_loc8_ < _loc6_ && _loc2_)
            {
               _loc7_ = this.orderedHeadersList[_loc8_].headerItem;
               if(_loc7_ == _loc2_)
               {
                  _loc9_ = this.orderedHeadersList[_loc8_];
                  if(this.itemEditorInstance)
                  {
                     this.endEdit(AdvancedDataGridEventReason.OTHER);
                  }
                  _loc10_ = this.orderedHeadersList[_loc8_].column;
                  if(this.sortableColumns && _loc10_.sortable)
                  {
                     this.lastItemDown = _loc2_;
                     _loc3_ = Sprite(selectionLayer.getChildByName("headerSelection"));
                     if(!_loc3_)
                     {
                        _loc3_ = new FlexSprite();
                        _loc3_.name = "headerSelection";
                        selectionLayer.addChild(_loc3_);
                     }
                     _loc11_ = _loc2_.height + cachedPaddingBottom + cachedPaddingTop;
                     _loc12_ = _loc2_.getExplicitOrMeasuredWidth();
                     _loc13_ = _loc2_.x;
                     if(_loc9_.actualColNum >= lockedColumnCount)
                     {
                        _loc13_ = this.getAdjustedXPos(_loc2_.x);
                        if(horizontalScrollPosition > 0 && _loc9_.actualColNum - horizontalScrollPosition < lockedColumnCount)
                        {
                           _loc15_ = 0;
                           if(lockedColumnCount > 0)
                           {
                              _loc16_ = this.getHeaderInfo(this.columns[lockedColumnCount - 1]);
                              _loc15_ = _loc16_.headerItem.x + this.columns[lockedColumnCount - 1].width;
                           }
                           else
                           {
                              _loc15_ = 0;
                           }
                           _loc12_ = _loc12_ - (_loc15_ - _loc13_);
                           _loc13_ = _loc15_;
                        }
                     }
                     _loc14_ = _loc3_.graphics;
                     _loc14_.clear();
                     _loc14_.beginFill(getStyle("selectionColor"));
                     _loc14_.drawRect(0,0,_loc12_,_loc11_ - 0.5);
                     _loc14_.endFill();
                     _loc3_.x = _loc13_;
                     _loc3_.y = _loc2_.y - cachedPaddingTop;
                  }
                  isPressed = true;
                  if(this.draggableColumns && this.isDraggingAllowed(_loc10_))
                  {
                     this.startX = NaN;
                     _loc17_ = systemManager.getSandboxRoot();
                     _loc17_.addEventListener(MouseEvent.MOUSE_MOVE,this.columnDraggingMouseMoveHandler,true);
                     _loc17_.addEventListener(MouseEvent.MOUSE_UP,this.columnDraggingMouseUpHandler,true);
                     _loc17_.addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE,this.columnDraggingMouseUpHandler);
                     systemManager.deployMouseShields(true);
                     this.movingColumn = _loc10_;
                  }
                  return;
               }
               _loc8_++;
            }
         }
         this.lastItemDown = null;
         _loc5_ = itemRendererContains(this.itemEditorInstance,DisplayObject(param1.target));
         if(!_loc5_)
         {
            if(_loc2_ && _loc2_.data)
            {
               this.lastItemDown = _loc2_;
               _loc18_ = itemRendererToIndices(_loc2_);
               _loc19_ = true;
               if(this.itemEditorInstance)
               {
                  if(_loc18_ == null || this.displayableColumns[_loc18_.x].editable == false)
                  {
                     _loc19_ = this.endEdit(AdvancedDataGridEventReason.OTHER);
                  }
                  else
                  {
                     _loc19_ = this.endEdit(this.editedItemPosition.rowIndex == _loc18_.y?AdvancedDataGridEventReason.NEW_COLUMN:AdvancedDataGridEventReason.NEW_ROW);
                  }
               }
               if(!_loc19_)
               {
                  return;
               }
            }
            else if(this.itemEditorInstance)
            {
               this.endEdit(AdvancedDataGridEventReason.OTHER);
            }
            if(this.headerIndex != -1)
            {
               _loc20_ = itemRendererToIndices(_loc2_);
               if(_loc20_)
               {
                  this.unselectColumnHeader(this.headerIndex,true);
                  this.headerIndex = -1;
                  caretIndex = _loc20_.y;
               }
            }
            super.mouseDownHandler(param1);
            if(_loc2_)
            {
               if(_loc18_ && this.displayableColumns[_loc18_.x].rendererIsEditor)
               {
                  resetDragScrolling();
               }
            }
         }
         else
         {
            resetDragScrolling();
         }
      }
      
      override protected function mouseUpHandler(param1:MouseEvent) : void
      {
         var _loc2_:AdvancedDataGridEvent = null;
         var _loc3_:IListItemRenderer = null;
         var _loc4_:Sprite = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Point = null;
         var _loc8_:AdvancedDataGridColumn = null;
         if(!collection || !collection.length)
         {
            return;
         }
         _loc3_ = this.mouseEventToItemRenderer(param1);
         if(enabled && (this.sortableColumns || this.draggableColumns) && collection && headerVisible && this.hasHeaderItemsCreated())
         {
            _loc5_ = this.orderedHeadersList.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               if(_loc3_ == this.orderedHeadersList[_loc6_].headerItem && _loc3_)
               {
                  _loc8_ = this.orderedHeadersList[_loc6_].column;
                  if(this.sortableColumns && _loc8_.sortable && this.lastItemDown == _loc3_)
                  {
                     this.lastItemDown = null;
                     _loc2_ = new AdvancedDataGridEvent(AdvancedDataGridEvent.HEADER_RELEASE,false,true);
                     if(_loc8_.colNum == -1 || isNaN(_loc8_.colNum))
                     {
                        _loc2_.columnIndex = -1;
                     }
                     else
                     {
                        _loc2_.columnIndex = _loc8_.colNum;
                     }
                     _loc2_.dataField = _loc8_.dataField;
                     _loc2_.itemRenderer = _loc3_;
                     _loc2_.triggerEvent = param1;
                     if(Object(_loc3_).hasOwnProperty("mouseEventToHeaderPart"))
                     {
                        _loc2_.headerPart = Object(_loc3_).mouseEventToHeaderPart(param1);
                     }
                     dispatchEvent(_loc2_);
                  }
                  isPressed = false;
                  return;
               }
               _loc6_++;
            }
         }
         if(this.movingColumn)
         {
            return;
         }
         super.mouseUpHandler(param1);
         if(_loc3_ && _loc3_.data && _loc3_ != this.itemEditorInstance && this.lastItemDown == _loc3_ && _loc3_.visible && this.isDataEditable(_loc3_.data))
         {
            _loc7_ = itemRendererToIndices(_loc3_);
            if(_loc7_ && _loc7_.y >= 0 && this.displayableColumns[_loc7_.x].editable && !this.dontEdit)
            {
               _loc2_ = new AdvancedDataGridEvent(AdvancedDataGridEvent.ITEM_EDIT_BEGINNING,false,true);
               _loc2_.columnIndex = this.displayableColumns[_loc7_.x].colNum;
               _loc2_.dataField = this.displayableColumns[_loc7_.x].dataField;
               _loc2_.rowIndex = _loc7_.y;
               _loc2_.itemRenderer = _loc3_;
               dispatchEvent(_loc2_);
            }
         }
         else if(this.lastItemDown && this.lastItemDown != this.itemEditorInstance)
         {
            _loc7_ = itemRendererToIndices(this.lastItemDown);
            if(_loc7_ && _loc7_.y >= 0 && this.editable && !this.dontEdit)
            {
               if(this.displayableColumns[_loc7_.x].editable)
               {
                  _loc2_ = new AdvancedDataGridEvent(AdvancedDataGridEvent.ITEM_EDIT_BEGINNING,false,true);
                  _loc2_.columnIndex = this.displayableColumns[_loc7_.x].colNum;
                  _loc2_.dataField = this.displayableColumns[_loc7_.x].dataField;
                  _loc2_.rowIndex = _loc7_.y;
                  _loc2_.itemRenderer = this.lastItemDown;
                  dispatchEvent(_loc2_);
               }
               else
               {
                  this.lastEditedItemPosition = {
                     "columnIndex":_loc7_.x,
                     "rowIndex":_loc7_.y
                  };
               }
            }
         }
         this.lastItemDown = null;
      }
      
      override protected function focusInHandler(param1:FocusEvent) : void
      {
         var _loc2_:* = false;
         var _loc3_:Array = null;
         if(this.losingFocus)
         {
            this.losingFocus = false;
            return;
         }
         if(this.editable.length)
         {
            addEventListener(FocusEvent.KEY_FOCUS_CHANGE,this.keyFocusChangeHandler);
            addEventListener(MouseEvent.MOUSE_DOWN,this.mouseFocusChangeHandler);
         }
         if(param1.target != this)
         {
            return;
         }
         super.focusInHandler(param1);
         if(this.editable.length && !isPressed)
         {
            this._editedItemPosition = this.lastEditedItemPosition;
            _loc2_ = this.editedItemPosition != null;
            if(!this._editedItemPosition)
            {
               this._editedItemPosition = {
                  "rowIndex":0,
                  "columnIndex":0
               };
               while(this._editedItemPosition.columnIndex != _columns.length)
               {
                  if(_columns[this._editedItemPosition.columnIndex].editable && _columns[this._editedItemPosition.columnIndex].visible)
                  {
                     _loc3_ = listItems[this._editedItemPosition.rowIndex];
                     if(_loc3_ && _loc3_[this._editedItemPosition.columnIndex])
                     {
                        _loc2_ = true;
                        break;
                     }
                  }
                  this._editedItemPosition.columnIndex++;
               }
            }
            if(_loc2_)
            {
               this.setEditedItemPosition(this._editedItemPosition);
            }
         }
      }
      
      override protected function focusOutHandler(param1:FocusEvent) : void
      {
         if(param1.target == this)
         {
            super.focusOutHandler(param1);
         }
         if(param1.relatedObject == this && itemRendererContains(this.itemEditorInstance,DisplayObject(param1.target)))
         {
            return;
         }
         if(param1.relatedObject == null && itemRendererContains(this.editedItemRenderer,DisplayObject(param1.target)))
         {
            return;
         }
         if(param1.relatedObject == null && itemRendererContains(this.itemEditorInstance,DisplayObject(param1.target)))
         {
            return;
         }
         if(this.itemEditorInstance && (!param1.relatedObject || !itemRendererContains(this.itemEditorInstance,param1.relatedObject)))
         {
            this.endEdit(AdvancedDataGridEventReason.OTHER);
            removeEventListener(FocusEvent.KEY_FOCUS_CHANGE,this.keyFocusChangeHandler);
            removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseFocusChangeHandler);
         }
      }
      
      override protected function keyDownHandler(param1:KeyboardEvent) : void
      {
         if(this.itemEditorInstance || param1.target != param1.currentTarget)
         {
            return;
         }
         if(this.headerIndex != -1)
         {
            this.headerNavigationHandler(param1);
            return;
         }
         if(param1.keyCode == Keyboard.ESCAPE)
         {
            this.setEditedItemPosition(null);
            this.lastEditedItemPosition = null;
            this.endEdit(AdvancedDataGridEventReason.CANCELLED);
            return;
         }
         if(headerVisible && selectedIndex == 0 && caretIndex == 0 && param1.keyCode == Keyboard.UP && !param1.ctrlKey && !param1.shiftKey)
         {
            this.moveFocusToHeader();
         }
         else if(param1.keyCode == Keyboard.UP && caretIndex == 0 && selectedIndex == -1)
         {
            this.moveFocusToHeader();
         }
         else if(param1.shiftKey && (param1.keyCode == Keyboard.PAGE_UP || param1.keyCode == Keyboard.PAGE_DOWN))
         {
            this.moveSelectionHorizontally(param1.keyCode,param1.shiftKey,param1.ctrlKey);
         }
         if(param1.keyCode != Keyboard.SPACE)
         {
            super.keyDownHandler(param1);
         }
         else if(caretIndex != -1)
         {
            moveSelectionVertically(param1.keyCode,param1.shiftKey,param1.ctrlKey);
         }
      }
      
      override protected function keyUpHandler(param1:KeyboardEvent) : void
      {
         if(this.isKeyPressed && this.headerIndex != -1)
         {
            this.isKeyPressed = false;
            this.selectedHeaderInfo = this.getHeaderInfo(this.columns[this.headerIndex]);
            this.selectColumnHeader(this.headerIndex);
         }
      }
      
      override protected function mouseWheelHandler(param1:MouseEvent) : void
      {
         if(this.itemEditorInstance)
         {
            this.endEdit(AdvancedDataGridEventReason.OTHER);
         }
         super.mouseWheelHandler(param1);
      }
      
      override protected function dragStartHandler(param1:DragEvent) : void
      {
         if(this.collectionUpdatesDisabled)
         {
            collection.enableAutoUpdate();
            this.collectionUpdatesDisabled = false;
         }
         super.dragStartHandler(param1);
      }
      
      private function columnResizeMouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:Class = null;
         if(!enabled || !this.resizableColumns)
         {
            return;
         }
         _loc2_ = DisplayObject(param1.target);
         _loc3_ = _loc2_.parent.getChildIndex(_loc2_);
         _loc4_ = getOptimumColumns();
         if(!_loc4_[_loc3_].resizable)
         {
            return;
         }
         _loc5_ = getStyle("stretchCursor");
         this.resizeCursorID = cursorManager.setCursor(_loc5_,CursorManagerPriority.HIGH);
      }
      
      private function columnResizeMouseOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         if(!enabled || !this.resizableColumns)
         {
            return;
         }
         _loc2_ = DisplayObject(param1.target);
         _loc3_ = _loc2_.parent.getChildIndex(_loc2_);
         _loc4_ = getOptimumColumns();
         if(!_loc4_[_loc3_].resizable)
         {
            return;
         }
         cursorManager.removeCursor(this.resizeCursorID);
      }
      
      private function columnResizeMouseDownHandler(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:IListItemRenderer = null;
         var _loc6_:DisplayObject = null;
         var _loc8_:Point = null;
         if(!enabled || !this.resizableColumns)
         {
            return;
         }
         _loc2_ = DisplayObject(param1.target);
         _loc3_ = _loc2_.parent.getChildIndex(_loc2_);
         if(lockedColumnCount > 0 && _loc2_.parent == UIComponent(this.getLines().getChildByName("header")))
         {
            _loc3_ = _loc3_ + (lockedColumnCount - 1);
         }
         _loc4_ = getOptimumColumns();
         if(!_loc4_[_loc3_].resizable)
         {
            return;
         }
         if(this.itemEditorInstance)
         {
            this.endEdit(AdvancedDataGridEventReason.OTHER);
         }
         this.startX = DisplayObject(param1.target).x;
         this.lastPt = new Point(param1.stageX,param1.stageY);
         this.lastPt = listContent.globalToLocal(this.lastPt);
         this.resizingColumn = _loc4_[_loc3_];
         _loc5_ = this.getHeaderInfo(_loc4_[_loc3_]).headerItem;
         if(_loc3_ > lockedColumnCount)
         {
            this.minX = this.getAdjustedXPos(_loc5_.x);
            this.startX = this.getAdjustedXPos(this.startX);
         }
         else
         {
            this.minX = _loc5_.x;
         }
         this.minX = this.minX + this.resizingColumn.minWidth;
         isPressed = true;
         _loc6_ = systemManager.getSandboxRoot();
         _loc6_.addEventListener(MouseEvent.MOUSE_MOVE,this.columnResizingHandler,true);
         _loc6_.addEventListener(MouseEvent.MOUSE_UP,this.columnResizeMouseUpHandler,true);
         _loc6_.addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE,this.columnResizeMouseUpHandler);
         systemManager.deployMouseShields(true);
         var _loc7_:Class = getStyle("columnResizeSkin");
         this.resizeGraphic = new _loc7_();
         listContent.addChild(DisplayObject(this.resizeGraphic));
         _loc8_ = new Point(param1.stageX,param1.stageY);
         _loc8_ = listContent.globalToLocal(_loc8_);
         this.resizeGraphic.move(_loc8_.x,_loc2_.y);
         this.resizeGraphic.setActualSize(this.resizeGraphic.measuredWidth,unscaledHeight - _loc2_.y);
      }
      
      private function columnResizingHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Point = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         if(!MouseEvent(param1).buttonDown)
         {
            this.columnResizeMouseUpHandler(param1);
            return;
         }
         _loc2_ = !!verticalScrollBar?int(verticalScrollBar.width):0;
         _loc3_ = new Point(param1.stageX,param1.stageY);
         _loc3_ = listContent.globalToLocal(_loc3_);
         this.lastPt = _loc3_;
         _loc4_ = 0;
         if(this.lockedSeparators && this.lockedSeparators.length > 0)
         {
            _loc4_ = this.lockedSeparators[0].width;
         }
         else if(this.separators && this.separators.length > 0)
         {
            _loc4_ = this.separators[0].width;
         }
         _loc5_ = unscaledWidth - _loc4_ - _loc2_;
         if(getOptimumColumns() == visibleColumns)
         {
            _loc6_ = this.absoluteToVisibleColumnIndex(this.resizingColumn.colNum);
         }
         else
         {
            _loc6_ = this.absoluteToDisplayColumnIndex(this.resizingColumn.colNum);
         }
         this.resizeGraphic.move(Math.min(Math.max(this.minX,_loc3_.x),_loc5_),this.resizeGraphic.y);
      }
      
      private function columnResizeMouseUpHandler(param1:Event) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:AdvancedDataGridColumn = null;
         var _loc4_:int = 0;
         var _loc5_:MouseEvent = null;
         var _loc6_:Point = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:AdvancedDataGridEvent = null;
         if(!enabled || !this.resizableColumns)
         {
            return;
         }
         isPressed = false;
         _loc2_ = systemManager.getSandboxRoot();
         _loc2_.removeEventListener(MouseEvent.MOUSE_MOVE,this.columnResizingHandler,true);
         _loc2_.removeEventListener(MouseEvent.MOUSE_UP,this.columnResizeMouseUpHandler,true);
         _loc2_.removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE,this.columnResizeMouseUpHandler);
         systemManager.deployMouseShields(false);
         listContent.removeChild(DisplayObject(this.resizeGraphic));
         cursorManager.removeCursor(this.resizeCursorID);
         _loc3_ = this.resizingColumn;
         this.resizingColumn = null;
         _loc4_ = !!verticalScrollBar?int(verticalScrollBar.width):0;
         _loc5_ = param1 as MouseEvent;
         if(_loc5_)
         {
            _loc6_ = new Point(_loc5_.stageX,_loc5_.stageY);
            _loc6_ = listContent.globalToLocal(_loc6_);
         }
         else
         {
            _loc6_ = this.lastPt;
         }
         _loc7_ = 0;
         if(this.lockedSeparators && this.lockedSeparators.length > 0)
         {
            _loc7_ = this.lockedSeparators[0].width;
         }
         else if(this.separators && this.separators.length > 0)
         {
            _loc7_ = this.separators[0].width;
         }
         _loc8_ = unscaledWidth - _loc7_ - _loc4_;
         _loc9_ = Math.min(Math.max(this.minX,_loc6_.x),_loc8_) - this.startX;
         this.resizeColumn(_loc3_.colNum,Math.floor(_loc3_.width + _loc9_));
         _loc10_ = new AdvancedDataGridEvent(AdvancedDataGridEvent.COLUMN_STRETCH);
         _loc10_.columnIndex = _loc3_.colNum;
         _loc10_.dataField = _loc3_.dataField;
         _loc10_.localX = _loc6_.x;
         dispatchEvent(_loc10_);
      }
      
      private function editorMouseDownHandler(param1:Event) : void
      {
         if(param1 is MouseEvent && owns(DisplayObject(param1.target)))
         {
            return;
         }
         this.endEdit(AdvancedDataGridEventReason.OTHER);
      }
      
      protected function editorKeyDownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ESCAPE)
         {
            this.endEdit(AdvancedDataGridEventReason.CANCELLED);
         }
         else if(param1.ctrlKey && param1.charCode == 46)
         {
            this.endEdit(AdvancedDataGridEventReason.CANCELLED);
         }
         else if(param1.charCode == Keyboard.ENTER && param1.keyCode != 229)
         {
            if(this.columns[this._editedItemPosition.columnIndex].editorUsesEnterKey)
            {
               return;
            }
            if(this.endEdit(AdvancedDataGridEventReason.NEW_ROW) && !this.dontEdit)
            {
               this.findNextEnterItemRenderer(param1);
            }
         }
      }
      
      private function editorStageResizeHandler(param1:Event) : void
      {
         if(param1.target is DisplayObjectContainer && DisplayObjectContainer(param1.target).contains(this))
         {
            this.endEdit(AdvancedDataGridEventReason.OTHER);
         }
      }
      
      private function mouseFocusChangeHandler(param1:MouseEvent) : void
      {
         if(this.itemEditorInstance && !param1.isDefaultPrevented() && itemRendererContains(this.itemEditorInstance,DisplayObject(param1.target)))
         {
            param1.preventDefault();
         }
      }
      
      private function keyFocusChangeHandler(param1:FocusEvent) : void
      {
         if(param1.keyCode == Keyboard.TAB && !param1.isDefaultPrevented() && this.findNextItemRenderer(param1.shiftKey))
         {
            param1.preventDefault();
         }
      }
      
      private function itemEditorFocusOutHandler(param1:FocusEvent) : void
      {
         if(param1.relatedObject && contains(param1.relatedObject))
         {
            return;
         }
         if(!param1.relatedObject)
         {
            return;
         }
         if(this.itemEditorInstance)
         {
            this.endEdit(AdvancedDataGridEventReason.OTHER);
         }
      }
      
      private function itemEditorItemEditBeginningHandler(param1:AdvancedDataGridEvent) : void
      {
         if(!param1.isDefaultPrevented())
         {
            this.setEditedItemPosition({
               "columnIndex":param1.columnIndex,
               "rowIndex":param1.rowIndex
            });
         }
         else if(!this.itemEditorInstance)
         {
            this._editedItemPosition = null;
            setFocus();
         }
      }
      
      private function itemEditorItemEditBeginHandler(param1:AdvancedDataGridEvent) : void
      {
         var _loc2_:IFocusManager = null;
         if(root)
         {
            systemManager.addEventListener(Event.DEACTIVATE,this.deactivateHandler,false,0,true);
         }
         if(!param1.isDefaultPrevented() && listItems[this.actualRowIndex][this.actualColIndex].data != null)
         {
            this.createItemEditor(param1.columnIndex,param1.rowIndex);
            if(this.editedItemRenderer is IDropInListItemRenderer && this.itemEditorInstance is IDropInListItemRenderer)
            {
               IDropInListItemRenderer(this.itemEditorInstance).listData = IDropInListItemRenderer(this.editedItemRenderer).listData;
            }
            if(!this.columns[param1.columnIndex].rendererIsEditor)
            {
               this.itemEditorInstance.data = this.editedItemRenderer.data;
            }
            if(this.itemEditorInstance is IInvalidating)
            {
               IInvalidating(this.itemEditorInstance).validateNow();
            }
            if(this.itemEditorInstance is IIMESupport)
            {
               IIMESupport(this.itemEditorInstance).imeMode = this.columns[param1.columnIndex].imeMode == null?this._imeMode:this.columns[param1.columnIndex].imeMode;
            }
            _loc2_ = focusManager;
            if(this.itemEditorInstance is IFocusManagerComponent)
            {
               _loc2_.setFocus(IFocusManagerComponent(this.itemEditorInstance));
            }
            _loc2_.defaultButtonEnabled = false;
            param1 = new AdvancedDataGridEvent(AdvancedDataGridEvent.ITEM_FOCUS_IN);
            param1.columnIndex = this._editedItemPosition.columnIndex;
            param1.rowIndex = this._editedItemPosition.rowIndex;
            param1.itemRenderer = this.itemEditorInstance;
            dispatchEvent(param1);
         }
      }
      
      private function itemEditorItemEditEndHandler(param1:AdvancedDataGridEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:Object = null;
         var _loc6_:String = null;
         var _loc7_:XML = null;
         var _loc8_:AdvancedDataGridListData = null;
         var _loc9_:IFocusManager = null;
         if(!param1.isDefaultPrevented())
         {
            _loc2_ = false;
            if(param1.reason == AdvancedDataGridEventReason.NEW_COLUMN)
            {
               if(!this.collectionUpdatesDisabled)
               {
                  collection.disableAutoUpdate();
                  this.collectionUpdatesDisabled = true;
               }
            }
            else if(this.collectionUpdatesDisabled)
            {
               collection.enableAutoUpdate();
               this.collectionUpdatesDisabled = false;
            }
            if(this.itemEditorInstance && param1.reason != AdvancedDataGridEventReason.CANCELLED)
            {
               _loc3_ = this.itemEditorInstance[_columns[param1.columnIndex].editorDataField];
               _loc4_ = _columns[param1.columnIndex].dataField;
               _loc5_ = param1.itemRenderer.data;
               _loc6_ = "";
               for each(_loc7_ in describeType(_loc5_).variable)
               {
                  if(_loc4_ == _loc7_.@name.toString())
                  {
                     _loc6_ = _loc7_.@type.toString();
                     break;
                  }
               }
               if(_loc6_ == "String")
               {
                  if(!(_loc3_ is String))
                  {
                     _loc3_ = _loc3_.toString();
                  }
               }
               else if(_loc6_ == "uint")
               {
                  if(!(_loc3_ is uint))
                  {
                     _loc3_ = uint(_loc3_);
                  }
               }
               else if(_loc6_ == "int")
               {
                  if(!(_loc3_ is int))
                  {
                     _loc3_ = int(_loc3_);
                  }
               }
               else if(_loc6_ == "Number")
               {
                  if(!(_loc3_ is int))
                  {
                     _loc3_ = Number(_loc3_);
                  }
               }
               if(_loc5_[_loc4_] != _loc3_)
               {
                  _loc2_ = true;
                  _loc5_[_loc4_] = _loc3_;
               }
               if(_loc2_ && !(_loc5_ is IPropertyChangeNotifier))
               {
                  collection.itemUpdated(_loc5_,_loc4_);
               }
               if(param1.itemRenderer is IDropInListItemRenderer)
               {
                  _loc8_ = AdvancedDataGridListData(IDropInListItemRenderer(param1.itemRenderer).listData);
                  _loc8_.label = _columns[param1.columnIndex].itemToLabel(_loc5_);
                  IDropInListItemRenderer(param1.itemRenderer).listData = _loc8_;
               }
               param1.itemRenderer.data = _loc5_;
            }
         }
         else if(param1.reason != AdvancedDataGridEventReason.OTHER)
         {
            if(this.itemEditorInstance && this._editedItemPosition)
            {
               if(selectedIndex != this._editedItemPosition.rowIndex)
               {
                  selectedIndex = this._editedItemPosition.rowIndex;
               }
               _loc9_ = focusManager;
               if(this.itemEditorInstance is IFocusManagerComponent)
               {
                  _loc9_.setFocus(IFocusManagerComponent(this.itemEditorInstance));
               }
            }
         }
         if(param1.reason == AdvancedDataGridEventReason.OTHER || !param1.isDefaultPrevented())
         {
            this.destroyItemEditor();
         }
      }
      
      protected function headerReleaseHandler(param1:AdvancedDataGridEvent) : void
      {
         var _loc2_:AdvancedDataGridEvent = null;
         var _loc3_:MouseEvent = null;
         if(!param1.isDefaultPrevented())
         {
            if(this.itemEditorInstance)
            {
               this.endEdit(AdvancedDataGridEventReason.OTHER);
            }
            _loc2_ = new AdvancedDataGridEvent(AdvancedDataGridEvent.SORT,false,true);
            _loc2_.columnIndex = param1.columnIndex;
            _loc2_.dataField = param1.dataField;
            _loc2_.triggerEvent = param1.triggerEvent;
            if(param1.triggerEvent)
            {
               _loc3_ = param1.triggerEvent as MouseEvent;
               if(_loc3_)
               {
                  _loc2_.multiColumnSort = _loc3_.ctrlKey;
                  _loc2_.removeColumnFromSort = _loc3_.shiftKey;
               }
            }
            dispatchEvent(_loc2_);
         }
      }
      
      protected function sortHandler(param1:AdvancedDataGridEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:Sort = null;
         _loc2_ = param1.dataField;
         _loc3_ = param1.columnIndex;
         if(!this.sortableColumns || !this.columns[_loc3_].sortable)
         {
            return;
         }
         if(_loc2_ == null)
         {
            _loc2_ = itemToUID(this.columns[_loc3_]);
         }
         if(!param1.multiColumnSort)
         {
            if(collection.sort && collection.sort.fields.length == 1 && (_loc2_ && this.findSortField(_loc2_) > -1))
            {
               if(this.sortExpertMode == true)
               {
                  this.sortDirection = this.flipSortOrder(_loc2_,_loc3_,collection);
               }
            }
            else
            {
               collection.sort = null;
               this.addSortField(_loc2_,_loc3_,collection);
            }
         }
         else if(param1.removeColumnFromSort)
         {
            this.removeSortField(_loc2_,_loc3_,collection);
         }
         else if(this.findSortField(_loc2_) == -1)
         {
            this.addSortField(_loc2_,_loc3_,collection);
         }
         else if(this.findSortField(_loc2_) > -1)
         {
            if(collection.sort.fields.length == 1)
            {
               this.sortDirection = this.flipSortOrder(_loc2_,_loc3_,collection);
            }
            else
            {
               this.flipSortOrder(_loc2_,_loc3_,collection);
               this.sortDirection = null;
            }
         }
         collection.refresh();
         if(this.headerIndex != -1)
         {
            this.selectedHeaderInfo = this.getHeaderInfo(this.columns[param1.columnIndex]);
            this.headerIndex = param1.columnIndex;
            this.selectColumnHeader(this.headerIndex);
         }
         this.invalidateHeaders();
      }
      
      private function deactivateHandler(param1:Event) : void
      {
         if(this.itemEditorInstance)
         {
            this.endEdit(AdvancedDataGridEventReason.OTHER);
            this.losingFocus = true;
            setFocus();
         }
      }
      
      protected function headerNavigationHandler(param1:KeyboardEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:AdvancedDataGridEvent = null;
         if(this.headerIndex == -1)
         {
            return;
         }
         _loc2_ = mapKeycodeForLayoutDirection(param1);
         if(_loc2_ == Keyboard.DOWN)
         {
            this.unselectColumnHeader(this.headerIndex,true);
            this.headerIndex = -1;
         }
         else if(_loc2_ == Keyboard.LEFT)
         {
            _loc3_ = this.viewDisplayableColumnAtOffset(this.headerIndex,-1);
            if(_loc3_ != -1)
            {
               this.unselectColumnHeader(this.headerIndex);
               this.selectedHeaderInfo = this.getHeaderInfo(this.columns[_loc3_]);
               this.headerIndex = _loc3_;
               this.selectColumnHeader(this.headerIndex);
            }
         }
         else if(_loc2_ == Keyboard.RIGHT)
         {
            _loc3_ = this.viewDisplayableColumnAtOffset(this.headerIndex,1);
            if(_loc3_ != -1)
            {
               this.unselectColumnHeader(this.headerIndex);
               this.selectedHeaderInfo = this.getHeaderInfo(this.columns[_loc3_]);
               this.headerIndex = _loc3_;
               this.selectColumnHeader(this.headerIndex);
            }
         }
         else if(_loc2_ == Keyboard.SPACE)
         {
            if(this.sortableColumns && this.columns[this.headerIndex].sortable)
            {
               this.isKeyPressed = true;
               this.selectedHeaderInfo = this.getHeaderInfo(this.columns[this.headerIndex]);
               this.selectColumnHeader(this.headerIndex);
               _loc4_ = new AdvancedDataGridEvent(AdvancedDataGridEvent.SORT,false,true);
               _loc4_.columnIndex = this.headerIndex;
               _loc4_.dataField = this.columns[this.headerIndex].dataField;
               _loc4_.multiColumnSort = param1.ctrlKey;
               _loc4_.removeColumnFromSort = param1.shiftKey;
               dispatchEvent(_loc4_);
            }
         }
         else if(param1.shiftKey && (_loc2_ == Keyboard.PAGE_UP || _loc2_ == Keyboard.PAGE_DOWN))
         {
            this.moveSelectionHorizontally(_loc2_,param1.shiftKey,param1.ctrlKey);
         }
         param1.stopPropagation();
      }
   }
}
