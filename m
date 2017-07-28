From: Benjamin Block <bblock@linux.vnet.ibm.com>
Subject: [PATCH 19/22] zfcp: clean up no longer existent prototype from zfcp API header
Date: Fri, 28 Jul 2017 12:31:05 +0200
Message-ID: <2a15cdff83bdd38edf47cba22565208f9f851f62.1501085249.git.bblock@linux.vnet.ibm.com>
References: <cover.1501085249.git.bblock@linux.vnet.ibm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <cover.1501085249.git.bblock@linux.vnet.ibm.com>
In-Reply-To: <cover.1501085249.git.bblock@linux.vnet.ibm.com>
References: <cover.1501085249.git.bblock@linux.vnet.ibm.com>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Steffen Maier <maier@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Martin Peschke <mpeschke@linux.vnet.ibm.com>, Benjamin Block <bblock@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Steffen Maier <maier@linux.vnet.ibm.com>

Commit a54ca0f62f95 ("[SCSI] zfcp: Redesign of the debug tracing for HBA
records.") refactored zfcp_dbf_hba_berr into zfcp_dbf_hba_bit_err
but added the prototype for the latter without removing it for the former.

Suggested-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.vnet.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.vnet.ibm.com>
---
 drivers/s390/scsi/zfcp_ext.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/scsi/zfcp_ext.h b/drivers/s390/scsi/zfcp_ext.h
index 9afdbc32b23f..a9e968717dd9 100644
--- a/drivers/s390/scsi/zfcp_ext.h
+++ b/drivers/s390/scsi/zfcp_ext.h
@@ -41,7 +41,6 @@ extern void zfcp_dbf_rec_run_wka(char *, struct zfcp_fc_wka_port *, u64);
 extern void zfcp_dbf_hba_fsf_uss(char *, struct zfcp_fsf_req *);
 extern void zfcp_dbf_hba_fsf_res(char *, int, struct zfcp_fsf_req *);
 extern void zfcp_dbf_hba_bit_err(char *, struct zfcp_fsf_req *);
-extern void zfcp_dbf_hba_berr(struct zfcp_dbf *, struct zfcp_fsf_req *);
 extern void zfcp_dbf_hba_def_err(struct zfcp_adapter *, u64, u16, void **);
 extern void zfcp_dbf_hba_basic(char *, struct zfcp_adapter *);
 extern void zfcp_dbf_san_req(char *, struct zfcp_fsf_req *, u32);
-- 
2.11.2
