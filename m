Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592BD224FA
	for <linux-s390@vger.kernel.org>; Wed,  1 Jul 2026 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924452; cv=none; b=AQWeux8wjOMBLYQDu/SH3++Itkg3+D9ay9sCxxL/O/tQHM3Q7/bjz71JlREmBiFKHsNoMN/boScPO9EPmBdrizAUt39YSGrZw5F2J1pdJepMYdzzeS8P+LZemefBaE88IS1PYJLuOe05J6itO2I6x1LGYDqV7TGDy6LI/ZiTatI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924452; c=relaxed/simple;
	bh=+AT2+Py72u8NigqYpiYSjQdKBWb8Uqx/Ov3AncTDZ+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/VN8rZniDIOKV2DjdifQagF0Gos2eLP7XsUwa67g5UeCSEhzpEf1CoJLSOX4kdJZWPL1UBWcy+gWDEJENdUYSUYJ/GIlqu5+BifUDD12Zc70Eqn0gyfAvoxERqO5y2wLVWI1BfYwExHhgdRAwl4qkiXQfvoUNwkeX57vUXaz28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i1spP9yj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i1spP9yj"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661AIQ4W494406;
	Wed, 1 Jul 2026 16:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4jDaDveEQjx3M9gQg
	Gm7WqdzDPE7p/UTV3IR3bqedqw=; b=i1spP9yjRxndO0QDdlJSv6hscQPNDEsml
	MHvTi1u6io8bKsZgsoQTJaI8co2rzJ+gbCLxS/uGwCqamkKiIhzq7t1N5Qp4chwf
	7lp0aEaS7W/khWtnF+cdu9Bf6iAR6xYufbqBPinfglgiTTM7BDiBjAJCm7e0yfwF
	ML9jWhxGnPfVFV6kLxwCtevMTdVjyu15eby90jzg5E6IF0wU8Hk4xX10qgYhSile
	Iqh8/f5yFuLhX9FzMBHMheu3dtOQNrBBjH3HWNODVbxL7db1s0qYvOi3vABfcorC
	tX6DvWCByYOuPkvFonzK4MJz5ExpFmoEqNJ9tfLEHtwkjrbzJgkLw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rf56f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 16:46:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661GYda8015589;
	Wed, 1 Jul 2026 16:46:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gg1tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 16:46:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 661GksAU10486094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 16:46:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CA4E20043;
	Wed,  1 Jul 2026 16:46:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D6092004D;
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
Subject: [PATCH v9 11/21] target/s390x: Support pckmo encrypt AES subfunctions
Date: Wed,  1 Jul 2026 18:46:34 +0200
Message-ID: <20260701164650.95760-12-freude@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a454482 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=Z4AAViVgUL_E5abT2tgA:9
X-Proofpoint-ORIG-GUID: TDY7XxzCZHmlQy9rldWJlrFWbhZLIeR7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE3MyBTYWx0ZWRfXxxTqxGnaxjv4
 iOvEP3IDc+OFkRXotdVnaDGbO1cD7fi/gtN1RaoRGBVLMwE+O4QHIVfAXOU5qLIfb/KmHMwmgjA
 gG2Rlapj73S9krGKw6FcULHpPhK47nixYt2nzhXLPMJExiI/yhlULItSFdDKkdPD1ideuHwz5vM
 gOcUI8m8SmBGtcMJoHapBJ7v06OdzuaLbkE5m5aqv2CY0LjGX+IXQRZTmrYGZpE3Yk4FyJvXbsv
 kaWu8En05QzVNRiEEorcx6fWRc/JACkJIMmN5j62+z9qG28+23y3z+8HS2WFhDhaIUJtaQItPEO
 3c4jvuj9qYkUYqWr5AXYwi4XAYNXl1It4NR0y2lITas34ATN7KJ8WyePgZLKbeoT1lv3s3ANSQD
 XOAYX5APrRKBIUrDU0VsrD8hlfGxzdSmobL0PfahEFS4M2zZlv9u57x4CqVy/m5KU6a2WAHvIwc
 ym4zGA/Ac+Tir9XMtTw==
X-Proofpoint-GUID: TDY7XxzCZHmlQy9rldWJlrFWbhZLIeR7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE3MyBTYWx0ZWRfX4bP9Y4cYb7Hq
 RJZkCXnH16dudzyUOFQE1mjivf2UYaqmMGKh6bzsO6ePAHoUBZ3AAlaAKsMMK0FO/BMKuocM8tJ
 n5W1m0fSSdNeX2fZG7cIGtOvBKIOEkI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010173

Support the subfuctions PCKMO-Encrypt-AES-128-Key,
PCKMO-Encrypt-AES-192-Key and PCKMO-Encrypt-AES-256-Key.

These subfunctions derive a protected key from an AES clear key
by encrypting it with an internal AES wrapping key. More
details can be found in the "z/Architecture Prinziples of
Operation" document.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
---
 target/s390x/gen-features.c      |  3 +++
 target/s390x/tcg/cpacf.h         |  4 +++
 target/s390x/tcg/cpacf_aes.c     | 45 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c | 21 +++++++++++++++
 target/s390x/tcg/translate.c     |  9 +++++--
 5 files changed, 80 insertions(+), 2 deletions(-)

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
index df7f258443..7512c0ea4c 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -279,4 +279,8 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E, \
     0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E }
 
+/* from cpacf_aes.c */
+int cpacf_aes_pckmo(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                    uint64_t param_addr, uint8_t fc);
+
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 6702006b66..37c616ca5c 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -500,3 +500,48 @@ static void decrypt_protkey(uint8_t *key, int keysize)
         key[i] ^= protkey_xor_pattern[i];
     }
 }
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
+    case CPACF_PCKMO_ENC_AES_128_KEY:
+        keysize = 16;
+        break;
+    case CPACF_PCKMO_ENC_AES_192_KEY:
+        keysize = 24;
+        break;
+    case CPACF_PCKMO_ENC_AES_256_KEY:
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
+    /* 'derive' the protected key from the clear key */
+    encrypt_clrkey(key, keysize);
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
index 564f7fa243..08151e916f 100644
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
+    case CPACF_PCKMO_ENC_AES_128_KEY:
+    case CPACF_PCKMO_ENC_AES_192_KEY:
+    case CPACF_PCKMO_ENC_AES_256_KEY:
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

