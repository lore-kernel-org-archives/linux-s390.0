Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7AA3009F2;
	Wed, 13 May 2026 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680907; cv=none; b=W5/v+S71ixKKALE+QY5S2XRVnKNsLJ8qqeUomZF8f6bBoZ5cExYLgs+XB7RdFK6osPvNhLSedLmz3+MEb1hsug4IYeKCUmBYlEbHQ8VjOiTzvg9njWBpTFzyjxf7VxvZ1jJ7b6jBIJTGzblFyxmq3BAAlSm0UnwxTl2h+z150ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680907; c=relaxed/simple;
	bh=Ee/RUhilf63oHklJBcEdwm61deQ1ElX5R/Hy16YrqPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UrSAeCO33s7YOvINuThs2kkTxR39/KhjqH6DWg7ESKqrPnLTNFZhJy2eLrE+jduFE5kMxQ98PVCZIbzkpuwcDN43lbFTREWvq+0246QIuSlf9SIkjTKI07DSnA42/h/lcariALBCsYRsY93Gavro3koRBp2QFSZBF4GgIvvgvlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aUTpcAmK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aUTpcAmK"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D1e3cU3185798;
	Wed, 13 May 2026 14:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NEIWHyUgV4pczwwIF
	1MFCtH7THcZVz2nt39xc5FJKGw=; b=aUTpcAmKM+vRxK/2ftYa7RS4NkqnrGXAP
	kFGuZkEGQV+9CQ27wLj5A/aO7u0NpuJJ94lwWyQUCDNZgB+ewnD/pp/DhmNcRF7W
	Wy4WJoqUmuqUcTVpmKpmc8G8Gcc2y0OapRLuudwILDlVasqoUm+GmN2IT3ZoUGy8
	xIPEc+OAeXVuVK1f14uLp5ODi3lJfWUdBfv8NI8KEpV/f3FqcQZk4kGXEyLJKymE
	/b4hnmo/mtJlQeQJ/Mkk5b4jarlVxt3pNPG5Y07H9R01ZcOfgB1+tP9yMyu/P6O2
	clgcXid4H5wvs+IKzvKZGvNnFHDwGe+QkoDIv7mbr27FaXuMDTf8w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv5g29r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 14:01:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64DDsNI0032622;
	Wed, 13 May 2026 14:01:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgr1w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 14:01:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64DE1UMq47710598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 14:01:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57C6C20040;
	Wed, 13 May 2026 14:01:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 316EC2004B;
	Wed, 13 May 2026 14:01:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 May 2026 14:01:30 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 1/4] s390/timex: Move union tod_clock type to separate header
Date: Wed, 13 May 2026 16:01:26 +0200
Message-ID: <20260513140129.4100822-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260513140129.4100822-1-hca@linux.ibm.com>
References: <20260513140129.4100822-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=cPHQdFeN c=1 sm=1 tr=0 ts=6a04843f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=xQFYLjJ_xnkpiNtZIxsA:9
X-Proofpoint-ORIG-GUID: -UBTFRFnlpVWbEvfb5LAAW5hRVPMYgTa
X-Proofpoint-GUID: -UBTFRFnlpVWbEvfb5LAAW5hRVPMYgTa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE0MCBTYWx0ZWRfX6wFuoE0WGO7a
 af6yYME/A76Me8NyOnDH+ABevWN8Kl2PlY/nQb7nmQhx03RFb4t+SL9Hdxfji6BC65iecIcHvVa
 4REDydbWMzLqSUgRqgRs6szJnXGt0h9+DTWjLzBW1qKARO+DXPNM1aEsYaIO+r4pcwtMY3zZnii
 1SgYSCKfFKIPkK3xujkc9Xoaz/n04tAP17M+bEHL/S87n0odNwcFRFi9CSWkJIhJwxrMJtUfEaR
 utahQKjjiL6VTidLozhESCP5WJn1l4B0zxjWWtVfWEWJKbitWSn/GgVj7DId8D/qH6AtnFfCcEj
 hkk0CwmCxZRAZ9+2ayEl44SV+MKVhH9cvbHR8fZiFfJbzhGJmXIv6u+/4SGigqwiYxn4ELl4Q5z
 TSp7uWhZj9sNVRaQTGawtDEeb7y9cMV+an975c/3hcvV64RR3cSa8++b8laZsP5IGGxPh0Os2FZ
 dEAu0pIw6n83pxGL+Bg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130140

Move union tod_clock type to separate header file. This is preparation
for upcoming changes in order to avoid header dependency problems.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/timex.h     | 20 +-------------------
 arch/s390/include/asm/tod_types.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 19 deletions(-)
 create mode 100644 arch/s390/include/asm/tod_types.h

diff --git a/arch/s390/include/asm/timex.h b/arch/s390/include/asm/timex.h
index 49447b40f038..ac3ab6c29912 100644
--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -12,6 +12,7 @@
 
 #include <linux/preempt.h>
 #include <linux/time64.h>
+#include <asm/tod_types.h>
 #include <asm/lowcore.h>
 #include <asm/machine.h>
 #include <asm/asm.h>
@@ -21,25 +22,6 @@
 
 extern u64 clock_comparator_max;
 
-union tod_clock {
-	__uint128_t val;
-	struct {
-		__uint128_t ei	:  8; /* epoch index */
-		__uint128_t tod : 64; /* bits 0-63 of tod clock */
-		__uint128_t	: 40;
-		__uint128_t pf	: 16; /* programmable field */
-	};
-	struct {
-		__uint128_t eitod : 72; /* epoch index + bits 0-63 tod clock */
-		__uint128_t	  : 56;
-	};
-	struct {
-		__uint128_t us	: 60; /* micro-seconds */
-		__uint128_t sus	: 12; /* sub-microseconds */
-		__uint128_t	: 56;
-	};
-} __packed;
-
 /* Inline functions for clock register access. */
 static inline int set_tod_clock(__u64 time)
 {
diff --git a/arch/s390/include/asm/tod_types.h b/arch/s390/include/asm/tod_types.h
new file mode 100644
index 000000000000..976fa0a1e895
--- /dev/null
+++ b/arch/s390/include/asm/tod_types.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_S390_TOD_TYPES_H
+#define _ASM_S390_TOD_TYPES_H
+
+#include <linux/types.h>
+
+#ifndef __ASSEMBLER__
+
+union tod_clock {
+	__uint128_t val;
+	struct {
+		__uint128_t ei	:  8; /* epoch index */
+		__uint128_t tod : 64; /* bits 0-63 of tod clock */
+		__uint128_t	: 40;
+		__uint128_t pf	: 16; /* programmable field */
+	};
+	struct {
+		__uint128_t eitod : 72; /* epoch index + bits 0-63 tod clock */
+		__uint128_t	  : 56;
+	};
+	struct {
+		__uint128_t us	: 60; /* micro-seconds */
+		__uint128_t sus	: 12; /* sub-microseconds */
+		__uint128_t	: 56;
+	};
+} __packed;
+
+#endif
+#endif
-- 
2.51.0

