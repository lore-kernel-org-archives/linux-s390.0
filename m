Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9B018FC89
	for <linux-s390@vger.kernel.org>; Thu, 24 Apr 2025 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501826; cv=none; b=BP0VOPin+TA2EdfRHa/rgMudrXtTJrRo7dtOU7k6v2fHArsIUQGXKgcqhM3Wv5nZ4KciS21Fv2hAtGPf2j3J+699WcDeydfXjIpVk6jzQoW0oMvnBXvHlflMqd9lq3cBq2rYDTpJaNGQnjSlL0Qr82BT8zaScxNUjH7vUiQdGU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501826; c=relaxed/simple;
	bh=05JsdeP0YYvJGYyaiCbqNnF6NGPPhaC+IzQx1uZR5LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LuwCJ7VA2/zzbwMchwV51U8r207SliQFhDay8cLulNlcl0m6dxAFZQIZpyo5epfRZtILbj/yYLTIV7hkM0AWAAlLceZC/L3svZuLJB/6o6rL+fD8Thi4iN6JhB45HgX8A+M1FmIlFw6Iwv2ErHK3IfF+rWXRFreAIFrSAdyZc7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CmpxMgSz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CmpxMgSz"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O9EZPM014502;
	Thu, 24 Apr 2025 13:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=P2WJbd5crV7hA0Lso
	IFdtSUZWXuc/CsIQ7hkmJDc6FY=; b=CmpxMgSza/VSekre3I5c3GWG5UVMg3dsy
	Tjumm8jl/skpGIb0rljclsrvZq8zBQCs8UOwWdowfJqrTe0AZl95rWxkyWhWNWSd
	O61QnyHdMZ/f+5rHOaBlLOgwsB8QtA3kvIA4Lh2m38p0DqUOBT8Nqwrc6DKy84Rk
	cgdGBmsjOXPTTKLZ7NzmvboXo+IfJ0kKga92mIFXMAWvn4qAs/U+CQbHJ0t1QLOx
	vYuJyUBvrQ1PQnIKwjWpjDhTVQeptz7+5J/gQV1dhs2A0TwKQ9YHQEYHruY42Zh6
	noEf9CJRLO295ASOeYZpTvcCLpIx67sTVEIHnL1slIkekgBCAkMbQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4678bwbq1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:36:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53OBS1aH028443;
	Thu, 24 Apr 2025 13:36:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfvrcg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:36:25 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53ODaLuo46006532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 13:36:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AECF420040;
	Thu, 24 Apr 2025 13:36:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 434702004B;
	Thu, 24 Apr 2025 13:36:21 +0000 (GMT)
Received: from funtu2.boeblingen.de.ibm.com (unknown [9.152.224.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Apr 2025 13:36:21 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v8 03/25] s390/ap: Introduce ap message buffer pool
Date: Thu, 24 Apr 2025 15:35:57 +0200
Message-ID: <20250424133619.16495-4-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424133619.16495-1-freude@linux.ibm.com>
References: <20250424133619.16495-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA5MiBTYWx0ZWRfX5Qpqt8yQrtgV F9zvGYXvD7ZnWxvRf78LqPgb3E/lO18E7qtw10hZG85Np9LFu0DWSOfLLfCnuLPmiqTDB+oLwrB /PqyMvPvAV/h+b5gjR4i1Wp7Awdz62B17G1puYuL5mWdUAN21AEiZXsmKbP6QIRu6gJ+4hAldPQ
 TWYRRbsUK1hz3/TncOAOKp/vsPQLKg3vM3i2IHPHz9RFs4WcoevMwzm5BvJARbtMgRyKjwh9icr Ntn2ayKfwRg+Q3JVUXKuSlvyZjsAvI7K6cH75pmrQ6Lu+e5kIRVAhbyoM9GsJTU82kct0h5gsPn v5SHT348r05+IfFywOSGw33QXS7s59708n9lPDNv1mnrZod74jLmqRiCAxotCSBaOCb174tKpdr
 W5+2YPpvBHj94XcuMD5pLKfbdm4jadAWtmcPTSJzrPpUMuNtVcgE/AFvlJyZkXdLEvW5K45N
X-Proofpoint-ORIG-GUID: ab2L2Kw7sTIqfMB0lJBzgt5WPcf6kzmU
X-Authority-Analysis: v=2.4 cv=KZzSsRYD c=1 sm=1 tr=0 ts=680a3e79 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=NDFkFa-y9k07oviRi3EA:9
X-Proofpoint-GUID: ab2L2Kw7sTIqfMB0lJBzgt5WPcf6kzmU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_06,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 adultscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240092

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
index 8935b3ee3a33..1e4784e9efd1 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -41,6 +41,7 @@
 #include <linux/module.h>
 #include <asm/uv.h>
 #include <asm/chsc.h>
+#include <linux/mempool.h>
 
 #include "ap_bus.h"
 #include "ap_debug.h"
@@ -102,6 +103,27 @@ static struct ap_config_info *const ap_qci_info_old = &qci[1];
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
+MODULE_PARM_DESC(msgpool_min_items, "AP message pool minimal items");
+
 /*
  * AP bus rescan related things.
  */
@@ -550,11 +572,22 @@ static void ap_poll_thread_stop(void)
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
@@ -569,7 +602,12 @@ EXPORT_SYMBOL(ap_init_apmsg);
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
index 8c263a9b643d..139bf2b13544 100644
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

