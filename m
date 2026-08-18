Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B5A4315F
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069926; cv=none; b=tVVXi7s5LpkX+MhZcdgeLu9CZmqZZsUgoizex8nQhnX+OMwqsLbaDT4EkeBynDn6a/LeIGi+ZxxgVUQOUQIem5I3DNHq9m4HLbaxuSghXoWrhEePhnFpSV3VENXUOUu8ULjdYn3OOdV272YCL7oORAdvIL9AkhKY2poRtCjSPXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069926; c=relaxed/simple;
	bh=XXeEROsZwh2IQp0rH0mNSOSescRKARW0wxhQ4avFQP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYh9imwx7tTFm6olzhvWLbpd9xry1TAux8NjOfaHf+eV/W7VZoPF1IJaw9eZbgrX9BIdgDYpNmLGSSTDqVCyAulwv6VYdFlQxdJ3u5pUcRpXw0S74iaGAXm+shBTq67uuyUlWJS80rJ/j/DidEe+0Y+ZAH+lQGFHoaC78B563K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mqRy8yaP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mqRy8yaP"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3ZV3505190;
	Tue, 18 Aug 2026 16:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=F4NH91p3BhNpHCGHm
	IeFJlmR0qY0Jy9dUnWWDiuKFeg=; b=mqRy8yaPrCL3Dv8zyma1aI1X5noql6lrp
	8wNua31o9YUowYz8XzMteeawC8MUL1F1ekhT2aV74FGa941SC5zVvYTSIiX0VljO
	FRnNfCOx9ua0u0U7KqOSB0pUAs4vUdnQ5HaG7KDLY50LnOAWWxIHonyCLykRMIYw
	SjqZVMB2XMJiVPirChkeOsoTxPMD34P4BAt4IlDdB7zq5ZMJaHSNPCqx1IrqO/lX
	E3vfrQtadbz24OMCif3UZ+EoRNjn64cjkSG4SGbJMRQ82R+V6RF7qLnrAFsgbUpV
	72dTOwGj4DrYx2qLjXryv50h0XJKQrK2ik2G/hBerJzYbi826GLbA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4sedp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 16:18:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IGBM4s017999;
	Tue, 18 Aug 2026 16:18:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ybvy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 16:18:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IGIRFG49676552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 16:18:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F67F20043;
	Tue, 18 Aug 2026 16:18:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54F4E2004B;
	Tue, 18 Aug 2026 16:18:27 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.161.134])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 16:18:27 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v15 12/20] target/s390x: Support AES XTS for cpacf km instruction
Date: Tue, 18 Aug 2026 18:18:16 +0200
Message-ID: <20260818161824.100746-13-freude@linux.ibm.com>
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
X-Proofpoint-GUID: zC74cSdEgH3eN-vBHB134vfGL1tHQF1z
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a8485d8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=NfUx3EYS-SKBlRlFgzgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDExOCBTYWx0ZWRfX9K2UBYhE8lYp
 ZAyRizbUiyHqBuqGBNVx4anCUAMSDpplQ7rs9cFW/aaD5huLb0t6WhjDZCp+ZcIjvlz3tYo+Eup
 PMA4C/6IjwwsMnpXmbWZ91Jh3izMZek=
X-Proofpoint-ORIG-GUID: zC74cSdEgH3eN-vBHB134vfGL1tHQF1z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDExOCBTYWx0ZWRfX0j6Ir8XM3JsT
 Bi7zdpsKPiI05II3FWVl0NSYQnxs8lbMJONJOhDzCnivISfat2pTfh6a7Won4422Dgtb5nFg0RL
 sxxlPJM1SpLZlMB/9c7OwSnOMjZLKXuhqAwFlpn35wdM9WjUXHhs8xzjOgRzpdTcf0r8GgkoLmm
 T9VqJTehOAQiwQvMPGKz3ugep/ODL45ejOG9sf0xoeAW/m7qtAfQpBpQ6B/nWGWa/UnjRgU4Rzx
 1sGb8dh0sC6ipFIA6ITBaoqwpER777CXZJvnQPD8nN1SC+cNrn0PMhloD7os+rypwXc5lWhGYM4
 cN0p0uAn/B0RRFkxaUHc2pSTP4iAH6Lk+Hwvjt1UeTvgroxzjO83/UfxaGtLgCTROdwh2HORSvZ
 qrTngkfkyeNOLk3NbJzMp9Rt4AeRYmgT5cB8i+JoMMshc7meXV+QnJsvB3xuZh8Eo4gN4n/U1SU
 kYHknjOw1NQp15ARrEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180118

Support the subfunctions XTS-AES-128 and XTS-AES-256
for the cpacf km instruction.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/gen-features.c      |  2 +
 target/s390x/tcg/cpacf.h         |  4 ++
 target/s390x/tcg/cpacf_aes.c     | 93 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |  6 +++
 4 files changed, 105 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 4132d7b932..078aeddb36 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -925,6 +925,8 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KM_AES_128,
     S390_FEAT_KM_AES_192,
     S390_FEAT_KM_AES_256,
+    S390_FEAT_KM_XTS_AES_128,
+    S390_FEAT_KM_XTS_AES_256,
     S390_FEAT_KMC_AES_128,
     S390_FEAT_KMC_AES_192,
     S390_FEAT_KMC_AES_256,
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 4a20aeacde..5013e19907 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -34,5 +34,9 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint8_t fc, uint8_t mod);
 int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t param_addr, uint8_t fc);
+int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                  uint64_t param_addr, uint64_t *dst_ptr_reg,
+                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                  uint32_t type, uint8_t fc, uint8_t mod);
 
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index b9e6d3d332..735cabdb1b 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -362,3 +362,96 @@ int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return 0;
 }
+
+int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                  uint64_t param_addr, uint64_t *dst_ptr_reg,
+                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                  uint32_t type, uint8_t fc, uint8_t mod)
+{
+    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
+    uint64_t len = *src_len_reg, done = 0;
+    uint8_t key[32], tweak[AES_BLOCK_SIZE];
+    int i, keysize, addr_reg_size;
+    AES_KEY exkey;
+
+    g_assert(type == S390_FEAT_TYPE_KM);
+
+    switch (fc) {
+    case CPACF_KM_XTS_128:
+        keysize = 16;
+        break;
+    case CPACF_KM_XTS_256:
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
+    /* fetch key from param block */
+    read_guest_wrap_u8(env, mmu_idx, ra, param_addr, key, keysize);
+
+    /* expand key */
+    if (mod) {
+        AES_set_decrypt_key(key, keysize * 8, &exkey);
+    } else {
+        AES_set_encrypt_key(key, keysize * 8, &exkey);
+    }
+
+    /* fetch tweak from param block */
+    read_guest_wrap_u8(env, mmu_idx, ra,
+                       param_addr + keysize, tweak, AES_BLOCK_SIZE);
+
+    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
+    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
+        /* fetch one AES block into in  */
+        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
+        if (mod) {
+            /* decrypt in => out */
+            AES_xts_decrypt(in, out, tweak, &exkey);
+        } else {
+            /* encrypt in => out */
+            AES_xts_encrypt(in, out, tweak, &exkey);
+        }
+        /* prep tweak for next round */
+        AES_xts_prep_next_tweak(tweak);
+        /* write out this processed block from out */
+        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
+        len -= AES_BLOCK_SIZE;
+        done += AES_BLOCK_SIZE;
+    }
+
+    /* update tweak in param block */
+    write_guest_wrap_u8(env, mmu_idx, ra,
+                        param_addr + keysize, tweak, AES_BLOCK_SIZE);
+
+    *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
+                             *src_ptr_reg + done);
+    *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
+                             *dst_ptr_reg + done);
+    *src_len_reg -= done;
+
+    return !len ? 0 : 3;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index affaaede52..1ced5c123e 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -112,6 +112,12 @@ static int cpacf_km(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
                            S390_FEAT_TYPE_KM, fc, mod);
         break;
+    case CPACF_KM_XTS_128:
+    case CPACF_KM_XTS_256:
+        rc = cpacf_aes_xts(env, mmu_idx, ra, env->regs[1],
+                           &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
+                           S390_FEAT_TYPE_KM, fc, mod);
+        break;
     default:
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
-- 
2.43.0

