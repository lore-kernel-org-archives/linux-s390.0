Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35294 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726347AbgGCNVQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jul 2020 09:21:16 -0400
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 7/7] zfcp: avoid benign overflow of the Request Queue's free-level
Date: Fri,  3 Jul 2020 15:20:03 +0200
Message-Id: <7f61f59a1f8db270312e64644f9173b8f1ac895f.1593780621.git.bblock@linux.ibm.com>
In-Reply-To: <cover.1593780621.git.bblock@linux.ibm.com>
References: <cover.1593780621.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Julian Wiedmann <jwi@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

zfcp_qdio_send() and zfcp_qdio_int_req() run concurrently, adding and
completing SBALs on the Request Queue. There's a theoretical race where
zfcp_qdio_int_req() completes a number of SBALs & increments the queue's
free-level _before_ zfcp_qdio_send() was able to decrement it.

This can cause ->req_q_free to momentarily hold a value larger than
QDIO_MAX_BUFFERS_PER_Q. Luckily zfcp_qdio_send() is always called under
->req_q_lock, and all readers of the free-level also take this lock. So
we can trust that zfcp_qdio_send() will clean up such a temporary
overflow before anyone can actually observe it.

But it's still confusing and annoying to worry about. So adjust the code
to avoid this race.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_qdio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/scsi/zfcp_qdio.c b/drivers/s390/scsi/zfcp_qdio.c
index d3d110a04884..e78d65bd46b1 100644
--- a/drivers/s390/scsi/zfcp_qdio.c
+++ b/drivers/s390/scsi/zfcp_qdio.c
@@ -260,17 +260,20 @@ int zfcp_qdio_send(struct zfcp_qdio *qdio, struct zfcp_qdio_req *q_req)
 	zfcp_qdio_account(qdio);
 	spin_unlock(&qdio->stat_lock);
 
+	atomic_sub(sbal_number, &qdio->req_q_free);
+
 	retval = do_QDIO(qdio->adapter->ccw_device, QDIO_FLAG_SYNC_OUTPUT, 0,
 			 q_req->sbal_first, sbal_number);
 
 	if (unlikely(retval)) {
+		/* Failed to submit the IO, roll back our modifications. */
+		atomic_add(sbal_number, &qdio->req_q_free);
 		zfcp_qdio_zero_sbals(qdio->req_q, q_req->sbal_first,
 				     sbal_number);
 		return retval;
 	}
 
 	/* account for transferred buffers */
-	atomic_sub(sbal_number, &qdio->req_q_free);
 	qdio->req_q_idx += sbal_number;
 	qdio->req_q_idx %= QDIO_MAX_BUFFERS_PER_Q;
 
-- 
2.26.2
