Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDCC47CC92
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069927; cv=none; b=tExtXSMcSM0JTc4UG8jnkCEJDR2DTIgKXphfGeaKYvMOlQWv2el6V7p2Lr3c7JuCLPlD1+G57HmkWQyqCHMG+xkFM4V3e+ggtUYrLmDoym2QvhCNA8wtIaXiHXLJQS1VSmeDwayCq5dKdw2Yl0uBDLGeWYZr2Y0rxDiisXajuSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069927; c=relaxed/simple;
	bh=knEG1M0Yw+mIPO3+85i5Hl+OFHjcCfxhUdnbKoBVDWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNpTmCVGfbz6g1xuFKng9Bf9iQQZghcu7lZcUROMgX6UWZcI+d3PpRjfHYZUAWkmcr7E82LcvEC4Y+8u5gsCAhDXr0M026yBFPgAnZRWZYoI5KnevSH5RRay4w9O4QsOSyUgiy5RYewo23TTTFV0io6cZRokPbvkrDMYk7sX5Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UL3NMN52; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UL3NMN52"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3d83542434;
	Tue, 18 Aug 2026 16:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=x6obM7fB/Xk5J/W3n
	GGqj/syY9iff/HcT84WsTlmv7g=; b=UL3NMN52OqQCIpm7WbyqIqkoA2JyYyJD0
	3ydLK3MZnzZ/Sk/dol12sEkdLLcI+jpkPVrkxS8bK2Q5YJ3LkEIWTH+f4ouMpXyC
	D+sXuLRO5Hd3Evvk+zdQ/5CcVABoHHyIKDEblidpcK51Zbjgdzs6UlnZKquIGzny
	Her2Y+b1W7J+ej01gFg0VCufBT3qC2sXnKyq9D6ZNsd9DNsA5OUd2VCPIeZMzWbc
	CnI53oajwJeiWlCxkXP3LT1ortCRYMIOdlMy+ZRBxXBJCCus7wsu/c6hCgb6DqLb
	8H0usrByefCpy4k83Bo5kEZZ0EvRYqvQpMz3H4Q+UjEp+b/534zUA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt8ua7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 16:18:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IGBLVa012964;
	Tue, 18 Aug 2026 16:18:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh444y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 16:18:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IGISsM43581764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 16:18:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF6B020043;
	Tue, 18 Aug 2026 16:18:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDEE42004B;
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
Subject: [PATCH v15 14/20] target/s390x: Support protected key AES ECB for cpacf km instruction
Date: Tue, 18 Aug 2026 18:18:18 +0200
Message-ID: <20260818161824.100746-15-freude@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a8485d8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=H4cIW5jPVsLKBRIgpP4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDExOCBTYWx0ZWRfX0zh0TMvP4cyj
 9tKQm7kHmwhY6ZJ69718MR9K3pfQV/nr/+igDEuf98ZKnVXHxaCamUVqP7Dmkmsph6YXo73B1aq
 s+CQXifU7uus3TraJqpkhYibVLaNfgo=
X-Proofpoint-GUID: nKEVwBAcRJn62XRLwWbZCzLpjUrWAhEk
X-Proofpoint-ORIG-GUID: nKEVwBAcRJn62XRLwWbZCzLpjUrWAhEk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDExOCBTYWx0ZWRfX+KOhMoyDDxIY
 GTTFpfyWxuEyhqTNxoGq+//ci6ZkrmJxOTFFklHWuFPu4qc4pApenAhLYm0teY4lvNSghqJBloH
 1NKjfSfDnbjTIsReWQDh0TR1ujorDHQJ4GX/fRyI8n8lIPEslmeBngKhz9i/z+jUo40mFkY8ls/
 pNnGw2ExviyL/pieNb4cCnVRlCtGBdGWrPNZobl/FFU+Aa3eLJ2jsa3z4OQtYEVYnSK0Hsov+7x
 OCr+omy1a12Cc0hpMV5NbtgWtOHuhwL77OKwLsvFgNM7TCRQYEhfg8XbmxeF7AljeUXe6AuVwvS
 jNGKIIa8TsmRHwn6JZZFgZkynPpPKJszaJQTfjhq879oqj63g9uzbU/1WRAmAeUGigqdW6mNlc9
 R8vTh0tbM+AjfJS6DxquUCzS7nmjsZVUgabBLMYo9qapGy46C19mGIqeSuoLQOJkQvQkZQfuA5y
 L36Rs5YP8tZDcKof4Cw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180118

Support the subfunctions CPACF_KM_PAES_128, CPACF_KM_PAES_192
and CPACF_KM_PAES_256 for the cpacf km instruction.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/gen-features.c      |   3 +
 target/s390x/tcg/cpacf.h         |   4 ++
 target/s390x/tcg/cpacf_aes.c     | 103 +++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |   7 +++
 4 files changed, 117 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index c5fd578d92..17de37f183 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -925,6 +925,9 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KM_AES_128,
     S390_FEAT_KM_AES_192,
     S390_FEAT_KM_AES_256,
+    S390_FEAT_KM_EAES_128,
+    S390_FEAT_KM_EAES_192,
+    S390_FEAT_KM_EAES_256,
     S390_FEAT_KM_XTS_AES_128,
     S390_FEAT_KM_XTS_AES_256,
     S390_FEAT_KMC_AES_128,
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 1964de5b6d..9c654c3353 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -40,5 +40,9 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint32_t type, uint8_t fc, uint8_t mod);
 int cpacf_aes_pckmo(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                     uint64_t param_addr, uint8_t fc);
+int cpacf_paes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint64_t *dst_ptr_reg,
+                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                   uint32_t type, uint8_t fc, uint8_t mod);
 
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 12ae367809..d727e718be 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -484,6 +484,17 @@ static void encrypt_clrkey(uint8_t *key, int keysize)
     }
 }
 
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
+
 int cpacf_aes_pckmo(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                     uint64_t param_addr, uint8_t fc)
 {
@@ -519,3 +530,95 @@ int cpacf_aes_pckmo(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return 0;
 }
+
+int cpacf_paes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint64_t *dst_ptr_reg,
+                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                   uint32_t type, uint8_t fc, uint8_t mod)
+{
+    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
+    uint64_t len = *src_len_reg, done = 0;
+    int i, keysize, addr_reg_size;
+    uint8_t key[32], wkvp[32];
+    AES_KEY exkey;
+
+    g_assert(type == S390_FEAT_TYPE_KM);
+
+    switch (fc) {
+    case CPACF_KM_PAES_128:
+        keysize = 16;
+        break;
+    case CPACF_KM_PAES_192:
+        keysize = 24;
+        break;
+    case CPACF_KM_PAES_256:
+        keysize = 32;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    /* check addressing mode, raise exception if not supported here */
+    addr_reg_size = get_address_bitsize(env);
+    switch (addr_reg_size) {
+    case 64:
+        break;
+    case 32:
+        len = (uint32_t)len;
+        break;
+    default:
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    /* early bail out if length is zero */
+    if (!len) {
+            return 0;
+    }
+
+    /* length has to be properly aligned. */
+    if (!QEMU_IS_ALIGNED(len, AES_BLOCK_SIZE)) {
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    /* fetch and check wkvp from param block */
+    read_guest_wrap_u8(env, mmu_idx, ra,
+                       param_addr + keysize, wkvp, sizeof(wkvp));
+    if (memcmp(wkvp, protkey_wkvp, sizeof(wkvp))) {
+        /* wkvp mismatch -> return with cc 1 */
+        return 1;
+    }
+
+    /* fetch protected key from param block */
+    read_guest_wrap_u8(env, mmu_idx, ra, param_addr, key, keysize);
+    /* decrypt the protected key */
+    decrypt_protkey(key, keysize);
+
+    /* expand key */
+    if (mod) {
+        AES_set_decrypt_key(key, keysize * 8, &exkey);
+    } else {
+        AES_set_encrypt_key(key, keysize * 8, &exkey);
+    }
+
+    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
+    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
+        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
+        if (mod) {
+            AES_decrypt(in, out, &exkey);
+        } else {
+            AES_encrypt(in, out, &exkey);
+        }
+        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
+        len -= AES_BLOCK_SIZE;
+        done += AES_BLOCK_SIZE;
+    }
+
+    *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
+                             *src_ptr_reg + done);
+    *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
+                             *dst_ptr_reg + done);
+    *src_len_reg -= done;
+
+    return !len ? 0 : 3;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 2cedc1d5e8..77f2ae9caa 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -112,6 +112,13 @@ static int cpacf_km(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
                            S390_FEAT_TYPE_KM, fc, mod);
         break;
+    case CPACF_KM_PAES_128:
+    case CPACF_KM_PAES_192:
+    case CPACF_KM_PAES_256:
+        rc = cpacf_paes_ecb(env, mmu_idx, ra, env->regs[1],
+                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
+                            S390_FEAT_TYPE_KM, fc, mod);
+        break;
     case CPACF_KM_XTS_128:
     case CPACF_KM_XTS_256:
         rc = cpacf_aes_xts(env, mmu_idx, ra, env->regs[1],
-- 
2.43.0

