Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0887/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:55:23 +0800
Message-Id: <20160802115523.9114-1-baolex.ni@intel.com>
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
 drivers/s390/cio/device.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 7ada078..3eca737 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -634,15 +634,15 @@ static ssize_t vpm_show(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%02x\n", sch->vpm);
 }
 
-static DEVICE_ATTR(chpids, 0444, chpids_show, NULL);
-static DEVICE_ATTR(pimpampom, 0444, pimpampom_show, NULL);
-static DEVICE_ATTR(devtype, 0444, devtype_show, NULL);
-static DEVICE_ATTR(cutype, 0444, cutype_show, NULL);
-static DEVICE_ATTR(modalias, 0444, modalias_show, NULL);
-static DEVICE_ATTR(online, 0644, online_show, online_store);
-static DEVICE_ATTR(availability, 0444, available_show, NULL);
-static DEVICE_ATTR(logging, 0200, NULL, initiate_logging);
-static DEVICE_ATTR(vpm, 0444, vpm_show, NULL);
+static DEVICE_ATTR(chpids, S_IRUSR | S_IRGRP | S_IROTH, chpids_show, NULL);
+static DEVICE_ATTR(pimpampom, S_IRUSR | S_IRGRP | S_IROTH, pimpampom_show, NULL);
+static DEVICE_ATTR(devtype, S_IRUSR | S_IRGRP | S_IROTH, devtype_show, NULL);
+static DEVICE_ATTR(cutype, S_IRUSR | S_IRGRP | S_IROTH, cutype_show, NULL);
+static DEVICE_ATTR(modalias, S_IRUSR | S_IRGRP | S_IROTH, modalias_show, NULL);
+static DEVICE_ATTR(online, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, online_show, online_store);
+static DEVICE_ATTR(availability, S_IRUSR | S_IRGRP | S_IROTH, available_show, NULL);
+static DEVICE_ATTR(logging, S_IWUSR, NULL, initiate_logging);
+static DEVICE_ATTR(vpm, S_IRUSR | S_IRGRP | S_IROTH, vpm_show, NULL);
 
 static struct attribute *io_subchannel_attrs[] = {
 	&dev_attr_chpids.attr,
-- 
2.9.2
