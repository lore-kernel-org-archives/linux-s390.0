Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3443A9014
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782288649; cv=none; b=DOlweggnBX0nRz/KhiDLZVdXosWT2dCyEpJ0BDgnxMdzDZK8/6tng84sqSL67a+PJNsvChb6ypXWjhcvdP8cG8ryCtQj1CV23dOVz1IM3HMsupWzrxbwETOuorKuGuSUTuIQPffZRxHB++XNjfFfTEL/jQ+Fv2QtM9Yv2GxIQHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782288649; c=relaxed/simple;
	bh=vtyJrlO8zI2Z0qZRiwWxMojUw9Yq0L/aTGZ4HlBCkqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRaGWbjQv8yAx2ae8ppe144+2eZOcg4Rsa7mIE/wLa3swAcbL6AtBbOCV2DR874pxpS7adpbA8hDau2sSoiFwU0a4bgNF3U0rgiAwXXhmMOurhIq3SsnVvy92WBR1b4vyN5A8+w/GXmlt52sYDm0WFQd5TPpdylA4B7eCxUferE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dQamBkHs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dQamBkHs"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O6IIjt4182838;
	Wed, 24 Jun 2026 08:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VgAfBzTgf7FdMuaAF
	vNZmWjEtf9jq0kiETkVMmmbIUI=; b=dQamBkHsFCA6HYIZ6jcV5DcW2DKgflqzc
	COtHp/wxcQs0ZlnXdBpPBKT6JKNmn//WHYNaZcv5oSXWiXkPsixmTzGMRsF8RMqH
	FT64CU3ldA6zRrhuurQ1vKBUkp+/t47eDeFAv0DHhqJBTyaAc4nRXOqeyhPRzLi9
	xdonZsxvfJOsfM2mFYZIrDecCADL5/VjDvuNJvqBvV++CBN7++T2Jv1peVlEm1kf
	iOCIxw+N7UsaTZ9KGR81cZCw9EShzhXa5GKIUuMNZbJcEGpNSVv5aEyGXyQCdV7e
	ihb0+1Wi7pf8hslf3OreZ95sena8enYaYidObOMjDtIjuQNF6GKMw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgsttd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:10:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65O84dTL017273;
	Wed, 24 Jun 2026 08:10:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phfgv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:10:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65O8AVZc29688110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 08:10:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5820820040;
	Wed, 24 Jun 2026 08:10:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0333E20043;
	Wed, 24 Jun 2026 08:10:31 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.224.92.54])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 08:10:30 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v8 03/18] target/s390x: Move cpacf sha512 code into a new file
Date: Wed, 24 Jun 2026 10:10:00 +0200
Message-ID: <20260624081029.23815-4-freude@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfX8Q6vvGPvZPj1
 8xEWwUPHp7fAhvI2XoVsSXhdSPbnfgnzjZjRxFwXA4YNOiXBZD01mBT/Jf3mUv4evTa15KWwcHg
 IqP0MJ3OM/kQYrJeyo3kcDdLvErDNfMHT8pXHUz32lzEnN5JK3SYhALg49bQyMVU4sYJ3FbMHY3
 Yrh+2gHo3veOF/UjJgc9+LL20+4EtMkb8oXjMvxh1h9C2B2uRlNpy5oDwlFkNAUoK5oBpK8lPgs
 W50+m34uR5KSXhqJAcOT018WkXppVrP5a4Qcd43shjcBv2qeCp4d82Sy0C+TSRANL3NUZSbqV9d
 KlOwtFavLhxGTfc6lFwdh/Xu7blz4q8eCT3+0PatIYv4qbVqVFsoo9JQKdCHrSZ0EBz9Ae/4QXS
 RPqTIWXLSIyoxjSP/Tsy2APVQrGetQ==
X-Proofpoint-GUID: ogdFahZC6MRD_ATJCXJB48_G2_g7u26z
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfX0TqVaJVw0Wh6
 kh2Co24xRzfn5jh5FbkIl1eepBhl3gIta5MEjZ289VGIK32/T6ozcl2ZjMva/m0L4BqA4WWH/7o
 Ps+sRSJ13QxCslubhuRrck8CNwbepqY=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3b90fc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=UGG5zPGqAAAA:8
 a=o9TamEWjRyXov50siisA:9 a=17ibUXfGiVyGqR_YBevW:22
X-Proofpoint-ORIG-GUID: ogdFahZC6MRD_ATJCXJB48_G2_g7u26z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240063

Move the cpacf sha512 implementation into a new file
cpacf_sha512.c. Add this new file to the build and add a
new header file cpacf.h containing the prototypes for the
s390 cpacf stuff.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
---
 target/s390x/tcg/cpacf.h         |  19 +++
 target/s390x/tcg/cpacf_sha512.c  | 245 +++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c | 227 +---------------------------
 target/s390x/tcg/meson.build     |   1 +
 4 files changed, 266 insertions(+), 226 deletions(-)
 create mode 100644 target/s390x/tcg/cpacf.h
 create mode 100644 target/s390x/tcg/cpacf_sha512.c

diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
new file mode 100644
index 0000000000..a6e68f17c3
--- /dev/null
+++ b/target/s390x/tcg/cpacf.h
@@ -0,0 +1,19 @@
+/*
+ * s390x cpacf
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef S390X_CPACF_H
+#define S390X_CPACF_H
+
+#include "cpu.h"
+#include <stdint.h>
+
+/* from cpacf_sha512.c */
+int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                 uint64_t param_addr, uint64_t *message_reg, uint64_t *len_reg,
+                 uint32_t type);
+
+#endif
diff --git a/target/s390x/tcg/cpacf_sha512.c b/target/s390x/tcg/cpacf_sha512.c
new file mode 100644
index 0000000000..4ea4c63d0e
--- /dev/null
+++ b/target/s390x/tcg/cpacf_sha512.c
@@ -0,0 +1,245 @@
+/*
+ *  s390 cpacf sha512
+ *
+ *  Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ *
+ *  Authors:
+ *   Jason A. Donenfeld <Jason@zx2c4.com>
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
+        uint64_t _addr = wrap_address(env, addr);
+        a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
+    }
+}
+
+static void sha512_write_ocv(CPUS390XState *env, const int mmu_idx,
+                             uint64_t addr, uint64_t a[8], uintptr_t ra)
+{
+    const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
+
+    for (int i = 0; i < 8; i++, addr += 8) {
+        uint64_t _addr = wrap_address(env, addr);
+        cpu_stq_mmu(env, _addr, a[i], oi, ra);
+    }
+}
+
+static void sha512_read_block(CPUS390XState *env, const int mmu_idx,
+                              uint64_t addr, uint64_t a[16], uintptr_t ra)
+{
+    const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
+
+    for (int i = 0; i < 16; i++, addr += 8) {
+        uint64_t _addr = wrap_address(env, addr);
+        a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
+    }
+}
+
+static void sha512_read_mbl_be64(CPUS390XState *env, const int mmu_idx,
+                                 uint64_t addr, uint8_t a[16], uintptr_t ra)
+{
+    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
+
+    for (int i = 0; i < 16; i++, addr += 1) {
+        uint64_t _addr = wrap_address(env, addr);
+        a[i] = cpu_ldb_mmu(env, _addr, oi, ra);
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
index f5189ce1c5..d731fc6c2a 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -19,232 +19,7 @@
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst-common.h"
 #include "accel/tcg/cpu-mmu-index.h"
-
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
-        uint64_t _addr = wrap_address(env, addr);
-        a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
-    }
-}
-
-static void sha512_write_ocv(CPUS390XState *env, const int mmu_idx,
-                             uint64_t addr, uint64_t a[8], uintptr_t ra)
-{
-    const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
-
-    for (int i = 0; i < 8; i++, addr += 8) {
-        uint64_t _addr = wrap_address(env, addr);
-        cpu_stq_mmu(env, _addr, a[i], oi, ra);
-    }
-}
-
-static void sha512_read_block(CPUS390XState *env, const int mmu_idx,
-                              uint64_t addr, uint64_t a[16], uintptr_t ra)
-{
-    const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
-
-    for (int i = 0; i < 16; i++, addr += 8) {
-        uint64_t _addr = wrap_address(env, addr);
-        a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
-    }
-}
-
-static void sha512_read_mbl_be64(CPUS390XState *env, const int mmu_idx,
-                                 uint64_t addr, uint8_t a[16], uintptr_t ra)
-{
-    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
-
-    for (int i = 0; i < 16; i++, addr += 1) {
-        uint64_t _addr = wrap_address(env, addr);
-        a[i] = cpu_ldb_mmu(env, _addr, oi, ra);
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
+#include "cpacf.h"
 
 static void fill_buf_random(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                             uint64_t *buf_reg, uint64_t *len_reg)
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

