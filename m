Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 18 Feb 2019 07:46:40 -0800
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] s390/setup: fix early warning messages
Message-ID: <20190218154640.GA27699@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi,

On Thu, Feb 14, 2019 at 03:40:56PM +0100, Martin Schwidefsky wrote:
> The setup_lowcore() function creates a new prefix page for the boot CPU.
> The PSW mask for the system_call, external interrupt, i/o interrupt and
> the program check handler have the DAT bit set in this new prefix page.
> 
> At the time setup_lowcore is called the system still runs without virtual
> address translation, the paging_init() function creates the kernel page
> table and loads the CR13 with the kernel ASCE.
> 
> Any code between setup_lowcore() and the end of paging_init() that has
> a BUG or WARN statement will create a program check that can not be
> handled correctly as there is no kernel page table yet.
> 
> To allow early WARN statements initially setup the lowcore with DAT off
> and set the DAT bit only after paging_init() has completed.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

This patch causes s390 qemu emulations to crash with a kernel stack overflow.
Reverting the patch fixes the problem. Crash log and bisect results below.

Guenter

---
# bad: [cb916fc5eabf8832e05f73c246eb467259846ef0] Add linux-next specific files for 20190218
# good: [d13937116f1e82bf508a6325111b322c30c85eb9] Linux 5.0-rc6
git bisect start 'HEAD' 'v5.0-rc6'
# bad: [8a076e150433e8623c844aef43b38889df81a503] Merge remote-tracking branch 'nand/nand/next'
git bisect bad 8a076e150433e8623c844aef43b38889df81a503
# bad: [3265789d1e2b7f1e88a8214ec0a22ccfc3b8a6f5] Merge remote-tracking branch 'i2c/i2c/for-next'
git bisect bad 3265789d1e2b7f1e88a8214ec0a22ccfc3b8a6f5
# good: [925a83c234b03380757f0588c11d0d374bbfe33e] Merge remote-tracking branch 'arm-soc/for-next'
git bisect good 925a83c234b03380757f0588c11d0d374bbfe33e
# bad: [53cec47975804529bb2aaaa1fe47b46ab2c2b10f] Merge remote-tracking branch 'btrfs-kdave/for-next'
git bisect bad 53cec47975804529bb2aaaa1fe47b46ab2c2b10f
# good: [4bbc817baaf6ee369dbc445603c6a2bd90d4529a] Merge remote-tracking branch 'mips/mips-next'
git bisect good 4bbc817baaf6ee369dbc445603c6a2bd90d4529a
# bad: [9398ebb7918864be50f2e4ce6c46e3666b50ccf7] Merge remote-tracking branch 's390/features'
git bisect bad 9398ebb7918864be50f2e4ce6c46e3666b50ccf7
# good: [b174b4fb919d118d9ac546b99a69574dfa431f7f] powerpc/powernv: Escalate reset when IODA reset fails
git bisect good b174b4fb919d118d9ac546b99a69574dfa431f7f
# good: [2c856ea847dca32aa7857aa5f54d2f60a5a7e3c8] Merge remote-tracking branch 'parisc-hd/for-next'
git bisect good 2c856ea847dca32aa7857aa5f54d2f60a5a7e3c8
# good: [a0308c1315e72b6fdce7b419c4546dad568b3a83] s390/mmap: take stack_guard_gap into account for mmap_base
git bisect good a0308c1315e72b6fdce7b419c4546dad568b3a83
# good: [058a78515d1229476b1e0641939532801d009f28] s390/jump_label: Use "jdd" constraint on gcc9
git bisect good 058a78515d1229476b1e0641939532801d009f28
# good: [e3d794d555cda31d48c89bdbc96ce862857be93f] riscv: treat cpu devicetree nodes without status as enabled
git bisect good e3d794d555cda31d48c89bdbc96ce862857be93f
# good: [43b2dd07c8e6cc5be50b83dd8bb8846eefdfb696] Merge remote-tracking branch 'risc-v/for-next'
git bisect good 43b2dd07c8e6cc5be50b83dd8bb8846eefdfb696
# bad: [94f85ed3e2f8fa4631868132117c014bcbad4e90] s390/setup: fix early warning messages
git bisect bad 94f85ed3e2f8fa4631868132117c014bcbad4e90
# first bad commit: [94f85ed3e2f8fa4631868132117c014bcbad4e90] s390/setup: fix early warning messages

---
Kernel stack overflow.
CPU: 0 PID: 2 Comm: swapper/0 Not tainted 5.0.0-rc6-next-20190218 #1
Hardware name: QEMU 2827 QEMU (KVM/Linux)
Krnl PSW : 0004c00180000000 0000000000b2c3e2 (pgm_check_handler+0x126/0x22c)
           R:0 T:0 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
Krnl GPRS: 81000e08ffff6400 0000000000000000 000000001fea26e8 000000000000008a
           0000000000b2c29c 0000000000000000 0000000000000000 0000000000000000
           0004c00180000000 0000000000b2c3e2 0000000000b2c342 000003e0000d8178
           000000001f84aa00 0000000000000000 000003e0000dbea8 000003e0000d80d8
Krnl Code: 0000000000b2c3d4: b90400db		lgr	%r13,%r11
           0000000000b2c3d8: 41b0f0a0		la	%r11,160(%r15)
          #0000000000b2c3dc: eb07b0180024	stmg	%r0,%r7,24(%r11)
          >0000000000b2c3e2: b9820000		xgr	%r0,%r0
           0000000000b2c3e6: b9820011		xgr	%r1,%r1
           0000000000b2c3ea: b9820022		xgr	%r2,%r2
           0000000000b2c3ee: b9820033		xgr	%r3,%r3
           0000000000b2c3f2: b9820044		xgr	%r4,%r4
Call Trace:
addressing exception: 0005 ilc:3 [#1] SMP 
Modules linked in:
CPU: 0 PID: 2 Comm: swapper/0 Not tainted 5.0.0-rc6-next-20190218 #1
Hardware name: QEMU 2827 QEMU (KVM/Linux)
Krnl PSW : 0004e00180000000 0000000000114d44 (__dump_trace+0x4c/0x110)
           R:0 T:0 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
Krnl GPRS: 01000dd4ffffff80 000000001fa48000 0000000000114e90 0000000000000000
           0000000000000000 000003e0000d8000 000003e0000dbf48 0000000000114e90
           000003e0000dbf60 0000000000000000 000003e0000d80d8 0000000000114e90
           000000001f84aa00 0000000000b2cd86 0000000000e2bdd0 0000000000e2bd78
Krnl Code: 0000000000114d36: a76bff48		aghi	%r6,-184
           0000000000114d3a: a7490000		lghi	%r4,0
          #0000000000114d3e: e330a0880004	lg	%r3,136(%r10)
          >0000000000114d44: b9040029		lgr	%r2,%r9
           0000000000114d48: 0de7		basr	%r14,%r7
           0000000000114d4a: 1222		ltr	%r2,%r2
           0000000000114d4c: b90400ca		lgr	%r12,%r10
           0000000000114d50: a7840017		brc	8,114d7e
Call Trace:
INFO: lockdep is turned off.
Last Breaking-Event-Address:
 [<0000000000114e6e>] dump_trace+0x66/0x88
addressing exception: 0005 ilc:3 [#2] SMP 
Modules linked in:
CPU: 0 PID: 2 Comm: swapper/0 Tainted: G      D           5.0.0-rc6-next-20190218 #1
Hardware name: QEMU 2827 QEMU (KVM/Linux)
Krnl PSW : 0004e00180000000 00000000001df7c0 (cpuacct_charge+0x40/0x218)
           R:0 T:0 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
Krnl GPRS: 0000000000014ad4 000003e0000d8000 0000000000003000 0000000000f925f5
           fffffffffff00000 ffffffffff34a0cb 0000000000000000 000000001febfe18
           0000000000e420a8 000000001f84aa00 000000001f84aa00 0000000000f925f5
           0000000000f925f5 0000000000b46d78 000000001fa4bbd0 000000001fa4bb68
Krnl Code: 00000000001df7b2: a78400ef		brc	8,1df990
           00000000001df7b6: a7293000		lghi	%r2,12288
          #00000000001df7ba: e3321f500091	llgh	%r3,3920(%r2,%r1)
          >00000000001df7c0: e330d0000082	xg	%r3,0(%r13)
           00000000001df7c6: 5430d008		n	%r3,8(%r13)
           00000000001df7ca: 581003a0		l	%r1,928
           00000000001df7ce: a71a0001		ahi	%r1,1
           00000000001df7d2: a7b800ff		lhi	%r11,255
Call Trace:
([<0000000000000001>] 0x1)
 [<00000000001b81ba>] update_curr+0x18a/0x488 
 [<00000000001be4ac>] task_tick_fair+0x4c/0x7e0 
 [<00000000001b2c82>] scheduler_tick+0x9a/0x130 
 [<0000000000230196>] update_process_times+0x56/0x68 
 [<0000000000243932>] tick_sched_handle.isra.5+0x52/0x78 
 [<00000000002439bc>] tick_sched_timer+0x64/0xc8 
 [<0000000000230ffc>] __hrtimer_run_queues+0x144/0x510 
 [<00000000002321fa>] hrtimer_interrupt+0x102/0x248 
 [<000000000010dbd4>] do_IRQ+0x6c/0xb0 
 [<0000000000b2c900>] ext_int_handler+0x130/0x134 
 [<0000000000b2b34c>] _raw_spin_unlock_irq+0x44/0x60 
INFO: lockdep is turned off.
Last Breaking-Event-Address:
 [<00000000001b81b4>] update_curr+0x184/0x488
Kernel panic - not syncing: Fatal exception in interrupt
