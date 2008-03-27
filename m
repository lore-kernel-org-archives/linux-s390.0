From: Christof Schmitt <christof.schmitt@de.ibm.com>
Subject: [patch 03/11] zfcp: Remove qtcb dump to kernel log
Date: Thu, 27 Mar 2008 14:21:57 +0100
Message-ID: <20080327133024.594716000@de.ibm.com>
References: <20080327132154.826339000@de.ibm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline; filename=zfcp_msg_cleanup_qtcb_trace.diff
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Martin Peschke <mp3@de.ibm.com>, Christof Schmitt <christof.schmitt@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Peschke <mp3@de.ibm.com>

Is not appropriate to printk() tons of hardware trace data.

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
Signed-off-by: Christof Schmitt <christof.schmitt@de.ibm.com>
---
 drivers/s390/scsi/zfcp_fsf.c |   31 -------------------------------
 1 file changed, 31 deletions(-)

--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -284,37 +284,6 @@ zfcp_fsf_protstatus_eval(struct zfcp_fsf
 		goto skip_protstatus;
 	}
 
-	/* log additional information provided by FSF (if any) */
-	if (likely(qtcb->header.log_length)) {
-		/* do not trust them ;-) */
-		if (unlikely(qtcb->header.log_start >
-			     sizeof(struct fsf_qtcb))) {
-			ZFCP_LOG_NORMAL
-			    ("bug: ULP (FSF logging) log data starts "
-			     "beyond end of packet header. Ignored. "
-			     "(start=%i, size=%li)\n",
-			     qtcb->header.log_start,
-			     sizeof(struct fsf_qtcb));
-			goto forget_log;
-		}
-		if (unlikely((size_t) (qtcb->header.log_start +
-				       qtcb->header.log_length) >
-			     sizeof(struct fsf_qtcb))) {
-			ZFCP_LOG_NORMAL("bug: ULP (FSF logging) log data ends "
-					"beyond end of packet header. Ignored. "
-					"(start=%i, length=%i, size=%li)\n",
-					qtcb->header.log_start,
-					qtcb->header.log_length,
-					sizeof(struct fsf_qtcb));
-			goto forget_log;
-		}
-		ZFCP_LOG_TRACE("ULP log data: \n");
-		ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_TRACE,
-			      (char *) qtcb + qtcb->header.log_start,
-			      qtcb->header.log_length);
-	}
- forget_log:
-
 	/* evaluate FSF Protocol Status */
 	switch (qtcb->prefix.prot_status) {
 

-- 
