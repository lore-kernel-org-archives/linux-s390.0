Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAEE3AAF6D
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 08:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560351; cv=none; b=BeIQxe9T15nbfI3yXiWpe615Ojom/NP+PzMX8xOaigTuEqoo27JrDoI8a6JMCsB3rG9rlhLURw1J1BwGKqncm8rEpc/1iiiYCOll0Hgulu1epVLZD3W+LH11Qfx4Wdxwjja6K9fNR6R4X/AT14bVJLfNfoGPg2pPR+xm/rFoX88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560351; c=relaxed/simple;
	bh=dV5ARJM8JyZuo/15lOGCCWPi436fWwOxX4lNGDSjS5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJsqiZmnziRw6Z1KgLYUfSxjavQ95gMOwh/hy8e7E7PozMQsbkED512IwAB6Cw9Mgbyn4PEiJEZ2kc8rzUpLSGosRcvKb7gVNgwTipTvdI0fdPDLmC6rozjPonV9xwwnnjvAE6rNLa7Apionc3zwsPsLOby5J4M8bRIKy8/t2ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kx/AvqpF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kx/AvqpF"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5VmDH856999;
	Mon, 24 Aug 2026 08:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=B/Sybm
	Q/FJyrxZ7FxX4k3LSF1+CDBp2yE9MObY673j0=; b=Kx/AvqpF7gOlbY2AlB8OHc
	9KmsAuVrjCbsAf1RjyYEQH54PJfWgIVukRUZHYEVDwi6Cz9afrUhmU7K/VeApngt
	+nPPP8eZmXaE6I9ElLxi47uUITA5xfkEqmAsAslh/kYRj2yb+ZXAS57xns/4eBea
	f15fVGntJNbemFbvoqvNnQAtUL2ZGljbzZwxx3E/FWEPrfem4GLb29HtBm0vCkIU
	/4KX+iD2bN6q0Lo1yFkzj8h4h7KrGwrJDxlEg4SNOBPjXVH+Hj8KKOAt7uhAr/nj
	wegHTvmtDbRh2yH7qD5GERKn2qba7Akj+ZoU+62HKYFcVXJaoSuRs3m8MldVhvJQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hgax5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 08:32:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O8QIpB028810;
	Mon, 24 Aug 2026 08:32:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsxvjjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 08:32:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67O8W7Av45744442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 08:32:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1212520043;
	Mon, 24 Aug 2026 08:32:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6D102004D;
	Mon, 24 Aug 2026 08:32:06 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.131.174])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 08:32:06 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v16 07/20] crypto: Add aes-helpers file to support some AES modes
Date: Mon, 24 Aug 2026 10:31:51 +0200
Message-ID: <20260824083204.40877-8-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824083204.40877-1-freude@linux.ibm.com>
References: <20260824083204.40877-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3NCBTYWx0ZWRfX1f0MEZ2+uspF
 A4vUNfTpZQxZUhZh9P1w5ffS32PjkOhM/SvR5WLZhHV0vJAatvMamkH7eVIOAGWDtbBla7TIWn7
 lx1CGQAoM3QCA7iTJzFH9eRz/XTgv/8=
X-Proofpoint-GUID: YLdju1sL_nlucQznGIMEU0d3i95Myya6
X-Proofpoint-ORIG-GUID: YLdju1sL_nlucQznGIMEU0d3i95Myya6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3NCBTYWx0ZWRfX18dKy8pPoNTh
 5ha7IsrRMGyIj08GNTmdWblFoJkyiHjjVpf5xdjFCBbzmid182SAkwdyOR6564HHh7Z3SzIZDoZ
 iRYvkaDAzvh7ng43r19HtDod9IwwV7DYymTLY9sw7d1TTL5QiIVKqQtPjEvDIiQ1tgFJkyqp+6Q
 ikzcOWcxxWNKHFTjI49QrRx/QZgRDEOp3qqkk/CF3i3DBnX7l/27/wiSpF+c8oLcWG2AUceO+Ug
 +xe8vRmyG2kjwqSh2FnJ3B0rKFtsNbTPQx/kVA2pEje10NL6SNhopqZOPYaM+U1pZrpWWIIToUt
 3U67ptZYnGZUrYc37emyV+7+DtJ35op4oiM9zD+ppBGQmOkBppfgUYPjeRTawdYeSVFuzVZs/hQ
 HmCckr+YSJSFXfMLJ+cxKKOSGGpg4huP8fn9aNdvdSqIwE9gm37uKBnq5TaldlgAmNTeBFoSGoL
 yuNqHHljtnCFke1tvXg==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8c018b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=zkwM-tl61wuaHISZUgYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240074

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
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/aes-helpers.c         | 106 ++++++++++++++++++++++++++++++++++
 crypto/meson.build           |   1 +
 include/crypto/aes-helpers.h | 109 +++++++++++++++++++++++++++++++++++
 3 files changed, 216 insertions(+)
 create mode 100644 crypto/aes-helpers.c
 create mode 100644 include/crypto/aes-helpers.h

diff --git a/crypto/aes-helpers.c b/crypto/aes-helpers.c
new file mode 100644
index 0000000000..68d848683c
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
+ * This implementation has been verified on little and big endian.
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
index 6ac83857aa..534b995c9b 100644
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
index 0000000000..9a94c48d86
--- /dev/null
+++ b/include/crypto/aes-helpers.h
@@ -0,0 +1,109 @@
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
+ * @src1: first source buffer of AES_BLOCK_SIZE bytes
+ * @src2: second source buffer of AES_BLOCK_SIZE bytes
+ * @dst: destination buffer of AES_BLOCK_SIZE bytes
+ *
+ * Bitwise XOR operation between two AES blocks.
+ */
+void AES_xor(const unsigned char *src1, const unsigned char *src2,
+             unsigned char *dst);
+
+/**
+ * AES_cbc_encrypt:
+ * @in: input plaintext block of AES_BLOCK_SIZE bytes
+ * @out: output ciphertext block of AES_BLOCK_SIZE bytes
+ * @iv: IV, updated after processing for chaining
+ * @key: AES key
+ *
+ * Single block AES encrypt in CBC (Cipher Block Chaining) mode.
+ * The input block is XORed with the IV, then encrypted with AES.
+ * IV is updated at the end and is prepared for the next invocation.
+ */
+void AES_cbc_encrypt(const unsigned char *in, unsigned char *out,
+                     unsigned char *iv, const AES_KEY *key);
+
+/**
+ * AES_cbc_decrypt:
+ * @in: input ciphertext block of AES_BLOCK_SIZE bytes
+ * @out: output plaintext block of AES_BLOCK_SIZE bytes
+ * @iv: initialization vector, updated to input block for chaining
+ * @key: AES key
+ *
+ * Single block AES decrypt in CBC (Cipher Block Chaining) mode.
+ * The input block is decrypted, then XORed with the IV.
+ * IV is updated at the end and is prepared for the next invocation.
+ */
+void AES_cbc_decrypt(const unsigned char *in, unsigned char *out,
+                     unsigned char *iv, const AES_KEY *key);
+
+/**
+ * AES_ctr_encrypt:
+ * @in: input data block of AES_BLOCK_SIZE bytes
+ * @out: output data block of AES_BLOCK_SIZE bytes
+ * @ctr: counter value of AES_BLOCK_SIZE bytes
+ * @key: AES key
+ *
+ * Single block AES encrypt/decrypt in CTR (Counter) mode.
+ * The counter block is encrypted, then XORed with the
+ * input data block.
+ * In CTR mode encrypt and decrypt are identical operations.
+ * Note that the caller is responsible for incrementing the
+ * counter block.
+ */
+void  AES_ctr_encrypt(const unsigned char *in, unsigned char *out,
+                      const unsigned char *ctr, const AES_KEY *key);
+
+/**
+ * AES_xts_prep_next_tweak:
+ * @tweak: pointer to tweak value to be updated (16 bytes buffer
+ *         containing a 128 bit little endian integer)
+ *
+ * Tweak calculation for AES XTS.
+ * Prepares the next tweak value for AES-XTS mode by multiplying
+ * the current tweak by α (x) in GF(2^128) according to IEEE 1619-2007.
+ */
+void AES_xts_prep_next_tweak(unsigned char *tweak);
+
+/**
+ * AES_xts_encrypt:
+ * @in: input plaintext block of AES_BLOCK_SIZE bytes
+ * @out: output ciphertext block of AES_BLOCK_SIZE bytes
+ * @tweak: tweak value (16 bytes)
+ * @key: AES key
+ *
+ * Single block AES encrypt in XTS mode.
+ * The input is XORed with the tweak, encrypted, then XORed with
+ * the tweak again to produce the output.
+ * Note that the caller is responsible for managing the tweak value.
+ * Use AES_xts_prep_next_tweak() to advance the tweak for the next block.
+ */
+void AES_xts_encrypt(const unsigned char *in, unsigned char *out,
+                     const unsigned char *tweak, const AES_KEY *key);
+
+/**
+ * AES_xts_decrypt:
+ * @in: input ciphertext block of AES_BLOCK_SIZE bytes
+ * @out: output plaintext block of AES_BLOCK_SIZE bytes
+ * @tweak: tweak value (16 bytes)
+ * @key: AES key
+ *
+ * Single block AES decrypt in XTS mode.
+ * The input is XORed with the tweak, decrypted, then XORed with
+ * the tweak again to produce the output.
+ * Note that the caller is responsible for managing the tweak value.
+ * Use AES_xts_prep_next_tweak() to advance the tweak for the next block.
+ */
+void AES_xts_decrypt(const unsigned char *in, unsigned char *out,
+                     const unsigned char *tweak, const AES_KEY *key);
+
+#endif
-- 
2.43.0

