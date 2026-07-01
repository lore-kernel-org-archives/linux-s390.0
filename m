Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB63379C4C
	for <linux-s390@vger.kernel.org>; Wed,  1 Jul 2026 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924434; cv=none; b=EZSK6J1xUeQujCDUOpRXWgnDSeCqerHmT+elYfbJZBTOQpiuL5NBRSj9NH5jyJb1ALyoxrRS7lSQDUeMJUqyLYIrXH1vGWz9J81SAR/wGXLtnqU2TZyEB5JoEsWlUfKeOptIW+5rjEc4Hic+m1nbm3CteQ9Rm1FUl19mLWqB/uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924434; c=relaxed/simple;
	bh=WDhLD2zVezgQh2PVMlyIhI6BeeCRKMCcj2meRmaT7q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQ3kSNGmYmrlZ2ohtRYEEQLD2XkLgroyr/V7rdUeEypo6rkAF/6L9zhlcu7MiAkf/roRqPuzdw6MY7NRZej4oitWXsNZie44V5a5qzOAoVdEIUixmOzs0WTdY0xzvqeGrGWQ9f+zmtQMrFy/LEjUdH6bU35f3UyIkejqqnCM/F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sNHeUpoT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sNHeUpoT"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661AIRbv446509;
	Wed, 1 Jul 2026 16:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=o1x6KBb1VQ07421LN
	D+pPC33UIDdSB9H/6OFMNnsHPY=; b=sNHeUpoTQ4DxkRjlyuSNYqj6eeXA+Z7C4
	KxTV3IEF5fb7jlUKKFFHEurO/SSAs4d6vAOhIQKdFBh/fm1Rqv04nTujOQglesTT
	9OS60rHAAZVJR9xL0Vmi8RoWwt7vHxTWiTjPV78ezJjlqQnAKOkrgt5tij666okf
	hb+T0pXTwi4ZRtTL1SxHT+ya4cVRxK28CBkF72GmLkBx+cOsqm4kkjQOk0RLzj+7
	jIgojklI5YraGDWHI+WXxg2zs2B4cxqn/GBQQXPgYl8RRmV6g5BQtv8g0++LMPHU
	sG3OPk5nQ0aa7aMAshPhFF8EI9/8sqBb+GboU8pEpRyHP5eWRb0Cg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjwa9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 16:46:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661GYcFk023124;
	Wed, 1 Jul 2026 16:46:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhg3wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 16:46:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 661GkrQ449152412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 16:46:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D26492004D;
	Wed,  1 Jul 2026 16:46:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1C7320065;
	Wed,  1 Jul 2026 16:46:53 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.187.249])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 16:46:53 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v9 09/21] target/s390x: Support AES XTS for cpacf km instruction
Date: Wed,  1 Jul 2026 18:46:32 +0200
Message-ID: <20260701164650.95760-10-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701164650.95760-1-freude@linux.ibm.com>
References: <20260701164650.95760-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE3MyBTYWx0ZWRfXzPttPC+2xg6m
 C15VbBQfDsdS1VY/eAJJDbivZ2XPTSLczgmoC/WT2f/n3v0l9ibLETVZpVXq0TvlJ9VVFZ8hMNJ
 QT8y3GLeAZCXn4KsqqS3AiRJHSq/S6Zre6zjtRFpS/8J7rPOlDFbt9//uGTVd/xTq3AGLz91I+O
 uGbyd7G/JyHY5k1Wwr+NneTDXKkxsNGVC3vlUWVNenvJqCqexi8TE3cT8WZQFa1Q9yLQ5crREn6
 kNX2O6Ic5A95mse+CjBnGNFEo0SAq3uRRilovS0XsK42K1UFP7R2egMhQHAVKmoFUSiqHizsIB8
 kT8XZAwM3X4dHuzwbQah2l/8m8ZscOfdG6BhM3hB3YCtCdKcNi81vbOG4txzbRiQT0dNG3XZIeA
 un4xc3X/usM3x9Ef/diQD0eqJgSligasQSIdvvUXfXrBFoDBcsxArJjPrFOgQYgX4xzB8WKE3//
 Da0G+3gqzOYsiOrn+cQ==
X-Proofpoint-GUID: Gj45t3znG3zWeeDS8vuepbIQdONaPuUZ
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a454482 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=zF3DBZfHWt6I_7Vt9OoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE3MyBTYWx0ZWRfX8qvxOLip4Cvg
 fScrZx2PNPg0K4cAcpGTxChRAuXL2I8wJYfFMXzShnD3coJnQDij5ZwKhakV27Ip/kBuyLn12u+
 rxPlX0ArcuplP/jgzKJ3dW8Lmpbkt8A=
X-Proofpoint-ORIG-GUID: Gj45t3znG3zWeeDS8vuepbIQdONaPuUZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010173

Support the subfunctions XTS-AES-128 and XTS-AES-256
for the cpacf km instruction.

Tested-by: Holger Dengler <dengler@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/gen-features.c      |   2 +
 target/s390x/tcg/cpacf.h         |   4 ++
 target/s390x/tcg/cpacf_aes.c     | 108 +++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |   6 ++
 4 files changed, 120 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 1b6a874b90..f9b1a40c7c 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -924,6 +924,8 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KM_AES_128,
     S390_FEAT_KM_AES_192,
     S390_FEAT_KM_AES_256,
+    S390_FEAT_KM_XTS_AES_128,
+    S390_FEAT_KM_XTS_AES_256,
     S390_FEAT_KMC_AES_128,
     S390_FEAT_KMC_AES_192,
     S390_FEAT_KMC_AES_256,
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 2e8ed72758..e585b77766 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -249,5 +249,9 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint8_t fc, uint8_t mod);
 int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t param_addr, uint8_t fc);
+int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                  uint64_t param_addr, uint64_t *dst_ptr_reg,
+                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                  uint32_t type, uint8_t fc, uint8_t mod);
 
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index f41b7dc541..4a28cc3d7c 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -353,3 +353,111 @@ int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return 0;
 }
+
+static void aes_xts_prep_next_tweak(uint8_t tweak[AES_BLOCK_SIZE])
+{
+    uint8_t carry;
+    int i;
+
+    carry = tweak[AES_BLOCK_SIZE - 1] >> 7;
+
+    for (i = AES_BLOCK_SIZE - 1; i > 0; i--) {
+        tweak[i] = (uint8_t)((tweak[i] << 1) | (tweak[i - 1] >> 7));
+    }
+
+    tweak[i] = (uint8_t)(tweak[i] << 1);
+    tweak[i] ^= (uint8_t)(0x87 & (uint8_t)(-(int8_t)carry));
+}
+
+int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                  uint64_t param_addr, uint64_t *dst_ptr_reg,
+                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                  uint32_t type, uint8_t fc, uint8_t mod)
+{
+    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
+    uint8_t buf1[AES_BLOCK_SIZE], buf2[AES_BLOCK_SIZE];
+    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
+    uint64_t addr, len = *src_len_reg, done = 0;
+    uint8_t key[32], tweak[AES_BLOCK_SIZE];
+    int i, keysize, addr_reg_size = 64;
+    AES_KEY exkey;
+
+    g_assert(type == S390_FEAT_TYPE_KM);
+
+    switch (fc) {
+    case CPACF_KM_XTS_128:
+        keysize = 16;
+        break;
+    case CPACF_KM_XTS_256:
+        keysize = 32;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (!(env->psw.mask & PSW_MASK_64)) {
+        len = (uint32_t)len;
+        addr_reg_size = (env->psw.mask & PSW_MASK_32) ? 32 : 24;
+    }
+
+    /* length has to be properly aligned. */
+    if (!QEMU_IS_ALIGNED(len, AES_BLOCK_SIZE)) {
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    /* fetch key from param block */
+    for (i = 0; i < keysize; i++) {
+        addr = wrap_address(env, param_addr + i);
+        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
+    }
+
+    /* expand key */
+    if (mod) {
+        AES_set_decrypt_key(key, keysize * 8, &exkey);
+    } else {
+        AES_set_encrypt_key(key, keysize * 8, &exkey);
+    }
+
+    /* fetch tweak from param block */
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        addr = wrap_address(env, param_addr + keysize + i);
+        tweak[i] = cpu_ldb_mmu(env, addr, oi, ra);
+    }
+
+    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
+    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
+        /* fetch one AES block into buf1  */
+        aes_read_block(env, mmu_idx, *src_ptr_reg + done, buf1, ra);
+        /* buf1 xor tweak => buf2 */
+        aes_xor(buf1, tweak, buf2);
+        if (mod) {
+            /* decrypt buf2 => buf1 */
+            AES_decrypt(buf2, buf1, &exkey);
+        } else {
+            /* encrypt buf2 => buf1 */
+            AES_encrypt(buf2, buf1, &exkey);
+        }
+        /* buf1 xor tweak => buf2 */
+        aes_xor(buf1, tweak, buf2);
+        /* prep tweak for next round */
+        aes_xts_prep_next_tweak(tweak);
+        /* write out this processed block from buf2 */
+        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, buf2, ra);
+        len -= AES_BLOCK_SIZE;
+        done += AES_BLOCK_SIZE;
+    }
+
+    /* update tweak in param block */
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        addr = wrap_address(env, param_addr + keysize + i);
+        cpu_stb_mmu(env, addr, tweak[i], oi, ra);
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
index 1d447cef30..564f7fa243 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -103,6 +103,12 @@ static int cpacf_km(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
                            S390_FEAT_TYPE_KM, fc, mod);
         break;
+    case CPACF_KM_XTS_128:
+    case CPACF_KM_XTS_256:
+        rc = cpacf_aes_xts(env, mmu_idx, ra, env->regs[1],
+                           &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
+                           S390_FEAT_TYPE_KM, fc, mod);
+        break;
     default:
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
-- 
2.43.0

