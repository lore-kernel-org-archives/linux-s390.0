Return-Path: <qy03fugy@stud.informatik.uni-erlangen.de>
Date: Mon, 6 Sep 2010 16:35:49 +0200
From: Christian Dietrich <qy03fugy@stud.informatik.uni-erlangen.de>
Subject: [PATCH 00/14] Removing dead code
Message-ID: <cover.1283782698.git.qy03fugy@stud.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Lennert Buytenhek <kernel@wantstofly.org>, Russell King <linux@arm.linux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Akinobu Mita <akinobu.mita@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Alexander Graf <agraf@suse.de>, "K.Prasad" <prasad@linux.vnet.ibm.com>, Dave Kleikamp <shaggy@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Borislav Petkov <borislav.petkov@amd.com>, "David S. Miller" <davem@davemloft.net>, Roland Dreier <rolandd@cisco.com>, Alexey Dobriyan <adobriyan@gmail.com>, Joe Perches <joe@perches.com>, "Juergen E. Fischer" <fischer@norbit.de>, Tejun Heo <tj@kernel.org>, Krzysztof Helt <krzysztof.h1@wp.pl>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Petr Vandrovec <vandrove@vc.cvut.cz>, Jean Delvare <khali@linux-fr.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Ben Hutchings <ben@decadent.org.uk>, Cyrill Gorcunov <gorcunov@openvz.org>, Peter Zijlstra <peterz@infradead.org>, Mike Galbraith <efault@gmx.de>, Dipankar Sarma <dipankar@in.ibm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Josh Triplett <josh@joshtriplett.org>, Lai Jiangshan <laijs@cn.fujitsu.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: vamos-dev@i4.informatik.uni-erlangen.de
List-ID: <linux-s390.vger.kernel.org>

Hi all!
       
As part of the VAMOS[0] research project at the University of Erlangen
we are looking at multiple integrity errors in linux' configuration
system.

I've been running a check on the whole sourcetree for
code block which are undead. This means they can't be deselected and
are always in the kernel if the enviroment of the block is
selected. They have often the form of

#ifdef ABC
....
#ifdef ABC
fooooo
#endif
#endif

Here the ifdefs of the inner block can be removed without any harm. At
this point we just checked the source code (for the undead), but we
want to do a crosscheck with the Kconfig for undead code blocks in the
future.

I build the patches against a vanilla kernel (v2.6.36-rc3) in order to
try if the kernel compiles with this patches.

Please keep me informed of this patch getting confirmed / merged so we
can keep track of it.

Regards

        Christian Dietrich

[0] http://vamos1.informatik.uni-erlangen.de/

Christian Dietrich (14):
  arch/arm: Removing undead ifdef __ASSEMBLY__
  arch/h8300: Removing dead ifdef __H8300_TLB_H__
  arch/parisc: Removing undead ifdef CONFIG_PA20
  arch/{s390,powerpc}: Removing undead ifdef __KERNEL__
  arch/x86: Removing undead ifdef ACPI/X86_IO_ACPI
  drivers/net: Removing undead ifdef CHELSIO_T1_1G
  drivers/scsi: Removing undead ifdef __ISAPNP__
  drivers/scsi: Removing undead ifdef CONFIG_PCI
  drivers/scsi: Removing undead ifdef REAL_DMA
  drivers/video: Removing undead ifdef ATAFB_FALCON
  drivers/video: Removing undead ifdef CONFIG_FB_MATROX_G
  include/linux: Removing undead ifdef __KERNEL__
  kernel/: Removing undead ifdef CONFIG_SMP
  kernel/: Removing undead ifdef CONFIG_DEBUG_LOCK_ALLOC

 arch/arm/mach-ixp23xx/include/mach/platform.h |    3 ---
 arch/h8300/include/asm/tlb.h                  |   13 -------------
 arch/parisc/kernel/unaligned.c                |    3 ---
 arch/powerpc/include/asm/processor.h          |    2 --
 arch/powerpc/include/asm/vdso_datapage.h      |    2 --
 arch/s390/include/asm/processor.h             |    4 ----
 arch/x86/kernel/early-quirks.c                |    2 --
 drivers/net/chelsio/subr.c                    |    2 --
 drivers/scsi/aha152x.c                        |    2 --
 drivers/scsi/aic7xxx_old.c                    |    2 --
 drivers/scsi/atari_NCR5380.c                  |    6 ------
 drivers/video/atafb.c                         |    2 --
 drivers/video/matrox/matroxfb_DAC1064.c       |    5 +----
 include/linux/socket.h                        |    6 +-----
 kernel/sched.c                                |    4 +---
 kernel/srcu.c                                 |    2 --
 16 files changed, 3 insertions(+), 57 deletions(-)
