package mx.controls.advancedDataGridClasses
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   import mx.collections.ArrayCollection;
   import mx.collections.CursorBookmark;
   import mx.collections.ItemResponder;
   import mx.collections.errors.ChildItemPendingError;
   import mx.collections.errors.ItemPendingError;
   import mx.controls.listClasses.AdvancedListBase;
   import mx.controls.listClasses.AdvancedListBaseContentHolder;
   import mx.controls.listClasses.BaseListData;
   import mx.controls.listClasses.IDropInListItemRenderer;
   import mx.controls.listClasses.IListItemRenderer;
   import mx.controls.listClasses.ListBaseSeekPending;
   import mx.controls.listClasses.ListRowInfo;
   import mx.core.IFactory;
   import mx.core.IFlexModuleFactory;
   import mx.core.IFontContextComponent;
   import mx.core.IInvalidating;
   import mx.core.IUIComponent;
   import mx.core.UIComponentGlobals;
   import mx.core.mx_internal;
   import mx.events.ListEvent;
   import mx.events.ScrollEvent;
   import mx.events.ScrollEventDetail;
   import mx.events.ScrollEventDirection;
   import mx.events.TweenEvent;
   
   use namespace mx_internal;
   
   public class AdvancedDataGridBase extends AdvancedListBase implements IFontContextComponent
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
      
      public static const NONE:String = "none";
      
      public static const SINGLE_ROW:String = "singleRow";
      
      public static const MULTIPLE_ROWS:String = "multipleRows";
      
      public static const SINGLE_CELL:String = "singleCell";
      
      public static const MULTIPLE_CELLS:String = "multipleCells";
       
      
      private var lockedRowCountResetShowHeaders:Boolean = false;
      
      mx_internal var visibleColumns:Array;
      
      mx_internal var listSubContent:AdvancedListBaseContentHolder;
      
      mx_internal var columnsInvalid:Boolean = true;
      
      mx_internal var _explicitHeaderHeight:Boolean;
      
      protected var columnMap:Object;
      
      protected var freeItemRenderersTable:Dictionary;
      
      protected var itemPending:Boolean;
      
      protected var bShiftKey:Boolean = false;
      
      protected var bCtrlKey:Boolean = false;
      
      protected var lastKey:uint = 0;
      
      protected var bSelectItem:Boolean = false;
      
      protected var currentRowHeight:Number;
      
      protected var currentColNum:int;
      
      protected var currentRowNum:int;
      
      protected var currentItemTop:Number;
      
      protected var headerRowInfo:Array;
      
      protected var itemRendererToFactoryMap:Dictionary;
      
      protected var _columns:Array;
      
      protected var headerInfos:Array;
      
      protected var visibleHeaderInfos:Array;
      
      protected var cellsWaitingToBeDisplayed:Boolean = true;
      
      protected var pendingCellSelection:ArrayCollection;
      
      public var headerItems:Array;
      
      protected var _selectionMode:String = "singleRow";
      
      mx_internal var _headerHeight:Number = 22;
      
      private var _headerWordWrap:Boolean;
      
      private var _showHeaders:Boolean = true;
      
      private var _headerRenderer:IFactory;
      
      private var _sortItemRenderer:IFactory;
      
      private var _styleFunction:Function;
      
      public function AdvancedDataGridBase()
      {
         this.headerRowInfo = [];
         this.pendingCellSelection = new ArrayCollection([]);
         this.headerItems = [];
         super();
         listType = "vertical";
         lockedRowCount = 0;
         defaultRowCount = 7;
         this.columnMap = {};
         this.freeItemRenderersTable = new Dictionary(false);
         this.itemRendererToFactoryMap = new Dictionary(true);
      }
      
      public function get fontContext() : IFlexModuleFactory
      {
         return moduleFactory;
      }
      
      public function set fontContext(param1:IFlexModuleFactory) : void
      {
         this.moduleFactory = param1;
      }
      
      public function get selectionMode() : String
      {
         return this._selectionMode;
      }
      
      public function set selectionMode(param1:String) : void
      {
         this.setSelectionMode(param1);
         itemsSizeChanged = true;
         invalidateDisplayList();
      }
      
      [Bindable("resize")]
      public function get headerHeight() : Number
      {
         return this._headerHeight;
      }
      
      public function set headerHeight(param1:Number) : void
      {
         this._headerHeight = param1;
         this._explicitHeaderHeight = true;
         itemsSizeChanged = true;
         invalidateDisplayList();
      }
      
      public function get headerWordWrap() : Boolean
      {
         return this._headerWordWrap;
      }
      
      public function set headerWordWrap(param1:Boolean) : void
      {
         if(param1 == this._headerWordWrap)
         {
            return;
         }
         this._headerWordWrap = param1;
         itemsSizeChanged = true;
         invalidateDisplayList();
         dispatchEvent(new Event("headerWordWrapChanged"));
      }
      
      [Bindable("showHeadersChanged")]
      public function get showHeaders() : Boolean
      {
         return this._showHeaders;
      }
      
      public function set showHeaders(param1:Boolean) : void
      {
         this._showHeaders = param1;
         itemsSizeChanged = true;
         invalidateDisplayList();
         dispatchEvent(new Event("showHeadersChanged"));
      }
      
      mx_internal function get headerVisible() : Boolean
      {
         return this.showHeaders && this.headerHeight > 0;
      }
      
      [Bindable("headerRendererChanged")]
      public function get headerRenderer() : IFactory
      {
         return this._headerRenderer;
      }
      
      public function set headerRenderer(param1:IFactory) : void
      {
         this._headerRenderer = param1;
         invalidateSize();
         invalidateDisplayList();
         itemsSizeChanged = true;
         rendererChanged = true;
         dispatchEvent(new Event("headerRendererChanged"));
      }
      
      [Bindable("sortItemRendererChanged")]
      public function get sortItemRenderer() : IFactory
      {
         return this._sortItemRenderer;
      }
      
      public function set sortItemRenderer(param1:IFactory) : void
      {
         this._sortItemRenderer = param1;
         itemsSizeChanged = true;
         rendererChanged = true;
         invalidateSize();
         invalidateDisplayList();
         dispatchEvent(new Event("sortItemRendererChanged"));
      }
      
      public function get styleFunction() : Function
      {
         return this._styleFunction;
      }
      
      public function set styleFunction(param1:Function) : void
      {
         this._styleFunction = param1;
         invalidateDisplayList();
      }
      
      override protected function makeRowsAndColumns(param1:Number, param2:Number, param3:Number, param4:Number, param5:int, param6:int, param7:Boolean = false, param8:uint = 0) : Point
      {
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:AdvancedDataGridListData = null;
         var _loc13_:int = 0;
         var _loc15_:IListItemRenderer = null;
         var _loc16_:DisplayObject = null;
         var _loc17_:String = null;
         var _loc18_:AdvancedDataGridColumn = null;
         var _loc20_:Array = null;
         this.currentColNum = lockedColumnCount;
         this.currentRowNum = lockedRowCount;
         var _loc14_:int = 0;
         if(!this.visibleColumns || this.visibleColumns.length == 0)
         {
            this.purgeHeaderRenderers();
            this.purgeItemRenderers();
            visibleData = {};
            return new Point(0,0);
         }
         invalidateSizeFlag = true;
         var _loc19_:Boolean = true;
         this.currentItemTop = param2;
         if(param6 <= lockedRowCount)
         {
            this.createHeaders(param1,param2);
            this.createLockedRows(param1,param2,param3,param4);
         }
         else
         {
            this.currentRowNum = param6;
         }
         _loc19_ = iterator != null && !iterator.afterLast && iteratorValid;
         while(!param7 && this.currentItemTop < param4 || param7 && param8 > 0)
         {
            if(param7)
            {
               param8--;
            }
            this.createRow(param1,param2,param3,param4,_loc19_);
            _loc19_ = this.moveIterator(_loc19_);
            _loc14_++;
         }
         if(!param7)
         {
            while(this.currentRowNum < listItems.length)
            {
               _loc20_ = listItems.pop();
               rowInfo.pop();
               while(_loc20_.length)
               {
                  _loc15_ = _loc20_.pop();
                  this.addToFreeItemRenderers(_loc15_);
               }
            }
         }
         invalidateSizeFlag = false;
         return new Point(this.currentColNum,_loc14_);
      }
      
      override protected function purgeItemRenderers() : void
      {
         var _loc1_:IListItemRenderer = null;
         rendererChanged = false;
         while(listItems.length)
         {
            this.currentRowNum = listItems.length - 1;
            while(listItems[this.currentRowNum].length)
            {
               _loc1_ = listItems[this.currentRowNum].pop();
               _loc1_.parent.removeChild(DisplayObject(_loc1_));
            }
            listItems.pop();
         }
         rowMap = {};
         rowInfo = [];
      }
      
      override protected function drawItem(param1:IListItemRenderer, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false) : void
      {
         var _loc10_:IListItemRenderer = null;
         if(!param1)
         {
            return;
         }
         if(rowMap[param1.name] == null)
         {
            return;
         }
         super.drawItem(param1,param2,param3,param4,param5);
         var _loc6_:int = rowMap[param1.name].rowIndex;
         var _loc7_:Array = this.getOptimumColumns();
         var _loc8_:int = _loc7_.length;
         var _loc9_:int = 0;
         while(_loc9_ < _loc8_)
         {
            _loc10_ = listItems[_loc6_][_loc9_];
            this.updateDisplayOfItemRenderer(_loc10_);
            _loc9_++;
         }
      }
      
      override protected function finishKeySelection() : void
      {
         var _loc1_:String = null;
         var _loc4_:IListItemRenderer = null;
         var _loc6_:ListEvent = null;
         var _loc7_:Point = null;
         var _loc2_:int = listItems.length;
         var _loc3_:int = rowInfo[_loc2_ - 1].y + rowInfo[_loc2_ - 1].height > listContent.height?1:0;
         if(this.lastKey == Keyboard.PAGE_DOWN)
         {
            if(lockedRowCount >= _loc2_ - _loc3_ - 1)
            {
               caretIndex = Math.min(verticalScrollPosition + lockedRowCount,collection.length - 1);
            }
            else
            {
               caretIndex = Math.min(verticalScrollPosition + _loc2_ - _loc3_ - 1,collection.length - 1);
            }
         }
         var _loc5_:Boolean = false;
         if(this.bSelectItem && caretIndex - verticalScrollPosition >= 0)
         {
            if(caretIndex - verticalScrollPosition > listItems.length - 1)
            {
               caretIndex = listItems.length - 1 + verticalScrollPosition;
            }
            _loc4_ = listItems[caretIndex - verticalScrollPosition][0];
            if(_loc4_)
            {
               _loc1_ = itemToUID(_loc4_.data);
               _loc4_ = visibleData[_loc1_];
               if(_loc4_)
               {
                  if(this.lastKey == Keyboard.SPACE)
                  {
                     _loc5_ = selectItem(_loc4_,this.bShiftKey,this.bCtrlKey);
                  }
                  else
                  {
                     if(!this.bCtrlKey)
                     {
                        selectItem(_loc4_,this.bShiftKey,this.bCtrlKey);
                        _loc5_ = true;
                     }
                     if(this.bCtrlKey)
                     {
                        this.drawItem(_loc4_,selectedData[_loc1_] != null,_loc1_ == highlightUID,true);
                     }
                  }
               }
            }
         }
         if(_loc5_)
         {
            _loc6_ = new ListEvent(ListEvent.CHANGE);
            _loc6_.itemRenderer = _loc4_;
            _loc7_ = itemRendererToIndices(_loc4_);
            if(_loc7_)
            {
               _loc6_.rowIndex = _loc7_.y;
               _loc6_.columnIndex = _loc7_.x;
            }
            dispatchEvent(_loc6_);
         }
      }
      
      override protected function addToFreeItemRenderers(param1:IListItemRenderer) : void
      {
         var _loc3_:AdvancedDataGridColumn = null;
         var _loc4_:IFactory = null;
         DisplayObject(param1).visible = false;
         delete rowMap[param1.name];
         var _loc2_:String = itemToUID(param1.data);
         if(visibleData[_loc2_] == param1)
         {
            delete visibleData[_loc2_];
         }
         if(this.columnMap[param1.name])
         {
            _loc3_ = this.columnMap[param1.name];
            _loc4_ = this.itemRendererToFactoryMap[param1];
            if(!this.freeItemRenderersTable[_loc3_])
            {
               this.freeItemRenderersTable[_loc3_] = new Dictionary(false);
            }
            if(!this.freeItemRenderersTable[_loc3_][_loc4_])
            {
               this.freeItemRenderersTable[_loc3_][_loc4_] = [];
            }
            this.freeItemRenderersTable[_loc3_][_loc4_].push(param1);
            delete this.columnMap[param1.name];
         }
         else
         {
            param1.parent.removeChild(DisplayObject(param1));
         }
      }
      
      override protected function adjustListContent(param1:Number = -1, param2:Number = -1) : void
      {
         super.adjustListContent(param1,param2);
         this.listSubContent.setActualSize(listContent.width,listContent.height);
      }
      
      override protected function removeIndicators(param1:String) : void
      {
         if(this.isRowSelectionMode())
         {
            super.removeIndicators(param1);
         }
      }
      
      override protected function clearIndicators() : void
      {
         if(this.isRowSelectionMode())
         {
            super.clearIndicators();
         }
      }
      
      override mx_internal function clearHighlight(param1:IListItemRenderer) : void
      {
         if(this.isRowSelectionMode())
         {
            super.clearHighlight(param1);
         }
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         if(!this.listSubContent)
         {
            this.listSubContent = new AdvancedListBaseContentHolder(this);
            this.listSubContent.styleName = this;
            listContent.addChild(this.listSubContent);
         }
      }
      
      protected function createHeaders(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:IListItemRenderer = null;
         var _loc7_:DisplayObject = null;
         var _loc8_:AdvancedDataGridColumn = null;
         var _loc9_:AdvancedDataGridListData = null;
         var _loc10_:int = 0;
         var _loc13_:Array = null;
         var _loc14_:IListItemRenderer = null;
         var _loc15_:IInvalidating = null;
         var _loc11_:int = 0;
         var _loc12_:Number = 0;
         if(!this.headerItems[0] || !this.headerItems[0][0] || param2 < this.headerItems[0][0].y + this.headerItems[0][0].height)
         {
            _loc3_ = param1;
            _loc5_ = 0;
            this.currentRowNum = 0;
            this.currentColNum = 0;
            _loc11_ = this.headerInfos.length;
            _loc10_ = 0;
            while(_loc10_ < _loc11_)
            {
               this.headerInfos[_loc10_].headerItem = null;
               _loc10_++;
            }
            _loc13_ = this.getOptimumColumns();
            while(this.currentColNum < _loc13_.length)
            {
               _loc8_ = _loc13_[this.currentColNum];
               if(!this.headerItems[this.currentRowNum])
               {
                  this.headerItems[this.currentRowNum] = [];
               }
               else if(this.headerItems[this.currentRowNum][this.currentColNum])
               {
                  _loc14_ = this.headerItems[this.currentRowNum][this.currentColNum];
                  this.addHeaderToFreeItemRenderers(_loc14_,_loc14_.data as AdvancedDataGridColumn);
               }
               _loc6_ = this.getHeaderRenderer(_loc8_);
               _loc9_ = AdvancedDataGridListData(this.makeListData(_loc8_,uid,-1,_loc8_.colNum,_loc8_));
               rowMap[_loc6_.name] = _loc9_;
               if(_loc6_ is IDropInListItemRenderer)
               {
                  IDropInListItemRenderer(_loc6_).listData = _loc9_;
               }
               _loc6_.data = _loc8_;
               _loc6_.styleName = _loc8_;
               this.headerItems[this.currentRowNum][this.currentColNum] = _loc6_;
               this.headerInfos[_loc8_.colNum].headerItem = _loc6_;
               _loc6_.explicitWidth = _loc4_ = _loc8_.width;
               UIComponentGlobals.layoutManager.validateClient(_loc6_,true);
               this.currentRowHeight = _loc6_.getExplicitOrMeasuredHeight();
               _loc6_.setActualSize(_loc4_,!!this._explicitHeaderHeight?Number(this._headerHeight - cachedPaddingTop - cachedPaddingBottom):Number(this.currentRowHeight));
               _loc6_.move(_loc3_,this.currentItemTop + cachedPaddingTop);
               _loc3_ = _loc3_ + _loc4_;
               _loc5_ = Math.ceil(Math.max(_loc5_,!!this._explicitHeaderHeight?Number(this._headerHeight):Number(this.currentRowHeight + cachedPaddingBottom + cachedPaddingTop)));
               _loc12_ = Math.max(_loc12_,!!this._explicitHeaderHeight?Number(this._headerHeight - cachedPaddingTop - cachedPaddingBottom):Number(this.currentRowHeight));
               _loc6_.visible = this.headerVisible;
               this.currentColNum++;
            }
            if(this.headerItems[this.currentRowNum])
            {
               _loc11_ = this.headerItems[this.currentRowNum].length;
               _loc10_ = 0;
               while(_loc10_ < _loc11_)
               {
                  this.headerItems[this.currentRowNum][_loc10_].setActualSize(this.headerItems[this.currentRowNum][_loc10_].width,_loc12_);
                  _loc15_ = this.headerItems[this.currentRowNum][_loc10_] as IInvalidating;
                  if(_loc15_)
                  {
                     IInvalidating(_loc15_).invalidateDisplayList();
                  }
                  _loc10_++;
               }
               while(this.headerItems[this.currentRowNum].length > this.currentColNum)
               {
                  _loc7_ = this.headerItems[this.currentRowNum].pop();
                  _loc7_.parent.removeChild(_loc7_);
               }
            }
            this.headerRowInfo[this.currentRowNum] = new ListRowInfo(this.currentItemTop,_loc5_,uid);
            if(this.headerVisible)
            {
               this.currentItemTop = this.currentItemTop + (!!_loc6_?_loc5_:0);
            }
            if(!this._explicitHeaderHeight)
            {
               this._headerHeight = !!_loc6_?Number(_loc5_):Number(0);
            }
         }
      }
      
      protected function createLockedRows(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var i:int = 0;
         var bookmark:CursorBookmark = null;
         var left:Number = param1;
         var top:Number = param2;
         var right:Number = param3;
         var bottom:Number = param4;
         var more:Boolean = true;
         var numLocked:int = lockedRowCount;
         var rowsMade:int = 0;
         if(lockedRowCount > 0 && (!listItems[lockedRowCount - 1] || !listItems[lockedRowCount - 1][0] || top < listItems[lockedRowCount - 1][0].y + listItems[lockedRowCount - 1][0].height))
         {
            this.currentRowNum = 0;
            if(numLocked && iterator)
            {
               bookmark = iterator.bookmark;
               try
               {
                  iterator.seek(CursorBookmark.FIRST);
               }
               catch(e:ItemPendingError)
               {
                  lastSeekPending = new ListBaseSeekPending(CursorBookmark.FIRST,0);
                  e.addResponder(new ItemResponder(seekPendingResultHandler,seekPendingFailureHandler,lastSeekPending));
                  iteratorValid = false;
               }
            }
            more = iterator != null && !iterator.afterLast && iteratorValid;
            i = 0;
            while(i < numLocked)
            {
               this.createRow(left,top,right,bottom,more);
               more = this.moveIterator(more);
               rowsMade++;
               i++;
            }
            if(bookmark)
            {
               try
               {
                  iterator.seek(bookmark,numLocked);
                  return;
               }
               catch(e:ItemPendingError)
               {
                  lastSeekPending = new ListBaseSeekPending(CursorBookmark.CURRENT,0);
                  e.addResponder(new ItemResponder(seekPendingResultHandler,seekPendingFailureHandler,lastSeekPending));
                  iteratorValid = false;
                  return;
               }
            }
         }
      }
      
      protected function purgeHeaderRenderers() : void
      {
         var _loc1_:IListItemRenderer = null;
         var _loc2_:Array = null;
         while(this.headerItems.length)
         {
            _loc2_ = this.headerItems.pop();
            while(_loc2_.length)
            {
               _loc1_ = IListItemRenderer(_loc2_.pop());
               this.addHeaderToFreeItemRenderers(_loc1_,_loc1_.data as AdvancedDataGridColumn);
            }
         }
      }
      
      protected function updateDisplayOfItemRenderer(param1:IListItemRenderer) : void
      {
         var _loc2_:IInvalidating = null;
         if(param1 is IInvalidating)
         {
            _loc2_ = IInvalidating(param1);
            _loc2_.invalidateDisplayList();
            _loc2_.validateNow();
         }
      }
      
      protected function setVisibleDataItem(param1:String, param2:IListItemRenderer) : void
      {
         if(param1 && this.currentColNum == 0)
         {
            visibleData[param1] = param2;
         }
      }
      
      protected function drawVisibleItem(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false) : void
      {
         if(this.isRowSelectionMode())
         {
            if(visibleData[param1])
            {
               this.drawItem(visibleData[param1],param2,param3,param4);
            }
         }
      }
      
      override protected function moveSelectionVertically(param1:uint, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:IListItemRenderer = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc11_:ScrollEvent = null;
         showCaret = true;
         var _loc8_:int = listItems.length;
         if(_loc8_ == 0)
         {
            return;
         }
         var _loc9_:int = 0;
         if(rowInfo[_loc8_ - 1].y + rowInfo[_loc8_ - 1].height > listContent.height)
         {
            _loc9_++;
         }
         var _loc10_:Boolean = false;
         this.bSelectItem = false;
         switch(param1)
         {
            case Keyboard.UP:
               if(caretIndex > 0)
               {
                  caretIndex--;
                  _loc10_ = true;
                  this.bSelectItem = true;
               }
               break;
            case Keyboard.DOWN:
               if(caretIndex < collection.length - 1)
               {
                  caretIndex++;
                  _loc10_ = true;
                  this.bSelectItem = true;
               }
               else if(caretIndex == collection.length - 1 && _loc9_)
               {
                  if(verticalScrollPosition < maxVerticalScrollPosition)
                  {
                     _loc4_ = verticalScrollPosition + 1;
                  }
               }
               break;
            case Keyboard.PAGE_UP:
               if(caretIndex < lockedRowCount)
               {
                  _loc4_ = 0;
                  caretIndex = 0;
               }
               else if(caretIndex > verticalScrollPosition + lockedRowCount && caretIndex < verticalScrollPosition + _loc8_)
               {
                  caretIndex = verticalScrollPosition + lockedRowCount;
               }
               else
               {
                  caretIndex = Math.max(caretIndex - _loc8_ + lockedRowCount,0);
                  _loc4_ = Math.max(caretIndex - lockedRowCount,0);
               }
               this.bSelectItem = true;
               break;
            case Keyboard.PAGE_DOWN:
               if(caretIndex < lockedRowCount)
               {
                  _loc4_ = 0;
               }
               else if(caretIndex >= verticalScrollPosition + lockedRowCount && caretIndex < verticalScrollPosition + _loc8_ - _loc9_ - 1)
               {
                  caretIndex = Math.min(verticalScrollPosition + listItems.length + lockedRowCount,collection.length - 1);
               }
               else if(lockedRowCount >= _loc8_ - _loc9_ - 1)
               {
                  _loc4_ = Math.min(verticalScrollPosition + 1,maxVerticalScrollPosition);
               }
               else
               {
                  _loc4_ = Math.min(caretIndex - lockedRowCount,maxVerticalScrollPosition);
               }
               this.bSelectItem = true;
               break;
            case Keyboard.HOME:
               if(caretIndex > 0)
               {
                  caretIndex = 0;
                  _loc4_ = 0;
                  this.bSelectItem = true;
               }
               break;
            case Keyboard.END:
               if(caretIndex < collection.length - 1)
               {
                  caretIndex = collection.length - 1;
                  _loc4_ = maxVerticalScrollPosition;
                  this.bSelectItem = true;
               }
               break;
            case Keyboard.SPACE:
               _loc10_ = true;
               this.bSelectItem = true;
         }
         if(_loc10_)
         {
            if(caretIndex < lockedRowCount)
            {
               _loc4_ = 0;
            }
            else if(caretIndex < verticalScrollPosition + lockedRowCount)
            {
               _loc4_ = caretIndex - lockedRowCount;
            }
            else if(caretIndex >= verticalScrollPosition + _loc8_ - _loc9_)
            {
               _loc4_ = Math.min(maxVerticalScrollPosition,caretIndex - _loc8_ + _loc9_ + 1);
            }
         }
         if(!isNaN(_loc4_))
         {
            if(verticalScrollPosition != _loc4_)
            {
               _loc11_ = new ScrollEvent(ScrollEvent.SCROLL);
               _loc11_.detail = ScrollEventDetail.THUMB_POSITION;
               _loc11_.direction = ScrollEventDirection.VERTICAL;
               _loc11_.delta = _loc4_ - verticalScrollPosition;
               _loc11_.position = _loc4_;
               verticalScrollPosition = _loc4_;
               dispatchEvent(_loc11_);
            }
            if(!iteratorValid)
            {
               keySelectionPending = true;
               return;
            }
         }
         this.bShiftKey = param2;
         this.bCtrlKey = param3;
         this.lastKey = param1;
         this.finishKeySelection();
      }
      
      protected function addHeaderToFreeItemRenderers(param1:IListItemRenderer, param2:AdvancedDataGridColumn) : void
      {
         DisplayObject(param1).visible = false;
         var _loc3_:IFactory = this.itemRendererToFactoryMap[param1];
         if(!this.freeItemRenderersTable[param2])
         {
            this.freeItemRenderersTable[param2] = new Dictionary(false);
         }
         if(!this.freeItemRenderersTable[param2][_loc3_])
         {
            this.freeItemRenderersTable[param2][_loc3_] = [];
         }
         this.freeItemRenderersTable[param2][_loc3_].push(param1);
      }
      
      protected function makeListData(param1:Object, param2:String, param3:int, param4:int, param5:AdvancedDataGridColumn) : BaseListData
      {
         var _loc6_:String = null;
         if(param1 is AdvancedDataGridColumn)
         {
            return new AdvancedDataGridListData(param5.headerText != null?param5.headerText:param5.dataField,param5.dataField,param4,param2,this,param3);
         }
         _loc6_ = param5.itemToLabel(param1);
         return new AdvancedDataGridListData(_loc6_,param5.dataField,param4,param2,this,param3);
      }
      
      mx_internal function getWidthOfItem(param1:IListItemRenderer, param2:AdvancedDataGridColumn, param3:int) : Number
      {
         return param2.width;
      }
      
      protected function calculateRowHeight(param1:Object, param2:Number, param3:Boolean = false) : Number
      {
         return NaN;
      }
      
      mx_internal function columnItemRenderer(param1:AdvancedDataGridColumn, param2:Boolean, param3:Object) : IListItemRenderer
      {
         var _loc4_:IFactory = this.columnItemRendererFactory(param1,param2,param3);
         var _loc5_:IListItemRenderer = _loc4_.newInstance();
         this.itemRendererToFactoryMap[_loc5_] = _loc4_;
         _loc5_.owner = this;
         return _loc5_;
      }
      
      mx_internal function columnItemRendererFactory(param1:AdvancedDataGridColumn, param2:Boolean, param3:Object) : IFactory
      {
         var _loc4_:IFactory = null;
         if(param2)
         {
            if(param1.headerRenderer)
            {
               _loc4_ = param1.headerRenderer;
            }
            else
            {
               _loc4_ = this.headerRenderer;
            }
         }
         else if(param1.itemRenderer)
         {
            _loc4_ = param1.itemRenderer;
         }
         if(!_loc4_)
         {
            _loc4_ = itemRenderer;
         }
         return _loc4_;
      }
      
      mx_internal function columnHeaderWordWrap(param1:AdvancedDataGridColumn) : Boolean
      {
         if(param1.headerWordWrap == true)
         {
            return true;
         }
         if(param1.headerWordWrap == false)
         {
            return false;
         }
         return this.headerWordWrap;
      }
      
      mx_internal function columnWordWrap(param1:AdvancedDataGridColumn) : Boolean
      {
         if(param1.wordWrap == true)
         {
            return true;
         }
         if(param1.wordWrap == false)
         {
            return false;
         }
         return wordWrap;
      }
      
      override protected function drawHighlightIndicator(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint, param7:IListItemRenderer) : void
      {
         if(this.isRowSelectionMode())
         {
            param4 = unscaledWidth - viewMetrics.left - viewMetrics.right;
         }
         super.drawHighlightIndicator(param1,param2,param3,param4,param5,param6,param7);
      }
      
      override protected function drawCaretIndicator(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint, param7:IListItemRenderer) : void
      {
         if(this.isRowSelectionMode())
         {
            param4 = unscaledWidth - viewMetrics.left - viewMetrics.right;
         }
         super.drawCaretIndicator(param1,param2,param3,param4,param5,param6,param7);
      }
      
      override protected function drawSelectionIndicator(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint, param7:IListItemRenderer) : void
      {
         if(this.isRowSelectionMode())
         {
            param4 = unscaledWidth - viewMetrics.left - viewMetrics.right;
         }
         super.drawSelectionIndicator(param1,param2,param3,param4,param5,param6,param7);
      }
      
      override mx_internal function mouseEventToItemRendererOrEditor(param1:MouseEvent) : IListItemRenderer
      {
         var _loc3_:Point = null;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc2_:DisplayObject = DisplayObject(param1.target);
         if(_loc2_ == listContent)
         {
            _loc3_ = new Point(param1.stageX,param1.stageY);
            _loc3_ = listContent.globalToLocal(_loc3_);
            _loc4_ = rowInfo.length == 0?Number(0):Number(rowInfo[0].y);
            _loc5_ = listItems.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               if(listItems[_loc6_].length)
               {
                  if(_loc3_.y < _loc4_ + rowInfo[_loc6_].height)
                  {
                     _loc7_ = 0;
                     _loc8_ = listItems[_loc6_].length;
                     _loc9_ = 0;
                     while(_loc9_ < _loc8_)
                     {
                        if(_loc3_.x < _loc7_ + this.visibleColumns[_loc9_].width)
                        {
                           return listItems[_loc6_][_loc9_];
                        }
                        _loc7_ = _loc7_ + this.visibleColumns[_loc9_].width;
                        _loc9_++;
                     }
                  }
               }
               _loc4_ = _loc4_ + rowInfo[_loc6_].height;
               _loc6_++;
            }
         }
         else if(_loc2_ == highlightIndicator)
         {
            return lastHighlightItemRenderer;
         }
         while(_loc2_ && _loc2_ != this)
         {
            if(_loc2_ is IListItemRenderer && (_loc2_.parent == this.listSubContent || _loc2_.parent == listContent))
            {
               if(_loc2_.visible)
               {
                  return IListItemRenderer(_loc2_);
               }
               break;
            }
            if(_loc2_ is IUIComponent)
            {
               _loc2_ = IUIComponent(_loc2_).owner;
            }
            else
            {
               _loc2_ = _loc2_.parent;
            }
         }
         return null;
      }
      
      mx_internal function get gridColumnMap() : Object
      {
         return this.columnMap;
      }
      
      private function createRow(param1:Number, param2:Number, param3:Number, param4:Number, param5:Boolean) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:AdvancedDataGridColumn = null;
         var _loc12_:IListItemRenderer = null;
         var _loc13_:AdvancedDataGridListData = null;
         var _loc14_:IListItemRenderer = null;
         var _loc18_:Object = null;
         var _loc20_:Array = null;
         var _loc21_:Object = null;
         var _loc22_:Number = NaN;
         var _loc15_:* = false;
         var _loc16_:* = false;
         var _loc17_:* = false;
         var _loc19_:String = null;
         if(this.itemPending)
         {
            _loc20_ = this.getOptimumColumns();
            _loc21_ = {};
            _loc10_ = _loc20_.length;
            _loc9_ = 0;
            while(_loc9_ < _loc10_)
            {
               _loc21_[AdvancedDataGridColumn(_loc20_[_loc9_]).dataField] = "Data Loading";
               _loc9_++;
            }
            _loc18_ = _loc21_;
         }
         else
         {
            _loc18_ = !!param5?iterator.current:null;
         }
         _loc6_ = param1;
         _loc8_ = 0;
         this.currentColNum = 0;
         if(!listItems[this.currentRowNum])
         {
            listItems[this.currentRowNum] = [];
         }
         if(param5)
         {
            _loc19_ = itemToUID(_loc18_);
            this.setupRenderer(_loc18_,_loc19_);
         }
         else
         {
            _loc8_ = this.currentRowNum > 1?Number(rowInfo[this.currentRowNum - 1].height):Number(rowHeight);
         }
         _loc8_ = this.layoutRow(param5,param1,_loc8_);
         while(listItems[this.currentRowNum].length > this.currentColNum)
         {
            _loc14_ = listItems[this.currentRowNum].pop();
            this.addToFreeItemRenderers(_loc14_);
         }
         if(param5 && variableRowHeight)
         {
            _loc8_ = Math.ceil(this.calculateRowHeight(_loc18_,_loc8_,true));
         }
         if(listItems[this.currentRowNum])
         {
            _loc22_ = _loc8_ - cachedPaddingTop - cachedPaddingBottom;
            _loc10_ = listItems[this.currentRowNum].length;
            _loc9_ = 0;
            while(_loc9_ < _loc10_)
            {
               listItems[this.currentRowNum][_loc9_].setActualSize(listItems[this.currentRowNum][_loc9_].width,_loc22_);
               _loc9_++;
            }
         }
         if(cachedVerticalAlign != "top")
         {
            if(cachedVerticalAlign == "bottom")
            {
               _loc9_ = 0;
               while(_loc9_ < this.currentColNum)
               {
                  _loc12_ = listItems[this.currentRowNum][_loc9_];
                  _loc12_.move(_loc12_.x,this.currentItemTop + _loc8_ - cachedPaddingBottom - _loc12_.getExplicitOrMeasuredHeight());
                  _loc9_++;
               }
            }
            else
            {
               _loc9_ = 0;
               while(_loc9_ < this.currentColNum)
               {
                  _loc12_ = listItems[this.currentRowNum][_loc9_];
                  _loc12_.move(_loc12_.x,this.currentItemTop + cachedPaddingTop + (_loc8_ - cachedPaddingBottom - cachedPaddingTop - _loc12_.getExplicitOrMeasuredHeight()) / 2);
                  _loc9_++;
               }
            }
         }
         _loc15_ = selectedData[_loc19_] != null;
         _loc16_ = highlightUID == _loc19_;
         _loc17_ = caretUID == _loc19_;
         rowInfo[this.currentRowNum] = new ListRowInfo(this.currentItemTop,_loc8_,_loc19_);
         if(param5)
         {
            this.drawVisibleItem(_loc19_,_loc15_,_loc16_,_loc17_);
         }
         if(_loc8_ == 0)
         {
            _loc8_ = rowHeight;
         }
         this.currentItemTop = this.currentItemTop + _loc8_;
         this.currentRowNum++;
      }
      
      private function moveIterator(param1:Boolean) : Boolean
      {
         var more:Boolean = param1;
         if(this.itemPending)
         {
            this.itemPending = false;
            return true;
         }
         if(iterator && more)
         {
            try
            {
               more = iterator.moveNext();
            }
            catch(e:ChildItemPendingError)
            {
               itemPending = true;
            }
            catch(e:ItemPendingError)
            {
               lastSeekPending = new ListBaseSeekPending(CursorBookmark.CURRENT,0);
               e.addResponder(new ItemResponder(seekPendingResultHandler,seekPendingFailureHandler,lastSeekPending));
               more = false;
               iteratorValid = false;
            }
         }
         return more;
      }
      
      protected function layoutRow(param1:Boolean, param2:Number, param3:Number) : Number
      {
         var _loc5_:IListItemRenderer = null;
         var _loc6_:AdvancedDataGridColumn = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Array = null;
         var _loc4_:Number = 0;
         if(param1)
         {
            this.currentColNum = 0;
            _loc8_ = this.currentItemTop + cachedPaddingTop;
            _loc9_ = cachedPaddingTop + cachedPaddingBottom;
            _loc10_ = this.getOptimumColumns();
            while(this.currentColNum < _loc10_.length)
            {
               _loc6_ = _loc10_[this.currentColNum];
               _loc5_ = listItems[this.currentRowNum][this.currentColNum];
               _loc7_ = this.getWidthOfItem(_loc5_,_loc6_,this.currentColNum);
               _loc5_.explicitWidth = _loc7_;
               if(_loc5_ is IInvalidating && (wordWrapChanged || variableRowHeight))
               {
                  IInvalidating(_loc5_).invalidateSize();
               }
               UIComponentGlobals.layoutManager.validateClient(_loc5_,true);
               this.currentRowHeight = _loc5_.getExplicitOrMeasuredHeight();
               _loc4_ = this.getRowHeight(_loc5_.data);
               _loc5_.setActualSize(_loc7_,!!variableRowHeight?Number(this.currentRowHeight):Number(_loc4_ - cachedPaddingTop - cachedPaddingBottom));
               _loc5_.move(param2,_loc8_);
               param2 = param2 + _loc6_.width;
               if(variableRowHeight && _loc5_.visible)
               {
                  param3 = Math.ceil(Math.max(param3,!!variableRowHeight?Number(this.currentRowHeight + _loc9_):Number(_loc4_)));
               }
               this.currentColNum++;
            }
         }
         if(!variableRowHeight)
         {
            param3 = _loc4_ != 0?Number(_loc4_):Number(this.getRowHeight());
         }
         return param3;
      }
      
      protected function getRowHeight(param1:Object = null) : Number
      {
         return rowHeight;
      }
      
      protected function getHeaderRenderer(param1:AdvancedDataGridColumn) : IListItemRenderer
      {
         var _loc2_:IListItemRenderer = null;
         var _loc3_:IFactory = this.columnItemRendererFactory(param1,true,null);
         if(this.freeItemRenderersTable[param1] && this.freeItemRenderersTable[param1][_loc3_] && this.freeItemRenderersTable[param1][_loc3_].length)
         {
            _loc2_ = this.freeItemRenderersTable[param1][_loc3_].pop();
         }
         else
         {
            _loc2_ = this.columnItemRenderer(param1,true,null);
            this.addRendererToContentArea(_loc2_,param1);
         }
         return _loc2_;
      }
      
      mx_internal function getRenderer(param1:AdvancedDataGridColumn, param2:Object, param3:Boolean = false) : IListItemRenderer
      {
         var _loc4_:IListItemRenderer = null;
         var _loc5_:IFactory = this.columnItemRendererFactory(param1,false,param2);
         if(this.freeItemRenderersTable[param1] && this.freeItemRenderersTable[param1][_loc5_] && this.freeItemRenderersTable[param1][_loc5_].length)
         {
            _loc4_ = this.freeItemRenderersTable[param1][_loc5_].pop();
         }
         else
         {
            _loc4_ = this.columnItemRenderer(param1,false,param2);
            _loc4_.styleName = param1;
         }
         return _loc4_;
      }
      
      protected function setupRenderer(param1:Object, param2:String, param3:Boolean = false) : void
      {
         var _loc4_:AdvancedDataGridColumn = null;
         var _loc5_:IListItemRenderer = null;
         var _loc6_:AdvancedDataGridListData = null;
         var _loc7_:Array = [];
         var _loc8_:Array = this.getOptimumColumns();
         while(this.currentColNum < _loc8_.length)
         {
            _loc4_ = _loc8_[this.currentColNum];
            if(param3)
            {
               _loc5_ = this.getRenderer(_loc4_,param1);
               this.addRendererToContentArea(_loc5_,_loc4_);
               this.columnMap[_loc5_.name] = _loc4_;
            }
            else
            {
               _loc5_ = listItems[this.currentRowNum][this.currentColNum];
               if(!_loc5_ || itemToUID(_loc5_.data) != param2 || this.columnMap[_loc5_.name] != _loc4_)
               {
                  _loc5_ = this.getRenderer(_loc4_,param1);
                  this.addRendererToContentArea(_loc5_,_loc4_);
                  this.columnMap[_loc5_.name] = _loc4_;
                  if(listItems[this.currentRowNum][this.currentColNum])
                  {
                     this.addToFreeItemRenderers(listItems[this.currentRowNum][this.currentColNum]);
                  }
                  listItems[this.currentRowNum][this.currentColNum] = _loc5_;
               }
            }
            _loc6_ = AdvancedDataGridListData(this.makeListData(param1,param2,this.currentRowNum,_loc4_.colNum,_loc4_));
            rowMap[_loc5_.name] = _loc6_;
            if(_loc5_ is IDropInListItemRenderer)
            {
               IDropInListItemRenderer(_loc5_).listData = !!param1?_loc6_:null;
            }
            _loc5_.data = param1;
            _loc5_.visible = true;
            this.setVisibleDataItem(param2,_loc5_);
            _loc7_[this.currentColNum] = _loc5_;
            this.currentColNum++;
         }
         if(param3)
         {
            listItems.splice(this.currentRowNum,0,_loc7_);
         }
      }
      
      protected function isRowSelectionMode() : Boolean
      {
         return this.selectionMode == SINGLE_ROW || this.selectionMode == MULTIPLE_ROWS;
      }
      
      protected function isCellSelectionMode() : Boolean
      {
         return this.selectionMode == SINGLE_CELL || this.selectionMode == MULTIPLE_CELLS;
      }
      
      protected function setSelectionMode(param1:String) : void
      {
         if(this.selectionMode == param1)
         {
            return;
         }
         if(param1 == NONE)
         {
            selectable = false;
         }
         else if(!selectable)
         {
            selectable = true;
         }
         if(param1 == SINGLE_ROW || param1 == SINGLE_CELL)
         {
            if(allowMultipleSelection)
            {
               allowMultipleSelection = false;
            }
         }
         else if(param1 == MULTIPLE_ROWS || param1 == MULTIPLE_CELLS)
         {
            if(!allowMultipleSelection)
            {
               allowMultipleSelection = true;
            }
         }
         else if(param1 != NONE)
         {
            param1 = SINGLE_ROW;
            if(allowMultipleSelection)
            {
               allowMultipleSelection = false;
            }
         }
         this.clearAllSelection();
         this._selectionMode = param1;
      }
      
      protected function selectionTween_updateHandler(param1:TweenEvent) : void
      {
         Sprite(param1.target.listener).alpha = Number(param1.value);
      }
      
      protected function selectionTween_endHandler(param1:TweenEvent) : void
      {
         this.selectionTween_updateHandler(param1);
      }
      
      protected function onSelectionTweenUpdate(param1:Number) : void
      {
      }
      
      protected function addRendererToContentArea(param1:IListItemRenderer, param2:AdvancedDataGridColumn) : void
      {
         if(param2.colNum < lockedColumnCount)
         {
            if(param1.parent != listContent)
            {
               listContent.addChild(DisplayObject(param1));
            }
         }
         else if(param1.parent != this.listSubContent)
         {
            this.listSubContent.addChild(DisplayObject(param1));
         }
      }
      
      protected function getOptimumColumns() : Array
      {
         return this.visibleColumns;
      }
      
      protected function clearAllSelection() : void
      {
         if(this.isRowSelectionMode())
         {
            clearSelected();
            this.clearIndicators();
         }
      }
   }
}
