Return-Path: <linux-kernel-owner+w=401wt.eu-S933881AbXKPO00@vger.kernel.org>
Message-Id: <20071116142526.155411036@de.ibm.com>
References: <20071116142441.484714036@de.ibm.com>
Date: Fri, 16 Nov 2007 15:24:43 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 02/10] magic sysrq: check for in_atomic before doing an console_unblank
Content-Disposition: inline; filename=002-console-unblank.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

When doing an magic sysrq reboot on s390 the following bug message
appears:

SysRq : Resetting
BUG: sleeping function called from invalid context at include/asm/semaphore.h:61

in_atomic():1, irqs_disabled():0
07000000004002a8 000000000fe6bc48 0000000000000002 0000000000000000
       000000000fe6bce8 000000000fe6bc60 000000000fe6bc60 000000000012a79a
       0000000000000000 07000000004002a8 0000000000000006 0000000000000000
       0000000000000000 000000000fe6bc48 000000000000000d 000000000fe6bcb8
       00000000004000c8 0000000000103234 000000000fe6bc48 000000000fe6bc90
Call Trace:
(��<00000000001031b2>| show_trace+0x12e/0x148)
 ��<000000000011ffca>| __might_sleep+0x10a/0x118
 ��<0000000000129fba>| acquire_console_sem+0x92/0xf4
 ��<000000000012a2ca>| console_unblank+0xc2/0xc8
 ��<0000000000107bb4>| machine_restart+0x54/0x6c
 ��<000000000028e806>| sysrq_handle_reboot+0x26/0x30
 ��<000000000028e52a>| __handle_sysrq+0xa6/0x180
 ��<0000000000140134>| run_workqueue+0xcc/0x18c
 ��<000000000014029a>| worker_thread+0xa6/0x108
 ��<00000000001458e4>| kthread+0x64/0x9c
 ��<0000000000106f0e>| kernel_thread_starter+0x6/0xc
 ��<0000000000106f08>| kernel_thread_starter+0x0/0xc

The only reason for doing a console_unblank on s390 is to flush the
log buffer. We have to check for in_atomic before doing a
console_unblank as the console is otherwise filled with an unrelated
bug message.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/setup.c linux-2.6-patched/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2007-10-09 22:31:38.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/setup.c	2007-11-16 14:27:37.000000000 +0100
@@ -347,7 +347,7 @@ void (*_machine_power_off)(void) = do_ma
 
 void machine_restart(char *command)
 {
-	if (!in_interrupt() || oops_in_progress)
+	if ((!in_interrupt() && !in_atomic()) || oops_in_progress)
 		/*
 		 * Only unblank the console if we are called in enabled
 		 * context or a bust_spinlocks cleared the way for us.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
