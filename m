Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615C5201269
	for <linux-s390@vger.kernel.org>; Sun, 23 Feb 2025 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740304510; cv=none; b=UmksBXdNlsHKr0COFbgLZTwYVIugZKVgZeqOKkhDcoL3lk+zBctsFd3rZAvbXNChj0HzrT/mbcobn2+bxGHhqZU+JyO7KAXtOeoXCfO+tMGgA5C7tY7i6Gz2l5uceDRBDxNYDHj+603zfjvUT4bHtFYHYo/QVTea6zJCSfpT4U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740304510; c=relaxed/simple;
	bh=xPpb9Eaw3eqhvqYCVQPKo9YswBiU23gnk2F0y2dBzG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WB0h1NWbfun/Tg/cUNOPkwf+c0coeLmilK/hX5nDEXDd+0yO7PjkyBK+9rdZ6Qa/N4uJv3ozwbEPIJm0xSEv9DBjGmvD4E3vVsmB3r6k70SM2NUvy2YQdcmGvSIa2gj7eHxnqG1ovajaJ2G6AUDGmmKANAy8ZmicU46jAVnwr/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DD8mwZo+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DD8mwZo+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51N8qiNX017991;
	Sun, 23 Feb 2025 09:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NpYquDehzRiUPnzjc
	RHuwOan59mMOLhoBUz1c4Ev964=; b=DD8mwZo+Su4bV4XKvBklh5MNm9f2yqVJb
	AgY/cPaPLj1HZLfMBPtheBIAWyT2jWmYdn5s2o7WvEXazokZDJcl7ILaZn/Bc10O
	hY/IiPB6PP071lQm1+NWn0h3mVhQqV92vs64gsGoCaHZ1Fl8hWIWCp8Oj3ceEKhz
	mC7PP3kg5rdhmkothCPYctbFMLYFdmnYD9gxLKRZh8pWhn1ABJxzx5FdoqaJW2H/
	VXsWeVxTkfTutOSbZE/YxTiVkldekfcLHiGV3qAP/E60xGgcTA9smW//iJXu1FnY
	+6d2t2PLYZaQoMyunq8+OKhYtqO+MCOEpCHepx6bqiDhQhiBZ9MYw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ysr9sapm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51N8mV6o012470;
	Sun, 23 Feb 2025 09:55:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yrwsa0hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 09:55:04 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51N9t1rj46334406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 09:55:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 644C520040;
	Sun, 23 Feb 2025 09:55:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23CAD2004D;
	Sun, 23 Feb 2025 09:55:01 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.19.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 23 Feb 2025 09:55:01 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v1 03/20] s390/ap: Introduce ap message buffer pool
Date: Sun, 23 Feb 2025 10:54:42 +0100
Message-ID: <20250223095459.43058-4-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250223095459.43058-1-freude@linux.ibm.com>
References: <20250223095459.43058-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TTDOWnzqCYlq68V-3l8imTUqMtoFyUvl
X-Proofpoint-GUID: TTDOWnzqCYlq68V-3l8imTUqMtoFyUvl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxlogscore=835 clxscore=1015 mlxscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502230073

There is a need for a do-not-allocate-memory path through the
ap bus layer. When ap_init_apmsg() with the AP_MSG_FLAG_MEMPOOL
xflag is called, instead of kmalloc() the ap message buffer is
allocated from the ap_msg_pool. This pool only holds a limited
amount of buffers: AP_MSG_POOL_MIN_ITEMS with the item size
AP_DEFAULT_MAX_MSG_SIZE and exactly one of these items (if available)
is returned if ap_init_apmsg() with the MEMPOOL flag is called.
When this pool is exhausted and the MEMPOOL flag is effective,
ap_init_apmsg() returns -ENOMEM without any attempt to allocate
memory.

The zcrypt layer may use this flag to indicate to the ap bus
that the processing path for this message should not allocate
memory. This is to prevent deadlocks with crypto and io for
example with encrypted swap volumes.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/ap_bus.c     | 59 +++++++++++++++++++++++++++-----
 drivers/s390/crypto/ap_bus.h     |  3 +-
 drivers/s390/crypto/zcrypt_api.c | 10 +++---
 3 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 4940eaf538e9..b585b5d11074 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -40,6 +40,7 @@
 #include <linux/module.h>
 #include <asm/uv.h>
 #include <asm/chsc.h>
+#include <linux/mempool.h>
 
 #include "ap_bus.h"
 #include "ap_debug.h"
@@ -101,6 +102,21 @@ static struct ap_config_info *const ap_qci_info_old = &qci[1];
  */
 debug_info_t *ap_dbf_info;
 
+/*
+ * There is a need for a do-not-allocate-memory path through the
+ * ap bus layer. When ap_init_apmsg() with the AP_MSG_FLAG_MEMPOOL
+ * xflag is called, instead of kmalloc() the ap message buffer is
+ * allocated from the ap_msg_pool. This pool only holds a limited
+ * amount of buffers: AP_MSG_POOL_MIN_ITEMS with the item size
+ * AP_DEFAULT_MAX_MSG_SIZE and exactly one of these items (if available)
+ * is returned if ap_init_apmsg() with the MEMPOOL flag is called.
+ * When this pool is exhausted and the MEMPOOL flag is effective,
+ * ap_init_apmsg() returns -ENOMEM without any attempt to allocate
+ * memory.
+ */
+#define AP_MSG_POOL_MIN_ITEMS 4
+static mempool_t *ap_msg_pool;
+
 /*
  * AP bus rescan related things.
  */
@@ -546,16 +562,27 @@ static void ap_poll_thread_stop(void)
 #define is_card_dev(x) ((x)->parent == ap_root_device)
 #define is_queue_dev(x) ((x)->parent != ap_root_device)
 
-/**
+/*
  * ap_init_apmsg() - Initialize ap_message.
- * Initialize a message before using. Otherwise this might result in
- * unexpected behaviour.
+ * Initialize struct ap_message and allocate buffer to construct
+ * the ap message.
  */
-int ap_init_apmsg(struct ap_message *ap_msg)
+int ap_init_apmsg(struct ap_message *ap_msg, u32 xflags)
 {
-	unsigned int maxmsgsize = atomic_read(&ap_max_msg_size);
+	unsigned int maxmsgsize;
 
 	memset(ap_msg, 0, sizeof(*ap_msg));
+
+	if (xflags & AP_MSG_FLAG_MEMPOOL) {
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
@@ -565,14 +592,18 @@ int ap_init_apmsg(struct ap_message *ap_msg)
 }
 EXPORT_SYMBOL(ap_init_apmsg);
 
-/**
+/*
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
 
@@ -2461,6 +2492,14 @@ static int __init ap_module_init(void)
 	/* init ap_queue hashtable */
 	hash_init(ap_queues);
 
+	/* create ap msg buffer memory pool */
+	ap_msg_pool = mempool_create_kmalloc_pool(AP_MSG_POOL_MIN_ITEMS,
+						  AP_DEFAULT_MAX_MSG_SIZE);
+	if (IS_ERR(ap_msg_pool)) {
+		ap_msg_pool = NULL;
+		goto out;
+	}
+
 	/* set up the AP permissions (ioctls, ap and aq masks) */
 	ap_perms_init();
 
@@ -2507,6 +2546,7 @@ static int __init ap_module_init(void)
 out_bus:
 	bus_unregister(&ap_bus_type);
 out:
+	mempool_destroy(ap_msg_pool);
 	ap_debug_exit();
 	return rc;
 }
@@ -2517,6 +2557,7 @@ static void __exit ap_module_exit(void)
 	ap_irq_exit();
 	root_device_unregister(ap_root_device);
 	bus_unregister(&ap_bus_type);
+	mempool_destroy(ap_msg_pool);
 	ap_debug_exit();
 }
 
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 3956a5e945bd..8b20506d6a60 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -240,8 +240,9 @@ struct ap_message {
 #define AP_MSG_FLAG_SPECIAL  0x0001	/* flag msg as 'special' with NQAP */
 #define AP_MSG_FLAG_USAGE    0x0002	/* CCA, EP11: usage (no admin) msg */
 #define AP_MSG_FLAG_ADMIN    0x0004	/* CCA, EP11: admin (=control) msg */
+#define AP_MSG_FLAG_MEMPOOL  0x0008	/* ap msg buffer via mempool */
 
-int ap_init_apmsg(struct ap_message *ap_msg);
+int ap_init_apmsg(struct ap_message *ap_msg, u32 xflags);
 void ap_release_apmsg(struct ap_message *ap_msg);
 
 enum ap_sm_wait ap_sm_event(struct ap_queue *aq, enum ap_sm_event event);
diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 78df25da0b95..ce5f7cb974b9 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -648,7 +648,7 @@ static long zcrypt_rsa_modexpo(struct ap_perms *perms,
 
 	trace_s390_zcrypt_req(mex, TP_ICARSAMODEXPO);
 
-	rc = ap_init_apmsg(&ap_msg);
+	rc = ap_init_apmsg(&ap_msg, 0);
 	if (rc)
 		goto out;
 
@@ -753,7 +753,7 @@ static long zcrypt_rsa_crt(struct ap_perms *perms,
 
 	trace_s390_zcrypt_req(crt, TP_ICARSACRT);
 
-	rc = ap_init_apmsg(&ap_msg);
+	rc = ap_init_apmsg(&ap_msg, 0);
 	if (rc)
 		goto out;
 
@@ -861,7 +861,7 @@ static long _zcrypt_send_cprb(bool userspace, struct ap_perms *perms,
 
 	xcrb->status = 0;
 
-	rc = ap_init_apmsg(&ap_msg);
+	rc = ap_init_apmsg(&ap_msg, 0);
 	if (rc)
 		goto out;
 
@@ -1045,7 +1045,7 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 
 	trace_s390_zcrypt_req(xcrb, TP_ZSENDEP11CPRB);
 
-	rc = ap_init_apmsg(&ap_msg);
+	rc = ap_init_apmsg(&ap_msg, 0);
 	if (rc)
 		goto out;
 
@@ -1219,7 +1219,7 @@ static long zcrypt_rng(char *buffer)
 
 	trace_s390_zcrypt_req(buffer, TP_HWRNGCPRB);
 
-	rc = ap_init_apmsg(&ap_msg);
+	rc = ap_init_apmsg(&ap_msg, 0);
 	if (rc)
 		goto out;
 	rc = prep_rng_ap_msg(&ap_msg, &func_code, &domain);
-- 
2.43.0

