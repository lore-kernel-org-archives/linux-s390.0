Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E786447143D
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069925; cv=none; b=SqHWZBnPijDIBGIqTRCysA5rSR4/DJWAHWUelnD935fXGKn+BzP3+n6DaFuoJrjB5RWOFmGGjUFpqDKhH59GH/QVv8w9vKE6EE2B69yyB2XNWExPxGS4HE+qEcdKwPcj+I4BLX+tatTznFCNAuzL4T1WxF1rmkdnqN8jX4HMGkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069925; c=relaxed/simple;
	bh=+eBdqL3mDHfRkLGI8QLzeiWZMEuopQ/1pJlUPK5dg20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4ke6ubIsgdE28ClycnTEXTb4OE8QyMRBs6W3kD3n+8jHbE5sM1BNkx16nlUCc2dF00twjltc6P3ih19TdGH6zu4KXD0f+AOPy+E1fbDfsdIR0ygwjt8xd+9YHFahBPUJ23Z6ulO842tyW/oJwgIxU5Rfnqgpb9AZb2KZ4YWCsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VKnpQLPn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VKnpQLPn"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3qS43582804;
	Tue, 18 Aug 2026 16:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CDi5SWQ0zrll23RoW
	bKEARynp6gNxp3xz450WxFDib8=; b=VKnpQLPn8FmeNwgKAe7KDJKt3ycSyjL3o
	3+sy5HfBPYrOdQQVZaBIO5mC3vjtUUDiraEvQoZbCc5UOyW+SVovGNtZNXJYwwG3
	Hg2Aezo1amnbWmE0gz0giwo3zF+SfqnvWTpJ04yS9KbRbTJ2tCYiCA2GXNyW4rZC
	Ly5UQfA8jckhckBK/g02xBv28u9ISATSUiYZgOCXKRZnylQlMWOJsXCEkJP8z4lq
	3cMoIzgsHtaQcpci2dwc1jCCwHImWW2nPo9D75Xm2P/zWL9v1yD3Lz3IK3JkuHWI
	PNLKU+QU7avgZG5H8IIkuqriZlOU72FiUkdOnMO6iNb977CqXZPKA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2ehe90jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 16:18:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IGBL1K002196;
	Tue, 18 Aug 2026 16:18:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ek455n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 16:18:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IGIRog49676554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 16:18:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B86FE20043;
	Tue, 18 Aug 2026 16:18:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84CB62004D;
	Tue, 18 Aug 2026 16:18:27 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.161.134])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 16:18:27 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v15 13/20] target/s390x: Base support for cpacf protected keys and pckmo
Date: Tue, 18 Aug 2026 18:18:17 +0200
Message-ID: <20260818161824.100746-14-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818161824.100746-1-freude@linux.ibm.com>
References: <20260818161824.100746-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDExOCBTYWx0ZWRfX425otkKVdWrS
 /Enqw5G+BR2n0PZNYYDnvmznE51T9T4iRh3J+MibdtDDv+L03028YZRrBr8v1aKGXgVWhxrsweP
 wNK4ThQoZ3WJqgjzYBDKULvsbWTAiEEWu/hEqgafACuGcBMKCR2UiJbny7oOSRRyYvkWaQX/a9x
 xin1Onca9yLLBVNBY8Sz0eqmn9T+Gk3vCYfxS/brB/hc0bTxXCdwuMTCUeNPtkkUFgADM3uz/0y
 JtMvgjqpAuGLeiPEePwV1LSxprU0gFA0ls+Avuksn4hiE400bpV24crtmMKA8azy73LMHxXQ0Y6
 GoF3vI4Y6UqOIuO/m/4TmrbUk7RY85Mqy4O8AKtrQQN1SU29Tehiwvvb78CltIS6r7dy3NY7tRT
 bqxWTC2S9sY57cvRW3rgn3w2lFBNTY+BoTtpmGiMPy2Ut9bt+thkwOuRVaVW75SYgj0r8bhg2kn
 EG3eGAdJglALcvQLVBQ==
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a8485d8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=Ka7jyKarb0bbGO5OOBwA:9
X-Proofpoint-ORIG-GUID: IjC-p4MnoD3_Te-8L2HUaDOoJXEG5DVS
X-Proofpoint-GUID: IjC-p4MnoD3_Te-8L2HUaDOoJXEG5DVS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDExOCBTYWx0ZWRfXx9zRdvzU0Xz1
 MUCQdBEuQe4uVZ0JU3frBnpq9wRncdhFlifEuvRqnlOk4s5KLnn9VF4zT5rzUOyhX9+tAjJqe1T
 gIFy3AUcAORmK07cLIHytKWXwCT84aU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180118

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
  value of 32 bytes 0x0F0A0C0E0F0A0C0E...

Add preprocessor defines for the xor pattern and wkvp used to
construct ('encrypt') a protected key from a clear key value with
this implementation. Also add some static functions to 'encrypt'
from clear key to protected key and 'decrypt' back to cpacf_aes.c.

The preprocessor defines shall be used later in testcases to
construct and decode protected keys.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/gen-features.c      |  3 ++
 target/s390x/tcg/cpacf-arch.h    | 25 +++++++++++++
 target/s390x/tcg/cpacf.h         |  2 +
 target/s390x/tcg/cpacf_aes.c     | 64 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c | 21 +++++++++++
 target/s390x/tcg/translate.c     |  9 ++++-
 6 files changed, 122 insertions(+), 2 deletions(-)

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
diff --git a/target/s390x/tcg/cpacf-arch.h b/target/s390x/tcg/cpacf-arch.h
index f92e4b44e3..cd51169c45 100644
--- a/target/s390x/tcg/cpacf-arch.h
+++ b/target/s390x/tcg/cpacf-arch.h
@@ -223,4 +223,29 @@
 #define CPACF_KDSA_PSIGN_ED25519   48
 #define CPACF_KDSA_PSIGN_ED448     52
 
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
 #endif /* S390X_CPACF_ARCH_H */
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 5013e19907..1964de5b6d 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -38,5 +38,7 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t param_addr, uint64_t *dst_ptr_reg,
                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                   uint32_t type, uint8_t fc, uint8_t mod);
+int cpacf_aes_pckmo(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                    uint64_t param_addr, uint8_t fc);
 
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 735cabdb1b..12ae367809 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -455,3 +455,67 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
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
+    read_guest_wrap_u8(env, mmu_idx, ra, param_addr, key, keysize);
+
+    /* 'derive' the protected key from the clear key */
+    encrypt_clrkey(key, keysize);
+
+    /* store the protected key into param block */
+    write_guest_wrap_u8(env, mmu_idx, ra, param_addr, key, keysize);
+    /* followed by the fake wkvp */
+    write_guest_wrap_u8(env, mmu_idx, ra,
+                        param_addr + keysize,
+                        protkey_wkvp, sizeof(protkey_wkvp));
+
+    return 0;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 1ced5c123e..2cedc1d5e8 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -205,6 +205,24 @@ static int cpacf_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
@@ -264,6 +282,9 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
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
index 6183ae76b6..9643d88571 100644
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

