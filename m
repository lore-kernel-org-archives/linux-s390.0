Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0892/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:55:45 +0800
Message-Id: <20160802115545.9445-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: ubraun@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dwmw2@infradead.org, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
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
 drivers/s390/net/lcs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index 251db0a..bac8a04 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -1959,7 +1959,7 @@ lcs_portno_store (struct device *dev, struct device_attribute *attr, const char
 
 }
 
-static DEVICE_ATTR(portno, 0644, lcs_portno_show, lcs_portno_store);
+static DEVICE_ATTR(portno, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, lcs_portno_show, lcs_portno_store);
 
 static const char *lcs_type[] = {
 	"not a channel",
@@ -1982,7 +1982,7 @@ lcs_type_show(struct device *dev, struct device_attribute *attr, char *buf)
 	return sprintf(buf, "%s\n", lcs_type[cgdev->cdev[0]->id.driver_info]);
 }
 
-static DEVICE_ATTR(type, 0444, lcs_type_show, NULL);
+static DEVICE_ATTR(type, S_IRUSR | S_IRGRP | S_IROTH, lcs_type_show, NULL);
 
 static ssize_t
 lcs_timeout_show(struct device *dev, struct device_attribute *attr, char *buf)
@@ -2016,7 +2016,7 @@ lcs_timeout_store (struct device *dev, struct device_attribute *attr, const char
 
 }
 
-static DEVICE_ATTR(lancmd_timeout, 0644, lcs_timeout_show, lcs_timeout_store);
+static DEVICE_ATTR(lancmd_timeout, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, lcs_timeout_show, lcs_timeout_store);
 
 static ssize_t
 lcs_dev_recover_store(struct device *dev, struct device_attribute *attr,
@@ -2036,7 +2036,7 @@ lcs_dev_recover_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static DEVICE_ATTR(recover, 0200, NULL, lcs_dev_recover_store);
+static DEVICE_ATTR(recover, S_IWUSR, NULL, lcs_dev_recover_store);
 
 static struct attribute * lcs_attrs[] = {
 	&dev_attr_portno.attr,
@@ -2418,7 +2418,7 @@ static ssize_t lcs_driver_group_store(struct device_driver *ddrv,
 	err = ccwgroup_create_dev(lcs_root_dev, &lcs_group_driver, 2, buf);
 	return err ? err : count;
 }
-static DRIVER_ATTR(group, 0200, NULL, lcs_driver_group_store);
+static DRIVER_ATTR(group, S_IWUSR, NULL, lcs_driver_group_store);
 
 static struct attribute *lcs_drv_attrs[] = {
 	&driver_attr_group.attr,
-- 
2.9.2
