From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 00/10] Add support for GCC's __builtin_unreachable() and use
 it in BUG.
Date: Thu, 10 Sep 2009 16:54:41 -0700
Message-ID: <4AA991C1.1050800@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-alpha-owner@vger.kernel.org>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, linux-am33-list@redhat.com, Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@atmel.com>, Mike Frysinger <vapier@gentoo.org>, uclinux-dist-devel@blackfin.uclinux.org
List-ID: <linux-s390.vger.kernel.org>

Starting with version 4.5, GCC has a new built-in function called
__builtin_unreachable().  The function tells the compiler that control
flow will never reach that point.  Currently we trick the compiler by
putting in for(;;); but this has the disadvantage that extra code is
emitted for an endless loop.  For an i386 kernel using
__builtin_unreachable() results in an allyesconfig that is nearly 4000
bytes smaller.

This patch set adds support to compiler.h creating a
new macro usable in the kernel called unreachable().  If the compiler
lacks __builtin_unreachable(), it just expands to for(;;).

The x86 and MIPS patches I actually tested with a GCC-4.5 snapshot.
Lacking the ability to test the rest of the architectures, I just did
what seemed right without even trying to compile the kernel.

01/10 adds the compiler.h support, the rest of the patches retrofit
the various architecture BUG macros to use it instead of for(;;) or
while(1) loops.

I will reply with the 10 patches.

The architecture specific patches I will send to a smaller set of
people.

David Daney (10):
   Add support for GCC-4.5's __builtin_unreachable() to compiler.h
   x86: Convert BUG() to use unreachable()
   MIPS: Convert BUG() to use unreachable()
   s390: Convert BUG() to use unreachable()
   mn10300: Convert BUG() to use unreachable()
   parisc: Convert BUG() to use unreachable()
   powerpc: Convert BUG() to use unreachable()
   alpha: Convert BUG() to use unreachable()
   avr32: Convert BUG() to use unreachable()
   blackfin: Convert BUG() to use unreachable()

  arch/alpha/include/asm/bug.h    |    2 +-
  arch/avr32/include/asm/bug.h    |    2 +-
  arch/blackfin/include/asm/bug.h |    2 +-
  arch/mips/include/asm/bug.h     |    4 +---
  arch/mn10300/include/asm/bug.h  |    3 ++-
  arch/parisc/include/asm/bug.h   |    4 ++--
  arch/powerpc/include/asm/bug.h  |    2 +-
  arch/s390/include/asm/bug.h     |    2 +-
  arch/x86/include/asm/bug.h      |    4 ++--
  include/linux/compiler-gcc4.h   |   14 ++++++++++++++
  include/linux/compiler.h        |    5 +++++
  11 files changed, 31 insertions(+), 13 deletions(-)
