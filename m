Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF1347CC78
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069927; cv=none; b=YVP0MbS/kHGpyVMl3OoN6XdMWiUmbDHmkXxs4glhHCDXv/HicGL7C9xPcejvut7k++QiwHVXSAl80v3qshmwFV1Z51v4tb8krs5D0gsz9lPA1X7siFDhVxY8gOFxdxN6r8bCFsKaVBBgMdxRPLKgq0mijDYzlu6IYqHF0VgLecI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069927; c=relaxed/simple;
	bh=puAT+Y/ipwNgsT9hLwr/v3CzOaXKt3oUW/A4kRWAYaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4PD0aYiXve+LCnZZrB8ry4G4XRkmJNaWTl6cUpszNwi2d+KSJKP0Rpk2X2/AClQ/3zlc6CFXxVqQ9mYUxCsG6F55mCTFFLGizFJ7gFZqzngbMHvmS2OI4v9UseDq1NUaNUmpsvXmo8xFTKCDcFUCtQfPJSV+5+fvrTR8Bm4oXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jt3IWtd7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jt3IWtd7"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3xMV402128;
	Tue, 18 Aug 2026 16:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pT1aOE3yDcNvWAfBL
	Ljhqw3ZCymedbMgQ5l5mbyinXM=; b=jt3IWtd7Eo28+NS6M6wdP92mI6HeFGpuM
	qipTRqDSA28y1VEogmrynQLa58gJZK+Y1jXHMna/rmDIvwBgepKfuCJvUVkFprfY
	2vYu8M8HcguVFxfE7g1HwNB8HnZT3H/B0osBNQQM6RrnD4mXvZtOYd1Uly5kU0RQ
	DodTPzXs3iY36PxDTXzMFsODhhhCxmAS83CJ46HilzqPtzMI8ie4f62T76okks+z
	9BCoA5wbvrt04e3+gl1BCfU804RJIZDIHBH4aakeeGRkvnwtOdIWYVbNJ/LYHApi
	rcScverL2K+Xe6AfUvty8rAFMq6XK5I72WodOVa6/ZKYBs2421HPA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhm1767-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 16:18:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IGBSrB014563;
	Tue, 18 Aug 2026 16:18:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tw48qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 16:18:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IGISHD51052950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 16:18:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 891CD20043;
	Tue, 18 Aug 2026 16:18:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E7C82004D;
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
Subject: [PATCH v15 17/20] target/s390x: Minimal protected key AES XTS support for cpacf pcc instruction
Date: Tue, 18 Aug 2026 18:18:21 +0200
Message-ID: <20260818161824.100746-18-freude@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDExOCBTYWx0ZWRfX7P2Xuw3dYgbH
 XBUJ1zN7RmMPii26ecTbMIxhvBSZ+4xslPqJuuslx5dZATiap8dgvSfIqnJKFP6cT3Jh9pK64SI
 dZFZV03jFVlNcex2D8nxm/Qu2PgCEn3z9NCRV4iy6wADQbdpZysy4MxW3PKuZPECiswS7qoN+a9
 bFwcJ4AT5yNSLV7KemeS7r39XQGHSB8VbnwUXfukexSxrl8SnTqBGAHdm5uEEqBMhOdZDyz9RUa
 95B7zIhaV4+S9+xG6EAYpa1MVcgeBtEsrKZzhttxBULC/7uXhwVU8dwsBf+MR31461p3z4qYahG
 ztA8tcoST6XZLMXiy/PKq0ZndiclwR5DdqLOlL00Hqn3lacvozSrgB+FGZKJpKcC78pUc6oPezt
 aZYNXJ0NIINUkB2fCxKSAQJGlylyy/lUHanIko+vf3EcRGpe5ATjqes8bSXYHm0szZDg2WG6v1u
 Ag3U5ObIomk4LyuTXCw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDExOCBTYWx0ZWRfX2djySKldUGAQ
 2heVKz8Y1+zRCh6sK8UJTVxRA13+4dWZuJc7xP9e9yMFzsVbUn/kFRnCVAW38AqI6kKSSQKYaIR
 0503p8DRqIxpH+0yvEa9y6RTERqWuJo=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a8485d9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=tkYQr5ag8MGam-WK_qUA:9
X-Proofpoint-ORIG-GUID: FhIVFZu8qauYBrxX7Oc3Q4JOIaxgzdPs
X-Proofpoint-GUID: FhIVFZu8qauYBrxX7Oc3Q4JOIaxgzdPs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180118

Support CPACF pcc subfunctions PCC-Compute-XTS-Parameter-Encrypted-AES-128
and PCC-Compute-XTS-Parameter-Encrypted-AES-128 but only for the special
case block sequential number is 0. However, this covers the s390 PAES XTS
implementation in the Linux kernel.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/gen-features.c      |  2 +
 target/s390x/tcg/cpacf.h         |  2 +
 target/s390x/tcg/cpacf_aes.c     | 65 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |  4 ++
 4 files changed, 73 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 9898f880a6..6b206cee83 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -944,6 +944,8 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KMCTR_EAES_256,
     S390_FEAT_PCC_XTS_AES_128,
     S390_FEAT_PCC_XTS_AES_256,
+    S390_FEAT_PCC_XTS_EAES_128,
+    S390_FEAT_PCC_XTS_EAES_256,
     S390_FEAT_PCKMO_AES_128,
     S390_FEAT_PCKMO_AES_192,
     S390_FEAT_PCKMO_AES_256,
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 15fd860e3a..f0c2e7fb6c 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -53,5 +53,7 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                    uint64_t *ctr_ptr_reg, uint32_t type,
                    uint8_t fc, uint8_t mod);
+int cpacf_paes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint8_t fc);
 
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 6208c7f27d..a669016182 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -816,3 +816,68 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return !len ? 0 : 3;
 }
+
+int cpacf_paes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint8_t fc)
+{
+    uint8_t key[32], wkvp[32], tweak[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
+    int keysize, i;
+    AES_KEY exkey;
+
+    switch (fc) {
+    case CPACF_PCC_XTS_PAES_128:
+        keysize = 16;
+        break;
+    case CPACF_PCC_XTS_PAES_256:
+        keysize = 32;
+        break;
+    default:
+        g_assert_not_reached();
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
+    /* fetch block sequence nr from param block into buf */
+    read_guest_wrap_u8(env, mmu_idx, ra,
+                       param_addr + keysize + sizeof(wkvp) + AES_BLOCK_SIZE,
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
+    /* fetch protected key from param block */
+    read_guest_wrap_u8(env, mmu_idx, ra, param_addr, key, keysize);
+    /* decrypt the protected key */
+    decrypt_protkey(key, keysize);
+
+    /* fetch tweak from param block into tweak */
+    read_guest_wrap_u8(env, mmu_idx, ra,
+                       param_addr + keysize + sizeof(wkvp),
+                       tweak, AES_BLOCK_SIZE);
+
+    /* expand key */
+    AES_set_encrypt_key(key, keysize * 8, &exkey);
+
+    /* encrypt tweak */
+    AES_encrypt(tweak, buf, &exkey);
+
+    /* store encrypted tweak into xts parameter field of the param block */
+    write_guest_wrap_u8(env, mmu_idx, ra,
+                        param_addr + keysize + sizeof(wkvp) + 3 * AES_BLOCK_SIZE,
+                        buf, AES_BLOCK_SIZE);
+
+    return 0;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index e9344dbbd9..d0fcdc1e01 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -219,6 +219,10 @@ static int cpacf_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     case CPACF_PCC_XTS_AES_256:
             rc = cpacf_aes_pcc(env, mmu_idx, ra, env->regs[1], fc);
             break;
+    case CPACF_PCC_XTS_PAES_128:
+    case CPACF_PCC_XTS_PAES_256:
+            rc = cpacf_paes_pcc(env, mmu_idx, ra, env->regs[1], fc);
+            break;
     default:
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
-- 
2.43.0

