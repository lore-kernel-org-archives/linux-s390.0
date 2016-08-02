Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0021/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:34:54 +0800
Message-Id: <20160802103454.15161-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com
List-ID: <linux-s390.vger.kernel.org>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 arch/s390/kernel/idle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index 7a55c29..db60941 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -63,7 +63,7 @@ static ssize_t show_idle_count(struct device *dev,
 	} while (read_seqcount_retry(&idle->seqcount, seq));
 	return sprintf(buf, "%llu\n", idle_count);
 }
-DEVICE_ATTR(idle_count, 0444, show_idle_count, NULL);
+DEVICE_ATTR(idle_count, S_IRUSR | S_IRGRP | S_IROTH, show_idle_count, NULL);
 
 static ssize_t show_idle_time(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -82,7 +82,7 @@ static ssize_t show_idle_time(struct device *dev,
 	idle_time += idle_enter ? ((idle_exit ? : now) - idle_enter) : 0;
 	return sprintf(buf, "%llu\n", idle_time >> 12);
 }
-DEVICE_ATTR(idle_time_us, 0444, show_idle_time, NULL);
+DEVICE_ATTR(idle_time_us, S_IRUSR | S_IRGRP | S_IROTH, show_idle_time, NULL);
 
 cputime64_t arch_cpu_idle_time(int cpu)
 {
-- 
2.9.2
