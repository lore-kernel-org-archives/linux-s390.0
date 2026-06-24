Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F24D3A6F1B
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782288660; cv=none; b=bwBZtFzCfHM+DVzCbsof9jjTxSurEW+EsxwOfbkEKzS2mfYAO3L1PPecykGuvMnJFoThCSPz57FW8LqiFoPu9hajVyRJfS9wYp10k4ZpNHgUv7vtBvIty06JwapSYNHIpUyhGQIf57UAPAsxQC7X59ovlgtjvSNaFSE9mdGR6pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782288660; c=relaxed/simple;
	bh=3GccoctCvonGYWcNOByVj2Qauce0HnMR9bkXQxz/+wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oY31d1XcGZya739F6zqGVy2EunpHf2js6vNK289QcfUwDwWxXr7r8KhI/iKw299q4OMl0l9qjK4dwHjd3TIx2ch436tojmsgz5VRtnBxsHAI7wlSlYdiRWBQc9JwMrPTM3E6FeJKaXSrdzerWuNQ6/l4qn4Eg4dDgXxUPsx/PRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gk1s8ARw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gk1s8ARw"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O6IpCW149794;
	Wed, 24 Jun 2026 08:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Q78bWRcYbf7EGN/TT
	ZqEWHD5A7Jc7WuvJLnlBWk3Shk=; b=Gk1s8ARw/h8yQY44miDBD5OIo/pqT/jGZ
	5LQXD5kFktA4aK7ObJjAe0yKQxuoSGW1Ra+Uw03zSL4jo1cPc8wixJkVIOU4f24q
	CHbOUMKxuFChV9tFd5bY7QNsxQgtC19X1Z2S7Tm1gyq8ZRq/qP9YAhl1BpABtGsr
	t33l31lJtJW24E3R1ieS8ceYcic6Xg+N2p3SqAyT+Oln7wkOqH2yzqF9hrWnKqP8
	9Tc21Z7rPCG5IkSl+7Bkz0Wd5STPoA2g6NyM/SfrHOmgRK+qnl8Yk3SrosGj6E+m
	CC/lwl/CbGh/OZ3i0ndQ1Xks1i1YEH4TkTpsg3HQr4dW+8Twi9zMg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3k4tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:10:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65O84cTq010053;
	Wed, 24 Jun 2026 08:10:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qfsu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:10:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65O8AVRF29688112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 08:10:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2D7A20040;
	Wed, 24 Jun 2026 08:10:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E9162004B;
	Wed, 24 Jun 2026 08:10:31 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.224.92.54])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 08:10:31 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v8 04/18] target/s390x: Support cpacf sha256
Date: Wed, 24 Jun 2026 10:10:01 +0200
Message-ID: <20260624081029.23815-5-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624081029.23815-1-freude@linux.ibm.com>
References: <20260624081029.23815-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3b90fc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=7rAwQbULjql6waQdbJoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfX9Lzb5iaPWrCR
 wvhXuF0T2LQJCXBs30RrAdvD9oL0N0T8eUBxz9YSNiiJQS+ttFVXfcBHdf+XpT2AUWhMzRWT7j1
 5FksFG+i7VOB16+FUoKZ5fslHvWwPyE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfXwJb/tTD4o9nu
 vL8yN9Ddp4aaiVdVxZSy0xBKyNV2XN53OqJsrUDQQKaUuhdwK1VUfAO0iKxee9S8A8RADzNta7c
 Y8gAZmR/i8k3x1n3JA8MQPHPUyD+OpcW5j1FFcUSakQg9kPkl6vimix5bPRtP3L9N0H/W4Rd4/9
 72qbAaCMI9CgjLmzGO9dczuox2wKDBac81LpgjRanVxdlpMrEnW1maopsBSP1DofGQfp1+VWjNu
 TQ5YNnDvqahCLDN5wm+JPaYT9gdrKRwmxG24F0039nZjoOh3rSY+gXqjTKDOIH3rUoLicq5mtzV
 2qb6QrvODQsw6xnNN3yVK3pW270AOq07B2ai9PItKYCD3mPiYtZA3pV1JTAFo01c3Ua5wdrN068
 dbcvZ6Jpf8n7cWOu6mLiysrUmQl7PFTSXO3GM3Y9ZSDPUYQtOO73vtjWdTDrMhn1dQPXqNMo27F
 5hXoobcHpRaTCtXvBBg==
X-Proofpoint-ORIG-GUID: HPsSA2Uzhq85QsfXK0_3HR7OG6gctWFO
X-Proofpoint-GUID: HPsSA2Uzhq85QsfXK0_3HR7OG6gctWFO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240063

Add a new file cpacf_sha256.c which implements sha256.
Add support for the sha256 subfuction for CPACF kimd and klmd.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
---
 target/s390x/gen-features.c      |   2 +
 target/s390x/tcg/cpacf.h         |   5 +
 target/s390x/tcg/cpacf_sha256.c  | 232 +++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |   8 ++
 target/s390x/tcg/meson.build     |   1 +
 5 files changed, 248 insertions(+)
 create mode 100644 target/s390x/tcg/cpacf_sha256.c

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 8218e6470e..5cf5b92c37 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -916,7 +916,9 @@ static uint16_t qemu_V7_1[] = {
  */
 static uint16_t qemu_MAX[] = {
     S390_FEAT_MSA_EXT_5,
+    S390_FEAT_KIMD_SHA_256,
     S390_FEAT_KIMD_SHA_512,
+    S390_FEAT_KLMD_SHA_256,
     S390_FEAT_KLMD_SHA_512,
     S390_FEAT_PRNO_TRNG,
 };
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index a6e68f17c3..e2fc149d2b 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -11,6 +11,11 @@
 #include "cpu.h"
 #include <stdint.h>
 
+/* from cpacf_sha256.c */
+int cpacf_sha256(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                 uint64_t param_addr, uint64_t *message_reg, uint64_t *len_reg,
+                 uint32_t type);
+
 /* from cpacf_sha512.c */
 int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                  uint64_t param_addr, uint64_t *message_reg, uint64_t *len_reg,
diff --git a/target/s390x/tcg/cpacf_sha256.c b/target/s390x/tcg/cpacf_sha256.c
new file mode 100644
index 0000000000..997e0b8b40
--- /dev/null
+++ b/target/s390x/tcg/cpacf_sha256.c
@@ -0,0 +1,232 @@
+/*
+ *  s390 cpacf sha256
+ *
+ *  Authors:
+ *   Harald Freudenberger <freude@linux.ibm.com>
+ *
+ * The sha256 implementation here is more or less a copy-and-paste
+ * from Jason A. Donenfeld's implementation of sha 512 with adaptions
+ * for sha 256.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "s390x-internal.h"
+#include "tcg_s390x.h"
+#include "exec/helper-proto.h"
+#include "accel/tcg/cpu-ldst-common.h"
+#include "accel/tcg/cpu-mmu-index.h"
+#include "cpacf.h"
+
+static uint32_t R(uint32_t x, int c)
+{
+    return (x >> c) | (x << (32 - c));
+}
+static uint32_t Ch(uint32_t x, uint32_t y, uint32_t z)
+{
+    return (x & y) ^ (~x & z);
+}
+static uint32_t Maj(uint32_t x, uint32_t y, uint32_t z)
+{
+    return (x & y) ^ (x & z) ^ (y & z);
+}
+static uint32_t Sigma0(uint32_t x)
+{
+    return R(x, 2) ^ R(x, 13) ^ R(x, 22);
+}
+static uint32_t Sigma1(uint32_t x)
+{
+    return R(x, 6) ^ R(x, 11) ^ R(x, 25);
+}
+static uint32_t sigma0(uint32_t x)
+{
+    return R(x, 7) ^ R(x, 18) ^ (x >> 3);
+}
+static uint32_t sigma1(uint32_t x)
+{
+    return R(x, 17) ^ R(x, 19) ^ (x >> 10);
+}
+
+static const uint32_t K[64] = {
+    0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1,
+    0x923f82a4, 0xab1c5ed5, 0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
+    0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174, 0xe49b69c1, 0xefbe4786,
+    0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
+    0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147,
+    0x06ca6351, 0x14292967, 0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
+    0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85, 0xa2bfe8a1, 0xa81a664b,
+    0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
+    0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a,
+    0x5b9cca4f, 0x682e6ff3, 0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
+    0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2,
+};
+
+/* a is icv/ocv, w is a single message block. w will get reused internally. */
+static void sha256_bda(uint32_t a[8], uint32_t w[16])
+{
+    uint32_t t, z[8], b[8];
+    int i, j;
+
+    memcpy(z, a, sizeof(z));
+    for (i = 0; i < 64; i++) {
+        memcpy(b, a, sizeof(b));
+
+        t = a[7] + Sigma1(a[4]) + Ch(a[4], a[5], a[6]) + K[i] + w[i % 16];
+        b[7] = t + Sigma0(a[0]) + Maj(a[0], a[1], a[2]);
+        b[3] += t;
+        for (j = 0; j < 8; ++j) {
+            a[(j + 1) % 8] = b[j];
+        }
+        if (i % 16 == 15) {
+            for (j = 0; j < 16; ++j) {
+                w[j] += w[(j + 9) % 16] + sigma0(w[(j + 1) % 16]) +
+                        sigma1(w[(j + 14) % 16]);
+            }
+        }
+    }
+
+    for (i = 0; i < 8; i++) {
+        a[i] += z[i];
+    }
+}
+
+/* a is icv/ocv, w is a single message block that needs be32 conversion. */
+static void sha256_bda_be32(uint32_t a[8], uint32_t w[16])
+{
+    uint32_t t[16];
+    int i;
+
+    for (i = 0; i < 16; i++) {
+        t[i] = be32_to_cpu(w[i]);
+    }
+    sha256_bda(a, t);
+}
+
+static void sha256_read_icv(CPUS390XState *env, const int mmu_idx,
+                            uint64_t addr, uint32_t a[8], uintptr_t ra)
+{
+    const MemOpIdx oi = make_memop_idx(MO_BE | MO_32 | MO_UNALN, mmu_idx);
+
+    for (int i = 0; i < 8; i++, addr += 4) {
+        uint64_t _addr = wrap_address(env, addr);
+        a[i] = cpu_ldl_mmu(env, _addr, oi, ra);
+    }
+}
+
+static void sha256_write_ocv(CPUS390XState *env, const int mmu_idx,
+                             uint64_t addr, uint32_t a[8], uintptr_t ra)
+{
+    const MemOpIdx oi = make_memop_idx(MO_BE | MO_32 | MO_UNALN, mmu_idx);
+
+    for (int i = 0; i < 8; i++, addr += 4) {
+        uint64_t _addr = wrap_address(env, addr);
+        cpu_stl_mmu(env, _addr, a[i], oi, ra);
+    }
+}
+
+static void sha256_read_block(CPUS390XState *env, const int mmu_idx,
+                              uint64_t addr, uint32_t a[16], uintptr_t ra)
+{
+    const MemOpIdx oi = make_memop_idx(MO_BE | MO_32 | MO_UNALN, mmu_idx);
+
+    for (int i = 0; i < 16; i++, addr += 4) {
+        uint64_t _addr = wrap_address(env, addr);
+        a[i] = cpu_ldl_mmu(env, _addr, oi, ra);
+    }
+}
+
+static void sha256_read_mbl_be32(CPUS390XState *env, const int mmu_idx,
+                                 uint64_t addr, uint8_t a[8], uintptr_t ra)
+{
+    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
+
+    for (int i = 0; i < 8; i++, addr += 1) {
+        uint64_t _addr = wrap_address(env, addr);
+        a[i] = cpu_ldb_mmu(env, _addr, oi, ra);
+    }
+}
+
+int cpacf_sha256(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                 uint64_t param_addr, uint64_t *message_reg, uint64_t *len_reg,
+                 uint32_t type)
+{
+    enum { MAX_BLOCKS_PER_RUN = 128 }; /* 128 * 64 = 8K */
+    uint64_t len = *len_reg, processed = 0;
+    int i, message_reg_len = 64;
+    uint32_t a[8];
+
+    g_assert(type == S390_FEAT_TYPE_KIMD || type == S390_FEAT_TYPE_KLMD);
+
+    if (!(env->psw.mask & PSW_MASK_64)) {
+        len = (uint32_t)len;
+        message_reg_len = (env->psw.mask & PSW_MASK_32) ? 32 : 24;
+    }
+
+    /* KIMD: length has to be properly aligned. */
+    if (type == S390_FEAT_TYPE_KIMD && !QEMU_IS_ALIGNED(len, 64)) {
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    sha256_read_icv(env, mmu_idx, param_addr, a, ra);
+
+    /* Process full blocks first. */
+    for (; len >= 64; len -= 64, processed += 64) {
+        uint32_t w[16];
+
+        if (processed >= MAX_BLOCKS_PER_RUN * 64) {
+            break;
+        }
+
+        sha256_read_block(env, mmu_idx, *message_reg + processed, w, ra);
+        sha256_bda(a, w);
+    }
+
+    /* KLMD: Process partial/empty block last. */
+    if (type == S390_FEAT_TYPE_KLMD && len < 64) {
+        const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
+        uint8_t x[64];
+
+        /* Read the remainder of the message byte-per-byte. */
+        for (i = 0; i < len; i++) {
+            uint64_t addr = wrap_address(env, *message_reg + processed + i);
+
+            x[i] = cpu_ldb_mmu(env, addr, oi, ra);
+        }
+        /* Pad the remainder with zero and set the top bit. */
+        memset(x + len, 0, 64 - len);
+        x[len] = 0x80;
+
+        /*
+         * Place the MBL either into this block (if there is space left),
+         * or use an additional one.
+         */
+        if (len < 56) {
+            sha256_read_mbl_be32(env, mmu_idx, param_addr + 32, x + 56, ra);
+        }
+        sha256_bda_be32(a, (uint32_t *)x);
+
+        if (len >= 56) {
+            memset(x, 0, 56);
+            sha256_read_mbl_be32(env, mmu_idx, param_addr + 32, x + 56, ra);
+            sha256_bda_be32(a, (uint32_t *)x);
+        }
+
+        processed += len;
+        len = 0;
+    }
+
+    /*
+     * Modify memory after we read all inputs and modify registers only after
+     * writing memory succeeded.
+     *
+     * TODO: if writing fails halfway through (e.g., when crossing page
+     * boundaries), we're in trouble. We'd need something like access_prepare().
+     */
+    sha256_write_ocv(env, mmu_idx, param_addr, a, ra);
+    *message_reg = deposit64(*message_reg, 0, message_reg_len,
+                             *message_reg + processed);
+    *len_reg -= processed;
+    return !len ? 0 : 3;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index d731fc6c2a..4e86a72433 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -53,6 +53,10 @@ static int cpacf_kimd(CPUS390XState *env, const int mmu_idx, const uintptr_t ra,
     int rc = 0;
 
     switch (fc) {
+    case 0x02: /* CPACF_KIMD_SHA_256 */
+        rc = cpacf_sha256(env, mmu_idx, ra, env->regs[1], &env->regs[r2],
+                          &env->regs[r2 + 1], S390_FEAT_TYPE_KIMD);
+        break;
     case 0x03: /* CPACF_KIMD_SHA_512 */
         rc = cpacf_sha512(env, mmu_idx, ra, env->regs[1], &env->regs[r2],
                           &env->regs[r2 + 1], S390_FEAT_TYPE_KIMD);
@@ -70,6 +74,10 @@ static int cpacf_klmd(CPUS390XState *env, const int mmu_idx, const uintptr_t ra,
     int rc = 0;
 
     switch (fc) {
+    case 0x02: /* CPACF_KLMD_SHA_256 */
+        rc = cpacf_sha256(env, mmu_idx, ra, env->regs[1], &env->regs[r2],
+                          &env->regs[r2 + 1], S390_FEAT_TYPE_KLMD);
+        break;
     case 0x03: /* CPACF_KLMD_SHA_512 */
         rc = cpacf_sha512(env, mmu_idx, ra, env->regs[1], &env->regs[r2],
                           &env->regs[r2 + 1], S390_FEAT_TYPE_KLMD);
diff --git a/target/s390x/tcg/meson.build b/target/s390x/tcg/meson.build
index 54a87393a3..8ae8da9708 100644
--- a/target/s390x/tcg/meson.build
+++ b/target/s390x/tcg/meson.build
@@ -5,6 +5,7 @@ s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
 ))
 s390x_common_ss.add(when: 'CONFIG_TCG', if_true: files(
   'cc_helper.c',
+  'cpacf_sha256.c',
   'cpacf_sha512.c',
   'crypto_helper.c',
   'excp_helper.c',
-- 
2.43.0

