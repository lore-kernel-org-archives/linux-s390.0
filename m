Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13F926CE1E
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 08:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782288673; cv=none; b=UNSZF/4woGabbb4q+cQLjogBoNfa1pQ6DawU96xO03ZX7mSftMN3f+z9mzz1Gp0Vhy4ZZFcgncCGMCPAskxlxmFms/pQFXAqWCdYgqtZNlPZceWNf4OUHtLQtAczq5sGpOj9zVh8MO7QEMkkDId7gnt2NXQ1Fr3tokCNadbZyBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782288673; c=relaxed/simple;
	bh=GqnLxpnCHPV2f3Wti8udpAHLkl6O4pDJ5QaagxrVwqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1zqocEmD9HvCURMGRvnMQdWAPgKbH5L/x2iWkmpA4B2UBmyoAaB0jewgRkKls3BcsgqvtZQDJ2D436FbxYi2cEyAN12ZkoCemAheCBr19FzM84ZluTvxg/UBwUnnjDqCutCo3coGBx/O8najmID4tyugiksZ/wcN9tTD0gY55A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HS/oU1ik; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HS/oU1ik"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O6IIRj4169117;
	Wed, 24 Jun 2026 08:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OqD1GuhZRxVZ2RPoA
	gwalms0wx5OJhUZj7G/Uo1ui5o=; b=HS/oU1ik4if3OrlVk3SAZUEHiOR2ex2tc
	gOhGsvoMyP9D/MSUO37g8VfIO+8697SWOdnzYbHvABzChqfHYam+DTKdeQAg4x2W
	7JucUQ5lcy4CyyoiaIR9hiKir7Vaok2s/BCAyUO7w9y/5+n+gwa2dnvEmxs+P3zZ
	aoJ8Rx8YJJBw0uVup38q7Qee4ZhXIrRWJ9oPsFzcuNCtbHkFB3buQMagmtniL6gv
	RsikzQ2Emzsd69GMVlxY3UBIdJprcCLAl2uE/HraTVTJMTr+lZyWYIKU9ZD17g7o
	y6T7RAm/Ks52fe54LiaegODSJXQj7Ibz8uP59KZutu55WTh4Nvt1g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gjx8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:10:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65O84mcI010108;
	Wed, 24 Jun 2026 08:10:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qfsub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:10:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65O8AZe516843232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 08:10:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55B6C20040;
	Wed, 24 Jun 2026 08:10:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1854E2004D;
	Wed, 24 Jun 2026 08:10:35 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.224.92.54])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 08:10:35 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v8 18/18] target/s390x: Use generic AES helper functions
Date: Wed, 24 Jun 2026 10:10:15 +0200
Message-ID: <20260624081029.23815-19-freude@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3b9100 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=-HiyJwbfKD-n0wRtvd4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfX5S9iqqmqkBVC
 GNgxLS+IhtC1E2nBmNkIWyAMJgcOi308UiDx0ASJ9CzG9o2plRwMMA4lE6GlE0O6tDFSZq2Ed7w
 uh0jgNxSKoBZMhC7TvlgwOspfzlPaCvArbc5kwFQGglBvA4fkzA1Vt0/9hWA6NyF0wA5OjEXBe/
 CKiM5/Ori1/1hi6krdgcFPsEsKRGaN+Tr/rRQkWB/nkJg1F2iJGlbV6i1I4mMUm3JmhQBJkHObD
 jGyvqpEe0HhkZm+UFGXc44kJUPZaesSNmJLVarec1T0EQcbigFiX6HwZefGKIILCrqNpjvSEllJ
 kFRx1W7rXGqrMPUDkBhy7d82579KmIp7Ua8r47Yx+0iy53f+LqbVUQVUinPLcgsVIuON8AayGnk
 xobFD39/sgg7PFdFAjVgn7CwykaT9w==
X-Proofpoint-GUID: Sf3oFGguVUWddqEZrPk50RkQvQQDw8bx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfX0NhzBVN6BkGl
 1X+ri/5zfVpojub8wt6QVIepHhRNrzBTbH1RZlzC2i+rpd87uXgydJQPH27AuVRcsPJ87UvgHgi
 dUJ4Ac8BqwNyGTu/7MfQFPZm9GqZWdg=
X-Proofpoint-ORIG-GUID: Sf3oFGguVUWddqEZrPk50RkQvQQDw8bx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240063

Rewrite the cpacf implementations to use the generic
AES helper functions from crypto/aes-helpers.c

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
---
 target/s390x/tcg/cpacf_aes.c | 124 ++++++++++-------------------------
 1 file changed, 36 insertions(+), 88 deletions(-)

diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 784f06df40..87a85c3f9e 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -112,20 +112,13 @@ int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     return !len ? 0 : 3;
 }
 
-static void aes_xor(const uint8_t *src1, const uint8_t *src2, uint8_t *dst)
-{
-    for (int i = 0; i < AES_BLOCK_SIZE; i++) {
-        dst[i] = src1[i] ^ src2[i];
-    }
-}
-
 int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t param_addr, uint64_t *dst_ptr_reg,
                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                   uint32_t type, uint8_t fc, uint8_t mod)
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
-    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
     const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     uint64_t addr, len = *src_len_reg, done = 0;
     int i, keysize, addr_reg_size = 64;
@@ -181,19 +174,11 @@ int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
         aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
         if (mod) {
-            /* decrypt in => buf */
-            AES_decrypt(in, buf, &exkey);
-            /* buf xor iv => out */
-            aes_xor(buf, iv, out);
-            /* prep iv for next round */
-            memcpy(iv, in, AES_BLOCK_SIZE);
+            /* decrypt in => out */
+            AES_cbc_decrypt(in, out, iv, &exkey);
         } else {
-            /* in xor iv => buf */
-            aes_xor(in, iv, buf);
-            /* encrypt buf => out */
-            AES_encrypt(buf, out, &exkey);
-            /* prep iv for next round */
-            memcpy(iv, out, AES_BLOCK_SIZE);
+            /* encrypt in => out */
+            AES_cbc_encrypt(in, out, iv, &exkey);
         }
         aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
         len -= AES_BLOCK_SIZE, done += AES_BLOCK_SIZE;
@@ -222,11 +207,10 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
     const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
-    uint8_t ctr[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
     uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
     uint64_t addr, len = *src_len_reg, done = 0;
+    uint8_t ctr[AES_BLOCK_SIZE], key[32];
     int i, keysize, addr_reg_size = 64;
-    uint8_t key[32];
     AES_KEY exkey;
 
     g_assert(type == S390_FEAT_TYPE_KMCTR);
@@ -268,12 +252,10 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
         /* read in nonce/ctr => ctr */
         aes_read_block(env, mmu_idx, *ctr_ptr_reg + done, ctr, ra);
-        /* encrypt ctr => buf */
-        AES_encrypt(ctr, buf, &exkey);
         /* read in one block of input data => in */
         aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
-        /* xor input data with encrypted ctr => out */
-        aes_xor(in, buf, out);
+        /* encrypt ctr and xor with in => out */
+        AES_ctr_encrypt(in, out, ctr, &exkey);
         /* write out the processed block */
         aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
         len -= AES_BLOCK_SIZE, done += AES_BLOCK_SIZE;
@@ -353,28 +335,13 @@ int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     return 0;
 }
 
-static void aes_xts_prep_next_tweak(uint8_t tweak[AES_BLOCK_SIZE])
-{
-    uint8_t carry;
-    int i;
-
-    carry = tweak[AES_BLOCK_SIZE - 1] >> 7;
-
-    for (i = AES_BLOCK_SIZE - 1; i > 0; i--) {
-        tweak[i] = (uint8_t)((tweak[i] << 1) | (tweak[i - 1] >> 7));
-    }
-
-    tweak[i] = (uint8_t)(tweak[i] << 1);
-    tweak[i] ^= (uint8_t)(0x87 & (uint8_t)(-(int8_t)carry));
-}
-
 int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t param_addr, uint64_t *dst_ptr_reg,
                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                   uint32_t type, uint8_t fc, uint8_t mod)
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
-    uint8_t buf1[AES_BLOCK_SIZE], buf2[AES_BLOCK_SIZE];
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
     const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     uint64_t addr, len = *src_len_reg, done = 0;
     uint8_t key[32], tweak[AES_BLOCK_SIZE];
@@ -425,23 +392,19 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     /* process up to MAX_BLOCKS_PER_RUN aes blocks */
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
-        /* fetch one AES block into buf1  */
-        aes_read_block(env, mmu_idx, *src_ptr_reg + done, buf1, ra);
-        /* buf1 xor tweak => buf2 */
-        aes_xor(buf1, tweak, buf2);
+        /* fetch one AES block into in  */
+        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
         if (mod) {
-            /* decrypt buf2 => buf1 */
-            AES_decrypt(buf2, buf1, &exkey);
+            /* decrypt in => out */
+            AES_xts_decrypt(in, out, tweak, &exkey);
         } else {
-            /* encrypt buf2 => buf1 */
-            AES_encrypt(buf2, buf1, &exkey);
+            /* encrypt in => out */
+            AES_xts_encrypt(in, out, tweak, &exkey);
         }
-        /* buf1 xor tweak => buf2 */
-        aes_xor(buf1, tweak, buf2);
         /* prep tweak for next round */
-        aes_xts_prep_next_tweak(tweak);
-        /* write out this processed block from buf2 */
-        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, buf2, ra);
+        AES_xts_prep_next_tweak(tweak);
+        /* write out this processed block from out */
+        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
         len -= AES_BLOCK_SIZE, done += AES_BLOCK_SIZE;
     }
 
@@ -637,7 +600,7 @@ int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint32_t type, uint8_t fc, uint8_t mod)
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
-    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
     const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     uint8_t key[32], wkvp[32], iv[AES_BLOCK_SIZE];
     uint64_t addr, len = *src_len_reg, done = 0;
@@ -705,19 +668,11 @@ int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
         aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
         if (mod) {
-            /* decrypt in => buf */
-            AES_decrypt(in, buf, &exkey);
-            /* buf xor iv => out */
-            aes_xor(buf, iv, out);
-            /* prep iv for next round */
-            memcpy(iv, in, AES_BLOCK_SIZE);
+            /* decrypt in => out */
+            AES_cbc_decrypt(in, out, iv, &exkey);
         } else {
-            /* in xor iv => buf */
-            aes_xor(in, iv, buf);
-            /* encrypt buf => out */
-            AES_encrypt(buf, out, &exkey);
-            /* prep iv for next round */
-            memcpy(iv, out, AES_BLOCK_SIZE);
+            /* encrypt in => out */
+            AES_cbc_encrypt(in, out, iv, &exkey);
         }
         aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
         len -= AES_BLOCK_SIZE, done += AES_BLOCK_SIZE;
@@ -746,11 +701,10 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
     const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
-    uint8_t ctr[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
     uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
+    uint8_t ctr[AES_BLOCK_SIZE], key[32], wkvp[32];
     uint64_t addr, len = *src_len_reg, done = 0;
     int i, keysize, addr_reg_size = 64;
-    uint8_t key[32], wkvp[32];
     AES_KEY exkey;
 
     g_assert(type == S390_FEAT_TYPE_KMCTR);
@@ -804,12 +758,10 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
         /* read in nonce/ctr => ctr */
         aes_read_block(env, mmu_idx, *ctr_ptr_reg + done, ctr, ra);
-        /* encrypt ctr => buf */
-        AES_encrypt(ctr, buf, &exkey);
         /* read in one block of input data => in */
         aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
-        /* exor input data with encrypted ctr => out */
-        aes_xor(in, buf, out);
+        /* encrypt ctr and xor with in => out */
+        AES_ctr_encrypt(in, out, ctr, &exkey);
         /* write out the processed block */
         aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
         len -= AES_BLOCK_SIZE, done += AES_BLOCK_SIZE;
@@ -909,7 +861,7 @@ int cpacf_paes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint32_t type, uint8_t fc, uint8_t mod)
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
-    uint8_t buf1[AES_BLOCK_SIZE], buf2[AES_BLOCK_SIZE];
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
     const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     uint8_t key[32], wkvp[32], tweak[AES_BLOCK_SIZE];
     uint64_t addr, len = *src_len_reg, done = 0;
@@ -972,23 +924,19 @@ int cpacf_paes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     /* process up to MAX_BLOCKS_PER_RUN aes blocks */
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
-        /* fetch one AES block into buf1  */
-        aes_read_block(env, mmu_idx, *src_ptr_reg + done, buf1, ra);
-        /* buf1 xor tweak => buf2 */
-        aes_xor(buf1, tweak, buf2);
+        /* fetch one AES block into in */
+        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
         if (mod) {
-            /* decrypt buf2 => buf1 */
-            AES_decrypt(buf2, buf1, &exkey);
+            /* decrypt in => out */
+            AES_xts_decrypt(in, out, tweak, &exkey);
         } else {
-            /* encrypt buf2 => buf1 */
-            AES_encrypt(buf2, buf1, &exkey);
+            /* encrypt in => out */
+            AES_xts_encrypt(in, out, tweak, &exkey);
         }
-        /* buf1 xor tweak => buf2 */
-        aes_xor(buf1, tweak, buf2);
         /* prep tweak for next round */
-        aes_xts_prep_next_tweak(tweak);
-        /* write out this processed block from buf2 */
-        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, buf2, ra);
+        AES_xts_prep_next_tweak(tweak);
+        /* write out this processed block from out */
+        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
         len -= AES_BLOCK_SIZE, done += AES_BLOCK_SIZE;
     }
 
-- 
2.43.0

