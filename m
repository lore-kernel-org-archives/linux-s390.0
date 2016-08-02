Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0886/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:55:18 +0800
Message-Id: <20160802115518.9048-1-baolex.ni@intel.com>
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
 drivers/s390/cio/css.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index 3d2b20e..db4783c 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -266,7 +266,7 @@ static ssize_t type_show(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%01x\n", sch->st);
 }
 
-static DEVICE_ATTR(type, 0444, type_show, NULL);
+static DEVICE_ATTR(type, S_IRUSR | S_IRGRP | S_IROTH, type_show, NULL);
 
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
@@ -276,7 +276,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "css:t%01X\n", sch->st);
 }
 
-static DEVICE_ATTR(modalias, 0444, modalias_show, NULL);
+static DEVICE_ATTR(modalias, S_IRUSR | S_IRGRP | S_IROTH, modalias_show, NULL);
 
 static struct attribute *subch_attrs[] = {
 	&dev_attr_type.attr,
@@ -766,7 +766,7 @@ css_cm_enable_store(struct device *dev, struct device_attribute *attr,
 	return ret < 0 ? ret : count;
 }
 
-static DEVICE_ATTR(cm_enable, 0644, css_cm_enable_show, css_cm_enable_store);
+static DEVICE_ATTR(cm_enable, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, css_cm_enable_show, css_cm_enable_store);
 
 static int __init setup_css(int nr)
 {
-- 
2.9.2
