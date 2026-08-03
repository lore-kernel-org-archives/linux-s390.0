Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F732363C5F
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773566; cv=none; b=Ba7GM7/Dg4BywtXR5ZWk+aUadsJORsvwjDbo9e3GGLHRRPMYxJGrfGUtQn70bu+IdULT21SvXPr8c8pQ0TOmmyfe0PaciO5ETMR4IIr7Q48hVc0Wbd1DxNOgUdRxCUp0mGsip3WVasJR0XuIDaaWJvg0HqaVubg9AJWqLA9/WHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773566; c=relaxed/simple;
	bh=mh+0v690r7UFkgnpt54nmrS+UqwCZhUasS3o54/O7hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYAClg3KapS4zgfzpJpCBeG62hfB6KIiMC/fJLfNeA6LFR8mSzX5xJqvS9quOuUBscBgVN0MKaUDhpljA50PWozHCn8TBYfnIfKWTiaEOKKJUKCoga14GVGx2YoDUO0IzxZ62FMae82Fq9F4h9cQwDwC4fzYUOXUW4C5PPcvU1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D3FBz/4f; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D3FBz/4f"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHhTP2282695;
	Mon, 3 Aug 2026 16:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Xv3I5qm5EaQWZ77Nm
	2gBe5qnWzKcgVMENuy8PMzAUCc=; b=D3FBz/4flDreU+MaLvq593jpgvBURSmaV
	e6r5t6JwyYuqOJ76ut2Ciw1VeoKpgX+YT0/xmqlanUydx6tlmZEJGoq+yPi9hEy2
	7Yq2sBTpHzMn+wGzeA3rFd7a49+n19sMb/zPFCNuVrJDeQlvN4mVqPvm3o6e0gzJ
	VpEsHPQL9/vJPd/O4T1rgPza9859ei1ma9D/Q9ZQZSneMw4GYqgbcJHeWoGai5ox
	4S39BKW7jxeQDaqnpLXvGReiE+5Q0XSD7zDGvH/38OE8sRsTBBx1Uqxthu/QBBuq
	wy1CL2hDmMU4RslKHCqm354zTrdege0abRsFhOZBVaI9tHWilyxbQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4squy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:12:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673GBIWN008958;
	Mon, 3 Aug 2026 16:12:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg5yac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:12:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673GCVqT29688100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 16:12:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69DAD20040;
	Mon,  3 Aug 2026 16:12:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A27020043;
	Mon,  3 Aug 2026 16:12:31 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.207.251])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 16:12:31 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v13 04/18] target/s390x: Add helper functions for copy memory to and from guest
Date: Mon,  3 Aug 2026 18:12:21 +0200
Message-ID: <20260803161235.228704-5-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803161235.228704-1-freude@linux.ibm.com>
References: <20260803161235.228704-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX+exY1og2kk90
 iQAdqvD7fK5Fq7qAeHLYbhP5dMMHZsQwoiidAnxQZUb1t+3+j1+DE2OnmLn35vT+fHfA0EAZ2IK
 NZV7ygE5rd6ZvhAz89ckgkc5l8QUbx4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX3d/biHmRWUx1
 FjjQ+txdsQ0XpJdv9jYfKsF9HQIKGOEFXo1xMQnQRGciRGzJh3VwmdYSzTemQZtQ76OcQxzQcmy
 1i9zw4DL8Vh0i0VULxStqcoqGTJ7EX8+EGjc6VJ6xJpM88AUAKyibkHVfP9sEab5/jJW5ovCoXJ
 4vVklIXHS86j3UTtvgaUFrPw1a5Zt2oY2Ka50xqUDtbBBvn1W3UBHoyatvEWPCvR2es4xgiMujg
 KziUF6RRiJSGjyTDZhwzzKl3XtsZ7fHe2fG+o6wRMzCpMfZSvQN7H6ahuSUg3XE7r9McWKKSVT8
 68pHaCW5uD0P5vZU/zPwbXlX0J+mNH02VEu/b6iEbdwQtR1A5eqwGc+wdcCPiYaXKQUCLKRhg35
 kNimC6f8JxdUYWO36EeCzL6hlTekR92lAUoTXqc2NIMndE5b0eGTaXDrRFwebE6O3mVnTg1AHKj
 C/D2aW0NbBAjjIqhT9Q==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a70bdf4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=FyORFv3Am_Wt7j1hYGwA:9
X-Proofpoint-ORIG-GUID: iRCsIyUVQkC1CGtlan4wHvteoTDUMxgC
X-Proofpoint-GUID: iRCsIyUVQkC1CGtlan4wHvteoTDUMxgC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030141

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
---
 target/s390x/tcg/cpacf_sha256.c  |  63 ++++---------------
 target/s390x/tcg/cpacf_sha512.c  |  63 ++++---------------
 target/s390x/tcg/crypto_helper.c |   1 +
 target/s390x/tcg/crypto_helper.h | 100 +++++++++++++++++++++++++++++++
 4 files changed, 123 insertions(+), 104 deletions(-)
 create mode 100644 target/s390x/tcg/crypto_helper.h

diff --git a/target/s390x/tcg/cpacf_sha256.c b/target/s390x/tcg/cpacf_sha256.c
index 7e57e497a3..f895f9e20c 100644
--- a/target/s390x/tcg/cpacf_sha256.c
+++ b/target/s390x/tcg/cpacf_sha256.c
@@ -18,6 +18,7 @@
 #include "accel/tcg/cpu-ldst-common.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "target/s390x/tcg/cpacf.h"
+#include "target/s390x/tcg/crypto_helper.h"
 
 static uint32_t R(uint32_t x, int c)
 {
@@ -103,53 +104,13 @@ static void sha256_bda_be32(uint32_t a[8], uint32_t w[16])
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
@@ -164,7 +125,8 @@ int cpacf_sha256(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
-    sha256_read_icv(env, mmu_idx, param_addr, a, ra);
+    /* read icv (8 * u32) */
+    read_guest_wrap_u32(env, mmu_idx, ra, param_addr, a, 8);
 
     /* Process full blocks first. */
     for (; len >= 64; len -= 64, processed += 64) {
@@ -174,21 +136,18 @@ int cpacf_sha256(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
@@ -198,13 +157,13 @@ int cpacf_sha256(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
 
@@ -219,7 +178,7 @@ int cpacf_sha256(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
      * TODO: if writing fails halfway through (e.g., when crossing page
      * boundaries), we're in trouble. We'd need something like access_prepare().
      */
-    sha256_write_ocv(env, mmu_idx, param_addr, a, ra);
+    write_guest_wrap_u32(env, mmu_idx, ra, param_addr, a, 8);
     *message_reg = deposit64(*message_reg, 0, message_reg_len,
                              *message_reg + processed);
     *len_reg -= processed;
diff --git a/target/s390x/tcg/cpacf_sha512.c b/target/s390x/tcg/cpacf_sha512.c
index ebfecc70f7..fa42eff336 100644
--- a/target/s390x/tcg/cpacf_sha512.c
+++ b/target/s390x/tcg/cpacf_sha512.c
@@ -17,6 +17,7 @@
 #include "accel/tcg/cpu-ldst-common.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "target/s390x/tcg/cpacf.h"
+#include "target/s390x/tcg/crypto_helper.h"
 
 static uint64_t R(uint64_t x, int c)
 {
@@ -118,53 +119,13 @@ static void sha512_bda_be64(uint64_t a[8], uint64_t w[16])
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
 
@@ -178,7 +139,8 @@ int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
-    sha512_read_icv(env, mmu_idx, param_addr, a, ra);
+    /* read icv (8 * u64) */
+    read_guest_wrap_u64(env, mmu_idx, ra, param_addr, a, 8);
 
     /* Process full blocks first. */
     for (; len >= 128; len -= 128, processed += 128) {
@@ -188,21 +150,18 @@ int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
@@ -212,13 +171,13 @@ int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
 
@@ -233,7 +192,7 @@ int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
      * TODO: if writing fails halfway through (e.g., when crossing page
      * boundaries), we're in trouble. We'd need something like access_prepare().
      */
-    sha512_write_ocv(env, mmu_idx, param_addr, a, ra);
+    write_guest_wrap_u64(env, mmu_idx, ra, param_addr, a, 8);
     *message_reg = deposit64(*message_reg, 0, message_reg_len,
                              *message_reg + processed);
     *len_reg -= processed;
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 6c296f6731..d996caf56a 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -20,6 +20,7 @@
 #include "accel/tcg/cpu-ldst-common.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "target/s390x/tcg/cpacf.h"
+#include "target/s390x/tcg/crypto_helper.h"
 
 static void fill_buf_random(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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

