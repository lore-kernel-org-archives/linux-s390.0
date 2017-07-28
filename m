From: Benjamin Block <bblock@linux.vnet.ibm.com>
Subject: [PATCH 13/22] zfcp: more fitting constant for fc_ct_hdr.ct_reason on port scan response
Date: Fri, 28 Jul 2017 12:30:59 +0200
Message-ID: <dda24b385d8c550ad488fa8ea761c38e8e114ffe.1501085249.git.bblock@linux.vnet.ibm.com>
References: <cover.1501085249.git.bblock@linux.vnet.ibm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <cover.1501085249.git.bblock@linux.vnet.ibm.com>
In-Reply-To: <cover.1501085249.git.bblock@linux.vnet.ibm.com>
References: <cover.1501085249.git.bblock@linux.vnet.ibm.com>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Steffen Maier <maier@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Benjamin Block <bblock@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Steffen Maier <maier@linux.vnet.ibm.com>

v2.6.33 commit dbf5dfe9dbce ("[SCSI] zfcp: Use common code definitions for
FC CT structs") replaced own definitions with common code definitions.
While FC_BA_RJT_UNABLE happens to be defined with the same value 9 as
FC_FS_RJT_UNABL and thus also works, here we should use the latter from
fc_gs.h.
See also its use in libfc's fc_disc_gpn_ft_resp().

Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.vnet.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.vnet.ibm.com>
---
 drivers/s390/scsi/zfcp_fc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
index 7331eea67435..cc3f378782b2 100644
--- a/drivers/s390/scsi/zfcp_fc.c
+++ b/drivers/s390/scsi/zfcp_fc.c
@@ -3,7 +3,7 @@
  *
  * Fibre Channel related functions for the zfcp device driver.
  *
- * Copyright IBM Corp. 2008, 2010
+ * Copyright IBM Corp. 2008, 2017
  */
 
 #define KMSG_COMPONENT "zfcp"
@@ -667,7 +667,7 @@ static int zfcp_fc_eval_gpn_ft(struct zfcp_fc_req *fc_req,
 		return -EIO;
 
 	if (hdr->ct_cmd != FC_FS_ACC) {
-		if (hdr->ct_reason == FC_BA_RJT_UNABLE)
+		if (hdr->ct_reason == FC_FS_RJT_UNABL)
 			return -EAGAIN; /* might be a temporary condition */
 		return -EIO;
 	}
-- 
2.11.2
