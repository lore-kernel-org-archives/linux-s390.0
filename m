Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH v14 16/25] time: replace read_boot_clock64() with read_persistent_wall_and_boot_offset()
Date: Tue, 17 Jul 2018 22:22:02 -0400
Message-Id: <20180718022211.6259-17-pasha.tatashin@oracle.com>
In-Reply-To: <20180718022211.6259-1-pasha.tatashin@oracle.com>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, pasha.tatashin@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

If architecture does not support exact boot time, it is challenging to
estimate boot time without having a reference to the current persistent
clock value. Yet, it cannot read the persistent clock time again, because
this may lead to math discrepancies with the caller of read_boot_clock64()
who have read the persistent clock at a different time.

This is why it is better to provide two values simultaneously: the
persistent clock value, and the boot time.

Replace read_boot_clock64() with:
read_persistent_wall_and_boot_offset(wall_time, boot_offset)

Where wall_time is returned by read_persistent_clock()
And boot_offset is wall_time - boot time, which defaults to 0.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 include/linux/timekeeping.h |  3 +-
 kernel/time/timekeeping.c   | 59 +++++++++++++++++++------------------
 2 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 86bc2026efce..686bc27acef0 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -243,7 +243,8 @@ extern void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot);
 extern int persistent_clock_is_local;
 
 extern void read_persistent_clock64(struct timespec64 *ts);
-extern void read_boot_clock64(struct timespec64 *ts);
+void read_persistent_clock_and_boot_offset(struct timespec64 *wall_clock,
+					   struct timespec64 *boot_offset);
 extern int update_persistent_clock64(struct timespec64 now);
 
 /*
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4786df904c22..cb738f825c12 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -17,6 +17,7 @@
 #include <linux/nmi.h>
 #include <linux/sched.h>
 #include <linux/sched/loadavg.h>
+#include <linux/sched/clock.h>
 #include <linux/syscore_ops.h>
 #include <linux/clocksource.h>
 #include <linux/jiffies.h>
@@ -1496,18 +1497,20 @@ void __weak read_persistent_clock64(struct timespec64 *ts64)
 }
 
 /**
- * read_boot_clock64 -  Return time of the system start.
+ * read_persistent_wall_and_boot_offset - Read persistent clock, and also offset
+ *                                        from the boot.
  *
  * Weak dummy function for arches that do not yet support it.
- * Function to read the exact time the system has been started.
- * Returns a timespec64 with tv_sec=0 and tv_nsec=0 if unsupported.
- *
- *  XXX - Do be sure to remove it once all arches implement it.
+ * wall_time	- current time as returned by persistent clock
+ * boot_offset	- offset that is defined as wall_time - boot_time
+ *		  default to 0.
  */
-void __weak read_boot_clock64(struct timespec64 *ts)
+void __weak __init
+read_persistent_wall_and_boot_offset(struct timespec64 *wall_time,
+				     struct timespec64 *boot_offset)
 {
-	ts->tv_sec = 0;
-	ts->tv_nsec = 0;
+	read_persistent_clock64(wall_time);
+	*boot_offset = (struct timespec64){0};
 }
 
 /* Flag for if timekeeping_resume() has injected sleeptime */
@@ -1521,28 +1524,29 @@ static bool persistent_clock_exists;
  */
 void __init timekeeping_init(void)
 {
+	struct timespec64 wall_time, boot_offset, wall_to_mono;
 	struct timekeeper *tk = &tk_core.timekeeper;
 	struct clocksource *clock;
 	unsigned long flags;
-	struct timespec64 now, boot, tmp;
-
-	read_persistent_clock64(&now);
-	if (!timespec64_valid_strict(&now)) {
-		pr_warn("WARNING: Persistent clock returned invalid value!\n"
-			"         Check your CMOS/BIOS settings.\n");
-		now.tv_sec = 0;
-		now.tv_nsec = 0;
-	} else if (now.tv_sec || now.tv_nsec)
-		persistent_clock_exists = true;
 
-	read_boot_clock64(&boot);
-	if (!timespec64_valid_strict(&boot)) {
-		pr_warn("WARNING: Boot clock returned invalid value!\n"
-			"         Check your CMOS/BIOS settings.\n");
-		boot.tv_sec = 0;
-		boot.tv_nsec = 0;
+	read_persistent_wall_and_boot_offset(&wall_time, &boot_offset);
+	if (timespec64_valid_strict(&wall_time) &&
+	    timespec64_to_ns(&wall_time) > 0) {
+		persistent_clock_exists = true;
+	} else {
+		pr_warn("Persistent clock returned invalid value");
+		wall_time = (struct timespec64){0};
 	}
 
+	if (timespec64_compare(&wall_time, &boot_offset) < 0)
+		boot_offset = (struct timespec64){0};
+
+	/*
+	 * We want set wall_to_mono, so the following is true:
+	 * wall time + wall_to_mono = boot time
+	 */
+	wall_to_mono = timespec64_sub(boot_offset, wall_time);
+
 	raw_spin_lock_irqsave(&timekeeper_lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 	ntp_init();
@@ -1552,13 +1556,10 @@ void __init timekeeping_init(void)
 		clock->enable(clock);
 	tk_setup_internals(tk, clock);
 
-	tk_set_xtime(tk, &now);
+	tk_set_xtime(tk, &wall_time);
 	tk->raw_sec = 0;
-	if (boot.tv_sec == 0 && boot.tv_nsec == 0)
-		boot = tk_xtime(tk);
 
-	set_normalized_timespec64(&tmp, -boot.tv_sec, -boot.tv_nsec);
-	tk_set_wall_to_mono(tk, tmp);
+	tk_set_wall_to_mono(tk, wall_to_mono);
 
 	timekeeping_update(tk, TK_MIRROR | TK_CLOCK_WAS_SET);
 
-- 
2.18.0
