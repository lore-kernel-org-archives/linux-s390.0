Return-Path: <linux-arch-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [RFC/PATCH 00/14] split exception table content out of module.h into extable.h 
Date: Sun, 24 Jul 2016 23:42:33 -0400
Message-ID: <20160725034247.109173-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160725034233.541Y113BCUhDDqGGw7fcD1n0XVfabu3dtCeoYCH0h-I@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Andrew Morton <akpm@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, Chris Metcalf <cmetcalf@mellanox.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Linus Torvalds <torvalds@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Henderson <rth@twiddle.net>, Russell King <linux@armlinux.org.uk>, Rusty Russell <rusty@rustcorp.com.au>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-m68k@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, x86@kernel.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

[RFC: Not looking for detailed review given the merge window is open.
 As long as nobody thinks the general idea is horrible, I'll expand into
 more fringe arch and resend in 2wks and get it added then to linux-next.]

While doing an audit looking for unnecessary instances of module.h
inclusion across arch/x86/ I found a significant number of includes
of module.h were for things like search_exception_table and friends.

For historical reasons (i.e. pre-git) the exception table stuff was
buried in the middle of the module.h file.  So we have core kernel
files that are completely non-modular (both arch specific and arch
independent) that are just including module.h for this.

The converse is also true, in that conventional drivers, be they for
filesystems or actual hardware peripherals or similar, do not
normally care about the exception tables.

Here we fork the exception table content out of module.h into a new
extable.h file.  The gain here is that module.h gets a bit smaller;
a win for all modular drivers that we build for allmodconfig.  Also
most core files that only need exception table stuff get to shed an
include of module.h that brings in lots of extra stuff and just
looks generally out of place.  They use the tiny extable.h instead.

We temporarily include extable.h into the module.h itself.  Then we
will work our way across the arch independent and arch specific
files needing just exception table content, and move them off
module.h and onto extable.h

Once that is done, we can remove the extable.h from module.h and in
doing it like this, we avoid introducing build failures into the git
history.

We have the option of taking this final one line commit and pushing
it out a complete release if we want to open up a bigger window for
converting some of the more fringe archtectures.

I've converted about a dozen architectures here w/o issue; that
largely reflects what I currently have toolchains for.  Build
testing seems necessary in all instances, since the odds are high
that the module.h presence was hiding implicit use of other headers,
as was the case for s390.

Paul.
-- 

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Helge Deller <deller@gmx.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-alpha@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@linux-mips.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: x86@kernel.org
Cc: sparclinux@vger.kernel.org

Paul Gortmaker (14):
  exceptions: fork exception table content from module.h into extable.h
  x86: migrate exception table users off module.h and onto extable.h
  arm: migrate exception table users off module.h and onto extable.h
  arm64: migrate exception table users off module.h and onto extable.h
  mips: migrate exception table users off module.h and onto extable.h
  sparc: migrate exception table users off module.h and onto extable.h
  powerpc: migrate exception table users off module.h and onto extable.h
  m68k: migrate exception table users off module.h and onto extable.h
  s390: migrate exception table users off module.h and onto extable.h
  tile: migrate exception table users off module.h and onto extable.h
  alpha: migrate exception table users off module.h and onto extable.h
  parisc: migrate exception table users off module.h and onto extable.h
  core: migrate exception table users off module.h and onto extable.h
  module.h: remove extable.h include now users have migrated

 arch/alpha/kernel/traps.c          |  2 +-
 arch/alpha/mm/fault.c              |  2 +-
 arch/arm/mm/extable.c              |  2 +-
 arch/arm/mm/fault.c                |  2 +-
 arch/arm64/kernel/probes/kprobes.c |  2 +-
 arch/arm64/mm/extable.c            |  2 +-
 arch/arm64/mm/fault.c              |  2 +-
 arch/m68k/kernel/signal.c          |  2 +-
 arch/mips/kernel/module.c          |  1 +
 arch/mips/kernel/traps.c           |  2 +-
 arch/mips/mm/extable.c             |  2 +-
 arch/parisc/mm/fault.c             |  2 +-
 arch/powerpc/kernel/kprobes.c      |  2 +-
 arch/powerpc/mm/fault.c            |  2 +-
 arch/s390/kernel/early.c           |  2 +-
 arch/s390/kernel/kprobes.c         |  2 ++
 arch/s390/kernel/traps.c           |  3 ++-
 arch/s390/mm/fault.c               |  2 +-
 arch/sparc/kernel/kprobes.c        |  2 +-
 arch/sparc/kernel/traps_64.c       |  2 +-
 arch/sparc/kernel/unaligned_64.c   |  2 +-
 arch/sparc/mm/fault_64.c           |  2 +-
 arch/sparc/mm/init_64.c            |  2 +-
 arch/tile/kernel/unaligned.c       |  2 +-
 arch/tile/mm/extable.c             |  2 +-
 arch/tile/mm/fault.c               |  2 +-
 arch/x86/kernel/kprobes/core.c     |  2 +-
 arch/x86/kernel/kprobes/opt.c      |  2 +-
 arch/x86/mm/extable.c              |  2 +-
 arch/x86/mm/fault.c                |  2 +-
 include/linux/extable.h            | 30 ++++++++++++++++++++++++++++++
 include/linux/module.h             | 26 +-------------------------
 init/main.c                        |  1 +
 kernel/extable.c                   |  1 +
 kernel/module.c                    |  1 +
 35 files changed, 66 insertions(+), 53 deletions(-)
 create mode 100644 include/linux/extable.h

-- 
2.8.4
