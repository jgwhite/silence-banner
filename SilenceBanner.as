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
			BANNER_URL:String = "http://www.residentadvisor.net/event.aspx?211556";
		
		private var
			nextCardTimer:Timer,
			container:Sprite,
			background:Sprite,
			card01Event:Card01Event,
			card02ActZip:Card02ActZip,
			card03ActBabyFord:Card03ActBabyFord,
			card04ActMargaretDygas:Card04ActMargaretDygas,
			card05ActSilentCollective:Card05ActSilentCollective,
			card06Info:Card06Info,
			card07Logos:Card07Logos,
			bannerButton:Sprite,
			sequence:Array,
			frame:Number,
			currentCard:Sprite;
		
		public function SilenceBanner () {
			super();
			
			container = new Sprite();
			container.buttonMode = true;
			container.useHandCursor = true;
			container.mouseChildren = false;
			container.addEventListener(MouseEvent.CLICK, onBannerClick);
			addChild(container);
			
			background = new Sprite();
			background.graphics.beginFill(0x4B617D, 1);
			background.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			background.graphics.endFill();
			container.addChild(background);
			
			card01Event = new Card01Event();
			card02ActZip = new Card02ActZip();
			card03ActBabyFord = new Card03ActBabyFord();
			card04ActMargaretDygas = new Card04ActMargaretDygas();
			card05ActSilentCollective = new Card05ActSilentCollective();
			card06Info = new Card06Info();
			card07Logos = new Card07Logos();
			
			sequence = [
				{ delay: 2000, card: card02ActZip },
				{ delay: 2000, card: card03ActBabyFord },
				{ delay: 2000, card: card04ActMargaretDygas },
				{ delay: 2000, card: card05ActSilentCollective },
				{ delay: 4000, card: card01Event },
				{ delay: 3000, card: card06Info },
				{ delay: 3000, card: card07Logos }
			];
			
			nextCardTimer = new Timer(1, 1);
			nextCardTimer.addEventListener(TimerEvent.TIMER, onNextCardTimer);
			
			introduce();
		}
		
		function introduce ():void {
			frame = -1;
			gotoNextCard();
		}
		
		function gotoNextCard ():void {
			var n = sequence.length;
			frame = (n + ((frame + 1) % n)) % n;
			if (currentCard) container.removeChild(currentCard);
			currentCard = sequence[frame].card;
			container.addChild(currentCard);
			nextCardTimer.delay = sequence[frame].delay;
			nextCardTimer.reset();
			nextCardTimer.start();
		}
		
		function onNextCardTimer (event:TimerEvent):void {
			gotoNextCard();
		}
		
		function onBannerClick (event:MouseEvent):void {
			navigateToURL(new URLRequest(BANNER_URL));
		}
		
	}
	
}