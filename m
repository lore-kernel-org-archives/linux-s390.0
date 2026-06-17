Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F073A3CB2C7
	for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689719; cv=none; b=qFr+IYlriDBznnPHmgB91Ibo3TDYBjWZwkU0UsLB+K+FlwAbcX6UQRmc6k4INm5TbyUCpQOe6qa/OT21d7LpuJfrt1SxoYEbwSlkyRSyJyD98fHBsEGjb1T4w/Se91r2ay7Zb6Emsmt7aKIola/3/4QRJr9mIIJ3COvEvfAFJjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689719; c=relaxed/simple;
	bh=f5/QXeoMyPcjtBIOOCduczqkIpCHG//F692n9iIggo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDf+fcuFOMBh1ce52+ZF6GqVOC23mHeUgLMbm4jzV6CowDTLwmoeX0umaCZYUYwFlpoxLj7asM99wqwdn6/h2C7VQtT+mONDTVd9ttsswSBV4+rMcK0c2WAERgb7E4aPKFbmcmj6V5LFFhqMBa2wJy8aXiGXthALTvLTJBkVWzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nuUk4WvY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nuUk4WvY"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8mlGL4003754;
	Wed, 17 Jun 2026 09:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zSZ3VjdOEdZm4Cy5E
	7lbwQx6q36NPD32dnucX3IJVVU=; b=nuUk4WvY57Er82boYElG8zuWbGzVBvJaP
	zXWrK3kW/2jJwEQD36iaNQZ7XY+Lmw/6A96YZ4mAkrEJyTywxv8G3llw3zdFKKbN
	GGj9DuOEVgts+gWfxsfbcFqqUax2nNlgkcA1NyG1esufsYpBlaZf4XDFdZ28Y2UR
	9wOKMjF1ETecggemF5KFmVJVMBAn4/st61HfQNNshs/IdWTHMfZtLi8/5WkIvaPE
	dftYWfzf1kIIrGeTfRWLo3RxwmBj1nYQkRGBTTU3WVzt6VxHkSr2Cq0M7oWTPf3s
	gjLDUwGSgAsovd5deQ60vcxtieaWgk0tZrOoTzr9Yc+RBRFocmUog==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx28bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 09:48:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H9Yg84008365;
	Wed, 17 Jun 2026 09:48:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eudvaags3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 09:48:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65H9mNDx34210294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2026 09:48:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B483420040;
	Wed, 17 Jun 2026 09:48:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 858972004F;
	Wed, 17 Jun 2026 09:48:22 +0000 (GMT)
Received: from funtu2.ehn-de.ibm.com (unknown [9.224.92.54])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Jun 2026 09:48:22 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v7 07/17] target/s390x: Minimal AES XTS support for cpacf pcc instruction
Date: Wed, 17 Jun 2026 11:48:10 +0200
Message-ID: <20260617094820.34402-8-freude@linux.ibm.com>
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
X-Proofpoint-GUID: _zkdLLuC_cA-w9Qi6OErg1UYZz3Ai9h8
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a326d6c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=gr50lgQh3SlUKNVXMSoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5MiBTYWx0ZWRfX9b+Y7l1Bxcf1
 5OSWqOWEbAfuyij6YgiUZbVySzaRNrGITIDEmY3RgvouV+eZNiXI0BPYfBfS9Z8daMT7Jm1Y/AC
 gopcLmO+qQLRHTmhuI8Rbddjgfu5m0w=
X-Proofpoint-ORIG-GUID: _zkdLLuC_cA-w9Qi6OErg1UYZz3Ai9h8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5MiBTYWx0ZWRfX5JdyEuy6Aeph
 dsmdUYOVlqnegJdGtRHmcDEXXyf8TS9/fCfp+xW53MywAdNcjeYJ+fxmwjpncaSVnJ9A/IU+Wgw
 SreRkFvM0OB9Hx3onqMMJBBPMv5VHxUjFNB1Vt4VRETyUUiTMjqL7G2HJe0JFcy+bYxfLkvq+c3
 P/OnT8UV9mJ22zZwv/V4ykr+Qtyrzg/tcRIymIzFv6OenLgsnRP0B1moJ5Ez/VRRGo4GvuD4p0y
 A7y8T+th8MQniKqY+Mx3E7dtxsiz8jGdqvoa1WKtghX8Soge/SasOAyewHz285WRGd4O+jJ/BhU
 l1/DAJqTKUrws8WiwY+1CSOEG+U/edRLZ1TmC9EzdglgWq5l1rVBQ2fqPU8RnBzohTBINP4PSpl
 NK+WkDRYlIE2hVR9cVkzzg84wwxm6JK1C/ArmU+VMbj3GdnPRIwSUfXyIfc5jfV2d02pNJMWqKx
 ubPdkqLDkmgCGopTXOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170092

Support CPACF pcc subfunctions PCC-Compute-XTS-Parameter-AES-128
and PCC-Compute-XTS-Parameter-AES-128 but only for the special
case block sequential number is 0. However, this covers the s390
AES XTS implementation in the Linux kernel and Libica and thus
also Opencryptoki clear key via Libica.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
---
 target/s390x/gen-features.c      |  2 +
 target/s390x/tcg/cpacf.h         |  2 +
 target/s390x/tcg/cpacf_aes.c     | 71 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c | 20 +++++++++
 4 files changed, 95 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 59c2a47539..1b6a874b90 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -930,6 +930,8 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KMCTR_AES_128,
     S390_FEAT_KMCTR_AES_192,
     S390_FEAT_KMCTR_AES_256,
+    S390_FEAT_PCC_XTS_AES_128,
+    S390_FEAT_PCC_XTS_AES_256,
 };
 
 /****** END FEATURE DEFS ******/
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index d73cb98c38..381a6c3ff1 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -32,5 +32,7 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                   uint64_t *ctr_ptr_reg, uint32_t type,
                   uint8_t fc, uint8_t mod);
+int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                  uint64_t param_addr, uint8_t fc);
 
 #endif
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index e200a9a87a..43c556f31b 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -16,6 +16,13 @@
 #include "crypto/aes.h"
 #include "cpacf.h"
 
+/* #define DEBUG_HELPER */
+#ifdef DEBUG_HELPER
+#define HELPER_LOG(x...) qemu_log(x)
+#else
+#define HELPER_LOG(x...)
+#endif
+
 static void aes_read_block(CPUS390XState *env, const int mmu_idx,
                            uint64_t addr, uint8_t *a, uintptr_t ra)
 {
@@ -289,3 +296,67 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return !len ? 0 : 3;
 }
+
+int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                  uint64_t param_addr, uint8_t fc)
+{
+    uint8_t key[32], tweak[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
+    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
+    int keysize, i;
+    uint64_t addr;
+    AES_KEY exkey;
+
+    switch (fc) {
+    case 0x32: /* CPACF_PCC compute XTS param AES-128 */
+        keysize = 16;
+        break;
+    case 0x34: /* CPACF PCC compute XTS param AES-256 */
+        keysize = 32;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    /* fetch block sequence nr from param block into buf */
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        addr = wrap_address(env, param_addr + keysize + AES_BLOCK_SIZE + i);
+        buf[i] = cpu_ldb_mmu(env, addr, oi, ra);
+    }
+
+    /* is the block sequence nr 0 ? */
+    for (i = 0; i < AES_BLOCK_SIZE && !buf[i]; i++) {
+            ;
+    }
+    if (i < AES_BLOCK_SIZE) {
+        /* no, sorry handling of non zero block sequence is not implemented */
+        cpu_abort(env_cpu(env),
+                  "PCC-compute-XTS-param with non zero block sequence is not implemented\n");
+        return 1;
+    }
+
+    /* fetch key from param block */
+    for (i = 0; i < keysize; i++) {
+        addr = wrap_address(env, param_addr + i);
+        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
+    }
+
+    /* fetch tweak from param block into tweak */
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        addr = wrap_address(env, param_addr + keysize + i);
+        tweak[i] = cpu_ldb_mmu(env, addr, oi, ra);
+    }
+
+    /* expand key */
+    AES_set_encrypt_key(key, keysize * 8, &exkey);
+
+    /* encrypt tweak */
+    AES_encrypt(tweak, buf, &exkey);
+
+    /* store encrypted tweak into xts parameter field of the param block */
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        addr = wrap_address(env, param_addr + keysize + 3 * AES_BLOCK_SIZE + i);
+        cpu_stb_mmu(env, addr, buf[i], oi, ra);
+    }
+
+    return 0;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 98dfa37185..1a0a503844 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -169,6 +169,23 @@ static int cpacf_ppno(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     return rc;
 }
 
+static int cpacf_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                     uint8_t fc)
+{
+    int rc = 0;
+
+    switch (fc) {
+    case 0x32: /* CPACF_PCC compute XTS param AES-128 */
+    case 0x34: /* CPACF PCC compute XTS param AES-256 */
+            rc = cpacf_aes_pcc(env, mmu_idx, ra, env->regs[1], fc);
+            break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return rc;
+}
+
 uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
                      uint32_t type)
 {
@@ -228,6 +245,9 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     case S390_FEAT_TYPE_KMCTR:
         rc = cpacf_kmctr(env, mmu_idx, ra, r1, r2, r3, fc, mod);
         break;
+    case S390_FEAT_TYPE_PCC:
+        rc = cpacf_pcc(env, mmu_idx, ra, fc);
+        break;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0

