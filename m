Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195D73CC7EC
	for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689718; cv=none; b=Fjo/B74PL+7lUrywTp95JXttNlawse5egGfl9AHjiEGHReuKc5p6wi9jacpUO6A+mttvrTUqk0khICCeTKNBRtWeTkiUawSPhyrqABJRaIZSELN4hoZrgoomq4reR3xlVgx92sCRQ8I+OXseyDJCaP8LOcYs49PfHenHCMrPc4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689718; c=relaxed/simple;
	bh=+Ppd7BuaMzJaLkkVw9ajoY03HlhP06vC3EdB+l3I+pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HErdXcnzreY9jmDdt0olZjKU+lNH0PGygRzCLuwKmFwZz48U+Xydu1QuWk85MDLBXa8NRkjMBGgsCGHJpcEOkMRFpg+ulvQjsE8qEoEfXqmgA4JlVsB4O3fFbRGs3D4WidWQK1KtRx9ZzJpJkTVvlt1XVa2StGyaTVc5btcSCDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ouDJhapf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ouDJhapf"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8mDQY079987;
	Wed, 17 Jun 2026 09:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5WSxuqwlknn4ZHqj8
	YRaf8gIGA2ogrmyZvmlU/MzUMc=; b=ouDJhapf86TGgSU4Yq33OMPxebkDDnxFs
	Ls8tewtLJLRWixseO0YnaGajw1YOWVm/kcuwRGiOKIuakzbw+9Nf+w11f9knIME9
	KViNdu99ntCAkpZ+ubwxCaVJtnG2wZGGVHVMmW4qGJaw7+46fpnNqbNc2wesqpU2
	cMMMqra1EM/lpQyYSLmicNprCn48evta2YdibyadltL4uCU9y9DlgfSPL91yWO/b
	KAjSBqSt1wS8YsP+femVo557AFkcxTmTa+OkgZ9fHydaWg3W+EdEWiS/zOp3f9HE
	IQz8VyCC6nX4JbTmwh6FExBpVO6kgFN26OLqa7MpOYwpyJOh49v6w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequ2908-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 09:48:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H9YcGO009187;
	Wed, 17 Jun 2026 09:48:27 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eudva2hjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 09:48:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65H9mNdx40305132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2026 09:48:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CF9D20043;
	Wed, 17 Jun 2026 09:48:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60E062004E;
	Wed, 17 Jun 2026 09:48:23 +0000 (GMT)
Received: from funtu2.ehn-de.ibm.com (unknown [9.224.92.54])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Jun 2026 09:48:23 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v7 11/17] target/s390x: Support protected key AES CBC for cpacf kmc instruction
Date: Wed, 17 Jun 2026 11:48:14 +0200
Message-ID: <20260617094820.34402-12-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617094820.34402-1-freude@linux.ibm.com>
References: <20260617094820.34402-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5MiBTYWx0ZWRfXx3oXrYTdgOHR
 a7KtSHv5Nao3yMHiuLqR4bICxh2B9nrHw/teNgwfEZWBH+7RX70dDFHKKJOM3YaaWi6lulc/7NW
 wwXNiLzkxSJbskfAh4mx7A4Fm8L+yIg=
X-Proofpoint-ORIG-GUID: aWkXkMQev3eeknIYWYya2MJD1aKUsiIT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5MiBTYWx0ZWRfX91ZI9mizRgPA
 Kr09xEOlV9rPf5W/S/IgF3sg7lhfLDkLHbmgEj+f2A71qAhBwT6UxWxreMcVStRsM6yOQew5n29
 7x8pA+OFkEirFdM7PjPxeDnvbafPMNL9fjGfH2hsVySoKF/XhYxkm8WgzNrObJ81uTPf2L/Jtg+
 LVozDFzfyBWB3sG5HKGJTgj3vholX8bWpZuGQSDFGpk54N5Cpoxe8+65Tq41gCDL7UZKFQtr7VT
 D6odhelSvdg1jxfmUuNjjJYG5aOiyr6IbznnRR2pplKG8GjLdNV5t1rGQBZWEagIjPWhG+/eQ0N
 FMKcQiuRxpYVMM3mht9KV/zyRaPGFwVFvTgZ657IO6deXOJnJg/ZCf7QF8D59v/tUpICsV6b7A3
 rcH2CHs4ZULR3iHjx4Rq8GCNa5sFmaRHwayaZ+hi6O2QRSKzFaSTkZ5M+ylj3QRsUSmEBw7pX5b
 PTSoo/QcquacNnURuGQ==
X-Proofpoint-GUID: aWkXkMQev3eeknIYWYya2MJD1aKUsiIT
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a326d6c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=1XR5bUzyU_lZOmb26nMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170092

Support the subfunctions CPACF_KMC_PAES_128, CPACF_KMC_PAES_192
and CPACF_KMC_PAES_256 for the cpacf kmc instruction.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
---
 target/s390x/gen-features.c      |   3 +
 target/s390x/tcg/cpacf.h         |   4 ++
 target/s390x/tcg/cpacf_aes.c     | 109 +++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |   7 ++
 4 files changed, 123 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 71e0e41d6e..074c53aecd 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -932,6 +932,9 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KMC_AES_128,
     S390_FEAT_KMC_AES_192,
     S390_FEAT_KMC_AES_256,
+    S390_FEAT_KMC_EAES_128,
+    S390_FEAT_KMC_EAES_192,
+    S390_FEAT_KMC_EAES_256,
     S390_FEAT_KMCTR_AES_128,
     S390_FEAT_KMCTR_AES_192,
     S390_FEAT_KMCTR_AES_256,
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 7cf739e7a4..e302c17a2f 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -44,5 +44,9 @@ int cpacf_paes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint64_t param_addr, uint64_t *dst_ptr_reg,
                    uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                    uint32_t type, uint8_t fc, uint8_t mod);
+int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint64_t *dst_ptr_reg,
+                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                   uint32_t type, uint8_t fc, uint8_t mod);
 
 #endif
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index bcfcf3b660..a6487261e1 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -620,3 +620,112 @@ int cpacf_paes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return !len ? 0 : 3;
 }
+
+int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint64_t *dst_ptr_reg,
+                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                   uint32_t type, uint8_t fc, uint8_t mod)
+{
+    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
+    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
+    uint8_t key[32], wkvp[32], iv[AES_BLOCK_SIZE];
+    uint64_t addr, len = *src_len_reg, done = 0;
+    int i, keysize, addr_reg_size = 64;
+    AES_KEY exkey;
+
+    g_assert(type == S390_FEAT_TYPE_KMC);
+
+    switch (fc) {
+    case 0x1a: /* CPACF_KMC_PAES_128 */
+        keysize = 16;
+        break;
+    case 0x1b: /* CPACF_KMC_PAES_192 */
+        keysize = 24;
+        break;
+    case 0x1c: /* CPACF_KMC_PAES_256 */
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
+        addr = wrap_address(env, param_addr + AES_BLOCK_SIZE + keysize + i);
+        wkvp[i] = cpu_ldb_mmu(env, addr, oi, ra);
+    }
+    if (memcmp(wkvp, protkey_wkvp, sizeof(wkvp))) {
+        /* wkvp mismatch -> return with cc 1 */
+        return 1;
+    }
+
+    /* fetch iv from param block */
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        addr = wrap_address(env, param_addr + i);
+        iv[i] = cpu_ldb_mmu(env, addr, oi, ra);
+    }
+
+    /* fetch protected key from param block */
+    for (i = 0; i < keysize; i++) {
+        addr = wrap_address(env, param_addr + AES_BLOCK_SIZE + i);
+        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
+    }
+    /* 'decrypt' the protected key */
+    for (i = 0; i < keysize; i++) {
+        key[i] ^= protkey_xor_pattern[i];
+    }
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
+            /* decrypt in => buf */
+            AES_decrypt(in, buf, &exkey);
+            /* buf xor iv => out */
+            aes_xor(buf, iv, out);
+            /* prep iv for next round */
+            memcpy(iv, in, AES_BLOCK_SIZE);
+        } else {
+            /* in xor iv => buf */
+            aes_xor(in, iv, buf);
+            /* encrypt buf => out */
+            AES_encrypt(buf, out, &exkey);
+            /* prep iv for next round */
+            memcpy(iv, out, AES_BLOCK_SIZE);
+        }
+        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
+        len -= AES_BLOCK_SIZE, done += AES_BLOCK_SIZE;
+    }
+
+    /* update iv in param block */
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        addr = wrap_address(env, param_addr + i);
+        cpu_stb_mmu(env, addr, iv[i], oi, ra);
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
index 988226338d..3fc48bc9a1 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -137,6 +137,13 @@ static int cpacf_kmc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
                            S390_FEAT_TYPE_KMC, fc, mod);
         break;
+    case 0x1a: /* CPACF_KMC_PAES_128 */
+    case 0x1b: /* CPACF_KMC_PAES_192 */
+    case 0x1c: /* CPACF_KMC_PAES_256 */
+        rc = cpacf_paes_cbc(env, mmu_idx, ra, env->regs[1],
+                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
+                            S390_FEAT_TYPE_KMC, fc, mod);
+        break;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0

