Return-Path: <linux-kernel-owner+w=401wt.eu-S1757459AbYFCRIi@vger.kernel.org>
Message-Id: <20080603170521.709812025@de.ibm.com>
References: <20080603165859.107949986@de.ibm.com>
Date: Tue, 03 Jun 2008 18:59:13 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 14/14] stp support.
Content-Disposition: inline; filename=113-stp.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Add support for clock synchronization with the server time protocol.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/time.c |  634 ++++++++++++++++++++++++++++++++++++------------
 drivers/s390/cio/chsc.c |   49 +++
 drivers/s390/s390mach.c |    4 
 drivers/s390/s390mach.h |    3 
 include/asm-s390/etr.h  |   45 +++
 5 files changed, 582 insertions(+), 153 deletions(-)

Index: quilt-2.6/arch/s390/kernel/time.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/time.c
+++ quilt-2.6/arch/s390/kernel/time.c
@@ -3,7 +3,7 @@
  *    Time of day based timer functions.
  *
  *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Copyright IBM Corp. 1999, 2008
  *    Author(s): Hartmut Penner (hp@de.ibm.com),
  *               Martin Schwidefsky (schwidefsky@de.ibm.com),
  *               Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com)
@@ -31,6 +31,7 @@
 #include <linux/notifier.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
+#include <linux/bootmem.h>
 #include <asm/uaccess.h>
 #include <asm/delay.h>
 #include <asm/s390_ext.h>
@@ -162,7 +163,7 @@ void init_cpu_timer(void)
 	/* Enable clock comparator timer interrupt. */
 	__ctl_set_bit(0,11);
 
-	/* Always allow ETR external interrupts, even without an ETR. */
+	/* Always allow the timing alert external interrupt. */
 	__ctl_set_bit(0, 4);
 }
 
@@ -170,8 +171,21 @@ static void clock_comparator_interrupt(_
 {
 }
 
+static void etr_timing_alert(struct etr_irq_parm *);
+static void stp_timing_alert(struct stp_irq_parm *);
+
+static void timing_alert_interrupt(__u16 code)
+{
+	if (S390_lowcore.ext_params & 0x00c40000)
+		etr_timing_alert((struct etr_irq_parm *)
+				 &S390_lowcore.ext_params);
+	if (S390_lowcore.ext_params & 0x00038000)
+		stp_timing_alert((struct stp_irq_parm *)
+				 &S390_lowcore.ext_params);
+}
+
 static void etr_reset(void);
-static void etr_ext_handler(__u16);
+static void stp_reset(void);
 
 /*
  * Get the TOD clock running.
@@ -181,6 +195,7 @@ static u64 __init reset_tod_clock(void)
 	u64 time;
 
 	etr_reset();
+	stp_reset();
 	if (store_clock(&time) == 0)
 		return time;
 	/* TOD clock not running. Set the clock to Unix Epoch. */
@@ -231,8 +246,9 @@ void __init time_init(void)
 	if (clocksource_register(&clocksource_tod) != 0)
 		panic("Could not register TOD clock source");
 
-	/* request the etr external interrupt */
-	if (register_early_external_interrupt(0x1406, etr_ext_handler,
+	/* request the timing alert external interrupt */
+	if (register_early_external_interrupt(0x1406,
+					      timing_alert_interrupt,
 					      &ext_int_etr_cc) != 0)
 		panic("Couldn't request external interrupt 0x1406");
 
@@ -245,10 +261,112 @@ void __init time_init(void)
 }
 
 /*
+ * The time is "clock". old is what we think the time is.
+ * Adjust the value by a multiple of jiffies and add the delta to ntp.
+ * "delay" is an approximation how long the synchronization took. If
+ * the time correction is positive, then "delay" is subtracted from
+ * the time difference and only the remaining part is passed to ntp.
+ */
+static unsigned long long adjust_time(unsigned long long old,
+				      unsigned long long clock,
+				      unsigned long long delay)
+{
+	unsigned long long delta, ticks;
+	struct timex adjust;
+
+	if (clock > old) {
+		/* It is later than we thought. */
+		delta = ticks = clock - old;
+		delta = ticks = (delta < delay) ? 0 : delta - delay;
+		delta -= do_div(ticks, CLK_TICKS_PER_JIFFY);
+		adjust.offset = ticks * (1000000 / HZ);
+	} else {
+		/* It is earlier than we thought. */
+		delta = ticks = old - clock;
+		delta -= do_div(ticks, CLK_TICKS_PER_JIFFY);
+		delta = -delta;
+		adjust.offset = -ticks * (1000000 / HZ);
+	}
+	jiffies_timer_cc += delta;
+	if (adjust.offset != 0) {
+		printk(KERN_NOTICE "etr: time adjusted by %li micro-seconds\n",
+		       adjust.offset);
+		adjust.modes = ADJ_OFFSET_SINGLESHOT;
+		do_adjtimex(&adjust);
+	}
+	return delta;
+}
+
+static DEFINE_PER_CPU(atomic_t, clock_sync_word);
+static unsigned long clock_sync_flags;
+
+#define CLOCK_SYNC_HAS_ETR	0
+#define CLOCK_SYNC_HAS_STP	1
+#define CLOCK_SYNC_ETR		2
+#define CLOCK_SYNC_STP		3
+
+/*
+ * The synchronous get_clock function. It will write the current clock
+ * value to the clock pointer and return 0 if the clock is in sync with
+ * the external time source. If the clock mode is local it will return
+ * -ENOSYS and -EAGAIN if the clock is not in sync with the external
+ * reference.
+ */
+int get_sync_clock(unsigned long long *clock)
+{
+	atomic_t *sw_ptr;
+	unsigned int sw0, sw1;
+
+	sw_ptr = &get_cpu_var(clock_sync_word);
+	sw0 = atomic_read(sw_ptr);
+	*clock = get_clock();
+	sw1 = atomic_read(sw_ptr);
+	put_cpu_var(clock_sync_sync);
+	if (sw0 == sw1 && (sw0 & 0x80000000U))
+		/* Success: time is in sync. */
+		return 0;
+	if (!test_bit(CLOCK_SYNC_HAS_ETR, &clock_sync_flags) &&
+	    !test_bit(CLOCK_SYNC_HAS_STP, &clock_sync_flags))
+		return -ENOSYS;
+	if (!test_bit(CLOCK_SYNC_ETR, &clock_sync_flags) &&
+	    !test_bit(CLOCK_SYNC_STP, &clock_sync_flags))
+		return -EACCES;
+	return -EAGAIN;
+}
+EXPORT_SYMBOL(get_sync_clock);
+
+/*
+ * Make get_sync_clock return -EAGAIN.
+ */
+static void disable_sync_clock(void *dummy)
+{
+	atomic_t *sw_ptr = &__get_cpu_var(clock_sync_word);
+	/*
+	 * Clear the in-sync bit 2^31. All get_sync_clock calls will
+	 * fail until the sync bit is turned back on. In addition
+	 * increase the "sequence" counter to avoid the race of an
+	 * etr event and the complete recovery against get_sync_clock.
+	 */
+	atomic_clear_mask(0x80000000, sw_ptr);
+	atomic_inc(sw_ptr);
+}
+
+/*
+ * Make get_sync_clock return 0 again.
+ * Needs to be called from a context disabled for preemption.
+ */
+static void enable_sync_clock(void)
+{
+	atomic_t *sw_ptr = &__get_cpu_var(clock_sync_word);
+	atomic_set_mask(0x80000000, sw_ptr);
+}
+
+/*
  * External Time Reference (ETR) code.
  */
 static int etr_port0_online;
 static int etr_port1_online;
+static int etr_steai_available;
 
 static int __init early_parse_etr(char *p)
 {
@@ -273,12 +391,6 @@ enum etr_event {
 	ETR_EVENT_UPDATE,
 };
 
-enum etr_flags {
-	ETR_FLAG_ENOSYS,
-	ETR_FLAG_EACCES,
-	ETR_FLAG_STEAI,
-};
-
 /*
  * Valid bit combinations of the eacr register are (x = don't care):
  * e0 e1 dp p0 p1 ea es sl
@@ -305,74 +417,18 @@ enum etr_flags {
  */
 static struct etr_eacr etr_eacr;
 static u64 etr_tolec;			/* time of last eacr update */
-static unsigned long etr_flags;
 static struct etr_aib etr_port0;
 static int etr_port0_uptodate;
 static struct etr_aib etr_port1;
 static int etr_port1_uptodate;
 static unsigned long etr_events;
 static struct timer_list etr_timer;
-static DEFINE_PER_CPU(atomic_t, etr_sync_word);
 
 static void etr_timeout(unsigned long dummy);
 static void etr_work_fn(struct work_struct *work);
 static DECLARE_WORK(etr_work, etr_work_fn);
 
 /*
- * The etr get_clock function. It will write the current clock value
- * to the clock pointer and return 0 if the clock is in sync with the
- * external time source. If the clock mode is local it will return
- * -ENOSYS and -EAGAIN if the clock is not in sync with the external
- * reference. This function is what ETR is all about..
- */
-int get_sync_clock(unsigned long long *clock)
-{
-	atomic_t *sw_ptr;
-	unsigned int sw0, sw1;
-
-	sw_ptr = &get_cpu_var(etr_sync_word);
-	sw0 = atomic_read(sw_ptr);
-	*clock = get_clock();
-	sw1 = atomic_read(sw_ptr);
-	put_cpu_var(etr_sync_sync);
-	if (sw0 == sw1 && (sw0 & 0x80000000U))
-		/* Success: time is in sync. */
-		return 0;
-	if (test_bit(ETR_FLAG_ENOSYS, &etr_flags))
-		return -ENOSYS;
-	if (test_bit(ETR_FLAG_EACCES, &etr_flags))
-		return -EACCES;
-	return -EAGAIN;
-}
-EXPORT_SYMBOL(get_sync_clock);
-
-/*
- * Make get_sync_clock return -EAGAIN.
- */
-static void etr_disable_sync_clock(void *dummy)
-{
-	atomic_t *sw_ptr = &__get_cpu_var(etr_sync_word);
-	/*
-	 * Clear the in-sync bit 2^31. All get_sync_clock calls will
-	 * fail until the sync bit is turned back on. In addition
-	 * increase the "sequence" counter to avoid the race of an
-	 * etr event and the complete recovery against get_sync_clock.
-	 */
-	atomic_clear_mask(0x80000000, sw_ptr);
-	atomic_inc(sw_ptr);
-}
-
-/*
- * Make get_sync_clock return 0 again.
- * Needs to be called from a context disabled for preemption.
- */
-static void etr_enable_sync_clock(void)
-{
-	atomic_t *sw_ptr = &__get_cpu_var(etr_sync_word);
-	atomic_set_mask(0x80000000, sw_ptr);
-}
-
-/*
  * Reset ETR attachment.
  */
 static void etr_reset(void)
@@ -381,15 +437,13 @@ static void etr_reset(void)
 		.e0 = 0, .e1 = 0, ._pad0 = 4, .dp = 0,
 		.p0 = 0, .p1 = 0, ._pad1 = 0, .ea = 0,
 		.es = 0, .sl = 0 };
-	if (etr_setr(&etr_eacr) == 0)
+	if (etr_setr(&etr_eacr) == 0) {
 		etr_tolec = get_clock();
-	else {
-		set_bit(ETR_FLAG_ENOSYS, &etr_flags);
-		if (etr_port0_online || etr_port1_online) {
-			printk(KERN_WARNING "Running on non ETR capable "
-			       "machine, only local mode available.\n");
-			etr_port0_online = etr_port1_online = 0;
-		}
+		set_bit(CLOCK_SYNC_HAS_ETR, &clock_sync_flags);
+	} else if (etr_port0_online || etr_port1_online) {
+		printk(KERN_WARNING "Running on non ETR capable "
+		       "machine, only local mode available.\n");
+		etr_port0_online = etr_port1_online = 0;
 	}
 }
 
@@ -397,14 +451,12 @@ static int __init etr_init(void)
 {
 	struct etr_aib aib;
 
-	if (test_bit(ETR_FLAG_ENOSYS, &etr_flags))
+	if (!test_bit(CLOCK_SYNC_HAS_ETR, &clock_sync_flags))
 		return 0;
 	/* Check if this machine has the steai instruction. */
 	if (etr_steai(&aib, ETR_STEAI_STEPPING_PORT) == 0)
-		set_bit(ETR_FLAG_STEAI, &etr_flags);
+		etr_steai_available = 1;
 	setup_timer(&etr_timer, etr_timeout, 0UL);
-	if (!etr_port0_online && !etr_port1_online)
-		set_bit(ETR_FLAG_EACCES, &etr_flags);
 	if (etr_port0_online) {
 		set_bit(ETR_EVENT_PORT0_CHANGE, &etr_events);
 		schedule_work(&etr_work);
@@ -435,7 +487,8 @@ void etr_switch_to_local(void)
 {
 	if (!etr_eacr.sl)
 		return;
-	etr_disable_sync_clock(NULL);
+	if (test_bit(CLOCK_SYNC_ETR, &clock_sync_flags))
+		disable_sync_clock(NULL);
 	set_bit(ETR_EVENT_SWITCH_LOCAL, &etr_events);
 	schedule_work(&etr_work);
 }
@@ -450,23 +503,21 @@ void etr_sync_check(void)
 {
 	if (!etr_eacr.es)
 		return;
-	etr_disable_sync_clock(NULL);
+	if (test_bit(CLOCK_SYNC_ETR, &clock_sync_flags))
+		disable_sync_clock(NULL);
 	set_bit(ETR_EVENT_SYNC_CHECK, &etr_events);
 	schedule_work(&etr_work);
 }
 
 /*
- * ETR external interrupt. There are two causes:
+ * ETR timing alert. There are two causes:
  * 1) port state change, check the usability of the port
  * 2) port alert, one of the ETR-data-validity bits (v1-v2 bits of the
  *    sldr-status word) or ETR-data word 1 (edf1) or ETR-data word 3 (edf3)
  *    or ETR-data word 4 (edf4) has changed.
  */
-static void etr_ext_handler(__u16 code)
+static void etr_timing_alert(struct etr_irq_parm *intparm)
 {
-	struct etr_interruption_parameter *intparm =
-		(struct etr_interruption_parameter *) &S390_lowcore.ext_params;
-
 	if (intparm->pc0)
 		/* ETR port 0 state change. */
 		set_bit(ETR_EVENT_PORT0_CHANGE, &etr_events);
@@ -591,58 +642,23 @@ static int etr_aib_follows(struct etr_ai
 	return 1;
 }
 
-/*
- * The time is "clock". old is what we think the time is.
- * Adjust the value by a multiple of jiffies and add the delta to ntp.
- * "delay" is an approximation how long the synchronization took. If
- * the time correction is positive, then "delay" is subtracted from
- * the time difference and only the remaining part is passed to ntp.
- */
-static unsigned long long etr_adjust_time(unsigned long long old,
-					  unsigned long long clock,
-					  unsigned long long delay)
-{
-	unsigned long long delta, ticks;
-	struct timex adjust;
-
-	if (clock > old) {
-		/* It is later than we thought. */
-		delta = ticks = clock - old;
-		delta = ticks = (delta < delay) ? 0 : delta - delay;
-		delta -= do_div(ticks, CLK_TICKS_PER_JIFFY);
-		adjust.offset = ticks * (1000000 / HZ);
-	} else {
-		/* It is earlier than we thought. */
-		delta = ticks = old - clock;
-		delta -= do_div(ticks, CLK_TICKS_PER_JIFFY);
-		delta = -delta;
-		adjust.offset = -ticks * (1000000 / HZ);
-	}
-	jiffies_timer_cc += delta;
-	if (adjust.offset != 0) {
-		printk(KERN_NOTICE "etr: time adjusted by %li micro-seconds\n",
-		       adjust.offset);
-		adjust.modes = ADJ_OFFSET_SINGLESHOT;
-		do_adjtimex(&adjust);
-	}
-	return delta;
-}
-
-static struct {
+struct clock_sync_data {
 	int in_sync;
 	unsigned long long fixup_cc;
-} etr_sync;
+};
 
-static void etr_sync_cpu_start(void *dummy)
+static void clock_sync_cpu_start(void *dummy)
 {
-	etr_enable_sync_clock();
+	struct clock_sync_data *sync = dummy;
+
+	enable_sync_clock();
 	/*
 	 * This looks like a busy wait loop but it isn't. etr_sync_cpus
 	 * is called on all other cpus while the TOD clocks is stopped.
 	 * __udelay will stop the cpu on an enabled wait psw until the
 	 * TOD is running again.
 	 */
-	while (etr_sync.in_sync == 0) {
+	while (sync->in_sync == 0) {
 		__udelay(1);
 		/*
 		 * A different cpu changes *in_sync. Therefore use
@@ -650,17 +666,17 @@ static void etr_sync_cpu_start(void *dum
 		 */
 		barrier();
 	}
-	if (etr_sync.in_sync != 1)
+	if (sync->in_sync != 1)
 		/* Didn't work. Clear per-cpu in sync bit again. */
-		etr_disable_sync_clock(NULL);
+		disable_sync_clock(NULL);
 	/*
 	 * This round of TOD syncing is done. Set the clock comparator
 	 * to the next tick and let the processor continue.
 	 */
-	fixup_clock_comparator(etr_sync.fixup_cc);
+	fixup_clock_comparator(sync->fixup_cc);
 }
 
-static void etr_sync_cpu_end(void *dummy)
+static void clock_sync_cpu_end(void *dummy)
 {
 }
 
@@ -672,6 +688,7 @@ static void etr_sync_cpu_end(void *dummy
 static int etr_sync_clock(struct etr_aib *aib, int port)
 {
 	struct etr_aib *sync_port;
+	struct clock_sync_data etr_sync;
 	unsigned long long clock, old_clock, delay, delta;
 	int follows;
 	int rc;
@@ -690,9 +707,9 @@ static int etr_sync_clock(struct etr_aib
 	 */
 	memset(&etr_sync, 0, sizeof(etr_sync));
 	preempt_disable();
-	smp_call_function(etr_sync_cpu_start, NULL, 0, 0);
+	smp_call_function(clock_sync_cpu_start, &etr_sync, 0, 0);
 	local_irq_disable();
-	etr_enable_sync_clock();
+	enable_sync_clock();
 
 	/* Set clock to next OTE. */
 	__ctl_set_bit(14, 21);
@@ -707,13 +724,13 @@ static int etr_sync_clock(struct etr_aib
 		/* Adjust Linux timing variables. */
 		delay = (unsigned long long)
 			(aib->edf2.etv - sync_port->edf2.etv) << 32;
-		delta = etr_adjust_time(old_clock, clock, delay);
+		delta = adjust_time(old_clock, clock, delay);
 		etr_sync.fixup_cc = delta;
 		fixup_clock_comparator(delta);
 		/* Verify that the clock is properly set. */
 		if (!etr_aib_follows(sync_port, aib, port)) {
 			/* Didn't work. */
-			etr_disable_sync_clock(NULL);
+			disable_sync_clock(NULL);
 			etr_sync.in_sync = -EAGAIN;
 			rc = -EAGAIN;
 		} else {
@@ -724,12 +741,12 @@ static int etr_sync_clock(struct etr_aib
 		/* Could not set the clock ?!? */
 		__ctl_clear_bit(0, 29);
 		__ctl_clear_bit(14, 21);
-		etr_disable_sync_clock(NULL);
+		disable_sync_clock(NULL);
 		etr_sync.in_sync = -EAGAIN;
 		rc = -EAGAIN;
 	}
 	local_irq_enable();
-	smp_call_function(etr_sync_cpu_end,NULL,0,0);
+	smp_call_function(clock_sync_cpu_end, NULL, 0, 0);
 	preempt_enable();
 	return rc;
 }
@@ -832,7 +849,7 @@ static struct etr_eacr etr_handle_update
 	 * Do not try to get the alternate port aib if the clock
 	 * is not in sync yet.
 	 */
-	if (!eacr.es)
+	if (!test_bit(CLOCK_SYNC_STP, &clock_sync_flags) && !eacr.es)
 		return eacr;
 
 	/*
@@ -840,7 +857,7 @@ static struct etr_eacr etr_handle_update
 	 * the other port immediately. If only stetr is available the
 	 * data-port bit toggle has to be used.
 	 */
-	if (test_bit(ETR_FLAG_STEAI, &etr_flags)) {
+	if (etr_steai_available) {
 		if (eacr.p0 && !etr_port0_uptodate) {
 			etr_steai_cv(&etr_port0, ETR_STEAI_PORT_0);
 			etr_port0_uptodate = 1;
@@ -909,10 +926,10 @@ static void etr_work_fn(struct work_stru
 	if (!eacr.ea) {
 		/* Both ports offline. Reset everything. */
 		eacr.dp = eacr.es = eacr.sl = 0;
-		on_each_cpu(etr_disable_sync_clock, NULL, 0, 1);
+		on_each_cpu(disable_sync_clock, NULL, 0, 1);
 		del_timer_sync(&etr_timer);
 		etr_update_eacr(eacr);
-		set_bit(ETR_FLAG_EACCES, &etr_flags);
+		clear_bit(CLOCK_SYNC_ETR, &clock_sync_flags);
 		return;
 	}
 
@@ -953,7 +970,6 @@ static void etr_work_fn(struct work_stru
 			eacr.e1 = 1;
 		sync_port = (etr_port0_uptodate &&
 			     etr_port_valid(&etr_port0, 0)) ? 0 : -1;
-		clear_bit(ETR_FLAG_EACCES, &etr_flags);
 	} else if (eacr.p1 && aib.esw.psc1 == etr_lpsc_pps_mode) {
 		eacr.sl = 0;
 		eacr.e0 = 0;
@@ -962,7 +978,6 @@ static void etr_work_fn(struct work_stru
 			eacr.es = 0;
 		sync_port = (etr_port1_uptodate &&
 			     etr_port_valid(&etr_port1, 1)) ? 1 : -1;
-		clear_bit(ETR_FLAG_EACCES, &etr_flags);
 	} else if (eacr.p0 && aib.esw.psc0 == etr_lpsc_operational_step) {
 		eacr.sl = 1;
 		eacr.e0 = 1;
@@ -976,7 +991,6 @@ static void etr_work_fn(struct work_stru
 			eacr.e1 = 1;
 		sync_port = (etr_port0_uptodate &&
 			     etr_port_valid(&etr_port0, 0)) ? 0 : -1;
-		clear_bit(ETR_FLAG_EACCES, &etr_flags);
 	} else if (eacr.p1 && aib.esw.psc1 == etr_lpsc_operational_step) {
 		eacr.sl = 1;
 		eacr.e0 = 0;
@@ -985,19 +999,22 @@ static void etr_work_fn(struct work_stru
 			eacr.es = 0;
 		sync_port = (etr_port1_uptodate &&
 			     etr_port_valid(&etr_port1, 1)) ? 1 : -1;
-		clear_bit(ETR_FLAG_EACCES, &etr_flags);
 	} else {
 		/* Both ports not usable. */
 		eacr.es = eacr.sl = 0;
 		sync_port = -1;
-		set_bit(ETR_FLAG_EACCES, &etr_flags);
+		clear_bit(CLOCK_SYNC_ETR, &clock_sync_flags);
 	}
 
+	if (!test_bit(CLOCK_SYNC_ETR, &clock_sync_flags))
+		eacr.es = 0;
+
 	/*
 	 * If the clock is in sync just update the eacr and return.
 	 * If there is no valid sync port wait for a port update.
 	 */
-	if (eacr.es || sync_port < 0) {
+	if (test_bit(CLOCK_SYNC_STP, &clock_sync_flags) ||
+	    eacr.es || sync_port < 0) {
 		etr_update_eacr(eacr);
 		etr_set_tolec_timeout(now);
 		return;
@@ -1018,11 +1035,13 @@ static void etr_work_fn(struct work_stru
 	 * and set up a timer to try again after 0.5 seconds
 	 */
 	etr_update_eacr(eacr);
+	set_bit(CLOCK_SYNC_ETR, &clock_sync_flags);
 	if (now < etr_tolec + (1600000 << 12) ||
 	    etr_sync_clock(&aib, sync_port) != 0) {
 		/* Sync failed. Try again in 1/2 second. */
 		eacr.es = 0;
 		etr_update_eacr(eacr);
+		clear_bit(CLOCK_SYNC_ETR, &clock_sync_flags);
 		etr_set_sync_timeout();
 	} else
 		etr_set_tolec_timeout(now);
@@ -1097,8 +1116,8 @@ static ssize_t etr_online_store(struct s
 	value = simple_strtoul(buf, NULL, 0);
 	if (value != 0 && value != 1)
 		return -EINVAL;
-	if (test_bit(ETR_FLAG_ENOSYS, &etr_flags))
-		return -ENOSYS;
+	if (!test_bit(CLOCK_SYNC_HAS_ETR, &clock_sync_flags))
+		return -EOPNOTSUPP;
 	if (dev == &etr_port0_dev) {
 		if (etr_port0_online == value)
 			return count;	/* Nothing to do. */
@@ -1292,3 +1311,318 @@ out:
 }
 
 device_initcall(etr_init_sysfs);
+
+/*
+ * Server Time Protocol (STP) code.
+ */
+static int stp_online;
+static struct stp_sstpi stp_info;
+static void *stp_page;
+
+static void stp_work_fn(struct work_struct *work);
+static DECLARE_WORK(stp_work, stp_work_fn);
+
+static int __init early_parse_stp(char *p)
+{
+	if (strncmp(p, "off", 3) == 0)
+		stp_online = 0;
+	else if (strncmp(p, "on", 2) == 0)
+		stp_online = 1;
+	return 0;
+}
+early_param("stp", early_parse_stp);
+
+/*
+ * Reset STP attachment.
+ */
+static void stp_reset(void)
+{
+	int rc;
+
+	stp_page = alloc_bootmem_pages(PAGE_SIZE);
+	rc = chsc_sstpc(stp_page, STP_OP_CTRL, 0x0000);
+	if (rc == 1)
+		set_bit(CLOCK_SYNC_HAS_STP, &clock_sync_flags);
+	else if (stp_online) {
+		printk(KERN_WARNING "Running on non STP capable machine.\n");
+		free_bootmem((unsigned long) stp_page, PAGE_SIZE);
+		stp_page = NULL;
+		stp_online = 0;
+	}
+}
+
+static int __init stp_init(void)
+{
+	if (test_bit(CLOCK_SYNC_HAS_STP, &clock_sync_flags) && stp_online)
+		schedule_work(&stp_work);
+	return 0;
+}
+
+arch_initcall(stp_init);
+
+/*
+ * STP timing alert. There are three causes:
+ * 1) timing status change
+ * 2) link availability change
+ * 3) time control parameter change
+ * In all three cases we are only interested in the clock source state.
+ * If a STP clock source is now available use it.
+ */
+static void stp_timing_alert(struct stp_irq_parm *intparm)
+{
+	if (intparm->tsc || intparm->lac || intparm->tcpc)
+		schedule_work(&stp_work);
+}
+
+/*
+ * STP sync check machine check. This is called when the timing state
+ * changes from the synchronized state to the unsynchronized state.
+ * After a STP sync check the clock is not in sync. The machine check
+ * is broadcasted to all cpus at the same time.
+ */
+void stp_sync_check(void)
+{
+	if (!test_bit(CLOCK_SYNC_STP, &clock_sync_flags))
+		return;
+	disable_sync_clock(NULL);
+	schedule_work(&stp_work);
+}
+
+/*
+ * STP island condition machine check. This is called when an attached
+ * server  attempts to communicate over an STP link and the servers
+ * have matching CTN ids and have a valid stratum-1 configuration
+ * but the configurations do not match.
+ */
+void stp_island_check(void)
+{
+	if (!test_bit(CLOCK_SYNC_STP, &clock_sync_flags))
+		return;
+	disable_sync_clock(NULL);
+	schedule_work(&stp_work);
+}
+
+/*
+ * STP tasklet. Check for the STP state and take over the clock
+ * synchronization if the STP clock source is usable.
+ */
+static void stp_work_fn(struct work_struct *work)
+{
+	struct clock_sync_data stp_sync;
+	unsigned long long old_clock, delta;
+	int rc;
+
+	if (!stp_online) {
+		chsc_sstpc(stp_page, STP_OP_CTRL, 0x0000);
+		return;
+	}
+
+	rc = chsc_sstpc(stp_page, STP_OP_CTRL, 0xb0e0);
+	if (rc)
+		return;
+
+	rc = chsc_sstpi(stp_page, &stp_info, sizeof(struct stp_sstpi));
+	if (rc || stp_info.c == 0)
+		return;
+
+	/*
+	 * Catch all other cpus and make them wait until we have
+	 * successfully synced the clock. smp_call_function will
+	 * return after all other cpus are in clock_sync_cpu_start.
+	 */
+	memset(&stp_sync, 0, sizeof(stp_sync));
+	preempt_disable();
+	smp_call_function(clock_sync_cpu_start, &stp_sync, 0, 0);
+	local_irq_disable();
+	enable_sync_clock();
+
+	set_bit(CLOCK_SYNC_STP, &clock_sync_flags);
+	if (test_and_clear_bit(CLOCK_SYNC_ETR, &clock_sync_flags))
+		schedule_work(&etr_work);
+
+	rc = 0;
+	if (stp_info.todoff[0] || stp_info.todoff[1] ||
+	    stp_info.todoff[2] || stp_info.todoff[3] ||
+	    stp_info.tmd != 2) {
+		old_clock = get_clock();
+		rc = chsc_sstpc(stp_page, STP_OP_SYNC, 0);
+		if (rc == 0) {
+			delta = adjust_time(old_clock, get_clock(), 0);
+			fixup_clock_comparator(delta);
+			rc = chsc_sstpi(stp_page, &stp_info,
+					sizeof(struct stp_sstpi));
+			if (rc == 0 && stp_info.tmd != 2)
+				rc = -EAGAIN;
+		}
+	}
+	if (rc) {
+		disable_sync_clock(NULL);
+		stp_sync.in_sync = -EAGAIN;
+		clear_bit(CLOCK_SYNC_STP, &clock_sync_flags);
+		if (etr_port0_online || etr_port1_online)
+			schedule_work(&etr_work);
+	} else
+		stp_sync.in_sync = 1;
+
+	local_irq_enable();
+	smp_call_function(clock_sync_cpu_end, NULL, 0, 0);
+	preempt_enable();
+}
+
+/*
+ * STP class sysfs interface functions
+ */
+static struct sysdev_class stp_sysclass = {
+	.name	= "stp",
+};
+
+static ssize_t stp_ctn_id_show(struct sysdev_class *class, char *buf)
+{
+	if (!stp_online)
+		return -ENODATA;
+	return sprintf(buf, "%016llx\n",
+		       *(unsigned long long *) stp_info.ctnid);
+}
+
+static SYSDEV_CLASS_ATTR(ctn_id, 0400, stp_ctn_id_show, NULL);
+
+static ssize_t stp_ctn_type_show(struct sysdev_class *class, char *buf)
+{
+	if (!stp_online)
+		return -ENODATA;
+	return sprintf(buf, "%i\n", stp_info.ctn);
+}
+
+static SYSDEV_CLASS_ATTR(ctn_type, 0400, stp_ctn_type_show, NULL);
+
+static ssize_t stp_dst_offset_show(struct sysdev_class *class, char *buf)
+{
+	if (!stp_online || !(stp_info.vbits & 0x2000))
+		return -ENODATA;
+	return sprintf(buf, "%i\n", (int)(s16) stp_info.dsto);
+}
+
+static SYSDEV_CLASS_ATTR(dst_offset, 0400, stp_dst_offset_show, NULL);
+
+static ssize_t stp_leap_seconds_show(struct sysdev_class *class, char *buf)
+{
+	if (!stp_online || !(stp_info.vbits & 0x8000))
+		return -ENODATA;
+	return sprintf(buf, "%i\n", (int)(s16) stp_info.leaps);
+}
+
+static SYSDEV_CLASS_ATTR(leap_seconds, 0400, stp_leap_seconds_show, NULL);
+
+static ssize_t stp_stratum_show(struct sysdev_class *class, char *buf)
+{
+	if (!stp_online)
+		return -ENODATA;
+	return sprintf(buf, "%i\n", (int)(s16) stp_info.stratum);
+}
+
+static SYSDEV_CLASS_ATTR(stratum, 0400, stp_stratum_show, NULL);
+
+static ssize_t stp_time_offset_show(struct sysdev_class *class, char *buf)
+{
+	if (!stp_online || !(stp_info.vbits & 0x0800))
+		return -ENODATA;
+	return sprintf(buf, "%i\n", (int) stp_info.tto);
+}
+
+static SYSDEV_CLASS_ATTR(time_offset, 0400, stp_time_offset_show, NULL);
+
+static ssize_t stp_time_zone_offset_show(struct sysdev_class *class, char *buf)
+{
+	if (!stp_online || !(stp_info.vbits & 0x4000))
+		return -ENODATA;
+	return sprintf(buf, "%i\n", (int)(s16) stp_info.tzo);
+}
+
+static SYSDEV_CLASS_ATTR(time_zone_offset, 0400,
+			 stp_time_zone_offset_show, NULL);
+
+static ssize_t stp_timing_mode_show(struct sysdev_class *class, char *buf)
+{
+	if (!stp_online)
+		return -ENODATA;
+	return sprintf(buf, "%i\n", stp_info.tmd);
+}
+
+static SYSDEV_CLASS_ATTR(timing_mode, 0400, stp_timing_mode_show, NULL);
+
+static ssize_t stp_timing_state_show(struct sysdev_class *class, char *buf)
+{
+	if (!stp_online)
+		return -ENODATA;
+	return sprintf(buf, "%i\n", stp_info.tst);
+}
+
+static SYSDEV_CLASS_ATTR(timing_state, 0400, stp_timing_state_show, NULL);
+
+static ssize_t stp_online_show(struct sysdev_class *class, char *buf)
+{
+	return sprintf(buf, "%i\n", stp_online);
+}
+
+static ssize_t stp_online_store(struct sysdev_class *class,
+				const char *buf, size_t count)
+{
+	unsigned int value;
+
+	value = simple_strtoul(buf, NULL, 0);
+	if (value != 0 && value != 1)
+		return -EINVAL;
+	if (!test_bit(CLOCK_SYNC_HAS_STP, &clock_sync_flags))
+		return -EOPNOTSUPP;
+	stp_online = value;
+	schedule_work(&stp_work);
+	return count;
+}
+
+/*
+ * Can't use SYSDEV_CLASS_ATTR because the attribute should be named
+ * stp/online but attr_online already exists in this file ..
+ */
+static struct sysdev_class_attribute attr_stp_online = {
+	.attr = { .name = "online", .mode = 0600 },
+	.show	= stp_online_show,
+	.store	= stp_online_store,
+};
+
+static struct sysdev_class_attribute *stp_attributes[] = {
+	&attr_ctn_id,
+	&attr_ctn_type,
+	&attr_dst_offset,
+	&attr_leap_seconds,
+	&attr_stp_online,
+	&attr_stratum,
+	&attr_time_offset,
+	&attr_time_zone_offset,
+	&attr_timing_mode,
+	&attr_timing_state,
+	NULL
+};
+
+static int __init stp_init_sysfs(void)
+{
+	struct sysdev_class_attribute **attr;
+	int rc;
+
+	rc = sysdev_class_register(&stp_sysclass);
+	if (rc)
+		goto out;
+	for (attr = stp_attributes; *attr; attr++) {
+		rc = sysdev_class_create_file(&stp_sysclass, *attr);
+		if (rc)
+			goto out_unreg;
+	}
+	return 0;
+out_unreg:
+	for (; attr >= stp_attributes; attr--)
+		sysdev_class_remove_file(&stp_sysclass, *attr);
+	sysdev_class_unregister(&stp_sysclass);
+out:
+	return rc;
+}
+
+device_initcall(stp_init_sysfs);
Index: quilt-2.6/drivers/s390/cio/chsc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.c
+++ quilt-2.6/drivers/s390/cio/chsc.c
@@ -874,3 +874,52 @@ exit:
 
 EXPORT_SYMBOL_GPL(css_general_characteristics);
 EXPORT_SYMBOL_GPL(css_chsc_characteristics);
+
+int chsc_sstpc(void *page, unsigned int op, u16 ctrl)
+{
+	struct {
+		struct chsc_header request;
+		unsigned int rsvd0;
+		unsigned int op : 8;
+		unsigned int rsvd1 : 8;
+		unsigned int ctrl : 16;
+		unsigned int rsvd2[5];
+		struct chsc_header response;
+		unsigned int rsvd3[7];
+	} __attribute__ ((packed)) *rr;
+	int rc;
+
+	memset(page, 0, PAGE_SIZE);
+	rr = page;
+	rr->request.length = 0x0020;
+	rr->request.code = 0x0033;
+	rr->op = op;
+	rr->ctrl = ctrl;
+	rc = chsc(rr);
+	if (rc)
+		return -EIO;
+	rc = (rr->response.code == 0x0001) ? 0 : -EIO;
+	return rc;
+}
+
+int chsc_sstpi(void *page, void *result, size_t size)
+{
+	struct {
+		struct chsc_header request;
+		unsigned int rsvd0[3];
+		struct chsc_header response;
+		char data[size];
+	} __attribute__ ((packed)) *rr;
+	int rc;
+
+	memset(page, 0, PAGE_SIZE);
+	rr = page;
+	rr->request.length = 0x0010;
+	rr->request.code = 0x0038;
+	rc = chsc(rr);
+	if (rc)
+		return -EIO;
+	memcpy(result, &rr->data, size);
+	return (rr->response.code == 0x0001) ? 0 : -EIO;
+}
+
Index: quilt-2.6/drivers/s390/s390mach.c
===================================================================
--- quilt-2.6.orig/drivers/s390/s390mach.c
+++ quilt-2.6/drivers/s390/s390mach.c
@@ -457,6 +457,10 @@ s390_do_machine_check(struct pt_regs *re
 			etr_sync_check();
 		if (S390_lowcore.external_damage_code & (1U << ED_ETR_SWITCH))
 			etr_switch_to_local();
+		if (S390_lowcore.external_damage_code & (1U << ED_STP_SYNC))
+			stp_sync_check();
+		if (S390_lowcore.external_damage_code & (1U << ED_STP_ISLAND))
+			stp_island_check();
 	}
 
 	if (mci->se)
Index: quilt-2.6/drivers/s390/s390mach.h
===================================================================
--- quilt-2.6.orig/drivers/s390/s390mach.h
+++ quilt-2.6/drivers/s390/s390mach.h
@@ -112,6 +112,9 @@ static inline int stcrw(struct crw *pcrw
 #define ED_ETR_SYNC	12	/* External damage ETR sync check */
 #define ED_ETR_SWITCH	13	/* External damage ETR switch to local */
 
+#define ED_STP_SYNC	7	/* External damage STP sync check */
+#define ED_STP_ISLAND	6	/* External damage STP island check */
+
 struct pt_regs;
 
 void s390_handle_mcck(void);
Index: quilt-2.6/include/asm-s390/etr.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/etr.h
+++ quilt-2.6/include/asm-s390/etr.h
@@ -122,7 +122,7 @@ struct etr_aib {
 } __attribute__ ((packed,aligned(8)));
 
 /* ETR interruption parameter */
-struct etr_interruption_parameter {
+struct etr_irq_parm {
 	unsigned int _pad0	: 8;
 	unsigned int pc0	: 1;	/* port 0 state change */
 	unsigned int pc1	: 1;	/* port 1 state change */
@@ -213,7 +213,46 @@ static inline int etr_ptff(void *ptff_bl
 #define ETR_PTFF_SGS	0x43	/* set gross steering rate */
 
 /* Functions needed by the machine check handler */
-extern void etr_switch_to_local(void);
-extern void etr_sync_check(void);
+void etr_switch_to_local(void);
+void etr_sync_check(void);
+
+/* STP interruption parameter */
+struct stp_irq_parm {
+	unsigned int _pad0	: 14;
+	unsigned int tsc	: 1;	/* Timing status change */
+	unsigned int lac	: 1;	/* Link availability change */
+	unsigned int tcpc	: 1;	/* Time control parameter change */
+	unsigned int _pad2	: 15;
+} __attribute__ ((packed));
+
+#define STP_OP_SYNC	1
+#define STP_OP_CTRL	3
+
+struct stp_sstpi {
+	unsigned int rsvd0;
+	unsigned int rsvd1 : 8;
+	unsigned int stratum : 8;
+	unsigned int vbits : 16;
+	unsigned int leaps : 16;
+	unsigned int tmd : 4;
+	unsigned int ctn : 4;
+	unsigned int rsvd2 : 3;
+	unsigned int c : 1;
+	unsigned int tst : 4;
+	unsigned int tzo : 16;
+	unsigned int dsto : 16;
+	unsigned int ctrl : 16;
+	unsigned int rsvd3 : 16;
+	unsigned int tto;
+	unsigned int rsvd4;
+	unsigned int ctnid[3];
+	unsigned int rsvd5;
+	unsigned int todoff[4];
+	unsigned int rsvd6[48];
+} __attribute__ ((packed));
+
+/* Functions needed by the machine check handler */
+void stp_sync_check(void);
+void stp_island_check(void);
 
 #endif /* __S390_ETR_H */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
