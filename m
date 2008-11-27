Return-Path: <linux-kernel-owner+w=401wt.eu-S1757773AbYK0Kzr@vger.kernel.org>
Message-Id: <20081127103129.900466934@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:30:28 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 08/60] zcrypt: Use of Thin Interrupts
Content-Disposition: inline; filename=107-ap-thinint.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Felix Beck <felix.beck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Felix Beck <felix.beck@de.ibm.com>

When the machine supports AP adapter interrupts polling will be
switched off at module initialization and the driver will work in
interrupt mode. 

Signed-off-by: Felix Beck <felix.beck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/isc.h  |    1 
 drivers/s390/crypto/ap_bus.c |  174 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/s390/crypto/ap_bus.h |    6 +
 3 files changed, 177 insertions(+), 4 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/isc.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/isc.h
+++ quilt-2.6/arch/s390/include/asm/isc.h
@@ -17,6 +17,7 @@
 #define CHSC_SCH_ISC 7			/* CHSC subchannels */
 /* Adapter interrupts. */
 #define QDIO_AIRQ_ISC IO_SCH_ISC	/* I/O subchannel in qdio mode */
+#define AP_ISC 6			/* adjunct processor (crypto) devices */
 
 /* Functions for registration of I/O interruption subclasses */
 void isc_register(unsigned int isc);
Index: quilt-2.6/drivers/s390/crypto/ap_bus.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/ap_bus.c
+++ quilt-2.6/drivers/s390/crypto/ap_bus.c
@@ -5,6 +5,7 @@
  * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
  *	      Martin Schwidefsky <schwidefsky@de.ibm.com>
  *	      Ralph Wuerthner <rwuerthn@de.ibm.com>
+ *	      Felix Beck <felix.beck@de.ibm.com>
  *
  * Adjunct processor bus.
  *
@@ -34,6 +35,10 @@
 #include <linux/mutex.h>
 #include <asm/s390_rdev.h>
 #include <asm/reset.h>
+#include <asm/airq.h>
+#include <asm/atomic.h>
+#include <asm/system.h>
+#include <asm/isc.h>
 #include <linux/hrtimer.h>
 #include <linux/ktime.h>
 
@@ -46,6 +51,7 @@ static enum hrtimer_restart ap_poll_time
 static int ap_poll_thread_start(void);
 static void ap_poll_thread_stop(void);
 static void ap_request_timeout(unsigned long);
+static inline void ap_schedule_poll_timer(void);
 
 /*
  * Module description.
@@ -80,19 +86,29 @@ static int ap_config_time = AP_CONFIG_TI
 static DECLARE_WORK(ap_config_work, ap_scan_bus);
 
 /*
- * Tasklet & timer for AP request polling.
+ * Tasklet & timer for AP request polling and interrupts
  */
 static DECLARE_TASKLET(ap_tasklet, ap_poll_all, 0);
 static atomic_t ap_poll_requests = ATOMIC_INIT(0);
 static DECLARE_WAIT_QUEUE_HEAD(ap_poll_wait);
 static struct task_struct *ap_poll_kthread = NULL;
 static DEFINE_MUTEX(ap_poll_thread_mutex);
+static void *ap_interrupt_indicator;
 static struct hrtimer ap_poll_timer;
 /* In LPAR poll with 4kHz frequency. Poll every 250000 nanoseconds.
  * If z/VM change to 1500000 nanoseconds to adjust to z/VM polling.*/
 static unsigned long long poll_timeout = 250000;
 
 /**
+ * ap_using_interrupts() - Returns non-zero if interrupt support is
+ * available.
+ */
+static inline int ap_using_interrupts(void)
+{
+	return ap_interrupt_indicator != NULL;
+}
+
+/**
  * ap_intructions_available() - Test if AP instructions are available.
  *
  * Returns 0 if the AP instructions are installed.
@@ -113,6 +129,23 @@ static inline int ap_instructions_availa
 }
 
 /**
+ * ap_interrupts_available(): Test if AP interrupts are available.
+ *
+ * Returns 1 if AP interrupts are available.
+ */
+static int ap_interrupts_available(void)
+{
+	unsigned long long facility_bits[2];
+
+	if (stfle(facility_bits, 2) <= 1)
+		return 0;
+	if (!(facility_bits[0] & (1ULL << 61)) ||
+	    !(facility_bits[1] & (1ULL << 62)))
+		return 0;
+	return 1;
+}
+
+/**
  * ap_test_queue(): Test adjunct processor queue.
  * @qid: The AP queue number
  * @queue_depth: Pointer to queue depth value
@@ -152,6 +185,80 @@ static inline struct ap_queue_status ap_
 	return reg1;
 }
 
+#ifdef CONFIG_64BIT
+/**
+ * ap_queue_interruption_control(): Enable interruption for a specific AP.
+ * @qid: The AP queue number
+ * @ind: The notification indicator byte
+ *
+ * Returns AP queue status.
+ */
+static inline struct ap_queue_status
+ap_queue_interruption_control(ap_qid_t qid, void *ind)
+{
+	register unsigned long reg0 asm ("0") = qid | 0x03000000UL;
+	register unsigned long reg1_in asm ("1") = 0x0000800000000000UL | AP_ISC;
+	register struct ap_queue_status reg1_out asm ("1");
+	register void *reg2 asm ("2") = ind;
+	asm volatile(
+		".long 0xb2af0000"		/* PQAP(RAPQ) */
+		: "+d" (reg0), "+d" (reg1_in), "=d" (reg1_out), "+d" (reg2)
+		:
+		: "cc" );
+	return reg1_out;
+}
+#endif
+
+/**
+ * ap_queue_enable_interruption(): Enable interruption on an AP.
+ * @qid: The AP queue number
+ * @ind: the notification indicator byte
+ *
+ * Enables interruption on AP queue via ap_queue_interruption_control(). Based
+ * on the return value it waits a while and tests the AP queue if interrupts
+ * have been switched on using ap_test_queue().
+ */
+static int ap_queue_enable_interruption(ap_qid_t qid, void *ind)
+{
+#ifdef CONFIG_64BIT
+	struct ap_queue_status status;
+	int t_depth, t_device_type, rc, i;
+
+	rc = -EBUSY;
+	status = ap_queue_interruption_control(qid, ind);
+
+	for (i = 0; i < AP_MAX_RESET; i++) {
+		switch (status.response_code) {
+		case AP_RESPONSE_NORMAL:
+			if (status.int_enabled)
+				return 0;
+			break;
+		case AP_RESPONSE_RESET_IN_PROGRESS:
+		case AP_RESPONSE_BUSY:
+			break;
+		case AP_RESPONSE_Q_NOT_AVAIL:
+		case AP_RESPONSE_DECONFIGURED:
+		case AP_RESPONSE_CHECKSTOPPED:
+		case AP_RESPONSE_INVALID_ADDRESS:
+			return -ENODEV;
+		case AP_RESPONSE_OTHERWISE_CHANGED:
+			if (status.int_enabled)
+				return 0;
+			break;
+		default:
+			break;
+		}
+		if (i < AP_MAX_RESET - 1) {
+			udelay(5);
+			status = ap_test_queue(qid, &t_depth, &t_device_type);
+		}
+	}
+	return rc;
+#else
+	return -EINVAL;
+#endif
+}
+
 /**
  * __ap_send(): Send message to adjunct processor queue.
  * @qid: The AP queue number
@@ -295,6 +402,11 @@ static int ap_query_queue(ap_qid_t qid, 
 		case AP_RESPONSE_CHECKSTOPPED:
 			rc = -ENODEV;
 			break;
+		case AP_RESPONSE_INVALID_ADDRESS:
+			rc = -ENODEV;
+			break;
+		case AP_RESPONSE_OTHERWISE_CHANGED:
+			break;
 		case AP_RESPONSE_BUSY:
 			break;
 		default:
@@ -345,6 +457,15 @@ static int ap_init_queue(ap_qid_t qid)
 			status = ap_test_queue(qid, &dummy, &dummy);
 		}
 	}
+	if (rc == 0 && ap_using_interrupts()) {
+		rc = ap_queue_enable_interruption(qid, ap_interrupt_indicator);
+		/* If interruption mode is supported by the machine,
+		* but an AP can not be enabled for interruption then
+		* the AP will be discarded.    */
+		if (rc)
+			pr_err("Registering adapter interrupts for "
+			       "AP %d failed\n", AP_QID_DEVICE(qid));
+	}
 	return rc;
 }
 
@@ -599,6 +720,14 @@ static ssize_t ap_config_time_show(struc
 	return snprintf(buf, PAGE_SIZE, "%d\n", ap_config_time);
 }
 
+static ssize_t ap_interrupts_show(struct bus_type *bus, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			ap_using_interrupts() ? 1 : 0);
+}
+
+static BUS_ATTR(ap_interrupts, 0444, ap_interrupts_show, NULL);
+
 static ssize_t ap_config_time_store(struct bus_type *bus,
 				    const char *buf, size_t count)
 {
@@ -653,7 +782,8 @@ static ssize_t poll_timeout_store(struct
 	ktime_t hr_time;
 
 	/* 120 seconds = maximum poll interval */
-	if (sscanf(buf, "%llu\n", &time) != 1 || time < 1 || time > 120000000000)
+	if (sscanf(buf, "%llu\n", &time) != 1 || time < 1 ||
+	    time > 120000000000ULL)
 		return -EINVAL;
 	poll_timeout = time;
 	hr_time = ktime_set(0, poll_timeout);
@@ -672,6 +802,7 @@ static struct bus_attribute *const ap_bu
 	&bus_attr_ap_domain,
 	&bus_attr_config_time,
 	&bus_attr_poll_thread,
+	&bus_attr_ap_interrupts,
 	&bus_attr_poll_timeout,
 	NULL,
 };
@@ -814,6 +945,11 @@ out:
 	return rc;
 }
 
+static void ap_interrupt_handler(void *unused1, void *unused2)
+{
+	tasklet_schedule(&ap_tasklet);
+}
+
 /**
  * __ap_scan_bus(): Scan the AP bus.
  * @dev: Pointer to device
@@ -928,6 +1064,8 @@ ap_config_timeout(unsigned long ptr)
  */
 static inline void ap_schedule_poll_timer(void)
 {
+	if (ap_using_interrupts())
+		return;
 	if (hrtimer_is_queued(&ap_poll_timer))
 		return;
 	hrtimer_start(&ap_poll_timer, ktime_set(0, poll_timeout),
@@ -1207,6 +1345,12 @@ static void ap_poll_all(unsigned long du
 	unsigned long flags;
 	struct ap_device *ap_dev;
 
+	/* Reset the indicator if interrupts are used. Thus new interrupts can
+	 * be received. Doing it in the beginning of the tasklet is therefor
+	 * important that no requests on any AP get lost.
+	 */
+	if (ap_using_interrupts())
+		xchg((u8 *)ap_interrupt_indicator, 0);
 	do {
 		flags = 0;
 		spin_lock(&ap_device_lock);
@@ -1268,6 +1412,8 @@ static int ap_poll_thread_start(void)
 {
 	int rc;
 
+	if (ap_using_interrupts())
+		return 0;
 	mutex_lock(&ap_poll_thread_mutex);
 	if (!ap_poll_kthread) {
 		ap_poll_kthread = kthread_run(ap_poll_thread, NULL, "appoll");
@@ -1301,8 +1447,12 @@ static void ap_request_timeout(unsigned 
 {
 	struct ap_device *ap_dev = (struct ap_device *) data;
 
-	if (ap_dev->reset == AP_RESET_ARMED)
+	if (ap_dev->reset == AP_RESET_ARMED) {
 		ap_dev->reset = AP_RESET_DO;
+
+		if (ap_using_interrupts())
+			tasklet_schedule(&ap_tasklet);
+	}
 }
 
 static void ap_reset_domain(void)
@@ -1345,6 +1495,16 @@ int __init ap_module_init(void)
 		printk(KERN_WARNING "AP instructions not installed.\n");
 		return -ENODEV;
 	}
+	if (ap_interrupts_available()) {
+		isc_register(AP_ISC);
+		ap_interrupt_indicator = s390_register_adapter_interrupt(
+			&ap_interrupt_handler, NULL, AP_ISC);
+		if (IS_ERR(ap_interrupt_indicator)) {
+			ap_interrupt_indicator = NULL;
+			isc_unregister(AP_ISC);
+		}
+	}
+
 	register_reset_call(&ap_reset_call);
 
 	/* Create /sys/bus/ap. */
@@ -1408,6 +1568,10 @@ out_bus:
 	bus_unregister(&ap_bus_type);
 out:
 	unregister_reset_call(&ap_reset_call);
+	if (ap_using_interrupts()) {
+		s390_unregister_adapter_interrupt(ap_interrupt_indicator, AP_ISC);
+		isc_unregister(AP_ISC);
+	}
 	return rc;
 }
 
@@ -1443,6 +1607,10 @@ void ap_module_exit(void)
 		bus_remove_file(&ap_bus_type, ap_bus_attrs[i]);
 	bus_unregister(&ap_bus_type);
 	unregister_reset_call(&ap_reset_call);
+	if (ap_using_interrupts()) {
+		s390_unregister_adapter_interrupt(ap_interrupt_indicator, AP_ISC);
+		isc_unregister(AP_ISC);
+	}
 }
 
 #ifndef CONFIG_ZCRYPT_MONOLITHIC
Index: quilt-2.6/drivers/s390/crypto/ap_bus.h
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/ap_bus.h
+++ quilt-2.6/drivers/s390/crypto/ap_bus.h
@@ -5,6 +5,7 @@
  * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
  *	      Martin Schwidefsky <schwidefsky@de.ibm.com>
  *	      Ralph Wuerthner <rwuerthn@de.ibm.com>
+ *	      Felix Beck <felix.beck@de.ibm.com>
  *
  * Adjunct processor bus header file.
  *
@@ -67,7 +68,8 @@ struct ap_queue_status {
 	unsigned int queue_empty	: 1;
 	unsigned int replies_waiting	: 1;
 	unsigned int queue_full		: 1;
-	unsigned int pad1		: 5;
+	unsigned int pad1		: 4;
+	unsigned int int_enabled	: 1;
 	unsigned int response_code	: 8;
 	unsigned int pad2		: 16;
 };
@@ -78,6 +80,8 @@ struct ap_queue_status {
 #define AP_RESPONSE_DECONFIGURED	0x03
 #define AP_RESPONSE_CHECKSTOPPED	0x04
 #define AP_RESPONSE_BUSY		0x05
+#define AP_RESPONSE_INVALID_ADDRESS	0x06
+#define AP_RESPONSE_OTHERWISE_CHANGED	0x07
 #define AP_RESPONSE_Q_FULL		0x10
 #define AP_RESPONSE_NO_PENDING_REPLY	0x10
 #define AP_RESPONSE_INDEX_TOO_BIG	0x11

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
