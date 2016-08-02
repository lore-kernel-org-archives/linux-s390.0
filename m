Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0889/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:55:32 +0800
Message-Id: <20160802115532.9246-1-baolex.ni@intel.com>
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
 drivers/s390/crypto/zcrypt_api.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 5d3d04c..3557e26 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -87,7 +87,7 @@ static ssize_t zcrypt_type_show(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%s\n", zdev->type_string);
 }
 
-static DEVICE_ATTR(type, 0444, zcrypt_type_show, NULL);
+static DEVICE_ATTR(type, S_IRUSR | S_IRGRP | S_IROTH, zcrypt_type_show, NULL);
 
 static ssize_t zcrypt_online_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
@@ -113,7 +113,7 @@ static ssize_t zcrypt_online_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(online, 0644, zcrypt_online_show, zcrypt_online_store);
+static DEVICE_ATTR(online, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, zcrypt_online_show, zcrypt_online_store);
 
 static struct attribute * zcrypt_device_attrs[] = {
 	&dev_attr_type.attr,
-- 
2.9.2
