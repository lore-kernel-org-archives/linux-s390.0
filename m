Return-Path: <linux-kernel-owner+w=401wt.eu-S1757919AbZGHQ77@vger.kernel.org>
Date: Wed, 8 Jul 2009 18:59:46 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for v2.6.31-rc2
Message-ID: <20090708185946.58d903c1@skybase>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from 'for-linus' branch of

	git://git390.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

Christian Borntraeger (1):
      [S390] improve suspend/resume error messages

Frank Munzert (1):
      [S390] shutdown actions: save/return rc from init function

Heiko Carstens (6):
      [S390] sclp: fix compile error for !SCLP_CONSOLE
      [S390] monreader: fix dev_set_drvdata conversion
      [S390] udelay: disable lockdep to avoid false positives
      [S390] perf_counter build fix
      [S390] add __ucmpdi2() helper function
      [S390] add generic atomic64 support for 31 bit

Martin Schwidefsky (2):
      [S390] set SCHED_OMIT_FRAME_POINTER for s390
      [S390] define KTIME_SCALAR for 32-bit s390

Stefan Haberland (1):
      [S390] dasd: correct debugfeature sense dump

 arch/s390/Kconfig                    |    8 ++++++
 arch/s390/include/asm/atomic.h       |    7 ++++-
 arch/s390/include/asm/perf_counter.h |    2 +
 arch/s390/kernel/ipl.c               |   15 ++++++----
 arch/s390/lib/Makefile               |    2 +-
 arch/s390/lib/delay.c                |    2 +
 arch/s390/lib/ucmpdi2.c              |   26 ++++++++++++++++++
 drivers/s390/block/dasd_eckd.c       |   47 ++++++++-------------------------
 drivers/s390/block/dasd_erp.c        |    2 +-
 drivers/s390/block/dasd_fba.c        |   25 ++++++++++--------
 drivers/s390/block/dasd_int.h        |    3 +-
 drivers/s390/block/dcssblk.c         |    7 +++--
 drivers/s390/block/xpram.c           |    2 +-
 drivers/s390/char/monreader.c        |    4 +-
 drivers/s390/char/sclp_rw.h          |    5 +++
 drivers/s390/char/vmwatchdog.c       |    8 +++---
 16 files changed, 98 insertions(+), 67 deletions(-)
 create mode 100644 arch/s390/lib/ucmpdi2.c

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index e577839..2ae5d72 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -95,6 +95,11 @@ config S390
 	select HAVE_ARCH_TRACEHOOK
 	select INIT_ALL_POSSIBLE
 	select HAVE_PERF_COUNTERS
+	select GENERIC_ATOMIC64 if !64BIT
+
+config SCHED_OMIT_FRAME_POINTER
+	bool
+	default y
 
 source "init/Kconfig"
 
@@ -116,6 +121,9 @@ config 32BIT
 	bool
 	default y if !64BIT
 
+config KTIME_SCALAR
+	def_bool 32BIT
+
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
diff --git a/arch/s390/include/asm/atomic.h b/arch/s390/include/asm/atomic.h
index fca9dff..c7d0abf 100644
--- a/arch/s390/include/asm/atomic.h
+++ b/arch/s390/include/asm/atomic.h
@@ -268,7 +268,12 @@ static __inline__ int atomic64_add_unless(atomic64_t *v,
 #define atomic64_inc_not_zero(v) atomic64_add_unless((v), 1, 0)
 
 #undef __CSG_LOOP
-#endif
+
+#else /* __s390x__ */
+
+#include <asm-generic/atomic64.h>
+
+#endif /* __s390x__ */
 
 #define smp_mb__before_atomic_dec()	smp_mb()
 #define smp_mb__after_atomic_dec()	smp_mb()
diff --git a/arch/s390/include/asm/perf_counter.h b/arch/s390/include/asm/perf_counter.h
index a7205a3..7015188 100644
--- a/arch/s390/include/asm/perf_counter.h
+++ b/arch/s390/include/asm/perf_counter.h
@@ -6,3 +6,5 @@
 
 static inline void set_perf_counter_pending(void) {}
 static inline void clear_perf_counter_pending(void) {}
+
+#define PERF_COUNTER_INDEX_OFFSET 0
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index b8bf4b1..371a2d8 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -70,6 +70,7 @@ struct shutdown_action {
 	char *name;
 	void (*fn) (struct shutdown_trigger *trigger);
 	int (*init) (void);
+	int init_rc;
 };
 
 static char *ipl_type_str(enum ipl_type type)
@@ -1486,11 +1487,13 @@ static int set_trigger(const char *buf, struct shutdown_trigger *trigger,
 	int i;
 
 	for (i = 0; i < SHUTDOWN_ACTIONS_COUNT; i++) {
-		if (!shutdown_actions_list[i])
-			continue;
 		if (sysfs_streq(buf, shutdown_actions_list[i]->name)) {
-			trigger->action = shutdown_actions_list[i];
-			return len;
+			if (shutdown_actions_list[i]->init_rc) {
+				return shutdown_actions_list[i]->init_rc;
+			} else {
+				trigger->action = shutdown_actions_list[i];
+				return len;
+			}
 		}
 	}
 	return -EINVAL;
@@ -1640,8 +1643,8 @@ static void __init shutdown_actions_init(void)
 	for (i = 0; i < SHUTDOWN_ACTIONS_COUNT; i++) {
 		if (!shutdown_actions_list[i]->init)
 			continue;
-		if (shutdown_actions_list[i]->init())
-			shutdown_actions_list[i] = NULL;
+		shutdown_actions_list[i]->init_rc =
+			shutdown_actions_list[i]->init();
 	}
 }
 
diff --git a/arch/s390/lib/Makefile b/arch/s390/lib/Makefile
index ab6735d..97975ec 100644
--- a/arch/s390/lib/Makefile
+++ b/arch/s390/lib/Makefile
@@ -3,6 +3,6 @@
 #
 
 lib-y += delay.o string.o uaccess_std.o uaccess_pt.o
-obj-$(CONFIG_32BIT) += div64.o qrnnd.o
+obj-$(CONFIG_32BIT) += div64.o qrnnd.o ucmpdi2.o
 lib-$(CONFIG_64BIT) += uaccess_mvcos.o
 lib-$(CONFIG_SMP) += spinlock.o
diff --git a/arch/s390/lib/delay.c b/arch/s390/lib/delay.c
index 3f5f680..97c1eca 100644
--- a/arch/s390/lib/delay.c
+++ b/arch/s390/lib/delay.c
@@ -36,9 +36,11 @@ static void __udelay_disabled(unsigned long usecs)
 	cr0 = (cr0_saved & 0xffff00e0) | 0x00000800;
 	__ctl_load(cr0 , 0, 0);
 	mask = psw_kernel_bits | PSW_MASK_WAIT | PSW_MASK_EXT;
+	lockdep_off();
 	trace_hardirqs_on();
 	__load_psw_mask(mask);
 	local_irq_disable();
+	lockdep_on();
 	__ctl_load(cr0_saved, 0, 0);
 	local_tick_enable(clock_saved);
 	set_clock_comparator(S390_lowcore.clock_comparator);
diff --git a/arch/s390/lib/ucmpdi2.c b/arch/s390/lib/ucmpdi2.c
new file mode 100644
index 0000000..3e05ff5
--- /dev/null
+++ b/arch/s390/lib/ucmpdi2.c
@@ -0,0 +1,26 @@
+#include <linux/module.h>
+
+union ull_union {
+	unsigned long long ull;
+	struct {
+		unsigned int high;
+		unsigned int low;
+	} ui;
+};
+
+int __ucmpdi2(unsigned long long a, unsigned long long b)
+{
+	union ull_union au = {.ull = a};
+	union ull_union bu = {.ull = b};
+
+	if (au.ui.high < bu.ui.high)
+		return 0;
+	else if (au.ui.high > bu.ui.high)
+		return 2;
+	if (au.ui.low < bu.ui.low)
+		return 0;
+	else if (au.ui.low > bu.ui.low)
+		return 2;
+	return 1;
+}
+EXPORT_SYMBOL(__ucmpdi2);
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index f8b1f04..c11770f 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1696,8 +1696,7 @@ static void dasd_eckd_handle_unsolicited_interrupt(struct dasd_device *device,
 		DBF_DEV_EVENT(DBF_ERR, device, "%s",
 			    "unsolicited interrupt received "
 			    "(sense available)");
-		device->discipline->dump_sense_dbf(device, NULL, irb,
-						   "unsolicited");
+		device->discipline->dump_sense_dbf(device, irb, "unsolicited");
 	}
 
 	dasd_schedule_device_bh(device);
@@ -2941,42 +2940,20 @@ dasd_eckd_dump_ccw_range(struct ccw1 *from, struct ccw1 *to, char *page)
 }
 
 static void
-dasd_eckd_dump_sense_dbf(struct dasd_device *device, struct dasd_ccw_req *req,
-			 struct irb *irb, char *reason)
+dasd_eckd_dump_sense_dbf(struct dasd_device *device, struct irb *irb,
+			 char *reason)
 {
 	u64 *sense;
-	int sl;
-	struct tsb *tsb;
 
-	sense = NULL;
-	tsb = NULL;
-	if (req && scsw_is_tm(&req->irb.scsw)) {
-		if (irb->scsw.tm.tcw)
-			tsb = tcw_get_tsb(
-				(struct tcw *)(unsigned long)irb->scsw.tm.tcw);
-		if (tsb && (irb->scsw.tm.fcxs == 0x01)) {
-			switch (tsb->flags & 0x07) {
-			case 1:	/* tsa_iostat */
-				sense = (u64 *)tsb->tsa.iostat.sense;
-			break;
-			case 2: /* ts_ddpc */
-				sense = (u64 *)tsb->tsa.ddpc.sense;
-			break;
-			case 3: /* tsa_intrg */
-			break;
-			}
-		}
-	} else {
-		if (irb->esw.esw0.erw.cons)
-			sense = (u64 *)irb->ecw;
-	}
+	sense = (u64 *) dasd_get_sense(irb);
 	if (sense) {
-		for (sl = 0; sl < 4; sl++) {
-			DBF_DEV_EVENT(DBF_EMERG, device,
-				      "%s: %016llx %016llx %016llx %016llx",
-				      reason, sense[0], sense[1], sense[2],
-				      sense[3]);
-		}
+		DBF_DEV_EVENT(DBF_EMERG, device,
+			      "%s: %s %02x%02x%02x %016llx %016llx %016llx "
+			      "%016llx", reason,
+			      scsw_is_tm(&irb->scsw) ? "t" : "c",
+			      scsw_cc(&irb->scsw), scsw_cstat(&irb->scsw),
+			      scsw_dstat(&irb->scsw), sense[0], sense[1],
+			      sense[2], sense[3]);
 	} else {
 		DBF_DEV_EVENT(DBF_EMERG, device, "%s",
 			      "SORRY - NO VALID SENSE AVAILABLE\n");
diff --git a/drivers/s390/block/dasd_erp.c b/drivers/s390/block/dasd_erp.c
index d970ce2..cb8f9ce 100644
--- a/drivers/s390/block/dasd_erp.c
+++ b/drivers/s390/block/dasd_erp.c
@@ -172,7 +172,7 @@ dasd_log_sense_dbf(struct dasd_ccw_req *cqr, struct irb *irb)
 	device = cqr->startdev;
 	/* dump sense data to s390 debugfeature*/
 	if (device->discipline && device->discipline->dump_sense_dbf)
-		device->discipline->dump_sense_dbf(device, cqr, irb, "log");
+		device->discipline->dump_sense_dbf(device, irb, "log");
 }
 EXPORT_SYMBOL(dasd_log_sense_dbf);
 
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index e21ee73..31849ad 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -241,7 +241,7 @@ static void dasd_fba_handle_unsolicited_interrupt(struct dasd_device *device,
 	/* check for unsolicited interrupts */
 	DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 		    "unsolicited interrupt received");
-	device->discipline->dump_sense_dbf(device, NULL, irb, "unsolicited");
+	device->discipline->dump_sense_dbf(device, irb, "unsolicited");
 	dasd_schedule_device_bh(device);
 	return;
 };
@@ -444,17 +444,20 @@ dasd_fba_fill_info(struct dasd_device * device,
 }
 
 static void
-dasd_fba_dump_sense_dbf(struct dasd_device *device, struct dasd_ccw_req *req,
-			 struct irb *irb, char *reason)
+dasd_fba_dump_sense_dbf(struct dasd_device *device, struct irb *irb,
+			char *reason)
 {
-	int sl;
-	if (irb->esw.esw0.erw.cons) {
-		for (sl = 0; sl < 4; sl++) {
-			DBF_DEV_EVENT(DBF_EMERG, device,
-				      "%s: %08x %08x %08x %08x",
-				      reason, irb->ecw[8 * 0], irb->ecw[8 * 1],
-				      irb->ecw[8 * 2], irb->ecw[8 * 3]);
-		}
+	u64 *sense;
+
+	sense = (u64 *) dasd_get_sense(irb);
+	if (sense) {
+		DBF_DEV_EVENT(DBF_EMERG, device,
+			      "%s: %s %02x%02x%02x %016llx %016llx %016llx "
+			      "%016llx", reason,
+			      scsw_is_tm(&irb->scsw) ? "t" : "c",
+			      scsw_cc(&irb->scsw), scsw_cstat(&irb->scsw),
+			      scsw_dstat(&irb->scsw), sense[0], sense[1],
+			      sense[2], sense[3]);
 	} else {
 		DBF_DEV_EVENT(DBF_EMERG, device, "%s",
 			      "SORRY - NO VALID SENSE AVAILABLE\n");
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index fd63b2f..b699ca3 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -284,8 +284,7 @@ struct dasd_discipline {
 	dasd_erp_fn_t(*erp_postaction) (struct dasd_ccw_req *);
 	void (*dump_sense) (struct dasd_device *, struct dasd_ccw_req *,
 			    struct irb *);
-	void (*dump_sense_dbf) (struct dasd_device *, struct dasd_ccw_req *,
-			    struct irb *, char *);
+	void (*dump_sense_dbf) (struct dasd_device *, struct irb *, char *);
 
 	void (*handle_unsolicited_interrupt) (struct dasd_device *,
 					      struct irb *);
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 016f9e9..d346176 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -964,7 +964,8 @@ static int dcssblk_freeze(struct device *dev)
 			break;
 	}
 	if (rc)
-		pr_err("Suspend failed because device %s is writeable.\n",
+		pr_err("Suspending the system failed because DCSS device %s "
+		       "is writable\n",
 		       dev_info->segment_name);
 	return rc;
 }
@@ -987,8 +988,8 @@ static int dcssblk_restore(struct device *dev)
 				goto out_panic;
 			}
 			if (start != entry->start || end != entry->end) {
-				pr_err("Mismatch of start / end address after "
-				       "resuming device %s\n",
+				pr_err("The address range of DCSS %s changed "
+				       "while the system was suspended\n",
 				       entry->segment_name);
 				goto out_panic;
 			}
diff --git a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
index 2e9e1ec..db442cd 100644
--- a/drivers/s390/block/xpram.c
+++ b/drivers/s390/block/xpram.c
@@ -443,7 +443,7 @@ fail:
  */
 static void xpram_resume_error(const char *message)
 {
-	pr_err("Resume error: %s\n", message);
+	pr_err("Resuming the system failed: %s\n", message);
 	panic("xpram resume error\n");
 }
 
diff --git a/drivers/s390/char/monreader.c b/drivers/s390/char/monreader.c
index 7892550..3234e90 100644
--- a/drivers/s390/char/monreader.c
+++ b/drivers/s390/char/monreader.c
@@ -320,7 +320,7 @@ static int mon_open(struct inode *inode, struct file *filp)
 		goto out_path;
 	}
 	filp->private_data = monpriv;
-	dev_set_drvdata(&monreader_device, monpriv);
+	dev_set_drvdata(monreader_device, monpriv);
 	unlock_kernel();
 	return nonseekable_open(inode, filp);
 
@@ -463,7 +463,7 @@ static struct miscdevice mon_dev = {
  *****************************************************************************/
 static int monreader_freeze(struct device *dev)
 {
-	struct mon_private *monpriv = dev_get_drvdata(&dev);
+	struct mon_private *monpriv = dev_get_drvdata(dev);
 	int rc;
 
 	if (!monpriv)
diff --git a/drivers/s390/char/sclp_rw.h b/drivers/s390/char/sclp_rw.h
index 85f491e..7a7bfc9 100644
--- a/drivers/s390/char/sclp_rw.h
+++ b/drivers/s390/char/sclp_rw.h
@@ -92,5 +92,10 @@ void sclp_set_columns(struct sclp_buffer *, unsigned short);
 void sclp_set_htab(struct sclp_buffer *, unsigned short);
 int sclp_chars_in_buffer(struct sclp_buffer *);
 
+#ifdef CONFIG_SCLP_CONSOLE
 void sclp_console_pm_event(enum sclp_pm_event sclp_pm_event);
+#else
+static inline void sclp_console_pm_event(enum sclp_pm_event sclp_pm_event) { }
+#endif
+
 #endif	/* __SCLP_RW_H__ */
diff --git a/drivers/s390/char/vmwatchdog.c b/drivers/s390/char/vmwatchdog.c
index cb7854c..f2bc287 100644
--- a/drivers/s390/char/vmwatchdog.c
+++ b/drivers/s390/char/vmwatchdog.c
@@ -250,14 +250,14 @@ static int vmwdt_resume(void)
 static int vmwdt_suspend(void)
 {
 	if (test_and_set_bit(VMWDT_OPEN, &vmwdt_is_open)) {
-		pr_err("The watchdog is in use. "
-			"This prevents hibernation or suspend.\n");
+		pr_err("The system cannot be suspended while the watchdog"
+			" is in use\n");
 		return NOTIFY_BAD;
 	}
 	if (test_bit(VMWDT_RUNNING, &vmwdt_is_open)) {
 		clear_bit(VMWDT_OPEN, &vmwdt_is_open);
-		pr_err("The watchdog is running. "
-			"This prevents hibernation or suspend.\n");
+		pr_err("The system cannot be suspended while the watchdog"
+			" is running\n");
 		return NOTIFY_BAD;
 	}
 	return NOTIFY_DONE;
