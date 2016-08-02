Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0880/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:54:46 +0800
Message-Id: <20160802115446.8648-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dwmw2@infradead.org, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, joe@perches.com, chuansheng.liu@intel.com, baolex.ni@intel.com, peter.senna@gmail.com
List-ID: <linux-s390.vger.kernel.org>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/s390/char/tape_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
index 3c379da..fb69230 100644
--- a/drivers/s390/char/tape_core.c
+++ b/drivers/s390/char/tape_core.c
@@ -99,7 +99,7 @@ tape_medium_state_show(struct device *dev, struct device_attribute *attr, char *
 }
 
 static
-DEVICE_ATTR(medium_state, 0444, tape_medium_state_show, NULL);
+DEVICE_ATTR(medium_state, S_IRUSR | S_IRGRP | S_IROTH, tape_medium_state_show, NULL);
 
 static ssize_t
 tape_first_minor_show(struct device *dev, struct device_attribute *attr, char *buf)
@@ -111,7 +111,7 @@ tape_first_minor_show(struct device *dev, struct device_attribute *attr, char *b
 }
 
 static
-DEVICE_ATTR(first_minor, 0444, tape_first_minor_show, NULL);
+DEVICE_ATTR(first_minor, S_IRUSR | S_IRGRP | S_IROTH, tape_first_minor_show, NULL);
 
 static ssize_t
 tape_state_show(struct device *dev, struct device_attribute *attr, char *buf)
@@ -124,7 +124,7 @@ tape_state_show(struct device *dev, struct device_attribute *attr, char *buf)
 }
 
 static
-DEVICE_ATTR(state, 0444, tape_state_show, NULL);
+DEVICE_ATTR(state, S_IRUSR | S_IRGRP | S_IROTH, tape_state_show, NULL);
 
 static ssize_t
 tape_operation_show(struct device *dev, struct device_attribute *attr, char *buf)
@@ -151,7 +151,7 @@ tape_operation_show(struct device *dev, struct device_attribute *attr, char *buf
 }
 
 static
-DEVICE_ATTR(operation, 0444, tape_operation_show, NULL);
+DEVICE_ATTR(operation, S_IRUSR | S_IRGRP | S_IROTH, tape_operation_show, NULL);
 
 static ssize_t
 tape_blocksize_show(struct device *dev, struct device_attribute *attr, char *buf)
@@ -164,7 +164,7 @@ tape_blocksize_show(struct device *dev, struct device_attribute *attr, char *buf
 }
 
 static
-DEVICE_ATTR(blocksize, 0444, tape_blocksize_show, NULL);
+DEVICE_ATTR(blocksize, S_IRUSR | S_IRGRP | S_IROTH, tape_blocksize_show, NULL);
 
 static struct attribute *tape_attrs[] = {
 	&dev_attr_medium_state.attr,
-- 
2.9.2
