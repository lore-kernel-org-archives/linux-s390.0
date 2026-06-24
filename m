Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC223A9626
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782288651; cv=none; b=qYgMLXpbwEDgtbMpr2l6pG4IQRygb+mRXyZRoSgPwvZJEJ45XtPWf7lRHITCJWBikL97F4RBsry6sFMh1SuA4hSzVjpdsLrMeQ8Y6+2TznwPLWdFJ45HCwDEoDqJi87aT7ST/Cn+5gTTt8AK2QdNy3oYy/kaqzrPjkm+Oj180kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782288651; c=relaxed/simple;
	bh=YV5XZF/b+jdIF8BG87nJt4GpSSQDIbRZg+LMH2fF+Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dEwoei0Bk0+sb8ZQ2HkZ8ZuajGl2mQqBouhC3LMpLEN7j2WlG9ZveplRXJ7d6ya+QpYLAHEUOvxLKw9fx+JNDv7XKo6s87uIDGqwHrF4H5UxlKObp+nvdWF68JFbWZf/tiJO/QJI0KW8K5wVmzxU+RiPoTZjeJWTJC8P7zzvKxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mhBxKIq8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mhBxKIq8"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O6IX6E023561;
	Wed, 24 Jun 2026 08:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=C5DK+U
	nxXWoRqDO0GzUFfM+DFq3wC9PBYP/qJ5dH16Q=; b=mhBxKIq8/tHeGaKg5raHsG
	Z9ofxYEuxW1zIh26+nVMV5fMRSI1OQ34hpb6ZSxiAXMdG2kwSmSz8a416xNqBkuS
	F+p1BezHncxZN+LBc7LbE67otr6p+qxj69X1fG96wYwscYXGDOYZzf3KrpYEUtyF
	yzfgAKPpuyZV0Fbl+15v2xfLqX9MxZ7WOT+WBWta3Nw3I6q8RE125CIACQmc/yJI
	wo8Tv/ztNhBu0lqNJ4yPvo/xXHQlaKAgxS3Q9KFnkt7mFkdctTEY1O+MgoeeC3dQ
	fMDY3Gt3iSvk7UOQwY18QeIgFJxiScPuMRUehZ2/7tm66dp98j5vEdHn8Y9And1g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hu6ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:10:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65O84ftU021950;
	Wed, 24 Jun 2026 08:10:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyq97a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:10:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65O8AZXm25231886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 08:10:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1253920040;
	Wed, 24 Jun 2026 08:10:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D01152004E;
	Wed, 24 Jun 2026 08:10:34 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.224.92.54])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 08:10:34 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v8 17/18] crypto: Add aes-helpers file to support some AES modes
Date: Wed, 24 Jun 2026 10:10:14 +0200
Message-ID: <20260624081029.23815-18-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624081029.23815-1-freude@linux.ibm.com>
References: <20260624081029.23815-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PeXdlE03U-fBYqrSqfNVOlzSs4yy_2sN
X-Proofpoint-GUID: PeXdlE03U-fBYqrSqfNVOlzSs4yy_2sN
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3b90ff cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=ZNJHLeKVfsBpcIed2koA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfX7a6GTiw20D+l
 uyIdXKSPwOCQyCwyIEMfvYiEwzNcGvN5DGLok22noJ6i1F+heVGHU09onMa/6sLIQQxF7xuWHn+
 q3yXxtgtSYKVucOXk5z0K+Wr6mYzdFBlyUiH2jKF8rDf6q8yJKggmp57DaMRGCqq1RsX8kEFnPr
 kt34hZTztZkvdz5Qg5pUXkpts2Pi/o+QEaR5iwOt0dbY5fDMwINpA+ZOC5sIUym+xGWAq2tPPbX
 7Fja6meGuLwD6dr9RIY51VZHYEsIXFteMQBgMO8ATBPCnGl+2ulR8lwK0rPugHy8Isq6ZzAzfk1
 rCymyNwo0mOnyaUmDxHPDST9QL+2lBfR+MJg/M6aa8uzjKUwyBpFWs+aQPo2SzgfraAbcMzZrVy
 j/HxAbpClhJGBDObzBJjA1OdkXKnPA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfXyzVG2HL89Dgb
 lQHXYUSDdlSFl0XiB7SdEJJ6oQnq/K89tFLvuIWAx89pl+w4aOipdVhdLgaPlvMW0q2jw9TXVnT
 +gdEjx16FxT6egSdOMMgvPzxiMtyZEw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240063

Add a new file crypto/aes-helpers.c with simple functions
to support some AES modes:
- AES cbc: AES_cbc_encrypt() AES_cbc_decrypt()
- AES ctr: AES_ctr_encrypt()
- AES xts: AES_xts_encrypt() AES_xts_decrypt()
and some AES related helpers:
- AES_xor()
- AES_xts_prep_next_tweak()

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
---
 crypto/aes-helpers.c | 106 +++++++++++++++++++++++++++++++++++++++++++
 crypto/meson.build   |   1 +
 include/crypto/aes.h |  14 ++++++
 3 files changed, 121 insertions(+)
 create mode 100644 crypto/aes-helpers.c

diff --git a/crypto/aes-helpers.c b/crypto/aes-helpers.c
new file mode 100644
index 0000000000..065a7afabf
--- /dev/null
+++ b/crypto/aes-helpers.c
@@ -0,0 +1,106 @@
+/*
+ * AES helper functions and mode implementations
+ *
+ *  Authors:
+ *   Harald Freudenberger <freude@linux.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include <stdint.h>
+#include <string.h>
+#include "crypto/aes.h"
+
+void AES_xor(const unsigned char *src1, const unsigned char *src2,
+             unsigned char *dst)
+{
+    int i;
+
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        dst[i] = src1[i] ^ src2[i];
+    }
+}
+
+void AES_cbc_encrypt(const unsigned char *in, unsigned char *out,
+                     unsigned char *iv, const AES_KEY *key)
+{
+    unsigned char buf[AES_BLOCK_SIZE];
+
+    /* in xor iv => buf */
+    AES_xor(in, iv, buf);
+    /* encrypt buf => out */
+    AES_encrypt(buf, out, key);
+    /* prep iv for next round */
+    memcpy(iv, out, AES_BLOCK_SIZE);
+}
+
+void AES_cbc_decrypt(const unsigned char *in, unsigned char *out,
+                     unsigned char *iv, const AES_KEY *key)
+{
+    unsigned char buf[AES_BLOCK_SIZE];
+
+    /* decrypt in => buf */
+    AES_decrypt(in, buf, key);
+    /* buf xor iv => out */
+    AES_xor(buf, iv, out);
+    /* prep iv for next round */
+    memcpy(iv, in, AES_BLOCK_SIZE);
+}
+
+void AES_ctr_encrypt(const unsigned char *in, unsigned char *out,
+                     const unsigned char *ctr, const AES_KEY *key)
+{
+    unsigned char buf[AES_BLOCK_SIZE];
+
+    /* encrypt ctr => buf */
+    AES_encrypt(ctr, buf, key);
+    /* exor input data with encrypted ctr => out */
+    AES_xor(in, buf, out);
+}
+
+/* Tweak calculation for AES XTS.
+ * Multiply tweak by α (x) in GF(2^128) per IEEE 1619-2007. The tweak
+ * is a 128-bit little-endian integer (tweak[0]=LSB, tweak[15]=MSB).
+ * This implementation has been verified on litte and big endian.
+ */
+void AES_xts_prep_next_tweak(unsigned char *tweak)
+{
+    unsigned char carry;
+    int i;
+
+    carry = tweak[AES_BLOCK_SIZE - 1] >> 7;
+
+    for (i = AES_BLOCK_SIZE - 1; i > 0; i--) {
+        tweak[i] = (unsigned char)((tweak[i] << 1) | (tweak[i - 1] >> 7));
+    }
+
+    tweak[i] = (unsigned char)(tweak[i] << 1);
+    tweak[i] ^= (unsigned char)(0x87 & (unsigned char)(-(unsigned char)carry));
+}
+
+void AES_xts_encrypt(const unsigned char *in, unsigned char *out,
+                     const unsigned char *tweak, const AES_KEY *key)
+{
+    unsigned char buf1[AES_BLOCK_SIZE], buf2[AES_BLOCK_SIZE];
+
+    /* in xor tweak => buf1 */
+    AES_xor(in, tweak, buf1);
+    /* encrypt buf1 => buf2 */
+    AES_encrypt(buf1, buf2, key);
+    /* buf2 xor tweak => out */
+    AES_xor(buf2, tweak, out);
+}
+
+void AES_xts_decrypt(const unsigned char *in, unsigned char *out,
+                     const unsigned char *tweak, const AES_KEY *key)
+{
+    unsigned char buf1[AES_BLOCK_SIZE], buf2[AES_BLOCK_SIZE];
+
+    /* in xor tweak => buf1 */
+    AES_xor(in, tweak, buf1);
+    /* encrypt buf1 => buf2 */
+    AES_decrypt(buf1, buf2, key);
+    /* buf2 xor tweak => out */
+    AES_xor(buf2, tweak, out);
+}
diff --git a/crypto/meson.build b/crypto/meson.build
index b51597a879..675f27311c 100644
--- a/crypto/meson.build
+++ b/crypto/meson.build
@@ -55,6 +55,7 @@ system_ss.add(when: gnutls, if_true: files('tls-cipher-suites.c'))
 
 util_ss.add(files(
   'aes.c',
+  'aes-helpers.c',
   'clmul.c',
   'init.c',
   'sm4.c',
diff --git a/include/crypto/aes.h b/include/crypto/aes.h
index 381f24c902..df6239cb9c 100644
--- a/include/crypto/aes.h
+++ b/include/crypto/aes.h
@@ -37,4 +37,18 @@ AES_Td0[x] = Si[x].[0e, 09, 0d, 0b];
 
 extern const uint32_t AES_Te0[256], AES_Td0[256];
 
+void AES_xor(const unsigned char *src1, const unsigned char *src2,
+             unsigned char *dst);
+void AES_cbc_encrypt(const unsigned char *in, unsigned char *out,
+                     unsigned char *iv, const AES_KEY *key);
+void AES_cbc_decrypt(const unsigned char *in, unsigned char *out,
+                     unsigned char *iv, const AES_KEY *key);
+void  AES_ctr_encrypt(const unsigned char *in, unsigned char *out,
+                      const unsigned char *ctr, const AES_KEY *key);
+void AES_xts_prep_next_tweak(unsigned char *tweak);
+void AES_xts_encrypt(const unsigned char *in, unsigned char *out,
+                     const unsigned char *tweak, const AES_KEY *key);
+void AES_xts_decrypt(const unsigned char *in, unsigned char *out,
+                     const unsigned char *tweak, const AES_KEY *key);
+
 #endif
-- 
2.43.0

