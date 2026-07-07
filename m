Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDEA433BDD
	for <linux-s390@vger.kernel.org>; Tue,  7 Jul 2026 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441118; cv=none; b=jT3FGr7X2+Qw1aaZLAgCmmz/LtdJD3k9BFtcieC52kiWsQbji/jj69gK2gDB6P1JinIbumm56nei/y+kDhUvUVYlrsySFlh2qnMZen0KmJlC2zaauIqVL13e477LARM6veP6rIicRS/W4j5YCgSkseAp5MIXnyzCZ2RP5TApiRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441118; c=relaxed/simple;
	bh=86ftElxmDEZvGysJozcShn5GAgvUhNwrm7ONGX74oiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dibQK3JxMQKT77pitN02tA8tJ912oZlaOpBcJkq6+vH85Xx/KTZw0zsvoSp+tlmSADqozjYcJS0PWmTTPfXVGb4+5ME8J3dxmX+AUajdTKUmTYuLvar4XzsXDOynAXhozJ4tvg5+eGYa/hZc5thNhACfQvV9cpvX5KxohCXTI+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cmP9jvYj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cmP9jvYj"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667FmLJb3445448;
	Tue, 7 Jul 2026 16:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zuoyNuV27ihAoaiof
	nNxvMSMvy1KSb9j2diu0GGvKOM=; b=cmP9jvYjJ24b2ovvumCdgQtNtp3x4ZEAT
	dFnTPXBWuRhiZcudBbznefdGkWyYvE8zk6PQ+NDmnyMdTbG0QfuxNEOHwVEYbOwb
	IYJ2u1qGW7TBFq4f+P226j476nJGl14buEPVs7AsXrDnCe4S3XlfE5k/Bg+eqTVR
	Ozk21Dp3JoDbxcBg5GPBYxEDW9JQ0oGTpEwrrQLEl8r1xeKPx0xITbzgpWCJOcBz
	hK7HTFKCo/sDVlOPYLdVlxrOWIOitHjNG5IevgzGn4DRFlsAeiOpCTJNIY+YRkCI
	ZRqUkIc3YlxPlh9R8FfhbQ5JdNvW7BK+jke1oGHRFcObvLTTOZsDA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdrq04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 16:18:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667G4dpa005437;
	Tue, 7 Jul 2026 16:18:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvw3sjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 16:18:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 667GIHQT53019108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 16:18:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7317A20043;
	Tue,  7 Jul 2026 16:18:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 438A120065;
	Tue,  7 Jul 2026 16:18:17 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.140.5])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 16:18:17 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v11 19/21] target/s390x: Use generic AES helper functions
Date: Tue,  7 Jul 2026 18:18:06 +0200
Message-ID: <20260707161815.40919-20-freude@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4d26ce cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=RTVADdF_yP6blHuwIEIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE2MCBTYWx0ZWRfX2X4sVERmOPN0
 jUPcNWxWD+lNECcH7IOZgTM/+8hQjapqqKBsYERJx91sCiHFbIUIWUJWiekO5k0jA1i4UtiPlPa
 KeVC2buFxi7yXM2U5UXkV2QdAHG9e0WBjKIaRQEwlij60yHeO6LNWOONWINBI2WQrJ2vnTEyfYr
 E9DpeOpe9PBXm8LdJHWR6yplXfID6Z7tz7qbvTy/CVPC5mZMwGJvKt/Qln8cX0HNUZ1S1+zCNlO
 HWFLGxGinBOMHuLVAc4nCcaYg7A84I3yU2zSaAh86BOVWQ1inkdGAcxT03UApOiY9JEOHxu41Ho
 ZwzimxmgHs1PgbMIg4XFmP+3dZKaEXRYvNrzS/o6MNk0OrvnRNaFww4SWrfFDzH9oFljqJ13bpw
 IkYDTpwDNZpwyDIX/c3UV9AxT44zsoSgzDqZci0FTgucOR6rOGFBRB1xXkeXS9qdz+gXdKlqFw9
 /OI1nRcP6YL1DZxxQUA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE2MCBTYWx0ZWRfX6oBGZ3oDA93E
 C29t+FMHSFL9dujfIYEQmiB0uqUurXj+C+J1A91PAfkJpXqsCRhqPQPFdmB98cu0L/99fo3lfLY
 95XLEaj+pi2I/FkQWDCrqBGOoCqx4t4=
X-Proofpoint-GUID: SraOwHWZwIY1hv8ctsD7KCj-Q4vlyhfn
X-Proofpoint-ORIG-GUID: SraOwHWZwIY1hv8ctsD7KCj-Q4vlyhfn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070160

Rewrite the cpacf implementations to use the generic
AES helper functions from crypto/aes-helpers.c

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
---
 target/s390x/tcg/cpacf_aes.c | 124 ++++++++++-------------------------
 1 file changed, 36 insertions(+), 88 deletions(-)

diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 4449bbc0d2..e9f0db2b5a 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -110,20 +110,13 @@ int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
@@ -179,19 +172,11 @@ int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
         len -= AES_BLOCK_SIZE;
@@ -221,11 +206,10 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
@@ -267,12 +251,10 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
         len -= AES_BLOCK_SIZE;
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
         len -= AES_BLOCK_SIZE;
         done += AES_BLOCK_SIZE;
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
         len -= AES_BLOCK_SIZE;
@@ -747,11 +702,10 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
@@ -805,12 +759,10 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
         len -= AES_BLOCK_SIZE;
@@ -911,7 +863,7 @@ int cpacf_paes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint32_t type, uint8_t fc, uint8_t mod)
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
-    uint8_t buf1[AES_BLOCK_SIZE], buf2[AES_BLOCK_SIZE];
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
     const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     uint8_t key[32], wkvp[32], tweak[AES_BLOCK_SIZE];
     uint64_t addr, len = *src_len_reg, done = 0;
@@ -974,23 +926,19 @@ int cpacf_paes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
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
         len -= AES_BLOCK_SIZE;
         done += AES_BLOCK_SIZE;
     }
-- 
2.43.0

