package
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.StageVideoAvailabilityEvent;
	import flash.media.StageVideoAvailability;
	
	[SWF(width="1280", height="720", frameRate="60")]
	public class POC_StageVideoAndroid extends Sprite
	{

		public static var nativeOverlay:DisplayObjectContainer;
		public static var nativeStage:Stage;
		public function POC_StageVideoAndroid()
		{
			super();
			
			nativeOverlay = this;
			nativeStage = stage;

			stage.addEventListener( StageVideoAvailabilityEvent.STAGE_VIDEO_AVAILABILITY , stageVideoState );
		}
			
		protected function stageVideoState( e:StageVideoAvailabilityEvent ):void
		{
			var stageVideoAvailable:Boolean = e.availability == StageVideoAvailability.AVAILABLE ;
			if( stageVideoAvailable ){
				var ssv:StageVideoComponent = new StageVideoComponent( nativeStage );
				ssv.playVideo("data/vid0.f4v");
			}
		}
	}
}