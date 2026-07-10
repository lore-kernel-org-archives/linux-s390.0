Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34253F076F
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783697370; cv=none; b=pBnB31p1QN0MjM6naLJ43CVPErtxlmn+AWNOUsaWsU1tIIdqRWcgPoxKMHIF6dRQmDF63pmjKEiYVik3giroe7gec+48swMKydaMO42dMDmirItdgbMFXI3/JNAtiwTtC3vr4NLJzC9Q5xi46Hy0bPSoujndGZD8ZGqCUU5lK9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783697370; c=relaxed/simple;
	bh=fNLRoLgcdZ4tHYW7SV5onk+9brhzIyFMSVuqJCSITAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=An6MWSipUrldFTR//Vm7NKXvBxopRJH+JPqISQ7VosSmZ1btVQK+wnuRGHIaf1oToI9WGsmUngQ/zoL/aBe+fsqA4QO0VOUy3lF0xHMoVD0DIznaFIe1Njepvr787R61gv0ZzP32npVlD2X842cW8JHcG6N+JdDtROFgFQ4dbD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I0SMXp9h; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I0SMXp9h"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AEmdAJ1164860;
	Fri, 10 Jul 2026 15:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QInrnpVNGRAgYpEnM
	uWrFy7oWjtbqTsnUxXhRdGgCu8=; b=I0SMXp9hCPcvj5QiJWRyttwMbWlb8BSNh
	SiFs2kNCkARIbL3007/4YCeaQRmaxZT5ChwEJCdGi9UaHExvTgdSqU9H2FyIFnnD
	dy+MgOJWiKMzIeDKvfhe4GbAIMkUnKlNuhjit30ZCznbj977QYXtFcVKT8lMYGrM
	V6AY33sIQsgxHzYJsrV4/OAzX565qZJnNZ+z2zgOQthEHske2WIlbQUsXhh3HydA
	UKYFgoo1OfQmNCdok4xyBGv27gqz7ZpksWWQ1UgUeZy0osoPJN690VUKXNh21s26
	tiexcLjBDral9lHAZ4NYiTyJisb+lTo5XisTuEsYLF6+LgXiNhseg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw57f6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 15:29:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66AFJiZI015261;
	Fri, 10 Jul 2026 15:29:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6yj8yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 15:29:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66AFTAuQ48824658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 15:29:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAB9820040;
	Fri, 10 Jul 2026 15:29:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4F2E2004B;
	Fri, 10 Jul 2026 15:29:09 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.196.135])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 15:29:09 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v12 13/17] target/s390x: Support protected key AES CTR for cpacf kmctr instruction
Date: Fri, 10 Jul 2026 17:28:59 +0200
Message-ID: <20260710152906.80207-14-freude@linux.ibm.com>
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
X-Proofpoint-GUID: vPRV6FiHJfUDioWURdvBlP6Vp-rVjrfg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE1MyBTYWx0ZWRfXztP9L/IIdueU
 3JarSJj3GDziKNfHMz81e0cUoOfAFGMA2SUjevYVPEn2euZlYKODeSjrs0IL3fDYRydmTc/sHjf
 GTKe+8fNlkeCis2Bxcjr0Ireew5yuYZUjgwDDWRuhW6XRWZT1rr3sUbXAAc5/wZuSzYB+YRkxz8
 cDoDqVb/Hg+CwGx71905wFwVrOtyXc0Ox8/a4rDot8jdfj4+A5DQQf59qLLbPABPfoijgsR9x3i
 9enrzHVeXghFZDNce8M9l1DVQil2tzUyjLBuC/xXJ80mpLiQW6RIlD5o+Ns49S9Ja5ffAMK0PrU
 dVdkk/8uqyvpUmhj3+VexKByaY5Js2Nam/Ndl7qsSuXoLUPuB/fQCwreaDpkfdA/mteCzEhGW3e
 57y7Rpj9vn110/h0Nc9Uh88W8dp662xDBoUTZRZ5EzRSEsSyTAA+GvpQj7ZZsTun2hBjtVYVvyx
 8Z5CFuMRZYZLMMT5IlQ==
X-Proofpoint-ORIG-GUID: vPRV6FiHJfUDioWURdvBlP6Vp-rVjrfg
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a510fca cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=Ff2AzlR8v_7kNCG2J78A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE1MyBTYWx0ZWRfX0JyBHm9kCg0A
 cHzim0emkFnUwsfOrKpIIb6hG9Ni6NPMEJJ9P79G+kJ4kzhHQkLM3/jtzMyxEsLgNoHvj4jtKCf
 wFiFKnVR2JkR9IvWr76hteQXuKDq6oY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100153

Support the subfunctions CPACF_KMCTR_PAES_128, CPACF_KMCTR_PAES_192
and CPACF_KMCTR_PAES_256 for the cpacf kmctr instruction.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/gen-features.c      |  3 ++
 target/s390x/tcg/cpacf.h         |  5 ++
 target/s390x/tcg/cpacf_aes.c     | 80 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |  7 +++
 4 files changed, 95 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index d1fce9e00c..9898f880a6 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -939,6 +939,9 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KMCTR_AES_128,
     S390_FEAT_KMCTR_AES_192,
     S390_FEAT_KMCTR_AES_256,
+    S390_FEAT_KMCTR_EAES_128,
+    S390_FEAT_KMCTR_EAES_192,
+    S390_FEAT_KMCTR_EAES_256,
     S390_FEAT_PCC_XTS_AES_128,
     S390_FEAT_PCC_XTS_AES_256,
     S390_FEAT_PCKMO_AES_128,
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 8987f8fbc7..71a2c6b914 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -290,5 +290,10 @@ int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint64_t param_addr, uint64_t *dst_ptr_reg,
                    uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                    uint32_t type, uint8_t fc, uint8_t mod);
+int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint64_t *dst_ptr_reg,
+                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                   uint64_t *ctr_ptr_reg, uint32_t type,
+                   uint8_t fc, uint8_t mod);
 
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index b207ebc954..a38f4cdbd4 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -663,3 +663,83 @@ int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return !len ? 0 : 3;
 }
+
+int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint64_t *dst_ptr_reg,
+                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                   uint64_t *ctr_ptr_reg, uint32_t type,
+                   uint8_t fc, uint8_t mod)
+{
+    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
+    uint8_t ctr[AES_BLOCK_SIZE], key[32], wkvp[32];
+    uint64_t len = *src_len_reg, done = 0;
+    int i, keysize, addr_reg_size = 64;
+    AES_KEY exkey;
+
+    g_assert(type == S390_FEAT_TYPE_KMCTR);
+
+    switch (fc) {
+    case CPACF_KMCTR_PAES_128:
+        keysize = 16;
+        break;
+    case CPACF_KMCTR_PAES_192:
+        keysize = 24;
+        break;
+    case CPACF_KMCTR_PAES_256:
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
+    copy_from_guest_wrap(env, mmu_idx, ra,
+                         param_addr + keysize, wkvp, sizeof(wkvp));
+    if (memcmp(wkvp, protkey_wkvp, sizeof(wkvp))) {
+        /* wkvp mismatch -> return with cc 1 */
+        return 1;
+    }
+
+    /* fetch protected key from param block */
+    copy_from_guest_wrap(env, mmu_idx, ra, param_addr, key, keysize);
+    /* decrypt the protected key */
+    decrypt_protkey(key, keysize);
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
index 237ce744b7..73b2a6557c 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -165,6 +165,13 @@ static int cpacf_kmctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
                            &env->regs[r3], S390_FEAT_TYPE_KMCTR, fc, mod);
         break;
+    case CPACF_KMCTR_PAES_128:
+    case CPACF_KMCTR_PAES_192:
+    case CPACF_KMCTR_PAES_256:
+        rc = cpacf_paes_ctr(env, mmu_idx, ra, env->regs[1],
+                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
+                            &env->regs[r3], S390_FEAT_TYPE_KMCTR, fc, mod);
+        break;
     default:
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
-- 
2.43.0

