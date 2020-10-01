Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732274AbgJARVg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Oct 2020 13:21:36 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 2/2] net/iucv: fix indentation in __iucv_message_receive()
Date: Thu,  1 Oct 2020 19:21:27 +0200
Message-Id: <20201001172127.98541-3-jwi@linux.ibm.com>
In-Reply-To: <20201001172127.98541-1-jwi@linux.ibm.com>
References: <20201001172127.98541-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

smatch complains about
net/iucv/iucv.c:1119 __iucv_message_receive() warn: inconsistent indenting

While touching this line, also make the return logic consistent and thus
get rid of a goto label.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/iucv/iucv.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index cd2e468852e7..349c6ac3313f 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -1116,10 +1116,9 @@ int __iucv_message_receive(struct iucv_path *path, struct iucv_message *msg,
 	if (msg->flags & IUCV_IPRMDATA)
 		return iucv_message_receive_iprmdata(path, msg, flags,
 						     buffer, size, residual);
-	 if (cpumask_empty(&iucv_buffer_cpumask)) {
-		rc = -EIO;
-		goto out;
-	}
+	if (cpumask_empty(&iucv_buffer_cpumask))
+		return -EIO;
+
 	parm = iucv_param[smp_processor_id()];
 	memset(parm, 0, sizeof(union iucv_param));
 	parm->db.ipbfadr1 = (u32)(addr_t) buffer;
@@ -1135,7 +1134,6 @@ int __iucv_message_receive(struct iucv_path *path, struct iucv_message *msg,
 		if (residual)
 			*residual = parm->db.ipbfln1f;
 	}
-out:
 	return rc;
 }
 EXPORT_SYMBOL(__iucv_message_receive);
-- 
2.17.1
