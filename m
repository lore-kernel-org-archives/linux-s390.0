Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED27379C56
	for <linux-s390@vger.kernel.org>; Wed,  1 Jul 2026 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924434; cv=none; b=OhHcE0DNUVLycmBucUaLUyoSCbxJDihrOHEkG+rgZOyor/7BxnWV5ZevgCMScEOc3M0bVeNS7+OLLjN5OZS4q7Ip2gqTubAqVeRHo42inW0sE943lg8bleJ3eXhHDrIJORHq0GXJtFWsKlewEAWKPqK4cHOooJXuYntyk8wS+Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924434; c=relaxed/simple;
	bh=e6ye9uxjC8YNEy7St9gQX+vqlgGZLKq54IGxJySBz+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/JQxipjVCEwjo3rLmtq2e9lXBC4ujwWZj2AeYaTFHkeF9rPY8dLRcWlRwv/T6t+1H9onMHy0ZnclXUhnSJcQvWXuTC/5GFqAUe2AG4l8Ma5oZiWXJ81rHlx3jcSwCVltK+ndSZ0o5qzFW5O4VpyZyc4e6aRX/OivgnMs/PCShg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YBkaCaD/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YBkaCaD/"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661AJ5sY448017;
	Wed, 1 Jul 2026 16:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6DbcMv132mHO4W0y3
	Ej3kNLdsmim3hr4A6Qu0lKcrJk=; b=YBkaCaD/tW23EKe8tgdJRbLImHgmhDHd6
	wkOuKf6BsgSRuc+qDgBOwrgSLGUd3erTYbT0hlxWBErXxdvbcrAdxHaO33Qwtace
	i02vJYJhC32O3iJYi7qehqj4AFj3da0Q+rypXYflXmGh+lODFSqLuVull0qayAvN
	Pj0OJfMf4vcaeIAW0CRxUd9TU3ePktDCBzrhvEYzlJwYKyTHEa97s3hQufhdRV2G
	QCIvdNMu898qnP8wBcZ4FCZu/R3OImjBk2EHl/lv+2/GWIfmBS7RtT/8E8YOGdbf
	odFZgVGEfque+kb0dBV7npDB1EuZMysMXOWOdwLVj9n/c7xTVFbdA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjwa9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 16:46:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661GYbDD010739;
	Wed, 1 Jul 2026 16:46:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqgcn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 16:46:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 661GkrO049152398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 16:46:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0926B20040;
	Wed,  1 Jul 2026 16:46:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6ACC20043;
	Wed,  1 Jul 2026 16:46:52 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.187.249])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 16:46:52 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v9 05/21] target/s390x: Support AES ECB for cpacf km instruction
Date: Wed,  1 Jul 2026 18:46:28 +0200
Message-ID: <20260701164650.95760-6-freude@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE3MyBTYWx0ZWRfX74Z2kvwqsId7
 VKYeUBswgtPNeGLjgpOoxaC9SlHordkCL+X6rIX0HmW8X5R74x/vSkDtvrbuQKfukGQAfcAvu0J
 vi29KHkZTrzIeRfjqXWQRsHZZTFF/jdayC9WfPzkK2r4Xzaq/yugXbjC5xQiUIG9CAB2freZovz
 kxzQSgCEsVfe5/+m/X6uYMY9umKuistFwMsXj3XhTFutfP/EFrBeWtf3C37kTSQZgz8RpMmUitB
 A3tz+PHLcxiTnKSiRlCAlBfZ40aESHiMEAHbdzGh3qwD6YwoDyasC88U/oxBkUUBRImJEvpznSy
 PIlNVLIKsSEotOgmu4+A3W8GGn5PRyoEnmHf5tIyYyH+wcIcRkgPj/GpOOYOJjrphPwoy5VdoIP
 6oQEY11xgy00BOh+vpmWDEzK7FAwkj/G2Oytb28/zqvRGj+PRt0cfkVO5F2OZxwzmTd89GmXDF6
 RchNGjdRus06KrkJMNA==
X-Proofpoint-GUID: usUr22RrTvt3ZTdS9GISwnCiI04vYVqo
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a454482 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=UeJqcyLMtA2A8E2_xXgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE3MyBTYWx0ZWRfX+C1wXGwIPNyv
 nDHkbetr7JqOK2GRLH1DGNguLaNa+2p64jWFiLJENcxdai3dJ0jWTStsCWfKTcImXWr/mU/d7nl
 x2t0qSa7u8q+vLdqay73cRPFHqn5wyI=
X-Proofpoint-ORIG-GUID: usUr22RrTvt3ZTdS9GISwnCiI04vYVqo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010173

Support the subfunctions CPACF_KM_AES_128, CPACF_KM_AES_192
and CPACF_KM_AES_256 for the cpacf km instruction.

Tested-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/gen-features.c      |   3 +
 target/s390x/tcg/cpacf.h         |   6 ++
 target/s390x/tcg/cpacf_aes.c     | 112 +++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |  24 +++++++
 target/s390x/tcg/meson.build     |   1 +
 5 files changed, 146 insertions(+)
 create mode 100644 target/s390x/tcg/cpacf_aes.c

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 5cf5b92c37..a35d1fd2f9 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -921,6 +921,9 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KLMD_SHA_256,
     S390_FEAT_KLMD_SHA_512,
     S390_FEAT_PRNO_TRNG,
+    S390_FEAT_KM_AES_128,
+    S390_FEAT_KM_AES_192,
+    S390_FEAT_KM_AES_256,
 };
 
 /****** END FEATURE DEFS ******/
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index d295b49699..ca1850c976 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -233,4 +233,10 @@ int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                  uint64_t param_addr, uint64_t *message_reg, uint64_t *len_reg,
                  uint32_t type);
 
+/* from cpacf_aes.c */
+int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                  uint64_t param_addr, uint64_t *dst_ptr_reg,
+                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                  uint32_t type, uint8_t fc, uint8_t mod);
+
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
new file mode 100644
index 0000000000..3b0676b7d5
--- /dev/null
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -0,0 +1,112 @@
+/*
+ *  s390 cpacf aes
+ *
+ *  Authors:
+ *   Harald Freudenberger <freude@linux.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "s390x-internal.h"
+#include "tcg_s390x.h"
+#include "accel/tcg/cpu-ldst-common.h"
+#include "accel/tcg/cpu-mmu-index.h"
+#include "crypto/aes.h"
+#include "target/s390x/tcg/cpacf.h"
+
+static void aes_read_block(CPUS390XState *env, const int mmu_idx,
+                           uint64_t addr, uint8_t *a, uintptr_t ra)
+{
+    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
+
+    for (int i = 0; i < AES_BLOCK_SIZE; i++, addr += 1) {
+        uint64_t _addr = wrap_address(env, addr);
+        a[i] = cpu_ldb_mmu(env, _addr, oi, ra);
+    }
+}
+
+static void aes_write_block(CPUS390XState *env, const int mmu_idx,
+                            uint64_t addr, uint8_t *a, uintptr_t ra)
+{
+    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
+
+    for (int i = 0; i < AES_BLOCK_SIZE; i++, addr += 1) {
+        uint64_t _addr = wrap_address(env, addr);
+        cpu_stb_mmu(env, _addr, a[i], oi, ra);
+    }
+}
+
+int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                  uint64_t param_addr, uint64_t *dst_ptr_reg,
+                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                  uint32_t type, uint8_t fc, uint8_t mod)
+{
+    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
+    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
+    uint64_t addr, len = *src_len_reg, done = 0;
+    int i, keysize, addr_reg_size = 64;
+    uint8_t key[32];
+    AES_KEY exkey;
+
+    g_assert(type == S390_FEAT_TYPE_KM);
+    switch (fc) {
+    case CPACF_KM_AES_128:
+        keysize = 16;
+        break;
+    case CPACF_KM_AES_192:
+        keysize = 24;
+        break;
+    case CPACF_KM_AES_256:
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
+    for (i = 0; i < keysize; i++) {
+        addr = wrap_address(env, param_addr + i);
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
+            AES_decrypt(in, out, &exkey);
+        } else {
+            AES_encrypt(in, out, &exkey);
+        }
+        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
+        len -= AES_BLOCK_SIZE;
+        done += AES_BLOCK_SIZE;
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
index 6c296f6731..3907b9748c 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -89,6 +89,27 @@ static int cpacf_klmd(CPUS390XState *env, const int mmu_idx, const uintptr_t ra,
     return rc;
 }
 
+static int cpacf_km(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                    uint32_t r1, uint32_t r2, uint32_t r3,
+                    uint8_t fc, uint8_t mod)
+{
+    int rc = 0;
+
+    switch (fc) {
+    case CPACF_KM_AES_128:
+    case CPACF_KM_AES_192:
+    case CPACF_KM_AES_256:
+        rc = cpacf_aes_ecb(env, mmu_idx, ra, env->regs[1],
+                           &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
+                           S390_FEAT_TYPE_KM, fc, mod);
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
@@ -153,6 +174,9 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     case S390_FEAT_TYPE_KLMD:
         rc = cpacf_klmd(env, mmu_idx, ra, r1, r2, r3, fc);
         break;
+    case S390_FEAT_TYPE_KM:
+        rc = cpacf_km(env, mmu_idx, ra, r1, r2, r3, fc, mod);
+        break;
     case S390_FEAT_TYPE_PPNO:
         rc = cpacf_ppno(env, mmu_idx, ra, r1, r2, r3, fc);
         break;
diff --git a/target/s390x/tcg/meson.build b/target/s390x/tcg/meson.build
index 8ae8da9708..6f2e75764b 100644
--- a/target/s390x/tcg/meson.build
+++ b/target/s390x/tcg/meson.build
@@ -5,6 +5,7 @@ s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
 ))
 s390x_common_ss.add(when: 'CONFIG_TCG', if_true: files(
   'cc_helper.c',
+  'cpacf_aes.c',
   'cpacf_sha256.c',
   'cpacf_sha512.c',
   'crypto_helper.c',
-- 
2.43.0

