Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87E13E866B
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783697370; cv=none; b=uVFx+KxhktBc4RfItapJEQOM5Hxtw+arWqLi5tPHTRyVvDCNmcU+f/xE6jIHz9uUJggPZal2VSdc85i131drsHH8cWMIn44itNABvGKUs2DfHb4gAE3v2GTotXBF4ZE+PaGydzx+maE2OMuoWjvS5QmnplcKMekJTKNlE4aT8gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783697370; c=relaxed/simple;
	bh=lpbEX1sbQP4xaElEP838ADjWqAqvFN/MWJNkHVTKCVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YiQat1zZ7NL+L948zRQfFwTQaHKnSBOE2RygOgbu/d9Rt9uJwjL8r5qo4l9WMt5BqJ1wUcLNsTo2cwLQkX9Ubam6QwvPXWLEmMtFOQOT5uvM42vhhNxeUYO8hjkhz9GWp9qt0syz58/6+B/jXKbzpT2dJs45vMPeLOS1hjnUxno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E09JtmbY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E09JtmbY"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AEmbQX1907303;
	Fri, 10 Jul 2026 15:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=17EASr86680uF9dCC
	r32CSPhpnjy+PR4I5qmOE9ircU=; b=E09JtmbY0KdzpsOwui9LD3J8dhV4UlixT
	SuYpDICokiK18QVecbXHvrk/BWNzdGiqXlSl5cAS8t4c95O9tKhH+mrEDyA2PrVj
	EY3pvlVvDDH2p/82TRIaHPnj+a5Qxpw65V/X9GzZwlAwcfdAvGyGlnF1M/Jel4Y7
	Bu8+a+9w2Cg0OivcDiI4nV1b7WcejPhMo29v6Q6ExEB5ZcSdxfz+MEPz0ilq7mRS
	Y3MVbDbM80gQw1ofQqWPqMOwKSKnjOad3GyvDGpS1ow/G0cmvfj/N9Ghj74O0JEj
	VQlQtqAKYxyH7oPIPm3AexV/TLw4m9VECZm0oVWpfugBeasnG6VJQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sur75sj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 15:29:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66AFJeaP015235;
	Fri, 10 Jul 2026 15:29:12 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6yj8y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 15:29:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66AFT8mY54264190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 15:29:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80C7C20040;
	Fri, 10 Jul 2026 15:29:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FB1820043;
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
Subject: [PATCH v12 05/17] target/s390x: Support AES ECB for cpacf km instruction
Date: Fri, 10 Jul 2026 17:28:51 +0200
Message-ID: <20260710152906.80207-6-freude@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE1MyBTYWx0ZWRfX+FX32/dxuTeR
 dhzfobgfCwXXegIyYW7Jx/91hEqpIJSG4uqKwg/nX6jjLvHSA9CNtItrNya8DGEdBsvO9I/Kb4H
 MnBWxfXLi7TmDAAt2tGhtCWsCIMb0LY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE1MyBTYWx0ZWRfX33jtz1cla+jN
 zxirYKeyWbzFKZEJ0rEA9qTWYmMHcCpRt7UFpC55oMADhc0T+8BTM7yhXXLJXiFNidJLqUxjZpa
 WSp4VPNE+GISfVDUSB5BbV1EqzDBhbS8Uqu1SF4g9wXucT9hs7Oet1SQHK2e6HnRMQOu/UaR81d
 9ZEwPZC+j+tnB4p9o7Jich3as1li4eN+RWi9OsETCVsaR9ab3Idyuq5bHX90+0sie9O/xqn6vUr
 Z62F+6qNDApBKBZXpig2/CoFGmcmOVLcxYzSX7YjRSGozRiLuSe/cVo2pnkVyjMbOg1kWVFuNDv
 qxCEtNWQ/9XwSB8h4C9mFfOHG4OKcmxg6v40sQ5Cknpa/17BSsg2HORF95pmWmUS4b29XAC3gSk
 Ww04tggw5TIjkXRrVKTx0r6klxPGVEQMF4ECWqB04IjfMr1iXKwGVx74GFoP8Ias48WWh0s3Ay8
 10EqsGlZQ69Dtvrq4Sg==
X-Proofpoint-GUID: ThmU4TCApWNhZY3jERPgM0zcFGN7Z2-K
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a510fc9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=5Vg_AgGwEONL64qEDWAA:9
X-Proofpoint-ORIG-GUID: ThmU4TCApWNhZY3jERPgM0zcFGN7Z2-K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100153

Support the subfunctions CPACF_KM_AES_128, CPACF_KM_AES_192
and CPACF_KM_AES_256 for the cpacf km instruction.

Tested-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/gen-features.c      |   3 +
 target/s390x/tcg/cpacf.h         |   6 ++
 target/s390x/tcg/cpacf_aes.c     | 136 +++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |  24 ++++++
 target/s390x/tcg/meson.build     |   1 +
 5 files changed, 170 insertions(+)
 create mode 100644 target/s390x/tcg/cpacf_aes.c

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 78f71c6c7b..c8ba5107d7 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -922,6 +922,9 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KLMD_SHA_256,
     S390_FEAT_KLMD_SHA_512,
     S390_FEAT_PRNO_TRNG,
+    S390_FEAT_KM_AES_128,
+    S390_FEAT_KM_AES_192,
+    S390_FEAT_KM_AES_256,
 };
 
 /****** END FEATURE DEFS ******/
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 94e9de5b23..cee393cdc0 100644
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
index 0000000000..5357d099c4
--- /dev/null
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -0,0 +1,136 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * s390 cpacf aes
+ *
+ * Authors:
+ *   Harald Freudenberger <freude@linux.ibm.com>
+ */
+
+#include "qemu/osdep.h"
+#include "s390x-internal.h"
+#include "tcg_s390x.h"
+#include "accel/tcg/cpu-ldst-common.h"
+#include "accel/tcg/cpu-mmu-index.h"
+#include "crypto/aes.h"
+#include "crypto/aes-helpers.h"
+#include "target/s390x/tcg/cpacf.h"
+
+/*
+ * helper function to copy some memory from guest to a local buffer
+ */
+static inline void copy_from_guest_wrap(CPUS390XState *env, const int mmu_idx,
+                                        const uintptr_t ra, uint64_t guest_addr,
+                                        uint8_t *dest, size_t len)
+{
+    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
+
+    for (size_t i = 0; i < len; i++, guest_addr++) {
+        uint64_t waddr = wrap_address(env, guest_addr);
+        dest[i] = cpu_ldb_mmu(env, waddr, oi, ra);
+    }
+}
+
+/*
+ * helper function to copy from a local buffer to guest memory
+ */
+static inline void copy_to_guest_wrap(CPUS390XState *env, const int mmu_idx,
+                                      const uintptr_t ra, uint64_t guest_addr,
+                                      const uint8_t *src, size_t len)
+{
+    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
+
+    for (size_t i = 0; i < len; i++, guest_addr++) {
+        uint64_t waddr = wrap_address(env, guest_addr);
+        cpu_stb_mmu(env, waddr, src[i], oi, ra);
+    }
+}
+
+/*
+ * read exactly one AES block from guest memory into a local buffer
+ */
+static inline void aes_read_block(CPUS390XState *env, const int mmu_idx,
+                                  const uintptr_t ra, uint64_t guest_addr,
+                                  uint8_t *buf)
+{
+    copy_from_guest_wrap(env, mmu_idx, ra, guest_addr, buf, AES_BLOCK_SIZE);
+}
+
+/*
+ * write exactly one AES block from local buffer to guest memory
+ */
+static void aes_write_block(CPUS390XState *env, const int mmu_idx,
+                            const uintptr_t ra, uint64_t guest_addr,
+                            uint8_t *buf)
+{
+    copy_to_guest_wrap(env, mmu_idx, ra, guest_addr, buf, AES_BLOCK_SIZE);
+}
+
+int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                  uint64_t param_addr, uint64_t *dst_ptr_reg,
+                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                  uint32_t type, uint8_t fc, uint8_t mod)
+{
+    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
+    uint64_t len = *src_len_reg, done = 0;
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
+    copy_from_guest_wrap(env, mmu_idx, ra, param_addr, key, keysize);
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
+        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
+        if (mod) {
+            AES_decrypt(in, out, &exkey);
+        } else {
+            AES_encrypt(in, out, &exkey);
+        }
+        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
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

