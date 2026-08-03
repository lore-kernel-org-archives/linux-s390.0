Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A3D369985
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773572; cv=none; b=WnhVkd0Rx8iFt1vmgavZH6ZDpSDwjERdXc4yq2nxUYn4QthJJPWDg8w1a9aGNJLF4gbWcgRFyQr3NJ4ESzQW8e/laxUIPXaQYBcsM3TXxWH1iChD2NY5ryLCM/0CbZBc62vQMFvP7Syd8PqnSFp6qv7vfVQThU+7qcinloE2NBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773572; c=relaxed/simple;
	bh=kyCdIfpX+Y+GNeavhRMbp8nF+yd0ac41HrNcQbFTSz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTy4s4W46bHouUnUR6ARbxp9O2xDOJzEGQjVyHRZQKofZbn35IgYao0X3Kkx7aqoPXXZ1JaM7DdQWmzG6gMxwO3tJkGnwA2Zv2qkQ3pcZhDFL1CvANUMHC6FUL4uVsy+s58aORJ0nDcog/4c6k7ajfA6+j67B+PUQ+saVOzpxgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R/lgm9FR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R/lgm9FR"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHrBR2341591;
	Mon, 3 Aug 2026 16:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qsodicJO2X68ujhIG
	G2ufJWH6f2uIpaV0GLUyF++k2E=; b=R/lgm9FRTGWBjJgjNcs/fjOLAL/I+asms
	AEos6HFeeACBb5uDDPRWMsPHXIWAgGFNspwDqD9akvu/cco7tunVzjPbojXwucJo
	ZG2xvgImQ25X4wPVYK8dYmdVlJgy2mYQFXoSDP1ZqYrFBk67Lo6QjTefGTty7JG1
	7JPkXBfHOsrfpdyx1fgVVgfTbb9z/tBmc2LmbE/i2kHNyv37nmxiRY7iA+hZjUDa
	eh276+ms+yxN1OLopvjl9YVm8vXpyjMCxlpfFVAlGQTHtIGbkAtzsXBhv4MzS8Ay
	kiH+wT1cB+FKgnrXaqe1p8uMU9kHcqBXA2uF6O91wRr5T8H+76jaQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8euhbvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:12:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673FuPeF007006;
	Mon, 3 Aug 2026 16:12:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh6466-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:12:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673GCWaw27656456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 16:12:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7A0620040;
	Mon,  3 Aug 2026 16:12:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CC3420043;
	Mon,  3 Aug 2026 16:12:32 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.207.251])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 16:12:32 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v13 10/18] target/s390x: Support AES XTS for cpacf km instruction
Date: Mon,  3 Aug 2026 18:12:27 +0200
Message-ID: <20260803161235.228704-11-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: lDqhIK9RGwiuA70o3vLgZ-esdakBdTq0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfXx8KNAqLlzAiL
 SxMSF8etqz3Etoo4InW2adxdnTMSP+Df1ll6PjaPpwkt6DY0JQ1omBqoVhmKTF4u+svYVAdetQH
 pgI9pNjugHdv+KegRmfEWJVMAPpLfaw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfXzIs/LT6x+ZT/
 LC+bySUcu36EnZ5OpbdkThNcMzCz9NtuUNcwOeJnShjBlfG7tkpWLkBsMiAOY4k8ZfuqsdFcDnl
 Wxew8zjiR4VH8xAB1235N4StKk3V5rhGRkhkvbC0hFbZUZn32beqWTmYGLIoMupGQwHUVYuqWQL
 nVHFWlJOEXu0fTP9UocZ14UScFb/oftXVaW6FRKAfihWKmzByamefUqp4gKRvNtq41ytFRVjBrd
 V6wwDh2PEy5QsCA85VpaklVfQ9SHlmpD03skIJgfVUxjLipe9qieHfTAFaliAtkZ46wlEzDXNcM
 9F3MdewBTXnr0SbaLcZPQaAosETUnmeR00UX/twhQdQMYzQzUndNAKjI/A/7qd7BYtdfQQfh9ur
 GcR4kgEf0uQjrkcsQmeVRIBbVdd2NERGPjqKwmbmedu+uYT1rEh9Ttj7UerPxkqCms/ypoYquty
 prhfeCwuNiJyahs7ygg==
X-Proofpoint-GUID: lDqhIK9RGwiuA70o3vLgZ-esdakBdTq0
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a70bdf5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=NfUx3EYS-SKBlRlFgzgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141

Support the subfunctions XTS-AES-128 and XTS-AES-256
for the cpacf km instruction.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 target/s390x/gen-features.c      |  2 +
 target/s390x/tcg/cpacf.h         |  4 ++
 target/s390x/tcg/cpacf_aes.c     | 81 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |  6 +++
 4 files changed, 93 insertions(+)

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
index cbb6090b44..61ce71476b 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -249,5 +249,9 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint8_t fc, uint8_t mod);
 int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t param_addr, uint8_t fc);
+int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                  uint64_t param_addr, uint64_t *dst_ptr_reg,
+                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                  uint32_t type, uint8_t fc, uint8_t mod);
 
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 1127452f28..0ffb514a84 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -308,3 +308,84 @@ int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
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
+    int i, keysize, addr_reg_size = 64;
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
+    if (!(env->psw.mask & PSW_MASK_64)) {
+        len = (uint32_t)len;
+        addr_reg_size = (env->psw.mask & PSW_MASK_32) ? 32 : 24;
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
index 9f4408f1c5..4fdb0d7c7d 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -104,6 +104,12 @@ static int cpacf_km(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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

