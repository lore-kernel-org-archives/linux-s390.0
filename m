Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0025/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:35:16 +0800
Message-Id: <20160802103516.15433-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, holzheu@linux.vnet.ibm.com, akpm@linux-foundation.org, phacht@linux.vnet.ibm.com, keescook@chromium.org, chuansheng.liu@intel.com, baolex.ni@intel.com
List-ID: <linux-s390.vger.kernel.org>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 arch/s390/kernel/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 64298a8..1d2d2e1 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -380,7 +380,7 @@ out:
 	put_online_cpus();
 	return rc ? rc : count;
 }
-static DEVICE_ATTR(dispatching, 0644, dispatching_show,
+static DEVICE_ATTR(dispatching, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, dispatching_show,
 			 dispatching_store);
 
 static ssize_t cpu_polarization_show(struct device *dev,
@@ -410,7 +410,7 @@ static ssize_t cpu_polarization_show(struct device *dev,
 	mutex_unlock(&smp_cpu_state_mutex);
 	return count;
 }
-static DEVICE_ATTR(polarization, 0444, cpu_polarization_show, NULL);
+static DEVICE_ATTR(polarization, S_IRUSR | S_IRGRP | S_IROTH, cpu_polarization_show, NULL);
 
 static struct attribute *topology_cpu_attrs[] = {
 	&dev_attr_polarization.attr,
-- 
2.9.2
