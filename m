Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39EE3A7F47
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 08:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560346; cv=none; b=WOnXOLN9kL8BHWuBVYwJVzwh1KPv+Cf6bwIuatwSQbzO32UJVCxLbGBMyA76PHfHCHGmAEYsY1oc32T/zvL7jt5k+ae/XsXsr+3ARb1D1rH96muLz20vfHPdb2gWogNFmBHv4axCkayP3t3StZZ8OnE6nkWQZf3I+IUL7BaBYfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560346; c=relaxed/simple;
	bh=PWGTMlXhBUsV5o8X41NWlB0F2s5uOfDe7vB1Je10opQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKyOVVX5lyAOKdawRAK1fDNEyGXw/cOME9O8oijPY537k3cRIiaGtNv8edjZgCsdJ5PoI0+zjtWlmhVPPInpMDI9LHxDJ4DciTft6b2GjKFptclhTU61eylQNEABiPmOOzNvBLtZIlFv5VfmLGCTWtWQQQPZi72DXxTxr/wSnN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C1++YBah; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C1++YBah"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5VisT4031778;
	Mon, 24 Aug 2026 08:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=j7aCbmIMnGUXHChIl
	CJg6F3UFLN1Owq+je4ZoIbjqJs=; b=C1++YBahWeMxDdutVql2oEkDhfpjso36b
	N1lpUIYaXFvUS1NXsDbPznVxrSrp6mqadgJ2nLy8tdguXQ8X0HXN/9Iz1WV0lN6T
	AYvskCc/bauGBPq8sz97jezi7yj/HQO3r+9eBDvg6VrZFo+j+vxmuri4yoqrjGhK
	gRYeL4YkZe+hz3jw1Ta663WMol2QwLRyNQpR9bf2VEDEony/+CZ6nCl/t5Vx9TUy
	ezC9nOfcb9Zb6PnRNZ9OBmRROvwTHTg3cnUhRT49WUIKly1uTEsKwifCtnNsx0st
	lTV5WDc9D9z8zZk0ZIxCs0xMXcuzKK+sFIUMt5NgYWMqUqGEPSeUg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726e84p2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 08:32:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O8QHhU014770;
	Mon, 24 Aug 2026 08:32:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3pvyvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 08:32:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67O8W7sO41943522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 08:32:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81D7920040;
	Mon, 24 Aug 2026 08:32:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 579992004D;
	Mon, 24 Aug 2026 08:32:07 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.131.174])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 08:32:07 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v16 09/20] target/s390x: Support AES CBC for cpacf kmc instruction
Date: Mon, 24 Aug 2026 10:31:53 +0200
Message-ID: <20260824083204.40877-10-freude@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8c018c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=4s_zGP7M7QCs5o7xjogA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3NCBTYWx0ZWRfX4yCR3h3Fr20I
 QajtU4lswEIkzFOZXT8OwfE5/BMIXaLWZ3z9BKVCotVgcnCD68Umq15Sqhg8yun4Y3JAKoqMSf7
 FdPgi+PCtk6aQTHMZYlOzYJcWm+fhC4=
X-Proofpoint-GUID: PFb-p_5Vf1PhSVnmdA0JmjIKwxmSbAyV
X-Proofpoint-ORIG-GUID: PFb-p_5Vf1PhSVnmdA0JmjIKwxmSbAyV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3NCBTYWx0ZWRfX7059IHE8HUcX
 5qVDSufZbbpsLi0Mete1FU3XA76Ao+Cluag/IR6l5WKAQXyr3Y7z9JcK0ngTBVhLPs3stfU9rXq
 Sh+ktGSXROkz87wO2+xCHiFKHLbzwwzruNx9FvShNKutrABVkW7BgBPI97sauyu3NiHwH9ka9bv
 br5XHWL0qAux5mX3aXNKrSY1pNOaOCnurKGerlKxpIW43vDhY1BiJPiKKR4POMhPLBhQ1cg+rCf
 vT6tyhEwYz4HCdU0q5MZ2ST1MhKZv0T0f956FU7DcSVHx3gLMb97XSQ9JCYHU/eRzOH+wS1JVPv
 V8HAkA7TBQmaNwSVESqypXTiR3IlVnZNpjEqpVX0R7A+MYzZXWLilXJv/iU+zik8tSOnuOZ/FUw
 5DV8KnnZPmD0j+N+AxVgMqzArmm39ZVdKtLkZq2oQhqZ17cE3lWWcu3dFoFLTn5gDVt0YtBafj7
 gUThVg+AMmgRTd/JFCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240074

Support the subfunctions CPACF_KMC_AES_128, CPACF_KMC_AES_192
and CPACF_KMC_AES_256 for the cpacf kmc instruction.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/gen-features.c      |  3 ++
 target/s390x/tcg/cpacf.h         |  4 ++
 target/s390x/tcg/cpacf_aes.c     | 91 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c | 24 +++++++++
 4 files changed, 122 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index c8ba5107d7..2dacc65995 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -925,6 +925,9 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KM_AES_128,
     S390_FEAT_KM_AES_192,
     S390_FEAT_KM_AES_256,
+    S390_FEAT_KMC_AES_128,
+    S390_FEAT_KMC_AES_192,
+    S390_FEAT_KMC_AES_256,
 };
 
 /****** END FEATURE DEFS ******/
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 49630bab5e..7dde122879 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -23,5 +23,9 @@ int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t param_addr, uint64_t *dst_ptr_reg,
                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                   uint32_t type, uint8_t fc, uint8_t mod);
+int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                  uint64_t param_addr, uint64_t *dst_ptr_reg,
+                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                  uint32_t type, uint8_t fc, uint8_t mod);
 
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index d87da18c19..c937514e9b 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -135,3 +135,94 @@ int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return !len ? 0 : 3;
 }
+
+int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                  uint64_t param_addr, uint64_t *dst_ptr_reg,
+                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                  uint32_t type, uint8_t fc, uint8_t mod)
+{
+    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
+    uint64_t len = *src_len_reg, done = 0;
+    uint8_t key[32], iv[AES_BLOCK_SIZE];
+    int i, keysize, addr_reg_size;
+    AES_KEY exkey;
+
+    g_assert(type == S390_FEAT_TYPE_KMC);
+
+    switch (fc) {
+    case CPACF_KMC_AES_128:
+        keysize = 16;
+        break;
+    case CPACF_KMC_AES_192:
+        keysize = 24;
+        break;
+    case CPACF_KMC_AES_256:
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
+        return 0;
+    }
+
+    /* length has to be properly aligned. */
+    if (!QEMU_IS_ALIGNED(len, AES_BLOCK_SIZE)) {
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    /* fetch iv from param block */
+    read_guest_wrap_u8(env, mmu_idx, ra, param_addr, iv, AES_BLOCK_SIZE);
+
+    /* fetch key from param block */
+    read_guest_wrap_u8(env, mmu_idx, ra,
+                       param_addr + AES_BLOCK_SIZE, key, keysize);
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
index 534498173c..7368c25e5d 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -119,6 +119,27 @@ static int cpacf_km(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     return rc;
 }
 
+static int cpacf_kmc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                     uint32_t r1, uint32_t r2, uint32_t r3,
+                     uint8_t fc, uint8_t mod)
+{
+    int rc = 0;
+
+    switch (fc) {
+    case CPACF_KMC_AES_128:
+    case CPACF_KMC_AES_192:
+    case CPACF_KMC_AES_256:
+        rc = cpacf_aes_cbc(env, mmu_idx, ra, env->regs[1],
+                           &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
+                           S390_FEAT_TYPE_KMC, fc, mod);
+        break;
+    default:
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    return rc;
+}
+
 static int cpacf_ppno(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                       uint32_t r1, uint32_t r2, uint32_t r3, uint8_t fc)
 {
@@ -190,6 +211,9 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     case S390_FEAT_TYPE_KM:
         rc = cpacf_km(env, mmu_idx, ra, r1, r2, r3, fc, mod);
         break;
+    case S390_FEAT_TYPE_KMC:
+        rc = cpacf_kmc(env, mmu_idx, ra, r1, r2, r3, fc, mod);
+        break;
     case S390_FEAT_TYPE_PPNO:
         rc = cpacf_ppno(env, mmu_idx, ra, r1, r2, r3, fc);
         break;
-- 
2.43.0

