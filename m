Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E321B356755
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783697367; cv=none; b=QyjVGR9bcSlPqxUVg/9MfNTQIBtgU+Go62qy1x+IsUSR2imgne538Td87RFmW/zDfA4ygAsQz4LkvL1Kt77uSQe//Y/cRGuJnUbe6B0StSDyoSmu7v4ctpAxr5hIHqBPRvKKJZze1NYGOH8t91FPLYkS9WHRsPz0h+WS6BPSdnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783697367; c=relaxed/simple;
	bh=iSgH8Abu8xJG530lQn7/rzqM9UXfoyL05trMLkJEuHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dl3pW2V49eYhyas19h//r2pu+l80jQAEehmgYAY0IJG9ehUiJN5PTdnbSndJce55M+rOWkmwgBooGf0eKNqus7oya0NyA9BEShYkWWzDpYf8yTj4wNtXy/d8I1wuw4IxFbvHpKmY7fcxjTBZd7TzpgxMTmNFmmMn8YgYCDSL9ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IWy+Wm6d; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IWy+Wm6d"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AEmM7q1164399;
	Fri, 10 Jul 2026 15:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IF9TW55XEtxMsH/zI
	q0l47zFW3oV5V4H8owPWhsqZjQ=; b=IWy+Wm6dRCYpAp5cnvPsCoYNet0gmuRCN
	QhrL+tm3o0NNtdB55AKZed25TdVgBToNfXB/hFmlteLasUrhZF7rRFpAbcENtyTe
	UoBCtObCztxfvpNYGHQFePZ+VIBX0WvR9CHEJcLSO+/5NAjjUySfM+GnTaGoAFqo
	M/PuTNFfWnTMFu8qt+WLi3eTVOOJZEQHS59+/DYsJKmj/xCg330wg91ksuzFR7FD
	s6+nQRNaBpgrXuLH8QafuztqW/C26Eje8M1Tu2wKBd/Q7LYx8c7hgygqmHQ7zY/W
	dsmZB87wYWYeJPuDhGx6uaL3aYnFbzU5sqqqujcFn2n5w9nMUbbnQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw57f6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 15:29:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66AFJeaQ015235;
	Fri, 10 Jul 2026 15:29:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6yj8yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 15:29:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66AFT9eg23069364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 15:29:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C5082004B;
	Fri, 10 Jul 2026 15:29:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA69F20043;
	Fri, 10 Jul 2026 15:29:08 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.196.135])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 15:29:08 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v12 08/17] target/s390x: Minimal AES XTS support for cpacf pcc instruction
Date: Fri, 10 Jul 2026 17:28:54 +0200
Message-ID: <20260710152906.80207-9-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710152906.80207-1-freude@linux.ibm.com>
References: <20260710152906.80207-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TrPr0sofbaxLbfvS7rnfCAOt_qgtsIup
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE1MyBTYWx0ZWRfXxr06OYUxpbtS
 onXoDHaieZyYQ7lAnLFJTXZh6ui84GsTg6z1WfznHuvWHoNqY+T1dhQOAEE1CYjXDBu1KXCN8xe
 O0hfkFJbBnaJ7XqbCTUv1xNISebyFhxcfqpWNLu5IH5mNfe5NIb2uTx9WKAicnymDS9md8bVtW9
 5syXnD79Pf/ojZMp4H42fcKll7DbHDJixA8/O7lQxdayBOdkmdNnJS4zAtaoUN9x2mEIf79b5c1
 ZbYlD2qVrIeMaJvm0iHmEzZygYkaw8nn4tvdqp6LHMqpn6w6nuAvaU0AkRfHIhiCcfkzfO0WxiZ
 iWf3g101I0u7xENqeFrS52YuY7ogLym6O16vbyAEazN39fOmDMmd75da4IeAIMBdkY/jsd4NRGD
 e3dw0osrW3Uxdm+mNzgh4tzo16W5vMr0uH7fDK9LYrwCBzlXZRqxs4uOBrVHDh1CGDVMKzWUPYb
 dA43nan7iPoFNMKDKrQ==
X-Proofpoint-ORIG-GUID: TrPr0sofbaxLbfvS7rnfCAOt_qgtsIup
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a510fc9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=WW2E3BMAMqXElFb4OSsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE1MyBTYWx0ZWRfX8SxOgSfRbNsZ
 CqzfYINZflur/kdH8QP8ErpJ53l3UcqgV6r9o7BdNX+9n9VAlN01AU9d16RS/4Apg4q2crkw9P5
 WOu63/GHxz9lDDbdG5AgahJk83qT0Wk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100153

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
index 7deb1a3fd2..e15230d5e3 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -283,3 +283,57 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
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
+    copy_from_guest_wrap(env, mmu_idx, ra,
+                         param_addr + keysize + AES_BLOCK_SIZE,
+                         buf, AES_BLOCK_SIZE);
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
+    copy_from_guest_wrap(env, mmu_idx, ra, param_addr, key, keysize);
+
+    /* fetch tweak from param block into tweak */
+    copy_from_guest_wrap(env, mmu_idx, ra,
+                         param_addr + keysize, tweak, AES_BLOCK_SIZE);
+
+    /* expand key */
+    AES_set_encrypt_key(key, keysize * 8, &exkey);
+
+    /* encrypt tweak */
+    AES_encrypt(tweak, buf, &exkey);
+
+    /* store encrypted tweak into xts parameter field of the param block */
+    copy_to_guest_wrap(env, mmu_idx, ra,
+                       param_addr + keysize + 3 * AES_BLOCK_SIZE,
+                       buf, AES_BLOCK_SIZE);
+
+    return 0;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 9be8a14a80..1d447cef30 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -169,6 +169,23 @@ static int cpacf_ppno(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
@@ -225,6 +242,9 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
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

