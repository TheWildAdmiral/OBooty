Scriptname BootyCallSetup extends ActiveMagicEffect  

OBootyCall Property Main Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

    if (akTarget)
        Utility.Wait(0.75)
        Main.AddTarget(akTarget)
    endif

endEvent