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
			container:Sprite,
			background:Sprite,
			
			whatMassive:WhatMassive,
			whatMassiveTween:Tween,
			
			whatAndDateTumbler:Tumbler,
			whatAndDate:WhatAndDate,
			
			lineaTumbler:Tumbler,
			linea:Linea,
			
			cardsTumbler:Tumbler,
			
			cardActZip:CardActZip,
			cardActBabyFord:CardActBabyFord,
			cardActMargaretDygas:CardActMargaretDygas,
			cardActSilentCollective:CardActSilentCollective,
			cardVenue:CardVenue,
			cardLogos:CardLogos,
			
			sequence:Array,
			nextCardTimer:Timer,
			frame:Number;
		
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
			
			whatMassive = new WhatMassive();
			whatMassive.blendMode = 'layer';
			whatMassive.cacheAsBitmap = true;
			whatMassive.alpha = 0.15;
			container.addChild(whatMassive);
			
			whatAndDateTumbler = new Tumbler();
			whatAndDate = new WhatAndDate();
			whatAndDate.cacheAsBitmap = true;
			whatAndDateTumbler.addChild(whatAndDate);
			container.addChild(whatAndDateTumbler);
			
			lineaTumbler = new Tumbler();
			linea = new Linea();
			lineaTumbler.addChild(linea);
			container.addChild(lineaTumbler);
			
			cardActZip = new CardActZip();
			cardActZip.cacheAsBitmap = true;
			cardActBabyFord = new CardActBabyFord();
			cardActBabyFord.cacheAsBitmap = true;
			cardActMargaretDygas = new CardActMargaretDygas();
			cardActMargaretDygas.cacheAsBitmap = true;
			cardActSilentCollective = new CardActSilentCollective();
			cardActSilentCollective.cacheAsBitmap = true;
			cardVenue = new CardVenue();
			cardVenue.cacheAsBitmap = true;
			cardLogos = new CardLogos();
			cardLogos.cacheAsBitmap = true;
			
			sequence = [
				{ delay: 2000, card: cardActZip },
				{ delay: 2000, card: cardActBabyFord },
				{ delay: 2000, card: cardActMargaretDygas },
				{ delay: 2000, card: cardActSilentCollective },
				{ delay: 2000, card: cardVenue },
				{ delay: 2000, card: cardLogos }
			];
			
			cardsTumbler = new Tumbler();
			container.addChild(cardsTumbler);
			
			nextCardTimer = new Timer(1, 1);
			nextCardTimer.addEventListener(TimerEvent.TIMER, onNextCardTimer);
			
			whatAndDateTumbler.tip = -0.5;
			lineaTumbler.tip = -0.5;
			cardsTumbler.tip = -0.5;
			
			introduce();
		}
		
		function introduce ():void {
			frame = 0;
			cardsTumbler.addChild(sequence[frame].card);
			
			whatAndDateTumbler.tumbleTo(1);
			lineaTumbler.tumbleTo(2);
			cardsTumbler.tumbleTo(0);
			
			cardsTumbler.onFinish = function () {
				nextCardTimer.delay = sequence[frame].delay;
				nextCardTimer.reset();
				nextCardTimer.start();
			}
		}
		
		function gotoNextCard ():void {
			var cardToRemove:Sprite = sequence[frame].card;
			
			var n = sequence.length;
			frame = (n + ((frame + 1) % n)) % n;
			
			var cardToAdd:Sprite = sequence[frame].card;
			
			cardsTumbler.onReset = function () {
				if (cardToRemove && cardsTumbler.contains(cardToRemove))
					cardsTumbler.removeChild(cardToRemove);
				if (cardToAdd) cardsTumbler.addChild(cardToAdd);
			}
			
			cardsTumbler.tumbleTo(cardsTumbler.tip + 1);
			
			cardsTumbler.onFinish = function () {
				nextCardTimer.delay = sequence[frame].delay;
				nextCardTimer.reset();
				nextCardTimer.start();
			}
		}
		
		function onNextCardTimer (event:TimerEvent):void {
			gotoNextCard();
		}
		
		function onBannerClick (event:MouseEvent):void {
			navigateToURL(new URLRequest(BANNER_URL), '_blank');
		}
		
	}
	
}