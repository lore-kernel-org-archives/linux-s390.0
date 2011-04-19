From: Patrick Finnegan <vax@purdue.edu>
Date: Tue, 19 Apr 2011 14:58:10 +0000
Subject: Problems using channel-attached 3270 terminal
Message-Id: <201104191058.11032.vax@purdue.edu>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

I have a couple of 3270-mode terminals locally attached via a 3174-21L 
on my z890 running Debian/Squeeze in an LPAR.

According to the 3270 terminal driver documentation, I should be able to 
enter ctrl-C, ctrl-D, etc, using ^C or ^D.  I can successfully do this 
from the SE/HMC console window.

Of course, a locally attached 3270 terminal (I've used a 3279 and 3483 
InfoWindow II) doesn't seem to be able to generate a proper character 
code for "^", so I have attempted and failed to get the "�" character 
(shift-6 on a 3270 keyboard) recognised as a "^".

I tried modifying the kernel source (defkeymap.map and ctrlchar.c under 
drivers/s390/char/), and also using dumpkeys/loadkeys to view and modify 
the keymap at runtime.

According to dumpkeys, the only compose sequenses by default are "^" "z" 
-> "\000".  I used loadkeys to load my modified keymap, which included 
the default compose sequences, along with versions modified to use "�" 
instead of "^", but it still didn't seem to make any difference.

Does anyone have any suggestions?

Pat
-- 
Purdue University Research Computing --  http://www.rcac.purdue.edu
