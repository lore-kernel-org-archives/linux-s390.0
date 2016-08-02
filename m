Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0881/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:54:53 +0800
Message-Id: <20160802115453.8716-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dwmw2@infradead.org, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, ursula.braun@de.ibm.com, joe@perches.com, chuansheng.liu@intel.com, baolex.ni@intel.com
List-ID: <linux-s390.vger.kernel.org>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/s390/char/vmlogrdr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/char/vmlogrdr.c b/drivers/s390/char/vmlogrdr.c
index e883063..18df533 100644
--- a/drivers/s390/char/vmlogrdr.c
+++ b/drivers/s390/char/vmlogrdr.c
@@ -535,7 +535,7 @@ static ssize_t vmlogrdr_autopurge_show(struct device *dev,
 }
 
 
-static DEVICE_ATTR(autopurge, 0644, vmlogrdr_autopurge_show,
+static DEVICE_ATTR(autopurge, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, vmlogrdr_autopurge_show,
 		   vmlogrdr_autopurge_store);
 
 
@@ -576,7 +576,7 @@ static ssize_t vmlogrdr_purge_store(struct device * dev,
 }
 
 
-static DEVICE_ATTR(purge, 0200, NULL, vmlogrdr_purge_store);
+static DEVICE_ATTR(purge, S_IWUSR, NULL, vmlogrdr_purge_store);
 
 
 static ssize_t vmlogrdr_autorecording_store(struct device *dev,
@@ -609,7 +609,7 @@ static ssize_t vmlogrdr_autorecording_show(struct device *dev,
 }
 
 
-static DEVICE_ATTR(autorecording, 0644, vmlogrdr_autorecording_show,
+static DEVICE_ATTR(autorecording, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, vmlogrdr_autorecording_show,
 		   vmlogrdr_autorecording_store);
 
 
@@ -638,7 +638,7 @@ static ssize_t vmlogrdr_recording_store(struct device * dev,
 }
 
 
-static DEVICE_ATTR(recording, 0200, NULL, vmlogrdr_recording_store);
+static DEVICE_ATTR(recording, S_IWUSR, NULL, vmlogrdr_recording_store);
 
 
 static ssize_t vmlogrdr_recording_status_show(struct device_driver *driver,
@@ -652,7 +652,7 @@ static ssize_t vmlogrdr_recording_status_show(struct device_driver *driver,
 	len = strlen(buf);
 	return len;
 }
-static DRIVER_ATTR(recording_status, 0444, vmlogrdr_recording_status_show,
+static DRIVER_ATTR(recording_status, S_IRUSR | S_IRGRP | S_IROTH, vmlogrdr_recording_status_show,
 		   NULL);
 static struct attribute *vmlogrdr_drv_attrs[] = {
 	&driver_attr_recording_status.attr,
-- 
2.9.2
