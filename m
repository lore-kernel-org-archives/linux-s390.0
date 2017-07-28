From: Benjamin Block <bblock@linux.vnet.ibm.com>
Subject: [PATCH 18/22] zfcp: clean up redundant code with fall through in link down SRB switch case
Date: Fri, 28 Jul 2017 12:31:04 +0200
Message-ID: <7334912a2cfb4c46ce7bf41ce53c851187891d5d.1501085249.git.bblock@linux.vnet.ibm.com>
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

Signed-off-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>
[maier@linux.vnet.ibm.com: re-worded short description for more details]
Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.vnet.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.vnet.ibm.com>
---
 drivers/s390/scsi/zfcp_fsf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index cc923c71a0fa..eefb474a9e42 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -197,8 +197,6 @@ static void zfcp_fsf_status_read_link_down(struct zfcp_fsf_req *req)
 
 	switch (sr_buf->status_subtype) {
 	case FSF_STATUS_READ_SUB_NO_PHYSICAL_LINK:
-		zfcp_fsf_link_down_info_eval(req, ldi);
-		break;
 	case FSF_STATUS_READ_SUB_FDISC_FAILED:
 		zfcp_fsf_link_down_info_eval(req, ldi);
 		break;
-- 
2.11.2
