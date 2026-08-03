Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10333659F9
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773571; cv=none; b=XRFRobrl6htetVCTXpH90u0VCcYhXkb9lIfnv3QuRxgIGtQ3MXRf+rnPGdjvbC7EDq48lW3HXjwgui3x3m7ktwiDNhjHSIqfmfDmRGRz4sZJHm+urx6V8d83ohveonL6DDPL7rtgM/EeK43Om5B24nMc6us1AAzdtkZVnljcjis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773571; c=relaxed/simple;
	bh=89y3aHR/5/Zb48RgVV2+rk4gxTVzUvBWmnthg89zR8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enwExsnBxRXD5fwh70jaAunTLe472c2GrfwjYRjEw6o6LZ/QgLNEDQmVDhgyK7xoasJG+Gx14Rydk0zo9erRfdoXvNBMLMETi4Ph+Qn4KhDYao85VaSviY0oF4WrXa2HHaFfNAGf4W/Yl5Cfy9DuciJSWHakhRCJ1i7id0h1SNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pVFiYj28; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pVFiYj28"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHUbd2282318;
	Mon, 3 Aug 2026 16:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=H4M5B8h1itkJgYltg
	1tv4u9TB8rC0J+torP0XHYxLrw=; b=pVFiYj28V1KBJ3tSj+GX19kqweYTq/ses
	xabtnXm1UVfV+UZkbdpP4e2dZKk79EyHpDGL5qbrSUZPHz/1E8BasBVPj5dyKNFe
	5aNXZKHZ4LpynGbehev0IQM4whmM5NwBS9wjsjAMFnNpIMqVxxgYDYNovlyj0e0k
	SCYzQn6SKzHoXLJTqoS4AVoGi46v5qvVAPWAi4nNd4ytp5A0thG8hcBQwMpRZvUk
	ro36cPosrn4ySqamDuskw2REqk2csaekZOGubeqQUO/oxJ2iO5kYzhySxPHNNM33
	XWXBIPTq+GZb9w+xG9yRPiB4ir6eDTLlXoZW2S9WgD6JhI5ZnRUgg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4sqv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:12:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673GBEWc008934;
	Mon, 3 Aug 2026 16:12:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg5yat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:12:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673GCYL211272664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 16:12:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE42A2004E;
	Mon,  3 Aug 2026 16:12:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B508C2004F;
	Mon,  3 Aug 2026 16:12:33 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.207.251])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 16:12:33 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v13 16/18] target/s390x: Support protected key AES XTS for cpacf km instruction
Date: Mon,  3 Aug 2026 18:12:33 +0200
Message-ID: <20260803161235.228704-17-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803161235.228704-1-freude@linux.ibm.com>
References: <20260803161235.228704-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfXyjk1LcQ6u0kB
 kaV1YcXDVxwB6Ki/RjhPz0VmSaZjWnoQIeddInoNNgm2CFXmDCL03SbiJtL3alwo6lYnkCjRgZz
 4u5dg0FF0H9+TiUxo3PQe0p4DGo5qKk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX3MADY0Pv98AK
 pX9MEau8T0tsVT+lYmCiXXNvRSN2z0jAWc+uZwoQ7poj59cGObOKPE11wZ4ee3ircjyywXrQfoB
 QjB9n0P+4V+0EVs2/cI2xPehsIF4s7TtDe2ITYdsihoH6Gz7U5afCtRVbIEIH1KKbIrz0Ag3cPx
 lhV8jSnZdPsp6QSyhPf6rQypeRbIAmTEvGgoE0auamqxb83afwcchCutjLDJE01lz+6jjI0wKwp
 vWXiOhVqP0m9I8sMmiIRFaBh0OH0E4NRqD44Iev/m9/+aAhUAkUvddF7nY896LOYq3B+POFer1p
 m1vHnGxNjG1eAL0B4TCNt4x7myThi9RlL5oOM7NGD6qA/CeTzZXRECjaI/qmWgCRhtwPdIuggSS
 mqw1rS9BSiRJQrXgu0GOuJbp9Hja60Z8oQqIuQaCH/zsRvaZRxLQcQspXBufSioEiCN/WW5+zrv
 i5LN9u30PT+sIasJVxQ==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a70bdf6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=D0XGIOQStSI5JxgU9CcA:9
X-Proofpoint-ORIG-GUID: PhXIZejCWbIlVFdBDoGyW2EhUQj_eSII
X-Proofpoint-GUID: PhXIZejCWbIlVFdBDoGyW2EhUQj_eSII
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030141

Support the subfunctions CPACF_KM_PXTS_128 and CPACF_KM_PXTS_256
for the cpacf km instruction.

Tested-by: Holger Dengler <dengler@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/gen-features.c      |  2 +
 target/s390x/tcg/cpacf.h         |  4 ++
 target/s390x/tcg/cpacf_aes.c     | 93 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |  6 +++
 4 files changed, 105 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 6b206cee83..0afea9fdd0 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -930,6 +930,8 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KM_EAES_256,
     S390_FEAT_KM_XTS_AES_128,
     S390_FEAT_KM_XTS_AES_256,
+    S390_FEAT_KM_XTS_EAES_128,
+    S390_FEAT_KM_XTS_EAES_256,
     S390_FEAT_KMC_AES_128,
     S390_FEAT_KMC_AES_192,
     S390_FEAT_KMC_AES_256,
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 1786a21f83..d86d3b58f9 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -297,5 +297,9 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint8_t fc, uint8_t mod);
 int cpacf_paes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint64_t param_addr, uint8_t fc);
+int cpacf_paes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint64_t *dst_ptr_reg,
+                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                   uint32_t type, uint8_t fc, uint8_t mod);
 
 #endif /* S390X_CPACF_H */
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index d1f3b44a15..1de80a7a7f 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -779,3 +779,96 @@ int cpacf_paes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return 0;
 }
+
+int cpacf_paes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint64_t *dst_ptr_reg,
+                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
+                   uint32_t type, uint8_t fc, uint8_t mod)
+{
+    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
+    uint8_t key[32], wkvp[32], tweak[AES_BLOCK_SIZE];
+    uint64_t len = *src_len_reg, done = 0;
+    int i, keysize, addr_reg_size = 64;
+    AES_KEY exkey;
+
+    g_assert(type == S390_FEAT_TYPE_KM);
+
+    switch (fc) {
+    case CPACF_KM_PXTS_128:
+        keysize = 16;
+        break;
+    case CPACF_KM_PXTS_256:
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
+    read_guest_wrap_u8(env, mmu_idx, ra,
+                       param_addr + keysize, wkvp, sizeof(wkvp));
+    if (memcmp(wkvp, protkey_wkvp, sizeof(wkvp))) {
+        /* wkvp mismatch -> return with cc 1 */
+        return 1;
+    }
+
+    /* fetch protected key from param block */
+    read_guest_wrap_u8(env, mmu_idx, ra, param_addr, key, keysize);
+    /* decrypt the protected key */
+    decrypt_protkey(key, keysize);
+
+    /* expand key */
+    if (mod) {
+        AES_set_decrypt_key(key, keysize * 8, &exkey);
+    } else {
+        AES_set_encrypt_key(key, keysize * 8, &exkey);
+    }
+
+    /* fetch tweak from param block */
+    read_guest_wrap_u8(env, mmu_idx, ra,
+                       param_addr + keysize + sizeof(wkvp),
+                       tweak, AES_BLOCK_SIZE);
+
+    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
+    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
+        /* fetch one AES block into in */
+        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
+        if (mod) {
+            /* decrypt in => out */
+            AES_xts_decrypt(in, out, tweak, &exkey);
+        } else {
+            /* encrypt in => out */
+            AES_xts_encrypt(in, out, tweak, &exkey);
+        }
+        /* prep tweak for next round */
+        AES_xts_prep_next_tweak(tweak);
+        /* write out this processed block from out */
+        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
+        len -= AES_BLOCK_SIZE;
+        done += AES_BLOCK_SIZE;
+    }
+
+    /* update tweak in param block */
+    write_guest_wrap_u8(env, mmu_idx, ra,
+                        param_addr + keysize + sizeof(wkvp),
+                        tweak, AES_BLOCK_SIZE);
+
+    *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
+                             *src_ptr_reg + done);
+    *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
+                             *dst_ptr_reg + done);
+    *src_len_reg -= done;
+
+    return !len ? 0 : 3;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index aa27889d97..47176c78be 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -117,6 +117,12 @@ static int cpacf_km(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
                            S390_FEAT_TYPE_KM, fc, mod);
         break;
+    case CPACF_KM_PXTS_128:
+    case CPACF_KM_PXTS_256:
+        rc = cpacf_paes_xts(env, mmu_idx, ra, env->regs[1],
+                            &env->regs[r1], &env->regs[r2], &env->regs[r2 + 1],
+                            S390_FEAT_TYPE_KM, fc, mod);
+        break;
     default:
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
-- 
2.43.0

