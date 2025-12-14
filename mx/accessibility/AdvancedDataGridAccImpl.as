package mx.accessibility
{
   import flash.accessibility.Accessibility;
   import flash.events.Event;
   import mx.collections.CursorBookmark;
   import mx.collections.ICollectionView;
   import mx.collections.IHierarchicalCollectionView;
   import mx.collections.IViewCursor;
   import mx.controls.AdvancedDataGrid;
   import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
   import mx.controls.advancedDataGridClasses.AdvancedDataGridHeaderInfo;
   import mx.controls.advancedDataGridClasses.SortInfo;
   import mx.controls.listClasses.IListItemRenderer;
   import mx.core.UIComponent;
   import mx.core.mx_internal;
   import mx.events.AdvancedDataGridEvent;
   
   use namespace mx_internal;
   
   public class AdvancedDataGridAccImpl extends ListBaseAccImpl
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
      
      private static var accessibilityHooked:Boolean = hookAccessibility();
      
      private static const ROLE_SYSTEM_LISTITEM:uint = 34;
      
      private static const ROLE_SYSTEM_OUTLINEITEM:uint = 36;
      
      private static const STATE_SYSTEM_COLLAPSED:uint = 1024;
      
      private static const STATE_SYSTEM_EXPANDED:uint = 512;
      
      private static const STATE_SYSTEM_FOCUSED:uint = 4;
      
      private static const STATE_SYSTEM_INVISIBLE:uint = 32768;
      
      private static const STATE_SYSTEM_OFFSCREEN:uint = 65536;
      
      private static const STATE_SYSTEM_SELECTABLE:uint = 2097152;
      
      private static const STATE_SYSTEM_SELECTED:uint = 2;
      
      private static const EVENT_OBJECT_FOCUS:uint = 32773;
      
      private static const EVENT_OBJECT_SELECTION:uint = 32774;
      
      private static const EVENT_OBJECT_STATECHANGE:uint = 32778;
       
      
      public function AdvancedDataGridAccImpl(param1:UIComponent)
      {
         super(param1);
         var _loc2_:AdvancedDataGrid = AdvancedDataGrid(param1);
         role = this.getRole(_loc2_);
      }
      
      private static function hookAccessibility() : Boolean
      {
         AdvancedDataGrid.createAccessibilityImplementation = createAccessibilityImplementation;
         return true;
      }
      
      mx_internal static function createAccessibilityImplementation(param1:UIComponent) : void
      {
         param1.accessibilityImplementation = new AdvancedDataGridAccImpl(param1);
      }
      
      public static function enableAccessibility() : void
      {
      }
      
      override protected function get eventsToHandle() : Array
      {
         return super.eventsToHandle.concat(["change",AdvancedDataGridEvent.ITEM_OPEN,AdvancedDataGridEvent.ITEM_CLOSE,AdvancedDataGridEvent.ITEM_FOCUS_IN]);
      }
      
      override public function get_accRole(param1:uint) : uint
      {
         var _loc3_:Object = null;
         var _loc2_:AdvancedDataGrid = AdvancedDataGrid(master);
         if(param1 == 0)
         {
            role = this.getRole(_loc2_);
            return role;
         }
         if(_loc2_.headerIndex != -1)
         {
            return 25;
         }
         if(_loc2_.selectionMode == "singleCell")
         {
            _loc3_ = _loc2_.selectedCells[0];
            if(_loc3_)
            {
               if(_loc2_.dataProvider is IHierarchicalCollectionView && _loc3_.columnIndex == _loc2_.treeColumn.colNum)
               {
                  return ROLE_SYSTEM_OUTLINEITEM;
               }
               return ROLE_SYSTEM_LISTITEM;
            }
         }
         if(_loc2_.dataProvider is IHierarchicalCollectionView)
         {
            return ROLE_SYSTEM_OUTLINEITEM;
         }
         return ROLE_SYSTEM_LISTITEM;
      }
      
      override public function get_accValue(param1:uint) : String
      {
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         var _loc6_:Object = null;
         var _loc2_:* = "";
         var _loc5_:AdvancedDataGrid = AdvancedDataGrid(master);
         if(param1 != 0 && _loc5_.dataProvider is IHierarchicalCollectionView)
         {
            _loc4_ = param1 - 1;
            if(_loc5_.selectionMode == "singleCell" || _loc5_.editable.length != 0)
            {
               _loc4_ = Math.floor(_loc4_ / _loc5_.columns.length);
            }
            _loc3_ = this.getItemAt(_loc4_);
            if(_loc3_ == null)
            {
               return _loc2_;
            }
            _loc2_ = _loc5_.getItemDepth(_loc3_,_loc4_ - _loc5_.verticalScrollPosition) + "";
         }
         return _loc2_;
      }
      
      override public function get_accState(param1:uint) : uint
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Object = null;
         var _loc8_:IHierarchicalCollectionView = null;
         var _loc9_:Object = null;
         var _loc10_:IListItemRenderer = null;
         var _loc2_:AdvancedDataGrid = AdvancedDataGrid(master);
         var _loc3_:uint = getState(param1);
         if(param1 > 0)
         {
            if(_loc2_.headerIndex != -1)
            {
               _loc3_ = _loc3_ | (STATE_SYSTEM_SELECTABLE | STATE_SYSTEM_SELECTED | STATE_SYSTEM_FOCUSED);
               return _loc3_;
            }
            _loc6_ = param1 - 1;
            if(_loc2_.editable.length == 0 || _loc2_.editedItemPosition == null)
            {
               _loc4_ = _loc6_;
               if(_loc2_.selectionMode == "singleCell")
               {
                  _loc7_ = _loc2_.selectedCells[0];
                  if(_loc7_)
                  {
                     _loc4_ = _loc7_.rowIndex;
                  }
               }
               if(_loc4_ < _loc2_.verticalScrollPosition || _loc4_ >= _loc2_.verticalScrollPosition + _loc2_.rowCount)
               {
                  _loc3_ = _loc3_ | (STATE_SYSTEM_OFFSCREEN | STATE_SYSTEM_INVISIBLE);
               }
               else
               {
                  _loc3_ = _loc3_ | STATE_SYSTEM_SELECTABLE;
                  _loc10_ = _loc2_.itemToItemRenderer(this.getItemAt(_loc4_));
                  if(_loc2_.dataProvider is IHierarchicalCollectionView)
                  {
                     _loc8_ = IHierarchicalCollectionView(_loc2_.dataProvider);
                     _loc9_ = this.getItemAt(_loc4_);
                     if(_loc9_ && _loc8_.source.canHaveChildren(_loc9_))
                     {
                        if(_loc2_.selectionMode != "singleCell" || _loc7_ && _loc7_.columnIndex == _loc2_.treeColumn.colNum)
                        {
                           if(_loc2_.isItemOpen(_loc9_))
                           {
                              _loc3_ = _loc3_ | STATE_SYSTEM_EXPANDED;
                           }
                           else
                           {
                              _loc3_ = _loc3_ | STATE_SYSTEM_COLLAPSED;
                           }
                        }
                     }
                  }
                  if(_loc2_.selectionMode == "singleCell")
                  {
                     _loc4_ = Math.floor(_loc6_ / _loc2_.columns.length);
                     _loc5_ = _loc6_ % _loc2_.columns.length;
                     if(_loc7_ && _loc7_.rowIndex == _loc4_ && _loc7_.columnIndex == _loc5_)
                     {
                        _loc3_ = _loc3_ | (STATE_SYSTEM_SELECTED | STATE_SYSTEM_FOCUSED);
                     }
                  }
                  else if(_loc10_ && _loc2_.isItemSelected(_loc10_.data))
                  {
                     _loc3_ = _loc3_ | (STATE_SYSTEM_SELECTED | STATE_SYSTEM_FOCUSED);
                  }
               }
            }
            else
            {
               _loc4_ = Math.floor(_loc6_ / _loc2_.columns.length);
               _loc5_ = _loc6_ % _loc2_.columns.length;
               if(_loc4_ < 0 || _loc5_ < 0)
               {
                  _loc7_ = _loc2_.editedItemPosition;
                  if(_loc7_)
                  {
                     _loc4_ = _loc7_.rowIndex;
                     _loc5_ = _loc7_.columnIndex;
                  }
                  else
                  {
                     _loc4_ = 0;
                     _loc5_ = 0;
                  }
               }
               if(_loc2_.selectionMode == "singleCell")
               {
                  _loc7_ = _loc2_.selectedCells[0];
               }
               if(_loc4_ < _loc2_.verticalScrollPosition || _loc4_ >= _loc2_.verticalScrollPosition + _loc2_.rowCount)
               {
                  _loc3_ = _loc3_ | (STATE_SYSTEM_OFFSCREEN | STATE_SYSTEM_INVISIBLE);
               }
               else if(_loc2_.columns[_loc5_].editable)
               {
                  _loc3_ = _loc3_ | STATE_SYSTEM_SELECTABLE;
                  _loc7_ = _loc2_.editedItemPosition;
                  if(_loc2_.dataProvider is IHierarchicalCollectionView)
                  {
                     _loc8_ = IHierarchicalCollectionView(_loc2_.dataProvider);
                     _loc9_ = this.getItemAt(_loc6_);
                     if(_loc9_ && _loc8_.source.canHaveChildren(_loc9_))
                     {
                        if(_loc2_.selectionMode != "singleCell" || _loc7_ && _loc7_.columnIndex == 0)
                        {
                           if(_loc2_.isItemOpen(_loc9_))
                           {
                              _loc3_ = _loc3_ | STATE_SYSTEM_EXPANDED;
                           }
                           else
                           {
                              _loc3_ = _loc3_ | STATE_SYSTEM_COLLAPSED;
                           }
                        }
                     }
                  }
                  if(_loc7_ && _loc7_.rowIndex == _loc4_ && _loc7_.columnIndex == _loc5_)
                  {
                     _loc3_ = _loc3_ | (STATE_SYSTEM_SELECTED | STATE_SYSTEM_FOCUSED);
                  }
               }
            }
         }
         return _loc3_;
      }
      
      override public function get_accDefaultAction(param1:uint) : String
      {
         var _loc2_:AdvancedDataGrid = AdvancedDataGrid(master);
         var _loc3_:int = param1 - 1;
         var _loc4_:int = _loc3_;
         var _loc5_:int = 0;
         if(_loc2_.selectionMode == "singleCell")
         {
            _loc4_ = Math.floor(_loc3_ / _loc2_.columns.length);
            _loc5_ = _loc3_ % _loc2_.columns.length;
         }
         if(param1 == 0)
         {
            return null;
         }
         if(_loc2_.headerIndex != -1)
         {
            return "Click";
         }
         if(!(_loc2_.dataProvider is IHierarchicalCollectionView) || _loc5_ != _loc2_.treeColumn.colNum)
         {
            return super.get_accDefaultAction(param1);
         }
         var _loc6_:Object = this.getItemAt(_loc4_);
         if(!_loc6_)
         {
            return null;
         }
         var _loc7_:IHierarchicalCollectionView = IHierarchicalCollectionView(_loc2_.dataProvider);
         if(_loc7_.source.canHaveChildren(_loc6_))
         {
            return !!_loc2_.isItemOpen(_loc6_)?"Collapse":"Expand";
         }
         return "Double Click";
      }
      
      override public function accDoDefaultAction(param1:uint) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:AdvancedDataGridEvent = null;
         var _loc7_:Object = null;
         var _loc8_:IHierarchicalCollectionView = null;
         var _loc2_:AdvancedDataGrid = AdvancedDataGrid(master);
         if(param1 > 0)
         {
            _loc3_ = param1 - 1;
            _loc4_ = _loc3_;
            _loc5_ = 0;
            if(_loc2_.selectionMode == "singleCell")
            {
               _loc4_ = Math.floor(_loc3_ / _loc2_.columns.length);
               _loc5_ = _loc3_ % _loc2_.columns.length;
            }
            if(_loc2_.headerIndex != -1)
            {
               _loc6_ = new AdvancedDataGridEvent(AdvancedDataGridEvent.SORT,false,true);
               _loc6_.columnIndex = _loc2_.headerIndex;
               _loc6_.dataField = _loc2_.columns[_loc2_.headerIndex].dataField;
               _loc6_.multiColumnSort = false;
               _loc6_.removeColumnFromSort = false;
               _loc2_.dispatchEvent(_loc6_);
               return;
            }
            if(_loc2_.dataProvider is IHierarchicalCollectionView && _loc5_ == 0)
            {
               if(_loc2_.selectionMode == "singleCell")
               {
                  _loc3_ = _loc4_;
               }
               _loc7_ = this.getItemAt(_loc3_);
               if(_loc7_ == null)
               {
                  return;
               }
               _loc8_ = IHierarchicalCollectionView(_loc2_.dataProvider);
               if(_loc8_.source.canHaveChildren(_loc7_))
               {
                  _loc2_.expandItem(_loc7_,!_loc2_.isItemOpen(_loc7_));
                  return;
               }
            }
            if(_loc2_.editable.length == 0)
            {
               if(_loc2_.selectionMode == "singleCell")
               {
                  _loc2_.selectedCells = [{
                     "rowIndex":_loc4_,
                     "columnIndex":_loc5_
                  }];
               }
               else
               {
                  _loc2_.selectedIndex = _loc3_;
               }
            }
            else
            {
               _loc2_.editedItemPosition = {
                  "rowIndex":_loc4_,
                  "columnIndex":_loc5_
               };
            }
         }
      }
      
      override public function getChildIDArray() : Array
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:Array = [];
         var _loc2_:AdvancedDataGrid = AdvancedDataGrid(master);
         if(_loc2_.dataProvider)
         {
            _loc3_ = 0;
            if((_loc2_.editedItemPosition == null || _loc2_.editable.length == 0) && _loc2_.selectionMode != "singleCell")
            {
               _loc3_ = _loc2_.dataProvider.length;
            }
            else
            {
               _loc3_ = _loc2_.columns.length * _loc2_.dataProvider.length;
            }
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc1_[_loc4_] = _loc4_ + 1;
               _loc4_++;
            }
         }
         return _loc1_;
      }
      
      override public function accLocation(param1:uint) : *
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         var _loc2_:AdvancedDataGrid = AdvancedDataGrid(master);
         var _loc3_:int = param1 - 1;
         if(_loc2_.headerIndex != -1)
         {
            return _loc2_.selectedHeaderInfo.headerItem;
         }
         if(_loc2_.editable.length == 0 || _loc2_.editedItemPosition == null)
         {
            if(_loc2_.selectionMode == "singleCell" && _loc2_.selectedCells.length > 0)
            {
               _loc6_ = _loc2_.selectedCells[0];
               if(_loc6_)
               {
                  _loc4_ = _loc6_.rowIndex;
                  _loc5_ = _loc6_.columnIndex;
               }
            }
            else
            {
               _loc4_ = _loc3_;
               _loc5_ = 0;
            }
            if(_loc4_ < _loc2_.verticalScrollPosition || _loc4_ >= _loc2_.verticalScrollPosition + _loc2_.rowCount)
            {
               return null;
            }
            return _loc2_.indicesToItemRenderer(_loc4_ - _loc2_.verticalScrollPosition,_loc5_);
         }
         _loc4_ = Math.floor(_loc3_ / _loc2_.columns.length);
         _loc5_ = _loc3_ % _loc2_.columns.length;
         if(_loc4_ < _loc2_.verticalScrollPosition || _loc4_ >= _loc2_.verticalScrollPosition + _loc2_.rowCount)
         {
            return null;
         }
         return _loc2_.indicesToItemRenderer(_loc4_ - _loc2_.verticalScrollPosition,_loc5_);
      }
      
      override public function get_accSelection() : Array
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         var _loc6_:Array = null;
         var _loc1_:AdvancedDataGrid = AdvancedDataGrid(master);
         var _loc2_:Array = [];
         if(_loc1_.editable.length > 0 && _loc1_.editedItemPosition != null)
         {
            _loc5_ = _loc1_.editedItemPosition;
            if(!_loc5_)
            {
               return _loc2_;
            }
            _loc2_[0] = _loc1_.columns.length * _loc5_.rowIndex + _loc5_.columnIndex + 1;
         }
         else if(_loc1_.selectionMode == "singleCell")
         {
            _loc3_ = _loc1_.selectedCells.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_ = _loc1_.selectedCells[_loc4_];
               _loc2_[_loc4_] = _loc1_.columns.length * _loc5_.rowIndex + _loc5_.columnIndex + 1;
               _loc4_++;
            }
         }
         else
         {
            _loc6_ = AdvancedDataGrid(master).selectedIndices;
            _loc3_ = _loc6_.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_[_loc4_] = _loc6_[_loc4_] + 1;
               _loc4_++;
            }
         }
         return _loc2_;
      }
      
      override public function get_accFocus() : uint
      {
         var _loc2_:uint = 0;
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:AdvancedDataGrid = AdvancedDataGrid(master);
         if(_loc1_.headerIndex != -1)
         {
            if(_loc1_.selectionMode == "singleCell")
            {
               _loc2_ = _loc1_.columns.length * _loc1_.dataProvider.length + _loc1_.headerIndex + 1;
            }
            else
            {
               _loc2_ = _loc1_.dataProvider.length + _loc1_.headerIndex + 1;
            }
            return _loc2_;
         }
         if(_loc1_.editable.length == 0)
         {
            if(_loc1_.selectionMode == "singleCell" && _loc1_.selectedCells.length > 0)
            {
               _loc3_ = _loc1_.selectedCells[0];
               if(_loc3_)
               {
                  _loc2_ = _loc1_.columns.length * _loc3_.rowIndex + _loc3_.columnIndex + 1;
               }
            }
            else
            {
               _loc2_ = _loc1_.selectedIndex;
            }
            return _loc2_ >= 0?uint(_loc2_ + 1):uint(0);
         }
         _loc3_ = _loc1_.editedItemPosition;
         if(_loc3_ == null)
         {
            return 0;
         }
         _loc4_ = _loc3_.rowIndex;
         _loc5_ = _loc3_.columnIndex;
         return _loc1_.columns.length * _loc4_ + _loc5_ + 1;
      }
      
      override public function accSelect(param1:uint, param2:uint) : void
      {
         var _loc3_:AdvancedDataGrid = AdvancedDataGrid(master);
         var _loc4_:uint = param2 - 1;
         if(_loc4_ >= 0 && _loc4_ < _loc3_.dataProvider.length)
         {
            _loc3_.selectedIndex = _loc4_;
         }
      }
      
      override protected function getName(param1:uint) : String
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Object = null;
         var _loc9_:Array = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:Boolean = false;
         var _loc13_:String = null;
         var _loc14_:Object = null;
         var _loc15_:String = null;
         var _loc16_:String = null;
         var _loc17_:IHierarchicalCollectionView = null;
         var _loc18_:String = null;
         var _loc19_:String = null;
         var _loc2_:AdvancedDataGrid = AdvancedDataGrid(master);
         if(param1 != 0 && _loc2_.headerIndex != -1)
         {
            _loc4_ = this.getValueForHeader(_loc2_);
            return _loc4_;
         }
         if(param1 == 0 || param1 > 100000)
         {
            return "";
         }
         var _loc3_:int = 0;
         if(_loc2_.editable.length == 0 || _loc2_.editedItemPosition == null)
         {
            if(_loc2_.selectionMode == "singleCell")
            {
               _loc3_ = _loc2_.dataProvider.length * _loc2_.columns.length;
            }
            else
            {
               _loc3_ = _loc2_.dataProvider.length;
            }
         }
         else if(_loc2_.editable.length != 0)
         {
            _loc3_ = _loc2_.dataProvider.length * _loc2_.columns.length;
         }
         if(param1 > _loc3_)
         {
            return "";
         }
         if(param1 > 0)
         {
            _loc5_ = param1 - 1;
            _loc12_ = true;
            if(_loc2_.editable.length == 0 || _loc2_.editedItemPosition == null)
            {
               _loc6_ = _loc5_;
               _loc13_ = ", Row " + (_loc6_ + 1);
               _loc8_ = this.getItemAt(_loc5_);
               if(_loc8_ is String)
               {
                  _loc4_ = " " + _loc8_;
               }
               else
               {
                  _loc4_ = "";
                  _loc9_ = _loc2_.columns;
                  if(_loc2_.selectionMode == "singleCell")
                  {
                     _loc6_ = Math.floor(_loc5_ / _loc2_.columns.length);
                     _loc7_ = _loc5_ % _loc2_.columns.length;
                     if(_loc6_ < 0 || _loc7_ < 0)
                     {
                        _loc14_ = _loc2_.selectedCells[0];
                        if(_loc14_)
                        {
                           _loc6_ = _loc14_.rowIndex;
                           _loc7_ = _loc14_.columnIndex;
                        }
                        else
                        {
                           return "";
                        }
                     }
                     _loc13_ = ", Row " + (_loc6_ + 1);
                     _loc8_ = this.getItemAt(_loc6_);
                     if(_loc7_ != 0)
                     {
                        _loc12_ = false;
                        _loc13_ = "";
                     }
                     _loc4_ = _loc4_ + (_loc9_[_loc7_].headerText + ": " + _loc9_[_loc7_].itemToLabel(_loc8_));
                  }
                  else
                  {
                     _loc10_ = _loc9_.length;
                     _loc11_ = 0;
                     while(_loc11_ < _loc10_)
                     {
                        if(_loc11_ > 0)
                        {
                           _loc4_ = _loc4_ + ",";
                        }
                        _loc4_ = _loc4_ + (" " + _loc9_[_loc11_].headerText + ": " + _loc9_[_loc11_].itemToLabel(_loc8_));
                        _loc11_++;
                     }
                  }
               }
            }
            else
            {
               _loc6_ = Math.floor(_loc5_ / _loc2_.columns.length);
               _loc7_ = _loc5_ % _loc2_.columns.length;
               if(_loc6_ < 0 || _loc7_ < 0)
               {
                  _loc14_ = _loc2_.editedItemPosition;
                  if(_loc14_)
                  {
                     _loc6_ = _loc14_.rowIndex;
                     _loc7_ = _loc14_.columnIndex;
                  }
                  else
                  {
                     return "";
                  }
               }
               _loc13_ = ", Row " + (_loc6_ + 1);
               if(_loc7_ != 0)
               {
                  _loc12_ = false;
                  _loc13_ = "";
               }
               _loc8_ = this.getItemAt(_loc6_);
               if(_loc8_ is String)
               {
                  _loc4_ = " " + _loc8_;
               }
               else
               {
                  _loc9_ = _loc2_.columns;
                  _loc15_ = _loc9_[_loc7_].itemToLabel(_loc8_);
                  _loc16_ = _loc9_[_loc7_].headerText;
                  _loc4_ = "";
                  _loc10_ = _loc9_.length;
                  _loc11_ = 0;
                  while(_loc11_ < _loc10_)
                  {
                     if(_loc11_ > 0)
                     {
                        _loc4_ = _loc4_ + ",";
                     }
                     _loc4_ = _loc4_ + (" " + _loc9_[_loc11_].headerText + ": " + _loc9_[_loc11_].itemToLabel(_loc8_));
                     _loc11_++;
                  }
                  _loc4_ = _loc4_ + (", Editing " + _loc16_ + ": " + _loc15_);
               }
            }
            if(_loc2_.dataProvider is IHierarchicalCollectionView)
            {
               _loc17_ = IHierarchicalCollectionView(_loc2_.dataProvider);
               _loc18_ = "";
               _loc19_ = this.getMOfN(_loc8_);
               if(_loc8_ && _loc17_.source.canHaveChildren(_loc8_))
               {
                  if(_loc12_)
                  {
                     _loc18_ = ". Press control shift right arrow to open, control shift left arrow to close";
                     if(_loc2_.editable.length == 0)
                     {
                        _loc4_ = _loc4_ + (_loc19_ + _loc18_);
                     }
                     else
                     {
                        _loc4_ = _loc4_ + _loc19_;
                     }
                  }
                  else
                  {
                     _loc4_ = _loc4_ + _loc13_;
                  }
               }
               else if(_loc12_)
               {
                  _loc4_ = _loc4_ + _loc19_;
               }
            }
            else
            {
               _loc4_ = _loc4_ + _loc13_;
            }
         }
         return _loc4_;
      }
      
      override protected function eventHandler(param1:Event) : void
      {
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         $eventHandler(param1);
         var _loc2_:AdvancedDataGrid = AdvancedDataGrid(master);
         switch(param1.type)
         {
            case "change":
               _loc6_ = false;
               if(_loc2_.headerIndex != -1)
               {
                  if(_loc2_.selectionMode == "singleCell")
                  {
                     _loc5_ = _loc2_.columns.length * _loc2_.dataProvider.length + _loc2_.headerIndex + 1;
                  }
                  else
                  {
                     _loc5_ = _loc2_.dataProvider.length + _loc2_.headerIndex + 1;
                  }
                  _loc6_ = true;
               }
               if(!_loc6_ && (_loc2_.editable.length == 0 || _loc2_.editedItemPosition == null))
               {
                  _loc4_ = _loc2_.selectedIndex;
                  if(_loc2_.selectionMode == "singleCell")
                  {
                     _loc3_ = _loc2_.selectedCells[0];
                     if(_loc3_)
                     {
                        _loc5_ = _loc2_.columns.length * _loc3_.rowIndex + _loc3_.columnIndex + 1;
                        _loc6_ = true;
                     }
                  }
                  else if(_loc4_ >= 0)
                  {
                     _loc5_ = _loc4_ + 1;
                     _loc6_ = true;
                  }
               }
               if(_loc6_)
               {
                  Accessibility.sendEvent(_loc2_,_loc5_,EVENT_OBJECT_FOCUS);
                  Accessibility.sendEvent(_loc2_,_loc5_,EVENT_OBJECT_SELECTION);
               }
               break;
            case AdvancedDataGridEvent.ITEM_FOCUS_IN:
               if(_loc2_.editable.length != 0 && _loc2_.editedItemPosition != null)
               {
                  _loc7_ = AdvancedDataGridEvent(param1).rowIndex;
                  _loc8_ = AdvancedDataGridEvent(param1).columnIndex;
                  Accessibility.sendEvent(_loc2_,_loc2_.columns.length * _loc7_ + _loc8_ + 1,EVENT_OBJECT_FOCUS);
                  Accessibility.sendEvent(_loc2_,_loc2_.columns.length * _loc7_ + _loc8_ + 1,EVENT_OBJECT_SELECTION);
               }
               break;
            case AdvancedDataGridEvent.ITEM_OPEN:
            case AdvancedDataGridEvent.ITEM_CLOSE:
               if(_loc2_.selectionMode == "singleCell")
               {
                  _loc3_ = _loc2_.selectedCells[0];
                  if(_loc3_)
                  {
                     _loc4_ = _loc3_.rowIndex;
                  }
               }
               else
               {
                  _loc4_ = _loc2_.selectedIndex;
               }
               if(_loc4_ >= 0)
               {
                  Accessibility.sendEvent(master,_loc4_ + 1,EVENT_OBJECT_STATECHANGE);
               }
         }
      }
      
      private function getItemAt(param1:int) : Object
      {
         var _loc2_:IViewCursor = AdvancedDataGrid(master).collectionIterator;
         _loc2_.seek(CursorBookmark.FIRST,param1);
         return _loc2_.current;
      }
      
      private function getMOfN(param1:Object) : String
      {
         var _loc7_:ICollectionView = null;
         var _loc8_:IViewCursor = null;
         if(!param1)
         {
            return "";
         }
         var _loc2_:AdvancedDataGrid = AdvancedDataGrid(master);
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:IHierarchicalCollectionView = IHierarchicalCollectionView(_loc2_.dataProvider);
         var _loc6_:Object = _loc2_.getParentItem(param1);
         if(_loc6_ != null)
         {
            _loc7_ = _loc5_.getChildren(_loc6_);
            if(_loc7_)
            {
               _loc4_ = _loc7_.length;
               _loc3_ = 0;
               while(_loc3_ < _loc4_)
               {
                  if(param1 == _loc7_[_loc3_])
                  {
                     break;
                  }
                  _loc3_++;
               }
            }
         }
         else
         {
            _loc8_ = ICollectionView(_loc2_.collectionIterator.view).createCursor();
            while(!_loc8_.afterLast)
            {
               if(param1 == _loc8_.current)
               {
                  _loc3_ = _loc4_;
               }
               _loc4_++;
               _loc8_.moveNext();
            }
         }
         if(_loc3_ == _loc4_)
         {
            _loc3_ = 0;
         }
         if(_loc4_ > 0)
         {
            _loc3_++;
         }
         return ", " + _loc3_ + " of " + _loc4_;
      }
      
      private function getValueForHeader(param1:AdvancedDataGrid) : String
      {
         var _loc2_:String = null;
         var _loc6_:String = null;
         var _loc8_:String = null;
         var _loc10_:* = null;
         var _loc3_:AdvancedDataGridHeaderInfo = param1.selectedHeaderInfo;
         var _loc4_:AdvancedDataGridColumn = _loc3_.column;
         var _loc5_:SortInfo = param1.getFieldSortInfo(_loc4_);
         var _loc7_:String = "ascending";
         if(_loc5_)
         {
            _loc8_ = _loc5_.sequenceNumber == -1?null:", sort order " + _loc5_.sequenceNumber;
            if(_loc5_.descending)
            {
               _loc6_ = "descending";
            }
            else
            {
               _loc6_ = "ascending";
               _loc7_ = "descending";
            }
         }
         var _loc9_:* = (!!_loc6_?" sorted " + _loc6_:"") + (!!_loc8_?_loc8_:"") + " Press space to sort " + _loc7_ + " on this field. " + " Press control space to add this field to sort";
         _loc2_ = _loc4_.headerText + ": Column " + (param1.headerIndex + 1);
         if(param1.columnGrouping)
         {
            _loc10_ = "";
            if(_loc3_.children)
            {
               _loc10_ = ", spans " + _loc3_.columnSpan + " columns";
               _loc2_ = _loc2_ + _loc10_;
            }
            else
            {
               _loc2_ = _loc2_ + _loc9_;
            }
         }
         else
         {
            _loc2_ = _loc2_ + _loc9_;
         }
         return _loc2_;
      }
      
      private function getRole(param1:AdvancedDataGrid) : uint
      {
         if(param1.dataProvider is IHierarchicalCollectionView)
         {
            return 35;
         }
         return 33;
      }
   }
}
