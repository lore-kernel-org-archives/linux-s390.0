From: Steffen Maier <maier@linux.vnet.ibm.com>
Subject: [PATCH RESEND 1/4] zfcp: consistently use appropriate SBAL flag definitions
Date: Thu, 22 Aug 2013 17:49:31 +0200
Message-ID: <1377186574-26954-2-git-send-email-maier@linux.vnet.ibm.com>
References: <1377099366.2011.23.camel@dabdike.int.hansenpartnership.com>
 <1377186574-26954-1-git-send-email-maier@linux.vnet.ibm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1377186574-26954-1-git-send-email-maier@linux.vnet.ibm.com>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Steffen Maier <maier@linux.vnet.ibm.com>, Martin Peschke <mpeschke@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Peschke <mpeschke@linux.vnet.ibm.com>

minor cleanup for status read request

Signed-off-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
---
 drivers/s390/scsi/zfcp_fsf.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -770,7 +770,8 @@ int zfcp_fsf_status_read(struct zfcp_qdi
 	if (zfcp_qdio_sbal_get(qdio))
 		goto out;
 
-	req = zfcp_fsf_req_create(qdio, FSF_QTCB_UNSOLICITED_STATUS, 0,
+	req = zfcp_fsf_req_create(qdio, FSF_QTCB_UNSOLICITED_STATUS,
+				  SBAL_SFLAGS0_TYPE_STATUS,
 				  adapter->pool.status_read_req);
 	if (IS_ERR(req)) {
 		retval = PTR_ERR(req);
