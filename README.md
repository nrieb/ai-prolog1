Author
======
nrieb AT cs dot unm dot edu

Prolog version
==============
SWI=Prolog version 6.6.6

State representation
====================
My state representation is encoded like

    state(Boat’s shore (e for east, w for west), # of vampires on the western shore,
    # werewolves on western shore).

For example:

    state(e,3,1)

means that the boat is on the eastern shore, there are three vampires on the western shore, and there is one werewolf on the western shore.  In the simple 3 vampires 3 werewolves case, then this implies that there are zero vampires on the eastern shore and two werewolves on the eastern shore.

Output Format
=============
Visited states
--------------
Format is
parent :SPACE: child

state(e,0,0) state(w,2,0)
state(e,0,0) state(w,0,2)
state(e,0,0) state(w,1,1)
state(e,0,0) state(w,1,0)
state(e,0,0) state(w,0,1)
...
state(e,3,1) state(w,3,3)
state(e,3,1) state(w,3,2)

Solution Output
---------------
Solution path is:
state(e,0,0)
state(w,0,2)
state(e,0,1)
state(w,0,3)
state(e,0,2)
state(w,2,2)
state(e,1,1)
state(w,3,1)
state(e,3,0)
state(w,3,2)
state(e,2,2)
state(w,3,3)
