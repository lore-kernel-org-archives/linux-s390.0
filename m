Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679A826CE1E
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 08:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782288645; cv=none; b=QI341Yoh+P7EKbFzxUzq6VdSZw7EyEIDXeqA7ZfgkG9UooiKYfutijNxNdGf3rBIC8MMTwvqHccaIYqO679BmcDoNInvB45M98yAiDuVcFMhV/MAEXNjgdcHpdQvfxYkzYxFmOoavXzcQGVAIMygQU1g1g5NXGrqVRgbtbRZy3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782288645; c=relaxed/simple;
	bh=SQgzI6Ll952d36Y1kSaDb3+oGkuG/zt5Ct4d25bIm+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSjoqFCZBt93h+SumhiS05oqiUt7N/XDy8C20pp/EwOSTEBakwCm8T6gvspKU2viFQACihDaIcT/rLj87GtBC63pyi5DUUYTaWL4gwfuonMh/zkeL4kz1rBKr6+YCvRvVMGeAVJ8O9qNKIh10reRFf8PWam505xczWUVq9XEtfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AumJ+mvG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AumJ+mvG"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O6IMAM4169201;
	Wed, 24 Jun 2026 08:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=M88dtoWpd7S/lCFBy
	AUcvp58/hNIhXVABasx9zroTsw=; b=AumJ+mvGJ2IJ7mTH/s9nzQ60/M/Pfe8PL
	G3UhKT/bmhGieahrA7E560H+PgR5XlRepntpVO8z1eDW6RqNWfXfwIv+vz1azBpx
	FkZk7uFWVvyaRHnf1dv19ZTipTE4ki/EwhLmFBSMZr+KNv2ypPQnZkEE8Vtv1BmR
	iZHcUAVmHmUgYfF5X+PqkFdRcPgC9zTG2W68nuVZmunRmMJ239TycN5Nvx4C5W3u
	6YeYMkwq2HWNcOoN2qARlBOo7L900LWBagDpJyzZBeNUkcR+LQfCI1mJ6n5s6r99
	uIkOARBH1dC/jkIxkL/VFo4LuuwX8a6rHFoxL2KeLebkC3Xg4Wd0g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gjx8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:10:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65O84epY010068;
	Wed, 24 Jun 2026 08:10:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qfsty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:10:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65O8AVfv22544854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 08:10:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F41212004B;
	Wed, 24 Jun 2026 08:10:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B539A2004D;
	Wed, 24 Jun 2026 08:10:30 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.224.92.54])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 08:10:30 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v8 02/18] target/s390x: Rework s390 cpacf implementations
Date: Wed, 24 Jun 2026 10:09:59 +0200
Message-ID: <20260624081029.23815-3-freude@linux.ibm.com>
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
X-Proofpoint-GUID: 4QdXagPbUSQXjQbbM-wHtOjJqZccgzkS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfX7p2guA5K5fz5
 AZlnyviCNdA5YLEP7fJa/qEH2xLNwo7CgS/EOiakFic95OU60HQ4cY+HTS+v5wOsRhZUZNtdubo
 uAnfeyoXgb/lJh64sLmHKJpT+0Hw4sA=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3b90fb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=v0hsMmXGSI8d9nQ1oYgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfXzyb0hDQ2Uqcj
 uFumQ/tUA48Bf7r6IusN3INSQnvVNMjWKZy14zhf1eoe/daBV/YUiXnslFSHdg6xRuYPdvu1TaS
 d7tdiFiw8snyUMDnoEdMwi7YljmsHp+dMeEvq9ZZa0XLnAInlQUfTKB6a9VRi9SNg/qVd5Hjjt+
 H/2TPv/2uSyG3VLyIDntquVcbvDTnYm5JOSs3mYY8ie2CADiduSEUGu5LkVC3S+pxZ1QcG56vLF
 XRPQzfIBZa9zskheitq7oJ2F1IIgfNVeW78yRtPZulpUOdzKY5UCMDINRIFYDW70OzyegYq1MBw
 Q+t32f8Dp/Uskp4RKMCXdqHdqJGwrzI+BX3c97EQPGxb1iL9+qrYr278EW7aJUWQsC5fvk6q+ZB
 dvpmspKl+P1NneWc3yQ8EwiBK+YZUdCPoGyaDuQPw9TQJaSbN7SLo12fNYEogSjUbcHHhOrmf4R
 Nf2S5ZQp67qWlBjthCA==
X-Proofpoint-ORIG-GUID: 4QdXagPbUSQXjQbbM-wHtOjJqZccgzkS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240063

Fix missing parts for MSA 9 kdsa and rework the cpacf
handling code so that further extensions can be made in
a clean and structured way.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
---
 target/s390x/tcg/crypto_helper.c | 89 +++++++++++++++++++++++++++-----
 target/s390x/tcg/insn-data.h.inc |  1 +
 target/s390x/tcg/translate.c     |  2 +
 3 files changed, 79 insertions(+), 13 deletions(-)

diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 29ad2aff43..f5189ce1c5 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -272,6 +272,57 @@ static void fill_buf_random(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     }
 }
 
+static int cpacf_kimd(CPUS390XState *env, const int mmu_idx, const uintptr_t ra,
+                      uint32_t r1, uint32_t r2, uint32_t r3, uint8_t fc)
+{
+    int rc = 0;
+
+    switch (fc) {
+    case 0x03: /* CPACF_KIMD_SHA_512 */
+        rc = cpacf_sha512(env, mmu_idx, ra, env->regs[1], &env->regs[r2],
+                          &env->regs[r2 + 1], S390_FEAT_TYPE_KIMD);
+        break;
+    default:
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    return rc;
+}
+
+static int cpacf_klmd(CPUS390XState *env, const int mmu_idx, const uintptr_t ra,
+                      uint32_t r1, uint32_t r2, uint32_t r3, uint8_t fc)
+{
+    int rc = 0;
+
+    switch (fc) {
+    case 0x03: /* CPACF_KLMD_SHA_512 */
+        rc = cpacf_sha512(env, mmu_idx, ra, env->regs[1], &env->regs[r2],
+                          &env->regs[r2 + 1], S390_FEAT_TYPE_KLMD);
+        break;
+    default:
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    return rc;
+}
+
+static int cpacf_ppno(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                      uint32_t r1, uint32_t r2, uint32_t r3, uint8_t fc)
+{
+    int rc = 0;
+
+    switch (fc) {
+    case 0x72: /* CPACF_PRNO_TRNG */
+        fill_buf_random(env, mmu_idx, ra, &env->regs[r1], &env->regs[r1 + 1]);
+        fill_buf_random(env, mmu_idx, ra, &env->regs[r2], &env->regs[r2 + 1]);
+        break;
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
@@ -282,13 +333,15 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     uint8_t subfunc[16] = { 0 };
     uint64_t param_addr;
     MemOpIdx oi;
+    int rc = 0;
 
     switch (type) {
-    case S390_FEAT_TYPE_KMAC:
+    case S390_FEAT_TYPE_KDSA:
     case S390_FEAT_TYPE_KIMD:
     case S390_FEAT_TYPE_KLMD:
-    case S390_FEAT_TYPE_PCKMO:
+    case S390_FEAT_TYPE_KMAC:
     case S390_FEAT_TYPE_PCC:
+    case S390_FEAT_TYPE_PCKMO:
         if (mod) {
             tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         }
@@ -300,25 +353,35 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
-    switch (fc) {
-    case 0: /* query subfunction */
+    /* handle query subfunction */
+    if (fc == 0) {
         oi = make_memop_idx(MO_8, mmu_idx);
-        for (int i = 0; i < 16; i++) {
+        for (int i = 0; i < sizeof(subfunc); i++) {
             param_addr = wrap_address(env, env->regs[1] + i);
             cpu_stb_mmu(env, param_addr, subfunc[i], oi, ra);
         }
+        goto out;
+    }
+
+    switch (type) {
+    case S390_FEAT_TYPE_KIMD:
+        rc = cpacf_kimd(env, mmu_idx, ra, r1, r2, r3, fc);
         break;
-    case 3: /* CPACF_*_SHA_512 */
-        return cpacf_sha512(env, mmu_idx, ra, env->regs[1], &env->regs[r2],
-                            &env->regs[r2 + 1], type);
-    case 114: /* CPACF_PRNO_TRNG */
-        fill_buf_random(env, mmu_idx, ra, &env->regs[r1], &env->regs[r1 + 1]);
-        fill_buf_random(env, mmu_idx, ra, &env->regs[r2], &env->regs[r2 + 1]);
+    case S390_FEAT_TYPE_KLMD:
+        rc = cpacf_klmd(env, mmu_idx, ra, r1, r2, r3, fc);
+        break;
+    case S390_FEAT_TYPE_PPNO:
+        rc = cpacf_ppno(env, mmu_idx, ra, r1, r2, r3, fc);
+        break;
+    case S390_FEAT_TYPE_KDSA:
+    case S390_FEAT_TYPE_KMAC:
+        /* subfunctions (other than query) are not implemented yet */
+        tcg_s390_program_interrupt(env, PGM_OPERATION, ra);
         break;
     default:
-        /* we don't implement any other subfunction yet */
         g_assert_not_reached();
     }
 
-    return 0;
+out:
+    return rc;
 }
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 0d5392eac5..6a0a7aacda 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -1015,6 +1015,7 @@
     D(0xb92e, KM,      RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KM)
     D(0xb92f, KMC,     RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMC)
     D(0xb929, KMA,     RRF_b, MSA8, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KMA)
+    D(0xb93a, KDSA,    RRE,   MSA9, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KDSA)
     E(0xb93c, PPNO,    RRE,   MSA5, 0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_PPNO, IF_IO)
     D(0xb93e, KIMD,    RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KIMD)
     D(0xb93f, KLMD,    RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KLMD)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 82165ac1ec..cef1b55149 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2592,6 +2592,7 @@ static DisasJumpType op_msa(DisasContext *s, DisasOps *o)
         /* FALL THROUGH */
     case S390_FEAT_TYPE_PCKMO:
     case S390_FEAT_TYPE_PCC:
+    case S390_FEAT_TYPE_KDSA:
         break;
     default:
         g_assert_not_reached();
@@ -6046,6 +6047,7 @@ enum DisasInsnEnum {
 #define FAC_MSA4        S390_FEAT_MSA_EXT_4 /* msa-extension-4 facility */
 #define FAC_MSA5        S390_FEAT_MSA_EXT_5 /* msa-extension-5 facility */
 #define FAC_MSA8        S390_FEAT_MSA_EXT_8 /* msa-extension-8 facility */
+#define FAC_MSA9        S390_FEAT_MSA_EXT_9 /* msa-extension-9 facility */
 #define FAC_ECT         S390_FEAT_EXTRACT_CPU_TIME
 #define FAC_PCI         S390_FEAT_ZPCI /* z/PCI facility */
 #define FAC_AIS         S390_FEAT_ADAPTER_INT_SUPPRESSION
-- 
2.43.0

