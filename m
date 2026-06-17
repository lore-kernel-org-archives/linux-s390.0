Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8913339FCCD
	for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689722; cv=none; b=TYDomvPj51Pse75Bz05psUmb5FxZqmJJ0oex/EYKAq/pRFfQtp+GndUcYyYadW1WPLSFkgXoMvK4OmWXegFPetKghAoKMxpFfT9P6hzvGi+eDHki4MMqb6U/qTlkgnzc0Me+dvqanjVgyzaEQiYOQqMEsAt1QNTqpE4qAMWZfPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689722; c=relaxed/simple;
	bh=G1snoC1cPFSSm3wFyynr9Pw86L3tSyFcQ3nIDwzC6Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LE0IwvLJAN/LSBV09WpQJcmCFNLYqpxr1M7fs1c6a4fwoKjvzAF+bVxYVQR1dUZ4IeXCijwewRDwk57/wqiNZpjUrcKfProh4pcOZy5GH9kg4xHUbLgq5mAKOJLYrrZL4P4vdAcSvLGYLXzyh3kL4Z0PJmgr25o2+Y7YDGxpbtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cWBOjDml; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cWBOjDml"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8mCll4127403;
	Wed, 17 Jun 2026 09:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=D0VTBmwG+lNkTQBna
	RhIO6fTpKHA1rPxk3P40axmOxE=; b=cWBOjDmlJPezth3qAJ1lzhsF2frVLwUpS
	z1myRejc0IkbxINBwWNi8QzhXssMld/8yIy6WtDlSV3ZdvuEWx16eVh36GRH/kOF
	ggF98Hp9KmgK4ieZ3BZHkGRl14oCJERjNLIh+zlrejsml3Up34pb71aRbEby9etO
	5aBcqe+kW4N5ssVbQRGpvZE5Et7Oc24lFaZcZcHeApKxsKtU6YjnZBqAZfyU541R
	FUUFdwcr3VlZOk7gCZGsWnYGnbO/1kikLt+sIdUDHfNt3lP3DSSQE+7eazNhOqzW
	pCBx+AXdtE5/xAfcMesYTm4nk9T8FLid+O3mlyYTzaMyqv6WHDfaA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqtj9b7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 09:48:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H9YrUR022641;
	Wed, 17 Jun 2026 09:48:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eudva2h5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 09:48:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65H9mOAJ50332056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2026 09:48:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1D4120040;
	Wed, 17 Jun 2026 09:48:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4FC12004E;
	Wed, 17 Jun 2026 09:48:23 +0000 (GMT)
Received: from funtu2.ehn-de.ibm.com (unknown [9.224.92.54])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Jun 2026 09:48:23 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v7 13/17] target/s390x: Minimal protected key AES XTS support for cpacf pcc instruction
Date: Wed, 17 Jun 2026 11:48:16 +0200
Message-ID: <20260617094820.34402-14-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617094820.34402-1-freude@linux.ibm.com>
References: <20260617094820.34402-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WBLSxx6GLsMhqf9QEG3OpmrDfR-RpuhO
X-Proofpoint-GUID: WBLSxx6GLsMhqf9QEG3OpmrDfR-RpuhO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5MiBTYWx0ZWRfX+sely0I1b6+G
 dzqqutBw/84nU3ku0zg7bRp2+WORlpOAPCS8ImoAVH+qlFyAXyw80Dfzwbin6ZzuUXvWb9W3q7L
 c5HgggOX98w4nw+nZTAiiFTd06eWSUzFWwPWJM4D1GRlov7UEYy8HZoEpeAeTSyP2+0qEDVDWkg
 McB/KPCp7lBADXsbIbOtdeIph5Fn1C2xy+W9kBgUbMKlIwlT3PwH3vDTYj/pQoNctBZ3ZoHpLPB
 tgI5dGQ3gE9Ks462Gej2HoPlzQ+XmZACXw2PJZIs1rGVKCtoThKK8Q/iCqw4qL5r/tgmzo9cfBj
 Bh3hS63D+3JdxcqJr1l19XLiO8TtH30wcSMCzCps3jIo0MnBF4Y2IyEdzGpxgNAsEGohZqDuwsY
 WPnaYif7GgVC+sQgRPq0Cg1swy7TvXU6lufXgTzwyGp7E7s6h8b2K8zlZ4qmUAHGwq/aSASQyYd
 SCgTfO1XMSH+YIbwaMg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5MiBTYWx0ZWRfXzGS429GvU9wN
 pmPngxJDTNP7KDgUzt0WIRAU6mcJRiA/vS9g5K3OAKWbX7Ab0Esjd8WGfOPBnkCAk6JpoBT4gOO
 kVJwVBoysrVF5/yO7nUD5TqwJb4t4n8=
X-Authority-Analysis: v=2.4 cv=B4KJFutM c=1 sm=1 tr=0 ts=6a326d6c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=zQyVPUQHs5nwjg34eLYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170092

Support CPACF pcc subfunctions PCC-Compute-XTS-Parameter-Encrypted-AES-128
and PCC-Compute-XTS-Parameter-Encrypted-AES-128 but only for the special
case block sequential number is 0. However, this covers the s390 PAES XTS
implementation in the Linux kernel.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
---
 target/s390x/gen-features.c      |  2 +
 target/s390x/tcg/cpacf.h         |  2 +
 target/s390x/tcg/cpacf_aes.c     | 80 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |  4 ++
 4 files changed, 88 insertions(+)

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
index 223bada622..6df474fbc8 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -53,5 +53,7 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                    uint64_t *ctr_ptr_reg, uint32_t type,
                    uint8_t fc, uint8_t mod);
+int cpacf_paes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint8_t fc);
 
 #endif
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index ffa286d422..d454d6f302 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -819,3 +819,83 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
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
+    case 0x3a: /* CPACF_PCC compute XTS param Encrypted AES-128 */
+        keysize = 16;
+        break;
+    case 0x3c: /* CPACF PCC compute XTS param Encrypted AES-256 */
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
+        cpu_abort(env_cpu(env),
+                  "PCC-compute-XTS-param (encrypted) with non zero block seq nr is not implemented\n");
+        return 1;
+    }
+
+    /* fetch protected key from param block */
+    for (i = 0; i < keysize; i++) {
+        addr = wrap_address(env, param_addr + i);
+        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
+    }
+    /* 'decrypt' the protected key */
+    for (i = 0; i < keysize; i++) {
+        key[i] ^= protkey_xor_pattern[i];
+    }
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
index 60c3ebd79e..38f7d900fa 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -206,6 +206,10 @@ static int cpacf_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     case 0x34: /* CPACF PCC compute XTS param AES-256 */
             rc = cpacf_aes_pcc(env, mmu_idx, ra, env->regs[1], fc);
             break;
+    case 0x3a: /* CPACF_PCC compute XTS param Encrypted AES-128 */
+    case 0x3c: /* CPACF PCC compute XTS param Encrypted AES-256 */
+            rc = cpacf_paes_pcc(env, mmu_idx, ra, env->regs[1], fc);
+            break;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0

