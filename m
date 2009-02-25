Return-Path: <linux-kernel-owner+w=401wt.eu-S1764680AbZBYP1Z@vger.kernel.org>
Message-Id: <20090225150831.217373674@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:37 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 15/46] lockdep: trace hardirq off in smp_send_stop
Content-Disposition: inline; filename=114-lockdep-send-stop.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

With lockdep we got the following trace after a panic:

Badness at /home/autobuild/BUILD/linux-2.6.28-20090204/kernel/lockdep.c:2878
[...]
Call Trace:
 [<0000000000176334>] lock_acquire+0x54/0xbc
 [<000000000050b4fe>] __atomic_notifier_call_chain+0x6e/0xdc
 [<000000000050b59c>] atomic_notifier_call_chain+0x30/0x44
 [<0000000000504274>] panic+0xd0/0x1e8
[...]
INFO: lockdep is turned off.
Last Breaking-Event-Address:
 [<0000000000170e62>] check_flags+0xae/0x15c
possible reason: unannotated irqs-off.

lockdep is right. We missed a trace_hardirq_off in our smp_send_stop
function and smp_send_stop is called before the panic call chain.

Reported-by: Mijo <Safradin mijo@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/smp.c |    2 ++
 1 file changed, 2 insertions(+)

Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c
+++ quilt-2.6/arch/s390/kernel/smp.c
@@ -32,6 +32,7 @@
 #include <linux/delay.h>
 #include <linux/cache.h>
 #include <linux/interrupt.h>
+#include <linux/irqflags.h>
 #include <linux/cpu.h>
 #include <linux/timex.h>
 #include <linux/bootmem.h>
@@ -75,6 +76,7 @@ void smp_send_stop(void)
 
 	/* Disable all interrupts/machine checks */
 	__load_psw_mask(psw_kernel_bits & ~PSW_MASK_MCHECK);
+	trace_hardirqs_off();
 
 	/* stop all processors */
 	for_each_online_cpu(cpu) {

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
