Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC343BFE25
	for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689720; cv=none; b=MeRHy2XM+1hwaaD4Z9P7WhJyuwi6qqbv9DhwMpFYA+c/r7M/ZxyFblPmAeQ8qfdLXMNSYkk0d22gI+ABaSXF+pGLnvBoVyAE7khWexivsKYmj3jJRI70tUY20QjIOkHZaH2p0iL29YcSupBX8b2mhRbm415jeAF+KecMT4OaNAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689720; c=relaxed/simple;
	bh=4+KvJcm+Q2lg2njscMkRl/sqh+KUWz9Nq9tSiJ2iqmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vvx/0GOFRBnLyIDb76k8ctTMOYVSGWeHtfwz6FU0nTNDso6wFDErOjDxqswjR9bd2OP9OkauGkIn+W55GM4mEqC0sjesUimU0WS1RsskCUPeOgNDH6hdHWr3b8t24Vweg5swex5cTML7ai6QcemRHwoazlTYDCvS4bEVNJgq8CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HffdFnvF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HffdFnvF"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8mQT44041213;
	Wed, 17 Jun 2026 09:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Qp2TxYo1HJc1FR7ji
	AzWmbFxd9yeN+gKCgOOZSVsAc8=; b=HffdFnvFPelsdr2RbXRH3WgM5RWkOMCr8
	zc59+aAWdI9ld7ZgwV/OFvk/GSkyMfs8mr8sc2nprbSdmMLZuOqjQETlX10sMplz
	aXE9mYmANs1QKtA3W+5Ng4Iw9SuCx+YIaLV1ivpo785tXjlWYVtEybpNTLLFh4Y/
	UyZK2KlTTjFr/RS4tPQQmqiGZCehc+088lOnZpfWeZvOFhZlra7ER76hxG3/BVww
	DQb00BRY0mPmyMJysQ45eCWUzEGCFzmhcwfBgxIrIH+COUcdkSkBQaoIvmwX/oB7
	1Dd9pck5cY1xa/4WXYArm4o7qPJ6T4TndQ0U56w1Mxez2Zu+40kYQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxa7xh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 09:48:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H9YacE021530;
	Wed, 17 Jun 2026 09:48:27 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eudva2h5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 09:48:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65H9mNNA40305130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2026 09:48:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BED820043;
	Wed, 17 Jun 2026 09:48:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 304C72004F;
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
Subject: [PATCH v7 10/17] target/s390x: Support protected key AES ECB for cpacf km instruction
Date: Wed, 17 Jun 2026 11:48:13 +0200
Message-ID: <20260617094820.34402-11-freude@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=OcSoyBTY c=1 sm=1 tr=0 ts=6a326d6c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=kMBD09bGjcw6kBLitfwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5MiBTYWx0ZWRfX4AD66IgaJAK5
 ZSdVkToqYpsjiwLFuf6A9i+GKX5fQEzKFtM2Vr9eIW//t91LlDORiOX1AhHFgJU9rkdpQV2ZHKf
 4Z2NA0w3msLtj0ipWn4JoNExGPz8mRCv4l9tHSEkt5T9+a9Z3wmow1GW7M9SqfSYex9u7iyv5g7
 YAb/6BMqDualots26id/ewZq30wP4azoKSV+9WhK/QYrfpeY1DGP2a2NkTF7A5fFDwU/AiWxlv2
 16pJpd+rR4q+BsSzpwBT65HR1zspPhYPwJns2NEF0y2vQ6yvAjYnppJnksH9mc5J2+TIUyhXat/
 I/uCFZA2+6JBFS15fxVzrtBzW+hHetYPDfz3XMy0sy58tAhquMHjwSup+U7958v2TA9tH0UlNyz
 YTNpKnYLh8wYa/IJtJUYV/dG3cXxoNI6iw3pk8LZt9D4kRHmgbqV4y2u1k3nH1PrO1XMPoofqR7
 pMJJK7hTWxLFbUaZD0A==
X-Proofpoint-GUID: UGzNMQWcKigWzx_IelduVX4L4uoO1wxO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5MiBTYWx0ZWRfX+KmCvIAidAFH
 5rhHdfUieB9Oezgo+ZDVHJF7lgFYRLTy/QzZCIpXo8Z/RQuCxL1kY+jnQdmEyXcdXtTI81TAih+
 0qiRj9jpF2THnt33C/M0UXvjGx+MqM4=
X-Proofpoint-ORIG-GUID: UGzNMQWcKigWzx_IelduVX4L4uoO1wxO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170092

Support the subfunctions CPACF_KM_PAES_128, CPACF_KM_PAES_192
and CPACF_KM_PAES_256 for the cpacf km instruction.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
---
 target/s390x/gen-features.c      |  3 ++
 target/s390x/tcg/cpacf.h         |  4 ++
 target/s390x/tcg/cpacf_aes.c     | 87 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |  7 +++
 4 files changed, 101 insertions(+)

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
index 5588e2bdec..7cf739e7a4 100644
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
 
 #endif
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 5a0a3473d5..bcfcf3b660 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -533,3 +533,90 @@ int cpacf_aes_pckmo(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
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
index e1952ae4bc..988226338d 100644
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

