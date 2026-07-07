Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10643430CDC
	for <linux-s390@vger.kernel.org>; Tue,  7 Jul 2026 16:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441139; cv=none; b=seHjXWElA7prkVM6LXY74+LRfmn8HKUtPgycRPHOolvflldM95JPOrrT3zFP7g6On1dGWbnkdrqUz3QD1kC7O6yRXyWJAbzU8aRq5HwFBKm0Q7CmVyQNU6NfQhQgAXeSf4CotKlFkvudXBM18dC/zud06UQf7wxQRFxj2KkzK/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441139; c=relaxed/simple;
	bh=7sqGQtpNXKGdr/X71/9h8sClVTHV7kXwAXT53ZsQ3Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d73ZJUYMHSVxgI9CJg6PV+o0QkhfviukUl+RXINzhXrIUk7DVUZcF+GT/lpE13fyNjjVD+w/k1NhJ0VNWphi6Mzy+pNcQLSnwAKCvhpLE9THGMFqLXyPugtkIhEOQhlbO/elF+0igraKYPRlm0BljN2L6B13jkqtxkF4JCh9iKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GszWWHS1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GszWWHS1"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667FmJgS4186755;
	Tue, 7 Jul 2026 16:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RcRojTP2+D61U3KnU
	+owutMB50JZqxKWbt2nMiWtyDs=; b=GszWWHS1W1nzYFndC0k293Dr1b3zB3Qoq
	rgJVbcO00oJ+VQ9FQbLx7etGH2t7Vf6d/v4L3AbykJX9qv7f+z8MWxCjmb31FlD+
	SiDNAfA0JOYBFSoLEONnRxOrB1OjMZQAD9qdB9mj9xeUr7sMjnXz+nbvJeKrOKrB
	XSUoIVmRMKDqmaI85Vl25FXiwNqokW3pwjCmNHTFzd4WMBuUMKpg71IvUWY6F9ax
	ZBIaOjTn9dKHsSLRSLah2nuKB1I+Ax/OyfPs52mxwNssTXrqWNUFeuYUZ+D25QPv
	5ij6WZG8XkLdnG7UcU2wIki7mTKj34kl01qZj9MqQ6iINl93J8+Og==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3r809-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 16:18:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667G4cPC003230;
	Tue, 7 Jul 2026 16:18:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hbh8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 16:18:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 667GIE6B24052116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 16:18:14 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4A4320040;
	Tue,  7 Jul 2026 16:18:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B50F20043;
	Tue,  7 Jul 2026 16:18:14 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.140.5])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 16:18:14 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v11 03/21] target/s390x: Move cpacf sha512 code into a new file
Date: Tue,  7 Jul 2026 18:17:50 +0200
Message-ID: <20260707161815.40919-4-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707161815.40919-1-freude@linux.ibm.com>
References: <20260707161815.40919-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4d26cc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=UGG5zPGqAAAA:8
 a=yMKeI-deMsSePwiaAVEA:9 a=17ibUXfGiVyGqR_YBevW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE2MCBTYWx0ZWRfXycSC/6GWJS7D
 l1JCjoLv4FeieDI5dVzF3qHSWG+56orD3OpGAXRbwZXQTr0GzhmZBYLTCRTjVp74JJcqoGDYMw6
 myezkH141CVSmGdeeCYMK4aDH68cimA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE2MCBTYWx0ZWRfX/3jkVlqnRBqs
 vFGXT79YZQxH74VDY9agC38jchWSWk3DdTVw9Q58yvPBHvOk84IEQtV03Ck1kghFuaHHWmBd7Xc
 sA1XOFPNt+9fJTbbOfKsDr+Wa2KhKha2Jh+yoz9TyfWDu6fjuILwbCIajv3aXaXVI+fFW2HN396
 fP5soHKiIs2oiOZ+LDpQQB8W5BABAo1pSYGuQ9Slu0Oy5g0jMKMcsi3d4w9jfQ6NiiENkv9Ksn8
 b5m5UOUg2+I5Y3tb0za5kgxhCgdINzUNIKu2wabwVEaTrK/3cbsQY35bN/y8XluIpxq2Fo7dv8w
 mdpeuGBkq5Ln2r8My+Q8j7QJNiYKdjqLALd2R5c3W/Z5kO7m80pfb1kMJGiJs+mSQl8aMXpUwbH
 jCTruXdS9RIELRZhjQMgpivYriKlL9DVh7BAMvu+ygHXiNL3QhJ5O4wVNg61xzaeODV8dyNUnUV
 L6dSTGC9CCTX+7GjNzA==
X-Proofpoint-ORIG-GUID: S6hhuj_niadngHHiBpOXvkMfQtEf4y8O
X-Proofpoint-GUID: S6hhuj_niadngHHiBpOXvkMfQtEf4y8O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070160

Move the cpacf sha512 implementation into a new file
cpacf_sha512.c. Add this new file to the build and use the cpacf.h
header file storing function the prototypes.

Tested-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/tcg/cpacf.h         |   5 +
 target/s390x/tcg/cpacf_sha512.c  | 241 +++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c | 222 ----------------------------
 target/s390x/tcg/meson.build     |   1 +
 4 files changed, 247 insertions(+), 222 deletions(-)
 create mode 100644 target/s390x/tcg/cpacf_sha512.c

diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 49496d39ed..3b89bc5cd7 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -223,4 +223,9 @@
 #define CPACF_KDSA_PSIGN_ED25519   48
 #define CPACF_KDSA_PSIGN_ED448     52
 
+/* from cpacf_sha512.c */
+int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                 uint64_t param_addr, uint64_t *message_reg, uint64_t *len_reg,
+                 uint32_t type);
+
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_sha512.c b/target/s390x/tcg/cpacf_sha512.c
new file mode 100644
index 0000000000..ebfecc70f7
--- /dev/null
+++ b/target/s390x/tcg/cpacf_sha512.c
@@ -0,0 +1,241 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ *  s390 cpacf sha512
+ *
+ *  Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>.
+ *  All Rights Reserved.
+ *
+ *  Authors:
+ *   Jason A. Donenfeld <Jason@zx2c4.com>
+ */
+
+#include "qemu/osdep.h"
+#include "s390x-internal.h"
+#include "tcg_s390x.h"
+#include "exec/helper-proto.h"
+#include "accel/tcg/cpu-ldst-common.h"
+#include "accel/tcg/cpu-mmu-index.h"
+#include "target/s390x/tcg/cpacf.h"
+
+static uint64_t R(uint64_t x, int c)
+{
+    return (x >> c) | (x << (64 - c));
+}
+static uint64_t Ch(uint64_t x, uint64_t y, uint64_t z)
+{
+    return (x & y) ^ (~x & z);
+}
+static uint64_t Maj(uint64_t x, uint64_t y, uint64_t z)
+{
+    return (x & y) ^ (x & z) ^ (y & z);
+}
+static uint64_t Sigma0(uint64_t x)
+{
+    return R(x, 28) ^ R(x, 34) ^ R(x, 39);
+}
+static uint64_t Sigma1(uint64_t x)
+{
+    return R(x, 14) ^ R(x, 18) ^ R(x, 41);
+}
+static uint64_t sigma0(uint64_t x)
+{
+    return R(x, 1) ^ R(x, 8) ^ (x >> 7);
+}
+static uint64_t sigma1(uint64_t x)
+{
+    return R(x, 19) ^ R(x, 61) ^ (x >> 6);
+}
+
+static const uint64_t K[80] = {
+    0x428a2f98d728ae22ULL, 0x7137449123ef65cdULL, 0xb5c0fbcfec4d3b2fULL,
+    0xe9b5dba58189dbbcULL, 0x3956c25bf348b538ULL, 0x59f111f1b605d019ULL,
+    0x923f82a4af194f9bULL, 0xab1c5ed5da6d8118ULL, 0xd807aa98a3030242ULL,
+    0x12835b0145706fbeULL, 0x243185be4ee4b28cULL, 0x550c7dc3d5ffb4e2ULL,
+    0x72be5d74f27b896fULL, 0x80deb1fe3b1696b1ULL, 0x9bdc06a725c71235ULL,
+    0xc19bf174cf692694ULL, 0xe49b69c19ef14ad2ULL, 0xefbe4786384f25e3ULL,
+    0x0fc19dc68b8cd5b5ULL, 0x240ca1cc77ac9c65ULL, 0x2de92c6f592b0275ULL,
+    0x4a7484aa6ea6e483ULL, 0x5cb0a9dcbd41fbd4ULL, 0x76f988da831153b5ULL,
+    0x983e5152ee66dfabULL, 0xa831c66d2db43210ULL, 0xb00327c898fb213fULL,
+    0xbf597fc7beef0ee4ULL, 0xc6e00bf33da88fc2ULL, 0xd5a79147930aa725ULL,
+    0x06ca6351e003826fULL, 0x142929670a0e6e70ULL, 0x27b70a8546d22ffcULL,
+    0x2e1b21385c26c926ULL, 0x4d2c6dfc5ac42aedULL, 0x53380d139d95b3dfULL,
+    0x650a73548baf63deULL, 0x766a0abb3c77b2a8ULL, 0x81c2c92e47edaee6ULL,
+    0x92722c851482353bULL, 0xa2bfe8a14cf10364ULL, 0xa81a664bbc423001ULL,
+    0xc24b8b70d0f89791ULL, 0xc76c51a30654be30ULL, 0xd192e819d6ef5218ULL,
+    0xd69906245565a910ULL, 0xf40e35855771202aULL, 0x106aa07032bbd1b8ULL,
+    0x19a4c116b8d2d0c8ULL, 0x1e376c085141ab53ULL, 0x2748774cdf8eeb99ULL,
+    0x34b0bcb5e19b48a8ULL, 0x391c0cb3c5c95a63ULL, 0x4ed8aa4ae3418acbULL,
+    0x5b9cca4f7763e373ULL, 0x682e6ff3d6b2b8a3ULL, 0x748f82ee5defb2fcULL,
+    0x78a5636f43172f60ULL, 0x84c87814a1f0ab72ULL, 0x8cc702081a6439ecULL,
+    0x90befffa23631e28ULL, 0xa4506cebde82bde9ULL, 0xbef9a3f7b2c67915ULL,
+    0xc67178f2e372532bULL, 0xca273eceea26619cULL, 0xd186b8c721c0c207ULL,
+    0xeada7dd6cde0eb1eULL, 0xf57d4f7fee6ed178ULL, 0x06f067aa72176fbaULL,
+    0x0a637dc5a2c898a6ULL, 0x113f9804bef90daeULL, 0x1b710b35131c471bULL,
+    0x28db77f523047d84ULL, 0x32caab7b40c72493ULL, 0x3c9ebe0a15c9bebcULL,
+    0x431d67c49c100d4cULL, 0x4cc5d4becb3e42b6ULL, 0x597f299cfc657e2aULL,
+    0x5fcb6fab3ad6faecULL, 0x6c44198c4a475817ULL
+};
+
+/* a is icv/ocv, w is a single message block. w will get reused internally. */
+static void sha512_bda(uint64_t a[8], uint64_t w[16])
+{
+    uint64_t t, z[8], b[8];
+    int i, j;
+
+    memcpy(z, a, sizeof(z));
+    for (i = 0; i < 80; i++) {
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
+/* a is icv/ocv, w is a single message block that needs be64 conversion. */
+static void sha512_bda_be64(uint64_t a[8], uint64_t w[16])
+{
+    uint64_t t[16];
+    int i;
+
+    for (i = 0; i < 16; i++) {
+        t[i] = be64_to_cpu(w[i]);
+    }
+    sha512_bda(a, t);
+}
+
+static void sha512_read_icv(CPUS390XState *env, const int mmu_idx,
+                            uint64_t addr, uint64_t a[8], uintptr_t ra)
+{
+    const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
+
+    for (int i = 0; i < 8; i++, addr += 8) {
+        a[i] = cpu_ldq_mmu(env, wrap_address(env, addr), oi, ra);
+    }
+}
+
+static void sha512_write_ocv(CPUS390XState *env, const int mmu_idx,
+                             uint64_t addr, uint64_t a[8], uintptr_t ra)
+{
+    const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
+
+    for (int i = 0; i < 8; i++, addr += 8) {
+        cpu_stq_mmu(env, wrap_address(env, addr), a[i], oi, ra);
+    }
+}
+
+static void sha512_read_block(CPUS390XState *env, const int mmu_idx,
+                              uint64_t addr, uint64_t a[16], uintptr_t ra)
+{
+    const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
+
+    for (int i = 0; i < 16; i++, addr += 8) {
+        a[i] = cpu_ldq_mmu(env, wrap_address(env, addr), oi, ra);
+    }
+}
+
+static void sha512_read_mbl_be64(CPUS390XState *env, const int mmu_idx,
+                                 uint64_t addr, uint8_t a[16], uintptr_t ra)
+{
+    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
+
+    for (int i = 0; i < 16; i++, addr += 1) {
+        a[i] = cpu_ldb_mmu(env, wrap_address(env, addr), oi, ra);
+    }
+}
+
+int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                 uint64_t param_addr, uint64_t *message_reg, uint64_t *len_reg,
+                 uint32_t type)
+{
+    enum { MAX_BLOCKS_PER_RUN = 64 }; /* Arbitrary: keep interactivity. */
+    uint64_t len = *len_reg, a[8], processed = 0;
+    int i, message_reg_len = 64;
+
+    g_assert(type == S390_FEAT_TYPE_KIMD || type == S390_FEAT_TYPE_KLMD);
+
+    if (!(env->psw.mask & PSW_MASK_64)) {
+        len = (uint32_t)len;
+        message_reg_len = (env->psw.mask & PSW_MASK_32) ? 32 : 24;
+    }
+
+    /* KIMD: length has to be properly aligned. */
+    if (type == S390_FEAT_TYPE_KIMD && !QEMU_IS_ALIGNED(len, 128)) {
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    sha512_read_icv(env, mmu_idx, param_addr, a, ra);
+
+    /* Process full blocks first. */
+    for (; len >= 128; len -= 128, processed += 128) {
+        uint64_t w[16];
+
+        if (processed >= MAX_BLOCKS_PER_RUN * 128) {
+            break;
+        }
+
+        sha512_read_block(env, mmu_idx, *message_reg + processed, w, ra);
+        sha512_bda(a, w);
+    }
+
+    /* KLMD: Process partial/empty block last. */
+    if (type == S390_FEAT_TYPE_KLMD && len < 128) {
+        const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
+        uint8_t x[128];
+
+        /* Read the remainder of the message byte-per-byte. */
+        for (i = 0; i < len; i++) {
+            uint64_t addr = wrap_address(env, *message_reg + processed + i);
+
+            x[i] = cpu_ldb_mmu(env, addr, oi, ra);
+        }
+        /* Pad the remainder with zero and set the top bit. */
+        memset(x + len, 0, 128 - len);
+        x[len] = 128;
+
+        /*
+         * Place the MBL either into this block (if there is space left),
+         * or use an additional one.
+         */
+        if (len < 112) {
+            sha512_read_mbl_be64(env, mmu_idx, param_addr + 64, x + 112, ra);
+        }
+        sha512_bda_be64(a, (uint64_t *)x);
+
+        if (len >= 112) {
+            memset(x, 0, 112);
+            sha512_read_mbl_be64(env, mmu_idx, param_addr + 64, x + 112, ra);
+            sha512_bda_be64(a, (uint64_t *)x);
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
+    sha512_write_ocv(env, mmu_idx, param_addr, a, ra);
+    *message_reg = deposit64(*message_reg, 0, message_reg_len,
+                             *message_reg + processed);
+    *len_reg -= processed;
+    return !len ? 0 : 3;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 987bc72ae9..dba46baa0d 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -21,228 +21,6 @@
 #include "accel/tcg/cpu-mmu-index.h"
 #include "target/s390x/tcg/cpacf.h"
 
-static uint64_t R(uint64_t x, int c)
-{
-    return (x >> c) | (x << (64 - c));
-}
-static uint64_t Ch(uint64_t x, uint64_t y, uint64_t z)
-{
-    return (x & y) ^ (~x & z);
-}
-static uint64_t Maj(uint64_t x, uint64_t y, uint64_t z)
-{
-    return (x & y) ^ (x & z) ^ (y & z);
-}
-static uint64_t Sigma0(uint64_t x)
-{
-    return R(x, 28) ^ R(x, 34) ^ R(x, 39);
-}
-static uint64_t Sigma1(uint64_t x)
-{
-    return R(x, 14) ^ R(x, 18) ^ R(x, 41);
-}
-static uint64_t sigma0(uint64_t x)
-{
-    return R(x, 1) ^ R(x, 8) ^ (x >> 7);
-}
-static uint64_t sigma1(uint64_t x)
-{
-    return R(x, 19) ^ R(x, 61) ^ (x >> 6);
-}
-
-static const uint64_t K[80] = {
-    0x428a2f98d728ae22ULL, 0x7137449123ef65cdULL, 0xb5c0fbcfec4d3b2fULL,
-    0xe9b5dba58189dbbcULL, 0x3956c25bf348b538ULL, 0x59f111f1b605d019ULL,
-    0x923f82a4af194f9bULL, 0xab1c5ed5da6d8118ULL, 0xd807aa98a3030242ULL,
-    0x12835b0145706fbeULL, 0x243185be4ee4b28cULL, 0x550c7dc3d5ffb4e2ULL,
-    0x72be5d74f27b896fULL, 0x80deb1fe3b1696b1ULL, 0x9bdc06a725c71235ULL,
-    0xc19bf174cf692694ULL, 0xe49b69c19ef14ad2ULL, 0xefbe4786384f25e3ULL,
-    0x0fc19dc68b8cd5b5ULL, 0x240ca1cc77ac9c65ULL, 0x2de92c6f592b0275ULL,
-    0x4a7484aa6ea6e483ULL, 0x5cb0a9dcbd41fbd4ULL, 0x76f988da831153b5ULL,
-    0x983e5152ee66dfabULL, 0xa831c66d2db43210ULL, 0xb00327c898fb213fULL,
-    0xbf597fc7beef0ee4ULL, 0xc6e00bf33da88fc2ULL, 0xd5a79147930aa725ULL,
-    0x06ca6351e003826fULL, 0x142929670a0e6e70ULL, 0x27b70a8546d22ffcULL,
-    0x2e1b21385c26c926ULL, 0x4d2c6dfc5ac42aedULL, 0x53380d139d95b3dfULL,
-    0x650a73548baf63deULL, 0x766a0abb3c77b2a8ULL, 0x81c2c92e47edaee6ULL,
-    0x92722c851482353bULL, 0xa2bfe8a14cf10364ULL, 0xa81a664bbc423001ULL,
-    0xc24b8b70d0f89791ULL, 0xc76c51a30654be30ULL, 0xd192e819d6ef5218ULL,
-    0xd69906245565a910ULL, 0xf40e35855771202aULL, 0x106aa07032bbd1b8ULL,
-    0x19a4c116b8d2d0c8ULL, 0x1e376c085141ab53ULL, 0x2748774cdf8eeb99ULL,
-    0x34b0bcb5e19b48a8ULL, 0x391c0cb3c5c95a63ULL, 0x4ed8aa4ae3418acbULL,
-    0x5b9cca4f7763e373ULL, 0x682e6ff3d6b2b8a3ULL, 0x748f82ee5defb2fcULL,
-    0x78a5636f43172f60ULL, 0x84c87814a1f0ab72ULL, 0x8cc702081a6439ecULL,
-    0x90befffa23631e28ULL, 0xa4506cebde82bde9ULL, 0xbef9a3f7b2c67915ULL,
-    0xc67178f2e372532bULL, 0xca273eceea26619cULL, 0xd186b8c721c0c207ULL,
-    0xeada7dd6cde0eb1eULL, 0xf57d4f7fee6ed178ULL, 0x06f067aa72176fbaULL,
-    0x0a637dc5a2c898a6ULL, 0x113f9804bef90daeULL, 0x1b710b35131c471bULL,
-    0x28db77f523047d84ULL, 0x32caab7b40c72493ULL, 0x3c9ebe0a15c9bebcULL,
-    0x431d67c49c100d4cULL, 0x4cc5d4becb3e42b6ULL, 0x597f299cfc657e2aULL,
-    0x5fcb6fab3ad6faecULL, 0x6c44198c4a475817ULL
-};
-
-/* a is icv/ocv, w is a single message block. w will get reused internally. */
-static void sha512_bda(uint64_t a[8], uint64_t w[16])
-{
-    uint64_t t, z[8], b[8];
-    int i, j;
-
-    memcpy(z, a, sizeof(z));
-    for (i = 0; i < 80; i++) {
-        memcpy(b, a, sizeof(b));
-
-        t = a[7] + Sigma1(a[4]) + Ch(a[4], a[5], a[6]) + K[i] + w[i % 16];
-        b[7] = t + Sigma0(a[0]) + Maj(a[0], a[1], a[2]);
-        b[3] += t;
-        for (j = 0; j < 8; ++j) {
-            a[(j + 1) % 8] = b[j];
-        }
-        if (i % 16 == 15) {
-            for (j = 0; j < 16; ++j) {
-                w[j] += w[(j + 9) % 16] + sigma0(w[(j + 1) % 16]) +
-                        sigma1(w[(j + 14) % 16]);
-            }
-        }
-    }
-
-    for (i = 0; i < 8; i++) {
-        a[i] += z[i];
-    }
-}
-
-/* a is icv/ocv, w is a single message block that needs be64 conversion. */
-static void sha512_bda_be64(uint64_t a[8], uint64_t w[16])
-{
-    uint64_t t[16];
-    int i;
-
-    for (i = 0; i < 16; i++) {
-        t[i] = be64_to_cpu(w[i]);
-    }
-    sha512_bda(a, t);
-}
-
-static void sha512_read_icv(CPUS390XState *env, const int mmu_idx,
-                            uint64_t addr, uint64_t a[8], uintptr_t ra)
-{
-    const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
-
-    for (int i = 0; i < 8; i++, addr += 8) {
-        a[i] = cpu_ldq_mmu(env, wrap_address(env, addr), oi, ra);
-    }
-}
-
-static void sha512_write_ocv(CPUS390XState *env, const int mmu_idx,
-                             uint64_t addr, uint64_t a[8], uintptr_t ra)
-{
-    const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
-
-    for (int i = 0; i < 8; i++, addr += 8) {
-        cpu_stq_mmu(env, wrap_address(env, addr), a[i], oi, ra);
-    }
-}
-
-static void sha512_read_block(CPUS390XState *env, const int mmu_idx,
-                              uint64_t addr, uint64_t a[16], uintptr_t ra)
-{
-    const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
-
-    for (int i = 0; i < 16; i++, addr += 8) {
-        a[i] = cpu_ldq_mmu(env, wrap_address(env, addr), oi, ra);
-    }
-}
-
-static void sha512_read_mbl_be64(CPUS390XState *env, const int mmu_idx,
-                                 uint64_t addr, uint8_t a[16], uintptr_t ra)
-{
-    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
-
-    for (int i = 0; i < 16; i++, addr += 1) {
-        a[i] = cpu_ldb_mmu(env, wrap_address(env, addr), oi, ra);
-    }
-}
-
-static int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
-                        uint64_t param_addr, uint64_t *message_reg,
-                        uint64_t *len_reg, uint32_t type)
-{
-    enum { MAX_BLOCKS_PER_RUN = 64 }; /* Arbitrary: keep interactivity. */
-    uint64_t len = *len_reg, a[8], processed = 0;
-    int i, message_reg_len = 64;
-
-    g_assert(type == S390_FEAT_TYPE_KIMD || type == S390_FEAT_TYPE_KLMD);
-
-    if (!(env->psw.mask & PSW_MASK_64)) {
-        len = (uint32_t)len;
-        message_reg_len = (env->psw.mask & PSW_MASK_32) ? 32 : 24;
-    }
-
-    /* KIMD: length has to be properly aligned. */
-    if (type == S390_FEAT_TYPE_KIMD && !QEMU_IS_ALIGNED(len, 128)) {
-        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
-    }
-
-    sha512_read_icv(env, mmu_idx, param_addr, a, ra);
-
-    /* Process full blocks first. */
-    for (; len >= 128; len -= 128, processed += 128) {
-        uint64_t w[16];
-
-        if (processed >= MAX_BLOCKS_PER_RUN * 128) {
-            break;
-        }
-
-        sha512_read_block(env, mmu_idx, *message_reg + processed, w, ra);
-        sha512_bda(a, w);
-    }
-
-    /* KLMD: Process partial/empty block last. */
-    if (type == S390_FEAT_TYPE_KLMD && len < 128) {
-        const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
-        uint8_t x[128];
-
-        /* Read the remainder of the message byte-per-byte. */
-        for (i = 0; i < len; i++) {
-            uint64_t addr = wrap_address(env, *message_reg + processed + i);
-
-            x[i] = cpu_ldb_mmu(env, addr, oi, ra);
-        }
-        /* Pad the remainder with zero and set the top bit. */
-        memset(x + len, 0, 128 - len);
-        x[len] = 128;
-
-        /*
-         * Place the MBL either into this block (if there is space left),
-         * or use an additional one.
-         */
-        if (len < 112) {
-            sha512_read_mbl_be64(env, mmu_idx, param_addr + 64, x + 112, ra);
-        }
-        sha512_bda_be64(a, (uint64_t *)x);
-
-        if (len >= 112) {
-            memset(x, 0, 112);
-            sha512_read_mbl_be64(env, mmu_idx, param_addr + 64, x + 112, ra);
-            sha512_bda_be64(a, (uint64_t *)x);
-        }
-
-        processed += len;
-        len = 0;
-    }
-
-    /*
-     * Modify memory after we read all inputs and modify registers only after
-     * writing memory succeeded.
-     *
-     * TODO: if writing fails halfway through (e.g., when crossing page
-     * boundaries), we're in trouble. We'd need something like access_prepare().
-     */
-    sha512_write_ocv(env, mmu_idx, param_addr, a, ra);
-    *message_reg = deposit64(*message_reg, 0, message_reg_len,
-                             *message_reg + processed);
-    *len_reg -= processed;
-    return !len ? 0 : 3;
-}
-
 static void fill_buf_random(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                             uint64_t *buf_reg, uint64_t *len_reg)
 {
diff --git a/target/s390x/tcg/meson.build b/target/s390x/tcg/meson.build
index 36cb0e079e..54a87393a3 100644
--- a/target/s390x/tcg/meson.build
+++ b/target/s390x/tcg/meson.build
@@ -5,6 +5,7 @@ s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
 ))
 s390x_common_ss.add(when: 'CONFIG_TCG', if_true: files(
   'cc_helper.c',
+  'cpacf_sha512.c',
   'crypto_helper.c',
   'excp_helper.c',
   'fpu_helper.c',
-- 
2.43.0

