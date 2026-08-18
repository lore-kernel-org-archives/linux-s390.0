Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F263B6C17
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069928; cv=none; b=KxxodORQR+UY31a1BDMrQhVMAbXn3+p9efufjnveoBYf1XR/z6+vAr8iHkfno1/XffNoMzdo7WFchJej9DfzrLZ7o+MXXxJOt+jJxRnTNmD15Eccu26OF0jwkmvlizSucDMb5BObwsjW68bd2Sq+88ym8jGKJxGAvqLTeqaJuBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069928; c=relaxed/simple;
	bh=c7bwC6UcpvR8skuZqEOBzav4i7ku9HK32M2ZsS0QG3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyt1ufoB1lJGpLgqCq5+jTfOAW06bShAGQF1p5b2fShfbfE8agiQdk1AGWZBHC4k50mVhWMMP3O9aYKtEGSMgbrNNZDk7e9KiV7WkV2JLh/Ysoe+TvUsSgacpyfU6Ntc62+yGyYndO/rDJbb+m88BMg4MDkE3LanJxV+894eKsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WxyndcGR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WxyndcGR"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3oM6401813;
	Tue, 18 Aug 2026 16:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1VsCXdVwGDDYgn+cx
	j4SnhBVigXoVk0PnrhrFhH1hDs=; b=WxyndcGRuBwO+zd9AweKYByOn4vgLmOF2
	1y3NRSiVLMfuOoVrM3o5kS7DYjT6AuNuTbz3ljh90T/bJ7+06pzPe7vHzt5Cxu7E
	hwD9zKi72n81NSRj2wdBJ4/N/gw7goRnwt7G1BY9AV4v5oZ5qALN3n9s6otHjMRw
	KaMnbiCdDBiFFB5btM/kH+RiPIPdusi9+VLSz9d2CfwCivyp9b4d1amp6cZW1oUS
	5ckTLiAuAuBH134s4oVvJF/CSHnyyAm2N8VA27zjbpQLOsyiziz20thuR7z/I7lt
	mMscp7u70VxRssRgB5S7a6XDRkWf3V8zy1Lk6xUz0nss3J0SBHqtg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhm1762-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 16:18:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IGBL1J002196;
	Tue, 18 Aug 2026 16:18:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ek455j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 16:18:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IGIRmH43516306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 16:18:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F41120043;
	Tue, 18 Aug 2026 16:18:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24D892004E;
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
Subject: [PATCH v15 11/20] target/s390x: Minimal AES XTS support for cpacf pcc instruction
Date: Tue, 18 Aug 2026 18:18:15 +0200
Message-ID: <20260818161824.100746-12-freude@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDExOCBTYWx0ZWRfX+R6sqikNz9Wa
 5ISsZ4kXXDcBTxzcVVqF7hazIn7rJxoJmEjZM4aUlYyU2NAGwWCcFXRAcBhub4J5eeZVkTadp3I
 LsRwOoD6T0uGuuBHGS56xpGZ3X+xRL3j0jt3hEULQi0QNcpvjTDmKV0oNYsLyCf8AlJ3nbRosa6
 aMj0K7IcYhp1oLJrQVMDSCQLjxo8MU8Ma02X+W63c0Qoe1+gIX+XEqPpVPezsn8EYOmlRh8DSn+
 h5SozAABOuNTVvQPlbb8fjeQ/rGg9b3yjgbsOL4pW0GT9NTg2UF/FwsbRBDHY042EsesSN4mmSW
 1Osqq4TIhGSvrwhb4SGbD7l2BX+e3BO33sYzL5K8Y61zbUFMlKhZOVsUQYuCA3hwIkbDs7dZ79O
 rkMTYwGmhRfm+kCooDNyfs61bsq66FT+RpmZ4Ru9n3QkjFRjwDr54BFibXpOKeCt9r52efolaJL
 lx6UOpYbjyBoSl76vag==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDExOCBTYWx0ZWRfX48IyEHZQVlWd
 Ofg5jllq1ZVGzEAF+eIRWauX2p1JQcaE/Y3ThYPFpsxYdSKf+fLuGXVh0xmT3Rns8yGC1TW7gBa
 8pCgi3IUpYCQ3G+x0VdnQKpTLclKGwY=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a8485d8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=ZK1dOEz8ZbUWtWENyc4A:9
X-Proofpoint-ORIG-GUID: 5w0ZeJr5EMJg7r25ArDoifgjzYHuJEED
X-Proofpoint-GUID: 5w0ZeJr5EMJg7r25ArDoifgjzYHuJEED
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180118

Support CPACF pcc subfunctions PCC-Compute-XTS-Parameter-AES-128
and PCC-Compute-XTS-Parameter-AES-245 but only for the special
case block sequential number is 0. However, this covers the s390
AES XTS implementation in the Linux kernel and Libica and thus
also Opencryptoki clear key via Libica.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
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
index a78ddc2821..4a20aeacde 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -32,5 +32,7 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                   uint64_t *ctr_ptr_reg, uint32_t type,
                   uint8_t fc, uint8_t mod);
+int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                  uint64_t param_addr, uint8_t fc);
 
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 88a2a84c66..b9e6d3d332 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -308,3 +308,57 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
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
index 3135974234..affaaede52 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -182,6 +182,23 @@ static int cpacf_ppno(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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
@@ -238,6 +255,9 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
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

