Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A493624D7
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 08:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782288648; cv=none; b=eBoC1+O+G4Oae5gtKSfgZWXK2Hk9O+QA6BztqHd6qotvzRFocVupmG7WvoWE/jLlYtofictTR8SM9OJd/0Os+9Br2wzSAKqwcjhOXk7ASwC08DSKhGqfVL4zHYL1SxVQTbpA952bKAyleF6ukjwtUzHG9pM9HR9fXIIbQF3G0UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782288648; c=relaxed/simple;
	bh=c0YCvnjK+jK5GNQRWhViFghfO1sSJHy0BDu8Xvbo5AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NlaUuOgAqp1L0gQMH9laZs4BFORSUVxt9f2skE6QuDoU3qdDMAypUysD+nRatnJILzqDYinNvr3LAgL2TL2gEy2Zvk30L22Wm+cCPpGf8yiUXLgKjQhVpxKT2uZ8JmmjH6lMiJz9ipBRIqbyYLVfiNLflgnp6fk+GaL3Yv+KPIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kl39B7ko; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kl39B7ko"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O6Ismp4170197;
	Wed, 24 Jun 2026 08:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=x+usC8vG6LcAKUiWf
	AbYFBSzCRCg6L8ssb/eALehI1U=; b=Kl39B7kojX+N2qEK2lnSQW8v0kQP+R738
	sZ/bLC7EuSVd+T6PftuQOW2ly/fLUNgiE1tKOacElSZqCHXXJ0wxwernwqqevYHB
	+FRsg4KxUhA/H+TytaFyYdASs7l2Vdsyyj9JLfjZIHLVDKJdUgbiu0k6CH+HIAbY
	JhK5QjgDKhcfe6ltyVgagoQZFVx1UFKyYgmRystqYYXb8v+pE+tFYIM30mjDUnwi
	Q7oxSWDMnn3zfBMR8UrZ1HVo0oGPRLTcL7GNwxbxXIObAnZvdIMyJPbEeTJ3RZp5
	CwIRjYN0OSe2jpo5OXxAbMxAaOyxZVhGWh42ftXugzwV7YbG/Ivcg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gjx8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:10:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65O84iO1026389;
	Wed, 24 Jun 2026 08:10:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dg7bu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:10:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65O8AWlm49676640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 08:10:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD38C20040;
	Wed, 24 Jun 2026 08:10:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87C782004D;
	Wed, 24 Jun 2026 08:10:32 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.224.92.54])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 08:10:32 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v8 08/18] target/s390x: Minimal AES XTS support for cpacf pcc instruction
Date: Wed, 24 Jun 2026 10:10:05 +0200
Message-ID: <20260624081029.23815-9-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624081029.23815-1-freude@linux.ibm.com>
References: <20260624081029.23815-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kctOEyvQTA440jKyZqWzcaffFb3blYiv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfX15qypyBlwl3Y
 9FYsdKb957Rj8lRpq/jBfWuPfy61TXnOjxIOtdKP67L2/PDGhpmIk3JyWHlaJKtBiJlkf32r3Zk
 6HYb/iphqCVRkyMbFGeZeuSA8eqLBgY=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3b90fd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=gr50lgQh3SlUKNVXMSoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfX8NFixf5vWGNU
 lRdoD9K/bkxnx5yksZpzgmgo34UarxQ2N/YZ2Ec/DfAWVKezEd+Wqee1d1lKrh2tFb28M8SoqQ3
 +SEaE812G+6ZwjY7mEGnxltyl6qy8ujQbiiAtp2kjS487jiCYFv7kCQxkkAxxnueLft2g7wcNZW
 p5w7RR4GAviywo1g0fmvXAC2bbjAD3ZDRhtX+LOp0a85xuV6IUame/wI6xesHU8tTjbHRNSX1E5
 c79uEQ1KjoEE2oF0/K0EkL7t4z27Riy/jk0NTCRLltIHosj9/Jc5KqKpSTl+jjlKeYYPeyhF2Iv
 PcT9tdrB4u8kX1t/jAtA2rkyH0fqbJqXClD+t0uT+lPF3fJZawP0fPDShoJcE6hLAg8ABDUnO4W
 PW6ecYNoQgnltaI6pZLja9hs+oY1bC0dNClya7UHoUb2z96USPkSFxseZCGVcxcSGl4XKAOC2fd
 x0S80kwciHMye2ooIEA==
X-Proofpoint-ORIG-GUID: kctOEyvQTA440jKyZqWzcaffFb3blYiv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240063

Support CPACF pcc subfunctions PCC-Compute-XTS-Parameter-AES-128
and PCC-Compute-XTS-Parameter-AES-128 but only for the special
case block sequential number is 0. However, this covers the s390
AES XTS implementation in the Linux kernel and Libica and thus
also Opencryptoki clear key via Libica.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
---
 target/s390x/gen-features.c      |  2 +
 target/s390x/tcg/cpacf.h         |  2 +
 target/s390x/tcg/cpacf_aes.c     | 63 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c | 20 ++++++++++
 4 files changed, 87 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 59c2a47539..1b6a874b90 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -930,6 +930,8 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KMCTR_AES_128,
     S390_FEAT_KMCTR_AES_192,
     S390_FEAT_KMCTR_AES_256,
+    S390_FEAT_PCC_XTS_AES_128,
+    S390_FEAT_PCC_XTS_AES_256,
 };
 
 /****** END FEATURE DEFS ******/
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 86fd5bffc2..004be6ee57 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -35,5 +35,7 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                   uint64_t *ctr_ptr_reg, uint32_t type,
                   uint8_t fc, uint8_t mod);
+int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                  uint64_t param_addr, uint8_t fc);
 
 #endif
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 5abe9e893b..c54337cf02 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -289,3 +289,66 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return !len ? 0 : 3;
 }
+
+int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                  uint64_t param_addr, uint8_t fc)
+{
+    uint8_t key[32], tweak[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
+    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
+    int keysize, i;
+    uint64_t addr;
+    AES_KEY exkey;
+
+    switch (fc) {
+    case 0x32: /* CPACF_PCC compute XTS param AES-128 */
+        keysize = 16;
+        break;
+    case 0x34: /* CPACF PCC compute XTS param AES-256 */
+        keysize = 32;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    /* fetch block sequence nr from param block into buf */
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        addr = wrap_address(env, param_addr + keysize + AES_BLOCK_SIZE + i);
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
+    /* fetch key from param block */
+    for (i = 0; i < keysize; i++) {
+        addr = wrap_address(env, param_addr + i);
+        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
+    }
+
+    /* fetch tweak from param block into tweak */
+    for (i = 0; i < AES_BLOCK_SIZE; i++) {
+        addr = wrap_address(env, param_addr + keysize + i);
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
+        addr = wrap_address(env, param_addr + keysize + 3 * AES_BLOCK_SIZE + i);
+        cpu_stb_mmu(env, addr, buf[i], oi, ra);
+    }
+
+    return 0;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 383233ff21..7c28c9f4b1 100644
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
+    case 0x32: /* CPACF_PCC compute XTS param AES-128 */
+    case 0x34: /* CPACF PCC compute XTS param AES-256 */
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

