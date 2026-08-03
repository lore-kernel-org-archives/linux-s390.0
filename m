Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35459375F65
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773569; cv=none; b=QYmOqVSWRYMlWUAQE5UlsA50RjWXGKp1PLv4kTbpGrSFSIcgScECZ77+1tdxZbFzfuSPlbbWwameYM+hIk1AD6nU5PLXnV+0B+CD+kduXm1NelAumBEd4Q2j+4q0kD2ZuHZKHyxgfjPhRU1oWEV0uwFkSW8qUGpO0mr5JFAQmWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773569; c=relaxed/simple;
	bh=yGS4ndD+nDbBm2o6xZ4wKIBZKuYMKeC2jkrmfW0jWK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyPf2Pi1uP20WnVSE0iIULX1jBi6sBoZIt4m7MFfborIHe3KUE6543JyAKEVlGXBFXRF6ykpCQC/rg0a1VHplzdIfZ6wZZOHTVAbDXVoK7hna2Gotp9DIAnmib5y6y3cQNFc7qVMJBySaTQ64yX4VTCbjYcJC3tiBGst3eucwIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HSyqdM0i; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HSyqdM0i"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHoYe2282779;
	Mon, 3 Aug 2026 16:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gVJ5/l9qbSpOyFbwI
	pE11qxzJWNwUiLc0YoLgR2jK1g=; b=HSyqdM0iiuwwHdSJRFxwt96osoJ5sBTfa
	qNBCYLnvt+m3FgOEP1oSmf/cXXj0sgTdTqMX7Kpl3rjBI/9etRaKOY0qa+71caB9
	SxTwqnv43xYro5uzfAUK4nmll8FRh378vBfb46oc2RGCP7mfYYGTvyt+JSXx1jcD
	MEwPW2w8mRUEUXSwCG+e1IM+N3eKWdgMoPcKZGjUj+6TQFaL4D5KF/2bn+8LWIgu
	yy8OikAIwjgGyhlp6W+gb39ely16iApAH6UPq5ggBoCpOpWizflZEYE3uoXdbG7f
	ENyTTRmZiydseLQFFE6ekgP9Fo4TTx0IhCbSn7shlhXOc2FUwUVSw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4sqv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:12:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673GBFbd013151;
	Mon, 3 Aug 2026 16:12:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qeb5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:12:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673GCW0Z32178568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 16:12:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7750720040;
	Mon,  3 Aug 2026 16:12:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E0CF2004B;
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
Subject: [PATCH v13 09/18] target/s390x: Minimal AES XTS support for cpacf pcc instruction
Date: Mon,  3 Aug 2026 18:12:26 +0200
Message-ID: <20260803161235.228704-10-freude@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX2m/7FZ3GS2Y0
 9Isy+OAhkJwVuymupmh8U6oeM4Rr9ZyoiHMdNEib7A+GxOhvg8pJBe1V1TnXiAfw60hGsr84zFq
 oeUyPyYPaXjz2iKr6tu3HJGxD8D1EvM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfXzuVWQafEZddC
 jgSi4wp16oSFqWrT7n3uP5zRDBIrr/Pf/VrcSqzXFCjJAMRgxss4941wdrrhn6tjg0en7f46Fu8
 esDLx7rejihAHsDGy7s/s7w9VlPFwMybbcSqNKxiuTpBVm67fu34CBjgyiNVgqnWj659dwhANQz
 gM/pJSxQ3NlDKIcXXWDPy8GX0ZCm3bNWIsH3ho/l3eSMc3HU9VFh5Pg6CnpASG1B7dHbnS12FQ7
 puaeyezeoLUMFD9UrI75tIPJrRXnn5azBfSK4jyMB2QLF415JUjuJej9vU3LKVVkozgal+Vauji
 ohhevxd4tAJCZHflryQ20qke3by7x9YpojIlepSPD0afaA81DO2Hms9N0cAaz1OrC+ZCzULbOfW
 txbnw5SGJacmnsnA2OPxBJEOSN9P1XqO0tDeuxgAtYMw3hofs8Q8IvUCvQjuU9quwtDgWtFDBHz
 Hd1eufkF+W9X7u2pp4g==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a70bdf5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=WW2E3BMAMqXElFb4OSsA:9
X-Proofpoint-ORIG-GUID: csNIZQpdOZdanx2kRpW-2UtWIGIdZxkQ
X-Proofpoint-GUID: csNIZQpdOZdanx2kRpW-2UtWIGIdZxkQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030141

Support CPACF pcc subfunctions PCC-Compute-XTS-Parameter-AES-128
and PCC-Compute-XTS-Parameter-AES-245 but only for the special
case block sequential number is 0. However, this covers the s390
AES XTS implementation in the Linux kernel and Libica and thus
also Opencryptoki clear key via Libica.

Tested-by: Holger Dengler <dengler@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 target/s390x/gen-features.c      |  2 ++
 target/s390x/tcg/cpacf.h         |  2 ++
 target/s390x/tcg/cpacf_aes.c     | 54 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c | 20 ++++++++++++
 4 files changed, 78 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 3281037958..4132d7b932 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -931,6 +931,8 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KMCTR_AES_128,
     S390_FEAT_KMCTR_AES_192,
     S390_FEAT_KMCTR_AES_256,
+    S390_FEAT_PCC_XTS_AES_128,
+    S390_FEAT_PCC_XTS_AES_256,
 };
 
 /****** END FEATURE DEFS ******/
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 4af7bc753c..cbb6090b44 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -247,5 +247,7 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                   uint64_t *ctr_ptr_reg, uint32_t type,
                   uint8_t fc, uint8_t mod);
+int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                  uint64_t param_addr, uint8_t fc);
 
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index a94c5e74e1..1127452f28 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -254,3 +254,57 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return !len ? 0 : 3;
 }
+
+int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                  uint64_t param_addr, uint8_t fc)
+{
+    uint8_t key[32], tweak[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
+    int keysize, i;
+    AES_KEY exkey;
+
+    switch (fc) {
+    case CPACF_PCC_XTS_AES_128:
+        keysize = 16;
+        break;
+    case CPACF_PCC_XTS_AES_256:
+        keysize = 32;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    /* fetch block sequence nr from param block into buf */
+    read_guest_wrap_u8(env, mmu_idx, ra,
+                       param_addr + keysize + AES_BLOCK_SIZE,
+                       buf, AES_BLOCK_SIZE);
+
+    /* is the block sequence nr 0 ? */
+    for (i = 0; i < AES_BLOCK_SIZE && !buf[i]; i++) {
+            ;
+    }
+    if (i < AES_BLOCK_SIZE) {
+        /* no, sorry handling of non zero block sequence is not implemented */
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        return 1;
+    }
+
+    /* fetch key from param block */
+    read_guest_wrap_u8(env, mmu_idx, ra, param_addr, key, keysize);
+
+    /* fetch tweak from param block into tweak */
+    read_guest_wrap_u8(env, mmu_idx, ra,
+                       param_addr + keysize, tweak, AES_BLOCK_SIZE);
+
+    /* expand key */
+    AES_set_encrypt_key(key, keysize * 8, &exkey);
+
+    /* encrypt tweak */
+    AES_encrypt(tweak, buf, &exkey);
+
+    /* store encrypted tweak into xts parameter field of the param block */
+    write_guest_wrap_u8(env, mmu_idx, ra,
+                        param_addr + keysize + 3 * AES_BLOCK_SIZE,
+                        buf, AES_BLOCK_SIZE);
+
+    return 0;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 7dd6ae4ed4..9f4408f1c5 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -170,6 +170,23 @@ static int cpacf_ppno(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     return rc;
 }
 
+static int cpacf_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                     uint8_t fc)
+{
+    int rc = 0;
+
+    switch (fc) {
+    case CPACF_PCC_XTS_AES_128:
+    case CPACF_PCC_XTS_AES_256:
+            rc = cpacf_aes_pcc(env, mmu_idx, ra, env->regs[1], fc);
+            break;
+    default:
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    return rc;
+}
+
 uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
                      uint32_t type)
 {
@@ -226,6 +243,9 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     case S390_FEAT_TYPE_KMCTR:
         rc = cpacf_kmctr(env, mmu_idx, ra, r1, r2, r3, fc, mod);
         break;
+    case S390_FEAT_TYPE_PCC:
+        rc = cpacf_pcc(env, mmu_idx, ra, fc);
+        break;
     case S390_FEAT_TYPE_PPNO:
         rc = cpacf_ppno(env, mmu_idx, ra, r1, r2, r3, fc);
         break;
-- 
2.43.0

