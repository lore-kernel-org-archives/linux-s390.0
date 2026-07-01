Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4538D372665
	for <linux-s390@vger.kernel.org>; Wed,  1 Jul 2026 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924437; cv=none; b=f4AozMbZlNv4M4wSu4ETR4M048fYO6Icb/aJuSdxEaZxFtMZVcTscuCn33VPmZISnciJgTgZDTi/dpI3Uh6AR5ewDszRBtvRex48hs2JhaKZwN89K4l3bFrre+eYVMxmHlqXN17FEPalXcEyAkQ3GM8TIrntNLj5oExLyLWhVNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924437; c=relaxed/simple;
	bh=Mob0ScFRnTv4kjZI31jUQNHPew3t2hVUWLJu8snEvN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXXJJFD2ow1rQW9LQGo6yJgs1y2aTMsVOZCovB87X7JN8nmWYjeK1IZmFJuPSeTXLNo/LD2X6QQQFZvw/uhzMsh4Qet29suSsNYh7smZnksizlqHg1FRavWTxG60dkOkAglAEU7MmfT60UUAIkr2zXH08JxdhszfItGEbgUHny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HoCTDrD2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HoCTDrD2"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661AIagu551454;
	Wed, 1 Jul 2026 16:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5LBOX/J+l5c2FVyRr
	gtLWBGZM+2t3/9Oo6ByW74VPus=; b=HoCTDrD2Ribuji3jnDVtZvM+S4T+U+mtc
	FQLFJMqGZIRwJQP5Rwu5Wbz7MsHVDKbmbfTXEoVQn2B2dLPAGGKwW3llbUtxJ2UK
	mAFcfA9ar3b80NUcjovkuDiYwkPD1iIVa39ru0kpsR04r6Y+QK0PtyxmIKHQBnjw
	yUCwyqGMaIxxasZX4xyPI55ZxZ67v16ucRHArqih711JFFOFa2Kp/0KjzKWMp7HU
	0F0aW8TGV7hVTIHvAG5/2/LcRWiwrmw4OcGGhQ8Eq+jh9a/FonQ/34zH1+4mHXP9
	+Zd5DK8EYEUnC4BcZ4AHT/dmgo0MrJ3FvxJQaQ3ayUkml9gg1utLw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5wmjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 16:47:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661GYgAZ010790;
	Wed, 1 Jul 2026 16:46:59 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2suk863r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 16:46:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 661GktvW47055316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 16:46:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2824C2004E;
	Wed,  1 Jul 2026 16:46:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 041572004B;
	Wed,  1 Jul 2026 16:46:55 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.187.249])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 16:46:54 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v9 16/21] target/s390x: Support protected key AES XTS for cpacf km instruction
Date: Wed,  1 Jul 2026 18:46:39 +0200
Message-ID: <20260701164650.95760-17-freude@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE3MyBTYWx0ZWRfX6sgs+GHERXP1
 SLMtQXZ8qYmD1jGSLtI8iVWdzgtcaOq8BXwZA2vL7Pjr6nrBCc+DpmBMlIcxqJoiVcbH5pinl4z
 3H8p3RQqL0oK1BcMNgj7daY2H5zrPkaNBkWuR+7f3QUDhNWe48XkE3PaV05YjqctEHnrWnJxgxT
 u+LGkXVCuTOsf6StbMrOOTVcxknAR1cd2QoOLaGQqmasjo6M3IE9COKskpXvWQI4Y1Nw7VuK3Rs
 R7j18C8sm5S0mP8oWo62FCanUZR6bAvgg/vq3WtC5SNig0oI1FYc9KlGmCy+6v26T3dg4YgzTEq
 aLtFhvfhxC91RyRC+CW6kUPQUalQyXA86kVKWoPDt6VbdfXmWv1L+774W0+JuQ5Im5gk4Bnh2tL
 1cCxm2teNIBL43Ms4L3KLssDvjqNKovo5NLgEdlon9kaOAEePr5AbAe+kYMoDeV9jikvdWiOa19
 T4iFRnBZkicrAiy3jEA==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a454484 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=_Jmc02WdQjUAVPbgbKgA:9
X-Proofpoint-ORIG-GUID: X6J1B82ZtSNp5cKQoo5g6q0XQ6TqMuX9
X-Proofpoint-GUID: X6J1B82ZtSNp5cKQoo5g6q0XQ6TqMuX9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE3MyBTYWx0ZWRfX+Nn3v5cbrh5I
 kkN7p0dLmIRN63nuEpRebZU7kd6E+0a+lJohAUWxwB54Cgh9NJ1kPQ8uLd9dztXOGJ/SfqghQuB
 dhVPKQ7hSTMN5nLsBVjVB2aNkqg1JQI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010173

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

