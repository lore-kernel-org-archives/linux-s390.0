Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A753FB7C1
	for <linux-s390@vger.kernel.org>; Mon,  6 Jul 2026 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331044; cv=none; b=oAuFtbE/G5ZjgLiBt+92jfzJ2Y5Yv1kAjxM1qHsAkDbX0u9vwN8vMKymk7D1uApuaOeqE3OUN1v2dLygN35jxWPZHZTVSTTjYOWE+daS3IBjMsZq2dEmn69EumvSH/wyIu2S8r27IAUurfrVvSw9JDmJlx6PhIqRcyZpuJd8z9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331044; c=relaxed/simple;
	bh=HjQZHuVnmD1cd89Wsw2umwlpFo1C8I77LUBaAji+yXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rwqm8T3O2bIw41WZa4TIIefRhZWgNv6j618d/+0N9uUKMmUKw+FV9tlaT+UHyTou4oyL3ej5oEXaR9mIRgNPwRTmKJFhMbHGE8/JIiNyVxITzEArXis+KM7uMfZ3yGPvr/rMwAK+AWAde9MeOKva/MTpZ31mPbOLxTxZlKqA9J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B7C9GrRG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B7C9GrRG"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6669IGGS3890041;
	Mon, 6 Jul 2026 09:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SMcfvUuy1FF4Yj2Z9
	8N8Bq+9kGrY0iMwV3cE0YsF+Wg=; b=B7C9GrRGPQinYhADMIHrOdknB4GbU/pu5
	GnPHU6u8ghyZJbs6HwHSBLdIKW+JHrwWZ0tUV9rwxoziz+2Bpx2b9i5wlChL/vvd
	lhp5phrHvq7AB5+aTpBq/WeMJb3idiCELq1WnfpM1AkCWQFhlmpo+KSBokzd3BxT
	4pduppXy5VIw1nZF2Qo3VakStuda3PBJDn+OyTXj9HBjKinXcABqK4mNe2dH6BBS
	h7mS/OgTAIHHFX7yc9gq4oGT0y8Mgi76OzDE/NuygKy5bwdDz15RaoCsvM1nsz0z
	j1k4lp9uyJ09l1GLTcVJbBi12QuXjJovTZQV6Gh1sPhzoWU5YrJDw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3gsr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 09:43:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6669Ydp6005612;
	Mon, 6 Jul 2026 09:43:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h4w4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 09:43:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6669hKSo29950316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 09:43:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 370932004B;
	Mon,  6 Jul 2026 09:43:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE58820043;
	Mon,  6 Jul 2026 09:43:19 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.193.81])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 09:43:19 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v10 20/21] target/s390x: Improve fetch and store mem from and to guest
Date: Mon,  6 Jul 2026 11:43:13 +0200
Message-ID: <20260706094317.17032-21-freude@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4b78bd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=SH-LS3B6E9p2pXL9WtEA:9
 a=ZDSMja1iq-x7GFnX:21
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5NCBTYWx0ZWRfX6GB7zy8FDNNj
 g+tjZAombq5Ycr5jd/MEEfuklQTu4pUWlb49jkZchFXzuRUyWb+Yes1aM5mXYInz/mh3F5I7UOY
 6z2z5XDHn1GL3/l5jXGI3f7QXDUVh3o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5NCBTYWx0ZWRfXzWto1CdHcy2X
 wz611oCMee4NCwnCypP3qsRUzoEx/QuYonRoEHQY8PUrMlerc9438XFfd8JgnC6JrNwHM3XPlzp
 zUOvjLVorH0fUu3zuVQyxPJ+1pQi8k5NZHN1CpofO1eJEykT+WFLh5nG1KF5FPApUlpZ7n+LRRT
 i8H+SsqAP679+d6feGUwm3JvWbhbBo29hpkezJsagpnCMFNAq6PZoAqIowFxymsDbHGcqssJac9
 HomHs2XrHzA9qhznAH5aZIeBMBnnTzZ/6VA3pIVtwhhZWI+GhK3vLsGoMazRtwtZyQasMNCbZPM
 ojXnCx7xtgKVSgQ4by6iZN3fWm8hZKwn8SW7eZTmTKKHMbcURF9J+IAuPJAZh28y3hMrYbRn1Tp
 R5axWHFwA81h4xg9cdC0ulzAWuODMhmIbX1zjOT9X5uhaYCtfCzeOEvn6UmsJIQHh6e89onO+28
 4Gi5yj3Q+sak5S7iHVQ==
X-Proofpoint-ORIG-GUID: i-Sab2cZsFIsqfqShN6gRlW_1GeFjapa
X-Proofpoint-GUID: i-Sab2cZsFIsqfqShN6gRlW_1GeFjapa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060094

Introduce helper functions:
* copy_from_guest_wrap()
* copy_to_guest_wrap()
for copy some memory from guest into a local buffer and the reverse
direction. Rework the other functions to use these helpers. By doing
so some local variables could be removed also and the code is better
readable now.

Suggested-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/tcg/cpacf_aes.c | 305 ++++++++++++++---------------------
 1 file changed, 124 insertions(+), 181 deletions(-)

diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 4298a0eac6..15124f3274 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -16,37 +16,64 @@
 #include "crypto/aes.h"
 #include "target/s390x/tcg/cpacf.h"
 
-static void aes_read_block(CPUS390XState *env, const int mmu_idx,
-                           uint64_t addr, uint8_t *a, uintptr_t ra)
+/*
+ * helper function to copy some memory from guest to a local buffer
+ */
+static inline void copy_from_guest_wrap(CPUS390XState *env, const int mmu_idx,
+                                        const uintptr_t ra, uint64_t guest_addr,
+                                        uint8_t *dest, size_t len)
 {
     const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
 
-    for (int i = 0; i < AES_BLOCK_SIZE; i++, addr += 1) {
-        uint64_t _addr = wrap_address(env, addr);
-        a[i] = cpu_ldb_mmu(env, _addr, oi, ra);
+    for (size_t i = 0; i < len; i++, guest_addr++) {
+        uint64_t waddr = wrap_address(env, guest_addr);
+        dest[i] = cpu_ldb_mmu(env, waddr, oi, ra);
     }
 }
 
-static void aes_write_block(CPUS390XState *env, const int mmu_idx,
-                            uint64_t addr, uint8_t *a, uintptr_t ra)
+/*
+ * helper function to copy from a local buffer to guest memory
+ */
+static inline void copy_to_guest_wrap(CPUS390XState *env, const int mmu_idx,
+                                      const uintptr_t ra, uint64_t guest_addr,
+                                      const uint8_t *src, size_t len)
 {
     const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
 
-    for (int i = 0; i < AES_BLOCK_SIZE; i++, addr += 1) {
-        uint64_t _addr = wrap_address(env, addr);
-        cpu_stb_mmu(env, _addr, a[i], oi, ra);
+    for (size_t i = 0; i < len; i++, guest_addr++) {
+        uint64_t waddr = wrap_address(env, guest_addr);
+        cpu_stb_mmu(env, waddr, src[i], oi, ra);
     }
 }
 
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
 int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t param_addr, uint64_t *dst_ptr_reg,
                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                   uint32_t type, uint8_t fc, uint8_t mod)
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
-    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
-    uint64_t addr, len = *src_len_reg, done = 0;
+    uint64_t len = *src_len_reg, done = 0;
     int i, keysize, addr_reg_size = 64;
     uint8_t key[32];
     AES_KEY exkey;
@@ -77,10 +104,7 @@ int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     }
 
     /* fetch key from param block */
-    for (i = 0; i < keysize; i++) {
-        addr = wrap_address(env, param_addr + i);
-        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
-    }
+    copy_from_guest_wrap(env, mmu_idx, ra, param_addr, key, keysize);
 
     /* expand key */
     if (mod) {
@@ -91,13 +115,13 @@ int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     /* process up to MAX_BLOCKS_PER_RUN aes blocks */
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
-        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
+        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
         if (mod) {
             AES_decrypt(in, out, &exkey);
         } else {
             AES_encrypt(in, out, &exkey);
         }
-        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
+        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
         len -= AES_BLOCK_SIZE;
         done += AES_BLOCK_SIZE;
     }
@@ -118,8 +142,7 @@ int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
     uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
-    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
-    uint64_t addr, len = *src_len_reg, done = 0;
+    uint64_t len = *src_len_reg, done = 0;
     int i, keysize, addr_reg_size = 64;
     uint8_t key[32], iv[AES_BLOCK_SIZE];
     AES_KEY exkey;
@@ -151,16 +174,11 @@ int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     }
 
     /* fetch iv from param block */
-    for (i = 0; i < AES_BLOCK_SIZE; i++) {
-        addr = wrap_address(env, param_addr + i);
-        iv[i] = cpu_ldb_mmu(env, addr, oi, ra);
-    }
+    copy_from_guest_wrap(env, mmu_idx, ra, param_addr, iv, AES_BLOCK_SIZE);
 
     /* fetch key from param block */
-    for (i = 0; i < keysize; i++) {
-        addr = wrap_address(env, param_addr + AES_BLOCK_SIZE + i);
-        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
-    }
+    copy_from_guest_wrap(env, mmu_idx, ra,
+                         param_addr + AES_BLOCK_SIZE, key, keysize);
 
     /* expand key */
     if (mod) {
@@ -171,7 +189,7 @@ int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     /* process up to MAX_BLOCKS_PER_RUN aes blocks */
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
-        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
+        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
         if (mod) {
             /* decrypt in => out */
             AES_cbc_decrypt(in, out, iv, &exkey);
@@ -179,16 +197,13 @@ int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
             /* encrypt in => out */
             AES_cbc_encrypt(in, out, iv, &exkey);
         }
-        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
+        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
         len -= AES_BLOCK_SIZE;
         done += AES_BLOCK_SIZE;
     }
 
     /* update iv in param block */
-    for (i = 0; i < AES_BLOCK_SIZE; i++) {
-        addr = wrap_address(env, param_addr + i);
-        cpu_stb_mmu(env, addr, iv[i], oi, ra);
-    }
+    copy_to_guest_wrap(env, mmu_idx, ra, param_addr, iv, AES_BLOCK_SIZE);
 
     *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
                              *src_ptr_reg + done);
@@ -206,9 +221,8 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint8_t fc, uint8_t mod)
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
-    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
-    uint64_t addr, len = *src_len_reg, done = 0;
+    uint64_t len = *src_len_reg, done = 0;
     uint8_t ctr[AES_BLOCK_SIZE], key[32];
     int i, keysize, addr_reg_size = 64;
     AES_KEY exkey;
@@ -240,10 +254,7 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     }
 
     /* fetch key from param block */
-    for (i = 0; i < keysize; i++) {
-        addr = wrap_address(env, param_addr + i);
-        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
-    }
+    copy_from_guest_wrap(env, mmu_idx, ra, param_addr, key, keysize);
 
     /* expand key */
     AES_set_encrypt_key(key, keysize * 8, &exkey);
@@ -251,13 +262,13 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     /* process up to MAX_BLOCKS_PER_RUN aes blocks */
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
         /* read in nonce/ctr => ctr */
-        aes_read_block(env, mmu_idx, *ctr_ptr_reg + done, ctr, ra);
+        aes_read_block(env, mmu_idx, ra, *ctr_ptr_reg + done, ctr);
         /* read in one block of input data => in */
-        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
+        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
         /* encrypt ctr and xor with in => out */
         AES_ctr_encrypt(in, out, ctr, &exkey);
         /* write out the processed block */
-        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
+        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
         len -= AES_BLOCK_SIZE;
         done += AES_BLOCK_SIZE;
     }
@@ -277,9 +288,7 @@ int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t param_addr, uint8_t fc)
 {
     uint8_t key[32], tweak[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
-    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     int keysize, i;
-    uint64_t addr;
     AES_KEY exkey;
 
     switch (fc) {
@@ -294,10 +303,9 @@ int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     }
 
     /* fetch block sequence nr from param block into buf */
-    for (i = 0; i < AES_BLOCK_SIZE; i++) {
-        addr = wrap_address(env, param_addr + keysize + AES_BLOCK_SIZE + i);
-        buf[i] = cpu_ldb_mmu(env, addr, oi, ra);
-    }
+    copy_from_guest_wrap(env, mmu_idx, ra,
+                         param_addr + keysize + AES_BLOCK_SIZE,
+                         buf, AES_BLOCK_SIZE);
 
     /* is the block sequence nr 0 ? */
     for (i = 0; i < AES_BLOCK_SIZE && !buf[i]; i++) {
@@ -310,16 +318,11 @@ int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     }
 
     /* fetch key from param block */
-    for (i = 0; i < keysize; i++) {
-        addr = wrap_address(env, param_addr + i);
-        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
-    }
+    copy_from_guest_wrap(env, mmu_idx, ra, param_addr, key, keysize);
 
     /* fetch tweak from param block into tweak */
-    for (i = 0; i < AES_BLOCK_SIZE; i++) {
-        addr = wrap_address(env, param_addr + keysize + i);
-        tweak[i] = cpu_ldb_mmu(env, addr, oi, ra);
-    }
+    copy_from_guest_wrap(env, mmu_idx, ra,
+                         param_addr + keysize, tweak, AES_BLOCK_SIZE);
 
     /* expand key */
     AES_set_encrypt_key(key, keysize * 8, &exkey);
@@ -328,10 +331,9 @@ int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     AES_encrypt(tweak, buf, &exkey);
 
     /* store encrypted tweak into xts parameter field of the param block */
-    for (i = 0; i < AES_BLOCK_SIZE; i++) {
-        addr = wrap_address(env, param_addr + keysize + 3 * AES_BLOCK_SIZE + i);
-        cpu_stb_mmu(env, addr, buf[i], oi, ra);
-    }
+    copy_to_guest_wrap(env, mmu_idx, ra,
+                       param_addr + keysize + 3 * AES_BLOCK_SIZE,
+                       buf, AES_BLOCK_SIZE);
 
     return 0;
 }
@@ -343,8 +345,7 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
     uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
-    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
-    uint64_t addr, len = *src_len_reg, done = 0;
+    uint64_t len = *src_len_reg, done = 0;
     uint8_t key[32], tweak[AES_BLOCK_SIZE];
     int i, keysize, addr_reg_size = 64;
     AES_KEY exkey;
@@ -373,10 +374,7 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     }
 
     /* fetch key from param block */
-    for (i = 0; i < keysize; i++) {
-        addr = wrap_address(env, param_addr + i);
-        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
-    }
+    copy_from_guest_wrap(env, mmu_idx, ra, param_addr, key, keysize);
 
     /* expand key */
     if (mod) {
@@ -386,15 +384,13 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     }
 
     /* fetch tweak from param block */
-    for (i = 0; i < AES_BLOCK_SIZE; i++) {
-        addr = wrap_address(env, param_addr + keysize + i);
-        tweak[i] = cpu_ldb_mmu(env, addr, oi, ra);
-    }
+    copy_from_guest_wrap(env, mmu_idx, ra,
+                         param_addr + keysize, tweak, AES_BLOCK_SIZE);
 
     /* process up to MAX_BLOCKS_PER_RUN aes blocks */
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
         /* fetch one AES block into in  */
-        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
+        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
         if (mod) {
             /* decrypt in => out */
             AES_xts_decrypt(in, out, tweak, &exkey);
@@ -405,16 +401,14 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
         /* prep tweak for next round */
         AES_xts_prep_next_tweak(tweak);
         /* write out this processed block from out */
-        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
+        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
         len -= AES_BLOCK_SIZE;
         done += AES_BLOCK_SIZE;
     }
 
     /* update tweak in param block */
-    for (i = 0; i < AES_BLOCK_SIZE; i++) {
-        addr = wrap_address(env, param_addr + keysize + i);
-        cpu_stb_mmu(env, addr, tweak[i], oi, ra);
-    }
+    copy_to_guest_wrap(env, mmu_idx, ra,
+                       param_addr + keysize, tweak, AES_BLOCK_SIZE);
 
     *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
                              *src_ptr_reg + done);
@@ -467,10 +461,8 @@ static void decrypt_protkey(uint8_t *key, int keysize)
 int cpacf_aes_pckmo(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                     uint64_t param_addr, uint8_t fc)
 {
-    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     uint8_t key[32];
-    int keysize, i;
-    uint64_t addr;
+    int keysize;
 
     switch (fc) {
     case CPACF_PCKMO_ENC_AES_128_KEY:
@@ -487,24 +479,17 @@ int cpacf_aes_pckmo(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     }
 
     /* fetch key from param block */
-    for (i = 0; i < keysize; i++) {
-        addr = wrap_address(env, param_addr + i);
-        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
-    }
+    copy_from_guest_wrap(env, mmu_idx, ra, param_addr, key, keysize);
 
     /* 'derive' the protected key from the clear key */
     encrypt_clrkey(key, keysize);
 
     /* store the protected key into param block */
-    for (i = 0; i < keysize; i++) {
-        addr = wrap_address(env, param_addr + i);
-        cpu_stb_mmu(env, addr, key[i], oi, ra);
-    }
+    copy_to_guest_wrap(env, mmu_idx, ra, param_addr, key, keysize);
     /* followed by the fake wkvp */
-    for (i = 0; i < sizeof(protkey_wkvp); i++) {
-        addr = wrap_address(env, param_addr + keysize + i);
-        cpu_stb_mmu(env, addr, protkey_wkvp[i], oi, ra);
-    }
+    copy_to_guest_wrap(env, mmu_idx, ra,
+                       param_addr + keysize,
+                       protkey_wkvp, sizeof(protkey_wkvp));
 
     return 0;
 }
@@ -515,9 +500,8 @@ int cpacf_paes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint32_t type, uint8_t fc, uint8_t mod)
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
-    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
-    uint64_t addr, len = *src_len_reg, done = 0;
+    uint64_t len = *src_len_reg, done = 0;
     int i, keysize, addr_reg_size = 64;
     uint8_t key[32], wkvp[32];
     AES_KEY exkey;
@@ -549,20 +533,15 @@ int cpacf_paes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     }
 
     /* fetch and check wkvp from param block */
-    for (i = 0; i < sizeof(wkvp); i++) {
-        addr = wrap_address(env, param_addr + keysize + i);
-        wkvp[i] = cpu_ldb_mmu(env, addr, oi, ra);
-    }
+    copy_from_guest_wrap(env, mmu_idx, ra,
+                         param_addr + keysize, wkvp, sizeof(wkvp));
     if (memcmp(wkvp, protkey_wkvp, sizeof(wkvp))) {
         /* wkvp mismatch -> return with cc 1 */
         return 1;
     }
 
     /* fetch protected key from param block */
-    for (i = 0; i < keysize; i++) {
-        addr = wrap_address(env, param_addr + i);
-        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
-    }
+    copy_from_guest_wrap(env, mmu_idx, ra, param_addr, key, keysize);
     /* decrypt the protected key */
     decrypt_protkey(key, keysize);
 
@@ -575,13 +554,13 @@ int cpacf_paes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     /* process up to MAX_BLOCKS_PER_RUN aes blocks */
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
-        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
+        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
         if (mod) {
             AES_decrypt(in, out, &exkey);
         } else {
             AES_encrypt(in, out, &exkey);
         }
-        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
+        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
         len -= AES_BLOCK_SIZE;
         done += AES_BLOCK_SIZE;
     }
@@ -602,9 +581,8 @@ int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
     uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
-    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     uint8_t key[32], wkvp[32], iv[AES_BLOCK_SIZE];
-    uint64_t addr, len = *src_len_reg, done = 0;
+    uint64_t len = *src_len_reg, done = 0;
     int i, keysize, addr_reg_size = 64;
     AES_KEY exkey;
 
@@ -635,26 +613,20 @@ int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     }
 
     /* fetch and check wkvp from param block */
-    for (i = 0; i < sizeof(wkvp); i++) {
-        addr = wrap_address(env, param_addr + AES_BLOCK_SIZE + keysize + i);
-        wkvp[i] = cpu_ldb_mmu(env, addr, oi, ra);
-    }
+    copy_from_guest_wrap(env, mmu_idx, ra,
+                         param_addr + AES_BLOCK_SIZE + keysize,
+                         wkvp, sizeof(wkvp));
     if (memcmp(wkvp, protkey_wkvp, sizeof(wkvp))) {
         /* wkvp mismatch -> return with cc 1 */
         return 1;
     }
 
     /* fetch iv from param block */
-    for (i = 0; i < AES_BLOCK_SIZE; i++) {
-        addr = wrap_address(env, param_addr + i);
-        iv[i] = cpu_ldb_mmu(env, addr, oi, ra);
-    }
+    copy_from_guest_wrap(env, mmu_idx, ra, param_addr, iv, AES_BLOCK_SIZE);
 
     /* fetch protected key from param block */
-    for (i = 0; i < keysize; i++) {
-        addr = wrap_address(env, param_addr + AES_BLOCK_SIZE + i);
-        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
-    }
+    copy_from_guest_wrap(env, mmu_idx, ra,
+                         param_addr + AES_BLOCK_SIZE, key, keysize);
     /* decrypt the protected key */
     decrypt_protkey(key, keysize);
 
@@ -667,7 +639,7 @@ int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     /* process up to MAX_BLOCKS_PER_RUN aes blocks */
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
-        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
+        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
         if (mod) {
             /* decrypt in => out */
             AES_cbc_decrypt(in, out, iv, &exkey);
@@ -675,16 +647,13 @@ int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
             /* encrypt in => out */
             AES_cbc_encrypt(in, out, iv, &exkey);
         }
-        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
+        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
         len -= AES_BLOCK_SIZE;
         done += AES_BLOCK_SIZE;
     }
 
     /* update iv in param block */
-    for (i = 0; i < AES_BLOCK_SIZE; i++) {
-        addr = wrap_address(env, param_addr + i);
-        cpu_stb_mmu(env, addr, iv[i], oi, ra);
-    }
+    copy_to_guest_wrap(env, mmu_idx, ra, param_addr, iv, AES_BLOCK_SIZE);
 
     *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
                              *src_ptr_reg + done);
@@ -702,10 +671,9 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint8_t fc, uint8_t mod)
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
-    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
     uint8_t ctr[AES_BLOCK_SIZE], key[32], wkvp[32];
-    uint64_t addr, len = *src_len_reg, done = 0;
+    uint64_t len = *src_len_reg, done = 0;
     int i, keysize, addr_reg_size = 64;
     AES_KEY exkey;
 
@@ -736,20 +704,15 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     }
 
     /* fetch and check wkvp from param block */
-    for (i = 0; i < sizeof(wkvp); i++) {
-        addr = wrap_address(env, param_addr + keysize + i);
-        wkvp[i] = cpu_ldb_mmu(env, addr, oi, ra);
-    }
+    copy_from_guest_wrap(env, mmu_idx, ra,
+                         param_addr + keysize, wkvp, sizeof(wkvp));
     if (memcmp(wkvp, protkey_wkvp, sizeof(wkvp))) {
         /* wkvp mismatch -> return with cc 1 */
         return 1;
     }
 
     /* fetch protected key from param block */
-    for (i = 0; i < keysize; i++) {
-        addr = wrap_address(env, param_addr + i);
-        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
-    }
+    copy_from_guest_wrap(env, mmu_idx, ra, param_addr, key, keysize);
     /* decrypt the protected key */
     decrypt_protkey(key, keysize);
 
@@ -759,13 +722,13 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     /* process up to MAX_BLOCKS_PER_RUN aes blocks */
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
         /* read in nonce/ctr => ctr */
-        aes_read_block(env, mmu_idx, *ctr_ptr_reg + done, ctr, ra);
+        aes_read_block(env, mmu_idx, ra, *ctr_ptr_reg + done, ctr);
         /* read in one block of input data => in */
-        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
+        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
         /* encrypt ctr and xor with in => out */
         AES_ctr_encrypt(in, out, ctr, &exkey);
         /* write out the processed block */
-        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
+        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
         len -= AES_BLOCK_SIZE;
         done += AES_BLOCK_SIZE;
     }
@@ -785,9 +748,7 @@ int cpacf_paes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint64_t param_addr, uint8_t fc)
 {
     uint8_t key[32], wkvp[32], tweak[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
-    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     int keysize, i;
-    uint64_t addr;
     AES_KEY exkey;
 
     switch (fc) {
@@ -802,21 +763,17 @@ int cpacf_paes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     }
 
     /* fetch and check wkvp from param block */
-    for (i = 0; i < sizeof(wkvp); i++) {
-        addr = wrap_address(env, param_addr + keysize + i);
-        wkvp[i] = cpu_ldb_mmu(env, addr, oi, ra);
-    }
+    copy_from_guest_wrap(env, mmu_idx, ra,
+                         param_addr + keysize, wkvp, sizeof(wkvp));
     if (memcmp(wkvp, protkey_wkvp, sizeof(wkvp))) {
         /* wkvp mismatch -> return with cc 1 */
         return 1;
     }
 
     /* fetch block sequence nr from param block into buf */
-    for (i = 0; i < AES_BLOCK_SIZE; i++) {
-        addr = wrap_address(env, param_addr + keysize +
-                            sizeof(wkvp) + AES_BLOCK_SIZE + i);
-        buf[i] = cpu_ldb_mmu(env, addr, oi, ra);
-    }
+    copy_from_guest_wrap(env, mmu_idx, ra,
+                         param_addr + keysize + sizeof(wkvp) + AES_BLOCK_SIZE,
+                         buf, AES_BLOCK_SIZE);
 
     /* is the block sequence nr 0 ? */
     for (i = 0; i < AES_BLOCK_SIZE && !buf[i]; i++) {
@@ -829,18 +786,14 @@ int cpacf_paes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     }
 
     /* fetch protected key from param block */
-    for (i = 0; i < keysize; i++) {
-        addr = wrap_address(env, param_addr + i);
-        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
-    }
+    copy_from_guest_wrap(env, mmu_idx, ra, param_addr, key, keysize);
     /* decrypt the protected key */
     decrypt_protkey(key, keysize);
 
     /* fetch tweak from param block into tweak */
-    for (i = 0; i < AES_BLOCK_SIZE; i++) {
-        addr = wrap_address(env, param_addr + keysize + sizeof(wkvp) + i);
-        tweak[i] = cpu_ldb_mmu(env, addr, oi, ra);
-    }
+    copy_from_guest_wrap(env, mmu_idx, ra,
+                         param_addr + keysize + sizeof(wkvp),
+                         tweak, AES_BLOCK_SIZE);
 
     /* expand key */
     AES_set_encrypt_key(key, keysize * 8, &exkey);
@@ -849,11 +802,9 @@ int cpacf_paes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     AES_encrypt(tweak, buf, &exkey);
 
     /* store encrypted tweak into xts parameter field of the param block */
-    for (i = 0; i < AES_BLOCK_SIZE; i++) {
-        addr = wrap_address(env, param_addr + keysize +
-                            sizeof(wkvp) + 3 * AES_BLOCK_SIZE + i);
-        cpu_stb_mmu(env, addr, buf[i], oi, ra);
-    }
+    copy_to_guest_wrap(env, mmu_idx, ra,
+                       param_addr + keysize + sizeof(wkvp) + 3 * AES_BLOCK_SIZE,
+                       buf, AES_BLOCK_SIZE);
 
     return 0;
 }
@@ -865,9 +816,8 @@ int cpacf_paes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
     uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
-    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     uint8_t key[32], wkvp[32], tweak[AES_BLOCK_SIZE];
-    uint64_t addr, len = *src_len_reg, done = 0;
+    uint64_t len = *src_len_reg, done = 0;
     int i, keysize, addr_reg_size = 64;
     AES_KEY exkey;
 
@@ -895,20 +845,15 @@ int cpacf_paes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     }
 
     /* fetch and check wkvp from param block */
-    for (i = 0; i < sizeof(wkvp); i++) {
-        addr = wrap_address(env, param_addr + keysize + i);
-        wkvp[i] = cpu_ldb_mmu(env, addr, oi, ra);
-    }
+    copy_from_guest_wrap(env, mmu_idx, ra,
+                         param_addr + keysize, wkvp, sizeof(wkvp));
     if (memcmp(wkvp, protkey_wkvp, sizeof(wkvp))) {
         /* wkvp mismatch -> return with cc 1 */
         return 1;
     }
 
     /* fetch protected key from param block */
-    for (i = 0; i < keysize; i++) {
-        addr = wrap_address(env, param_addr + i);
-        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
-    }
+    copy_from_guest_wrap(env, mmu_idx, ra, param_addr, key, keysize);
     /* decrypt the protected key */
     decrypt_protkey(key, keysize);
 
@@ -920,15 +865,14 @@ int cpacf_paes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     }
 
     /* fetch tweak from param block */
-    for (i = 0; i < AES_BLOCK_SIZE; i++) {
-        addr = wrap_address(env, param_addr + keysize + sizeof(wkvp) + i);
-        tweak[i] = cpu_ldb_mmu(env, addr, oi, ra);
-    }
+    copy_from_guest_wrap(env, mmu_idx, ra,
+                         param_addr + keysize + sizeof(wkvp),
+                         tweak, AES_BLOCK_SIZE);
 
     /* process up to MAX_BLOCKS_PER_RUN aes blocks */
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
         /* fetch one AES block into in */
-        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
+        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
         if (mod) {
             /* decrypt in => out */
             AES_xts_decrypt(in, out, tweak, &exkey);
@@ -939,16 +883,15 @@ int cpacf_paes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
         /* prep tweak for next round */
         AES_xts_prep_next_tweak(tweak);
         /* write out this processed block from out */
-        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
+        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
         len -= AES_BLOCK_SIZE;
         done += AES_BLOCK_SIZE;
     }
 
     /* update tweak in param block */
-    for (i = 0; i < AES_BLOCK_SIZE; i++) {
-        addr = wrap_address(env, param_addr + keysize + sizeof(wkvp) + i);
-        cpu_stb_mmu(env, addr, tweak[i], oi, ra);
-    }
+    copy_to_guest_wrap(env, mmu_idx, ra,
+                       param_addr + keysize + sizeof(wkvp),
+                       tweak, AES_BLOCK_SIZE);
 
     *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
                              *src_ptr_reg + done);
-- 
2.43.0

