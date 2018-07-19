Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH v15 18/26] ARM/time: remove read_boot_clock64()
Date: Thu, 19 Jul 2018 16:55:37 -0400
Message-Id: <20180719205545.16512-19-pasha.tatashin@oracle.com>
In-Reply-To: <20180719205545.16512-1-pasha.tatashin@oracle.com>
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, pasha.tatashin@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

read_boot_clock64() is deleted, and replaced with
read_persistent_wall_and_boot_offset().

The default implementation of read_persistent_wall_and_boot_offset()
provides a better fallback than the current stubs for read_boot_clock64()
that arm has with no users, so remove the old code.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/arm/include/asm/mach/time.h    |  3 +--
 arch/arm/kernel/time.c              | 15 ++-------------
 arch/arm/plat-omap/counter_32k.c    |  2 +-
 drivers/clocksource/tegra20_timer.c |  2 +-
 4 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/arm/include/asm/mach/time.h b/arch/arm/include/asm/mach/time.h
index 0f79e4dec7f9..4ac3a019a46f 100644
--- a/arch/arm/include/asm/mach/time.h
+++ b/arch/arm/include/asm/mach/time.h
@@ -13,7 +13,6 @@
 extern void timer_tick(void);
 
 typedef void (*clock_access_fn)(struct timespec64 *);
-extern int register_persistent_clock(clock_access_fn read_boot,
-				     clock_access_fn read_persistent);
+extern int register_persistent_clock(clock_access_fn read_persistent);
 
 #endif
diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index cf2701cb0de8..078b259ead4e 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -83,29 +83,18 @@ static void dummy_clock_access(struct timespec64 *ts)
 }
 
 static clock_access_fn __read_persistent_clock = dummy_clock_access;
-static clock_access_fn __read_boot_clock = dummy_clock_access;
 
 void read_persistent_clock64(struct timespec64 *ts)
 {
 	__read_persistent_clock(ts);
 }
 
-void read_boot_clock64(struct timespec64 *ts)
-{
-	__read_boot_clock(ts);
-}
-
-int __init register_persistent_clock(clock_access_fn read_boot,
-				     clock_access_fn read_persistent)
+int __init register_persistent_clock(clock_access_fn read_persistent)
 {
 	/* Only allow the clockaccess functions to be registered once */
-	if (__read_persistent_clock == dummy_clock_access &&
-	    __read_boot_clock == dummy_clock_access) {
-		if (read_boot)
-			__read_boot_clock = read_boot;
+	if (__read_persistent_clock == dummy_clock_access) {
 		if (read_persistent)
 			__read_persistent_clock = read_persistent;
-
 		return 0;
 	}
 
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index 2438b96004c1..fcc5bfec8bd1 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -110,7 +110,7 @@ int __init omap_init_clocksource_32k(void __iomem *vbase)
 	}
 
 	sched_clock_register(omap_32k_read_sched_clock, 32, 32768);
-	register_persistent_clock(NULL, omap_read_persistent_clock64);
+	register_persistent_clock(omap_read_persistent_clock64);
 	pr_info("OMAP clocksource: 32k_counter at 32768 Hz\n");
 
 	return 0;
diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
index c337a8100a7b..2242a36fc5b0 100644
--- a/drivers/clocksource/tegra20_timer.c
+++ b/drivers/clocksource/tegra20_timer.c
@@ -259,6 +259,6 @@ static int __init tegra20_init_rtc(struct device_node *np)
 	else
 		clk_prepare_enable(clk);
 
-	return register_persistent_clock(NULL, tegra_read_persistent_clock64);
+	return register_persistent_clock(tegra_read_persistent_clock64);
 }
 TIMER_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
-- 
2.18.0
