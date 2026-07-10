Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996DB3DB337
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783697367; cv=none; b=X6S7fwfnUnTtRr1z2aN76B6HLRTwk5m9igX5UX8hOKbmhQvvGma6tvharPTyyHCq8ESPkglGWETJ9Xx5yMyNytE25tpRCHTeVDnOhTGHZXRa8LkOOxbYMPqz+2MOyjAIPGxl4ob2e/9kRxikryL/JVVMPeGDz0gS5gA2St3psfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783697367; c=relaxed/simple;
	bh=jyabYzo5hnZ4lFE3HU9Uk8fgTafeZlIhFgHd+Mr1nSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJvVQgVM+azJEtq7oo4dSNH7e60KuCxdEb2ln+zQLEO9X4u0B6jBbd//KBATGqnCZ/XyHpkNuX6R2KUqseaQMp6+nmrOs+OKeGEwM+fGveG2WshDtBg/saDLODz3YGleQSsPUBrhJK/TY7pR0sQZBSmhli+HOeAwYtxOa7ZrS/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qTED2d+u; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qTED2d+u"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AEmj8a765843;
	Fri, 10 Jul 2026 15:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cu6HPn
	EOKo40lGZU96y22CBYEdDjsoCox7hngywxAvc=; b=qTED2d+uP9EI+8tW0RSckn
	l0uM/F9MRH9ENh9nKd7WzZM2aiWbaKha+CNjQaRz2amlR+QZtT1nMJa6PXQ0Q4W6
	MPLL+xWS1cwHGusRh1uooY9iMnufYnIiIHlwG360vj5WSc+J0qmiNJpeLGHpRQMB
	8ydfgtVOg6xDb8jdOQ46jnYGdA6i9mkmfoP2zpI2JtOrOsJJf0Ay6k95dKbpVL+S
	mfK/b2tF3e33l8+yGQ80VID1m88wnox/Na+x1/9Xrixoc5/p0ALTx3likKuQqN0B
	+c85zTKbRKIogCKUBVWrnoUrtiAEChxx0iT3NnaF9tX2oqdB1rxADfCkJu9bsj6Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rke7kmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 15:29:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66AFJeI8011436;
	Fri, 10 Jul 2026 15:29:12 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqgjd1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 15:29:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66AFT8xl54264188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 15:29:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A52D20040;
	Fri, 10 Jul 2026 15:29:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19C4A2004B;
	Fri, 10 Jul 2026 15:29:08 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.196.135])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 15:29:08 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v12 04/17] crypto: Add aes-helpers file to support some AES modes
Date: Fri, 10 Jul 2026 17:28:50 +0200
Message-ID: <20260710152906.80207-5-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710152906.80207-1-freude@linux.ibm.com>
References: <20260710152906.80207-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a510fc8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=zkwM-tl61wuaHISZUgYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE1MyBTYWx0ZWRfX7sYVPE9VMcXO
 ciyE7Ehes3cBCssoQpBAyS+lGpTuF/o//jMW2ybiMTRQ1H5TOO1g6LU3W1s57JPDpYs13/VWuNZ
 QOOmqs6AUpC2ajw866JxrGydCvsZ8QDBq07q06LzNLq3KOzeVmWwX6qkqix8D13FA9caUcVboYA
 znBNAtQp/BL5E2Xv+MrMqA6BCAFiTGAzIy2YMvlsr76xTyuvAqsBtbU7dpn+Q+BnvuAg0XaA57r
 V5iRh0/cuJvV0l3GM0YKJRO1TihxGg9LwVCnLZ+bqJSvVGe+r3F65ZbQiMUAHgJsA0akhAmAgFX
 ILp491e+EVXtPTcmYb7+F/AByiy/64O+0GlMPlkBn5vC8owSJV7zM3n4O1aWLo6RswjLaAwHouK
 ODgLoaaIcXiS3w61Eq3SgTFm83NBr303ya4/s3UqXkesAS29gfSg/WmKW62Bhy+tfnTtCNDD5h8
 EJE0s9q8f5KDrSPedxw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE1MyBTYWx0ZWRfX2lFPQzD0Akch
 RDNrJHpDz0DYjtXSmfczvqKNI3x6eDRl7Uw58C6ssy5luiVX9V9x2+ApJZhP5K01+DZo5QeBeD9
 /zJ2mbsPetcN3ZLYYsiIIMhW10zmgro=
X-Proofpoint-GUID: _08aBMQTkXnsHcUqkRs2eUyDkywd1FlM
X-Proofpoint-ORIG-GUID: _08aBMQTkXnsHcUqkRs2eUyDkywd1FlM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100153

Add a new file crypto/aes-helpers.c with simple functions
to support some AES modes:
- AES cbc: AES_cbc_encrypt() AES_cbc_decrypt()
- AES ctr: AES_ctr_encrypt()
- AES xts: AES_xts_encrypt() AES_xts_decrypt()
and some AES related helpers:
- AES_xor()
- AES_xts_prep_next_tweak()
Add header file include/crypto/aes-helpers.h for these functions

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
---
 crypto/aes-helpers.c         | 106 ++++++++++++++++++++++++++++++++
 crypto/meson.build           |   1 +
 include/crypto/aes-helpers.h | 116 +++++++++++++++++++++++++++++++++++
 3 files changed, 223 insertions(+)
 create mode 100644 crypto/aes-helpers.c
 create mode 100644 include/crypto/aes-helpers.h

diff --git a/crypto/aes-helpers.c b/crypto/aes-helpers.c
new file mode 100644
index 0000000000..ff4aa0a385
--- /dev/null
+++ b/crypto/aes-helpers.c
@@ -0,0 +1,106 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * AES helper functions and mode implementations
+ *
+ * Authors:
+ *   Harald Freudenberger <freude@linux.ibm.com>
+ */
+
+#include "qemu/osdep.h"
+#include "crypto/aes.h"
+#include "crypto/aes-helpers.h"
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
+/*
+ * Tweak calculation for AES XTS.
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
diff --git a/include/crypto/aes-helpers.h b/include/crypto/aes-helpers.h
new file mode 100644
index 0000000000..c1552b0e8f
--- /dev/null
+++ b/include/crypto/aes-helpers.h
@@ -0,0 +1,116 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * AES helper functions and modes
+ */
+
+#ifndef QEMU_AES_HELPERS_H
+#define QEMU_AES_HELPERS_H
+
+/**
+ * AES_xor:
+ *
+ * Bitwise XOR operation between two AES blocks.
+ *
+ * @src1: first source buffer of AES_BLOCK_SIZE bytes
+ * @src2: second source buffer of AES_BLOCK_SIZE bytes
+ * @dst: destination buffer of AES_BLOCK_SIZE bytes
+ */
+void AES_xor(const unsigned char *src1, const unsigned char *src2,
+             unsigned char *dst);
+
+/**
+ * AES_cbc_encrypt:
+ *
+ * Single block AES encrypt in CBC (Cipher Block Chaining) mode.
+ * The input block is XORed with the IV, then encrypted with AES.
+ * IV is updated at the end and is prepared for the next invocation.
+ *
+ * @in: input plaintext block of AES_BLOCK_SIZE bytes
+ * @out: output ciphertext block of AES_BLOCK_SIZE bytes
+ * @iv: IV, updated after processing for chaining
+ * @key: AES key
+ */
+void AES_cbc_encrypt(const unsigned char *in, unsigned char *out,
+                     unsigned char *iv, const AES_KEY *key);
+
+/**
+ * AES_cbc_decrypt:
+ *
+ * Single block AES decrypt in CBC (Cipher Block Chaining) mode.
+ * The input block is decrypted, then XORed with the IV.
+ * IV is updated at the end and is prepared for the next invocation.
+ *
+ * @in: input ciphertext block of AES_BLOCK_SIZE bytes
+ * @out: output plaintext block of AES_BLOCK_SIZE bytes
+ * @iv: initialization vector, updated to input block for chaining
+ * @key: AES key
+ */
+void AES_cbc_decrypt(const unsigned char *in, unsigned char *out,
+                     unsigned char *iv, const AES_KEY *key);
+
+/**
+ * AES_ctr_encrypt:
+ *
+ * Single block AES encrypt/decrypt in CTR (Counter) mode.
+ * The counter block is encrypted, then XORed with the
+ * input data block.
+ * In CTR mode encrypt and decrypt are identical operations.
+ * Note that the caller is responsible for incrementing the
+ * counter block.
+ *
+ * @in: input data block of AES_BLOCK_SIZE bytes
+ * @out: output data block of AES_BLOCK_SIZE bytes
+ * @ctr: counter value of AES_BLOCK_SIZE bytes
+ * @key: AES key
+ */
+void  AES_ctr_encrypt(const unsigned char *in, unsigned char *out,
+                      const unsigned char *ctr, const AES_KEY *key);
+
+/**
+ * AES_xts_prep_next_tweak:
+ *
+ * Tweak calculation for AES XTS.
+ * Prepares the next tweak value for AES-XTS mode by multiplying
+ * the current tweak by α (x) in GF(2^128) according to IEEE 1619-2007.
+ *
+ * @tweak: pointer to tweak value to be updated (16 bytes buffer
+ *         containing a 128 bit little endian integer)
+ */
+void AES_xts_prep_next_tweak(unsigned char *tweak);
+
+/**
+ * AES_xts_encrypt:
+ *
+ * Single block AES encrypt in XTS mode.
+ * The input is XORed with the tweak, encrypted, then XORed with
+ * the tweak again to produce the output.
+ * Note that the caller is responsible for managing the tweak value.
+ * Use AES_xts_prep_next_tweak() to advance the tweak for the next block.
+ *
+ * @in: input plaintext block of AES_BLOCK_SIZE bytes
+ * @out: output ciphertext block of AES_BLOCK_SIZE bytes
+ * @tweak: tweak value (16 bytes)
+ * @key: AES key
+ */
+void AES_xts_encrypt(const unsigned char *in, unsigned char *out,
+                     const unsigned char *tweak, const AES_KEY *key);
+
+/**
+ * AES_xts_decrypt:
+ *
+ * Single block AES decrypt in XTS mode.
+ * The input is XORed with the tweak, decrypted, then XORed with
+ * the tweak again to produce the output.
+ * Note that the caller is responsible for managing the tweak value.
+ * Use AES_xts_prep_next_tweak() to advance the tweak for the next block.
+ *
+ * @in: input ciphertext block of AES_BLOCK_SIZE bytes
+ * @out: output plaintext block of AES_BLOCK_SIZE bytes
+ * @tweak: tweak value (16 bytes)
+ * @key: AES key
+ */
+void AES_xts_decrypt(const unsigned char *in, unsigned char *out,
+                     const unsigned char *tweak, const AES_KEY *key);
+
+#endif
-- 
2.43.0

