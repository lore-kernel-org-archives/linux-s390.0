Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0875/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:54:12 +0800
Message-Id: <20160802115412.8308-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: wein@de.ibm.com, stefan.haberland@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dwmw2@infradead.org, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
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
 drivers/s390/block/dasd_devmap.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 3cdbce4..a70a159 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -747,7 +747,7 @@ static ssize_t dasd_ff_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static DEVICE_ATTR(failfast, 0644, dasd_ff_show, dasd_ff_store);
+static DEVICE_ATTR(failfast, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, dasd_ff_show, dasd_ff_store);
 
 /*
  * readonly controls the readonly status of a dasd
@@ -799,7 +799,7 @@ dasd_ro_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static DEVICE_ATTR(readonly, 0644, dasd_ro_show, dasd_ro_store);
+static DEVICE_ATTR(readonly, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, dasd_ro_show, dasd_ro_store);
 /*
  * erplog controls the logging of ERP related data
  * (e.g. failing channel programs).
@@ -845,7 +845,7 @@ dasd_erplog_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static DEVICE_ATTR(erplog, 0644, dasd_erplog_show, dasd_erplog_store);
+static DEVICE_ATTR(erplog, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, dasd_erplog_show, dasd_erplog_store);
 
 /*
  * use_diag controls whether the driver should use diag rather than ssch
@@ -896,7 +896,7 @@ dasd_use_diag_store(struct device *dev, struct device_attribute *attr,
 	return rc;
 }
 
-static DEVICE_ATTR(use_diag, 0644, dasd_use_diag_show, dasd_use_diag_store);
+static DEVICE_ATTR(use_diag, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, dasd_use_diag_show, dasd_use_diag_store);
 
 /*
  * use_raw controls whether the driver should give access to raw eckd data or
@@ -945,7 +945,7 @@ dasd_use_raw_store(struct device *dev, struct device_attribute *attr,
 	return rc;
 }
 
-static DEVICE_ATTR(raw_track_access, 0644, dasd_use_raw_show,
+static DEVICE_ATTR(raw_track_access, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, dasd_use_raw_show,
 		   dasd_use_raw_store);
 
 static ssize_t
@@ -979,7 +979,7 @@ out:
 	return rc ? rc : count;
 }
 
-static DEVICE_ATTR(safe_offline, 0200, NULL, dasd_safe_offline_store);
+static DEVICE_ATTR(safe_offline, S_IWUSR, NULL, dasd_safe_offline_store);
 
 static ssize_t
 dasd_access_show(struct device *dev, struct device_attribute *attr,
@@ -1005,7 +1005,7 @@ dasd_access_show(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%d\n", count);
 }
 
-static DEVICE_ATTR(host_access_count, 0444, dasd_access_show, NULL);
+static DEVICE_ATTR(host_access_count, S_IRUSR | S_IRGRP | S_IROTH, dasd_access_show, NULL);
 
 static ssize_t
 dasd_discipline_show(struct device *dev, struct device_attribute *attr,
@@ -1031,7 +1031,7 @@ out:
 	return len;
 }
 
-static DEVICE_ATTR(discipline, 0444, dasd_discipline_show, NULL);
+static DEVICE_ATTR(discipline, S_IRUSR | S_IRGRP | S_IROTH, dasd_discipline_show, NULL);
 
 static ssize_t
 dasd_device_status_show(struct device *dev, struct device_attribute *attr,
@@ -1071,7 +1071,7 @@ dasd_device_status_show(struct device *dev, struct device_attribute *attr,
 	return len;
 }
 
-static DEVICE_ATTR(status, 0444, dasd_device_status_show, NULL);
+static DEVICE_ATTR(status, S_IRUSR | S_IRGRP | S_IROTH, dasd_device_status_show, NULL);
 
 static ssize_t dasd_alias_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
@@ -1096,7 +1096,7 @@ static ssize_t dasd_alias_show(struct device *dev,
 	return sprintf(buf, "0\n");
 }
 
-static DEVICE_ATTR(alias, 0444, dasd_alias_show, NULL);
+static DEVICE_ATTR(alias, S_IRUSR | S_IRGRP | S_IROTH, dasd_alias_show, NULL);
 
 static ssize_t dasd_vendor_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -1119,7 +1119,7 @@ static ssize_t dasd_vendor_show(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%s\n", vendor);
 }
 
-static DEVICE_ATTR(vendor, 0444, dasd_vendor_show, NULL);
+static DEVICE_ATTR(vendor, S_IRUSR | S_IRGRP | S_IROTH, dasd_vendor_show, NULL);
 
 #define UID_STRLEN ( /* vendor */ 3 + 1 + /* serial    */ 14 + 1 +\
 		     /* SSID   */ 4 + 1 + /* unit addr */ 2 + 1 +\
@@ -1173,7 +1173,7 @@ dasd_uid_show(struct device *dev, struct device_attribute *attr, char *buf)
 
 	return snprintf(buf, PAGE_SIZE, "%s\n", uid_string);
 }
-static DEVICE_ATTR(uid, 0444, dasd_uid_show, NULL);
+static DEVICE_ATTR(uid, S_IRUSR | S_IRGRP | S_IROTH, dasd_uid_show, NULL);
 
 /*
  * extended error-reporting
@@ -1219,7 +1219,7 @@ dasd_eer_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static DEVICE_ATTR(eer_enabled, 0644, dasd_eer_show, dasd_eer_store);
+static DEVICE_ATTR(eer_enabled, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, dasd_eer_show, dasd_eer_store);
 
 /*
  * expiration time for default requests
@@ -1262,7 +1262,7 @@ dasd_expires_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static DEVICE_ATTR(expires, 0644, dasd_expires_show, dasd_expires_store);
+static DEVICE_ATTR(expires, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, dasd_expires_show, dasd_expires_store);
 
 static ssize_t
 dasd_retries_show(struct device *dev, struct device_attribute *attr, char *buf)
@@ -1302,7 +1302,7 @@ dasd_retries_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static DEVICE_ATTR(retries, 0644, dasd_retries_show, dasd_retries_store);
+static DEVICE_ATTR(retries, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, dasd_retries_show, dasd_retries_store);
 
 static ssize_t
 dasd_timeout_show(struct device *dev, struct device_attribute *attr,
@@ -1356,7 +1356,7 @@ dasd_timeout_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static DEVICE_ATTR(timeout, 0644,
+static DEVICE_ATTR(timeout, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH,
 		   dasd_timeout_show, dasd_timeout_store);
 
 static ssize_t dasd_reservation_policy_show(struct device *dev,
@@ -1407,7 +1407,7 @@ static ssize_t dasd_reservation_policy_store(struct device *dev,
 		return count;
 }
 
-static DEVICE_ATTR(reservation_policy, 0644,
+static DEVICE_ATTR(reservation_policy, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH,
 		   dasd_reservation_policy_show, dasd_reservation_policy_store);
 
 static ssize_t dasd_reservation_state_show(struct device *dev,
@@ -1453,7 +1453,7 @@ static ssize_t dasd_reservation_state_store(struct device *dev,
 		return count;
 }
 
-static DEVICE_ATTR(last_known_reservation_state, 0644,
+static DEVICE_ATTR(last_known_reservation_state, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH,
 		   dasd_reservation_state_show, dasd_reservation_state_store);
 
 static ssize_t dasd_pm_show(struct device *dev,
@@ -1477,7 +1477,7 @@ static ssize_t dasd_pm_show(struct device *dev,
 		       cablepm, cuirpm, hpfpm);
 }
 
-static DEVICE_ATTR(path_masks, 0444, dasd_pm_show, NULL);
+static DEVICE_ATTR(path_masks, S_IRUSR | S_IRGRP | S_IROTH, dasd_pm_show, NULL);
 
 static struct attribute * dasd_attrs[] = {
 	&dev_attr_readonly.attr,
-- 
2.9.2
