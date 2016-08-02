Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0890/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:55:36 +0800
Message-Id: <20160802115536.9313-1-baolex.ni@intel.com>
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
 drivers/s390/net/ctcm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index ad17fc5..84fbad0 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -1779,7 +1779,7 @@ static ssize_t ctcm_driver_group_store(struct device_driver *ddrv,
 	err = ccwgroup_create_dev(ctcm_root_dev, &ctcm_group_driver, 2, buf);
 	return err ? err : count;
 }
-static DRIVER_ATTR(group, 0200, NULL, ctcm_driver_group_store);
+static DRIVER_ATTR(group, S_IWUSR, NULL, ctcm_driver_group_store);
 
 static struct attribute *ctcm_drv_attrs[] = {
 	&driver_attr_group.attr,
-- 
2.9.2
