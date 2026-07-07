Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906A7434E29
	for <linux-s390@vger.kernel.org>; Tue,  7 Jul 2026 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441139; cv=none; b=GAAv3DbZjmaGWth8djAXFQt3ezZBI7hEJ8cXKD+eK1vz38ZiZ+txdu7BCOqUDLJLaa5FcKcCyMN9YB0oaewZ2eR1drtSkcRvFEhJxId94POjuwkWv9OVdz2CIEtQWfc6+bdvPNQIiRmqwh2qVgwBJM+YhIiTIniWJjl392LV8zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441139; c=relaxed/simple;
	bh=08t+t4coVPLnAok23h5dIGD/Jgmsv6gcORrJe5Hpnrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcBhXCT4xCroC92KHQZzbME03ov59aRkQOXDt6FH9PTwOBqv2V1AVBuax/V8HgmQzmLFo49nbt51oeZX1B8gpmYVxFp65bqa4e64k764u2HQERU7/FFxe+dk8DTORzs3Olg/6YZv4PUoOs3qk2cTHIWUn6Dc8AZCsaFPvw7SdNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cQJQArBZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cQJQArBZ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667FmL1e309989;
	Tue, 7 Jul 2026 16:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cZnmrFGb/tJIR6vCz
	XKnZfoyjp6UMfQ6Br7MOrrwrvc=; b=cQJQArBZQpaEPp3IsgXuCNNK9jTuT70L0
	GkSj/8Lg87h/dQOV0rsXJdDKioKeRD8ZIxfHgG8uWwWTAgcIKkkjEwKf81FRxHbQ
	Hu3noGfPq7cGG3VdFbZYwyvjRoay50+kw77xNoBC/esz4rKZVu/u/MFWjXOZq34q
	5TqDN2fl4YbQBv49H3pplvINZhaqksa8IX9VWj/bR71AwDmW3q5q+56Q1G/KLzjP
	cBXYSUBkQJzajoBx3ApnNe5I03mTv2Jc9FTSlBtDkKNZaRkh8lGsLGjgcaN895I+
	mfqV13heDlDEeuUkbfx+dnN+Zv/WDba4MKvMOTyabxiI6rDkbC2JQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqqw2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 16:18:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667G4dof003243;
	Tue, 7 Jul 2026 16:18:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hbh93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 16:18:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 667GIHEi44237252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 16:18:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF2962004D;
	Tue,  7 Jul 2026 16:18:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77CA32004B;
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
Subject: [PATCH v11 20/21] target/s390x: Improve fetch and store mem from and to guest
Date: Tue,  7 Jul 2026 18:18:07 +0200
Message-ID: <20260707161815.40919-21-freude@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE2MCBTYWx0ZWRfX4gTS3UrxLa4B
 bpTDksP91QyaMq+in/eoqJ9349ry2atdbjcwt21LtCmYRPDp2xMPPHwGYvsM1UJ+cvU8YzqY2GT
 KG4W1rfRvC7UQ8pYNMurh15SvblZkEQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE2MCBTYWx0ZWRfX3o8CABMDHLdS
 PpOpm+4e/r+UNNdBAumYb8udbZeHlVpi3ZemxvC3leLymSlJkMoraVwP2dPeVtYE9FLJf7Fqyxu
 G9Y1pmGI7W2P2JBq0W5odJ2KPfBF8HIR7vunoY5AJi7BSDgZuW8SAxcrnfbY7eF62dgkCvELrMB
 oT1HnAkffwVSzpv13csTnDqnfXHeDLME65rnxdXksXwifkLRQx5c7Eh3C+/dMW3Nv9ZcaqX+VUH
 jj8cn2HpD97nulGg5bFXx49eiGVaOmp5Ky6Ty98P9LEyahfbP8bpspN37blh1v4paWQgtkw71VB
 NX4VK+92fWTLbz9BpS+S7rKkRR4zwVENyjRf94fCj49AIvFeXoAjRziS20NWwmJEFVLwrqNO1nB
 RTTatqJkLD9wR42BKGpdkwH/38YLnNhW+rbC2zxeAwp7Mv4R7ZI4e58ZbPtUO4JudpbIR7ITSSQ
 Y4SGyyCBeCZZVrlG04A==
X-Proofpoint-GUID: dDoAl2NGbNbtn8CG5n0G0IbL4ZINzKoT
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4d26cf cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=SH-LS3B6E9p2pXL9WtEA:9
 a=ZDSMja1iq-x7GFnX:21
X-Proofpoint-ORIG-GUID: dDoAl2NGbNbtn8CG5n0G0IbL4ZINzKoT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070160

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
index e9f0db2b5a..ece70d989d 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -15,37 +15,64 @@
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
@@ -76,10 +103,7 @@ int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     }
 
     /* fetch key from param block */
-    for (i = 0; i < keysize; i++) {
-        addr = wrap_address(env, param_addr + i);
-        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
-    }
+    copy_from_guest_wrap(env, mmu_idx, ra, param_addr, key, keysize);
 
     /* expand key */
     if (mod) {
@@ -90,13 +114,13 @@ int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
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
@@ -117,8 +141,7 @@ int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
     uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
-    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
-    uint64_t addr, len = *src_len_reg, done = 0;
+    uint64_t len = *src_len_reg, done = 0;
     int i, keysize, addr_reg_size = 64;
     uint8_t key[32], iv[AES_BLOCK_SIZE];
     AES_KEY exkey;
@@ -150,16 +173,11 @@ int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
@@ -170,7 +188,7 @@ int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     /* process up to MAX_BLOCKS_PER_RUN aes blocks */
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
-        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
+        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
         if (mod) {
             /* decrypt in => out */
             AES_cbc_decrypt(in, out, iv, &exkey);
@@ -178,16 +196,13 @@ int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
@@ -205,9 +220,8 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
@@ -239,10 +253,7 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     }
 
     /* fetch key from param block */
-    for (i = 0; i < keysize; i++) {
-        addr = wrap_address(env, param_addr + i);
-        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
-    }
+    copy_from_guest_wrap(env, mmu_idx, ra, param_addr, key, keysize);
 
     /* expand key */
     AES_set_encrypt_key(key, keysize * 8, &exkey);
@@ -250,13 +261,13 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
@@ -276,9 +287,7 @@ int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t param_addr, uint8_t fc)
 {
     uint8_t key[32], tweak[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
-    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     int keysize, i;
-    uint64_t addr;
     AES_KEY exkey;
 
     switch (fc) {
@@ -293,10 +302,9 @@ int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
@@ -309,16 +317,11 @@ int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
@@ -327,10 +330,9 @@ int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
@@ -342,8 +344,7 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
     uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
-    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
-    uint64_t addr, len = *src_len_reg, done = 0;
+    uint64_t len = *src_len_reg, done = 0;
     uint8_t key[32], tweak[AES_BLOCK_SIZE];
     int i, keysize, addr_reg_size = 64;
     AES_KEY exkey;
@@ -372,10 +373,7 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     }
 
     /* fetch key from param block */
-    for (i = 0; i < keysize; i++) {
-        addr = wrap_address(env, param_addr + i);
-        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
-    }
+    copy_from_guest_wrap(env, mmu_idx, ra, param_addr, key, keysize);
 
     /* expand key */
     if (mod) {
@@ -385,15 +383,13 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
@@ -404,16 +400,14 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
@@ -466,10 +460,8 @@ static void decrypt_protkey(uint8_t *key, int keysize)
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
@@ -486,24 +478,17 @@ int cpacf_aes_pckmo(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
@@ -514,9 +499,8 @@ int cpacf_paes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
@@ -548,20 +532,15 @@ int cpacf_paes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
 
@@ -574,13 +553,13 @@ int cpacf_paes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
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
@@ -601,9 +580,8 @@ int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
     uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
-    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     uint8_t key[32], wkvp[32], iv[AES_BLOCK_SIZE];
-    uint64_t addr, len = *src_len_reg, done = 0;
+    uint64_t len = *src_len_reg, done = 0;
     int i, keysize, addr_reg_size = 64;
     AES_KEY exkey;
 
@@ -634,26 +612,20 @@ int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
 
@@ -666,7 +638,7 @@ int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     /* process up to MAX_BLOCKS_PER_RUN aes blocks */
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
-        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
+        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
         if (mod) {
             /* decrypt in => out */
             AES_cbc_decrypt(in, out, iv, &exkey);
@@ -674,16 +646,13 @@ int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
@@ -701,10 +670,9 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
 
@@ -735,20 +703,15 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
 
@@ -758,13 +721,13 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
@@ -784,9 +747,7 @@ int cpacf_paes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint64_t param_addr, uint8_t fc)
 {
     uint8_t key[32], wkvp[32], tweak[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
-    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     int keysize, i;
-    uint64_t addr;
     AES_KEY exkey;
 
     switch (fc) {
@@ -801,21 +762,17 @@ int cpacf_paes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
@@ -828,18 +785,14 @@ int cpacf_paes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
@@ -848,11 +801,9 @@ int cpacf_paes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
@@ -864,9 +815,8 @@ int cpacf_paes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
     uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
-    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     uint8_t key[32], wkvp[32], tweak[AES_BLOCK_SIZE];
-    uint64_t addr, len = *src_len_reg, done = 0;
+    uint64_t len = *src_len_reg, done = 0;
     int i, keysize, addr_reg_size = 64;
     AES_KEY exkey;
 
@@ -894,20 +844,15 @@ int cpacf_paes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
 
@@ -919,15 +864,14 @@ int cpacf_paes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
@@ -938,16 +882,15 @@ int cpacf_paes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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

