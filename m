Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A259C4315F
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069928; cv=none; b=pIF3TIIIg8PuxnNT7LXt+vss9URbOqb0APgHVhgbTD2DwRDXLl3Dz8XchE/ROV03JoFDa0FIvHickRc8y4/fOYdZssmtn3WnB3kvNWzmyDrZWic9qWjq9ES9Yut1pRFIoJMim8PLQYj72TWLaFXZ32bZQlAcdErHGWEFGhx5rmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069928; c=relaxed/simple;
	bh=8luuM9i/hbW9aKe3cdcguWn3c4UjTEyQaUs9qaxOB9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6+0NkEqEr6JAo7HKTvOKDb6oHhZSMtGZOmUHiymmtbYJRrgl3oUkspBFPPs/MpEbHl2ew6/ZaQQvdSnuXWFlVx+QSDWayznEID85frqIjc+82r8D/M77u2q1g0CAM5NxS0QHcHAdHddrvt0/2hqMd1k0tHGUz+Uu6AVb9Mxkoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f0NF0F7f; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f0NF0F7f"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3Zql455087;
	Tue, 18 Aug 2026 16:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5fIoG//4tfDkZSWPI
	RQaWHmNDzxZTM+AX5CSxrYDr/8=; b=f0NF0F7fcQT6tp74jCaFgqlSUPrVeP56q
	HItrv1d2CdztM1ixJZn5jiUx/NzKWRUq+7YYDuQRySchOYBn0XIhxWXVaZl0gvwu
	JuSQGZZX1PVDRLkUk7WWQUzkCSJWPLcu2YnbpYJd2QyVAZV5KLyeYX3eBa0vKXfs
	5UhCwy13sIlYaQR6ZWN++guN/h5SEuyej90tD/Yv/IvZ84tFC6bIk5Acie0RfcvO
	aRTVv/8/8BUfXxZdbXvRfR0On84VC2m/CcyNibnkam7XlT4NomPBM1hE6Mx8dhDi
	cHq+d5lmvl72op+zERUMaHX10uu+lgF9XyK3WtNXNxtvXBqgxPIYA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3sdhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 16:18:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IGBJkj017975;
	Tue, 18 Aug 2026 16:18:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ybvy1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 16:18:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IGIQBS40108296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 16:18:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B21E120043;
	Tue, 18 Aug 2026 16:18:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D8172004D;
	Tue, 18 Aug 2026 16:18:26 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.161.134])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 16:18:26 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v15 08/20] target/s390x: Support AES ECB for cpacf km instruction
Date: Tue, 18 Aug 2026 18:18:12 +0200
Message-ID: <20260818161824.100746-9-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818161824.100746-1-freude@linux.ibm.com>
References: <20260818161824.100746-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r9JptbeqK2i2WhxFBGYcFB4XM_T-kGqf
X-Proofpoint-ORIG-GUID: r9JptbeqK2i2WhxFBGYcFB4XM_T-kGqf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDExOCBTYWx0ZWRfXyS/PnPEgAvjz
 bVOyzLkiRif3lds177Ns3Lf4DvTLdTL1gijB4qf8I8WuOr4gZ/gXK8DQtnWLdHVDHROWn2+fAhw
 kbZKCLdFSfJmeIeYae35mBBHxUNlDzk=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a8485d7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=UeJqcyLMtA2A8E2_xXgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDExOCBTYWx0ZWRfXyqF0lowzCBZy
 cbcGJJUEh1NXjBqq9Gt1fGpm7pYyoY/RNCvqiEtIMsYANsLK7icKtVEAl+MvvllvpXVGnoP5Dj4
 5Fqq2ShAQxBZ9AxUm6WaUeTPiwRD/jFM78rfaarSS4VdGG0xBj9/ZThb4/GA6ZqNEYeQt9zJHgG
 p4G7tlytRJ3dBVtmCENvvje+A7EO7h3DQvmSbG6dKk+3/08OiydXISKR9U9BPK6GTVXD20n5Mhi
 BEWav8l/C6ZbXlvTFE+cZtcBzvdRDEOdQwKCdy8iLF+8viKtW+gaR5P0/RpaA3vl7tklk0uWrc5
 ITfL8K9p8iY8XZz4rSbyupDTj+u599VhCKuhfIIkTxylXjtQ97cFeQ+Pq+1S1oAx4OfaEHUBAhd
 RgvSz4DvJnY93GvEmInt0p//F8QawpHrI9FocnhIW3LmwhLtFsNv2XpxR82hx+DIHjTaYvchXeN
 QW6tOvcdZvBwcsztZCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180118

Support the subfunctions CPACF_KM_AES_128, CPACF_KM_AES_192
and CPACF_KM_AES_256 for the cpacf km instruction.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/gen-features.c      |   3 +
 target/s390x/tcg/cpacf.h         |   6 ++
 target/s390x/tcg/cpacf_aes.c     | 137 +++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |  24 ++++++
 target/s390x/tcg/meson.build     |   1 +
 5 files changed, 171 insertions(+)
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
index 67b8368e4d..49630bab5e 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -18,4 +18,10 @@ int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
index 0000000000..313a60e6ef
--- /dev/null
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -0,0 +1,137 @@
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
+#include "target/s390x/tcg/cpacf-arch.h"
+#include "target/s390x/tcg/cpacf.h"
+#include "target/s390x/tcg/crypto_helper.h"
+
+/*
+ * read exactly one AES block from guest memory into a local buffer
+ */
+static inline void aes_read_block(CPUS390XState *env, const int mmu_idx,
+                                  const uintptr_t ra, uint64_t guest_addr,
+                                  uint8_t *buf)
+{
+    read_guest_wrap_u8(env, mmu_idx, ra, guest_addr, buf, AES_BLOCK_SIZE);
+}
+
+/*
+ * write exactly one AES block from local buffer to guest memory
+ */
+static void aes_write_block(CPUS390XState *env, const int mmu_idx,
+                            const uintptr_t ra, uint64_t guest_addr,
+                            uint8_t *buf)
+{
+    write_guest_wrap_u8(env, mmu_idx, ra, guest_addr, buf, AES_BLOCK_SIZE);
+}
+
+/*
+ * Helper function returning the bitsize of the address mode.
+ * Within this file only 64 bit and 32 bit are supported and
+ * thus this function returns either 64 or 32 or 0.
+ */
+static int get_address_bitsize(CPUS390XState *env)
+{
+    if (env->psw.mask & PSW_MASK_64) {
+        return 64;
+    } else if (env->psw.mask & PSW_MASK_32) {
+        return 32;
+    } else {
+        /* unknown or unsupported here */
+        return 0;
+    }
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
+    int i, keysize, addr_reg_size;
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
+    /* check addressing mode, raise exception if not supported here */
+    addr_reg_size = get_address_bitsize(env);
+    switch (addr_reg_size) {
+    case 64:
+        break;
+    case 32:
+        len = (uint32_t)len;
+        break;
+    default:
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    /* early bail out if length is zero */
+    if (!len) {
+            return 0;
+    }
+
+    /* length has to be properly aligned. */
+    if (!QEMU_IS_ALIGNED(len, AES_BLOCK_SIZE)) {
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    /* fetch key from param block */
+    read_guest_wrap_u8(env, mmu_idx, ra, param_addr, key, keysize);
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
index 27decdda63..534498173c 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -98,6 +98,27 @@ static int cpacf_klmd(CPUS390XState *env, const int mmu_idx, const uintptr_t ra,
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
@@ -166,6 +187,9 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
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

