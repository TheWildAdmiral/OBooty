Scriptname OBootyCall extends Quest


;   ██████╗ ██████╗  ██████╗  ██████╗ ████████╗██╗   ██╗
;  ██╔═══██╗██╔══██╗██╔═══██╗██╔═══██╗╚══██╔══╝╚██╗ ██╔╝
;  ██║   ██║██████╔╝██║   ██║██║   ██║   ██║    ╚████╔╝ 
;  ██║   ██║██╔══██╗██║   ██║██║   ██║   ██║     ╚██╔╝  
;  ╚██████╔╝██████╔╝╚██████╔╝╚██████╔╝   ██║      ██║   
;   ╚═════╝ ╚═════╝  ╚═════╝  ╚═════╝    ╚═╝      ╚═╝   


; ====|| Properties ||====
Actor Property Player Auto                  
Spell Property CallSpell Auto               ; The summon spell
Spell Property SetupSpell Auto              ; The setup spell
ReferenceAlias Property CallFollower Auto   ; A person who follows the booty call
ReferenceAlias[] Property Targets Auto      ; Available NPCs to summon

; ====|| Functions ||====
String Function GetActorName(Actor actorTarget)
    return actorTarget.GetActorBase().GetName()
endFunction

Int Function SelectTarget()

    UIListMenu menu = uiextensions.GetMenu("UIListMenu") as UIListMenu
    
    Int i = 0
    Int size = Targets.Length

    while (i < size)
        ObjectReference ref = Targets[i].GetReference()

        if (ref)
            menu.AddEntryItem( GetActorName(ref as Actor) )
        else
            menu.AddEntryItem("[EMPTY]")
        endif

        i += 1
    endWhile

    menu.OpenMenu()
    return menu.GetResultInt()

endFunction

Function AddTarget(Actor target)

    Int result = SelectTarget()

    if (result < 0)
        return
    endif

    Targets[result].ForceRefTo(target)
    Debug.Notification( GetActorName(target) + " will answer your booty calls" )

endFunction

Function FollowPlayer()
    
    Int result = SelectTarget()

    if (result < 0)
        return
    endif

    ObjectReference ref = Targets[result].GetReference()

    if (ref)
        Actor follower = ref as Actor

        follower.MoveTo(Player)
        CallFollower.ForceRefTo(ref)
        follower.EvaluatePackage()
    endif

endFunction

Function UnfollowPlayer()
    
    ObjectReference ref = CallFollower.GetReference()

    CallFollower.Clear()
    (ref as Actor).EvaluatePackage()

endFunction

; ====|| Events ||====
Event OnInit()
    Player.AddSpell(CallSpell)
    Player.AddSpell(SetupSpell)
endEvent