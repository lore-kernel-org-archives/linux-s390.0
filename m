Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760FB430CDC
	for <linux-s390@vger.kernel.org>; Tue,  7 Jul 2026 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441114; cv=none; b=OvpGoeiLzUE40tbHcDWy7QSRIh/lliTDIWdm+ZdLuGEdOimvzLUnA4nV/eNTivzcbIwZ1+F5j23zr9qUZEDWUpYYZDXI3v+OgW3GCr+UmHxeRfDaBKVlL62cDWCJ4GbyPRpR8leDEn1red9NrjXc0rJcK7I2N2Ro8GcTXy7ywtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441114; c=relaxed/simple;
	bh=s0xdHd4ki17eoRc9VtvsRaO8o2ezRLrLc4+BiSOVjCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlpawSW4/y0rQ5RCsze7GtkjMaIfPUWbrDB63njlc5Zn7abFp0txbg6rAcGykh3HnRBqmM0K1agnSEnGS+Ww57jAWMz06MXz2QUsErylEarx52pf1FxPZc2TGLsHyyJ9ipeEANsbqaCxRqwPpK53RT84of2q1eY+Lkvkexv/ggM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tWsCvz3k; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tWsCvz3k"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667Fmqxl3446435;
	Tue, 7 Jul 2026 16:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cDnWlrLgXK/jDS57J
	oAfCI5ey18rBuiB7cHO8+wrbG8=; b=tWsCvz3k8Zq8KIgQUZeWQ6Q3NM82ix1AE
	QPMKRLbjUNz51cVHOJZ9ueX6hBoRlQTwj32iWtDMI9Ne/wKvtWfySw0wgBjdAEwG
	7R7z3kttcu22KunmTrf4CVfMD7OtLVG6J//jRkUG+DK2K9SC+w0UvZr4EPL2zge6
	kjLeNqKPytZ10E7JSdw1dIqXIubN5+80vpHiuIki4ZL+ZVjiY0/EhzMCwMbxKGvt
	t7S7gVobMjkxjtrjgr6mRgGz0LAw1B3fLD1igkSZxZ2py59rH16d02qxqJHzxqfZ
	fvEJAJtL7eastPBJyvb79JPPnq3RDNWD7t5cq4t5Kdi+mRxYlgieQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdrpyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 16:18:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667G4cRV019154;
	Tue, 7 Jul 2026 16:18:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgq3tum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 16:18:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 667GIG4r61735396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 16:18:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2E052004D;
	Tue,  7 Jul 2026 16:18:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF1FC20043;
	Tue,  7 Jul 2026 16:18:15 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.140.5])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 16:18:15 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v11 10/21] target/s390x: Base support for cpacf protected keys
Date: Tue,  7 Jul 2026 18:17:57 +0200
Message-ID: <20260707161815.40919-11-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707161815.40919-1-freude@linux.ibm.com>
References: <20260707161815.40919-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4d26cc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=pDJEeJrE-AQHYYEhGn0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE2MCBTYWx0ZWRfX7BjiG0H8MqS8
 DmsGlomTfWXsFxwIydJqgr+5LiFH31dLWgqvlep2sYcbP0VHguIXG/RmwSp0EMkZSUHS3mO1TII
 8RHk0KtZReOSmLgrneTAYscSZTuHyW13mtgF3ssb/X2aDi/ti8zCURfHCcHYnN2AvvFGnAnfbvf
 Kc+4ksfRhAfF4DA6Ah9qAySZdzBiByT6v4KbEYwB/IrjbEO3i+wMWrxxhcZw86kS+IyMy4qlp2e
 nsZI+WsLJss3GAtAe+CZO03sfOxRbX+CaRaI6a18CxvwOSmJPe2M4fOp4NFVd3WHqp59M+F2krq
 wtjB8YmNrHdWTb0aQ3QgeR4hPJiBn/QqtHfoZiL5GrJXS22DC+0ubWIX55nG42MoyHduapyUjSo
 lYKlgLl+Jqe3/f7I2IA247hKhnsPYHbPapbgt55wxSunKVtwr7of0zJ261zuL4mhnu+T7wbhpGB
 RPP4aDhX1dd4irppbZw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE2MCBTYWx0ZWRfX9oYAdjsqaZXa
 Uic/5fYshnexZJqbnDmDsuU/AzQxoc/kg0bNhvs3ZTqhHsRqmR2WL8EvNy1l9mXjvt8ocuykbVE
 ngDMypVT2X7sljLWpW9F5o6a+C7nZn0=
X-Proofpoint-GUID: AW-1tM3k-oRPySy3NP0huiQtbAdztibY
X-Proofpoint-ORIG-GUID: AW-1tM3k-oRPySy3NP0huiQtbAdztibY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070160

Add base support for cpacf protected key handling.

The qemu version provided here is only a fake intended to make
protected key available for developing and testing purpose:
* The protected key is 'derived' from the clear key by xoring
  the fixed pattern 0xAAAA... onto the key value.
* The AES Wrapping Key Verification Pattern is a fixed
  value of 32 bytes 0xFACEFACE...

Add preprocessor defines for the xor pattern and wkvp used to
construct ('encrypt') a protected key from a clear key value with
this implementation. Also add some static functions to 'encrypt'
from clear key to protected key and 'decrypt' back to cpacf_aes.c.

The preprocessor defines shall be used later in testcases to
construct and decode protected keys.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/tcg/cpacf.h     | 25 +++++++++++++++++++++++
 target/s390x/tcg/cpacf_aes.c | 39 ++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 61ce71476b..b5cc1f202e 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -254,4 +254,29 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                   uint32_t type, uint8_t fc, uint8_t mod);
 
+/*
+ * Support for protected key cpacf functions. Note that this is
+ * a fake implementation intended for debugging and development.
+ * Do not use for production load !
+ */
+
+/*
+ * Hard coded pattern xored with the AES clear key
+ * to 'produce' the protected key.
+ */
+#define PROTKEY_XOR_PATTERN { \
+    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, \
+    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, \
+    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, \
+    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA }
+
+/*
+ * Hard coded wkvp ("Wrapping Key Verification Pattern")
+ */
+#define PROTKEY_WKVP { \
+    0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E, \
+    0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E, \
+    0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E, \
+    0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E }
+
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 3512c2712a..2deee597c7 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -460,3 +460,42 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return !len ? 0 : 3;
 }
+
+/*
+ * Support for protected key cpacf functions. Note that this is
+ * a fake implementation intended for debugging and development.
+ * Do not use for production load !
+ */
+
+/*
+ * Hard coded pattern xored with the AES clear key
+ * to 'produce' the protected key.
+ */
+static const uint8_t protkey_xor_pattern[32] = PROTKEY_XOR_PATTERN;
+
+/*
+ * Hard coded wkvp ("Wrapping Key Verification Pattern")
+ */
+static const uint8_t protkey_wkvp[32] = PROTKEY_WKVP;
+
+/*
+ * 'encrypt' the clear key value into a protected key
+ * by xor-ing the protkey_xor_pattern onto it.
+ */
+static void encrypt_clrkey(uint8_t *key, int keysize)
+{
+    for (int i = 0; i < keysize; i++) {
+        key[i] ^= protkey_xor_pattern[i];
+    }
+}
+
+/*
+ * 'decrypt' the protected key by reverting the xor
+ * of the protkey_xor_pattern onto the clear key value.
+ */
+static void decrypt_protkey(uint8_t *key, int keysize)
+{
+    for (int i = 0; i < keysize; i++) {
+        key[i] ^= protkey_xor_pattern[i];
+    }
+}
-- 
2.43.0

