Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8299395AF8
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782288663; cv=none; b=ZA28hoI0FULq1eWtyPAMir8GZPFpmex0RYIQtwww991M2YzjqeNwvuFld3xLjRfDQ5JK8DyWMZJLxOl+unYDIOda2pr1iQeovEkF9e3Z+W+X9zOMihjzBXJVbQ3oaFwsHxumFQ4VoybPRwMVRKtKuJEvUaMlfTPSGsgXUGBZsrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782288663; c=relaxed/simple;
	bh=OIk36xoDaQqo38ACzM3OPuPT9l3Kt6dosm7ynZOdltE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNxWAcqspOzLGJa2wdX+31/PjNeh/N3g1Bm6dxDv3bI7el4F309oiv3Dpx786agbPDaWbhWbOtVyOeNW4gOVY5uHsKoHaY5LRBuirciUEP5UyiSAC4Wjf4dkaNgwQvy2A+tjTH78Gr0X6hSyHprP+9hD9J8XmUEjFIp5z42KVEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CCEDL4Kg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CCEDL4Kg"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O6ISpU076229;
	Wed, 24 Jun 2026 08:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XBX5CQ/Aq59LpY1Y0
	CSRzKd+5BQE90t6SsXw7Acdrus=; b=CCEDL4Kg2MjLLOWIL+BvKqEsPBZKkvD0r
	fy0L0D05lpR2klvEehhUwQ8BbXxYTy8SQ7FQelEiDmUmG+OQsuGm1nHJF+OegGVC
	/BLAbUjcoXVbXZGOJJ7/dXXAErag2APrvJ52CidKRkQbFv9oACWG/lShRIgsd8J4
	63sP1K8hW02FZd9XSwph+uwTdvPR+BfKPM4By7M3C83xFcC8OLWiNxdipICwcuII
	n5GsvdSI7ih39FaytPM0m4jd7vsdF3L16qvsPqAxutkb3EXHS9GD5IJbR+fIJr4p
	gvHIy9jz8ZPJAKQ4wyj8OyZ/BbXwYzB5UVgEZ4S6rYhSuEJ34JUaQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4k26y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:10:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65O84jxD017306;
	Wed, 24 Jun 2026 08:10:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phfgv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:10:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65O8AXqH55116248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 08:10:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4ABAC20040;
	Wed, 24 Jun 2026 08:10:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18FC92004B;
	Wed, 24 Jun 2026 08:10:33 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.224.92.54])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 08:10:33 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v8 10/18] target/s390x: Support pckmo encrypt AES subfunctions
Date: Wed, 24 Jun 2026 10:10:07 +0200
Message-ID: <20260624081029.23815-11-freude@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfX/U2P/2rwwR6N
 OVUUnmsmt6OWjWeDkNg78Pf5HbYC636dL9Nut/Sb9nq4ls0iF5nCq5VC85YyEv2w6wc/WLJyMIn
 pQp6S/ZXHZsplXTQpZPHzkEWo4H81VU=
X-Proofpoint-ORIG-GUID: 5CwaKLspt_i-oDLvX2HoXNcIIQUKCXNw
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3b90fe cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=c1VHS3cbejH8GTlVP8QA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfXyTFIOmDn4853
 cHT8+rxZk4BAS5HzMZn1psKn8q3SXxdvYn8FqVLRf62TuQZXKO73SX7t/Q3/ufjSGyU2kXLJ3RW
 ms9ftkGKAUxbTFEyDxs8I+57AqmyN8wp7nxz3FpnIzdUAaBUuPSk3sKhkZfaBwNMgAOqRmmZTxZ
 7SUD8F87+8jutLDu4NJT6ybJFqnFWEQCdrDBYX58HW5gKSkMKu+AKEzxJPrVh9QlX5Svr/rMuo/
 EEoJ2eSIS0+6tNt5uF0BS7Eh/1HlC8GBrj2s07gq03V3vhvMFjIeW5v+Tdg4FZoqn2eFRI7d95t
 Fan1x30U/No3sjThAdyYlB1BGPAJCuJxyEsQfdTUNfJ4U3/F2II0lGgwmfRAfHTKDwA8F/qotFV
 aH8rlJa3nE0VxZVcKGFTBaFolJBJmE7kEN2b1sJbrkBbuOHrJNuU9+WzCyW5rYn22RvABUU6Ynj
 qc/2FX5e8TBF2OewYMA==
X-Proofpoint-GUID: 5CwaKLspt_i-oDLvX2HoXNcIIQUKCXNw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240063

Support the subfuctions PCKMO-Encrypt-AES-128-Key,
PCKMO-Encrypt-AES-192-Key and PCKMO-Encrypt-AES-256-Key.

These subfunctions derive a protected key from an AES clear key
by encrypting it with an internal AES wrapping key. More
details can be found in the "z/Architecture Prinziples of
Operation" document.

The qemu version provided here is only a fake intended to make
protected key available for developing and testing purpose:
* The protected key is 'derived' from the clear key by xoring
  the fixed pattern 0xAAAA... onto the key value.
* The AES Wrapping Key Verification Pattern is a fixed
  value of 32 bytes 0xFACEFACE...

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
---
 target/s390x/gen-features.c      |  3 ++
 target/s390x/tcg/cpacf.h         |  2 +
 target/s390x/tcg/cpacf_aes.c     | 66 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c | 21 ++++++++++
 target/s390x/tcg/translate.c     |  9 ++++-
 5 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index f9b1a40c7c..d3e69aaca6 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -934,6 +934,9 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KMCTR_AES_256,
     S390_FEAT_PCC_XTS_AES_128,
     S390_FEAT_PCC_XTS_AES_256,
+    S390_FEAT_PCKMO_AES_128,
+    S390_FEAT_PCKMO_AES_192,
+    S390_FEAT_PCKMO_AES_256,
 };
 
 /****** END FEATURE DEFS ******/
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index fdd0d7203e..1350199536 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -41,5 +41,7 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t param_addr, uint64_t *dst_ptr_reg,
                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                   uint32_t type, uint8_t fc, uint8_t mod);
+int cpacf_aes_pckmo(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                    uint64_t param_addr, uint8_t fc);
 
 #endif
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 27681d5670..5db63983ef 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -459,3 +459,69 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return !len ? 0 : 3;
 }
+
+/*
+ * Hard coded pattern xored with the AES clear key
+ * to 'produce' the protected key.
+ */
+static const uint8_t protkey_xor_pattern[32] = {
+    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA,
+    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA,
+    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA,
+    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA };
+
+/*
+ * Hard coded wkvp ("Wrapping Key Verification Pattern")
+ */
+static const uint8_t protkey_wkvp[32] = {
+    0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E,
+    0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E,
+    0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E,
+    0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E };
+
+int cpacf_aes_pckmo(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                    uint64_t param_addr, uint8_t fc)
+{
+    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
+    uint8_t key[32];
+    int keysize, i;
+    uint64_t addr;
+
+    switch (fc) {
+    case 0x12: /* CPACF_PCKMO_ENC_AES_128_KEY */
+        keysize = 16;
+        break;
+    case 0x13: /* CPACF_PCKMO_ENC_AES_192_KEY */
+        keysize = 24;
+        break;
+    case 0x14: /* CPACF_PCKMO_ENC_AES_256_KEY */
+        keysize = 32;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    /* fetch key from param block */
+    for (i = 0; i < keysize; i++) {
+        addr = wrap_address(env, param_addr + i);
+        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
+    }
+
+    /* 'derive' the protected key */
+    for (i = 0; i < keysize; i++) {
+        key[i] ^= protkey_xor_pattern[i];
+    }
+
+    /* store the protected key into param block */
+    for (i = 0; i < keysize; i++) {
+        addr = wrap_address(env, param_addr + i);
+        cpu_stb_mmu(env, addr, key[i], oi, ra);
+    }
+    /* followed by the fake wkvp */
+    for (i = 0; i < sizeof(protkey_wkvp); i++) {
+        addr = wrap_address(env, param_addr + keysize + i);
+        cpu_stb_mmu(env, addr, protkey_wkvp[i], oi, ra);
+    }
+
+    return 0;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index f400e29e34..3868e3e074 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -192,6 +192,24 @@ static int cpacf_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     return rc;
 }
 
+static int cpacf_pckmo(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                       uint8_t fc)
+{
+    int rc = 0;
+
+    switch (fc) {
+    case 0x12: /* CPACF_PCKMO_ENC_AES_128_KEY */
+    case 0x13: /* CPACF_PCKMO_ENC_AES_192_KEY */
+    case 0x14: /* CPACF_PCKMO_ENC_AES_256_KEY */
+        rc = cpacf_aes_pckmo(env, mmu_idx, ra, env->regs[1], fc);
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
@@ -251,6 +269,9 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     case S390_FEAT_TYPE_PCC:
         rc = cpacf_pcc(env, mmu_idx, ra, fc);
         break;
+    case S390_FEAT_TYPE_PCKMO:
+        rc = cpacf_pckmo(env, mmu_idx, ra, fc);
+        break;
     case S390_FEAT_TYPE_PPNO:
         rc = cpacf_ppno(env, mmu_idx, ra, r1, r2, r3, fc);
         break;
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index cef1b55149..d7a99e6c1e 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2558,6 +2558,7 @@ static DisasJumpType op_msa(DisasContext *s, DisasOps *o)
     int r2 = have_field(s, r2) ? get_field(s, r2) : 0;
     int r3 = have_field(s, r3) ? get_field(s, r3) : 0;
     TCGv_i32 t_r1, t_r2, t_r3, type;
+    bool update_cc = true;
 
     switch (s->insn->data) {
     case S390_FEAT_TYPE_KMA:
@@ -2589,8 +2590,10 @@ static DisasJumpType op_msa(DisasContext *s, DisasOps *o)
             gen_program_exception(s, PGM_SPECIFICATION);
             return DISAS_NORETURN;
         }
-        /* FALL THROUGH */
+        break;
     case S390_FEAT_TYPE_PCKMO:
+        update_cc = false;
+        /* FALL THROUGH */
     case S390_FEAT_TYPE_PCC:
     case S390_FEAT_TYPE_KDSA:
         break;
@@ -2603,7 +2606,9 @@ static DisasJumpType op_msa(DisasContext *s, DisasOps *o)
     t_r3 = tcg_constant_i32(r3);
     type = tcg_constant_i32(s->insn->data);
     gen_helper_msa(cc_op, tcg_env, t_r1, t_r2, t_r3, type);
-    set_cc_static(s);
+    if (update_cc) {
+        set_cc_static(s);
+    }
     return DISAS_NEXT;
 }
 
-- 
2.43.0

