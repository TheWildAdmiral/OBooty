Scriptname BootyCallSpell extends ActiveMagicEffect  

OBootyCall Property Main Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
    Utility.Wait(0.75)
    Main.FollowPlayer()
endEvent