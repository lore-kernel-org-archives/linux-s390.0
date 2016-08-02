Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0884/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:55:09 +0800
Message-Id: <20160802115509.8916-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: sebott@linux.vnet.ibm.com, oberpar@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dwmw2@infradead.org, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
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
 drivers/s390/cio/chp.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
index 50597f9..411893e 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -271,7 +271,7 @@ static ssize_t chp_status_write(struct device *dev,
 	return error < 0 ? error : count;
 }
 
-static DEVICE_ATTR(status, 0644, chp_status_show, chp_status_write);
+static DEVICE_ATTR(status, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, chp_status_show, chp_status_write);
 
 static ssize_t chp_configure_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
@@ -308,7 +308,7 @@ static ssize_t chp_configure_write(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(configure, 0644, chp_configure_show, chp_configure_write);
+static DEVICE_ATTR(configure, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, chp_configure_show, chp_configure_write);
 
 static ssize_t chp_type_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
@@ -322,7 +322,7 @@ static ssize_t chp_type_show(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%x\n", type);
 }
 
-static DEVICE_ATTR(type, 0444, chp_type_show, NULL);
+static DEVICE_ATTR(type, S_IRUSR | S_IRGRP | S_IROTH, chp_type_show, NULL);
 
 static ssize_t chp_cmg_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
@@ -336,7 +336,7 @@ static ssize_t chp_cmg_show(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%x\n", chp->cmg);
 }
 
-static DEVICE_ATTR(cmg, 0444, chp_cmg_show, NULL);
+static DEVICE_ATTR(cmg, S_IRUSR | S_IRGRP | S_IROTH, chp_cmg_show, NULL);
 
 static ssize_t chp_shared_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
@@ -350,7 +350,7 @@ static ssize_t chp_shared_show(struct device *dev,
 	return sprintf(buf, "%x\n", chp->shared);
 }
 
-static DEVICE_ATTR(shared, 0444, chp_shared_show, NULL);
+static DEVICE_ATTR(shared, S_IRUSR | S_IRGRP | S_IROTH, chp_shared_show, NULL);
 
 static ssize_t chp_chid_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
@@ -367,7 +367,7 @@ static ssize_t chp_chid_show(struct device *dev, struct device_attribute *attr,
 
 	return rc;
 }
-static DEVICE_ATTR(chid, 0444, chp_chid_show, NULL);
+static DEVICE_ATTR(chid, S_IRUSR | S_IRGRP | S_IROTH, chp_chid_show, NULL);
 
 static ssize_t chp_chid_external_show(struct device *dev,
 				      struct device_attribute *attr, char *buf)
@@ -384,7 +384,7 @@ static ssize_t chp_chid_external_show(struct device *dev,
 
 	return rc;
 }
-static DEVICE_ATTR(chid_external, 0444, chp_chid_external_show, NULL);
+static DEVICE_ATTR(chid_external, S_IRUSR | S_IRGRP | S_IROTH, chp_chid_external_show, NULL);
 
 static struct attribute *chp_attrs[] = {
 	&dev_attr_status.attr,
-- 
2.9.2
