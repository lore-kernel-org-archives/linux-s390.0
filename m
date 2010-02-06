From: Frans Pop <elendil@planet.nl>
Subject: [PATCH 00/16] remove trailing spaces in messages
Date: Sat, 6 Feb 2010 18:44:36 +0100
Message-ID: <201002061844.45212.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Return-path: <linux-mips-bounce@linux-mips.org>
Errors-to: linux-mips-bounce@linux-mips.org
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David S. Miller" <davem@davemloft.net>, Fenghua Yu <fenghua.yu@intel.com>, Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@elte.hu>, Jeff Dike <jdike@addtoit.com>, Jiri Kosina <trivial@kernel.org>, Kyle McMartin <kyle@mcmartin.ca>, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linux-pm@lists.linux-foundation.org, linuxppc-dev@ozlabs.org, linux-s390@vger.kernel.org, Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au, Mike Frysinger <vapier@gentoo.org>, Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Ralf
List-ID: <linux-s390.vger.kernel.org>

This is a first series of patches to remove trailing spaces in messages. 
Patches cover arch-specific code plus one fix for PM and one in 
Documentation. Depending on how this series is received I'll continue
with other parts of the kernel.

Benefits are:
- general cleanup and consistency
- minor reduction in kernel size and user's log file size
- reduced annoyance for people writing logcheck rules

The patch for m68k has been rebased against linux-next; all other
patches apply against both mainline and -next (as of 5-2).

Shortstat:
 74 files changed, 135 insertions(+), 136 deletions(-)

Frans Pop (16):
      alpha: remove trailing spaces in messages
      arm: remove trailing spaces in messages
      ia64: remove trailing space in messages
      m68k: remove trailing space in messages
      microblaze: remove trailing space in messages
      mips: remove trailing space in messages
      parisc: remove trailing space in messages
      s390: remove trailing space in messages
      sparc: remove trailing space in messages
      x86: remove trailing space in messages
      blackfin: remove trailing space in messages
      cris/trivial: remove trailing space in message
      powerpc: remove trailing space in messages
      um: remove trailing space in messages
      PM: remove trailing space in message
      trivial: remove trailing space in spidev test program
