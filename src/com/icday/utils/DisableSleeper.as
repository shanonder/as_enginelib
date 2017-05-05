//------------------------------------------------------------------------------
//
// classname: DisableSleeper
// version: 0.1.0
// author: 小兵( aosnow@yeah.net )
// created: 2013-8-5
// copyright (c) 2013 小兵( aosnow@yeah.net )
// ...
//
//------------------------------------------------------------------------------

package com.icday.utils
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.getTimer;

	public class DisableSleeper
	{
		//--------------------------------------------------------------------------
		//
		//   Class constructor
		//
		//--------------------------------------------------------------------------

		/**
		 * 创建新的实例
		 * @param stage 舞台对象
		 */
		public function DisableSleeper( stage:Stage )
		{
			if( stage is Stage )
			{
				this.stage = stage;

				lastFrameTime = getTimer();
				this.stage.addEventListener( Event.ENTER_FRAME, onEnterFrameHandler );
			}
		}

		//--------------------------------------------------------------------------
		//
		//	 Class properties
		//
		//--------------------------------------------------------------------------

		protected var stage:Stage;
		protected var lastFrameTime:int;

		protected var snd:Sound = new Sound();
		protected var sndCh:SoundChannel;

		//--------------------------------------------------------------------------
		//
		//   Class methods
		//
		//--------------------------------------------------------------------------

		public function run():void
		{
			snd.addEventListener( SampleDataEvent.SAMPLE_DATA, onSampleDataHandler, false, 0, true );
			sndCh = snd.play();
		}

		public function stop():void
		{

			if(sndCh)
				sndCh.stop();


			if( sndCh )
				sndCh.stop();

		}

		public function destroy():void
		{
			snd.close();
			sndCh.stop();

			snd = null;
			sndCh = null;
		}

		//--------------------------------------------------------------------------
		//
		//   Event handlers
		//
		//--------------------------------------------------------------------------

		public function onSampleDataHandler( e:SampleDataEvent ):void
		{
			e.data.position = e.data.length = 4096 * 4;
		}

		public function onEnterFrameHandler( e:Event ):void
		{
//			var currFrameTime:int = getTimer();
//			var timeElapsed:int = currFrameTime - lastFrameTime;
//			trace( "[", e.type, "] elapsed:", timeElapsed, "ms, fps:", ~~( 1000 / timeElapsed + 0.5 ));
//			lastFrameTime = currFrameTime;
		}
	}
}
