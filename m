Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727055AbfGCA3o (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Jul 2019 20:29:44 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x62L1hGC048116
        for <linux-s390@vger.kernel.org>; Tue, 2 Jul 2019 17:02:11 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tgcry4g6b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 02 Jul 2019 17:02:11 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <bblock@linux.ibm.com>;
        Tue, 2 Jul 2019 22:02:09 +0100
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 2/3] zfcp: fix request object use-after-free in send path causing wrong traces
Date: Tue,  2 Jul 2019 23:02:01 +0200
In-Reply-To: <cover.1562098940.git.bblock@linux.ibm.com>
References: <cover.1562098940.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <80afa28579890b7c276a57b1ad7a970d5f349689.1562098940.git.bblock@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, stable@vger.kernel.org

When tracing instances where we open and close WKA ports, we also pass the
request-ID of the respective FSF command.

But after successfully sending the FSF command we must not use the
request-object anymore, as this might result in an use-after-free (see
"zfcp: fix request object use-after-free in send path causing seqno errors"
).

To fix this add a new variable that caches the request-ID before sending
the request. This won't change during the hand-off to the FCP channel,
and so it's safe to trace this cached request-ID later, instead of using
the request object.

Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
Fixes: d27a7cb91960 ("zfcp: trace on request for open and close of WKA port")
Cc: <stable@vger.kernel.org> #2.6.38+
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_fsf.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index c5b2615b49ef..296bbc3c4606 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -1627,6 +1627,7 @@ int zfcp_fsf_open_wka_port(struct zfcp_fc_wka_port *wka_port)
 {
 	struct zfcp_qdio *qdio = wka_port->adapter->qdio;
 	struct zfcp_fsf_req *req;
+	unsigned long req_id = 0;
 	int retval = -EIO;
 
 	spin_lock_irq(&qdio->req_q_lock);
@@ -1649,6 +1650,8 @@ int zfcp_fsf_open_wka_port(struct zfcp_fc_wka_port *wka_port)
 	hton24(req->qtcb->bottom.support.d_id, wka_port->d_id);
 	req->data = wka_port;
 
+	req_id = req->req_id;
+
 	zfcp_fsf_start_timer(req, ZFCP_FSF_REQUEST_TIMEOUT);
 	retval = zfcp_fsf_req_send(req);
 	if (retval)
@@ -1657,7 +1660,7 @@ int zfcp_fsf_open_wka_port(struct zfcp_fc_wka_port *wka_port)
 out:
 	spin_unlock_irq(&qdio->req_q_lock);
 	if (!retval)
-		zfcp_dbf_rec_run_wka("fsowp_1", wka_port, req->req_id);
+		zfcp_dbf_rec_run_wka("fsowp_1", wka_port, req_id);
 	return retval;
 }
 
@@ -1683,6 +1686,7 @@ int zfcp_fsf_close_wka_port(struct zfcp_fc_wka_port *wka_port)
 {
 	struct zfcp_qdio *qdio = wka_port->adapter->qdio;
 	struct zfcp_fsf_req *req;
+	unsigned long req_id = 0;
 	int retval = -EIO;
 
 	spin_lock_irq(&qdio->req_q_lock);
@@ -1705,6 +1709,8 @@ int zfcp_fsf_close_wka_port(struct zfcp_fc_wka_port *wka_port)
 	req->data = wka_port;
 	req->qtcb->header.port_handle = wka_port->handle;
 
+	req_id = req->req_id;
+
 	zfcp_fsf_start_timer(req, ZFCP_FSF_REQUEST_TIMEOUT);
 	retval = zfcp_fsf_req_send(req);
 	if (retval)
@@ -1713,7 +1719,7 @@ int zfcp_fsf_close_wka_port(struct zfcp_fc_wka_port *wka_port)
 out:
 	spin_unlock_irq(&qdio->req_q_lock);
 	if (!retval)
-		zfcp_dbf_rec_run_wka("fscwp_1", wka_port, req->req_id);
+		zfcp_dbf_rec_run_wka("fscwp_1", wka_port, req_id);
 	return retval;
 }
 
-- 
2.17.1
