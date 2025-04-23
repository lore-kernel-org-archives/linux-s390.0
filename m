Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC4622F77F
	for <linux-s390@vger.kernel.org>; Wed, 23 Apr 2025 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745403352; cv=none; b=R9/wGG+/5hQgoGKpDnAIq9AnSeDNrJ7m4k+MwoOn6lssHqqg5eDG6i0ropoVDUZrAaCYEm8X8blvbLCxOncDCK8HASbtxb9Hh+kH9X0zPTByANCORvh0XdrSkV884nyWmX6Y3jVDkhokhYaMXroWX0A+dludSB95BsuTayhlo7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745403352; c=relaxed/simple;
	bh=DtrvJA8QKOlqTfQYf6HOfX5fGAus1MWq9TvuiYRHGuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBGJEL7/7SBVoCav3FvBlhPhMuX1OYCZIHxMSXsck5RjLEbqFXkA270ejaTQCGgHoYlZEurAB+cdpJV4EDHKR1wQd7/CN0S1kOvirpV3KlI6xNVYo8LUJAGUZ2JSsObCnwSgT3NkTgHuVhwDYBbdC0pD6jSeoQuI/w8eaATTnh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fmTkFRbI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fmTkFRbI"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6fj7I012556;
	Wed, 23 Apr 2025 10:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ci9t6190HigHl2YoV
	K8TSvROYJo41c5Nl0sQT0kxRgI=; b=fmTkFRbIropDyXfMMqe2EPf9EUVEmjUdv
	kUZ2hy5GjPgmXlLxW8N6jn2Z0/cpwmveRIIHprCW87KhYPxMFNNnYQ3xSvLBxYu0
	CbSoib7os1QKxlo8Z85eWZFDoz6K2IaKIudjuCZWebbvDaDviTOa0RGDU2dK8mL1
	gEpNnXkxmNwqy9VT7IXiDL6U0HKZ8bSybm5P9Kq2X4BI8lsHaDVNvG16+xW1LWzz
	5fcfKFze4zg1NfnepgiUa0eS0u47RoDmQkyOrbMR7OhQsUFOllW4rEBUGlx5XqJX
	+nMwRZcCAr9nx4/mXCU/voUViUQwUw4WIUrnVdlZktoA2yPk3SITA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466n30a5nq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6YFvl028443;
	Wed, 23 Apr 2025 10:15:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfvjhdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:15:41 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53NAFbga51773798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 10:15:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD7C120049;
	Wed, 23 Apr 2025 10:15:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B6522004D;
	Wed, 23 Apr 2025 10:15:37 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.87.147.99])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Apr 2025 10:15:37 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Subject: [PATCH v7 03/25] s390/ap: Introduce ap message buffer pool
Date: Wed, 23 Apr 2025 12:15:12 +0200
Message-ID: <20250423101535.143137-4-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423101535.143137-1-freude@linux.ibm.com>
References: <20250423101535.143137-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA2OSBTYWx0ZWRfX8Am8SZk7mhZa /73trDs/ynhfVbrubcFtgM9YNYdH+ehjcYDjvfg6qQLTddk/7DgmqgH6lBabDWazJnDKlDaXqFc 7TD5r5S/pf1u9NzB0wtY5YJNlNdNrGauqrLt3tSkitZTQrh4T6imUR+hyIfQzB9bQ7FXprgf61n
 ySfmEw4Y7RLG22S6COPqJznn9IsUuPh0JKkMNAAX6CKYLCMbEZffk/WjZYAxWgJlkONp6jmwUUT K//gnd5go6m8llxiep/71yn6oe5sw3uUZXVay+sXosJa+UJA6SElPAB+FguXfeuuJHWLtjmTpjW nEOTlPSh7DbyLz+xXRS14tiK/Q0o9Prwk5seQ2wzASjRPWBXrYddI9xOPdPDgckULvYgWWhU7CY
 rZaD+ixa/j9UB5H3w9dKvnsO/vvGtvLYpx/ZGnEzYycbANBISqeKUe/CbNpAupgclVOspOxy
X-Authority-Analysis: v=2.4 cv=aoiyCTZV c=1 sm=1 tr=0 ts=6808bdce cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=NDFkFa-y9k07oviRi3EA:9
X-Proofpoint-GUID: vVrKVkY81lEkY1cwn1cNCj1BJSOxiFAO
X-Proofpoint-ORIG-GUID: vVrKVkY81lEkY1cwn1cNCj1BJSOxiFAO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_07,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230069

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

