Return-Path: <linux-kernel-owner+w=401wt.eu-S1753834AbYJCUbx@vger.kernel.org>
Subject: [GIT PULL] last minute s390 fixes for 2.6.27
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Fri, 03 Oct 2008 22:06:09 +0200
Message-Id: <1223064369.31517.3.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive fixes for two regressions:

Heiko Carstens (1):
      [S390] nohz: Fix __udelay.

Jan Glauber (1):
      [S390] qdio: prevent stack clobber

 arch/s390/kernel/time.c       |    2 +
 arch/s390/lib/delay.c         |   88 +++++++++++++++++++++++++----------------
 drivers/s390/cio/qdio_setup.c |   55 +++++++++----------------
 3 files changed, 76 insertions(+), 69 deletions(-)

diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index ca114fe..06acb1a 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -169,6 +169,8 @@ void init_cpu_timer(void)
 
 static void clock_comparator_interrupt(__u16 code)
 {
+	if (S390_lowcore.clock_comparator == -1ULL)
+		set_clock_comparator(S390_lowcore.clock_comparator);
 }
 
 static void etr_timing_alert(struct etr_irq_parm *);
diff --git a/arch/s390/lib/delay.c b/arch/s390/lib/delay.c
index fc6ab60..0953cee 100644
--- a/arch/s390/lib/delay.c
+++ b/arch/s390/lib/delay.c
@@ -1,14 +1,9 @@
 /*
- *  arch/s390/lib/delay.c
  *    Precise Delay Loops for S390
  *
- *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
- *
- *  Derived from "arch/i386/lib/delay.c"
- *    Copyright (C) 1993 Linus Torvalds
- *    Copyright (C) 1997 Martin Mares <mj@atrey.karlin.mff.cuni.cz>
+ *    Copyright IBM Corp. 1999,2008
+ *    Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>,
+ *		 Heiko Carstens <heiko.carstens@de.ibm.com>,
  */
 
 #include <linux/sched.h>
@@ -29,30 +24,31 @@ void __delay(unsigned long loops)
 	asm volatile("0: brct %0,0b" : : "d" ((loops/2) + 1));
 }
 
-/*
- * Waits for 'usecs' microseconds using the TOD clock comparator.
- */
-void __udelay(unsigned long usecs)
+static void __udelay_disabled(unsigned long usecs)
 {
-	u64 end, time, old_cc = 0;
-	unsigned long flags, cr0, mask, dummy;
-	int irq_context;
+	unsigned long mask, cr0, cr0_saved;
+	u64 clock_saved;
 
-	irq_context = in_interrupt();
-	if (!irq_context)
-		local_bh_disable();
-	local_irq_save(flags);
-	if (raw_irqs_disabled_flags(flags)) {
-		old_cc = local_tick_disable();
-		S390_lowcore.clock_comparator = -1ULL;
-		__ctl_store(cr0, 0, 0);
-		dummy = (cr0 & 0xffff00e0) | 0x00000800;
-		__ctl_load(dummy , 0, 0);
-		mask = psw_kernel_bits | PSW_MASK_WAIT | PSW_MASK_EXT;
-	} else
-		mask = psw_kernel_bits | PSW_MASK_WAIT |
-			PSW_MASK_EXT | PSW_MASK_IO;
+	clock_saved = local_tick_disable();
+	set_clock_comparator(get_clock() + ((u64) usecs << 12));
+	__ctl_store(cr0_saved, 0, 0);
+	cr0 = (cr0_saved & 0xffff00e0) | 0x00000800;
+	__ctl_load(cr0 , 0, 0);
+	mask = psw_kernel_bits | PSW_MASK_WAIT | PSW_MASK_EXT;
+	trace_hardirqs_on();
+	__load_psw_mask(mask);
+	local_irq_disable();
+	__ctl_load(cr0_saved, 0, 0);
+	local_tick_enable(clock_saved);
+	set_clock_comparator(S390_lowcore.clock_comparator);
+}
 
+static void __udelay_enabled(unsigned long usecs)
+{
+	unsigned long mask;
+	u64 end, time;
+
+	mask = psw_kernel_bits | PSW_MASK_WAIT | PSW_MASK_EXT | PSW_MASK_IO;
 	end = get_clock() + ((u64) usecs << 12);
 	do {
 		time = end < S390_lowcore.clock_comparator ?
@@ -62,13 +58,37 @@ void __udelay(unsigned long usecs)
 		__load_psw_mask(mask);
 		local_irq_disable();
 	} while (get_clock() < end);
+	set_clock_comparator(S390_lowcore.clock_comparator);
+}
 
-	if (raw_irqs_disabled_flags(flags)) {
-		__ctl_load(cr0, 0, 0);
-		local_tick_enable(old_cc);
+/*
+ * Waits for 'usecs' microseconds using the TOD clock comparator.
+ */
+void __udelay(unsigned long usecs)
+{
+	unsigned long flags;
+
+	preempt_disable();
+	local_irq_save(flags);
+	if (in_irq()) {
+		__udelay_disabled(usecs);
+		goto out;
+	}
+	if (in_softirq()) {
+		if (raw_irqs_disabled_flags(flags))
+			__udelay_disabled(usecs);
+		else
+			__udelay_enabled(usecs);
+		goto out;
 	}
-	if (!irq_context)
+	if (raw_irqs_disabled_flags(flags)) {
+		local_bh_disable();
+		__udelay_disabled(usecs);
 		_local_bh_enable();
-	set_clock_comparator(S390_lowcore.clock_comparator);
+		goto out;
+	}
+	__udelay_enabled(usecs);
+out:
 	local_irq_restore(flags);
+	preempt_enable();
 }
diff --git a/drivers/s390/cio/qdio_setup.c b/drivers/s390/cio/qdio_setup.c
index 1679e2f..a0b6b46 100644
--- a/drivers/s390/cio/qdio_setup.c
+++ b/drivers/s390/cio/qdio_setup.c
@@ -447,51 +447,36 @@ void qdio_print_subchannel_info(struct qdio_irq *irq_ptr,
 {
 	char s[80];
 
-	sprintf(s, "%s sc:%x ", cdev->dev.bus_id, irq_ptr->schid.sch_no);
-
+	sprintf(s, "qdio: %s ", dev_name(&cdev->dev));
 	switch (irq_ptr->qib.qfmt) {
 	case QDIO_QETH_QFMT:
-		sprintf(s + strlen(s), "OSADE ");
+		sprintf(s + strlen(s), "OSA ");
 		break;
 	case QDIO_ZFCP_QFMT:
 		sprintf(s + strlen(s), "ZFCP ");
 		break;
 	case QDIO_IQDIO_QFMT:
-		sprintf(s + strlen(s), "HiperSockets ");
+		sprintf(s + strlen(s), "HS ");
 		break;
 	}
-	sprintf(s + strlen(s), "using: ");
-
-	if (!is_thinint_irq(irq_ptr))
-		sprintf(s + strlen(s), "no");
-	sprintf(s + strlen(s), "AdapterInterrupts ");
-	if (!(irq_ptr->sch_token != 0))
-		sprintf(s + strlen(s), "no");
-	sprintf(s + strlen(s), "QEBSM ");
-	if (!(irq_ptr->qib.ac & QIB_AC_OUTBOUND_PCI_SUPPORTED))
-		sprintf(s + strlen(s), "no");
-	sprintf(s + strlen(s), "OutboundPCI ");
-	if (!css_general_characteristics.aif_tdd)
-		sprintf(s + strlen(s), "no");
-	sprintf(s + strlen(s), "TDD\n");
-	printk(KERN_INFO "qdio: %s", s);
-
-	memset(s, 0, sizeof(s));
-	sprintf(s, "%s SIGA required: ", cdev->dev.bus_id);
-	if (irq_ptr->siga_flag.input)
-		sprintf(s + strlen(s), "Read ");
-	if (irq_ptr->siga_flag.output)
-		sprintf(s + strlen(s), "Write ");
-	if (irq_ptr->siga_flag.sync)
-		sprintf(s + strlen(s), "Sync ");
-	if (!irq_ptr->siga_flag.no_sync_ti)
-		sprintf(s + strlen(s), "SyncAI ");
-	if (!irq_ptr->siga_flag.no_sync_out_ti)
-		sprintf(s + strlen(s), "SyncOutAI ");
-	if (!irq_ptr->siga_flag.no_sync_out_pci)
-		sprintf(s + strlen(s), "SyncOutPCI");
+	sprintf(s + strlen(s), "on SC %x using ", irq_ptr->schid.sch_no);
+	sprintf(s + strlen(s), "AI:%d ", is_thinint_irq(irq_ptr));
+	sprintf(s + strlen(s), "QEBSM:%d ", (irq_ptr->sch_token) ? 1 : 0);
+	sprintf(s + strlen(s), "PCI:%d ",
+		(irq_ptr->qib.ac & QIB_AC_OUTBOUND_PCI_SUPPORTED) ? 1 : 0);
+	sprintf(s + strlen(s), "TDD:%d ", css_general_characteristics.aif_tdd);
+	sprintf(s + strlen(s), "SIGA:");
+	sprintf(s + strlen(s), "%s", (irq_ptr->siga_flag.input) ? "R" : " ");
+	sprintf(s + strlen(s), "%s", (irq_ptr->siga_flag.output) ? "W" : " ");
+	sprintf(s + strlen(s), "%s", (irq_ptr->siga_flag.sync) ? "S" : " ");
+	sprintf(s + strlen(s), "%s",
+		(!irq_ptr->siga_flag.no_sync_ti) ? "A" : " ");
+	sprintf(s + strlen(s), "%s",
+		(!irq_ptr->siga_flag.no_sync_out_ti) ? "O" : " ");
+	sprintf(s + strlen(s), "%s",
+		(!irq_ptr->siga_flag.no_sync_out_pci) ? "P" : " ");
 	sprintf(s + strlen(s), "\n");
-	printk(KERN_INFO "qdio: %s", s);
+	printk(KERN_INFO "%s", s);
 }
 
 int __init qdio_setup_init(void)
