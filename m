Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A374D33F368
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773570; cv=none; b=HTlI35ML7h292kmSCTzpJvg2D7yZK0M/ULBsBoxGirVuJNWMFU21JUNq08v35TX3+W9/v+GC2e7p2Y5wJPBcPeVsN2XXcAKrw2AdXrS9y9LKP8SEINDuugzFSZ2XoasDPC2V5IyYJeuOsbWOHHSTROp5P98x6Fl0J0EC5tJOGq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773570; c=relaxed/simple;
	bh=pSpEAeNuCSlB8kR4hDBdN899Hn8WNh5WpqBL2JTyw0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uw4RNZzF8pr3e2l+WkzPDyMvWx5h5mnrL0G03PBY5K4Glr29E/4kZKL3j/tflMRJ4Pu2/2FcTWV6Mij/wKW6rJ62kniIFT6fdxhcH/FsUUe3DujMmlGVEm9A8carkr/tgoCjJvEC9Ii9uN2kx+BX8I1PA6R/r/PXkVzu9MjApME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=deTzTg9T; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="deTzTg9T"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHnqv2341358;
	Mon, 3 Aug 2026 16:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kbG70sko5MjTOTBwE
	PiFt6z0BOgUCwkodIZnAKzhJtQ=; b=deTzTg9TsklPCWVtMnhDSn8lyXsTONqvw
	YUhCIHJyP/MR3dcTboomKVQ9dVMqmKuqhwv2Uzchxl1C2e16SWLSJW6mberyc92z
	vW7JQvm0eFUj1BsMEj32dQXhYUtUaGgUnmW6Wx/n8y+D26TCBiEflRllKP8h+Qrt
	/JxxbxigOaspMCxoVo4fAteRGD3KdYOH3kpvHqjb6re28xgG2etcB9P40Ae0IVc4
	lpx484Ok1BoimDsKhALF+2ut9YpMk9iYouBBIoq2n/ClXfG9AtqffvlR8SELANVa
	fqp4/mfVbUDaBUD2t1RiM43cALG8ViKcTmUz+9XJ7+qbyimx6MdgA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8euhbvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:12:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673GBQ8I012078;
	Mon, 3 Aug 2026 16:12:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4jx6aj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:12:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673GCX1e8782096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 16:12:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2EC120040;
	Mon,  3 Aug 2026 16:12:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADE8E2004B;
	Mon,  3 Aug 2026 16:12:32 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.207.251])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 16:12:32 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v13 11/18] target/s390x: Base support for cpacf protected keys and pckmo
Date: Mon,  3 Aug 2026 18:12:28 +0200
Message-ID: <20260803161235.228704-12-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803161235.228704-1-freude@linux.ibm.com>
References: <20260803161235.228704-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tYTCBoQZZF0C0tx7CM8sKnsUoC9kpr-B
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX5DXuFAViCK/A
 AMVFzuW3PgNhphdROAvB5C4M97wxfiIg5ip8CD8mjE0UKJ3RUtNp3Nr05NkGtINRsFjvdUTW0nZ
 kKwTLio8V9I92PbfXoUG0GwMD7HUOqg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX6y37RGsY+Hbs
 YV74RBCB5x7iEE+4fIh9MCenpdL1et2hY5OctXH8MfMh/oaTf2Xr3PmCH8JmSrThqoNE9BzyV/s
 4ntjG9PZYzfL30vWxUOM3eZQI0XyNyFXpaOMF/AE0EddSTJHGOsyCmkV3QzY4a6B0ZkRvKJetfs
 Vd18Uoo1LO24ISJJ00nitePm5m/+0+wfBqmZxVhs4/1gcuBS+a2J44dty1+bPSu1eXmagaguVLu
 p79JtT96cAlciKyZVTUwtZNjYgFzfHvBP9aktVTazcAgjCQn8hQpPzX2tVMOI+sYD6Iytb2NqA4
 pes3JpNl9Z0Evv+xzkaiZRYx9woccrC3qGKxOrQHborOXHlqiQD6DST/9+6Z421cMpD52I0DnDV
 T8PV7MCmlAsNOijV5ZuBRmUSlhMud/SmWCNRWR178hOJNH0FcY7Ltow9IGZMkxN093lhbPfoLUI
 ZyA/lcKH/378xSITJow==
X-Proofpoint-GUID: tYTCBoQZZF0C0tx7CM8sKnsUoC9kpr-B
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a70bdf5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=c7LoGp8Tn7I-ceKYaY8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141

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
index 0ffb514a84..4f0b243f53 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -389,3 +389,67 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
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
index 4fdb0d7c7d..f1ebac1e41 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -193,6 +193,24 @@ static int cpacf_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
@@ -252,6 +270,9 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
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

