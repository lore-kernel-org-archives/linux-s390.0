Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC804433BD4
	for <linux-s390@vger.kernel.org>; Tue,  7 Jul 2026 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441114; cv=none; b=F3wJ3AXEVZ5tqThdPBRqd7Dbzf6FNzzdi0T04egbBkUU+r1YsR5Hy8QXEJLnoBbIMoQR0Lz5I/nlEwZM339HzV5HMHDqmkXbNvLwFUOxn7c8g7L60svXVeUGGYBlTWoPBYZmqmnAH3BI8JPc405kZmPoY8Ji8hLoI08iCFrINww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441114; c=relaxed/simple;
	bh=CJLxMZKtFQ7um0lWJOUyJxTEAkb3KIFc1lbWAUyPIqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvrFsYSO8hculzYyv4Fh031Yr28I8gNgoQLFtRrXi7y7GkkK1I+Vqvtaaqnwpti3sa4S7djw9rDg+or1jaJpHLNheWjHFpJLQxs1253VR15fjDWSFZYXE/G8S8cSOhLkk9fqzzouK7AwFRvNVsd6UDS/NHR3BCaeeMJxisj7Llw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K74pT1kM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K74pT1kM"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667FmM3v310140;
	Tue, 7 Jul 2026 16:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9Jjgs43Kw1MDgkTOo
	+lI0hsmG1LB/gFo3fZ00JkAHb0=; b=K74pT1kMRBY2QGj2wX+/b9vbXAEt2/MRU
	wGKaebXQIrOQqXlUkRZM7wHeMzNBeGgp3L9HHNmy2/5A/iclQFsD9q/nrgWZOwsE
	tIVtZp/xLr2v1aMLNYo9xIqIxUm2zNVyVTWny8XU/OR3TKTivkpebhkvJQSOeFRQ
	XyNTVkm27Bbdck0sgcf6gYXZ8xRJmJgwhsReZ0EqlHCChMelEd2+iaGLL9Uly/6w
	qa9mMDdz4Fc7yZyDCiVvEb5lBgttKjfopl0FzfLLH7ZqQhamBSLN8KtJqfyyecQX
	adNYR41MkLhuwUU1oUD+1Xf+scamXym1ZryrdkR2T+9RnS1v5y1Gg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqqw2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 16:18:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667G4dkY018739;
	Tue, 7 Jul 2026 16:18:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqg3cyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 16:18:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 667GIFoE44237074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 16:18:15 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41BD420040;
	Tue,  7 Jul 2026 16:18:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CFDA2004B;
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
Subject: [PATCH v11 06/21] target/s390x: Support AES CBC for cpacf kmc instruction
Date: Tue,  7 Jul 2026 18:17:53 +0200
Message-ID: <20260707161815.40919-7-freude@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE2MCBTYWx0ZWRfX3NHuIWvFnGTV
 PTYAIuxOGK13xr+zmK9O0Mm3yaWDAiGkwxmAnC0ptTQsH4mqDxSSaqRYQL01krsza5ZTKUP1exI
 48zosKH4D/Ntsb3EYoY4L04q/4XPdF8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE2MCBTYWx0ZWRfX20MsSFCS96Ed
 QAmyZphiptC0m9d0/tiWOlrYAF5O35ExztbTl+ttNJ9DMraGmV0njHlIysoGqwNmpZP17i+ISlf
 htBLiLiK3yS5nj2wsQ30dpmpu7SweCRj31Liifds8VDUbO770PV8ByubFJtoT2566oAtSEeSivE
 mVuQsaGl+a8Ef/6tfnOzvWGX0YshHIjYysrpQcd7pjwIhVuwAxFkIsywVHH79EWknJOzjEYx9hH
 G0Hv5GssRct6nWc4u4xdxegTZMxcug4oE6YxOPcf1YBxjdIAq/yFBCYUHwoRilHga04Mj7t0FIc
 E7XPgErZem2e9EbUHL+cZTpsYh5P7DmiI1hZh2HAqojkc5/HDQyWeTDlC9pZsyJ4dAbyBq4oDWt
 P+StXn1rRoQGOdmSuFP0yeIGuflDvFOhasw6bZ2DCVQGROVQ7Ced+EVgldVj8wN/FeSzwP8lXKu
 BAlbGjhkrjX+GZcdK/A==
X-Proofpoint-GUID: XZ2znX01Lf5o_mQJHAaOBMi-1ooul5PT
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4d26cb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=4s_zGP7M7QCs5o7xjogA:9
X-Proofpoint-ORIG-GUID: XZ2znX01Lf5o_mQJHAaOBMi-1ooul5PT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070160

Support the subfunctions CPACF_KMC_AES_128, CPACF_KMC_AES_192
and CPACF_KMC_AES_256 for the cpacf kmc instruction.

Tested-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/gen-features.c      |   3 +
 target/s390x/tcg/cpacf.h         |   4 ++
 target/s390x/tcg/cpacf_aes.c     | 103 +++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |  24 +++++++
 4 files changed, 134 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index a35d1fd2f9..9c0c0b229f 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -924,6 +924,9 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KM_AES_128,
     S390_FEAT_KM_AES_192,
     S390_FEAT_KM_AES_256,
+    S390_FEAT_KMC_AES_128,
+    S390_FEAT_KMC_AES_192,
+    S390_FEAT_KMC_AES_256,
 };
 
 /****** END FEATURE DEFS ******/
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index cee393cdc0..df6e3262d3 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -238,5 +238,9 @@ int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t param_addr, uint64_t *dst_ptr_reg,
                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                   uint32_t type, uint8_t fc, uint8_t mod);
+int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                  uint64_t param_addr, uint64_t *dst_ptr_reg,
+                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                  uint32_t type, uint8_t fc, uint8_t mod);
 
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 7a2f555855..5b4130a19e 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -109,3 +109,106 @@ int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return !len ? 0 : 3;
 }
+
+static void aes_xor(const uint8_t *src1, const uint8_t *src2, uint8_t *dst)
+{
+    for (int i = 0; i < AES_BLOCK_SIZE; i++) {
+        dst[i] = src1[i] ^ src2[i];
+    }
+}
+
+int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                  uint64_t param_addr, uint64_t *dst_ptr_reg,
+                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                  uint32_t type, uint8_t fc, uint8_t mod)
+{
+    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
+    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
+    uint64_t addr, len = *src_len_reg, done = 0;
+    int i, keysize, addr_reg_size = 64;
+    uint8_t key[32], iv[AES_BLOCK_SIZE];
+    AES_KEY exkey;
+
+    g_assert(type == S390_FEAT_TYPE_KMC);
+
+    switch (fc) {
+    case CPACF_KMC_AES_128:
+        keysize = 16;
+        break;
+    case CPACF_KMC_AES_192:
+        keysize = 24;
+        break;
+    case CPACF_KMC_AES_256:
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
+    /* fetch iv from param block */
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        addr = wrap_address(env, param_addr + i);
+        iv[i] = cpu_ldb_mmu(env, addr, oi, ra);
+    }
+
+    /* fetch key from param block */
+    for (i = 0; i < keysize; i++) {
+        addr = wrap_address(env, param_addr + AES_BLOCK_SIZE + i);
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
+        len -= AES_BLOCK_SIZE;
+        done += AES_BLOCK_SIZE;
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
index 3907b9748c..1fe1d7157b 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -110,6 +110,27 @@ static int cpacf_km(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     return rc;
 }
 
+static int cpacf_kmc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                     uint32_t r1, uint32_t r2, uint32_t r3,
+                     uint8_t fc, uint8_t mod)
+{
+    int rc = 0;
+
+    switch (fc) {
+    case CPACF_KMC_AES_128:
+    case CPACF_KMC_AES_192:
+    case CPACF_KMC_AES_256:
+        rc = cpacf_aes_cbc(env, mmu_idx, ra, env->regs[1],
+                           &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
+                           S390_FEAT_TYPE_KMC, fc, mod);
+        break;
+    default:
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    return rc;
+}
+
 static int cpacf_ppno(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                       uint32_t r1, uint32_t r2, uint32_t r3, uint8_t fc)
 {
@@ -177,6 +198,9 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     case S390_FEAT_TYPE_KM:
         rc = cpacf_km(env, mmu_idx, ra, r1, r2, r3, fc, mod);
         break;
+    case S390_FEAT_TYPE_KMC:
+        rc = cpacf_kmc(env, mmu_idx, ra, r1, r2, r3, fc, mod);
+        break;
     case S390_FEAT_TYPE_PPNO:
         rc = cpacf_ppno(env, mmu_idx, ra, r1, r2, r3, fc);
         break;
-- 
2.43.0

