Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674AF3955FE
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899070; cv=none; b=Hx+AYGJPy3+X0DWwI+O6+hxyZKgkPCF+FNnexZl6VyMG59fX4ru1vRzO5XwFz7nN56eZXvQ26xKuPJ3NAWs4D5iyItApWsFXdyk0QB71Fy3liJ5N+aImqMLES8GxbUCmoRE+nZS+fLwb3M/jutKQeqNdH8JdbUej3Q0i2uzXExw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899070; c=relaxed/simple;
	bh=OrmFcKHBxJbfzj9dgR7VDo1fcTiV4G9MN6IbwSsb5Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aaXLstgqGtdcdC6oW2gwXzobb+HDBeSQ0CL/xzpM4FCkN4TzdTNc7v3p1PIlOcOZyFd9205t+kbaJEHdrqvwTzqzNXuadC1/a9VZMctojTkzIZ88cVoN9vAnuCtmUvfmomtSN/j4Yrri8R25RyIIe65RmCERDasu9YDteq23Li4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oq5+NDjg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oq5+NDjg"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D2E7hC2015691
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 13:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8FTemu2aIr+LmZ+Hc
	/BwTNP6FxXwAT6fkpg/eKvfmxg=; b=oq5+NDjg+dwHEjcylHWdEDPjdSlYCckci
	cahHwSSIvEH0OTwcAzLUo6VVol7B9v1rgNlxeIgu6RbQLnY9hos856jk2eNtMtWO
	1g3AbJGawY/k56K3FlmKtE9KuUowkKr8FdDrfAfnx982ZVgXEUNlVPTPIvhYAnZc
	qRnJYJNECd+poHAUj6PkQTd6NRMmD9PbywAUEWkEplzpVK5l8xSTnysULxtTbfhO
	gWgVJUFWEA2nrdAAUoY1rswvOfdCaTGmdgpRpz/GdvgnBHiOF8GW3IknMgRtlgWo
	YyoXo0lJHtCnJK+c2n2ezfcdyBeRVnljiKQ4GzKQlsfGYhR0Y/m/Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7duged8q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 13:44:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DCOAYW2643990
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 13:44:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjt3t0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 13:44:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DDiNB516843046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 13:44:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74E902004F;
	Tue, 13 Oct 2026 13:44:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5586F2004E;
	Tue, 13 Oct 2026 13:44:23 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.224.94.37])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 13:44:23 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v3 2/2] s390/ap: Cap AP maximum message size adjustable via module parameter
Date: Tue, 13 Oct 2026 15:44:22 +0200
Message-ID: <20261013134422.64155-3-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013134422.64155-1-freude@linux.ibm.com>
References: <20261013134422.64155-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6ace35bc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=yY1uK_18XjtSVT4SLfkA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: UMm7y63Pw2QQdsbU1zrJTzRvvIxdnKpg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1NCBTYWx0ZWRfX9mZdRpaGC5Wb
 AzLNTI7aK8SKpRyzFpdl1Zcj06MnUjsnoGl/OfW+feRJ7zNQD4GFfEpVb7WU9RZOlnZYkU7rdkd
 wYOP8yks0s4HvKQC/mtA7eLYdU3CMcHzNuFeb+8x9R+YXShlNRoBkKssd4JpFr3J0yaEXTd0n67
 YZTtQ1ry7wBbSFTmUMRvCeavl3GK5k2r5laSmdsaO4+qGSuOhQ1h9yqGsFtZTdeeWKI76ua2UJ9
 TcTyj3ts5LOsYkgkeUZOpqCsgTHffSF958agckrQ7XIOqtW/pC+KfQcUdAt5M+Avro3vAEzOMoJ
 s3P33UuIPdJSDLzy1E1zJczZeW3SXrpcPehmXkRaNkA5rWNYJRyCBqVMAGbBHIegctnEOXJAzaj
 h+uuvBCaXvWLKnh8Q7nCmh/wmaKTEYCq4y1fj/rE1pxHMz6li8sOG7vciO9e+0lx07+gq2izuNx
 DsDlJsaeVl2tBMMzR0w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1NCBTYWx0ZWRfX9ZK2iMIEiVCe
 9A3YXe5Hs5k0ZJPHQ3uUqMM8CYC+Uzc6ccEwt7AxaKKTWCAsuTmz1fEk79dQKRWY598LYSYdKUv
 UFbr9U4XgLLyozez+Gq8mnolOry+SZ0=
X-Proofpoint-ORIG-GUID: UMm7y63Pw2QQdsbU1zrJTzRvvIxdnKpg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130054

With AP bus now supporting the new APMLM field with PQAP/TAPQ the AP
max message size could be raised up to 960KB. As this amount of memory
is tried to get allocated on each AP request/reply it would quickly
cause some memory problems.

Introduce a reasonable default upper limit
AP_DEFAULT_MAX_MSG_SIZE_LIMIT (72KB) and expose it via a read-only
module parameter 'max_msg_size_limit'. When creating an AP card, clip
the calculated AP max message size from the hardware info fetched via
PQAP/TAPQ to this upper limit and log a debug feature warning
(AP_DBF_WARN) if the card's reported limit exceeds it.

Also define some lower limit AP_MIN_MSG_SIZE (12KB) and ensure during
module init that a user-supplied max_msg_size_limit parameter is not
lower than this minimum, adjusting it with a warning if necessary.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/ap_bus.c  | 11 +++++++++++
 drivers/s390/crypto/ap_bus.h  |  5 ++++-
 drivers/s390/crypto/ap_card.c |  6 ++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index d82df5b4e2db..639a02f41cea 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -76,6 +76,10 @@ MODULE_PARM_DESC(useirq, "Use interrupt if available, default is 1 (on).");
 atomic_t ap_max_msg_size = ATOMIC_INIT(AP_DEFAULT_MAX_MSG_SIZE);
 EXPORT_SYMBOL(ap_max_msg_size);
 
+unsigned int ap_max_msg_size_limit = AP_DEFAULT_MAX_MSG_SIZE_LIMIT;
+module_param_named(max_msg_size_limit, ap_max_msg_size_limit, uint, 0444);
+MODULE_PARM_DESC(max_msg_size_limit, "Upper limit for AP max message size.");
+
 static struct device *ap_root_device;
 
 /* Hashtable of all queue devices on the AP bus */
@@ -2631,6 +2635,13 @@ static int __init ap_module_init(void)
 		ap_domain_index = -1;
 	}
 
+	/* verify AP max msg size limit module parameter */
+	if (ap_max_msg_size_limit < AP_MIN_MSG_SIZE) {
+		pr_warn("max_msg_size_limit (%u) below minimum %u, adjusting\n",
+			ap_max_msg_size_limit, AP_MIN_MSG_SIZE);
+		ap_max_msg_size_limit = AP_MIN_MSG_SIZE;
+	}
+
 	/* Create /sys/bus/ap. */
 	rc = bus_register(&ap_bus_type);
 	if (rc)
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 34f9dcd96bc7..5dcc9c54e32e 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -25,11 +25,14 @@
 #define AP_RESET_TIMEOUT (HZ*0.7)	/* Time in ticks for reset timeouts. */
 #define AP_CONFIG_TIME 30	/* Time in seconds between AP bus rescans. */
 #define AP_POLL_TIME 1		/* Time in ticks between receive polls. */
-#define AP_DEFAULT_MAX_MSG_SIZE (12 * 1024)
+#define AP_MIN_MSG_SIZE (12 * 1024)
+#define AP_DEFAULT_MAX_MSG_SIZE AP_MIN_MSG_SIZE
+#define AP_DEFAULT_MAX_MSG_SIZE_LIMIT (72 * 1024)
 #define AP_TAPQ_ML_FIELD_CHUNK_SIZE (4096)
 
 extern int ap_domain_index;
 extern atomic_t ap_max_msg_size;
+extern unsigned int ap_max_msg_size_limit;
 
 extern DECLARE_HASHTABLE(ap_queues, 8);
 extern spinlock_t ap_queues_lock;
diff --git a/drivers/s390/crypto/ap_card.c b/drivers/s390/crypto/ap_card.c
index e9a8180f08c2..134c14fb2e03 100644
--- a/drivers/s390/crypto/ap_card.c
+++ b/drivers/s390/crypto/ap_card.c
@@ -14,6 +14,7 @@
 #include <asm/sclp.h>
 
 #include "ap_bus.h"
+#include "ap_debug.h"
 
 /*
  * AP card related attributes.
@@ -244,6 +245,11 @@ struct ap_card *ap_card_create(int id, struct ap_tapq_hwinfo hwinfo,
 	ac->maxmsgsize = hwinfo.ml > 3 ?
 		hwinfo.ml * (hwinfo.mlm + 1) * AP_TAPQ_ML_FIELD_CHUNK_SIZE :
 		AP_DEFAULT_MAX_MSG_SIZE;
+	if (ac->maxmsgsize > ap_max_msg_size_limit) {
+		AP_DBF_WARN("card 0x%02x: ml=%d mlm=%d exceeds max_msg_size_limit %u, clipping\n",
+			    id, hwinfo.ml, hwinfo.mlm, ap_max_msg_size_limit);
+		ac->maxmsgsize = ap_max_msg_size_limit;
+	}
 
 	return ac;
 }
-- 
2.43.0

