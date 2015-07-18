Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 18 Jul 2015 16:27:17 -0700
From: Guenter <linux@roeck-us.net>
Subject: Build error due to "x86/fpu, sched: Dynamically allocate 'struct
 fpu'"
Message-ID: <20150718232717.GA3235@groeck-UX31A>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux390@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Hi,

Commit 0c8c0f03e3a2 ("x86/fpu, sched: Dynamically allocate 'struct fpu'")
causes s390 builds in mainline to fail as follows.

arch/s390/kernel/traps.c: Assembler messages:
arch/s390/kernel/traps.c:262: Error: operand out of range
	(0x00000000000023e8 is not between 0x0000000000000000 and 0x0000000000000fff)
arch/s390/kernel/traps.c:300: Error: operand out of range
	(0x00000000000023e8 is not between 0x0000000000000000 and 0x0000000000000fff)

Bisect log is as follows.

# bad: [9d37e6679dfddbb5fa605fb2d7ff448f7cd6d038] Merge branch 'fixes' of git://ftp.arm.linux.org.uk/~rmk/linux-arm
# good: [bc0195aad0daa2ad5b0d76cce22b167bc3435590] Linux 4.2-rc2
git bisect start 'HEAD' 'v4.2-rc2'
# good: [a27507ca2d796cfa8d907de31ad730359c8a6d06] x86/nmi/64: Reorder nested NMI checks
git bisect good a27507ca2d796cfa8d907de31ad730359c8a6d06
# good: [eb254374a30cc53f976f2302f2198813a3b687ea] Merge tag 'staging-4.2-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect good eb254374a30cc53f976f2302f2198813a3b687ea
# good: [3a26a5b1513cddfc018c8e264979bc6e28f8ec1f] Merge branch 'akpm' (patches from Andrew)
git bisect good 3a26a5b1513cddfc018c8e264979bc6e28f8ec1f
# good: [f79a17bf268cc043eecffb65033b2e58fc037eef] Merge branch 'perf-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good f79a17bf268cc043eecffb65033b2e58fc037eef
# bad: [5aaeb5c01c5b6c0be7b7aadbf3ace9f3a4458c3d] x86/fpu, sched: Introduce CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT and use it on x86
git bisect bad 5aaeb5c01c5b6c0be7b7aadbf3ace9f3a4458c3d
# good: [36f1a77b3aa57c5c2eb1ae2d67d07c4350a78345] x86/nmi/64: Make the "NMI executing" variable more consistent
git bisect good 36f1a77b3aa57c5c2eb1ae2d67d07c4350a78345
# bad: [0c8c0f03e3a292e031596484275c14cf39c0ab7a] x86/fpu, sched: Dynamically allocate 'struct fpu'
git bisect bad 0c8c0f03e3a292e031596484275c14cf39c0ab7a
# good: [a97439aa1aec10387797b4abae3cf117de1c90d7] x86/entry/64, x86/nmi/64: Add CONFIG_DEBUG_ENTRY NMI testing code
git bisect good a97439aa1aec10387797b4abae3cf117de1c90d7
# first bad commit: [0c8c0f03e3a292e031596484275c14cf39c0ab7a] x86/fpu, sched: Dynamically allocate 'struct fpu'

Guenter
