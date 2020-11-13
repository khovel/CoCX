/**
 * ...
 * @author Ormael
 */
package classes.Items.Consumables 
{
	import classes.Items.Consumable;
	import classes.PerkLib;
	//import classes.Monster;
	import classes.internals.Utils;
	import classes.Scenes.SceneLib;

	public class BallsOfTheDarkness extends Consumable {
		
		public function BallsOfTheDarkness() 
		{
			super("BallOTD", "BallsOfTheDarkness", "a Balls of the Darkness", 60, "Three ball-shaped throwing weapons.  Though good for only a single use, they're guaranteed to do medium to high damage to solo or weak group of enemies if they hits.  Inflicts 1440 to 8640 darkness damage.");
		}
		
		override public function canUse():Boolean {
			if (game.inCombat) return true;
			outputText("There's no one to throw it at!");
			return false;
		}
		
		override public function useItem():Boolean {
			clearOutput();
			outputText("You toss balls of the darkness at your foe");
			if (game.monster.findPerk(PerkLib.EnemyGroupType) >= 0) outputText("s");
			outputText("!  They flies straight and true, almost as if they has a mind of their own as they arcs towards " + game.monster.a + game.monster.short + "!\n");
			if (game.monster.spe - 320 > Utils.rand(100) + 1) { //1% dodge for each point of speed over 320
				outputText("Somehow " + game.monster.a + game.monster.short + "'");
				if (!game.monster.plural) outputText("s");
				outputText(" incredible speed allows " + game.monster.pronoun2 + " to avoid the balls!  The deadly spheres shatters when they impacts something in the distance. For a moment area around impact is engulfed in the darkness.");
			}
			else { //Not dodged
				var damage:Number = 1440 + Utils.rand(721);
				if (game.player.level >= 6) {
					if (game.player.level >= 24) {
						if (game.player.level >= 42) damage *= 4;
						else damage *= 3;
					}
					else damage *= 2;
				}
				if (game.monster.findPerk(PerkLib.EnemyGroupType) >= 0) damage *= 5;
				outputText(game.monster.capitalA + game.monster.short + " is hit with the Balls of the Darkness!  They breaks apart as the darkness engulfing " + game.monster.pronoun2 + ". ");
				damage = SceneLib.combat.doDarknessDamage(damage, true, true);
				if (game.monster.HP < game.monster.minHP()) game.monster.HP = game.monster.minHP() - 1;
			}
			return(false);
		}
	}
}