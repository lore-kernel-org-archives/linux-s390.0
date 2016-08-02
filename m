Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0023/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:35:04 +0800
Message-Id: <20160802103504.15297-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, holzheu@linux.vnet.ibm.com, tglx@linutronix.de, borntraeger@de.ibm.com, peterz@infradead.org, chuansheng.liu@intel.com, baolex.ni@intel.com
List-ID: <linux-s390.vger.kernel.org>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 arch/s390/kernel/smp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 7b89a75..c5bfc01 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -1025,7 +1025,7 @@ out:
 	put_online_cpus();
 	return rc ? rc : count;
 }
-static DEVICE_ATTR(configure, 0644, cpu_configure_show, cpu_configure_store);
+static DEVICE_ATTR(configure, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, cpu_configure_show, cpu_configure_store);
 #endif /* CONFIG_HOTPLUG_CPU */
 
 static ssize_t show_cpu_address(struct device *dev,
@@ -1033,7 +1033,7 @@ static ssize_t show_cpu_address(struct device *dev,
 {
 	return sprintf(buf, "%d\n", pcpu_devices[dev->id].address);
 }
-static DEVICE_ATTR(address, 0444, show_cpu_address, NULL);
+static DEVICE_ATTR(address, S_IRUSR | S_IRGRP | S_IROTH, show_cpu_address, NULL);
 
 static struct attribute *cpu_common_attrs[] = {
 #ifdef CONFIG_HOTPLUG_CPU
@@ -1147,7 +1147,7 @@ static ssize_t __ref rescan_store(struct device *dev,
 	rc = smp_rescan_cpus();
 	return rc ? rc : count;
 }
-static DEVICE_ATTR(rescan, 0200, NULL, rescan_store);
+static DEVICE_ATTR(rescan, S_IWUSR, NULL, rescan_store);
 #endif /* CONFIG_HOTPLUG_CPU */
 
 static int __init s390_smp_init(void)
-- 
2.9.2
