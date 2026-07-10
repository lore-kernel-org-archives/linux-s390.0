Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385CA3C3C0E
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783697367; cv=none; b=IrUOMbAxN4xAgu5MsxLuSzPm12o6OJzp6e5Bl7Ig+ckb5zWVUuw7zzzPLESPH8C24MlXonToF1PJgiY6ym1D9oGu+SdrzXUQuzrEv9VTNzYK0sGyWFXKNew1kFUtVC7dB9auhUnAHEK8TQRQxm0NaK7foc8FcTP60CiSesDpP8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783697367; c=relaxed/simple;
	bh=6bA6m2HqRxTeUSOcQlJWIeYBCQG4lgvnCfsKdWItuhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4Dp3867+jSLwRW4vOHgLEIwGGpYycniIdHilzCEOe9FDsIXZzFiljwc7lhMFX/vlbFHzcBOPaYglUSNFjlqpXEcohT+XkaKs7+8WM8hW250eKtfa8W/r3HSTaS3QAMiV+Qb5LBJjD0MW33X/TD6f8IBx6O3OfDHym+HMnPgSVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S1rTJShi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S1rTJShi"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AEmjJW1165009;
	Fri, 10 Jul 2026 15:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VlFMWtJDmOSkrtggs
	J5bwp/xaXy5pGmU/zp/zjQDk+Q=; b=S1rTJShiTJ7Ngt0TBK3yoj2vMJ0nPtswT
	/SO+SfboM6xpcS1sodBIs/Dwf1HqD/QtQexggEM0CASzjdgdHVAkYImY16jH/q9p
	KUymZW+xM2/zu8m9MOstu+sVruPQjTS2k84hNEXSBHV1pulwXJvMLHu8PdR7nxbS
	1wj+s1a8kPPnimksXfqFzlI9WO7TWj8OBE3EVTPVR4HFYBH14iIwK2j8yaCqS1oa
	FHbh2Jl/hpth1nZnYnI0/Y9QYQlz1ZVec9avA/nlPYGsqepo4zjkE0Y8qy5uB+C7
	CYuIEeI4XN/ugqBLUfGvoxzVOTchNX2O2VU0a11khG68ChvheMcoQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw57f6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 15:29:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66AFJdKI003153;
	Fri, 10 Jul 2026 15:29:12 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvwjt2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 15:29:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66AFT87659048422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 15:29:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5EE720040;
	Fri, 10 Jul 2026 15:29:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF2DD2004D;
	Fri, 10 Jul 2026 15:29:08 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.196.135])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 15:29:08 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v12 07/17] target/s390x: Support AES CTR for cpacf kmctr instruction
Date: Fri, 10 Jul 2026 17:28:53 +0200
Message-ID: <20260710152906.80207-8-freude@linux.ibm.com>
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
X-Proofpoint-GUID: 3ATEQ3fmkWyaOnupf3i4dzAYIhj53tkj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE1MyBTYWx0ZWRfX5FqCWiunAgit
 XzBxrjk86Yhbki45hB9p1sk+MXf2EnzQkPsuN2gpLIGaAXf4ZVdsy7u1lI7JHQhnRrK1KJThmdQ
 wCX7n1COqsUjLaI2v6dKvCmAykRFpFKTET00T8f6WC60WWgHxjYg9n6mVoOTUe6BLkkuxLFspRa
 lNPEpult/ax6yjmCrCGnhDDBX0gAwlu27tkEwZrZN5FXsuOh7278EcXkToyiLhI3hExAfX8D2Xl
 VeHCbLzRx8l2KmrNH6zoQG4y76aD5igxiytyhvljEZNLOOtl0wYFjXX0tZEmNAHRzIhpT7tcxhP
 zhpqHNHUExgwXRg0C7V8Td9kBzy28quR+sSuMb71p3yoPUFYceY8vNbFN1m04x6X8pfATSYzsWs
 7pZTP7O96rfQLYguXp+4eYnnGH4NWQws1j+7fw58ze/v87az7bkcZMQTjHH2PaFJhnAslOvFV+b
 HbwPrdmxewY3kanRZbg==
X-Proofpoint-ORIG-GUID: 3ATEQ3fmkWyaOnupf3i4dzAYIhj53tkj
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a510fca cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=LQnWXxm1RwZjr7XDrSkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE1MyBTYWx0ZWRfXzeiTNTF2SUFK
 4wZm1OJedRcMWqZYzu76aJLbHN7AHYjADkCYerH9bGBC7tZ0E8IU/Zl+Ws0ehzl8UMfScfl1Qdj
 XrX/3UlGaKSDKcV9id1K/CCSq3JMTEg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100153

Support the subfunctions CPACF_KMCTR_AES_128, CPACF_KMCTR_AES_192
and CPACF_KMCTR_AES_256 for the cpacf kmctr instruction.

Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/gen-features.c      |  3 ++
 target/s390x/tcg/cpacf.h         |  5 +++
 target/s390x/tcg/cpacf_aes.c     | 70 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c | 24 +++++++++++
 4 files changed, 102 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 2dacc65995..3281037958 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -928,6 +928,9 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KMC_AES_128,
     S390_FEAT_KMC_AES_192,
     S390_FEAT_KMC_AES_256,
+    S390_FEAT_KMCTR_AES_128,
+    S390_FEAT_KMCTR_AES_192,
+    S390_FEAT_KMCTR_AES_256,
 };
 
 /****** END FEATURE DEFS ******/
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index df6e3262d3..4af7bc753c 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -242,5 +242,10 @@ int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t param_addr, uint64_t *dst_ptr_reg,
                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                   uint32_t type, uint8_t fc, uint8_t mod);
+int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                  uint64_t param_addr, uint64_t *dst_ptr_reg,
+                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                  uint64_t *ctr_ptr_reg, uint32_t type,
+                  uint8_t fc, uint8_t mod);
 
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 7b6d133bec..7deb1a3fd2 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -213,3 +213,73 @@ int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return !len ? 0 : 3;
 }
+
+int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                  uint64_t param_addr, uint64_t *dst_ptr_reg,
+                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                  uint64_t *ctr_ptr_reg, uint32_t type,
+                  uint8_t fc, uint8_t mod)
+{
+    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
+    uint64_t len = *src_len_reg, done = 0;
+    uint8_t ctr[AES_BLOCK_SIZE], key[32];
+    int i, keysize, addr_reg_size = 64;
+    AES_KEY exkey;
+
+    g_assert(type == S390_FEAT_TYPE_KMCTR);
+
+    switch (fc) {
+    case CPACF_KMCTR_AES_128:
+        keysize = 16;
+        break;
+    case CPACF_KMCTR_AES_192:
+        keysize = 24;
+        break;
+    case CPACF_KMCTR_AES_256:
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
+    copy_from_guest_wrap(env, mmu_idx, ra, param_addr, key, keysize);
+
+    /* expand key */
+    AES_set_encrypt_key(key, keysize * 8, &exkey);
+
+    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
+    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
+        /* read in nonce/ctr => ctr */
+        aes_read_block(env, mmu_idx, ra, *ctr_ptr_reg + done, ctr);
+        /* read in one block of input data => in */
+        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
+        /* encrypt ctr and xor with in => out */
+        AES_ctr_encrypt(in, out, ctr, &exkey);
+        /* write out the processed block */
+        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
+        len -= AES_BLOCK_SIZE;
+        done += AES_BLOCK_SIZE;
+    }
+
+    *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
+                             *src_ptr_reg + done);
+    *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
+                             *dst_ptr_reg + done);
+    *ctr_ptr_reg = deposit64(*ctr_ptr_reg, 0, addr_reg_size,
+                             *ctr_ptr_reg + done);
+    *src_len_reg -= done;
+
+    return !len ? 0 : 3;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 1fe1d7157b..9be8a14a80 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -131,6 +131,27 @@ static int cpacf_kmc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     return rc;
 }
 
+static int cpacf_kmctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                       uint32_t r1, uint32_t r2, uint32_t r3,
+                       uint8_t fc, uint8_t mod)
+{
+    int rc = 0;
+
+    switch (fc) {
+    case CPACF_KMCTR_AES_128:
+    case CPACF_KMCTR_AES_192:
+    case CPACF_KMCTR_AES_256:
+        rc = cpacf_aes_ctr(env, mmu_idx, ra, env->regs[1],
+                           &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
+                           &env->regs[r3], S390_FEAT_TYPE_KMCTR, fc, mod);
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
@@ -201,6 +222,9 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     case S390_FEAT_TYPE_KMC:
         rc = cpacf_kmc(env, mmu_idx, ra, r1, r2, r3, fc, mod);
         break;
+    case S390_FEAT_TYPE_KMCTR:
+        rc = cpacf_kmctr(env, mmu_idx, ra, r1, r2, r3, fc, mod);
+        break;
     case S390_FEAT_TYPE_PPNO:
         rc = cpacf_ppno(env, mmu_idx, ra, r1, r2, r3, fc);
         break;
-- 
2.43.0

