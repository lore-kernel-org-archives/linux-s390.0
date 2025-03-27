Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F677217F32
	for <linux-s390@vger.kernel.org>; Thu, 27 Mar 2025 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743086393; cv=none; b=WmsibvIAGQvVwfKSSW5maRXZm/2BUZms4JOW18ET1xbKrILD77WSdy3srV7DuLmwtsRCUxh2ygl46+QH1J91FzzR6yvEMVU+1wvjZVpLU0cN+jfOOqEgsCgNgeDvDPYJajH9XXi/yZUnnKZJBOailvupk/DId3ZDE4lZ7ItY/S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743086393; c=relaxed/simple;
	bh=r4Mh6BRInYfXbRFddgTL/HJoHj9775QGXvXPHleal+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fn5RrJZC7BG8XTsS5qjEC2/aU9dHvD12tWkYz4ADLrRq4ZIXH6gEiAENDssR1HXKzzlxUHm2JjOvBH3E77yoF6jJVKko5KUNFdEhfSz4z+bmG9aLuT9Mv8gaAmVSCqVQJEXm4zAM5SgTO5tNdLF/dEQTyCdNJMfgq/d0SuWB8MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l1CBdwxM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l1CBdwxM"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R8o1q8011964;
	Thu, 27 Mar 2025 14:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sN6RUWiT6orgubDrb
	m1aq6dinzyT/5zVgZ1MA0NxhMA=; b=l1CBdwxMSlv8nByINwBb/sl8MTNLe6zQ5
	Fy2kOxol0E30SlKVDGsScf8kPt9a4EGGDNRxVfa/GMd2Xn6mFdCkBjSBzvYAzvpw
	n1mTu7clDiB/PY92oJ4NWr9ihhaMCH0q1q4a3A6whCIHZjyCQun/7JAK0+njxvDe
	QSfXPaLtzJ0ghlgYiaZ5a+ugZXKSSL7OsmhnL2yajGlDrWWnLTmb6C5mJg7PG7b6
	TvDRDIEVPuNTQGasdEs1ICsO4Eem4wcG5uJCNNDJN9hJr1Gx4OUmTh2MyXGuzgHN
	TEPX+eLbV0LTbc6qMZqHHPNz/6PJPvJGxHXKVH3s37VoZKU0jK+HQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45mrt04e01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 14:39:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52RCB73F012359;
	Thu, 27 Mar 2025 14:39:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j91mdq2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 14:39:48 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52REdie752166956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 14:39:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D24920040;
	Thu, 27 Mar 2025 14:39:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D83B92004E;
	Thu, 27 Mar 2025 14:39:43 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.80.24])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Mar 2025 14:39:43 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v3 03/21] s390/ap: Introduce ap message buffer pool
Date: Thu, 27 Mar 2025 15:39:23 +0100
Message-ID: <20250327143941.45507-4-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327143941.45507-1-freude@linux.ibm.com>
References: <20250327143941.45507-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HRR_Zd5-mYBkgYCWVFYZtCXu35BvWgQ6
X-Proofpoint-GUID: HRR_Zd5-mYBkgYCWVFYZtCXu35BvWgQ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503270099

There is a need for a do-not-allocate-memory path through the
ap bus layer. When ap_init_apmsg() with use_mempool set to true
is called, instead of kmalloc() the ap message buffer is
allocated from the ap_msg_pool. This pool only holds a limited
amount of buffers: ap_msg_pool_min_items with the item size
AP_DEFAULT_MAX_MSG_SIZE and exactly one of these items (if available)
is returned if ap_init_apmsg() with the use_mempool arg set to true
is called. When this pool is exhausted and use_mempool is set true,
ap_init_apmsg() returns -ENOMEM without any attempt to allocate
memory.

Default values for this mempool of ap messages is:
 * Each buffer is 12KB (that is the default AP bus size
   and all the urgend messages should fit into this space).
 * Minimum items held in the pool is 8. This value is adjustable
   via module parameter ap.msgpool_min_items.

The zcrypt layer may use this flag to indicate to the ap bus
that the processing path for this message should not allocate
memory but should use pre-allocated memory buffer instead.
This is to prevent deadlocks with crypto and io for example
with encrypted swap volumes.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/ap_bus.c     | 57 ++++++++++++++++++++++++++++----
 drivers/s390/crypto/ap_bus.h     |  3 +-
 drivers/s390/crypto/zcrypt_api.c | 10 +++---
 3 files changed, 57 insertions(+), 13 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 4940eaf538e9..75dbab9dff4a 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -40,6 +40,7 @@
 #include <linux/module.h>
 #include <asm/uv.h>
 #include <asm/chsc.h>
+#include <linux/mempool.h>
 
 #include "ap_bus.h"
 #include "ap_debug.h"
@@ -101,6 +102,23 @@ static struct ap_config_info *const ap_qci_info_old = &qci[1];
  */
 debug_info_t *ap_dbf_info;
 
+/*
+ * There is a need for a do-not-allocate-memory path through the
+ * ap bus layer. When ap_init_apmsg() with use_mempool set to true
+ * is called, instead of kmalloc() the ap message buffer is
+ * allocated from the ap_msg_pool. This pool only holds a limited
+ * amount of buffers: ap_msg_pool_min_items with the item size
+ * AP_DEFAULT_MAX_MSG_SIZE and exactly one of these items (if available)
+ * is returned if ap_init_apmsg() with the use_mempool arg set to true
+ * is called. When this pool is exhausted and use_mempool is set true,
+ * ap_init_apmsg() returns -ENOMEM without any attempt to allocate
+ * memory.
+ */
+static mempool_t *ap_msg_pool;
+static unsigned int ap_msg_pool_min_items = 8;
+module_param_named(msgpool_min_items, ap_msg_pool_min_items, uint, 0440);
+MODULE_PARM_DESC(msgpool_min_items, "AP message pool minimal items.");
+
 /*
  * AP bus rescan related things.
  */
@@ -548,14 +566,25 @@ static void ap_poll_thread_stop(void)
 
 /**
  * ap_init_apmsg() - Initialize ap_message.
- * Initialize a message before using. Otherwise this might result in
- * unexpected behaviour.
+ * Initialize struct ap_message and allocate buffer to construct
+ * the ap message.
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
@@ -567,12 +596,16 @@ EXPORT_SYMBOL(ap_init_apmsg);
 
 /**
  * ap_release_apmsg() - Release ap_message.
- * Releases all memory used internal within the ap_message struct
- * Currently this is the message and private field.
+ * Cleanup struct ap_message and release all memory held.
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
 
@@ -2461,6 +2494,14 @@ static int __init ap_module_init(void)
 	/* init ap_queue hashtable */
 	hash_init(ap_queues);
 
+	/* create ap msg buffer memory pool */
+	ap_msg_pool = mempool_create_kmalloc_pool(ap_msg_pool_min_items,
+						  AP_DEFAULT_MAX_MSG_SIZE);
+	if (IS_ERR(ap_msg_pool)) {
+		ap_msg_pool = NULL;
+		goto out;
+	}
+
 	/* set up the AP permissions (ioctls, ap and aq masks) */
 	ap_perms_init();
 
@@ -2507,6 +2548,7 @@ static int __init ap_module_init(void)
 out_bus:
 	bus_unregister(&ap_bus_type);
 out:
+	mempool_destroy(ap_msg_pool);
 	ap_debug_exit();
 	return rc;
 }
@@ -2517,6 +2559,7 @@ static void __exit ap_module_exit(void)
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

