Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0879/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:54:40 +0800
Message-Id: <20160802115440.8580-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dwmw2@infradead.org, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, joe@perches.com, peter.senna@gmail.com
List-ID: <linux-s390.vger.kernel.org>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/s390/char/raw3270.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index a2da898..8d55885 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -1057,7 +1057,7 @@ raw3270_model_show(struct device *dev, struct device_attribute *attr, char *buf)
 	return snprintf(buf, PAGE_SIZE, "%i\n",
 			((struct raw3270 *) dev_get_drvdata(dev))->model);
 }
-static DEVICE_ATTR(model, 0444, raw3270_model_show, NULL);
+static DEVICE_ATTR(model, S_IRUSR | S_IRGRP | S_IROTH, raw3270_model_show, NULL);
 
 static ssize_t
 raw3270_rows_show(struct device *dev, struct device_attribute *attr, char *buf)
@@ -1065,7 +1065,7 @@ raw3270_rows_show(struct device *dev, struct device_attribute *attr, char *buf)
 	return snprintf(buf, PAGE_SIZE, "%i\n",
 			((struct raw3270 *) dev_get_drvdata(dev))->rows);
 }
-static DEVICE_ATTR(rows, 0444, raw3270_rows_show, NULL);
+static DEVICE_ATTR(rows, S_IRUSR | S_IRGRP | S_IROTH, raw3270_rows_show, NULL);
 
 static ssize_t
 raw3270_columns_show(struct device *dev, struct device_attribute *attr, char *buf)
@@ -1073,7 +1073,7 @@ raw3270_columns_show(struct device *dev, struct device_attribute *attr, char *bu
 	return snprintf(buf, PAGE_SIZE, "%i\n",
 			((struct raw3270 *) dev_get_drvdata(dev))->cols);
 }
-static DEVICE_ATTR(columns, 0444, raw3270_columns_show, NULL);
+static DEVICE_ATTR(columns, S_IRUSR | S_IRGRP | S_IROTH, raw3270_columns_show, NULL);
 
 static struct attribute * raw3270_attrs[] = {
 	&dev_attr_model.attr,
-- 
2.9.2
