Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0024/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:35:10 +0800
Message-Id: <20160802103510.15365-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, akpm@linux-foundation.org, joe@perches.com, zhangfan@linux.vnet.ibm.com, viresh.kumar@linaro.org, keescook@chromium.org, chuansheng.liu@intel.com, baolex.ni@intel.com
List-ID: <linux-s390.vger.kernel.org>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 arch/s390/kernel/time.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 9409d32..b4a06e9 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -1163,7 +1163,7 @@ static ssize_t etr_stepping_port_show(struct device *dev,
 	return sprintf(buf, "%i\n", etr_port0.esw.p);
 }
 
-static DEVICE_ATTR(stepping_port, 0400, etr_stepping_port_show, NULL);
+static DEVICE_ATTR(stepping_port, S_IRUSR, etr_stepping_port_show, NULL);
 
 static ssize_t etr_stepping_mode_show(struct device *dev,
 					struct device_attribute *attr,
@@ -1180,7 +1180,7 @@ static ssize_t etr_stepping_mode_show(struct device *dev,
 	return sprintf(buf, "%s\n", mode_str);
 }
 
-static DEVICE_ATTR(stepping_mode, 0400, etr_stepping_mode_show, NULL);
+static DEVICE_ATTR(stepping_mode, S_IRUSR, etr_stepping_mode_show, NULL);
 
 /*
  * ETR port attributes
@@ -1241,7 +1241,7 @@ out:
 	return count;
 }
 
-static DEVICE_ATTR(online, 0600, etr_online_show, etr_online_store);
+static DEVICE_ATTR(online, S_IRUSR | S_IWUSR, etr_online_show, etr_online_store);
 
 static ssize_t etr_stepping_control_show(struct device *dev,
 					struct device_attribute *attr,
@@ -1251,7 +1251,7 @@ static ssize_t etr_stepping_control_show(struct device *dev,
 		       etr_eacr.e0 : etr_eacr.e1);
 }
 
-static DEVICE_ATTR(stepping_control, 0400, etr_stepping_control_show, NULL);
+static DEVICE_ATTR(stepping_control, S_IRUSR, etr_stepping_control_show, NULL);
 
 static ssize_t etr_mode_code_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -1263,7 +1263,7 @@ static ssize_t etr_mode_code_show(struct device *dev,
 		       etr_port0.esw.psc0 : etr_port0.esw.psc1);
 }
 
-static DEVICE_ATTR(state_code, 0400, etr_mode_code_show, NULL);
+static DEVICE_ATTR(state_code, S_IRUSR, etr_mode_code_show, NULL);
 
 static ssize_t etr_untuned_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -1275,7 +1275,7 @@ static ssize_t etr_untuned_show(struct device *dev,
 	return sprintf(buf, "%i\n", aib->edf1.u);
 }
 
-static DEVICE_ATTR(untuned, 0400, etr_untuned_show, NULL);
+static DEVICE_ATTR(untuned, S_IRUSR, etr_untuned_show, NULL);
 
 static ssize_t etr_network_id_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -1287,7 +1287,7 @@ static ssize_t etr_network_id_show(struct device *dev,
 	return sprintf(buf, "%i\n", aib->edf1.net_id);
 }
 
-static DEVICE_ATTR(network, 0400, etr_network_id_show, NULL);
+static DEVICE_ATTR(network, S_IRUSR, etr_network_id_show, NULL);
 
 static ssize_t etr_id_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
@@ -1299,7 +1299,7 @@ static ssize_t etr_id_show(struct device *dev,
 	return sprintf(buf, "%i\n", aib->edf1.etr_id);
 }
 
-static DEVICE_ATTR(id, 0400, etr_id_show, NULL);
+static DEVICE_ATTR(id, S_IRUSR, etr_id_show, NULL);
 
 static ssize_t etr_port_number_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
@@ -1311,7 +1311,7 @@ static ssize_t etr_port_number_show(struct device *dev,
 	return sprintf(buf, "%i\n", aib->edf1.etr_pn);
 }
 
-static DEVICE_ATTR(port, 0400, etr_port_number_show, NULL);
+static DEVICE_ATTR(port, S_IRUSR, etr_port_number_show, NULL);
 
 static ssize_t etr_coupled_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
@@ -1323,7 +1323,7 @@ static ssize_t etr_coupled_show(struct device *dev,
 	return sprintf(buf, "%i\n", aib->edf3.c);
 }
 
-static DEVICE_ATTR(coupled, 0400, etr_coupled_show, NULL);
+static DEVICE_ATTR(coupled, S_IRUSR, etr_coupled_show, NULL);
 
 static ssize_t etr_local_time_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
@@ -1335,7 +1335,7 @@ static ssize_t etr_local_time_show(struct device *dev,
 	return sprintf(buf, "%i\n", aib->edf3.blto);
 }
 
-static DEVICE_ATTR(local_time, 0400, etr_local_time_show, NULL);
+static DEVICE_ATTR(local_time, S_IRUSR, etr_local_time_show, NULL);
 
 static ssize_t etr_utc_offset_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
@@ -1347,7 +1347,7 @@ static ssize_t etr_utc_offset_show(struct device *dev,
 	return sprintf(buf, "%i\n", aib->edf3.buo);
 }
 
-static DEVICE_ATTR(utc_offset, 0400, etr_utc_offset_show, NULL);
+static DEVICE_ATTR(utc_offset, S_IRUSR, etr_utc_offset_show, NULL);
 
 static struct device_attribute *etr_port_attributes[] = {
 	&dev_attr_online,
@@ -1642,7 +1642,7 @@ static ssize_t stp_ctn_id_show(struct device *dev,
 		       *(unsigned long long *) stp_info.ctnid);
 }
 
-static DEVICE_ATTR(ctn_id, 0400, stp_ctn_id_show, NULL);
+static DEVICE_ATTR(ctn_id, S_IRUSR, stp_ctn_id_show, NULL);
 
 static ssize_t stp_ctn_type_show(struct device *dev,
 				struct device_attribute *attr,
@@ -1653,7 +1653,7 @@ static ssize_t stp_ctn_type_show(struct device *dev,
 	return sprintf(buf, "%i\n", stp_info.ctn);
 }
 
-static DEVICE_ATTR(ctn_type, 0400, stp_ctn_type_show, NULL);
+static DEVICE_ATTR(ctn_type, S_IRUSR, stp_ctn_type_show, NULL);
 
 static ssize_t stp_dst_offset_show(struct device *dev,
 				   struct device_attribute *attr,
@@ -1664,7 +1664,7 @@ static ssize_t stp_dst_offset_show(struct device *dev,
 	return sprintf(buf, "%i\n", (int)(s16) stp_info.dsto);
 }
 
-static DEVICE_ATTR(dst_offset, 0400, stp_dst_offset_show, NULL);
+static DEVICE_ATTR(dst_offset, S_IRUSR, stp_dst_offset_show, NULL);
 
 static ssize_t stp_leap_seconds_show(struct device *dev,
 					struct device_attribute *attr,
@@ -1675,7 +1675,7 @@ static ssize_t stp_leap_seconds_show(struct device *dev,
 	return sprintf(buf, "%i\n", (int)(s16) stp_info.leaps);
 }
 
-static DEVICE_ATTR(leap_seconds, 0400, stp_leap_seconds_show, NULL);
+static DEVICE_ATTR(leap_seconds, S_IRUSR, stp_leap_seconds_show, NULL);
 
 static ssize_t stp_stratum_show(struct device *dev,
 				struct device_attribute *attr,
@@ -1686,7 +1686,7 @@ static ssize_t stp_stratum_show(struct device *dev,
 	return sprintf(buf, "%i\n", (int)(s16) stp_info.stratum);
 }
 
-static DEVICE_ATTR(stratum, 0400, stp_stratum_show, NULL);
+static DEVICE_ATTR(stratum, S_IRUSR, stp_stratum_show, NULL);
 
 static ssize_t stp_time_offset_show(struct device *dev,
 				struct device_attribute *attr,
@@ -1697,7 +1697,7 @@ static ssize_t stp_time_offset_show(struct device *dev,
 	return sprintf(buf, "%i\n", (int) stp_info.tto);
 }
 
-static DEVICE_ATTR(time_offset, 0400, stp_time_offset_show, NULL);
+static DEVICE_ATTR(time_offset, S_IRUSR, stp_time_offset_show, NULL);
 
 static ssize_t stp_time_zone_offset_show(struct device *dev,
 				struct device_attribute *attr,
@@ -1708,7 +1708,7 @@ static ssize_t stp_time_zone_offset_show(struct device *dev,
 	return sprintf(buf, "%i\n", (int)(s16) stp_info.tzo);
 }
 
-static DEVICE_ATTR(time_zone_offset, 0400,
+static DEVICE_ATTR(time_zone_offset, S_IRUSR,
 			 stp_time_zone_offset_show, NULL);
 
 static ssize_t stp_timing_mode_show(struct device *dev,
@@ -1720,7 +1720,7 @@ static ssize_t stp_timing_mode_show(struct device *dev,
 	return sprintf(buf, "%i\n", stp_info.tmd);
 }
 
-static DEVICE_ATTR(timing_mode, 0400, stp_timing_mode_show, NULL);
+static DEVICE_ATTR(timing_mode, S_IRUSR, stp_timing_mode_show, NULL);
 
 static ssize_t stp_timing_state_show(struct device *dev,
 				struct device_attribute *attr,
@@ -1731,7 +1731,7 @@ static ssize_t stp_timing_state_show(struct device *dev,
 	return sprintf(buf, "%i\n", stp_info.tst);
 }
 
-static DEVICE_ATTR(timing_state, 0400, stp_timing_state_show, NULL);
+static DEVICE_ATTR(timing_state, S_IRUSR, stp_timing_state_show, NULL);
 
 static ssize_t stp_online_show(struct device *dev,
 				struct device_attribute *attr,
-- 
2.9.2
