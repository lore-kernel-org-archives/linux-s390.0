Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C641742A7A9
	for <linux-s390@vger.kernel.org>; Mon,  6 Jul 2026 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331039; cv=none; b=ebDczhTB+2mU/hCZGxeasavGPrssjZgecgwiCSCe1S1+Rdc28goYbp4cyZ9640GdJ/EF/ndqr13nVfXomgCtk46RbMqoR5GI9/ERaccW4AibY+MCAaTRT7wVVGrrfmMUFsdEr7pcIpCiH5/Nj6WpMaZI/ZnhO5NlBqCEcPv4mdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331039; c=relaxed/simple;
	bh=Mob0ScFRnTv4kjZI31jUQNHPew3t2hVUWLJu8snEvN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fcr8D/LkYc4OT23kBKmkNDsqT0PGMKbItC7RkhG+2y78OIDROSkwyP8b0JhkSnjtDa/dO8n+Us1mxJyGSnscA9xXwVvU//ponKw4d6vv1zH/sazR3g6Nc89l/bNR3tJSK6mTGHwpDSIcnyAMlTHOb1KxIMLt6WjLuM3vqBGns2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lk/PN+yW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lk/PN+yW"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6669IDFd3890018;
	Mon, 6 Jul 2026 09:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5LBOX/J+l5c2FVyRr
	gtLWBGZM+2t3/9Oo6ByW74VPus=; b=Lk/PN+yWVO6bbVRsPTiCz4Qk1pi8IKsDd
	axFxHXFj5QCwORJVIz+nThHsXapzr/nrkbyQjDxSkj/MEFr3panUOmmBrYIj8mCv
	jq17wnhpUk5EjgYz/+UP3PbWF0jjHImXh157HlzCkchDvCQvPgt9Aq+5naGIqyw/
	cCdcM9VfsAP2kPDG4xak3LKT96JTQ6qwoth/hQXr5ArwUj1LoVZwH9MQ1Ij6xO2D
	5f9TsuFFZ/f/9ekGXHaQ6+W11YaPeijbiAbvIm5mW7WUfEZMifo0tQ36wahu4m3h
	AxeKqsyCLy4O5mzlrze72ONo+T4QBYI4yF2rhGEcHq5pF9wCo9d2w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3gsqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 09:43:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6669YeQ6028347;
	Mon, 6 Jul 2026 09:43:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgjw0gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 09:43:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6669hJac54722918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 09:43:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 263002004B;
	Mon,  6 Jul 2026 09:43:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED3CA20043;
	Mon,  6 Jul 2026 09:43:18 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.193.81])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 09:43:18 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v10 16/21] target/s390x: Support protected key AES XTS for cpacf km instruction
Date: Mon,  6 Jul 2026 11:43:09 +0200
Message-ID: <20260706094317.17032-17-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706094317.17032-1-freude@linux.ibm.com>
References: <20260706094317.17032-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4b78bc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=_Jmc02WdQjUAVPbgbKgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5NCBTYWx0ZWRfXxSHd4a2d03Ph
 Oi5ke/wKa74I5vohf5koRuGMQtd3rzVjBR7w58bhBAC4DqTvkcWsSbUOcKt6bkI5TRISwQ4oIaK
 +1IjhNHH68f4EWDbV6dcnDMoVh7Hc+k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5NCBTYWx0ZWRfX9sO6jxc3WV/L
 B02jWJD+w7PyASwl5CNnL6kzGrV+lwzK9K1dyXnpGLvSO1hJtdT1YyjfiD6yPYOdqQf0sV3GbNf
 XSetIwrBYAZQ58QIzUvqfAKS9bfQ87XXsYBEHNbslVMIneKxPMOfx1vUPhj8id5iPQTvNk/NgoO
 NgoNjay3xjFPUxgta6cgKM+IOTdZfZGd3hVvGnHwurND1P9yqDOVpefSBx1JA9h9NuN3YGHx1TE
 WUnMuQItOaXHSjYhlZIz53CeynRmOSFheRkQj9cb84YsofZbXf6LPhFzDc7tDYQiPJJH6JOknVG
 1cC5AiKLqs0nho/f1PeYt/u4NloZUgaRjJqb99wpfS71/KkGla3+Kc5yyRVR6atHhJqx2ylUvhp
 hViXIGmR9+Gr4uBgPrquZZxcOIgMbOmd3xfQdj4oRriU78S7U1sjl7omYOjErjX0PnPNiAwp3tn
 Y0YXVboEhas5ftoPKkQ==
X-Proofpoint-ORIG-GUID: UOjANTV_Lbfus0_O56S8MLMIoiZIEx0I
X-Proofpoint-GUID: UOjANTV_Lbfus0_O56S8MLMIoiZIEx0I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060094

Support the subfunctions CPACF_KM_PXTS_128 and CPACF_KM_PXTS_256
for the cpacf km instruction.

Tested-by: Holger Dengler <dengler@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/gen-features.c      |   2 +
 target/s390x/tcg/cpacf.h         |   4 ++
 target/s390x/tcg/cpacf_aes.c     | 105 +++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |   6 ++
 4 files changed, 117 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 126bacb281..c4c59c3504 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -929,6 +929,8 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KM_EAES_256,
     S390_FEAT_KM_XTS_AES_128,
     S390_FEAT_KM_XTS_AES_256,
+    S390_FEAT_KM_XTS_EAES_128,
+    S390_FEAT_KM_XTS_EAES_256,
     S390_FEAT_KMC_AES_128,
     S390_FEAT_KMC_AES_192,
     S390_FEAT_KMC_AES_256,
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 9dc197388e..b2223b4d64 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -297,5 +297,9 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint8_t fc, uint8_t mod);
 int cpacf_paes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint64_t param_addr, uint8_t fc);
+int cpacf_paes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint64_t *dst_ptr_reg,
+                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                   uint32_t type, uint8_t fc, uint8_t mod);
 
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index df4cd7ae70..0c3cbb29e3 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -905,3 +905,108 @@ int cpacf_paes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return 0;
 }
+
+int cpacf_paes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint64_t *dst_ptr_reg,
+                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                   uint32_t type, uint8_t fc, uint8_t mod)
+{
+    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
+    uint8_t buf1[AES_BLOCK_SIZE], buf2[AES_BLOCK_SIZE];
+    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
+    uint8_t key[32], wkvp[32], tweak[AES_BLOCK_SIZE];
+    uint64_t addr, len = *src_len_reg, done = 0;
+    int i, keysize, addr_reg_size = 64;
+    AES_KEY exkey;
+
+    g_assert(type == S390_FEAT_TYPE_KM);
+
+    switch (fc) {
+    case CPACF_KM_PXTS_128:
+        keysize = 16;
+        break;
+    case CPACF_KM_PXTS_256:
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
+    /* fetch tweak from param block */
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        addr = wrap_address(env, param_addr + keysize + sizeof(wkvp) + i);
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
+        addr = wrap_address(env, param_addr + keysize + sizeof(wkvp) + i);
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
index 5e924b78f5..6172012979 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -116,6 +116,12 @@ static int cpacf_km(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
                            S390_FEAT_TYPE_KM, fc, mod);
         break;
+    case CPACF_KM_PXTS_128:
+    case CPACF_KM_PXTS_256:
+        rc = cpacf_paes_xts(env, mmu_idx, ra, env->regs[1],
+                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
+                            S390_FEAT_TYPE_KM, fc, mod);
+        break;
     default:
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
-- 
2.43.0

