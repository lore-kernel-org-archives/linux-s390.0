Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0022/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:34:58 +0800
Message-Id: <20160802103458.15229-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, brueckner@linux.vnet.ibm.com, anna-maria@linutronix.de, chuansheng.liu@intel.com, baolex.ni@intel.com
List-ID: <linux-s390.vger.kernel.org>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 arch/s390/kernel/perf_cpum_sf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index a8e8321..92f496a 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1641,4 +1641,4 @@ out:
 	return err;
 }
 arch_initcall(init_cpum_sampling_pmu);
-core_param(cpum_sfb_size, CPUM_SF_MAX_SDB, sfb_size, 0640);
+core_param(cpum_sfb_size, CPUM_SF_MAX_SDB, sfb_size, S_IRUSR | S_IWUSR | S_IRGRP);
-- 
2.9.2
