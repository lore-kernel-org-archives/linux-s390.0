From: Benjamin Block <bblock@linux.vnet.ibm.com>
Subject: [PATCH 14/22] zfcp: clarify that we don't need "link" test on failed open port
Date: Fri, 28 Jul 2017 12:31:00 +0200
Message-ID: <04e5a8789513584a0d4d870b07ec82b9d1ede9d7.1501085249.git.bblock@linux.vnet.ibm.com>
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

Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.vnet.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.vnet.ibm.com>
---
 drivers/s390/scsi/zfcp_fsf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index c10b4b9f1574..9f73b8fc7f3b 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -3,7 +3,7 @@
  *
  * Implementation of FSF commands.
  *
- * Copyright IBM Corp. 2002, 2015
+ * Copyright IBM Corp. 2002, 2017
  */
 
 #define KMSG_COMPONENT "zfcp"
@@ -1393,6 +1393,8 @@ static void zfcp_fsf_open_port_handler(struct zfcp_fsf_req *req)
 	case FSF_ADAPTER_STATUS_AVAILABLE:
 		switch (header->fsf_status_qual.word[0]) {
 		case FSF_SQ_INVOKE_LINK_TEST_PROCEDURE:
+			/* no zfcp_fc_test_link() with failed open port */
+			/* fall through */
 		case FSF_SQ_ULP_DEPENDENT_ERP_REQUIRED:
 		case FSF_SQ_NO_RETRY_POSSIBLE:
 			req->status |= ZFCP_STATUS_FSFREQ_ERROR;
-- 
2.11.2
