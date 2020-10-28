Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29846 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726837AbgJ1Vgt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Oct 2020 17:36:49 -0400
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 3/5] zfcp: clarify & assert the stat_lock locking in zfcp_qdio_send()
Date: Wed, 28 Oct 2020 19:30:50 +0100
Message-Id: <b023b1472630f4bf9fce580577d7bb49de89ccbf.1603908167.git.bblock@linux.ibm.com>
In-Reply-To: <cover.1603908167.git.bblock@linux.ibm.com>
References: <cover.1603908167.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Benjamin Block <bblock@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Julian Wiedmann <jwi@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

Explain why the plain spin_lock() suffices in current code, even when
the stat_lock is also used by zfcp_qdio_int_req() in tasklet context.

We could also promote the spin_lock() to a spin_lock_irqsave(), but that
would just obfuscate the locking even further.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_qdio.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/s390/scsi/zfcp_qdio.c b/drivers/s390/scsi/zfcp_qdio.c
index 9fc045ddf66d..23ab16d65f2a 100644
--- a/drivers/s390/scsi/zfcp_qdio.c
+++ b/drivers/s390/scsi/zfcp_qdio.c
@@ -10,6 +10,7 @@
 #define KMSG_COMPONENT "zfcp"
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
+#include <linux/lockdep.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include "zfcp_ext.h"
@@ -283,6 +284,13 @@ int zfcp_qdio_send(struct zfcp_qdio *qdio, struct zfcp_qdio_req *q_req)
 	int retval;
 	u8 sbal_number = q_req->sbal_number;
 
+	/*
+	 * This should actually be a spin_lock_bh(stat_lock), to protect against
+	 * zfcp_qdio_int_req() in tasklet context.
+	 * But we can't do so (and are safe), as we always get called with IRQs
+	 * disabled by spin_lock_irq[save](req_q_lock).
+	 */
+	lockdep_assert_irqs_disabled();
 	spin_lock(&qdio->stat_lock);
 	zfcp_qdio_account(qdio);
 	spin_unlock(&qdio->stat_lock);
-- 
2.26.2
