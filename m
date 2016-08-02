Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0876/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:54:19 +0800
Message-Id: <20160802115419.8376-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dwmw2@infradead.org, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dan.j.williams@intel.com, axboe@fb.com, akpm@linux-foundation.org, martin.petersen@oracle.com, joe@perches.com, ross.zwisler@linux.intel.com, chuansheng.liu@intel.com, baolex.ni@intel.com
List-ID: <linux-s390.vger.kernel.org>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/s390/block/dcssblk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index bed53c4..9604f25 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -1083,7 +1083,7 @@ out_pdrv:
 module_init(dcssblk_init);
 module_exit(dcssblk_exit);
 
-module_param_string(segments, dcssblk_segments, DCSSBLK_PARM_LEN, 0444);
+module_param_string(segments, dcssblk_segments, DCSSBLK_PARM_LEN, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(segments, "Name of DCSS segment(s) to be loaded, "
 		 "comma-separated list, names in each set separated "
 		 "by commas are separated by colons, each set contains "
-- 
2.9.2
