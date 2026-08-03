Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CED31E828
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773577; cv=none; b=B+7d2SJeTvcpW++B4bxM8nIglu3AXbFhudtJLdEbY3aHiZxp4wkVVOXcntxR3cfD7i9oKNbdz3KFNveHQuGX8ciDK8FRzNVaeRPpyWf+whLwe7Yuq+jSmKZneSStaA+lPYhmqgE2rI1SrhC+4Sl+Odw7W3b29r/OroJY8TlwQII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773577; c=relaxed/simple;
	bh=fU4S2JgR7L/BcvacwEOT0Tpzq07vq2tEjuAuqlDEz4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CfnszotbZcClJFEad0UtNXGvDUhfQ81YxYMXwxTwrBe6lZyKu4SzguQe9wC18ds0RxW2bttOotRO23W7HpXSDht1Nns0N3N2J8Q78DF2E21nmFQs22cr+MfGnsUgathxHAFIMCdn0npCVy64QtpHTnaGVs2OjpHdu9G+It6P3d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HHEBYX7T; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HHEBYX7T"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EI0G02341761;
	Mon, 3 Aug 2026 16:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BG+Tv8UfDnUQ7yFcw
	dJGpeL0oUU6GyvvrnQJ8tPooIk=; b=HHEBYX7TTyLD2oVmxbysvv8iCYlGNk4SL
	qK/lru8om5AJ6Z7DEiNqvU1dE2Stqnx6xL7WVSsOCgDQhnD+Qj4zxfqjOg27FEH9
	5E4AAk+X5C9AfySNB7VHegoqp1OI+NU6qXsTbmUydtnKUDxP72gLfE/H6vTrYjLb
	FjMfqts/1gaPJmn246a4oCL7uwwa53zy98a3cwEE85RHmQsT3G53sGojCu+W5cEa
	09c0DOE8XNdRurmmozgHaIHTxVxab7JcRpogg0a0tLBtIb9NjuU0jp7ne8xU0rYH
	1D6Jsfjxxgk9F3LTB8pDhRUOQNziUiLV7z5G3gAbFSGG5lv6BMVBg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8euhbve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:12:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673GBGG5011978;
	Mon, 3 Aug 2026 16:12:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4jx6ak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:12:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673GCXTK8782100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 16:12:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D3E920040;
	Mon,  3 Aug 2026 16:12:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2393F2004D;
	Mon,  3 Aug 2026 16:12:33 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.207.251])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 16:12:33 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v13 13/18] target/s390x: Support protected key AES CBC for cpacf kmc instruction
Date: Mon,  3 Aug 2026 18:12:30 +0200
Message-ID: <20260803161235.228704-14-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: nBsKc0b6pJmFIoN65ERHcbb7B4YDhWPa
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX0TwA+Mu6+O2o
 kRyZbBrI7LbvbUi5mKvejU+o8xSZ7z698G4y5l6yTpRfS8faAzzGoLn11H8U2IUiGZk2Nk1LRXB
 KcZ2WDQr73E47BYz5edJwPveCA6TMbo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX07uSFfiW6uwY
 15VC82j/sLs2pyE9vu1bNp0UGJUVem9qWaIcUB/XhLL2fdAatTk6mn667hHssUkqc6PR1OHjLIi
 djO7ngGNcavqj3qvq+Nyk19CVHk9yzRf+O3OyY6nj15Ly/fi9rFxOQudsqyAM0mUODY8y9n7w+y
 aN65qwuYRN1pYhUBgeZlYhPc1UOO6Wlf7JxF8dm/map5LV4L4KfmGta2fh1p3YFwVYNb4k9qX9z
 YcGx4RvJFdsnf8rpgh82/cgViR3n+1BD5RakpGs1uTpWA4WzUuXqsgljt4QH7KFYP2I1bp9xfot
 DTyPgAFT5EoAjBmZpqDJTlTas4FXcrWIofhQQberE2QJuh41I7TwlCnUzRcLcdps4B8Y96dZ4+V
 rj7oqYsqieGx7dyMUORWnZSvD7ol3o+JAUq8uwgn9PqXwSfG+peuSux+Jch5hhZOSR9+SPLO1uW
 L2Phbyz5SBxPYmjA/Tg==
X-Proofpoint-GUID: nBsKc0b6pJmFIoN65ERHcbb7B4YDhWPa
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a70bdf6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=8AYr_lYigW3ys9mEaM0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141

Support the subfunctions CPACF_KMC_PAES_128, CPACF_KMC_PAES_192
and CPACF_KMC_PAES_256 for the cpacf kmc instruction.

Tested-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/gen-features.c      |  3 ++
 target/s390x/tcg/cpacf.h         |  4 ++
 target/s390x/tcg/cpacf_aes.c     | 90 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |  7 +++
 4 files changed, 104 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 17de37f183..d1fce9e00c 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -933,6 +933,9 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KMC_AES_128,
     S390_FEAT_KMC_AES_192,
     S390_FEAT_KMC_AES_256,
+    S390_FEAT_KMC_EAES_128,
+    S390_FEAT_KMC_EAES_192,
+    S390_FEAT_KMC_EAES_256,
     S390_FEAT_KMCTR_AES_128,
     S390_FEAT_KMCTR_AES_192,
     S390_FEAT_KMCTR_AES_256,
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 9820ec293b..8987f8fbc7 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -286,5 +286,9 @@ int cpacf_paes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint64_t param_addr, uint64_t *dst_ptr_reg,
                    uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                    uint32_t type, uint8_t fc, uint8_t mod);
+int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint64_t *dst_ptr_reg,
+                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                   uint32_t type, uint8_t fc, uint8_t mod);
 
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index a6d3efb383..7373609ced 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -544,3 +544,93 @@ int cpacf_paes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return !len ? 0 : 3;
 }
+
+int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint64_t *dst_ptr_reg,
+                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                   uint32_t type, uint8_t fc, uint8_t mod)
+{
+    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
+    uint8_t key[32], wkvp[32], iv[AES_BLOCK_SIZE];
+    uint64_t len = *src_len_reg, done = 0;
+    int i, keysize, addr_reg_size = 64;
+    AES_KEY exkey;
+
+    g_assert(type == S390_FEAT_TYPE_KMC);
+
+    switch (fc) {
+    case CPACF_KMC_PAES_128:
+        keysize = 16;
+        break;
+    case CPACF_KMC_PAES_192:
+        keysize = 24;
+        break;
+    case CPACF_KMC_PAES_256:
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
+    /* fetch and check wkvp from param block */
+    read_guest_wrap_u8(env, mmu_idx, ra,
+                       param_addr + AES_BLOCK_SIZE + keysize,
+                       wkvp, sizeof(wkvp));
+    if (memcmp(wkvp, protkey_wkvp, sizeof(wkvp))) {
+        /* wkvp mismatch -> return with cc 1 */
+        return 1;
+    }
+
+    /* fetch iv from param block */
+    read_guest_wrap_u8(env, mmu_idx, ra, param_addr, iv, AES_BLOCK_SIZE);
+
+    /* fetch protected key from param block */
+    read_guest_wrap_u8(env, mmu_idx, ra,
+                       param_addr + AES_BLOCK_SIZE, key, keysize);
+    /* decrypt the protected key */
+    decrypt_protkey(key, keysize);
+
+    /* expand key */
+    if (mod) {
+        AES_set_decrypt_key(key, keysize * 8, &exkey);
+    } else {
+        AES_set_encrypt_key(key, keysize * 8, &exkey);
+    }
+
+    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
+    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
+        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
+        if (mod) {
+            /* decrypt in => out */
+            AES_cbc_decrypt(in, out, iv, &exkey);
+        } else {
+            /* encrypt in => out */
+            AES_cbc_encrypt(in, out, iv, &exkey);
+        }
+        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
+        len -= AES_BLOCK_SIZE;
+        done += AES_BLOCK_SIZE;
+    }
+
+    /* update iv in param block */
+    write_guest_wrap_u8(env, mmu_idx, ra, param_addr, iv, AES_BLOCK_SIZE);
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
index b4e9407d60..3c6dd74c70 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -138,6 +138,13 @@ static int cpacf_kmc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
                            S390_FEAT_TYPE_KMC, fc, mod);
         break;
+    case CPACF_KMC_PAES_128:
+    case CPACF_KMC_PAES_192:
+    case CPACF_KMC_PAES_256:
+        rc = cpacf_paes_cbc(env, mmu_idx, ra, env->regs[1],
+                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
+                            S390_FEAT_TYPE_KMC, fc, mod);
+        break;
     default:
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
-- 
2.43.0

