Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0900/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:56:24 +0800
Message-Id: <20160802115624.9973-1-baolex.ni@intel.com>
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
 drivers/s390/scsi/zfcp_dbf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_dbf.c b/drivers/s390/scsi/zfcp_dbf.c
index 5d7fbe4..ae1b08a 100644
--- a/drivers/s390/scsi/zfcp_dbf.c
+++ b/drivers/s390/scsi/zfcp_dbf.c
@@ -19,13 +19,13 @@
 
 static u32 dbfsize = 4;
 
-module_param(dbfsize, uint, 0400);
+module_param(dbfsize, uint, S_IRUSR);
 MODULE_PARM_DESC(dbfsize,
 		 "number of pages for each debug feature area (default 4)");
 
 static u32 dbflevel = 3;
 
-module_param(dbflevel, uint, 0400);
+module_param(dbflevel, uint, S_IRUSR);
 MODULE_PARM_DESC(dbflevel,
 		 "log level for each debug feature area "
 		 "(default 3, range 0..6)");
-- 
2.9.2
