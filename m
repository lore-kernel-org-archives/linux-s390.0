From: Benjamin Block <bblock@linux.vnet.ibm.com>
Subject: [PATCH 20/22] zfcp: clean up a member of struct zfcp_qdio that was assigned but never used
Date: Fri, 28 Jul 2017 12:31:06 +0200
Message-ID: <7f893474194435f0fe38553e6825611b179ddaf6.1501085249.git.bblock@linux.vnet.ibm.com>
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

v2.6.38 commit a54ca0f62f95 ("[SCSI] zfcp: Redesign of the debug tracing
for HBA records.")
dropped trace information previously introduced with
v2.6.27 commit c3baa9a26c5a ("[SCSI] zfcp: Add information about interrupt
to trace.")
but kept and needlessly assigned a now no longer used struct field.

Signed-off-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>
[maier@linux.vnet.ibm.com: reword, added git history]
Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.vnet.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.vnet.ibm.com>
---
 drivers/s390/scsi/zfcp_fsf.c  | 1 -
 drivers/s390/scsi/zfcp_qdio.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index eefb474a9e42..69d1dc3ec79d 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -2394,7 +2394,6 @@ void zfcp_fsf_reqid_check(struct zfcp_qdio *qdio, int sbal_idx)
 			      req_id, dev_name(&adapter->ccw_device->dev));
 		}
 
-		fsf_req->qdio_req.sbal_response = sbal_idx;
 		zfcp_fsf_req_complete(fsf_req);
 
 		if (likely(sbale->eflags & SBAL_EFLAGS_LAST_ENTRY))
diff --git a/drivers/s390/scsi/zfcp_qdio.h b/drivers/s390/scsi/zfcp_qdio.h
index 85cdb82127e8..7f647a90c750 100644
--- a/drivers/s390/scsi/zfcp_qdio.h
+++ b/drivers/s390/scsi/zfcp_qdio.h
@@ -54,7 +54,6 @@ struct zfcp_qdio {
  * @sbal_last: last sbal for this request
  * @sbal_limit: last possible sbal for this request
  * @sbale_curr: current sbale at creation of this request
- * @sbal_response: sbal used in interrupt
  * @qdio_outb_usage: usage of outbound queue
  */
 struct zfcp_qdio_req {
@@ -64,7 +63,6 @@ struct zfcp_qdio_req {
 	u8	sbal_last;
 	u8	sbal_limit;
 	u8	sbale_curr;
-	u8	sbal_response;
 	u16	qdio_outb_usage;
 };
 
-- 
2.11.2
