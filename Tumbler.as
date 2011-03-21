package {
	
	import flash.display.Sprite;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	
	public class Tumbler extends Sprite {
		
		static private const
			DURATION = 1;
		
		public var
			onReset:Function,
			onFinish:Function;
		
		private var
			_tip:Number,
			_reset:Boolean,
			tumbleTween:Tween;
		
		public function Tumbler () {
			super();
			_tip = 0;
			_reset = false;
			blendMode = "layer";
			cacheAsBitmap = true;
			tumbleTween = new Tween(this, "tip", Strong.easeInOut, 0, 0, DURATION, true);
			tumbleTween.addEventListener(TweenEvent.MOTION_CHANGE, onTweenMotionChange);
			tumbleTween.addEventListener(TweenEvent.MOTION_FINISH, onTweenMotionFinish);
			tumbleTween.stop();
		}
		
		public function tumbleTo (value:Number = 1, duration:Number = DURATION):void {
			_reset = false;
			tumbleTween.continueTo(tip, 1);
			tumbleTween.fforward();
			tumbleTween.stop();
			tumbleTween.continueTo(value, duration);
		}
		
		private function onTweenMotionChange (event:TweenEvent):void {
			if (_reset) return;
			if (y < 0 && onReset != null) onReset();
		}
		
		private function onTweenMotionFinish (event:TweenEvent):void {
			if (onFinish != null) onFinish();
		}
		
		public function get tip ():Number {
			return _tip;
		}
		public function set tip (value:Number):void {
			_tip = value;
			y = Math.round(((2 * ((_tip - 0.5) - Math.floor(_tip - 0.5))) - 1) * 90);
		}
		
	}
	
}
