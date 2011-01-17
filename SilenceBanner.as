package {
	
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	
	public class SilenceBanner extends MovieClip {
		
		static private const
			BANNER_URL:String = "http://www.residentadvisor.net/event.aspx?184949",
			CARD_CONTENT_X:Number = 230,
			CARD_CONTENT_Y:Number = 5;
		
		private var
			nextCardTimer:Timer,
			background:Sprite,
			bannerButton:Sprite;
		
		public function SilenceBanner () {
			super();
			
			createBackground();
			createBannerButton();
			
			nextCardTimer = new Timer(2000, 1);
			nextCardTimer.addEventListener(TimerEvent.TIMER, onNextCardTimer);
			
			introduce();
		}
		
		function createBackground ():void {
			background = new Sprite();
			background.graphics.beginFill(0x4B617D, 1);
			background.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			background.graphics.endFill();
			addChild(background);
		}
		
		function createBannerButton ():void {
			bannerButton = new Sprite();
			bannerButton.x = 0; bannerButton.y = 0;
			bannerButton.graphics.beginFill(0xFFFFFF, 0);
			bannerButton.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			bannerButton.graphics.endFill();
			bannerButton.buttonMode = true;
			bannerButton.useHandCursor = true;
			bannerButton.addEventListener(MouseEvent.CLICK, onBannerClick);
			addChild(bannerButton);
		}
		
		function introduce ():void {
			
		}
		
		function gotoNextCard ():void {
			
		}
		
		function onNextCardTimer (event:TimerEvent):void {
			gotoNextCard();
		}
		
		function onBannerClick (event:MouseEvent):void {
			navigateToURL(new URLRequest(BANNER_URL));
		}
		
	}
	
}