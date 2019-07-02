Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727241AbfGCAeh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Jul 2019 20:34:37 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x62L1hGN048098
        for <linux-s390@vger.kernel.org>; Tue, 2 Jul 2019 17:02:10 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tgcry4g5g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 02 Jul 2019 17:02:09 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <bblock@linux.ibm.com>;
        Tue, 2 Jul 2019 22:02:07 +0100
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 1/3] zfcp: fix request object use-after-free in send path causing seqno errors
Date: Tue,  2 Jul 2019 23:02:00 +0200
In-Reply-To: <cover.1562098940.git.bblock@linux.ibm.com>
References: <cover.1562098940.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <b47864dfe92ea0bac4276922bedc8d48330d2885.1562098940.git.bblock@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, stable@vger.kernel.org

With a recent change to our send path for FSF commands we introduced a
possible use-after-free of request-objects, that might further lead to zfcp
crafting bad requests, which the FCP channel correctly complains about with
an error (FSF_PROT_SEQ_NUMB_ERROR). This error is then handled by an
adapter-wide recovery.

The following sequence illustrates the possible use-after-free:

    Send Path:

        int zfcp_fsf_open_port(struct zfcp_erp_action *erp_action)
        {
                struct zfcp_fsf_req *req;
                ...
                spin_lock_irq(&qdio->req_q_lock);
        //                     ^^^^^^^^^^^^^^^^
        //                     protects QDIO queue during sending
                ...
                req = zfcp_fsf_req_create(qdio,
                                          FSF_QTCB_OPEN_PORT_WITH_DID,
                                          SBAL_SFLAGS0_TYPE_READ,
                                          qdio->adapter->pool.erp_req);
        //            ^^^^^^^^^^^^^^^^^^^
        //            allocation of the request-object
                ...
                retval = zfcp_fsf_req_send(req);
                ...
                spin_unlock_irq(&qdio->req_q_lock);
                return retval;
        }

        static int zfcp_fsf_req_send(struct zfcp_fsf_req *req)
        {
                struct zfcp_adapter *adapter = req->adapter;
                struct zfcp_qdio *qdio = adapter->qdio;
                ...
                zfcp_reqlist_add(adapter->req_list, req);
        //      ^^^^^^^^^^^^^^^^
        //      add request to our driver-internal hash-table for tracking
        //      (protected by separate lock req_list->lock)
                ...
                if (zfcp_qdio_send(qdio, &req->qdio_req)) {
        //          ^^^^^^^^^^^^^^
        //          hand-off the request to FCP channel;
        //          the request can complete at any point now
                        ...
                }

                /* Don't increase for unsolicited status */
                if (!zfcp_fsf_req_is_status_read_buffer(req))
        //           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        //           possible use-after-free
                        adapter->fsf_req_seq_no++;
        //                       ^^^^^^^^^^^^^^^^
        //                       because of the use-after-free we might
        //                       miss this accounting, and as follow-up
        //                       this results in the FCP channel error
        //                       FSF_PROT_SEQ_NUMB_ERROR
                adapter->req_no++;

                return 0;
        }

        static inline bool
        zfcp_fsf_req_is_status_read_buffer(struct zfcp_fsf_req *req)
        {
                return req->qtcb == NULL;
        //             ^^^^^^^^^
        //             possible use-after-free
        }

    Response Path:

        void zfcp_fsf_reqid_check(struct zfcp_qdio *qdio, int sbal_idx)
        {
                ...
                struct zfcp_fsf_req *fsf_req;
                ...
                for (idx = 0; idx < QDIO_MAX_ELEMENTS_PER_BUFFER; idx++) {
                        ...
                        fsf_req = zfcp_reqlist_find_rm(adapter->req_list,
                                                       req_id);
        //                        ^^^^^^^^^^^^^^^^^^^^
        //                        remove request from our driver-internal
        //                        hash-table (lock req_list->lock)
                        ...
                        zfcp_fsf_req_complete(fsf_req);
                }
        }

        static void zfcp_fsf_req_complete(struct zfcp_fsf_req *req)
        {
                ...
                if (likely(req->status & ZFCP_STATUS_FSFREQ_CLEANUP))
                        zfcp_fsf_req_free(req);
        //              ^^^^^^^^^^^^^^^^^
        //              free memory for request-object
                else
                        complete(&req->completion);
        //              ^^^^^^^^
        //              completion notification for code-paths that wait
        //              synchronous for the completion of the request; in
        //              those the memory is freed separately
        }

The result of the use-after-free only affects the send path, and can not
lead to any data corruption. In case we miss the sequence-number
accounting, because the memory was already re-purposed, the next FSF
command will fail with said FCP channel error, and we will recover the
whole adapter. This causes no additional errors, but it slows down traffic.
There is a slight chance of the same thing happen again recursively after
the adapter recovery, but so far this has not been seen.

This was seen under z/VM, where the send path might run on a virtual CPU
that gets scheduled away by z/VM, while the return path might still run,
and so create the necessary timing. Running with KASAN can also slow down
the kernel sufficiently to run into this user-after-free, and then see the
report by KASAN.

To fix this, simply pull the test for the sequence-number accounting in
front of the hand-off to the FCP channel (this information doesn't change
during hand-off), but leave the sequence-number accounting itself where it
is.

To make future regressions of the same kind less likely, add comments to
all closely related code-paths.

Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
Fixes: f9eca0227600 ("scsi: zfcp: drop duplicate fsf_command from zfcp_fsf_req which is also in QTCB header")
Cc: <stable@vger.kernel.org> #5.0+
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_fsf.c | 45 ++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index d94496ee6883..c5b2615b49ef 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
 #include <linux/blktrace_api.h>
+#include <linux/types.h>
 #include <linux/slab.h>
 #include <scsi/fc/fc_els.h>
 #include "zfcp_ext.h"
@@ -741,6 +742,7 @@ static struct zfcp_fsf_req *zfcp_fsf_req_create(struct zfcp_qdio *qdio,
 
 static int zfcp_fsf_req_send(struct zfcp_fsf_req *req)
 {
+	const bool is_srb = zfcp_fsf_req_is_status_read_buffer(req);
 	struct zfcp_adapter *adapter = req->adapter;
 	struct zfcp_qdio *qdio = adapter->qdio;
 	int req_id = req->req_id;
@@ -757,8 +759,20 @@ static int zfcp_fsf_req_send(struct zfcp_fsf_req *req)
 		return -EIO;
 	}
 
+	/*
+	 * NOTE: DO NOT TOUCH ASYNC req PAST THIS POINT.
+	 *	 ONLY TOUCH SYNC req AGAIN ON req->completion.
+	 *
+	 * The request might complete and be freed concurrently at any point
+	 * now. This is not protected by the QDIO-lock (req_q_lock). So any
+	 * uncontrolled access after this might result in an use-after-free bug.
+	 * Only if the request doesn't have ZFCP_STATUS_FSFREQ_CLEANUP set, and
+	 * when it is completed via req->completion, is it safe to use req
+	 * again.
+	 */
+
 	/* Don't increase for unsolicited status */
-	if (!zfcp_fsf_req_is_status_read_buffer(req))
+	if (!is_srb)
 		adapter->fsf_req_seq_no++;
 	adapter->req_no++;
 
@@ -805,6 +819,7 @@ int zfcp_fsf_status_read(struct zfcp_qdio *qdio)
 	retval = zfcp_fsf_req_send(req);
 	if (retval)
 		goto failed_req_send;
+	/* NOTE: DO NOT TOUCH req PAST THIS POINT! */
 
 	goto out;
 
@@ -914,8 +929,10 @@ struct zfcp_fsf_req *zfcp_fsf_abort_fcp_cmnd(struct scsi_cmnd *scmnd)
 	req->qtcb->bottom.support.req_handle = (u64) old_req_id;
 
 	zfcp_fsf_start_timer(req, ZFCP_FSF_SCSI_ER_TIMEOUT);
-	if (!zfcp_fsf_req_send(req))
+	if (!zfcp_fsf_req_send(req)) {
+		/* NOTE: DO NOT TOUCH req, UNTIL IT COMPLETES! */
 		goto out;
+	}
 
 out_error_free:
 	zfcp_fsf_req_free(req);
@@ -1098,6 +1115,7 @@ int zfcp_fsf_send_ct(struct zfcp_fc_wka_port *wka_port,
 	ret = zfcp_fsf_req_send(req);
 	if (ret)
 		goto failed_send;
+	/* NOTE: DO NOT TOUCH req PAST THIS POINT! */
 
 	goto out;
 
@@ -1198,6 +1216,7 @@ int zfcp_fsf_send_els(struct zfcp_adapter *adapter, u32 d_id,
 	ret = zfcp_fsf_req_send(req);
 	if (ret)
 		goto failed_send;
+	/* NOTE: DO NOT TOUCH req PAST THIS POINT! */
 
 	goto out;
 
@@ -1243,6 +1262,7 @@ int zfcp_fsf_exchange_config_data(struct zfcp_erp_action *erp_action)
 		zfcp_fsf_req_free(req);
 		erp_action->fsf_req_id = 0;
 	}
+	/* NOTE: DO NOT TOUCH req PAST THIS POINT! */
 out:
 	spin_unlock_irq(&qdio->req_q_lock);
 	return retval;
@@ -1279,8 +1299,10 @@ int zfcp_fsf_exchange_config_data_sync(struct zfcp_qdio *qdio,
 	zfcp_fsf_start_timer(req, ZFCP_FSF_REQUEST_TIMEOUT);
 	retval = zfcp_fsf_req_send(req);
 	spin_unlock_irq(&qdio->req_q_lock);
-	if (!retval)
+	if (!retval) {
+		/* NOTE: ONLY TOUCH SYNC req AGAIN ON req->completion. */
 		wait_for_completion(&req->completion);
+	}
 
 	zfcp_fsf_req_free(req);
 	return retval;
@@ -1330,6 +1352,7 @@ int zfcp_fsf_exchange_port_data(struct zfcp_erp_action *erp_action)
 		zfcp_fsf_req_free(req);
 		erp_action->fsf_req_id = 0;
 	}
+	/* NOTE: DO NOT TOUCH req PAST THIS POINT! */
 out:
 	spin_unlock_irq(&qdio->req_q_lock);
 	return retval;
@@ -1372,8 +1395,10 @@ int zfcp_fsf_exchange_port_data_sync(struct zfcp_qdio *qdio,
 	retval = zfcp_fsf_req_send(req);
 	spin_unlock_irq(&qdio->req_q_lock);
 
-	if (!retval)
+	if (!retval) {
+		/* NOTE: ONLY TOUCH SYNC req AGAIN ON req->completion. */
 		wait_for_completion(&req->completion);
+	}
 
 	zfcp_fsf_req_free(req);
 
@@ -1493,6 +1518,7 @@ int zfcp_fsf_open_port(struct zfcp_erp_action *erp_action)
 		erp_action->fsf_req_id = 0;
 		put_device(&port->dev);
 	}
+	/* NOTE: DO NOT TOUCH req PAST THIS POINT! */
 out:
 	spin_unlock_irq(&qdio->req_q_lock);
 	return retval;
@@ -1557,6 +1583,7 @@ int zfcp_fsf_close_port(struct zfcp_erp_action *erp_action)
 		zfcp_fsf_req_free(req);
 		erp_action->fsf_req_id = 0;
 	}
+	/* NOTE: DO NOT TOUCH req PAST THIS POINT! */
 out:
 	spin_unlock_irq(&qdio->req_q_lock);
 	return retval;
@@ -1626,6 +1653,7 @@ int zfcp_fsf_open_wka_port(struct zfcp_fc_wka_port *wka_port)
 	retval = zfcp_fsf_req_send(req);
 	if (retval)
 		zfcp_fsf_req_free(req);
+	/* NOTE: DO NOT TOUCH req PAST THIS POINT! */
 out:
 	spin_unlock_irq(&qdio->req_q_lock);
 	if (!retval)
@@ -1681,6 +1709,7 @@ int zfcp_fsf_close_wka_port(struct zfcp_fc_wka_port *wka_port)
 	retval = zfcp_fsf_req_send(req);
 	if (retval)
 		zfcp_fsf_req_free(req);
+	/* NOTE: DO NOT TOUCH req PAST THIS POINT! */
 out:
 	spin_unlock_irq(&qdio->req_q_lock);
 	if (!retval)
@@ -1776,6 +1805,7 @@ int zfcp_fsf_close_physical_port(struct zfcp_erp_action *erp_action)
 		zfcp_fsf_req_free(req);
 		erp_action->fsf_req_id = 0;
 	}
+	/* NOTE: DO NOT TOUCH req PAST THIS POINT! */
 out:
 	spin_unlock_irq(&qdio->req_q_lock);
 	return retval;
@@ -1899,6 +1929,7 @@ int zfcp_fsf_open_lun(struct zfcp_erp_action *erp_action)
 		zfcp_fsf_req_free(req);
 		erp_action->fsf_req_id = 0;
 	}
+	/* NOTE: DO NOT TOUCH req PAST THIS POINT! */
 out:
 	spin_unlock_irq(&qdio->req_q_lock);
 	return retval;
@@ -1987,6 +2018,7 @@ int zfcp_fsf_close_lun(struct zfcp_erp_action *erp_action)
 		zfcp_fsf_req_free(req);
 		erp_action->fsf_req_id = 0;
 	}
+	/* NOTE: DO NOT TOUCH req PAST THIS POINT! */
 out:
 	spin_unlock_irq(&qdio->req_q_lock);
 	return retval;
@@ -2299,6 +2331,7 @@ int zfcp_fsf_fcp_cmnd(struct scsi_cmnd *scsi_cmnd)
 	retval = zfcp_fsf_req_send(req);
 	if (unlikely(retval))
 		goto failed_scsi_cmnd;
+	/* NOTE: DO NOT TOUCH req PAST THIS POINT! */
 
 	goto out;
 
@@ -2373,8 +2406,10 @@ struct zfcp_fsf_req *zfcp_fsf_fcp_task_mgmt(struct scsi_device *sdev,
 	zfcp_fc_fcp_tm(fcp_cmnd, sdev, tm_flags);
 
 	zfcp_fsf_start_timer(req, ZFCP_FSF_SCSI_ER_TIMEOUT);
-	if (!zfcp_fsf_req_send(req))
+	if (!zfcp_fsf_req_send(req)) {
+		/* NOTE: DO NOT TOUCH req, UNTIL IT COMPLETES! */
 		goto out;
+	}
 
 	zfcp_fsf_req_free(req);
 	req = NULL;
-- 
2.17.1
