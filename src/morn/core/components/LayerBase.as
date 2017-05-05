package morn.core.components
{
	import flash.events.Event;
	
	public class LayerBase extends Component
	{
		public function LayerBase()
		{
			super();
			this.mouseChildren = true;
			if(stage){
				onAddToStage(null);
			}else{
				addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
			}
			
		}
		
		protected function onAddToStage(event:Event):void
		{
			App.stage.addEventListener(Event.RESIZE,onStageResize);
		}
		
		protected function onStageResize(event:Event):void
		{
			for (var i:int = this.numChildren - 1; i > -1; i--) {
				var item:IResizebale = getChildAt(i) as IResizebale;
				if(item){
					item.onStageResize();
				}
			}
		}
	}
}