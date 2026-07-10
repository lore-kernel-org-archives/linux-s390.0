Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34C43F0A87
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783697371; cv=none; b=EVlulgcr/PKR6/CxDYP2FaSI2ruj3BYm08XW6m1DjgwjymEy70/kpbw6jfWU0g2HWivJpPoiKcLKQWw68qy8nZ/G5tRMGAztkNfwOE58BML3a5b5H7vuj6Ts6Uz5mRgVnG8Rd5gizw/O+MjEjabaKvc6c1ge4v11TLvuGLOOifc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783697371; c=relaxed/simple;
	bh=mqjz5LDkbzw9BCd/WKpdSLVn//1UVueTqfxTLziDMcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VfkxRWEQ0JkiJGMcLMQ34FAqCIDXdwuPsH42BtOgHgVzu8P+/E+srBYQDzpKkSSAw2Z8xRsJpyL0gpUY1V0r7/qJYkYJE+syK28eie8y5x9gozWiKPpSdAEsNsB0k4sJcv3ysEmhuD677YYpqgImh7NlVH/16PW0tCjxXrCBaVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qwf3SC4J; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qwf3SC4J"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AEmTdI1406446;
	Fri, 10 Jul 2026 15:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Jk5moPdrXc9aQmegh
	F2zfNWd4aiJcnkAJzlqEsomAdU=; b=qwf3SC4JvmUZ0qwhIoCk3wqg7ApkzEYMr
	QSjOhMrXzCsJTTkDyful5u3a9v3+LUsK6H/7hviiPA8kA9nD14pLlFSzrJ9nuE6K
	DG7VRqLrWvgvWBu+WPuk8jXYwfefa0il9i4DUscSLG0Adk5efYzG14Jm/FYFtTv0
	oOhlb5RiHCvdFKEGSqxwU0fKSJ8nzNSmeJSEQPN/yvVFA16Bpt8ulwaM2EaCtyl4
	Ncjb6uuAV2PiyYtIcLyzlrn3ic7KYwe2Xvjzb0kJLKW6D0P23RYx6fmHGDFaamVV
	5mhCBZmyTD73K6ojY3QGk7VzYio7v4fHgT5mugk35PdmDynzcSB6w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fafh0cprg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 15:29:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66AFJh7q015250;
	Fri, 10 Jul 2026 15:29:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6yj8yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 15:29:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66AFT90623069372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 15:29:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A8AD20040;
	Fri, 10 Jul 2026 15:29:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B2E220043;
	Fri, 10 Jul 2026 15:29:09 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.196.135])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 15:29:09 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v12 10/17] target/s390x: Base support for cpacf protected keys and pckmo
Date: Fri, 10 Jul 2026 17:28:56 +0200
Message-ID: <20260710152906.80207-11-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710152906.80207-1-freude@linux.ibm.com>
References: <20260710152906.80207-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=VebH+lp9 c=1 sm=1 tr=0 ts=6a510fca cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=c7LoGp8Tn7I-ceKYaY8A:9
X-Proofpoint-GUID: gn67LIa9bP0xhWCoscYAil1twQ1Ktvcj
X-Proofpoint-ORIG-GUID: gn67LIa9bP0xhWCoscYAil1twQ1Ktvcj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE1MyBTYWx0ZWRfX6rb7w/vnVvEY
 XXMRDrp0nkU79qKAxXgW4Svod6Ooo6SFRKD1AJnQQHRcaO2+Lq0R8eEdEZLhIXrc0cWZ4MYewqF
 1g87X107MeV5s6ie5mq7fWjwlagwTdM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE1MyBTYWx0ZWRfX6YcU24N+CJzw
 Q8JXIlULgKeeIF4vd9WVsiKcfsBR1I1oJxOKqH+8xnp50xpPMMj/KGb73YXVzR0pXjwsVb+dZi6
 GnzaToByEIIxRkkzE1w7pIwraJ5Ir7JKn+t0qql14SPkRnm3OKL+8YSPTI2NCpKUvz00knWuc6E
 7vShrEMxQqNYTv85oY0qqgVyvVNCE4EMlo2GBWYZWjGLpT7w6FM9kOGlifChue7w2mxarPMpTNV
 QhjtaZlAFJBQtoiK1H19MJDphOCeU+jWbFetM1F6VOx3hZMUcsHCJz4Oqs7sLjJcdZuxwWudgo/
 aYtElqkikoBmIJUMOZHqsTRCpJnP8JtAfQi+eVylXlMnffl5D4L6qj++3Ibbis3hMkE0/rILw4b
 lNPyVz/uTzPES2x8hBdxsEq6yYMyme40cTdNLpchuYMJbUYSYIQioxrWC+AEcy+CDQkm/eBttSf
 wdHcRff2l0Gsbb3QDyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100153

Add base support for cpacf protected key handling.
Add support for the pckmo subfunctions PCKMO-Encrypt-AES-128-Key,
PCKMO-Encrypt-AES-192-Key and PCKMO-Encrypt-AES-256-Key which deal
with protected keys. These pckmo subfunctions derive a protected key
from an AES clear key by encrypting it with an internal AES wrapping
key. More details about protected keys can be found in the
"z/Architecture Prinziples of Operation" document.

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
Tested-by: Holger Dengler <dengler@linux.ibm.com>
---
 target/s390x/gen-features.c      |  3 ++
 target/s390x/tcg/cpacf.h         | 29 +++++++++++++++
 target/s390x/tcg/cpacf_aes.c     | 64 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c | 21 +++++++++++
 target/s390x/tcg/translate.c     |  9 ++++-
 5 files changed, 124 insertions(+), 2 deletions(-)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 078aeddb36..c5fd578d92 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -935,6 +935,9 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KMCTR_AES_256,
     S390_FEAT_PCC_XTS_AES_128,
     S390_FEAT_PCC_XTS_AES_256,
+    S390_FEAT_PCKMO_AES_128,
+    S390_FEAT_PCKMO_AES_192,
+    S390_FEAT_PCKMO_AES_256,
 };
 
 /****** END FEATURE DEFS ******/
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 61ce71476b..1d7d9baf0c 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -254,4 +254,33 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
+/* from cpacf_aes.c */
+int cpacf_aes_pckmo(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                    uint64_t param_addr, uint8_t fc);
+
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 13d5cdff42..bc92884ff9 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -418,3 +418,67 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
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
+int cpacf_aes_pckmo(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                    uint64_t param_addr, uint8_t fc)
+{
+    uint8_t key[32];
+    int keysize;
+
+    switch (fc) {
+    case CPACF_PCKMO_ENC_AES_128_KEY:
+        keysize = 16;
+        break;
+    case CPACF_PCKMO_ENC_AES_192_KEY:
+        keysize = 24;
+        break;
+    case CPACF_PCKMO_ENC_AES_256_KEY:
+        keysize = 32;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    /* fetch key from param block */
+    copy_from_guest_wrap(env, mmu_idx, ra, param_addr, key, keysize);
+
+    /* 'derive' the protected key from the clear key */
+    encrypt_clrkey(key, keysize);
+
+    /* store the protected key into param block */
+    copy_to_guest_wrap(env, mmu_idx, ra, param_addr, key, keysize);
+    /* followed by the fake wkvp */
+    copy_to_guest_wrap(env, mmu_idx, ra,
+                       param_addr + keysize,
+                       protkey_wkvp, sizeof(protkey_wkvp));
+
+    return 0;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 564f7fa243..08151e916f 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -192,6 +192,24 @@ static int cpacf_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     return rc;
 }
 
+static int cpacf_pckmo(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                       uint8_t fc)
+{
+    int rc = 0;
+
+    switch (fc) {
+    case CPACF_PCKMO_ENC_AES_128_KEY:
+    case CPACF_PCKMO_ENC_AES_192_KEY:
+    case CPACF_PCKMO_ENC_AES_256_KEY:
+        rc = cpacf_aes_pckmo(env, mmu_idx, ra, env->regs[1], fc);
+        break;
+    default:
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    return rc;
+}
+
 uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
                      uint32_t type)
 {
@@ -251,6 +269,9 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     case S390_FEAT_TYPE_PCC:
         rc = cpacf_pcc(env, mmu_idx, ra, fc);
         break;
+    case S390_FEAT_TYPE_PCKMO:
+        rc = cpacf_pckmo(env, mmu_idx, ra, fc);
+        break;
     case S390_FEAT_TYPE_PPNO:
         rc = cpacf_ppno(env, mmu_idx, ra, r1, r2, r3, fc);
         break;
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index cef1b55149..d7a99e6c1e 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2558,6 +2558,7 @@ static DisasJumpType op_msa(DisasContext *s, DisasOps *o)
     int r2 = have_field(s, r2) ? get_field(s, r2) : 0;
     int r3 = have_field(s, r3) ? get_field(s, r3) : 0;
     TCGv_i32 t_r1, t_r2, t_r3, type;
+    bool update_cc = true;
 
     switch (s->insn->data) {
     case S390_FEAT_TYPE_KMA:
@@ -2589,8 +2590,10 @@ static DisasJumpType op_msa(DisasContext *s, DisasOps *o)
             gen_program_exception(s, PGM_SPECIFICATION);
             return DISAS_NORETURN;
         }
-        /* FALL THROUGH */
+        break;
     case S390_FEAT_TYPE_PCKMO:
+        update_cc = false;
+        /* FALL THROUGH */
     case S390_FEAT_TYPE_PCC:
     case S390_FEAT_TYPE_KDSA:
         break;
@@ -2603,7 +2606,9 @@ static DisasJumpType op_msa(DisasContext *s, DisasOps *o)
     t_r3 = tcg_constant_i32(r3);
     type = tcg_constant_i32(s->insn->data);
     gen_helper_msa(cc_op, tcg_env, t_r1, t_r2, t_r3, type);
-    set_cc_static(s);
+    if (update_cc) {
+        set_cc_static(s);
+    }
     return DISAS_NEXT;
 }
 
-- 
2.43.0

