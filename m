Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0901/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:56:28 +0800
Message-Id: <20160802115628.10039-1-baolex.ni@intel.com>
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
 drivers/s390/scsi/zfcp_fc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
index 237688a..83741e2 100644
--- a/drivers/s390/scsi/zfcp_fc.c
+++ b/drivers/s390/scsi/zfcp_fc.c
@@ -28,17 +28,17 @@ static u32 zfcp_fc_rscn_range_mask[] = {
 };
 
 static bool no_auto_port_rescan;
-module_param_named(no_auto_port_rescan, no_auto_port_rescan, bool, 0600);
+module_param_named(no_auto_port_rescan, no_auto_port_rescan, bool, S_IRUSR | S_IWUSR);
 MODULE_PARM_DESC(no_auto_port_rescan,
 		 "no automatic port_rescan (default off)");
 
 static unsigned int port_scan_backoff = 500;
-module_param(port_scan_backoff, uint, 0600);
+module_param(port_scan_backoff, uint, S_IRUSR | S_IWUSR);
 MODULE_PARM_DESC(port_scan_backoff,
 	"upper limit of port scan random backoff in msecs (default 500)");
 
 static unsigned int port_scan_ratelimit = 60000;
-module_param(port_scan_ratelimit, uint, 0600);
+module_param(port_scan_ratelimit, uint, S_IRUSR | S_IWUSR);
 MODULE_PARM_DESC(port_scan_ratelimit,
 	"minimum interval between port scans in msecs (default 60000)");
 
-- 
2.9.2
