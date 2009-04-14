Return-Path: <linux-kernel-owner+w=401wt.eu-S1756127AbZDNN5z@vger.kernel.org>
Message-Id: <20090414135349.653173299@de.ibm.com>
References: <20090414135327.576111185@de.ibm.com>
Date: Tue, 14 Apr 2009 15:53:40 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 13/14] add read_persistent_clock
Content-Disposition: inline; filename=013-persistent-clock.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Add a read_persistent_clock function that does not just return 0.
Since timekeeping_init calls the function before time_init has been
called move reset_tod_clock to early.c to make sure that the TOD
clock is running when read_persistent_clock is invoked.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/timex.h |    5 +++++
 arch/s390/kernel/early.c      |   16 ++++++++++++++++
 arch/s390/kernel/head.S       |    7 +++++--
 arch/s390/kernel/time.c       |   28 +++++++++-------------------
 4 files changed, 35 insertions(+), 21 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/timex.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/timex.h
+++ quilt-2.6/arch/s390/include/asm/timex.h
@@ -11,6 +11,9 @@
 #ifndef _ASM_S390_TIMEX_H
 #define _ASM_S390_TIMEX_H
 
+/* The value of the TOD clock for 1.1.1970. */
+#define TOD_UNIX_EPOCH 0x7d91048bca000000ULL
+
 /* Inline functions for clock register access. */
 static inline int set_clock(__u64 time)
 {
@@ -85,4 +88,6 @@ int get_sync_clock(unsigned long long *c
 void init_cpu_timer(void);
 unsigned long long monotonic_clock(void);
 
+extern u64 sched_clock_base_cc;
+
 #endif
Index: quilt-2.6/arch/s390/kernel/early.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/early.c
+++ quilt-2.6/arch/s390/kernel/early.c
@@ -38,6 +38,21 @@ static unsigned long machine_flags;
 
 static void __init setup_boot_command_line(void);
 
+/*
+ * Get the TOD clock running.
+ */
+static void __init reset_tod_clock(void)
+{
+	u64 time;
+
+	if (store_clock(&time) == 0)
+		return;
+	/* TOD clock not running. Set the clock to Unix Epoch. */
+	if (set_clock(TOD_UNIX_EPOCH) != 0 || store_clock(&time) != 0)
+		disabled_wait(0);
+
+	sched_clock_base_cc = TOD_UNIX_EPOCH;
+}
 
 #ifdef CONFIG_SHARED_KERNEL
 int __init savesys_ipl_nss(char *cmd, const int cmdlen);
@@ -372,6 +387,7 @@ static void __init setup_boot_command_li
  */
 void __init startup_init(void)
 {
+	reset_tod_clock();
 	ipl_save_parameters();
 	rescue_initrd();
 	clear_bss_section();
Index: quilt-2.6/arch/s390/kernel/head.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/head.S
+++ quilt-2.6/arch/s390/kernel/head.S
@@ -471,6 +471,8 @@ startup:basr	%r13,0			# get base
 .LPG0:
 	xc	0x200(256),0x200	# partially clear lowcore
 	xc	0x300(256),0x300
+	l	%r1,5f-.LPG0(%r13)
+	stck	0(%r1)
 
 #ifndef CONFIG_MARCH_G5
 	# check processor version against MARCH_{G5,Z900,Z990,Z9_109,Z10}
@@ -496,9 +498,10 @@ startup:basr	%r13,0			# get base
 	brct	%r0,0b
 #endif
 
-	l	%r13,0f-.LPG0(%r13)
+	l	%r13,4f-.LPG0(%r13)
 	b	0(%r13)
-0:	.long	startup_continue
+4:	.long	startup_continue
+5:	.long	sched_clock_base_cc
 
 #
 # params at 10400 (setup.h)
Index: quilt-2.6/arch/s390/kernel/time.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/time.c
+++ quilt-2.6/arch/s390/kernel/time.c
@@ -52,9 +52,6 @@
 #define USECS_PER_JIFFY     ((unsigned long) 1000000/HZ)
 #define CLK_TICKS_PER_JIFFY ((unsigned long) USECS_PER_JIFFY << 12)
 
-/* The value of the TOD clock for 1.1.1970. */
-#define TOD_UNIX_EPOCH 0x7d91048bca000000ULL
-
 /*
  * Create a small time difference between the timer interrupts
  * on the different cpus to avoid lock contention.
@@ -63,9 +60,10 @@
 
 #define TICK_SIZE tick
 
+u64 sched_clock_base_cc = -1;	/* Force to data section. */
+
 static ext_int_info_t ext_int_info_cc;
 static ext_int_info_t ext_int_etr_cc;
-static u64 sched_clock_base_cc;
 
 static DEFINE_PER_CPU(struct clock_event_device, comparators);
 
@@ -195,22 +193,12 @@ static void timing_alert_interrupt(__u16
 static void etr_reset(void);
 static void stp_reset(void);
 
-/*
- * Get the TOD clock running.
- */
-static u64 __init reset_tod_clock(void)
+unsigned long read_persistent_clock(void)
 {
-	u64 time;
+	struct timespec ts;
 
-	etr_reset();
-	stp_reset();
-	if (store_clock(&time) == 0)
-		return time;
-	/* TOD clock not running. Set the clock to Unix Epoch. */
-	if (set_clock(TOD_UNIX_EPOCH) != 0 || store_clock(&time) != 0)
-		panic("TOD clock not operational.");
-
-	return TOD_UNIX_EPOCH;
+	tod_to_timeval(get_clock() - TOD_UNIX_EPOCH, &ts);
+	return ts.tv_sec;
 }
 
 static cycle_t read_tod_clock(void)
@@ -265,7 +253,9 @@ void update_vsyscall_tz(void)
  */
 void __init time_init(void)
 {
-	sched_clock_base_cc = reset_tod_clock();
+	/* Reset time synchronization interfaces. */
+	etr_reset();
+	stp_reset();
 
 	/* set xtime */
 	tod_to_timeval(sched_clock_base_cc - TOD_UNIX_EPOCH, &xtime);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
