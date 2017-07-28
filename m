From: Benjamin Block <bblock@linux.vnet.ibm.com>
Subject: [PATCH 17/22] zfcp: fix kernel doc comment typos for struct zfcp_dbf_scsi
Date: Fri, 28 Jul 2017 12:31:03 +0200
Message-ID: <b2d16f3a7d55cd063a7e931a6479c53d9b373abd.1501085249.git.bblock@linux.vnet.ibm.com>
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

Improves commit 250a1352b95e ("[SCSI] zfcp: Redesign of the debug tracing
for SCSI records.")

Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.vnet.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.vnet.ibm.com>
---
 drivers/s390/scsi/zfcp_dbf.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_dbf.h b/drivers/s390/scsi/zfcp_dbf.h
index 33ccf15b63e0..3508c00458f4 100644
--- a/drivers/s390/scsi/zfcp_dbf.h
+++ b/drivers/s390/scsi/zfcp_dbf.h
@@ -208,12 +208,12 @@ enum zfcp_dbf_scsi_id {
  * @scsi_result: scsi result
  * @scsi_retries: current retry number of scsi request
  * @scsi_allowed: allowed retries
- * @fcp_rsp_info: FCP response info
+ * @fcp_rsp_info: FCP response info code
  * @scsi_opcode: scsi opcode
  * @fsf_req_id: request id of fsf request
  * @host_scribble: LLD specific data attached to SCSI request
- * @pl_len: length of paload stored as zfcp_dbf_pay
- * @fsf_rsp: response for fsf request
+ * @pl_len: length of payload stored as zfcp_dbf_pay
+ * @fcp_rsp: response for FCP request
  * @scsi_lun_64_hi: scsi device logical unit number, high part of 64 bit
  */
 struct zfcp_dbf_scsi {
-- 
2.11.2
