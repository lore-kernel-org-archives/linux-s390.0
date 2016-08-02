Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0891/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:55:41 +0800
Message-Id: <20160802115541.9379-1-baolex.ni@intel.com>
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
 drivers/s390/net/ctcm_sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/ctcm_sysfs.c b/drivers/s390/net/ctcm_sysfs.c
index ddb0aa3..103bdde 100644
--- a/drivers/s390/net/ctcm_sysfs.c
+++ b/drivers/s390/net/ctcm_sysfs.c
@@ -186,10 +186,10 @@ static ssize_t ctcm_type_show(struct device *dev,
 			ctcm_type[cgdev->cdev[0]->id.driver_info]);
 }
 
-static DEVICE_ATTR(buffer, 0644, ctcm_buffer_show, ctcm_buffer_write);
-static DEVICE_ATTR(protocol, 0644, ctcm_proto_show, ctcm_proto_store);
-static DEVICE_ATTR(type, 0444, ctcm_type_show, NULL);
-static DEVICE_ATTR(stats, 0644, stats_show, stats_write);
+static DEVICE_ATTR(buffer, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, ctcm_buffer_show, ctcm_buffer_write);
+static DEVICE_ATTR(protocol, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, ctcm_proto_show, ctcm_proto_store);
+static DEVICE_ATTR(type, S_IRUSR | S_IRGRP | S_IROTH, ctcm_type_show, NULL);
+static DEVICE_ATTR(stats, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, stats_show, stats_write);
 
 static struct attribute *ctcm_attr[] = {
 	&dev_attr_protocol.attr,
-- 
2.9.2
