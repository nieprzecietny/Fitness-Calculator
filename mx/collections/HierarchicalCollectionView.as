package mx.collections
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import flash.xml.XMLNode;
   import mx.collections.errors.ItemPendingError;
   import mx.core.EventPriority;
   import mx.core.mx_internal;
   import mx.events.CollectionEvent;
   import mx.events.CollectionEventKind;
   import mx.events.PropertyChangeEvent;
   import mx.utils.IXMLNotifiable;
   import mx.utils.UIDUtil;
   import mx.utils.XMLNotifier;
   
   use namespace mx_internal;
   
   public class HierarchicalCollectionView extends EventDispatcher implements IHierarchicalCollectionView, IXMLNotifiable
   {
      
      mx_internal static const VERSION:String = "4.1.0.16076";
       
      
      private var hierarchicalData:IHierarchicalData;
      
      private var cursor:HierarchicalCollectionViewCursor;
      
      private var currentLength:int;
      
      private var parentNode:XML;
      
      private var childrenMap:Dictionary;
      
      private var childrenMapCache:Dictionary;
      
      mx_internal var treeData:ICollectionView;
      
      mx_internal var parentMap:Object;
      
      private var _hasRoot:Boolean;
      
      private var _openNodes:Object;
      
      private var _showRoot:Boolean = true;
      
      private var _filterFunction:Function;
      
      private var _sort:Sort;
      
      public function HierarchicalCollectionView(param1:IHierarchicalData = null, param2:Object = null)
      {
         this.childrenMapCache = new Dictionary(true);
         super();
         if(param1)
         {
            this.initializeCollection(param1.getRoot(),param1,param2);
         }
      }
      
      public function get hasRoot() : Boolean
      {
         return this._hasRoot;
      }
      
      public function get openNodes() : Object
      {
         return this._openNodes;
      }
      
      public function set openNodes(param1:Object) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:CollectionEvent = null;
         if(param1)
         {
            this._openNodes = {};
            for each(_loc2_ in param1)
            {
               this._openNodes[UIDUtil.getUID(_loc2_)] = _loc2_;
            }
         }
         else
         {
            this._openNodes = {};
         }
         if(this.hierarchicalData)
         {
            this.currentLength = this.calculateLength();
            _loc3_ = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
            _loc3_.kind = CollectionEventKind.REFRESH;
            dispatchEvent(_loc3_);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get showRoot() : Boolean
      {
         return this._showRoot;
      }
      
      private function set _338884225showRoot(param1:Boolean) : void
      {
         var _loc2_:CollectionEvent = null;
         if(this._showRoot != param1)
         {
            this._showRoot = param1;
            if(this.hierarchicalData)
            {
               this.initializeCollection(this.hierarchicalData.getRoot(),this.hierarchicalData,this.openNodes);
               _loc2_ = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
               _loc2_.kind = CollectionEventKind.RESET;
               dispatchEvent(_loc2_);
            }
         }
      }
      
      public function get source() : IHierarchicalData
      {
         return this.hierarchicalData;
      }
      
      public function set source(param1:IHierarchicalData) : void
      {
         this.initializeCollection(param1.getRoot(),param1,this.openNodes);
      }
      
      [Bindable("filterFunctionChanged")]
      public function get filterFunction() : Function
      {
         return this._filterFunction;
      }
      
      public function set filterFunction(param1:Function) : void
      {
         this._filterFunction = param1;
      }
      
      public function get length() : int
      {
         return this.currentLength;
      }
      
      [Bindable("sortChanged")]
      public function get sort() : Sort
      {
         return this._sort;
      }
      
      public function set sort(param1:Sort) : void
      {
         this._sort = param1;
      }
      
      public function createCursor() : IViewCursor
      {
         return new HierarchicalCollectionViewCursor(this,this.treeData,this.hierarchicalData);
      }
      
      public function contains(param1:Object) : Boolean
      {
         var item:Object = param1;
         var cursor:IViewCursor = this.createCursor();
         while(!cursor.afterLast)
         {
            if(cursor.current == item)
            {
               return true;
            }
            try
            {
               cursor.moveNext();
            }
            catch(e:ItemPendingError)
            {
               return false;
            }
         }
         return false;
      }
      
      public function disableAutoUpdate() : void
      {
         var _loc1_:* = null;
         this.treeData.disableAutoUpdate();
         for(_loc1_ in this.childrenMap)
         {
            ICollectionView(this.childrenMap[_loc1_]).disableAutoUpdate();
         }
      }
      
      public function enableAutoUpdate() : void
      {
         var _loc1_:* = null;
         this.treeData.enableAutoUpdate();
         for(_loc1_ in this.childrenMap)
         {
            ICollectionView(this.childrenMap[_loc1_]).enableAutoUpdate();
         }
      }
      
      public function itemUpdated(param1:Object, param2:Object = null, param3:Object = null, param4:Object = null) : void
      {
         var _loc5_:CollectionEvent = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
         _loc5_.kind = CollectionEventKind.UPDATE;
         var _loc6_:PropertyChangeEvent = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
         _loc6_.source = param1;
         _loc6_.property = param2;
         _loc6_.oldValue = param3;
         _loc6_.newValue = param4;
         _loc5_.items.push(_loc6_);
         dispatchEvent(_loc5_);
      }
      
      public function refresh() : Boolean
      {
         return this.internalRefresh(true);
      }
      
      public function getNodeDepth(param1:Object) : int
      {
         var _loc2_:int = 1;
         var _loc3_:Object = this.getParentItem(param1);
         while(_loc3_ != null)
         {
            _loc3_ = this.getParentItem(_loc3_);
            _loc2_++;
         }
         _loc2_ = this.hasRoot && !this.showRoot?int(_loc2_ - 1):int(_loc2_);
         return _loc2_ < 1?1:int(_loc2_);
      }
      
      public function getParentItem(param1:Object) : *
      {
         var _loc2_:String = UIDUtil.getUID(param1);
         if(this.parentMap.hasOwnProperty(_loc2_))
         {
            return this.parentMap[_loc2_];
         }
         return undefined;
      }
      
      public function getChildren(param1:Object) : ICollectionView
      {
         var _loc6_:Array = null;
         var _loc2_:String = UIDUtil.getUID(param1);
         var _loc3_:* = this.hierarchicalData.getChildren(param1);
         var _loc4_:ICollectionView = this.childrenMapCache[_loc2_];
         if(_loc3_ is XMLList && _loc4_)
         {
            XMLListCollection(_loc4_).dispatchResetEvent = false;
            XMLListCollection(_loc4_).source = _loc3_;
            _loc4_.refresh();
         }
         if(_loc4_)
         {
            this.childrenMap[param1] = _loc4_;
            return _loc4_;
         }
         if(!_loc3_)
         {
            return null;
         }
         if(_loc3_ is ICollectionView)
         {
            _loc4_ = ICollectionView(_loc3_);
         }
         else if(_loc3_ is Array)
         {
            _loc4_ = new ArrayCollection(_loc3_);
         }
         else if(_loc3_ is XMLList)
         {
            _loc4_ = new XMLListCollection(_loc3_);
         }
         else
         {
            _loc6_ = new Array(_loc3_);
            if(_loc6_ != null)
            {
               _loc4_ = new ArrayCollection(_loc6_);
            }
         }
         this.childrenMapCache[_loc2_] = _loc4_;
         var _loc5_:ICollectionView = this.childrenMap[param1];
         if(_loc5_ != _loc4_)
         {
            if(_loc5_ != null)
            {
               _loc5_.removeEventListener(CollectionEvent.COLLECTION_CHANGE,this.nestedCollectionChangeHandler);
            }
            _loc4_.addEventListener(CollectionEvent.COLLECTION_CHANGE,this.nestedCollectionChangeHandler,false,0,true);
            this.childrenMap[param1] = _loc4_;
         }
         return _loc4_;
      }
      
      public function openNode(param1:Object) : void
      {
         var _loc2_:String = UIDUtil.getUID(param1);
         if(this._openNodes[_loc2_] != null)
         {
            return;
         }
         this._openNodes[_loc2_] = param1;
         var _loc3_:ICollectionView = this.getChildren(param1);
         if(!_loc3_)
         {
            return;
         }
         if(this.sortCanBeApplied(_loc3_) && !(_loc3_.sort == null && this.sort == null))
         {
            _loc3_.sort = this.sort;
         }
         if(!(_loc3_.filterFunction == null && this.filterFunction == null))
         {
            _loc3_.filterFunction = this.filterFunction;
         }
         _loc3_.refresh();
         this.updateParentMapAndLength(_loc3_,param1);
      }
      
      public function closeNode(param1:Object) : void
      {
         var cursor:IViewCursor = null;
         var uid:String = null;
         var node:Object = param1;
         var childrenCollection:ICollectionView = this.childrenMap[node];
         delete this._openNodes[UIDUtil.getUID(node)];
         if(childrenCollection)
         {
            cursor = childrenCollection.createCursor();
            while(!cursor.afterLast)
            {
               uid = UIDUtil.getUID(cursor.current);
               delete this.parentMap[uid];
               try
               {
                  cursor.moveNext();
               }
               catch(e:ItemPendingError)
               {
                  break;
               }
            }
         }
         this.updateLength();
      }
      
      public function addChild(param1:Object, param2:Object) : Boolean
      {
         if(param1 == null)
         {
            return this.addChildAt(param1,param2,this.treeData.length);
         }
         return this.addChildAt(param1,param2,this.getChildren(param1).length);
      }
      
      public function removeChild(param1:Object, param2:Object) : Boolean
      {
         var cursor:IViewCursor = null;
         var children:ICollectionView = null;
         var parent:Object = param1;
         var child:Object = param2;
         var index:int = 0;
         if(parent == null)
         {
            cursor = this.treeData.createCursor();
         }
         else
         {
            children = this.getChildren(parent);
            cursor = children.createCursor();
         }
         while(!cursor.afterLast)
         {
            if(cursor.current == child)
            {
               cursor.remove();
               return true;
            }
            try
            {
               cursor.moveNext();
            }
            catch(e:ItemPendingError)
            {
               return false;
            }
         }
         return false;
      }
      
      public function addChildAt(param1:Object, param2:Object, param3:int) : Boolean
      {
         var cursor:IViewCursor = null;
         var children:ICollectionView = null;
         var parent:Object = param1;
         var newChild:Object = param2;
         var index:int = param3;
         if(!parent)
         {
            cursor = this.treeData.createCursor();
         }
         else
         {
            if(!this.hierarchicalData.canHaveChildren(parent))
            {
               return false;
            }
            children = this.getChildren(parent);
            cursor = children.createCursor();
         }
         try
         {
            cursor.seek(CursorBookmark.FIRST,index);
         }
         catch(e:ItemPendingError)
         {
            return false;
         }
         cursor.insert(newChild);
         return true;
      }
      
      public function removeChildAt(param1:Object, param2:int) : Boolean
      {
         var cursor:IViewCursor = null;
         var children:ICollectionView = null;
         var parent:Object = param1;
         var index:int = param2;
         if(!parent)
         {
            cursor = this.treeData.createCursor();
         }
         else
         {
            children = this.getChildren(parent);
            cursor = children.createCursor();
         }
         try
         {
            cursor.seek(CursorBookmark.FIRST,index);
         }
         catch(e:ItemPendingError)
         {
            return false;
         }
         if(cursor.beforeFirst || cursor.afterLast)
         {
            return false;
         }
         cursor.remove();
         return true;
      }
      
      private function getCollection(param1:Object) : ICollectionView
      {
         var _loc2_:XMLList = null;
         var _loc3_:Array = null;
         if(typeof param1 == "string")
         {
            param1 = new XML(param1);
         }
         else if(param1 is XMLNode)
         {
            param1 = new XML(XMLNode(param1).toString());
         }
         else if(param1 is XMLList)
         {
            param1 = new XMLListCollection(param1 as XMLList);
         }
         if(param1 is XML)
         {
            _loc2_ = new XMLList();
            _loc2_ = _loc2_ + param1;
            return new XMLListCollection(_loc2_);
         }
         if(param1 is ICollectionView)
         {
            return ICollectionView(param1);
         }
         if(param1 is Array)
         {
            return new ArrayCollection(param1 as Array);
         }
         if(param1 is Object)
         {
            _loc3_ = [];
            _loc3_.push(param1);
            return new ArrayCollection(_loc3_);
         }
         return new ArrayCollection();
      }
      
      private function initializeCollection(param1:Object, param2:IHierarchicalData, param3:Object = null) : void
      {
         var _loc5_:Object = null;
         this.parentMap = {};
         this.childrenMap = new Dictionary(true);
         this.childrenMapCache = new Dictionary(true);
         if(this.treeData)
         {
            this.treeData.removeEventListener(CollectionEvent.COLLECTION_CHANGE,this.collectionChangeHandler,false);
         }
         if(this.hierarchicalData)
         {
            this.hierarchicalData.removeEventListener(CollectionEvent.COLLECTION_CHANGE,this.collectionChangeHandler,false);
         }
         this.treeData = this.getCollection(param1);
         if(this.treeData)
         {
            this._hasRoot = this.treeData.length == 1;
         }
         var _loc4_:Object = param1;
         if(param2 && !this.showRoot && this.hasRoot)
         {
            _loc5_ = this.treeData.createCursor().current;
            if(param2.hasChildren(_loc5_))
            {
               _loc4_ = param2.getChildren(_loc5_);
               this.treeData = this.getCollection(_loc4_);
            }
         }
         this.treeData.addEventListener(CollectionEvent.COLLECTION_CHANGE,this.collectionChangeHandler,false,EventPriority.DEFAULT_HANDLER,true);
         this.hierarchicalData = param2;
         this.hierarchicalData.addEventListener(CollectionEvent.COLLECTION_CHANGE,this.collectionChangeHandler,false,EventPriority.DEFAULT_HANDLER,true);
         if(param3)
         {
            this._openNodes = param3;
         }
         else
         {
            this._openNodes = {};
         }
         this.currentLength = this.calculateLength();
      }
      
      private function updateParentMapAndLength(param1:ICollectionView, param2:Object) : void
      {
         var item:Object = null;
         var uid:String = null;
         var childrenCollection:ICollectionView = null;
         var collection:ICollectionView = param1;
         var node:Object = param2;
         var cursor:IViewCursor = collection.createCursor();
         this.currentLength = this.currentLength + collection.length;
         while(!cursor.afterLast)
         {
            item = cursor.current;
            uid = UIDUtil.getUID(item);
            this.parentMap[uid] = node;
            if(this._openNodes[uid] != null)
            {
               childrenCollection = this.getChildren(item);
               if(childrenCollection)
               {
                  this.updateParentMapAndLength(childrenCollection,item);
               }
            }
            try
            {
               cursor.moveNext();
            }
            catch(e:ItemPendingError)
            {
               break;
            }
         }
      }
      
      public function calculateLength(param1:Object = null, param2:Object = null) : int
      {
         var length:int = 0;
         var childNodes:ICollectionView = null;
         var modelOffset:int = 0;
         var modelCursor:IViewCursor = null;
         var parNode:* = undefined;
         var uid:String = null;
         var childCursor:IViewCursor = null;
         var node:Object = param1;
         var parent:Object = param2;
         length = 0;
         modelOffset = 0;
         var firstNode:Boolean = true;
         if(node == null)
         {
            modelCursor = this.treeData.createCursor();
            if(modelCursor.beforeFirst)
            {
               return this.treeData.length;
            }
            while(!modelCursor.afterLast)
            {
               node = modelCursor.current;
               if(node is XML)
               {
                  if(firstNode)
                  {
                     firstNode = false;
                     parNode = node.parent();
                     if(parNode != null)
                     {
                        this.startTrackUpdates(parNode);
                        this.childrenMap[parNode] = this.treeData;
                        this.parentNode = parNode;
                     }
                  }
                  this.startTrackUpdates(node);
               }
               if(node === null)
               {
                  length = length + 1;
               }
               else
               {
                  length = length + (this.calculateLength(node,null) + 1);
               }
               modelOffset++;
               try
               {
                  modelCursor.moveNext();
               }
               catch(e:ItemPendingError)
               {
                  length = length + (treeData.length - modelOffset);
                  return length;
               }
            }
         }
         else
         {
            uid = UIDUtil.getUID(node);
            this.parentMap[uid] = parent;
            if(node != null && this.openNodes[uid] && this.hierarchicalData.canHaveChildren(node) && this.hierarchicalData.hasChildren(node))
            {
               childNodes = this.getChildren(node);
               if(childNodes != null)
               {
                  childCursor = childNodes.createCursor();
                  try
                  {
                     childCursor.seek(CursorBookmark.FIRST);
                     while(!childCursor.afterLast)
                     {
                        if(node is XML)
                        {
                           this.startTrackUpdates(childCursor.current);
                        }
                        length = length + (this.calculateLength(childCursor.current,node) + 1);
                        modelOffset++;
                        try
                        {
                           childCursor.moveNext();
                        }
                        catch(e:ItemPendingError)
                        {
                           length = length + (childNodes.length - modelOffset);
                           return length;
                        }
                     }
                  }
                  catch(e:ItemPendingError)
                  {
                     length = length + 1;
                  }
               }
            }
         }
         return length;
      }
      
      private function internalRefresh(param1:Boolean) : Boolean
      {
         var _loc2_:Object = null;
         var _loc3_:ICollectionView = null;
         var _loc5_:CollectionEvent = null;
         var _loc4_:Boolean = false;
         if(!(this.treeData.filterFunction == null && this.filterFunction == null))
         {
            this.treeData.filterFunction = this.filterFunction;
            this.treeData.refresh();
            _loc4_ = true;
         }
         for each(_loc2_ in this.openNodes)
         {
            _loc3_ = this.getChildren(_loc2_);
            if(_loc3_ && !(_loc3_.filterFunction == null && this.filterFunction == null))
            {
               _loc3_.filterFunction = this.filterFunction;
               _loc3_.refresh();
               _loc4_ = true;
            }
         }
         if(_loc4_)
         {
            this.updateLength();
         }
         if(this.sortCanBeApplied(this.treeData) && !(this.treeData.sort == null && this.sort == null))
         {
            this.treeData.sort = this.sort;
            this.treeData.refresh();
            param1 = true;
         }
         for each(_loc2_ in this.openNodes)
         {
            _loc3_ = this.getChildren(_loc2_);
            if(_loc3_ && this.sortCanBeApplied(_loc3_) && !(_loc3_.sort == null && this.sort == null))
            {
               _loc3_.sort = this.sort;
               _loc3_.refresh();
               param1 = true;
            }
         }
         if(param1)
         {
            _loc5_ = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
            _loc5_.kind = CollectionEventKind.REFRESH;
            dispatchEvent(_loc5_);
         }
         return true;
      }
      
      private function sortCanBeApplied(param1:ICollectionView) : Boolean
      {
         var _loc4_:SortField = null;
         if(this.sort == null)
         {
            return true;
         }
         var _loc2_:Object = param1.createCursor().current;
         if(!_loc2_ || !this.sort.fields)
         {
            return false;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this.sort.fields.length)
         {
            _loc4_ = this.sort.fields[_loc3_];
            if(!_loc2_.hasOwnProperty(_loc4_.name))
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      private function updateLength(param1:Object = null, param2:Object = null) : void
      {
         this.currentLength = this.calculateLength();
      }
      
      private function getVisibleNodes(param1:Object, param2:Object, param3:Array) : void
      {
         var childNodes:ICollectionView = null;
         var cursor:IViewCursor = null;
         var node:Object = param1;
         var parent:Object = param2;
         var nodeArray:Array = param3;
         nodeArray.push(node);
         var uid:String = UIDUtil.getUID(node);
         this.parentMap[uid] = parent;
         if(this.openNodes[uid] != null && this.hierarchicalData.canHaveChildren(node) && this.hierarchicalData.hasChildren(node))
         {
            childNodes = this.getChildren(node);
            if(childNodes != null)
            {
               cursor = childNodes.createCursor();
               while(!cursor.afterLast)
               {
                  this.getVisibleNodes(cursor.current,node,nodeArray);
                  try
                  {
                     cursor.moveNext();
                  }
                  catch(e:ItemPendingError)
                  {
                     return;
                  }
               }
            }
         }
      }
      
      private function getVisibleLocation(param1:int) : int
      {
         var newLocation:int = 0;
         var oldLocation:int = param1;
         newLocation = 0;
         var modelCursor:IViewCursor = this.treeData.createCursor();
         var i:int = 0;
         while(i < oldLocation && !modelCursor.afterLast)
         {
            newLocation = newLocation + (this.calculateLength(modelCursor.current,null) + 1);
            try
            {
               modelCursor.moveNext();
            }
            catch(e:ItemPendingError)
            {
               return newLocation;
            }
            i++;
         }
         return newLocation;
      }
      
      private function getVisibleLocationInSubCollection(param1:Object, param2:int) : int
      {
         var children:ICollectionView = null;
         var cursor:IViewCursor = null;
         var parent:Object = param1;
         var oldLocation:int = param2;
         var newLocation:int = oldLocation;
         var target:Object = parent;
         parent = this.getParentItem(parent);
         while(parent != null)
         {
            children = this.childrenMap[parent];
            cursor = children.createCursor();
            while(!cursor.afterLast)
            {
               if(cursor.current == target)
               {
                  newLocation++;
                  break;
               }
               newLocation = newLocation + (this.calculateLength(cursor.current,parent) + 1);
               try
               {
                  cursor.moveNext();
               }
               catch(e:ItemPendingError)
               {
                  break;
               }
            }
            target = parent;
            parent = this.getParentItem(parent);
         }
         cursor = this.treeData.createCursor();
         while(!cursor.afterLast)
         {
            if(cursor.current == target)
            {
               newLocation++;
               break;
            }
            newLocation = newLocation + (this.calculateLength(cursor.current,parent) + 1);
            try
            {
               cursor.moveNext();
            }
            catch(e:ItemPendingError)
            {
               break;
            }
         }
         return newLocation;
      }
      
      public function collectionChangeHandler(param1:CollectionEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         var _loc8_:Array = null;
         var _loc9_:CollectionEvent = null;
         var _loc10_:CollectionEvent = null;
         var _loc11_:int = 0;
         if(param1 is CollectionEvent)
         {
            _loc10_ = CollectionEvent(param1);
            if(_loc10_.kind == CollectionEventKind.RESET)
            {
               if(this.hierarchicalData)
               {
                  this.initializeCollection(this.hierarchicalData.getRoot(),this.hierarchicalData,this.openNodes);
               }
               this.updateLength();
               this.internalRefresh(false);
               dispatchEvent(param1);
            }
            else if(_loc10_.kind == CollectionEventKind.ADD)
            {
               _loc3_ = _loc10_.items.length;
               _loc9_ = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE,false,true,_loc10_.kind);
               _loc9_.location = this.getVisibleLocation(_loc10_.location);
               _loc2_ = 0;
               while(_loc2_ < _loc3_)
               {
                  _loc7_ = _loc10_.items[_loc2_];
                  if(_loc7_ is XML)
                  {
                     this.startTrackUpdates(_loc7_);
                  }
                  this.getVisibleNodes(_loc7_,null,_loc9_.items);
                  _loc2_++;
               }
               this.currentLength = this.currentLength + _loc9_.items.length;
               dispatchEvent(_loc9_);
            }
            else if(_loc10_.kind == CollectionEventKind.REMOVE)
            {
               _loc3_ = _loc10_.items.length;
               _loc9_ = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE,false,true,_loc10_.kind);
               _loc9_.location = this.getVisibleLocation(_loc10_.location);
               _loc2_ = 0;
               while(_loc2_ < _loc3_)
               {
                  _loc7_ = _loc10_.items[_loc2_];
                  if(_loc7_ is XML)
                  {
                     this.stopTrackUpdates(_loc7_);
                  }
                  this.getVisibleNodes(_loc7_,null,_loc9_.items);
                  _loc2_++;
               }
               this.currentLength = this.currentLength - _loc9_.items.length;
               dispatchEvent(_loc9_);
            }
            else if(_loc10_.kind == CollectionEventKind.UPDATE)
            {
               dispatchEvent(param1);
            }
            else if(_loc10_.kind == CollectionEventKind.REPLACE)
            {
               _loc3_ = _loc10_.items.length;
               _loc9_ = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE,false,true,CollectionEventKind.REMOVE);
               _loc2_ = 0;
               while(_loc2_ < _loc3_)
               {
                  _loc7_ = _loc10_.items[_loc2_].oldValue;
                  if(_loc7_ is XML)
                  {
                     this.stopTrackUpdates(_loc7_);
                  }
                  this.getVisibleNodes(_loc7_,null,_loc9_.items);
                  _loc2_++;
               }
               _loc11_ = 0;
               _loc2_ = 0;
               while(_loc2_ < _loc3_)
               {
                  _loc7_ = _loc10_.items[_loc2_].oldValue;
                  while(_loc9_.items[_loc11_] != _loc7_)
                  {
                     _loc11_++;
                  }
                  _loc9_.items.splice(_loc11_,1);
                  _loc2_++;
               }
               if(_loc9_.items.length)
               {
                  this.currentLength = this.currentLength - _loc9_.items.length;
                  dispatchEvent(_loc9_);
               }
               dispatchEvent(param1);
            }
         }
      }
      
      public function nestedCollectionChangeHandler(param1:CollectionEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         var _loc8_:Array = null;
         var _loc9_:CollectionEvent = null;
         var _loc10_:CollectionEvent = null;
         var _loc11_:int = 0;
         var _loc12_:Object = null;
         if(param1 is CollectionEvent)
         {
            _loc10_ = CollectionEvent(param1);
            if(_loc10_.kind == CollectionEventKind.EXPAND)
            {
               param1.stopImmediatePropagation();
            }
            else if(_loc10_.kind == CollectionEventKind.ADD)
            {
               this.updateLength();
               _loc3_ = _loc10_.items.length;
               _loc9_ = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE,false,true,_loc10_.kind);
               _loc2_ = 0;
               while(_loc2_ < _loc3_)
               {
                  _loc7_ = _loc10_.items[_loc2_];
                  if(_loc7_ is XML)
                  {
                     this.startTrackUpdates(_loc7_);
                  }
                  _loc6_ = this.getParentItem(_loc7_);
                  if(_loc6_ != null)
                  {
                     this.getVisibleNodes(_loc7_,_loc6_,_loc9_.items);
                  }
                  _loc2_++;
               }
               _loc9_.location = this.getVisibleLocationInSubCollection(_loc6_,_loc10_.location);
               dispatchEvent(_loc9_);
            }
            else if(_loc10_.kind == CollectionEventKind.REMOVE)
            {
               _loc3_ = _loc10_.items.length;
               _loc9_ = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE,false,true,_loc10_.kind);
               _loc2_ = 0;
               while(_loc2_ < _loc3_)
               {
                  _loc7_ = _loc10_.items[_loc2_];
                  if(_loc7_ is XML)
                  {
                     this.stopTrackUpdates(_loc7_);
                  }
                  _loc6_ = this.getParentItem(_loc7_);
                  if(_loc6_ != null)
                  {
                     this.getVisibleNodes(_loc7_,_loc6_,_loc9_.items);
                  }
                  _loc2_++;
               }
               _loc9_.location = this.getVisibleLocationInSubCollection(_loc6_,_loc10_.location);
               this.currentLength = this.currentLength - _loc9_.items.length;
               dispatchEvent(_loc9_);
            }
            else if(_loc10_.kind == CollectionEventKind.UPDATE)
            {
               dispatchEvent(param1);
            }
            else if(_loc10_.kind == CollectionEventKind.REPLACE)
            {
               _loc3_ = _loc10_.items.length;
               _loc9_ = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE,false,true,CollectionEventKind.REMOVE);
               _loc2_ = 0;
               while(_loc2_ < _loc3_)
               {
                  _loc7_ = _loc10_.items[_loc2_].oldValue;
                  _loc6_ = this.getParentItem(_loc7_);
                  if(_loc6_ != null)
                  {
                     this.getVisibleNodes(_loc7_,_loc6_,_loc9_.items);
                     if(this._openNodes[UIDUtil.getUID(_loc6_)] != null)
                     {
                        _loc12_ = _loc10_.items[_loc2_].newValue;
                        _loc5_ = UIDUtil.getUID(_loc12_);
                        this.parentMap[_loc5_] = _loc6_;
                        delete this.parentMap[UIDUtil.getUID(_loc7_)];
                     }
                  }
                  _loc2_++;
               }
               _loc11_ = 0;
               _loc2_ = 0;
               while(_loc2_ < _loc3_)
               {
                  _loc7_ = _loc10_.items[_loc2_].oldValue;
                  if(_loc7_ is XML)
                  {
                     this.stopTrackUpdates(_loc7_);
                  }
                  while(_loc9_.items[_loc11_] != _loc7_)
                  {
                     _loc11_++;
                  }
                  _loc9_.items.splice(_loc11_,1);
                  _loc2_++;
               }
               if(_loc9_.items.length)
               {
                  this.currentLength = this.currentLength - _loc9_.items.length;
                  dispatchEvent(_loc9_);
               }
               dispatchEvent(param1);
            }
            else if(_loc10_.kind == CollectionEventKind.RESET)
            {
               this.updateLength();
               _loc9_ = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE,false,true,CollectionEventKind.REFRESH);
               dispatchEvent(_loc9_);
            }
         }
      }
      
      public function xmlNotification(param1:Object, param2:String, param3:Object, param4:Object, param5:Object) : void
      {
         var _loc6_:String = null;
         var _loc7_:Object = null;
         var _loc8_:Object = null;
         var _loc9_:XMLListCollection = null;
         var _loc10_:int = 0;
         var _loc11_:CollectionEvent = null;
         var _loc12_:XMLListAdapter = null;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:XMLList = null;
         var _loc16_:XMLListCollection = null;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         if(param1 === param3)
         {
            switch(param2)
            {
               case "nodeAdded":
                  for(_loc13_ in this.childrenMap)
                  {
                     if(_loc13_ === param1)
                     {
                        _loc12_ = this.childrenMap[_loc13_].list as XMLListAdapter;
                        if(_loc12_ && !_loc12_.busy())
                        {
                           if(this.childrenMap[_loc13_] === this.treeData)
                           {
                              _loc9_ = this.treeData as XMLListCollection;
                              if(this.parentNode != null)
                              {
                                 _loc9_.dispatchResetEvent = false;
                                 _loc9_.source = this.parentNode.*;
                                 _loc9_.refresh();
                              }
                           }
                           else
                           {
                              _loc9_ = this.getChildren(_loc13_) as XMLListCollection;
                           }
                           if(_loc9_)
                           {
                              _loc10_ = param4.childIndex();
                              _loc11_ = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                              _loc11_.kind = CollectionEventKind.ADD;
                              _loc11_.location = _loc10_;
                              _loc11_.items = [param4];
                              _loc9_.dispatchEvent(_loc11_);
                           }
                        }
                        break;
                     }
                  }
                  break;
               case "nodeRemoved":
                  for(_loc14_ in this.childrenMap)
                  {
                     if(_loc14_ === param1)
                     {
                        _loc9_ = this.childrenMap[_loc14_];
                        _loc12_ = _loc9_.list as XMLListAdapter;
                        if(_loc12_ && !_loc12_.busy())
                        {
                           _loc15_ = _loc9_.source as XMLList;
                           if(this.childrenMap[_loc14_] === this.treeData)
                           {
                              _loc9_ = this.treeData as XMLListCollection;
                              if(this.parentNode)
                              {
                                 _loc9_.dispatchResetEvent = false;
                                 _loc9_.source = this.parentNode.*;
                                 _loc9_.refresh();
                              }
                           }
                           else
                           {
                              _loc16_ = _loc9_;
                              _loc9_ = this.getChildren(_loc14_) as XMLListCollection;
                              if(!_loc9_)
                              {
                                 _loc16_.addEventListener(CollectionEvent.COLLECTION_CHANGE,this.nestedCollectionChangeHandler,false,0,true);
                                 _loc11_ = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                                 _loc11_.kind = CollectionEventKind.REMOVE;
                                 _loc11_.location = 0;
                                 _loc11_.items = [param4];
                                 _loc16_.dispatchEvent(_loc11_);
                                 _loc16_.removeEventListener(CollectionEvent.COLLECTION_CHANGE,this.nestedCollectionChangeHandler);
                              }
                           }
                           if(_loc9_)
                           {
                              _loc17_ = _loc15_.length();
                              _loc18_ = 0;
                              while(_loc18_ < _loc17_)
                              {
                                 if(_loc15_[_loc18_] === param4)
                                 {
                                    _loc11_ = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                                    _loc11_.kind = CollectionEventKind.REMOVE;
                                    _loc11_.location = _loc10_;
                                    _loc11_.items = [param4];
                                    _loc9_.dispatchEvent(_loc11_);
                                    break;
                                 }
                                 _loc18_++;
                              }
                           }
                        }
                        break;
                     }
                  }
            }
         }
      }
      
      private function startTrackUpdates(param1:Object) : void
      {
         XMLNotifier.getInstance().watchXML(param1,this);
      }
      
      private function stopTrackUpdates(param1:Object) : void
      {
         XMLNotifier.getInstance().unwatchXML(param1,this);
      }
      
      public function set showRoot(param1:Boolean) : void
      {
         var _loc2_:Object = this.showRoot;
         if(_loc2_ !== param1)
         {
            this._338884225showRoot = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"showRoot",_loc2_,param1));
            }
         }
      }
   }
}
