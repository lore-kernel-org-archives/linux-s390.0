Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404B430C637
	for <linux-s390@vger.kernel.org>; Mon,  6 Jul 2026 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331023; cv=none; b=cnJ7Hv4bocR17ZPdHWpy6/QTu1up2ZrT1lbPKHxI2657ywhFKZ90Zd/o4jOO4n1bFHp1i7qBIPwDXP/IYDO5K9NaMj06W01LnaDJ/39Lk6L2btQU3be4xIu2n2N5GpXweFu3CzEOCZBbc2cTukG4xjnJBQZqWPROYLHMLhgnhOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331023; c=relaxed/simple;
	bh=mseI0Bi3GHR8TQOmZpsNkn7oGTsZJIw9yO9Sk6Da+UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UE4jeh9jIRTVlndXS0+zbEj7WE6AdRdlCBK4SY0bS6lMG9yG65GmQXDAyt1Y5dNy5DWXIZwIphQdBLBVOLkQ6wwo32dh7wjND9Nm+/RoNX7xosTdXm+dwMZWRQd3jwd9AquK6ProhY+ppND/R4Ruc4FcBG6eOms09wsYzbnolk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ag9AcoJy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ag9AcoJy"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6669IT6U3826471;
	Mon, 6 Jul 2026 09:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EUxSq0ch+fjod2kbF
	SmYLduJjGhTs+iBHG49KqeoWs0=; b=ag9AcoJyXbgE33MswTcBmAIRqzQjK126K
	6/tkoaNvvbsKJo96A31UDHBELopba2GYiNkVWuKw+AXM+UL6b/6ZdEmi87ahOiSt
	1Y7hY8wVpJuYDdxEaSNRPrB4M5KYF3cQiik/iJQVjxuKiOKBcoZUUqF7Sy6NmZRO
	C/TIkpzI8lF8TycxbzKXJxpEDxnyk9YXrw03zAKfQhQBg3tGHEHQa97VTQrS4l9g
	AA2zOloYDf+tasw1H4adCFu4U8AiFLGvZ9/ETVfaaHKdYoUSeQlbwxi0PiyEtckc
	BlZ4Yn6nZ3Oo3YaoGkbU8u6ATcep51Tc5fA2stBLXM/j/p2LAEXlA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qkn8vjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 09:43:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6669YhfV005904;
	Mon, 6 Jul 2026 09:43:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h4w48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 09:43:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6669hIlU38470024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 09:43:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92D062004B;
	Mon,  6 Jul 2026 09:43:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C96620043;
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
Subject: [PATCH v10 13/21] target/s390x: Support protected key AES CBC for cpacf kmc instruction
Date: Mon,  6 Jul 2026 11:43:06 +0200
Message-ID: <20260706094317.17032-14-freude@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4b78bb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=1XR5bUzyU_lZOmb26nMA:9
X-Proofpoint-GUID: c9SJBVSLJqirDN2ibj2Ut_GVROipuMuy
X-Proofpoint-ORIG-GUID: c9SJBVSLJqirDN2ibj2Ut_GVROipuMuy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5NCBTYWx0ZWRfXyzmkQLFhNjCP
 HFm8vw8GylS1zJt1vR2P3QsN26r+XDaP2uk1mPTHJFgQJpQ3eLXZNdbmD0yFMMhb/R6Ni6e2kh2
 jCFj3jkfheCeuVHE5FDPFKobBXTDlFk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5NCBTYWx0ZWRfXz9BTak8eYb0v
 3SLyaVq7JtmL/7SogpZZyuUM3MRd7KNtqf2VlzXj0rfo6E1qfMw5xJ8FU7CANZzzmI6cvEHswCh
 LeZu9YB3NXyEJyUp3ZVkBSKNKOBG5fctjm0pNs8Z/Y/0hrw5cFozK7/0L4jOk6V3KT0z5q28zLf
 7ilReQ94V/T0WsCO6jWDMHOOP8PQdNreDwEY8ezD7XprczynqitCfvaWDLRLyMP0KuTCNTHVWPf
 D3a9dSpZTFIhGrdJyespNTj1queWgo70uGlReG6nO4xomz5CxgWvodoEIUwf0+udO5ARjxIVZFN
 YQBOu/o11PdYhfSSl70OWIRERAiPN+w4xtu0dHzNGfa6mthPlb28kumhSy2t8zqs7CJ/thWwE7Y
 y33ZXqXKFS8tPr1MlLDFtgw56BiGEDfe/hcvuk1VvT8Y8CpspZ9YGxX6ZNilHNTD6Na6juIcpfN
 5ye+YBjKPkMbfYrrm+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060094

Support the subfunctions CPACF_KMC_PAES_128, CPACF_KMC_PAES_192
and CPACF_KMC_PAES_256 for the cpacf kmc instruction.

Tested-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/gen-features.c      |   3 +
 target/s390x/tcg/cpacf.h         |   4 ++
 target/s390x/tcg/cpacf_aes.c     | 108 +++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |   7 ++
 4 files changed, 122 insertions(+)

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
index cc545fb703..b0d484c3cb 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -286,5 +286,9 @@ int cpacf_paes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint64_t param_addr, uint64_t *dst_ptr_reg,
                    uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                    uint32_t type, uint8_t fc, uint8_t mod);
+int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint64_t *dst_ptr_reg,
+                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                   uint32_t type, uint8_t fc, uint8_t mod);
 
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index b7f1dc99e9..bb3488e38f 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -631,3 +631,111 @@ int cpacf_paes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
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
+    case CPACF_KMC_PAES_128:
+        keysize = 16;
+        break;
+    case CPACF_KMC_PAES_192:
+        keysize = 24;
+        break;
+    case CPACF_KMC_PAES_256:
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
index b00351d8c1..237ce744b7 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -137,6 +137,13 @@ static int cpacf_kmc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
                            S390_FEAT_TYPE_KMC, fc, mod);
         break;
+    case CPACF_KMC_PAES_128:
+    case CPACF_KMC_PAES_192:
+    case CPACF_KMC_PAES_256:
+        rc = cpacf_paes_cbc(env, mmu_idx, ra, env->regs[1],
+                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
+                            S390_FEAT_TYPE_KMC, fc, mod);
+        break;
     default:
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
-- 
2.43.0

