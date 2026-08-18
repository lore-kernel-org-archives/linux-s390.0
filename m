Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFE547CA9F
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069927; cv=none; b=XdWHoDp7lQb++0a/jn2rLNFZZfog6qwE4Q6ZvlSgrb53u0pRad5WqmjzLFd1nR6PLDuDw3pQA1NFQ621Yox0U5BAOx1XcGUbWycaZJ/z0+tgukBp4pCI+w0JSCUGg2JHKq2to24mmH0QZModte/qACZ0EUvOI5LQYjv5v06P6us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069927; c=relaxed/simple;
	bh=QbGfGZ7Fxmu3uQFZ0iFAdSg8wXv65PQ++wHcqioy/ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FotO4LpYsXtEBfLZGStKZzZhkWHt5RKmcpeRT+6KZMwwEfqinSJv9jwI/ANJRfmAHuOp/iYXPdz3elBLZ34HjI7nUofSTt8cyx+6UHaZJxUF2Fo+JEdQWLQaVTRt2KIPs4eaIwJcWO9Sdbxz1bojjLIvgfukuvvEiIoTqFr5lvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UOzt7Mmb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UOzt7Mmb"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3oHL2831697;
	Tue, 18 Aug 2026 16:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tXUhasaY/5qap0fF2
	3qRfzzQxZ3bLjN4yF+zGsblRm0=; b=UOzt7MmbFw8kN5ThgqeQFllNf43n1B9M8
	O5t+CpB6k9/SPLjYlwKfiYR+F3yTvvz2Zptrw+kMEgMEUb4IsN0KFf6RnrjwKXeb
	WBUzwo1k7jlshAKfctn7TPkFf60gfYoOnwoif8/L/vVtO+s8Ba2Dgi2xQR2gFamu
	zOL8oB2j3tA43C+p+tq4ZmM/3mb9fLlSr7D1XbcS7xIvbVcVtjqXm9p8h1qWpzc3
	ghEu5vcCef8p86xDlcU3x8nvXG8Hxe5MUHWJ9NY0p9qlQO2IAisRJ1Fl0mCqiL6E
	kgjieP3O+C60PrTlRqEjNU3Cr3qPhg4Tst4zWiQ7LowJegGCxenLA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqsck5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 16:18:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IGBMUJ023737;
	Tue, 18 Aug 2026 16:18:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq49xg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 16:18:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IGIS7s43581770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 16:18:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 584922004B;
	Tue, 18 Aug 2026 16:18:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DA8E20043;
	Tue, 18 Aug 2026 16:18:28 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.161.134])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 16:18:28 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v15 16/20] target/s390x: Support protected key AES CTR for cpacf kmctr instruction
Date: Tue, 18 Aug 2026 18:18:20 +0200
Message-ID: <20260818161824.100746-17-freude@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDExOCBTYWx0ZWRfXw/P3uuMo2WPF
 ugAATkHJVzE9mWycBHTpc14NtRhJ7OAM/WtvBgM7PfIZPi/7EZS2KQBV92F125ZAkiQWehj5iiN
 +67qMNBSKs6tdwF+Ki3J+ZtF7+pL13i0/RIcaUIXRxxF6M1yrhHkv6bo64q80BdD6GJuSo3LqpA
 p+s3GeUlBsLhupU/O8PvPrJNJponAEV1+116PjLomR6jIxLur+yqWRC/IW5+sSjeonqvA//29ax
 yT5ESZS4FC8C0GZEZztepkZMvrFcqCtns6ume8yY2ELT01b+EcvEtjeE/Dc1txXwxLyaJEku8Hu
 NF804vUIMcNRsfc8H6rCx9iEAyF6MbgHFU9TPeYN7/5ABfI+bYTSOPWgLKTmg4FvS8Z6adfyXHA
 Qks5IbhoEfxejqtDtyd+5YcTd+WjxVmRxoVj1xIJlt8OmUavXX+ndDG7bHMKLiCH6V1svzkgXFK
 v3BQMt/xg5MQlLkXjnA==
X-Proofpoint-ORIG-GUID: Ap3AV2PLrKdx1BSa7ecL98V5VTbaoEv5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDExOCBTYWx0ZWRfX/3IzZdeRPM0f
 CK4gPVjrz544iGeUQHTLIzXFzBDauLuBA73bF+pL5Yljh4ObswDsOM/TiVsX2BrG+n75Vph877o
 L/LA4OveKtSkWk2vpDg+2/1eSNNghVo=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a8485d8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=f59o6tnjY-_5Ge3baHwA:9
X-Proofpoint-GUID: Ap3AV2PLrKdx1BSa7ecL98V5VTbaoEv5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180118

Support the subfunctions CPACF_KMCTR_PAES_128, CPACF_KMCTR_PAES_192
and CPACF_KMCTR_PAES_256 for the cpacf kmctr instruction.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/gen-features.c      |  3 ++
 target/s390x/tcg/cpacf.h         |  5 ++
 target/s390x/tcg/cpacf_aes.c     | 92 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |  7 +++
 4 files changed, 107 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index d1fce9e00c..9898f880a6 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -939,6 +939,9 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KMCTR_AES_128,
     S390_FEAT_KMCTR_AES_192,
     S390_FEAT_KMCTR_AES_256,
+    S390_FEAT_KMCTR_EAES_128,
+    S390_FEAT_KMCTR_EAES_192,
+    S390_FEAT_KMCTR_EAES_256,
     S390_FEAT_PCC_XTS_AES_128,
     S390_FEAT_PCC_XTS_AES_256,
     S390_FEAT_PCKMO_AES_128,
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 73cb564c0b..15fd860e3a 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -48,5 +48,10 @@ int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint64_t param_addr, uint64_t *dst_ptr_reg,
                    uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                    uint32_t type, uint8_t fc, uint8_t mod);
+int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint64_t *dst_ptr_reg,
+                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                   uint64_t *ctr_ptr_reg, uint32_t type,
+                   uint8_t fc, uint8_t mod);
 
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index e2a01b8bef..6208c7f27d 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -724,3 +724,95 @@ int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return !len ? 0 : 3;
 }
+
+int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint64_t *dst_ptr_reg,
+                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                   uint64_t *ctr_ptr_reg, uint32_t type,
+                   uint8_t fc, uint8_t mod)
+{
+    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
+    uint8_t ctr[AES_BLOCK_SIZE], key[32], wkvp[32];
+    uint64_t len = *src_len_reg, done = 0;
+    int i, keysize, addr_reg_size;
+    AES_KEY exkey;
+
+    g_assert(type == S390_FEAT_TYPE_KMCTR);
+
+    switch (fc) {
+    case CPACF_KMCTR_PAES_128:
+        keysize = 16;
+        break;
+    case CPACF_KMCTR_PAES_192:
+        keysize = 24;
+        break;
+    case CPACF_KMCTR_PAES_256:
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
+    /* fetch and check wkvp from param block */
+    read_guest_wrap_u8(env, mmu_idx, ra,
+                       param_addr + keysize, wkvp, sizeof(wkvp));
+    if (memcmp(wkvp, protkey_wkvp, sizeof(wkvp))) {
+        /* wkvp mismatch -> return with cc 1 */
+        return 1;
+    }
+
+    /* fetch protected key from param block */
+    read_guest_wrap_u8(env, mmu_idx, ra, param_addr, key, keysize);
+    /* decrypt the protected key */
+    decrypt_protkey(key, keysize);
+
+    /* expand key */
+    AES_set_encrypt_key(key, keysize * 8, &exkey);
+
+    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
+    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
+        /* read in nonce/ctr => ctr */
+        aes_read_block(env, mmu_idx, ra, *ctr_ptr_reg + done, ctr);
+        /* read in one block of input data => in */
+        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
+        /* encrypt ctr and xor with in => out */
+        AES_ctr_encrypt(in, out, ctr, &exkey);
+        /* write out the processed block */
+        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
+        len -= AES_BLOCK_SIZE;
+        done += AES_BLOCK_SIZE;
+    }
+
+    *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
+                             *src_ptr_reg + done);
+    *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
+                             *dst_ptr_reg + done);
+    *ctr_ptr_reg = deposit64(*ctr_ptr_reg, 0, addr_reg_size,
+                             *ctr_ptr_reg + done);
+    *src_len_reg -= done;
+
+    return !len ? 0 : 3;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 44c24c632c..e9344dbbd9 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -174,6 +174,13 @@ static int cpacf_kmctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
                            &env->regs[r3], S390_FEAT_TYPE_KMCTR, fc, mod);
         break;
+    case CPACF_KMCTR_PAES_128:
+    case CPACF_KMCTR_PAES_192:
+    case CPACF_KMCTR_PAES_256:
+        rc = cpacf_paes_ctr(env, mmu_idx, ra, env->regs[1],
+                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
+                            &env->regs[r3], S390_FEAT_TYPE_KMCTR, fc, mod);
+        break;
     default:
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
-- 
2.43.0

