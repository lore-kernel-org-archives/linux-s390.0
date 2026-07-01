Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C20379C2E
	for <linux-s390@vger.kernel.org>; Wed,  1 Jul 2026 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924434; cv=none; b=o/mjSBQvv3ONb3aLNTz/GOWiwJhELpYHFB/3d0TDHRuW2JdkPXIFXCJ3iYJF4VKSS7MWUREf8I66uiXGHOeHYmoghnW9nbuoc+kjh566YsNVoGBfaqinv5JjDhEMxQZiA2ElPkeXInzfvEzTweeLoDw+4PkOOYZJBPRCJPddXw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924434; c=relaxed/simple;
	bh=vtF09qdNQuTTDrDS7sd8pa/8OZwfnroX6kFGv74Z2Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTPa/x8vFEuPTq8PPNIR1M0PW1dX/rZbqEg0DEuiTFq4Bd6eyl3w4HsDOqo+ID3qrRB+qV63rf375pFmYDzd/jb6UBSLtwDR1G6u7rC4d0hBRvG8rPC9rdsBpgtLr37dTpN9aZBuvOtrdHd7lfCBNBKbFdCl9tEj445q4hvtidU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MzkF6j4y; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MzkF6j4y"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661AIMRM446476;
	Wed, 1 Jul 2026 16:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2bRnNmzn8zKV9kO1+
	0GIK5NM2b/Ji9wu7DWH+5dYf3g=; b=MzkF6j4yL987Zk3uadXMrWNfcMD+NOemB
	8ul1bwk/VTclB+kjF/4GYtWqLESK2Ws6tMERg83BEjSKR99kadAbMOKibo/Xq3Rp
	lS4dJOYfXr1o3Zarl3CNKh50HW+9njz14TPjLMs3wzmKdumpST14EUIlh0sMDfiq
	Bl1y+/ZLNLlen58PCt7jeqzV+8gA+YwnsvgudDAU04YyTVXVXwvc37j3lxQNdIIM
	wYMLWncCKzEt/KJELfRXQwlCDq9yJCamj1ZD9dfDbBVnVRA7aYvYjveBNIMMPxkf
	cZEdINcsixkIfR8TAYWLDRnygc44hj0Xcbc5UzVg9yqhoXa/oHYhQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjwa9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 16:46:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661GYi6L018903;
	Wed, 1 Jul 2026 16:46:59 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w894r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 16:46:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 661Gks0E30147234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 16:46:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C55BF2004B;
	Wed,  1 Jul 2026 16:46:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D26F20040;
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
Subject: [PATCH v9 14/21] target/s390x: Support protected key AES CTR for cpacf kmctr instruction
Date: Wed,  1 Jul 2026 18:46:37 +0200
Message-ID: <20260701164650.95760-15-freude@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE3MyBTYWx0ZWRfXwty7vwlko17d
 eLkY7dpJVZqKEndxHcM/Dysx8JFFlitiPeZIfTyTbXV6OOFPJ7nxC+7lGgs68j+3gpv+DCCWzbh
 Gayjb9X+QJaLTvWw9RoKVJyGElUfyn2nrosJQm5IoHSK7jCvTIxTPbX9qnbKKgk8ypRno9/3XPs
 ENG0He6JSeM0ZPvqmdooszv/jhiRHIpbFtxXIf2F5INyA4TeKhiqctti1vY7uosQZSiParf1iaG
 pjdN1jXh/T7gLHBIiSvakha6Ze6C1yTF1uo1cRlksc8p3V3aATTwCypSQarFGNVzpvQHaIKBLyF
 t//6ZO6tcD9kEOu76Z4QdydKy+3GTImlhsy7N2nbnxZRFAYOEN2K+opfNGoUwZcCcA0x59053su
 eB+sLO27JAT9Z8eNx3wtCoPRDGBxS/8FKNt6Euj+7QFTOzUFY7eKDxnnXqmM95dvZNjc3D0hDSh
 SvpOn6Stzd82MTGpxKg==
X-Proofpoint-GUID: BJJ4aZqjP6ru4ngcArMwrRVPsQCB_b0Y
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a454483 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=f59o6tnjY-_5Ge3baHwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE3MyBTYWx0ZWRfXxUekF5RWZPUK
 aTiM1egskU37N9gnnXnSGhZfnSRVjgmZ5sKl8e21BLQ2glpSfgZEOygHerw9P4tTY7DlitTGp+X
 0wizaUPTMWkwwZzP56yMowF66i6Pwco=
X-Proofpoint-ORIG-GUID: BJJ4aZqjP6ru4ngcArMwrRVPsQCB_b0Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010173

Support the subfunctions CPACF_KMCTR_PAES_128, CPACF_KMCTR_PAES_192
and CPACF_KMCTR_PAES_256 for the cpacf kmctr instruction.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/gen-features.c      |  3 ++
 target/s390x/tcg/cpacf.h         |  5 ++
 target/s390x/tcg/cpacf_aes.c     | 89 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |  7 +++
 4 files changed, 104 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 074c53aecd..4a131dc191 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -938,6 +938,9 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KMCTR_AES_128,
     S390_FEAT_KMCTR_AES_192,
     S390_FEAT_KMCTR_AES_256,
+    S390_FEAT_KMCTR_EAES_128,
+    S390_FEAT_KMCTR_EAES_192,
+    S390_FEAT_KMCTR_EAES_256,
     S390_FEAT_PCC_XTS_AES_128,
     S390_FEAT_PCC_XTS_AES_256,
     S390_FEAT_PCKMO_AES_128,
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index b0d484c3cb..6071f21fb6 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -290,5 +290,10 @@ int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint64_t param_addr, uint64_t *dst_ptr_reg,
                    uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                    uint32_t type, uint8_t fc, uint8_t mod);
+int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint64_t *dst_ptr_reg,
+                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                   uint64_t *ctr_ptr_reg, uint32_t type,
+                   uint8_t fc, uint8_t mod);
 
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index bb3488e38f..c52df6510f 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -739,3 +739,92 @@ int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return !len ? 0 : 3;
 }
+
+int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint64_t *dst_ptr_reg,
+                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                   uint64_t *ctr_ptr_reg, uint32_t type,
+                   uint8_t fc, uint8_t mod)
+{
+    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
+    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
+    uint8_t ctr[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
+    uint64_t addr, len = *src_len_reg, done = 0;
+    int i, keysize, addr_reg_size = 64;
+    uint8_t key[32], wkvp[32];
+    AES_KEY exkey;
+
+    g_assert(type == S390_FEAT_TYPE_KMCTR);
+
+    switch (fc) {
+    case CPACF_KMCTR_PAES_128:
+        keysize = 16;
+        break;
+    case CPACF_KMCTR_PAES_192:
+        keysize = 24;
+        break;
+    case CPACF_KMCTR_PAES_256:
+        keysize = 32;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (!(env->psw.mask & PSW_MASK_64)) {
+        len = (uint32_t)len;
+        addr_reg_size = (env->psw.mask & PSW_MASK_32) ? 32 : 24;
+    }
+
+    /* length has to be properly aligned. */
+    if (!QEMU_IS_ALIGNED(len, AES_BLOCK_SIZE)) {
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
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
+    /* fetch protected key from param block */
+    for (i = 0; i < keysize; i++) {
+        addr = wrap_address(env, param_addr + i);
+        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
+    }
+    /* decrypt the protected key */
+    decrypt_protkey(key, keysize);
+
+    /* expand key */
+    AES_set_encrypt_key(key, keysize * 8, &exkey);
+
+    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
+    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
+        /* read in nonce/ctr => ctr */
+        aes_read_block(env, mmu_idx, *ctr_ptr_reg + done, ctr, ra);
+        /* encrypt ctr => buf */
+        AES_encrypt(ctr, buf, &exkey);
+        /* read in one block of input data => in */
+        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
+        /* exor input data with encrypted ctr => out */
+        aes_xor(in, buf, out);
+        /* write out the processed block */
+        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
+        len -= AES_BLOCK_SIZE;
+        done += AES_BLOCK_SIZE;
+    }
+
+    *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
+                             *src_ptr_reg + done);
+    *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
+                             *dst_ptr_reg + done);
+    *ctr_ptr_reg = deposit64(*ctr_ptr_reg, 0, addr_reg_size,
+                             *ctr_ptr_reg + done);
+    *src_len_reg -= done;
+
+    return !len ? 0 : 3;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 237ce744b7..73b2a6557c 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -165,6 +165,13 @@ static int cpacf_kmctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
                            &env->regs[r3], S390_FEAT_TYPE_KMCTR, fc, mod);
         break;
+    case CPACF_KMCTR_PAES_128:
+    case CPACF_KMCTR_PAES_192:
+    case CPACF_KMCTR_PAES_256:
+        rc = cpacf_paes_ctr(env, mmu_idx, ra, env->regs[1],
+                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
+                            &env->regs[r3], S390_FEAT_TYPE_KMCTR, fc, mod);
+        break;
     default:
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
-- 
2.43.0

