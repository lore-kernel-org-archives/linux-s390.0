From: Benjamin Block <bblock@linux.vnet.ibm.com>
Subject: [PATCH 21/22] zfcp: clean up unnecessary module_param_named() with no_auto_port_rescan
Date: Fri, 28 Jul 2017 12:31:07 +0200
Message-ID: <99ca093052e6b521a0466280cf96ea2c96dc15d1.1501085249.git.bblock@linux.vnet.ibm.com>
References: <cover.1501085249.git.bblock@linux.vnet.ibm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <cover.1501085249.git.bblock@linux.vnet.ibm.com>
In-Reply-To: <cover.1501085249.git.bblock@linux.vnet.ibm.com>
References: <cover.1501085249.git.bblock@linux.vnet.ibm.com>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Martin Peschke <mpeschke@linux.vnet.ibm.com>, Steffen Maier <maier@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Benjamin Block <bblock@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Peschke <mpeschke@linux.vnet.ibm.com>

Improves commit 43f60cbd56c4 ("[SCSI] zfcp: No automatic port_rescan on
events")

Signed-off-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>
[maier@linux.vnet.ibm.com: reword, underscore in description to match sysfs]
Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.vnet.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.vnet.ibm.com>
---
 drivers/s390/scsi/zfcp_fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
index 3e715597b739..8210645c2111 100644
--- a/drivers/s390/scsi/zfcp_fc.c
+++ b/drivers/s390/scsi/zfcp_fc.c
@@ -29,7 +29,7 @@ static u32 zfcp_fc_rscn_range_mask[] = {
 };
 
 static bool no_auto_port_rescan;
-module_param_named(no_auto_port_rescan, no_auto_port_rescan, bool, 0600);
+module_param(no_auto_port_rescan, bool, 0600);
 MODULE_PARM_DESC(no_auto_port_rescan,
 		 "no automatic port_rescan (default off)");
 
-- 
2.11.2
