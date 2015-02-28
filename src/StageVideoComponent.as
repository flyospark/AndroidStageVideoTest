package
{
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.geom.Rectangle;
	import flash.media.StageVideo;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	public class StageVideoComponent extends Sprite
	{
		protected var stream : NetStream;
		protected var stageVideo : StageVideo;
		public static const VIDEO_COMPLETED:String =  "VideoComplete" ;
		public function StageVideoComponent(stage : Stage)
		{
			var nc : NetConnection = new NetConnection();
			nc.connect( null );
			stream = new NetStream( nc );
			stream.client = this;
			stream.addEventListener( NetStatusEvent.NET_STATUS, onNetStatus );
			
			//stream.useHardwareDecoder = tru;
			
			if ( stage.stageVideos.length > 0 )
			{
				stageVideo = stage.stageVideos[0];
			}
			
			if ( stageVideo )
			{
				trace("viewport:"+ stage.fullScreenWidth + " : "+ stage.fullScreenHeight );
				stageVideo.viewPort = new Rectangle( 0, 0, stage.fullScreenWidth, stage.fullScreenHeight);
			}
			else
			{
				throw new Error("stage video not available");	
			}
		}
		
		public function playVideo(url : String) : void
		{
			stream.close();
			
			if ( stageVideo )
			{
				stageVideo.attachNetStream( stream );
			}
			trace("playing:"+url);
			stream.play( url );
		}
		
		public function stopVideo() : void
		{
			stageVideo.attachNetStream(null);
			stream.close();
			stream.dispose();
			stageVideo = null;
			dispatchEvent( new Event( VIDEO_COMPLETED ) );
		}
		
		public function onXMPData(info : Object) : void
		{
		}
		
		public function onMetaData(info : Object) : void
		{
		}
		
		public function onCuePoint(info : Object) : void
		{
		}
		
		public function onPlayStatus(info : Object) : void
		{
			trace(info);
		}
		
		private function onNetStatus(e : NetStatusEvent) : void
		{
			if (e.info.code == "NetStream.Play.Stop")
			{
				stopVideo();
			}
			trace(e.info.code);
		}
	}
}