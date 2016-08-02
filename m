Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0883/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:55:05 +0800
Message-Id: <20160802115505.8850-1-baolex.ni@intel.com>
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
 drivers/s390/cio/ccwgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/ccwgroup.c b/drivers/s390/cio/ccwgroup.c
index e443b0d..68ebc59 100644
--- a/drivers/s390/cio/ccwgroup.c
+++ b/drivers/s390/cio/ccwgroup.c
@@ -206,8 +206,8 @@ out:
 	}
 	return count;
 }
-static DEVICE_ATTR(ungroup, 0200, NULL, ccwgroup_ungroup_store);
-static DEVICE_ATTR(online, 0644, ccwgroup_online_show, ccwgroup_online_store);
+static DEVICE_ATTR(ungroup, S_IWUSR, NULL, ccwgroup_ungroup_store);
+static DEVICE_ATTR(online, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, ccwgroup_online_show, ccwgroup_online_store);
 
 static struct attribute *ccwgroup_attrs[] = {
 	&dev_attr_online.attr,
-- 
2.9.2
