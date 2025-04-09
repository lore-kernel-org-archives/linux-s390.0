Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04B726560D
	for <linux-s390@vger.kernel.org>; Wed,  9 Apr 2025 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207399; cv=none; b=nlq1/KQBvWjLMUoYI+q5GdxZbpZ5TeES+0DoRZOIfyFPAe9Ub6rmePi/NSeBaRWhj3v76PYXblTwWdkRXIwh7nqN8tBTldUn2vr0s1byi6jcyZ4dn+BYg/nI25AezHoTNqbnzZCbZSEU/TcauzLAefgink0GzKgcy4lbciX2ulI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207399; c=relaxed/simple;
	bh=pZNBqRxcPOKJscKAcxYh10rJ2pOgpbzfyg05vnyhVQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6Em+urM9uun3Rhj7jXgyrW5DqsIeYrWWi2F1ARvBv3SObRAx9ndQ3/kjcTPRW9acuDjkY91nAb9rcl3Ma6olQr2bHzs8TcDDNRmTNBbU1wETjrRPRWjHVc7OouC/GIgw0h3/wX7QNs2nSj9R67Fq2l3xEyV+U/LK9M20Ip9n20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JtgVWNFE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JtgVWNFE"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539CT7Ol019382;
	Wed, 9 Apr 2025 14:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=q5Uo970/s3P6cjkO4
	ZJrj/C/oCdJqxE9pX0Zv+G1Jbk=; b=JtgVWNFESdv9LaE5xZzsOlWevEl0VMEBQ
	ABOX4vbRiAjlNds8V1mDeJqBCJW8oZfbZ6aojyult8piYNi5WoTNq7Apdpn+ai30
	AkaNF09q40d7pW46RUGOZgn5G3rAAB0swDVN8gp15HCYZOEtpHlkpDhQorsG0JNK
	Eyt4fvJ0WO/B64N0hIVWtJmeR/0HEMjTQTaXYv6M2qf6oT6R6NgOdWesfqY0DetY
	Kl16DJufZY5V7tnNM4a5M7jFhgS+QA2J/pJtodOKNTLij1cj2lfy/JxS+xfN73bC
	DVVrpuLNKFLKIZSUkJIb9Usu1yUD4UNB3V0+DgQlf+9Wa+8zQebiA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45wrx2rhkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 14:03:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 539A3A4R025510;
	Wed, 9 Apr 2025 14:03:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ugbkyy3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 14:03:12 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 539E38NB28967464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 14:03:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A463F20040;
	Wed,  9 Apr 2025 14:03:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1ACA52004B;
	Wed,  9 Apr 2025 14:03:08 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.93.164])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Apr 2025 14:03:08 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v4 03/24] s390/ap: Introduce ap message buffer pool
Date: Wed,  9 Apr 2025 16:02:44 +0200
Message-ID: <20250409140305.58900-4-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409140305.58900-1-freude@linux.ibm.com>
References: <20250409140305.58900-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yn3Wqh0WStp2mOdDf05vbrM4rQiv5ftS
X-Proofpoint-ORIG-GUID: yn3Wqh0WStp2mOdDf05vbrM4rQiv5ftS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504090082

There is a need for a do-not-allocate-memory path through the AP bus
layer. The pkey layer may be triggered via the in-kernel interface
from a protected key crypto algorithm (namely PAES) to convert a
secure key into a protected key. This happens in a workqueue context,
so sleeping is allowed but memory allocations causing IO operations
are not permitted.

To accomplish this, an AP message memory pool with pre-allocated space
is established. When ap_init_apmsg() with use_mempool set to true is
called, instead of kmalloc() the ap message buffer is allocated from
the ap_msg_pool. This pool only holds a limited amount of buffers:
ap_msg_pool_min_items with the item size AP_DEFAULT_MAX_MSG_SIZE and
exactly one of these items (if available) is returned if
ap_init_apmsg() with the use_mempool arg set to true is called. When
this pool is exhausted and use_mempool is set true, ap_init_apmsg()
returns -ENOMEM without any attempt to allocate memory and the caller
has to deal with that.

Default values for this mempool of ap messages is:
 * Each buffer is 12KB (that is the default AP bus size
   and all the urgent messages should fit into this space).
 * Minimum items held in the pool is 8. This value is adjustable
   via module parameter ap.msgpool_min_items.

The zcrypt layer may use this flag to indicate to the ap bus that the
processing path for this message should not allocate memory but should
use pre-allocated memory buffer instead.  This is to prevent deadlocks
with crypto and io for example with encrypted swap volumes.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/ap_bus.c     | 54 ++++++++++++++++++++++++++++++--
 drivers/s390/crypto/ap_bus.h     |  3 +-
 drivers/s390/crypto/zcrypt_api.c | 10 +++---
 3 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 69f2d873748a..aac227397137 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -40,6 +40,7 @@
 #include <linux/module.h>
 #include <asm/uv.h>
 #include <asm/chsc.h>
+#include <linux/mempool.h>
 
 #include "ap_bus.h"
 #include "ap_debug.h"
@@ -101,6 +102,27 @@ static struct ap_config_info *const ap_qci_info_old = &qci[1];
  */
 debug_info_t *ap_dbf_info;
 
+/*
+ * There is a need for a do-not-allocate-memory path through the AP bus
+ * layer. The pkey layer may be triggered via the in-kernel interface from
+ * a protected key crypto algorithm (namely PAES) to convert a secure key
+ * into a protected key. This happens in a workqueue context, so sleeping
+ * is allowed but memory allocations causing IO operations are not permitted.
+ * To accomplish this, an AP message memory pool with pre-allocated space
+ * is established. When ap_init_apmsg() with use_mempool set to true is
+ * called, instead of kmalloc() the ap message buffer is allocated from
+ * the ap_msg_pool. This pool only holds a limited amount of buffers:
+ * ap_msg_pool_min_items with the item size AP_DEFAULT_MAX_MSG_SIZE and
+ * exactly one of these items (if available) is returned if ap_init_apmsg()
+ * with the use_mempool arg set to true is called. When this pool is exhausted
+ * and use_mempool is set true, ap_init_apmsg() returns -ENOMEM without
+ * any attempt to allocate memory and the caller has to deal with that.
+ */
+static mempool_t *ap_msg_pool;
+static unsigned int ap_msg_pool_min_items = 8;
+module_param_named(msgpool_min_items, ap_msg_pool_min_items, uint, 0440);
+MODULE_PARM_DESC(msgpool_min_items, "AP message pool minimal items.");
+
 /*
  * AP bus rescan related things.
  */
@@ -549,11 +571,22 @@ static void ap_poll_thread_stop(void)
 /*
  * ap_init_apmsg() - Initialize ap_message.
  */
-int ap_init_apmsg(struct ap_message *ap_msg)
+int ap_init_apmsg(struct ap_message *ap_msg, bool use_mempool)
 {
-	unsigned int maxmsgsize = atomic_read(&ap_max_msg_size);
+	unsigned int maxmsgsize;
 
 	memset(ap_msg, 0, sizeof(*ap_msg));
+
+	if (use_mempool) {
+		ap_msg->msg = mempool_alloc_preallocated(ap_msg_pool);
+		if (!ap_msg->msg)
+			return -ENOMEM;
+		ap_msg->bufsize = AP_DEFAULT_MAX_MSG_SIZE;
+		ap_msg->flags |= AP_MSG_FLAG_MEMPOOL;
+		return 0;
+	}
+
+	maxmsgsize = atomic_read(&ap_max_msg_size);
 	ap_msg->msg = kmalloc(maxmsgsize, GFP_KERNEL);
 	if (!ap_msg->msg)
 		return -ENOMEM;
@@ -568,7 +601,12 @@ EXPORT_SYMBOL(ap_init_apmsg);
  */
 void ap_release_apmsg(struct ap_message *ap_msg)
 {
-	kfree_sensitive(ap_msg->msg);
+	if (ap_msg->flags & AP_MSG_FLAG_MEMPOOL) {
+		memzero_explicit(ap_msg->msg, ap_msg->bufsize);
+		mempool_free(ap_msg->msg, ap_msg_pool);
+	} else {
+		kfree_sensitive(ap_msg->msg);
+	}
 }
 EXPORT_SYMBOL(ap_release_apmsg);
 
@@ -2457,6 +2495,14 @@ static int __init ap_module_init(void)
 	/* init ap_queue hashtable */
 	hash_init(ap_queues);
 
+	/* create ap msg buffer memory pool */
+	ap_msg_pool = mempool_create_kmalloc_pool(ap_msg_pool_min_items,
+						  AP_DEFAULT_MAX_MSG_SIZE);
+	if (!ap_msg_pool) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
 	/* set up the AP permissions (ioctls, ap and aq masks) */
 	ap_perms_init();
 
@@ -2503,6 +2549,7 @@ static int __init ap_module_init(void)
 out_bus:
 	bus_unregister(&ap_bus_type);
 out:
+	mempool_destroy(ap_msg_pool);
 	ap_debug_exit();
 	return rc;
 }
@@ -2513,6 +2560,7 @@ static void __exit ap_module_exit(void)
 	ap_irq_exit();
 	root_device_unregister(ap_root_device);
 	bus_unregister(&ap_bus_type);
+	mempool_destroy(ap_msg_pool);
 	ap_debug_exit();
 }
 
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 483231bcdea6..60c41d8116ad 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -236,8 +236,9 @@ struct ap_message {
 #define AP_MSG_FLAG_SPECIAL  0x0001	/* flag msg as 'special' with NQAP */
 #define AP_MSG_FLAG_USAGE    0x0002	/* CCA, EP11: usage (no admin) msg */
 #define AP_MSG_FLAG_ADMIN    0x0004	/* CCA, EP11: admin (=control) msg */
+#define AP_MSG_FLAG_MEMPOOL  0x0008 /* ap msg buffer allocated via mempool */
 
-int ap_init_apmsg(struct ap_message *ap_msg);
+int ap_init_apmsg(struct ap_message *ap_msg, bool use_mempool);
 void ap_release_apmsg(struct ap_message *ap_msg);
 
 enum ap_sm_wait ap_sm_event(struct ap_queue *aq, enum ap_sm_event event);
diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 78df25da0b95..ad09c5306e28 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -648,7 +648,7 @@ static long zcrypt_rsa_modexpo(struct ap_perms *perms,
 
 	trace_s390_zcrypt_req(mex, TP_ICARSAMODEXPO);
 
-	rc = ap_init_apmsg(&ap_msg);
+	rc = ap_init_apmsg(&ap_msg, false);
 	if (rc)
 		goto out;
 
@@ -753,7 +753,7 @@ static long zcrypt_rsa_crt(struct ap_perms *perms,
 
 	trace_s390_zcrypt_req(crt, TP_ICARSACRT);
 
-	rc = ap_init_apmsg(&ap_msg);
+	rc = ap_init_apmsg(&ap_msg, false);
 	if (rc)
 		goto out;
 
@@ -861,7 +861,7 @@ static long _zcrypt_send_cprb(bool userspace, struct ap_perms *perms,
 
 	xcrb->status = 0;
 
-	rc = ap_init_apmsg(&ap_msg);
+	rc = ap_init_apmsg(&ap_msg, false);
 	if (rc)
 		goto out;
 
@@ -1045,7 +1045,7 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 
 	trace_s390_zcrypt_req(xcrb, TP_ZSENDEP11CPRB);
 
-	rc = ap_init_apmsg(&ap_msg);
+	rc = ap_init_apmsg(&ap_msg, false);
 	if (rc)
 		goto out;
 
@@ -1219,7 +1219,7 @@ static long zcrypt_rng(char *buffer)
 
 	trace_s390_zcrypt_req(buffer, TP_HWRNGCPRB);
 
-	rc = ap_init_apmsg(&ap_msg);
+	rc = ap_init_apmsg(&ap_msg, false);
 	if (rc)
 		goto out;
 	rc = prep_rng_ap_msg(&ap_msg, &func_code, &domain);
-- 
2.43.0

