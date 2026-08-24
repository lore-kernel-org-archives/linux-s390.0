Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA3E332ED6
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560399; cv=none; b=jA1y2rYsw8XGCmmm1wjV0rjf2L0HxRhKQHh41wafU5KKDcl58YoqjI9lI65NDyygXU8m3oXj670ZnqqxqBQVOFuPHTfTkQNqU1vH1GwDBmoBUjLejtkxLDfHFz8ax9+q5ko42da/a22opyf+V7LpmN6/YX4jGWQtlpuec5ux3js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560399; c=relaxed/simple;
	bh=HMugjSUEsvnN6Jb0SsssEDVqKLURnTRKp8aQIa4xtjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSKIGDM2uIbLY/XNFHNeqN/uxIPz3ASVM9wHy7N+pLNoOf4xr7E1FRx3ndWgQ7LdECDhTx0I1aT+YK5JGsQD6Si+JUxrddMpPl22XCnxuRWXQsecPEuITHjcmAJZgonSC37gORx5iEcE53fpvu4sg8sNMhdf9MZR7mAJA9wD978=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WdRzABPC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WdRzABPC"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5VX9A4031322;
	Mon, 24 Aug 2026 08:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JxYe7fX+UDm/xMQO7
	joGm39jI5RVR2SQoE1agHnB/8g=; b=WdRzABPCHT0Q0CaZXPQ0jMZPJzL/53luG
	lFgfgEdXlN7U2BIBSJlB0y9EdgBkeFnFa86SUXKrmHjvwsnYIXa25StU9uN4ibAH
	kzx9NAUqaGicK1GRk2iaQ4CjJwp09xKJHHNVOZG5/xk55iWp5o6f5yTKNm6qLAek
	9kPKQMgriXPDgXXH27CmAkf+Y8jX7o3QxQxmzrFh4ugJTuryodeLo5LXF3y73U0a
	Jqp2p8VQun46p4Iz3l6xHwbdQTTdGjtkyPww04TTEiGg7pxRE87S2FoG9ZCv6jpa
	O7+VNa6QRRS8Pa8qkiuajjLKFXA24/F1Vv2OdOVdCcd9imN057tVg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726e84p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 08:32:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O8QLcP018136;
	Mon, 24 Aug 2026 08:32:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkgvr3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 08:32:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67O8W7cj45154560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 08:32:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B711120040;
	Mon, 24 Aug 2026 08:32:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 875452004B;
	Mon, 24 Aug 2026 08:32:07 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.131.174])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 08:32:07 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v16 10/20] target/s390x: Support AES CTR for cpacf kmctr instruction
Date: Mon, 24 Aug 2026 10:31:54 +0200
Message-ID: <20260824083204.40877-11-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824083204.40877-1-freude@linux.ibm.com>
References: <20260824083204.40877-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8c018c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=LQnWXxm1RwZjr7XDrSkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3NCBTYWx0ZWRfX6rQp9XJyLE5d
 2BFPNZLhBOvvd0ZplCiEUJSOuEfPuwep/I1Qe91zP9odIMD0yA/0D10BwAWw0sIYJolwdlGiaDv
 PK7gvnLnOle2NQQq7ABnp5WMnLhMW6s=
X-Proofpoint-GUID: AoDvKAUyMNECh-tUSHer97zCEoWXA8qY
X-Proofpoint-ORIG-GUID: AoDvKAUyMNECh-tUSHer97zCEoWXA8qY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3NCBTYWx0ZWRfX4jGPJxbFZMBi
 6khpT7WX5vABY07+40A/o8iANRyesttPWgSh48lU3S/HNeH846b8asTjDLizKwvBfyFNA2S+dma
 gJWezyWl/KXS2a1gLvLbMUngDR+LHKNph65swC5ZGkrzO3Rp4R+zIKEHulsgFUm3OAIsxY984Q6
 dQ6BQFZpuBgV+uFTcsxFlm5R1fzOhHn+sg6sQwLJ+6tWI4VVg7VDV19a6DZxna5EtM0fG/XMFnc
 jH4dKYnw3gbw4uRke0gKfB3oxY/8ZSH+1GYhOr2EPXZ52EY44Rq1roLceDAcQ4a1Wa/0Bl2RdBZ
 kA7vRY2AAtwIQqlaH/C7XG91kwv8ByoBF79noOBvNZKoqBqBiAxCPSDVacdQ/1YyLrXE4lT4yuS
 GWHwIkRuW0Y3Y7CBKIHqne4VjihrqCJCq4IMCHBrdvutH/wAJII/bTU2oiB5RaMxa8VCwDWYYWs
 ft9+KO6UuiIaobIKOQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240074

Support the subfunctions CPACF_KMCTR_AES_128, CPACF_KMCTR_AES_192
and CPACF_KMCTR_AES_256 for the cpacf kmctr instruction.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/gen-features.c      |  3 ++
 target/s390x/tcg/cpacf.h         |  5 ++
 target/s390x/tcg/cpacf_aes.c     | 82 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c | 24 ++++++++++
 4 files changed, 114 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 2dacc65995..3281037958 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -928,6 +928,9 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KMC_AES_128,
     S390_FEAT_KMC_AES_192,
     S390_FEAT_KMC_AES_256,
+    S390_FEAT_KMCTR_AES_128,
+    S390_FEAT_KMCTR_AES_192,
+    S390_FEAT_KMCTR_AES_256,
 };
 
 /****** END FEATURE DEFS ******/
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 7dde122879..a78ddc2821 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -27,5 +27,10 @@ int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t param_addr, uint64_t *dst_ptr_reg,
                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                   uint32_t type, uint8_t fc, uint8_t mod);
+int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                  uint64_t param_addr, uint64_t *dst_ptr_reg,
+                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                  uint64_t *ctr_ptr_reg, uint32_t type,
+                  uint8_t fc, uint8_t mod);
 
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index c937514e9b..474516bb5f 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -226,3 +226,85 @@ int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return !len ? 0 : 3;
 }
+
+int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                  uint64_t param_addr, uint64_t *dst_ptr_reg,
+                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                  uint64_t *ctr_ptr_reg, uint32_t type,
+                  uint8_t fc, uint8_t mod)
+{
+    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
+    uint64_t len = *src_len_reg, done = 0;
+    uint8_t ctr[AES_BLOCK_SIZE], key[32];
+    int i, keysize, addr_reg_size;
+    AES_KEY exkey;
+
+    g_assert(type == S390_FEAT_TYPE_KMCTR);
+
+    switch (fc) {
+    case CPACF_KMCTR_AES_128:
+        keysize = 16;
+        break;
+    case CPACF_KMCTR_AES_192:
+        keysize = 24;
+        break;
+    case CPACF_KMCTR_AES_256:
+        keysize = 32;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    /* check addressing mode, raise exception if not supported here */
+    addr_reg_size = get_address_bitsize(env);
+    switch (addr_reg_size) {
+    case 64:
+        break;
+    case 32:
+        len = (uint32_t)len;
+        break;
+    default:
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    /* early bail out if length is zero */
+    if (!len) {
+        return 0;
+    }
+
+    /* length has to be properly aligned. */
+    if (!QEMU_IS_ALIGNED(len, AES_BLOCK_SIZE)) {
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    /* fetch key from param block */
+    read_guest_wrap_u8(env, mmu_idx, ra, param_addr, key, keysize);
+
+    /* expand key */
+    AES_set_encrypt_key(key, keysize * 8, &exkey);
+
+    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
+    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
+        /* read in nonce/ctr => ctr */
+        aes_read_block(env, mmu_idx, ra, *ctr_ptr_reg + done, ctr);
+        /* read in one block of input data => in */
+        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
+        /* encrypt ctr and xor with in => out */
+        AES_ctr_encrypt(in, out, ctr, &exkey);
+        /* write out the processed block */
+        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
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
index 7368c25e5d..3135974234 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -140,6 +140,27 @@ static int cpacf_kmc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     return rc;
 }
 
+static int cpacf_kmctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                       uint32_t r1, uint32_t r2, uint32_t r3,
+                       uint8_t fc, uint8_t mod)
+{
+    int rc = 0;
+
+    switch (fc) {
+    case CPACF_KMCTR_AES_128:
+    case CPACF_KMCTR_AES_192:
+    case CPACF_KMCTR_AES_256:
+        rc = cpacf_aes_ctr(env, mmu_idx, ra, env->regs[1],
+                           &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
+                           &env->regs[r3], S390_FEAT_TYPE_KMCTR, fc, mod);
+        break;
+    default:
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+    }
+
+    return rc;
+}
+
 static int cpacf_ppno(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                       uint32_t r1, uint32_t r2, uint32_t r3, uint8_t fc)
 {
@@ -214,6 +235,9 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     case S390_FEAT_TYPE_KMC:
         rc = cpacf_kmc(env, mmu_idx, ra, r1, r2, r3, fc, mod);
         break;
+    case S390_FEAT_TYPE_KMCTR:
+        rc = cpacf_kmctr(env, mmu_idx, ra, r1, r2, r3, fc, mod);
+        break;
     case S390_FEAT_TYPE_PPNO:
         rc = cpacf_ppno(env, mmu_idx, ra, r1, r2, r3, fc);
         break;
-- 
2.43.0

