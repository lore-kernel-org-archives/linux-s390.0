From: Benjamin Block <bblock@linux.vnet.ibm.com>
Subject: [PATCH 01/22] zfcp: replace zfcp_qdio_sbale_count by sg_nents
Date: Fri, 28 Jul 2017 12:30:47 +0200
Message-ID: <40f8ed99ea59fb87b9a434867527c2a3ec290d4f.1501085249.git.bblock@linux.vnet.ibm.com>
References: <cover.1501085249.git.bblock@linux.vnet.ibm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <cover.1501085249.git.bblock@linux.vnet.ibm.com>
In-Reply-To: <cover.1501085249.git.bblock@linux.vnet.ibm.com>
References: <cover.1501085249.git.bblock@linux.vnet.ibm.com>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: LABBE Corentin <clabbe.montjoie@gmail.com>, Steffen Maier <maier@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Benjamin Block <bblock@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: LABBE Corentin <clabbe.montjoie@gmail.com>

The zfcp_qdio_sbale_count function do the same work than sg_nents().
So replace it by sg_nents() for removing duplicate code.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.vnet.ibm.com>
---
 drivers/s390/scsi/zfcp_fsf.c  |  3 +--
 drivers/s390/scsi/zfcp_qdio.h | 15 ---------------
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index 27ff38f839fc..3b69ec5e69ed 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -991,8 +991,7 @@ static int zfcp_fsf_setup_ct_els_sbals(struct zfcp_fsf_req *req,
 		qtcb->bottom.support.resp_buf_length =
 			zfcp_qdio_real_bytes(sg_resp);
 
-		zfcp_qdio_set_data_div(qdio, &req->qdio_req,
-					zfcp_qdio_sbale_count(sg_req));
+		zfcp_qdio_set_data_div(qdio, &req->qdio_req, sg_nents(sg_req));
 		zfcp_qdio_set_sbale_last(qdio, &req->qdio_req);
 		zfcp_qdio_set_scount(qdio, &req->qdio_req);
 		return 0;
diff --git a/drivers/s390/scsi/zfcp_qdio.h b/drivers/s390/scsi/zfcp_qdio.h
index 497cd379b0d1..85cdb82127e8 100644
--- a/drivers/s390/scsi/zfcp_qdio.h
+++ b/drivers/s390/scsi/zfcp_qdio.h
@@ -225,21 +225,6 @@ void zfcp_qdio_set_data_div(struct zfcp_qdio *qdio,
 }
 
 /**
- * zfcp_qdio_sbale_count - count sbale used
- * @sg: pointer to struct scatterlist
- */
-static inline
-unsigned int zfcp_qdio_sbale_count(struct scatterlist *sg)
-{
-	unsigned int count = 0;
-
-	for (; sg; sg = sg_next(sg))
-		count++;
-
-	return count;
-}
-
-/**
  * zfcp_qdio_real_bytes - count bytes used
  * @sg: pointer to struct scatterlist
  */
-- 
2.11.2
