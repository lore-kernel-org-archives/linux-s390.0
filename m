Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC272376468
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560349; cv=none; b=LAUG9B2SDXLb7apQLHmo91sSAjImjARCfFuJv3bAtfsnkSyKc9ifheOAK0gbDjtMGuXbO2wGkMetlRy3dfZjiAdaeivfFWZptFoYB+AqVEjDMjKXFv2H9O+jVrphDfRt+8bc2uWM3HpiCdNzaNmVk1CLx1+6xyOK10F5CmTzkOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560349; c=relaxed/simple;
	bh=/IOc64wAMlR0BuRkXWsHwyfBdq/zAKWu3ysKeb+EsF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o94L+JXymPQ8EEuKtLSjC5UcNbidbX1bYXyWmOD0kgwnAz5OlSAJs2fmQheVMVKvBSm+1kqBhsAbihEb3Caf11XBRfwpQhJxdLzhCCHUKYv3cjCw/UnsoktOiDgcMvyP6B7zUx/3EZ/4RwyYsu0FJutXT+Y/W8QevTXMLjvp3mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YrQVTDOu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YrQVTDOu"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5VY4Z3283705;
	Mon, 24 Aug 2026 08:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4OIQIWLfpx82Yj08h
	2Cd9jytVzxj3ZZdmw4v/J/jI8Q=; b=YrQVTDOuwt2sLf85WnBwFBiVc9rPJm+gF
	ELKBE2Q5WCT1rSR1RkfOBKeS/9l4MfGTRS/mBqpKfz1UMQBW57nC+zEn1n/+L57H
	65LHNca0RPF52TkgqDggfBwXrVdS1Tg95Pg2fMS//xKiDGK4fIZg37YO7NumjVB4
	tjRAX3HQu0lndJQPzjhITfC1QPvaX34N1KKq2uf5Pr5P1KHbJ5+lFMs/7SnC+LM8
	BvkOeSPcwnQhoWpIZAqP226Y7s2ohTYtWsNb5Y00Bk8BQzNuUA/sPNsdgSjeklqX
	swlUgzIrBu0QljDtryGOLN2Diab1wv/IdJYo60VrhWSTKyIeNYcAQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqg1wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 08:32:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O8QONZ018160;
	Mon, 24 Aug 2026 08:32:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkgvr3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 08:32:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67O8W61P35586458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 08:32:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9272C20040;
	Mon, 24 Aug 2026 08:32:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53CB520043;
	Mon, 24 Aug 2026 08:32:06 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.131.174])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 08:32:06 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v16 05/20] target/s390x: Add helper functions for copy memory to and from guest
Date: Mon, 24 Aug 2026 10:31:49 +0200
Message-ID: <20260824083204.40877-6-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824083204.40877-1-freude@linux.ibm.com>
References: <20260824083204.40877-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SngIAamiCVhW1xfpw21-Lbxl8Po49s9v
X-Proofpoint-ORIG-GUID: SngIAamiCVhW1xfpw21-Lbxl8Po49s9v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3NCBTYWx0ZWRfXwfRhldsJgB+A
 2bcs4nd55RXmkmlt3zpBLy4DC3gzYt5JxWU+BoUogPTYVHa6SxZ8rFOOqzUFcdsK4JGbRTOWGZA
 W2CQCC0Y12yHZOK9CczmwoRl+HKTNBvpuauZOTAPSZzp3WW93JhXFPxcn9OEIvVnqx2G1zFNkCc
 2uKYZC5IQ2y10hMSmvOmOa+qmIiGRDVtYovJ0ofcTecVqYcqj52co/MDmoRwrO5bK/VOmJXfSGa
 LxinvL7lpDuWcBgdH1yhqcnIoawXoKIbZdjNpMAIN5E6zDVRXbWd8XRVZPReApTuAgE9RWCcPMg
 usIzzu12hsFH2r3kPm1jNyRIJd2nSiTcifaZN96slVeJhS5THll2QSZbOiDC8Vg1Bm068/XZ15G
 bM3JG/QJNR8hcweFSRc7fizBgMYPAQJz09NEoPHClv5O0I8YVamJzzCXeh8tafXTvjGEhNyz0we
 M4HvYddR236yOmIRHbA==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8c018c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=FyORFv3Am_Wt7j1hYGwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3NCBTYWx0ZWRfX5GMMsyONR3j5
 oj9FnggNuNySe9T9wH4CJ6KZZDiC+d1fllMf7KEftOZ84vjIf71KqStyHgH058+M/snQMn+IMiI
 RvVL5S+cn31RytUxMLH78WA8y05Eifk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240074

Add some simple helper functions to copy memory from guest to a local
buffer and the other way around:

- read_guest_wrap_u8()
- write_guest_wrap_u8()
- read_guest_wrap_u32()
- write_guest_wrap_u32()
- read_guest_wrap_u64()
- write_guest_wrap_u64()

The reader functions read from guest memory into an array of
u8/u32/u64 with BE conversion. Similar the writer functions write an
array of u8/u32/u64 into guest memory with BE conversion.

All these functions are intended to be used for the crypto
implementations thus are located in crypto_helper.h.

Rework and simplify the sha 256 and sha 512 implementations to use
these helper functions.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/cpacf_sha256.c  |  63 ++++---------------
 target/s390x/tcg/cpacf_sha512.c  |  63 ++++---------------
 target/s390x/tcg/crypto_helper.c |   1 +
 target/s390x/tcg/crypto_helper.h | 100 +++++++++++++++++++++++++++++++
 4 files changed, 123 insertions(+), 104 deletions(-)
 create mode 100644 target/s390x/tcg/crypto_helper.h

diff --git a/target/s390x/tcg/cpacf_sha256.c b/target/s390x/tcg/cpacf_sha256.c
index 30754dbdd4..67321b565c 100644
--- a/target/s390x/tcg/cpacf_sha256.c
+++ b/target/s390x/tcg/cpacf_sha256.c
@@ -19,6 +19,7 @@
 #include "accel/tcg/cpu-mmu-index.h"
 #include "target/s390x/tcg/cpacf-arch.h"
 #include "target/s390x/tcg/cpacf.h"
+#include "target/s390x/tcg/crypto_helper.h"
 
 static uint32_t R(uint32_t x, int c)
 {
@@ -104,53 +105,13 @@ static void sha256_bda_be32(uint32_t a[8], uint32_t w[16])
     sha256_bda(a, t);
 }
 
-static void sha256_read_icv(CPUS390XState *env, const int mmu_idx,
-                            uint64_t addr, uint32_t a[8], uintptr_t ra)
-{
-    const MemOpIdx oi = make_memop_idx(MO_BE | MO_32 | MO_UNALN, mmu_idx);
-
-    for (int i = 0; i < 8; i++, addr += 4) {
-        a[i] = cpu_ldl_mmu(env, wrap_address(env, addr), oi, ra);
-    }
-}
-
-static void sha256_write_ocv(CPUS390XState *env, const int mmu_idx,
-                             uint64_t addr, uint32_t a[8], uintptr_t ra)
-{
-    const MemOpIdx oi = make_memop_idx(MO_BE | MO_32 | MO_UNALN, mmu_idx);
-
-    for (int i = 0; i < 8; i++, addr += 4) {
-        cpu_stl_mmu(env, wrap_address(env, addr), a[i], oi, ra);
-    }
-}
-
-static void sha256_read_block(CPUS390XState *env, const int mmu_idx,
-                              uint64_t addr, uint32_t a[16], uintptr_t ra)
-{
-    const MemOpIdx oi = make_memop_idx(MO_BE | MO_32 | MO_UNALN, mmu_idx);
-
-    for (int i = 0; i < 16; i++, addr += 4) {
-        a[i] = cpu_ldl_mmu(env, wrap_address(env, addr), oi, ra);
-    }
-}
-
-static void sha256_read_mbl_be32(CPUS390XState *env, const int mmu_idx,
-                                 uint64_t addr, uint8_t a[8], uintptr_t ra)
-{
-    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
-
-    for (int i = 0; i < 8; i++, addr += 1) {
-        a[i] = cpu_ldb_mmu(env, wrap_address(env, addr), oi, ra);
-    }
-}
-
 int cpacf_sha256(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                  uint64_t param_addr, uint64_t *message_reg, uint64_t *len_reg,
                  uint32_t type)
 {
     enum { MAX_BLOCKS_PER_RUN = 128 }; /* 128 * 64 = 8K */
     uint64_t len = *len_reg, processed = 0;
-    int i, message_reg_len = 64;
+    int message_reg_len = 64;
     uint32_t a[8];
 
     g_assert(type == S390_FEAT_TYPE_KIMD || type == S390_FEAT_TYPE_KLMD);
@@ -165,7 +126,8 @@ int cpacf_sha256(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
-    sha256_read_icv(env, mmu_idx, param_addr, a, ra);
+    /* read icv (8 * u32) */
+    read_guest_wrap_u32(env, mmu_idx, ra, param_addr, a, 8);
 
     /* Process full blocks first. */
     for (; len >= 64; len -= 64, processed += 64) {
@@ -175,21 +137,18 @@ int cpacf_sha256(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
             break;
         }
 
-        sha256_read_block(env, mmu_idx, *message_reg + processed, w, ra);
+        /* read sha256 block (16 * u32) */
+        read_guest_wrap_u32(env, mmu_idx, ra, *message_reg + processed, w, 16);
         sha256_bda(a, w);
     }
 
     /* KLMD: Process partial/empty block last. */
     if (type == S390_FEAT_TYPE_KLMD && len < 64) {
-        const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
         uint8_t x[64];
 
-        /* Read the remainder of the message byte-per-byte. */
-        for (i = 0; i < len; i++) {
-            uint64_t addr = wrap_address(env, *message_reg + processed + i);
+        /* Read the remainder of the message. */
+        read_guest_wrap_u8(env, mmu_idx, ra, *message_reg + processed, x, len);
 
-            x[i] = cpu_ldb_mmu(env, addr, oi, ra);
-        }
         /* Pad the remainder with zero and set the top bit. */
         memset(x + len, 0, 64 - len);
         x[len] = 0x80;
@@ -199,13 +158,13 @@ int cpacf_sha256(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
          * or use an additional one.
          */
         if (len < 56) {
-            sha256_read_mbl_be32(env, mmu_idx, param_addr + 32, x + 56, ra);
+            read_guest_wrap_u8(env, mmu_idx, ra, param_addr + 32, x + 56, 8);
         }
         sha256_bda_be32(a, (uint32_t *)x);
 
         if (len >= 56) {
             memset(x, 0, 56);
-            sha256_read_mbl_be32(env, mmu_idx, param_addr + 32, x + 56, ra);
+            read_guest_wrap_u8(env, mmu_idx, ra, param_addr + 32, x + 56, 8);
             sha256_bda_be32(a, (uint32_t *)x);
         }
 
@@ -220,7 +179,7 @@ int cpacf_sha256(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
      * TODO: if writing fails halfway through (e.g., when crossing page
      * boundaries), we're in trouble. We'd need something like access_prepare().
      */
-    sha256_write_ocv(env, mmu_idx, param_addr, a, ra);
+    write_guest_wrap_u32(env, mmu_idx, ra, param_addr, a, 8);
     *message_reg = deposit64(*message_reg, 0, message_reg_len,
                              *message_reg + processed);
     *len_reg -= processed;
diff --git a/target/s390x/tcg/cpacf_sha512.c b/target/s390x/tcg/cpacf_sha512.c
index 2a1ff38c58..edd8dae78f 100644
--- a/target/s390x/tcg/cpacf_sha512.c
+++ b/target/s390x/tcg/cpacf_sha512.c
@@ -18,6 +18,7 @@
 #include "accel/tcg/cpu-mmu-index.h"
 #include "target/s390x/tcg/cpacf-arch.h"
 #include "target/s390x/tcg/cpacf.h"
+#include "target/s390x/tcg/crypto_helper.h"
 
 static uint64_t R(uint64_t x, int c)
 {
@@ -119,53 +120,13 @@ static void sha512_bda_be64(uint64_t a[8], uint64_t w[16])
     sha512_bda(a, t);
 }
 
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
 int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                  uint64_t param_addr, uint64_t *message_reg, uint64_t *len_reg,
                  uint32_t type)
 {
     enum { MAX_BLOCKS_PER_RUN = 64 }; /* Arbitrary: keep interactivity. */
     uint64_t len = *len_reg, a[8], processed = 0;
-    int i, message_reg_len = 64;
+    int message_reg_len = 64;
 
     g_assert(type == S390_FEAT_TYPE_KIMD || type == S390_FEAT_TYPE_KLMD);
 
@@ -179,7 +140,8 @@ int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
-    sha512_read_icv(env, mmu_idx, param_addr, a, ra);
+    /* read icv (8 * u64) */
+    read_guest_wrap_u64(env, mmu_idx, ra, param_addr, a, 8);
 
     /* Process full blocks first. */
     for (; len >= 128; len -= 128, processed += 128) {
@@ -189,21 +151,18 @@ int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
             break;
         }
 
-        sha512_read_block(env, mmu_idx, *message_reg + processed, w, ra);
+        /* read sha512 block (16 * u64) */
+        read_guest_wrap_u64(env, mmu_idx, ra, *message_reg + processed, w, 16);
         sha512_bda(a, w);
     }
 
     /* KLMD: Process partial/empty block last. */
     if (type == S390_FEAT_TYPE_KLMD && len < 128) {
-        const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
         uint8_t x[128];
 
-        /* Read the remainder of the message byte-per-byte. */
-        for (i = 0; i < len; i++) {
-            uint64_t addr = wrap_address(env, *message_reg + processed + i);
+        /* Read the remainder of the message. */
+        read_guest_wrap_u8(env, mmu_idx, ra, *message_reg + processed, x, len);
 
-            x[i] = cpu_ldb_mmu(env, addr, oi, ra);
-        }
         /* Pad the remainder with zero and set the top bit. */
         memset(x + len, 0, 128 - len);
         x[len] = 128;
@@ -213,13 +172,13 @@ int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
          * or use an additional one.
          */
         if (len < 112) {
-            sha512_read_mbl_be64(env, mmu_idx, param_addr + 64, x + 112, ra);
+            read_guest_wrap_u8(env, mmu_idx, ra, param_addr + 64, x + 112, 16);
         }
         sha512_bda_be64(a, (uint64_t *)x);
 
         if (len >= 112) {
             memset(x, 0, 112);
-            sha512_read_mbl_be64(env, mmu_idx, param_addr + 64, x + 112, ra);
+            read_guest_wrap_u8(env, mmu_idx, ra, param_addr + 64, x + 112, 16);
             sha512_bda_be64(a, (uint64_t *)x);
         }
 
@@ -234,7 +193,7 @@ int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
      * TODO: if writing fails halfway through (e.g., when crossing page
      * boundaries), we're in trouble. We'd need something like access_prepare().
      */
-    sha512_write_ocv(env, mmu_idx, param_addr, a, ra);
+    write_guest_wrap_u64(env, mmu_idx, ra, param_addr, a, 8);
     *message_reg = deposit64(*message_reg, 0, message_reg_len,
                              *message_reg + processed);
     *len_reg -= processed;
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 4d1b9a54f2..27decdda63 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -22,6 +22,7 @@
 #include "accel/tcg/cpu-mmu-index.h"
 #include "target/s390x/tcg/cpacf-arch.h"
 #include "target/s390x/tcg/cpacf.h"
+#include "target/s390x/tcg/crypto_helper.h"
 
 static int fill_buf_random(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                            uint64_t *buf_reg, uint64_t *len_reg)
diff --git a/target/s390x/tcg/crypto_helper.h b/target/s390x/tcg/crypto_helper.h
new file mode 100644
index 0000000000..2364e46029
--- /dev/null
+++ b/target/s390x/tcg/crypto_helper.h
@@ -0,0 +1,100 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Crypto helper functions
+ */
+
+#ifndef TARGET_S390_CRYPTO_HELPER_H
+#define TARGET_S390_CRYPTO_HELPER_H
+
+/*
+ * helper function to read len * u8 from guest to local buffer
+ */
+static inline void read_guest_wrap_u8(CPUS390XState *env, const int mmu_idx,
+                                      const uintptr_t ra, uint64_t guest_addr,
+                                      uint8_t *dest, size_t len)
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
+ * helper function to write len * u8 from local buffer to guest
+ */
+static inline void write_guest_wrap_u8(CPUS390XState *env, const int mmu_idx,
+                                       const uintptr_t ra, uint64_t guest_addr,
+                                       const uint8_t *src, size_t len)
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
+ * helper function to read len * u32 from guest to local buffer
+ */
+static inline void read_guest_wrap_u32(CPUS390XState *env, const int mmu_idx,
+                                      const uintptr_t ra, uint64_t guest_addr,
+                                      uint32_t *dest, size_t len)
+{
+    const MemOpIdx oi = make_memop_idx(MO_BE | MO_32 | MO_UNALN, mmu_idx);
+
+    for (size_t i = 0; i < len; i++, guest_addr += 4) {
+        uint64_t waddr = wrap_address(env, guest_addr);
+        dest[i] = cpu_ldl_mmu(env, waddr, oi, ra);
+    }
+}
+
+/*
+ * helper function to write len * u32 from local buffer to guest
+ */
+static inline void write_guest_wrap_u32(CPUS390XState *env, const int mmu_idx,
+                                        const uintptr_t ra, uint64_t guest_addr,
+                                        const uint32_t *src, size_t len)
+{
+    const MemOpIdx oi = make_memop_idx(MO_BE | MO_32 | MO_UNALN, mmu_idx);
+
+    for (size_t i = 0; i < len; i++, guest_addr += 4) {
+        uint64_t waddr = wrap_address(env, guest_addr);
+        cpu_stl_mmu(env, waddr, src[i], oi, ra);
+    }
+}
+
+/*
+ * helper function to read len * u64 from guest to local buffer
+ */
+static inline void read_guest_wrap_u64(CPUS390XState *env, const int mmu_idx,
+                                      const uintptr_t ra, uint64_t guest_addr,
+                                      uint64_t *dest, size_t len)
+{
+    const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
+
+    for (size_t i = 0; i < len; i++, guest_addr += 8) {
+        uint64_t waddr = wrap_address(env, guest_addr);
+        dest[i] = cpu_ldq_mmu(env, waddr, oi, ra);
+    }
+}
+
+/*
+ * helper function to write len * u64 from local buffer to guest
+ */
+static inline void write_guest_wrap_u64(CPUS390XState *env, const int mmu_idx,
+                                        const uintptr_t ra, uint64_t guest_addr,
+                                        const uint64_t *src, size_t len)
+{
+    const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
+
+    for (size_t i = 0; i < len; i++, guest_addr += 8) {
+        uint64_t waddr = wrap_address(env, guest_addr);
+        cpu_stq_mmu(env, waddr, src[i], oi, ra);
+    }
+}
+
+#endif /* TARGET_S390_CRYPTO_HELPER_H */
-- 
2.43.0

