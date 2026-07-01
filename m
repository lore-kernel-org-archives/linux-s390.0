Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392EE37998B
	for <linux-s390@vger.kernel.org>; Wed,  1 Jul 2026 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924454; cv=none; b=cCIDWNm+KVbeMGRiucbrxrRb6VqRQYuuuTtHiZFG6s1b384c+tffI5UtR1xTHNI5EyG1DQvnva+FNSjerjr1N7sSboVpXH1TaoA/c1bHZ7Whtfe+4jHMwcp1/fDOL8TgHcMR9WQyQUAftcPuICJnZrC99DDdoMnPsl6/uTGywgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924454; c=relaxed/simple;
	bh=6uCjxZ5DpZnZGrZ6G2+BSuws5E8WGat2eWavrPAnLA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cil/srmGmRgnsN6P3gne4mHqI+IqlFj747+IMt98aC/8Rm4QnEji0yapOpZsYMH6TY5fna/+GXvC9q+v+Zb9qSqTZACDRYVUMzqA0uabQGGB9D1pWQAms3BR0CibLU77WwMWyJ9jei5OP9pmCJJpsJgDsjqhFB9oVDT65181RVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Abe26h4q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Abe26h4q"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661AINlU494384;
	Wed, 1 Jul 2026 16:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5ZDJn3v5xKdDEk2In
	qnnkkZDLDWxYfvl5nccwPf70rU=; b=Abe26h4qU9EA3h+AqsmXa20iQJb78j8fL
	spx4W/3dEZdsn2QROYZysanWtAf83e5CXDN6nLcNam5F4vrbgoXLeUzySfubX3e/
	N5zTcGEiBOndxujvKqPEI+pzmrNxWObl8e5Nlo0uHNHSPH6kOIQwMbHlcGSeaOUq
	UZA2KdkKk+zpO/Jz9LQoKDKxB7jHpEUudtcf2HAnV94To2tnCTUjCxgOWAz610hT
	NKfRt/eHFuIGSImJhPfFWFwQzHs8OqlxEHf6VytxzrV6pK58USjRyTx37ZPGv1kI
	E1EGWDVxMvz6wG6Bo17jbUhYs87WWHQgz7t5GvqvyJ0BCW1ja2U9Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rf56f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 16:46:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661GYaBd024337;
	Wed, 1 Jul 2026 16:46:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyfxf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 16:46:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 661Gkttk50004472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 16:46:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F401520040;
	Wed,  1 Jul 2026 16:46:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C98622004D;
	Wed,  1 Jul 2026 16:46:54 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.187.249])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 16:46:54 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v9 15/21] target/s390x: Minimal protected key AES XTS support for cpacf pcc instruction
Date: Wed,  1 Jul 2026 18:46:38 +0200
Message-ID: <20260701164650.95760-16-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701164650.95760-1-freude@linux.ibm.com>
References: <20260701164650.95760-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a454483 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=EmLOupEv2CnJZljdqbQA:9
X-Proofpoint-ORIG-GUID: mZudWNn3d-fWWN9kX3pqCVS0qE5bk_dT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE3MyBTYWx0ZWRfX3vS35lWYeFe/
 Vauef3+l8Ol8JEU5XVGmqDMrMU0zBjfOVn6cYf8lVxcPm9xeAMDXWr7RzXyFlnq72XSN96Ko4hf
 Jm+o9eqWroXCXiQFwgeLxGt3Xt8JGVUyqOb3mg1WmMJEeE+E8smEPgRHoZGqhb2V6GAB0P1CTb5
 H8GxdSASJkH7xqRWl67zTrVAoguK61JvwUK/io24657WHhYAUgVxygrSAB7GT20afkTQzQII5ib
 Uk7nCoZKM1id2C/MkV/+CBWXdIzUgKyvVzsMPlr9y6p268NXGfIKoWRDD2QRuP1v55vpFMndBYF
 RDmhludE1POkJnHvKNu32eiXNDAp7Jc5ceTSqt2czNRtOLGiAzUOIy69oXXbwrw1tAboiWQTAyQ
 ksAz3hRcF0MRf0sXJjCZOaAGPxxDwtZ7pq8of+Wdhu2yjwHFwYqmvV0J9Hier1WwJMpLpqw9Z8q
 6Ub1Z+xX06w0Ra8AUaA==
X-Proofpoint-GUID: mZudWNn3d-fWWN9kX3pqCVS0qE5bk_dT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE3MyBTYWx0ZWRfXzKYE+ahQkHeY
 zqjWJojkRre6EVFLnSxxNOMaY+o5Tf+p+DPfHBuMIyLyCs+t61qfcOS9ssX9TP/Mth3YSxGqz2f
 8f5Dt1u9+n3YA10xlfgC20hu6Ai/hJw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010173

Support CPACF pcc subfunctions PCC-Compute-XTS-Parameter-Encrypted-AES-128
and PCC-Compute-XTS-Parameter-Encrypted-AES-128 but only for the special
case block sequential number is 0. However, this covers the s390 PAES XTS
implementation in the Linux kernel.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
---
 target/s390x/gen-features.c      |  2 +
 target/s390x/tcg/cpacf.h         |  2 +
 target/s390x/tcg/cpacf_aes.c     | 77 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |  4 ++
 4 files changed, 85 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 4a131dc191..126bacb281 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -943,6 +943,8 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KMCTR_EAES_256,
     S390_FEAT_PCC_XTS_AES_128,
     S390_FEAT_PCC_XTS_AES_256,
+    S390_FEAT_PCC_XTS_EAES_128,
+    S390_FEAT_PCC_XTS_EAES_256,
     S390_FEAT_PCKMO_AES_128,
     S390_FEAT_PCKMO_AES_192,
     S390_FEAT_PCKMO_AES_256,
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 6071f21fb6..9dc197388e 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -295,5 +295,7 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                    uint64_t *ctr_ptr_reg, uint32_t type,
                    uint8_t fc, uint8_t mod);
+int cpacf_paes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint8_t fc);
 
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index c52df6510f..df4cd7ae70 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -828,3 +828,80 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return !len ? 0 : 3;
 }
+
+int cpacf_paes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint8_t fc)
+{
+    uint8_t key[32], wkvp[32], tweak[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
+    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
+    int keysize, i;
+    uint64_t addr;
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
+    for (i = 0; i < sizeof(wkvp); i++) {
+        addr = wrap_address(env, param_addr + keysize + i);
+        wkvp[i] = cpu_ldb_mmu(env, addr, oi, ra);
+    }
+    if (memcmp(wkvp, protkey_wkvp, sizeof(wkvp))) {
+        /* wkvp mismatch -> return with cc 1 */
+        return 1;
+    }
+
+    /* fetch block sequence nr from param block into buf */
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        addr = wrap_address(env, param_addr + keysize +
+                            sizeof(wkvp) + AES_BLOCK_SIZE + i);
+        buf[i] = cpu_ldb_mmu(env, addr, oi, ra);
+    }
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
+    for (i = 0; i < keysize; i++) {
+        addr = wrap_address(env, param_addr + i);
+        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
+    }
+    /* decrypt the protected key */
+    decrypt_protkey(key, keysize);
+
+    /* fetch tweak from param block into tweak */
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        addr = wrap_address(env, param_addr + keysize + sizeof(wkvp) + i);
+        tweak[i] = cpu_ldb_mmu(env, addr, oi, ra);
+    }
+
+    /* expand key */
+    AES_set_encrypt_key(key, keysize * 8, &exkey);
+
+    /* encrypt tweak */
+    AES_encrypt(tweak, buf, &exkey);
+
+    /* store encrypted tweak into xts parameter field of the param block */
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        addr = wrap_address(env, param_addr + keysize +
+                            sizeof(wkvp) + 3 * AES_BLOCK_SIZE + i);
+        cpu_stb_mmu(env, addr, buf[i], oi, ra);
+    }
+
+    return 0;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 73b2a6557c..5e924b78f5 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -206,6 +206,10 @@ static int cpacf_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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

