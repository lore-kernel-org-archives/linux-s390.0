Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0903/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:56:42 +0800
Message-Id: <20160802115642.10171-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: maier@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dwmw2@infradead.org, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
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
 drivers/s390/scsi/zfcp_scsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_scsi.c b/drivers/s390/scsi/zfcp_scsi.c
index b3c6ff4..a16afd8 100644
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -21,15 +21,15 @@
 #include "zfcp_reqlist.h"
 
 static unsigned int default_depth = 32;
-module_param_named(queue_depth, default_depth, uint, 0600);
+module_param_named(queue_depth, default_depth, uint, S_IRUSR | S_IWUSR);
 MODULE_PARM_DESC(queue_depth, "Default queue depth for new SCSI devices");
 
 static bool enable_dif;
-module_param_named(dif, enable_dif, bool, 0400);
+module_param_named(dif, enable_dif, bool, S_IRUSR);
 MODULE_PARM_DESC(dif, "Enable DIF/DIX data integrity support");
 
 static bool allow_lun_scan = 1;
-module_param(allow_lun_scan, bool, 0600);
+module_param(allow_lun_scan, bool, S_IRUSR | S_IWUSR);
 MODULE_PARM_DESC(allow_lun_scan, "For NPIV, scan and attach all storage LUNs");
 
 static void zfcp_scsi_slave_destroy(struct scsi_device *sdev)
-- 
2.9.2
