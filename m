Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EA526CE1E
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 08:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782288660; cv=none; b=PWCh2pWytSqpOM7TR6W8oROMAXSnBdI9zfRew14FDDd0o+BQd0padFmgJVmkJagkB+gOS5Zbo173W8I75XEo+biBBVgfswlNEId4ZCZ4I1uqWWx+p4Y1U373QnPPCNM+wO8RmWP4HoMPMZh33ORMc1P+7OFBouLQJ9R1NaJqmqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782288660; c=relaxed/simple;
	bh=DN12EP5jZwhnCF1O9jkFEEisrhm2u7ORfETLtnMTlMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4SM0Wdq1uHMeIu43uII9lBxyNyEUGjXN9/12bTpVT0/e5yYeCYpnrwv8ZC8hW3HK9X3vtH4j6cbjkkpLYDgm/fPRe7QGXbHuKuHaEvZgQEBFEKWhEATL7tISSGubNxHMIyAK/V18re0YytKeyy0ffzUwQ9n3iTpuwXB7qGTm/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a8967yK7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a8967yK7"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O6IIIh076000;
	Wed, 24 Jun 2026 08:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fx6ytMVNMYiqiEiCX
	7kqZ8VYxZAIiHU6qgMiRnXXTDc=; b=a8967yK7j4m8oZJ7DYx0cmFS0/RoQzH9x
	Z5Opk4EPsWEvVe/OKj+/Q5GuSIE37uaPFfh2DNxWeO8+59kH8Ft1nDPiVdkxnGIO
	qCeyz/1gr7zqNbjwadZdfMLZGvKNaGOD3VO8VJdJSjuKtLfto3G+lJdh3Uuru+Gq
	58T/Nznns+Mnc4/H6OrGARDhWbDUA1LUmVFdhFk0ybOUVZbSMsAV61MweTNOqfTt
	c76W+IJT/GAwIUqDNcI4alnNJ4B/pXzHAkT0nmbINavI+ZUiGup+jxnaicXdNOmc
	+7jnQm/neAXA391UR+h0y+XRa5biFlrF8OM9w/fdf0Qqq6w0AmqXA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4k271-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:10:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65O84hqO010081;
	Wed, 24 Jun 2026 08:10:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qfsu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:10:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65O8AYoH34931164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 08:10:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F92020040;
	Wed, 24 Jun 2026 08:10:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E18F2004D;
	Wed, 24 Jun 2026 08:10:34 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.224.92.54])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 08:10:34 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v8 14/18] target/s390x: Minimal protected key AES XTS support for cpacf pcc instruction
Date: Wed, 24 Jun 2026 10:10:11 +0200
Message-ID: <20260624081029.23815-15-freude@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfX6Z3GtMpexi6b
 MZwRxbkaiZv6IUFb26wAKVy/tsdZ2f+gsEw52pum9W0yIk+F+J3HsFGXjL31GO0ndoqXo1r5/rO
 CbpNTeWeFGULT/UEVrU8vshGJF75E+I=
X-Proofpoint-ORIG-GUID: ce4lU8E_laSgPBlS6Hu4dD-d4Gv0NJZE
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3b90ff cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=EmLOupEv2CnJZljdqbQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfX5d+nKgg+pk9v
 2CrQylyNfNjPNSW2JOkDxfyLOC26O83bcKqQSNejvJRMC0EH/KWQf56KGfpJ0Uo8qwl5wzW8O0f
 /bDBNTD1ZojG9I8Wss6Zad09M+BUJ+86+GOq+yfzFPkmwdv62EYnsIIbs5Qyci6LU/rMbBWMQOJ
 YXFAHQB8XwTG254Jy0zzZs4XGshPgXsm7P85KfYpRMAieDKiYGFr3qyP5I2zAvlMtSJjQELfzf9
 Y003M6Q+eMrnI3uC4Je1oiUm4QOQ7ZuBzOWMu8qTD1X/UZ8e+H9cW9OyHo+KdF/YQ41XqGnLdrv
 GKzDHUbnMZSsMfAQX9OrkcluyKpn+4Mp4Zg5JU2oOcna+iWCXDkr5q/g6PQnNYvvR5fIr8oHdve
 A1S5G/qX0jonsmxY3sYQ+gyO3u2G5yA8w21NhcT5BVGE1Ot35AugAaBuuaJPWoURc0XQUlU8For
 0/zPQbDfoCSOjIEtMsg==
X-Proofpoint-GUID: ce4lU8E_laSgPBlS6Hu4dD-d4Gv0NJZE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240063

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
index 00256dad50..afef5240f8 100644
--- a/target/s390x/tcg/cpacf.h
+++ b/target/s390x/tcg/cpacf.h
@@ -56,5 +56,7 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                    uint64_t *ctr_ptr_reg, uint32_t type,
                    uint8_t fc, uint8_t mod);
+int cpacf_paes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint8_t fc);
 
 #endif
diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 901068166f..672e8b5983 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -825,3 +825,80 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
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
index 38866423c7..00dded126c 100644
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
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
-- 
2.43.0

