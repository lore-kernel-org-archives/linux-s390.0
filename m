Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0888/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:55:27 +0800
Message-Id: <20160802115527.9180-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: ingo.tuchscherer@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dwmw2@infradead.org, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
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
 drivers/s390/crypto/ap_bus.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 327255d..df671a9 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1029,7 +1029,7 @@ static ssize_t ap_hwtype_show(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", ap_dev->device_type);
 }
 
-static DEVICE_ATTR(hwtype, 0444, ap_hwtype_show, NULL);
+static DEVICE_ATTR(hwtype, S_IRUSR | S_IRGRP | S_IROTH, ap_hwtype_show, NULL);
 
 static ssize_t ap_raw_hwtype_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
@@ -1039,7 +1039,7 @@ static ssize_t ap_raw_hwtype_show(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", ap_dev->raw_hwtype);
 }
 
-static DEVICE_ATTR(raw_hwtype, 0444, ap_raw_hwtype_show, NULL);
+static DEVICE_ATTR(raw_hwtype, S_IRUSR | S_IRGRP | S_IROTH, ap_raw_hwtype_show, NULL);
 
 static ssize_t ap_depth_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
@@ -1048,7 +1048,7 @@ static ssize_t ap_depth_show(struct device *dev, struct device_attribute *attr,
 	return snprintf(buf, PAGE_SIZE, "%d\n", ap_dev->queue_depth);
 }
 
-static DEVICE_ATTR(depth, 0444, ap_depth_show, NULL);
+static DEVICE_ATTR(depth, S_IRUSR | S_IRGRP | S_IROTH, ap_depth_show, NULL);
 static ssize_t ap_request_count_show(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
@@ -1062,7 +1062,7 @@ static ssize_t ap_request_count_show(struct device *dev,
 	return rc;
 }
 
-static DEVICE_ATTR(request_count, 0444, ap_request_count_show, NULL);
+static DEVICE_ATTR(request_count, S_IRUSR | S_IRGRP | S_IROTH, ap_request_count_show, NULL);
 
 static ssize_t ap_requestq_count_show(struct device *dev,
 				      struct device_attribute *attr, char *buf)
@@ -1076,7 +1076,7 @@ static ssize_t ap_requestq_count_show(struct device *dev,
 	return rc;
 }
 
-static DEVICE_ATTR(requestq_count, 0444, ap_requestq_count_show, NULL);
+static DEVICE_ATTR(requestq_count, S_IRUSR | S_IRGRP | S_IROTH, ap_requestq_count_show, NULL);
 
 static ssize_t ap_pendingq_count_show(struct device *dev,
 				      struct device_attribute *attr, char *buf)
@@ -1090,7 +1090,7 @@ static ssize_t ap_pendingq_count_show(struct device *dev,
 	return rc;
 }
 
-static DEVICE_ATTR(pendingq_count, 0444, ap_pendingq_count_show, NULL);
+static DEVICE_ATTR(pendingq_count, S_IRUSR | S_IRGRP | S_IROTH, ap_pendingq_count_show, NULL);
 
 static ssize_t ap_reset_show(struct device *dev,
 				      struct device_attribute *attr, char *buf)
@@ -1115,7 +1115,7 @@ static ssize_t ap_reset_show(struct device *dev,
 	return rc;
 }
 
-static DEVICE_ATTR(reset, 0444, ap_reset_show, NULL);
+static DEVICE_ATTR(reset, S_IRUSR | S_IRGRP | S_IROTH, ap_reset_show, NULL);
 
 static ssize_t ap_interrupt_show(struct device *dev,
 				      struct device_attribute *attr, char *buf)
@@ -1134,7 +1134,7 @@ static ssize_t ap_interrupt_show(struct device *dev,
 	return rc;
 }
 
-static DEVICE_ATTR(interrupt, 0444, ap_interrupt_show, NULL);
+static DEVICE_ATTR(interrupt, S_IRUSR | S_IRGRP | S_IROTH, ap_interrupt_show, NULL);
 
 static ssize_t ap_modalias_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -1142,7 +1142,7 @@ static ssize_t ap_modalias_show(struct device *dev,
 	return sprintf(buf, "ap:t%02X\n", to_ap_dev(dev)->device_type);
 }
 
-static DEVICE_ATTR(modalias, 0444, ap_modalias_show, NULL);
+static DEVICE_ATTR(modalias, S_IRUSR | S_IRGRP | S_IROTH, ap_modalias_show, NULL);
 
 static ssize_t ap_functions_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
@@ -1151,7 +1151,7 @@ static ssize_t ap_functions_show(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "0x%08X\n", ap_dev->functions);
 }
 
-static DEVICE_ATTR(ap_functions, 0444, ap_functions_show, NULL);
+static DEVICE_ATTR(ap_functions, S_IRUSR | S_IRGRP | S_IROTH, ap_functions_show, NULL);
 
 static struct attribute *ap_dev_attrs[] = {
 	&dev_attr_hwtype.attr,
@@ -1424,7 +1424,7 @@ static ssize_t ap_domain_show(struct bus_type *bus, char *buf)
 	return snprintf(buf, PAGE_SIZE, "%d\n", ap_domain_index);
 }
 
-static BUS_ATTR(ap_domain, 0444, ap_domain_show, NULL);
+static BUS_ATTR(ap_domain, S_IRUSR | S_IRGRP | S_IROTH, ap_domain_show, NULL);
 
 static ssize_t ap_control_domain_mask_show(struct bus_type *bus, char *buf)
 {
@@ -1444,7 +1444,7 @@ static ssize_t ap_control_domain_mask_show(struct bus_type *bus, char *buf)
 			ap_configuration->adm[6], ap_configuration->adm[7]);
 }
 
-static BUS_ATTR(ap_control_domain_mask, 0444,
+static BUS_ATTR(ap_control_domain_mask, S_IRUSR | S_IRGRP | S_IROTH,
 		ap_control_domain_mask_show, NULL);
 
 static ssize_t ap_config_time_show(struct bus_type *bus, char *buf)
@@ -1458,7 +1458,7 @@ static ssize_t ap_interrupts_show(struct bus_type *bus, char *buf)
 			ap_using_interrupts() ? 1 : 0);
 }
 
-static BUS_ATTR(ap_interrupts, 0444, ap_interrupts_show, NULL);
+static BUS_ATTR(ap_interrupts, S_IRUSR | S_IRGRP | S_IROTH, ap_interrupts_show, NULL);
 
 static ssize_t ap_config_time_store(struct bus_type *bus,
 				    const char *buf, size_t count)
@@ -1472,7 +1472,7 @@ static ssize_t ap_config_time_store(struct bus_type *bus,
 	return count;
 }
 
-static BUS_ATTR(config_time, 0644, ap_config_time_show, ap_config_time_store);
+static BUS_ATTR(config_time, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, ap_config_time_show, ap_config_time_store);
 
 static ssize_t ap_poll_thread_show(struct bus_type *bus, char *buf)
 {
@@ -1495,7 +1495,7 @@ static ssize_t ap_poll_thread_store(struct bus_type *bus,
 	return count;
 }
 
-static BUS_ATTR(poll_thread, 0644, ap_poll_thread_show, ap_poll_thread_store);
+static BUS_ATTR(poll_thread, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, ap_poll_thread_show, ap_poll_thread_store);
 
 static ssize_t poll_timeout_show(struct bus_type *bus, char *buf)
 {
@@ -1524,7 +1524,7 @@ static ssize_t poll_timeout_store(struct bus_type *bus, const char *buf,
 	return count;
 }
 
-static BUS_ATTR(poll_timeout, 0644, poll_timeout_show, poll_timeout_store);
+static BUS_ATTR(poll_timeout, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, poll_timeout_show, poll_timeout_store);
 
 static ssize_t ap_max_domain_id_show(struct bus_type *bus, char *buf)
 {
@@ -1537,7 +1537,7 @@ static ssize_t ap_max_domain_id_show(struct bus_type *bus, char *buf)
 	return snprintf(buf, PAGE_SIZE, "%d\n", max_domain_id);
 }
 
-static BUS_ATTR(ap_max_domain_id, 0444, ap_max_domain_id_show, NULL);
+static BUS_ATTR(ap_max_domain_id, S_IRUSR | S_IRGRP | S_IROTH, ap_max_domain_id_show, NULL);
 
 static struct bus_attribute *const ap_bus_attrs[] = {
 	&bus_attr_ap_domain,
-- 
2.9.2
