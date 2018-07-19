Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH v15 25/26] x86/tsc:  split native_calibrate_cpu() into early and late parts
Date: Thu, 19 Jul 2018 16:55:44 -0400
Message-Id: <20180719205545.16512-26-pasha.tatashin@oracle.com>
In-Reply-To: <20180719205545.16512-1-pasha.tatashin@oracle.com>
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, pasha.tatashin@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

Early in boot CPU can be calibrated using msr, cpuid, and quick pit
methods. The other methods pit/hpet/pmtimer are available only after acpi
is initialized.

Split native_calibrate_cpu() into early and late parts so they can be
called separately during early and late tsc calibration.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/include/asm/tsc.h |  1 +
 arch/x86/kernel/tsc.c      | 54 +++++++++++++++++++++++++-------------
 2 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index c4368ff73652..88140e4f2292 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -40,6 +40,7 @@ extern int unsynchronized_tsc(void);
 extern int check_tsc_unstable(void);
 extern void mark_tsc_async_resets(char *reason);
 extern unsigned long native_calibrate_cpu(void);
+extern unsigned long native_calibrate_cpu_early(void);
 extern unsigned long native_calibrate_tsc(void);
 extern unsigned long long native_sched_clock_from_tsc(u64 tsc);
 
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 9277ae9b68b3..60586779b02c 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -680,30 +680,17 @@ static unsigned long cpu_khz_from_cpuid(void)
 	return eax_base_mhz * 1000;
 }
 
-/**
- * native_calibrate_cpu - calibrate the cpu on boot
+/*
+ * calibrate cpu using pit, hpet, and ptimer methods. They are available
+ * later in boot after acpi is initialized.
  */
-unsigned long native_calibrate_cpu(void)
+static unsigned long pit_hpet_ptimer_calibrate_cpu(void)
 {
 	u64 tsc1, tsc2, delta, ref1, ref2;
 	unsigned long tsc_pit_min = ULONG_MAX, tsc_ref_min = ULONG_MAX;
-	unsigned long flags, latch, ms, fast_calibrate;
+	unsigned long flags, latch, ms;
 	int hpet = is_hpet_enabled(), i, loopmin;
 
-	fast_calibrate = cpu_khz_from_cpuid();
-	if (fast_calibrate)
-		return fast_calibrate;
-
-	fast_calibrate = cpu_khz_from_msr();
-	if (fast_calibrate)
-		return fast_calibrate;
-
-	local_irq_save(flags);
-	fast_calibrate = quick_pit_calibrate();
-	local_irq_restore(flags);
-	if (fast_calibrate)
-		return fast_calibrate;
-
 	/*
 	 * Run 5 calibration loops to get the lowest frequency value
 	 * (the best estimate). We use two different calibration modes
@@ -846,6 +833,37 @@ unsigned long native_calibrate_cpu(void)
 	return tsc_pit_min;
 }
 
+/**
+ * native_calibrate_cpu_early - can calibrate the cpu early in boot
+ */
+unsigned long native_calibrate_cpu_early(void)
+{
+	unsigned long flags, fast_calibrate = cpu_khz_from_cpuid();
+
+	if (!fast_calibrate)
+		fast_calibrate = cpu_khz_from_msr();
+	if (!fast_calibrate) {
+		local_irq_save(flags);
+		fast_calibrate = quick_pit_calibrate();
+		local_irq_restore(flags);
+	}
+	return fast_calibrate;
+}
+
+
+/**
+ * native_calibrate_cpu - calibrate the cpu
+ */
+unsigned long native_calibrate_cpu(void)
+{
+	unsigned long tsc_freq = native_calibrate_cpu_early();
+
+	if (!tsc_freq)
+		tsc_freq = pit_hpet_ptimer_calibrate_cpu();
+
+	return tsc_freq;
+}
+
 void recalibrate_cpu_khz(void)
 {
 #ifndef CONFIG_SMP
-- 
2.18.0
