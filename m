Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83B439936E
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782288663; cv=none; b=Ch1qnchGJdXMzcb9BkFzUyvsmC6V9DbdDNZBU43M72X9liY+l+CSEyEBzN5PJOSD1NeQOQu1Z7Z9PLy4l3GVdfnTKkQUx9c0Yzqh46yRnD4+v9fpbm+Y95aTwS+tkFHMdsF7FH1OwH25tvAupsm4De9lqnl/nfbvIjQWOdw8JrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782288663; c=relaxed/simple;
	bh=fw7vgXFlV7jYsMoHuxLjUV5Y+Brs0sVgpv9NP+vrx8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGivR3fDSiSvh1RZmmW51kroMNe55/phaI5VmSPhJVVI/ET09TxlYQwtJQKRAQ8c3560PXNOcbRt7tpBTxDtYITdl4JL2fMPqdVhNPVtGwzleO1UC7XXRDbUCnVPty/AKB4kuOwA33w/VOuWauQ+kFp1wlzrnOSGC6yww7PwZZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VURrZgS2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VURrZgS2"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O6IfKA299872;
	Wed, 24 Jun 2026 08:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sO3AQATeZycdTJdqx
	CKtJVoqnpWOwgH95OsxOI3sK6Q=; b=VURrZgS2HFUPFEVLLJwlN2VZl/pyzHygP
	VG+qkn5MPkbM1btGTYvbsBT0NZkKL6pNwfrvdhHlzYBoCnWfw6AyEb1bu4qEzrd0
	cLQ5AktsV0njseiHBuxgGaY3bVRx26lvOhQqDhrJt/3XgOv8ShqxgqgvLlLbWmeE
	IwXBJK/2rB7HsXxpuCSQPF6Zc18NNxWFd2J1WCwlJKgl6CD55K5f6+XTkZBbWmnB
	sOE2kTwUYj4cnve1aKs95u2nXGU95lJtgb4KCAeNwNrCG5MnD64gnjtNqW6vnfRX
	aAlWaolee6EB6d/8bTF3rcgLtskDzj0GO6o2C/WQFG4FR6fCCOXCw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqu084-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:10:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65O84fVd005610;
	Wed, 24 Jun 2026 08:10:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k7kb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:10:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65O8AXfs54329784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 08:10:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 981902004B;
	Wed, 24 Jun 2026 08:10:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 509BD2004D;
	Wed, 24 Jun 2026 08:10:33 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.224.92.54])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 08:10:33 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v8 11/18] target/s390x: Support protected key AES ECB for cpacf km instruction
Date: Wed, 24 Jun 2026 10:10:08 +0200
Message-ID: <20260624081029.23815-12-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624081029.23815-1-freude@linux.ibm.com>
References: <20260624081029.23815-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3b90fe cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=69tMjoP1xJWpGR56_V0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfX5Wk2Jk1opzBn
 LXcWjvwSvFm7NIsnjrNLCGDM3xMLAv1xwynjFKWpPD6mBR/+994MvjGqcA2ZDmch5zqEaUJ54Fz
 ZLGOSb4gk7ewF5MHNfNosUHvOSAFH4+LlIjDk0lz8H09meFglxlHYV9Aw1SzGFuUwpcCswU56uz
 U7HKX4jaQFO4SItzwZOZkC8nqPmKbD5E8Tz7D1QSV6UQCBNUtvJLMt4s8NFoO2XaBZbT8McDoin
 dtHYB7PCOCjFP5WNsfaMMNJYN0Etbv9Ta1sPV0EsEvj+DxdpIsJ74Ju3Vk54LRruRs+zPoNZJj1
 zExDbQOapqier+PxeRy7p3wFRCOTGQ/RWKC1hVaDNcIz3fFJMtDUoOt9iqABx4oSBz8wxKN/jjC
 icno7JQWnPl0jursv18ybUKre1aV0MLYiAAkvvNR5nsUjKzpQ6Q1H+4anIZVMw7z6/neAIURhEM
 HdgfdV+rGyRySDWwFoA==
X-Proofpoint-GUID: u8wXEfX6p6lARDUkvSzbsxBrvJuqzJe_
X-Proofpoint-ORIG-GUID: u8wXEfX6p6lARDUkvSzbsxBrvJuqzJe_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfXzMRujOA8X/Uo
 5qQ8g8Rl73ZCtiBcos4QXCjXNDaNYpW/WpDalM6EVPDUs4qzRFVK0zrsF+pG2S8ODzQsru33M1p
 HhOqJDRNj4koRLNpPuo7JJZOZXCJ6DE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240063

Support the subfunctions CPACF_KM_PAES_128, CPACF_KM_PAES_192
and CPACF_KM_PAES_256 for the cpacf km instruction.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
---
 target/s390x/gen-features.c      |   3 +
 target/s390x/tcg/cpacf.h         |   4 ++
 target/s390x/tcg/cpacf_aes.c     | 113 +++++++++++++++++++++++++++++--
 target/s390x/tcg/crypto_helper.c |   7 ++
 4 files changed, 123 insertions(+), 4 deletions(-)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index d3e69aaca6..71e0e41d6e 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -924,6 +924,9 @@ static uint16_t qemu_MAX[] = {
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
index 1350199536..c246a2157c 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -43,5 +43,9 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint32_t type, uint8_t fc, uint8_t mod);
 int cpacf_aes_pckmo(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                     uint64_t param_addr, uint8_t fc);
+int cpacf_paes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint64_t *dst_ptr_reg,
+                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                   uint32_t type, uint8_t fc, uint8_t mod);
 
 #endif
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 5db63983ef..778cbb5e5f 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -479,6 +479,28 @@ static const uint8_t protkey_wkvp[32] = {
     0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E,
     0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E };
 
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
+
 int cpacf_aes_pckmo(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                     uint64_t param_addr, uint8_t fc)
 {
@@ -507,10 +529,8 @@ int cpacf_aes_pckmo(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
         key[i] = cpu_ldb_mmu(env, addr, oi, ra);
     }
 
-    /* 'derive' the protected key */
-    for (i = 0; i < keysize; i++) {
-        key[i] ^= protkey_xor_pattern[i];
-    }
+    /* encrypt the clear key to a protected key */
+    encrypt_clrkey(key, keysize);
 
     /* store the protected key into param block */
     for (i = 0; i < keysize; i++) {
@@ -525,3 +545,88 @@ int cpacf_aes_pckmo(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return 0;
 }
+
+int cpacf_paes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint64_t *dst_ptr_reg,
+                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                   uint32_t type, uint8_t fc, uint8_t mod)
+{
+    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
+    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
+    uint64_t addr, len = *src_len_reg, done = 0;
+    int i, keysize, addr_reg_size = 64;
+    uint8_t key[32], wkvp[32];
+    AES_KEY exkey;
+
+    g_assert(type == S390_FEAT_TYPE_KM);
+
+    switch (fc) {
+    case 0x1a: /* CPACF_KM_PAES_128 */
+        keysize = 16;
+        break;
+    case 0x1b: /* CPACF_KM_PAES_192 */
+        keysize = 24;
+        break;
+    case 0x1c: /* CPACF_KM_PAES_256 */
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
+    /* fetch and check wkvp from param block */
+    for (i = 0; i < sizeof(wkvp); i++) {
+        addr = wrap_address(env, param_addr + keysize + i);
+        wkvp[i] = cpu_ldb_mmu(env, addr, oi, ra);
+    }
+    if (memcmp(wkvp, protkey_wkvp, sizeof(wkvp))) {
+        /* wkvp mismatch -> return with cc 1 */
+        return 1;
+    }
+
+    /* fetch protected key from param block */
+    for (i = 0; i < keysize; i++) {
+        addr = wrap_address(env, param_addr + i);
+        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
+    }
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
+        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
+        if (mod) {
+            AES_decrypt(in, out, &exkey);
+        } else {
+            AES_encrypt(in, out, &exkey);
+        }
+        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
+        len -= AES_BLOCK_SIZE, done += AES_BLOCK_SIZE;
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
index 3868e3e074..7881749314 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -103,6 +103,13 @@ static int cpacf_km(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
                            S390_FEAT_TYPE_KM, fc, mod);
         break;
+    case 0x1a: /* CPACF_KM_PAES_128 */
+    case 0x1b: /* CPACF_KM_PAES_192 */
+    case 0x1c: /* CPACF_KM_PAES_256 */
+        rc = cpacf_paes_ecb(env, mmu_idx, ra, env->regs[1],
+                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
+                            S390_FEAT_TYPE_KM, fc, mod);
+        break;
     case 0x32: /* CPACF_KM_XTS_128 */
     case 0x34: /* CPACF_KM_XTS_256 */
         rc = cpacf_aes_xts(env, mmu_idx, ra, env->regs[1],
-- 
2.43.0

