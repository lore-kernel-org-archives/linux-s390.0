Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9993363C5F
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773569; cv=none; b=JESVpia8lbbSwdCpk5FFGQ3+NXNgUyXxxHZNH6YcYjVYBki4rGIbKUKxMgfG60tgBQQrkUoeJLY5yVRRuFfkCLj9RJouyxxoUQFZfLP3A/syVXyS2JcRXLsRWWkjpZGaCMlMDgpSw3nkVhcFvhSh5/MG40JUxtFKbZRI/IMDrik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773569; c=relaxed/simple;
	bh=sQDet/EP30TWLTAxZVOf7BFcPxPA0ZUEhLrXe7sMk1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdZSqWrgo9LOtw0zn2K6ItmHtiePVx/WIpgeblHWDuTiWrW7CB4SIqZC3FhkWQQC6G54mYRALq4d7k9Te0htbpZtigNe7JNRxXpz35E0aMiX8af44Pzs8J8R/mWyyzPTei3dcMaee+RwIy/fFaCpeO7ayAysiFaVSu/rqIDn2e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=At33l9QS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="At33l9QS"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHnIi2341470;
	Mon, 3 Aug 2026 16:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xmtUOuir1wK9KwGxE
	8LbYVIlgP621HqP3y7rRVPlQZw=; b=At33l9QS8UPR9AzOhIUpzUZzhJoB1uP9t
	qa8wPVl8kgwNPqFe0p6HgwMQrGCx+BULM9QYcR8EoO21eTy/XxSRtgyaQcIoGHNt
	6rg/we7wLG/EUTtaMNX2tTtLsve8G/oTteG63vKg38dYTXmvXltsB/gIPfXH9EQy
	fW6MobhXftHNL2UlUEwrC9Bm0h7hsXbzWComWweF64S64MOB1bv5PLTj78mMgylI
	1HsuR7eykC94AajKb6gYrpS2AGkzR293xLyS/Mo0zUVnkE6N7Gr8KiqkLqsMsCca
	torLby9S8Ap+JkInHSJbnik5Tg5wrfB8pa5ORRuM/9W87+Xo/+rVw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8euhbvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:12:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673GBSRT012089;
	Mon, 3 Aug 2026 16:12:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4jx6am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:12:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673GCX7U19858058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 16:12:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEF9F20043;
	Mon,  3 Aug 2026 16:12:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 849D02004E;
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
Subject: [PATCH v13 15/18] target/s390x: Minimal protected key AES XTS support for cpacf pcc instruction
Date: Mon,  3 Aug 2026 18:12:32 +0200
Message-ID: <20260803161235.228704-16-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: C7DaaF6rF6_jyRdHqTZQar9szG10hh4b
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX3YmWVzdaUf97
 d3JmWgHl5IAG+Qgg8u1BK/kBWMJJZsKYr6LdKwyLyV+eE8/xzZWK1nnnODH0r0RLCcoI6YKoNns
 DqCwdkhumBrlJ/nAAhrTMjO0DCHNHV4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX2svY07E7HKtb
 yDyFjIrRUefZJfzOYBPHjiOhtGgRL6IFML8Ppb/iqFtqXb0lXCXf9s6GYM9+PA5qsFzyGymRVtM
 ttFiVqsbiGXanPFzR920rKcH0lBA0lt6GMbB5MhhPv3BjxS3b/ed3lQZgO7cqU3chjcYMWdCJmr
 mtSPHzZEr8g/QKTssogxYJwXaJhxA3yQMu6PmcAaORIwCXV7ZLWgtJZNrPZdJm8CX0fGSCOVm8a
 7FwzZW9TPwPgaCFO7KQj+3zu/Vo3iZvJ73wXam0CA2SAFbe+oK/pPFEWuIrnBfZiMz19iMS8pAk
 8bs6jbSs1xQ/W0Lx/0OAxz5hZFUbtpsHWACBTwpj3cYk3g5LdQOnevCtNkUKV+dgcORkq/HeFCp
 TUKQhrZCKzl8Re4JDSvp8jVYFfva8F598fOotVBIxERP78aFE7XQdFjlWJs5UsI/wokT+pKkwSa
 pIlfQNjCxhQgHyRc6bQ==
X-Proofpoint-GUID: C7DaaF6rF6_jyRdHqTZQar9szG10hh4b
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a70bdf6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=tkYQr5ag8MGam-WK_qUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141

Support CPACF pcc subfunctions PCC-Compute-XTS-Parameter-Encrypted-AES-128
and PCC-Compute-XTS-Parameter-Encrypted-AES-128 but only for the special
case block sequential number is 0. However, this covers the s390 PAES XTS
implementation in the Linux kernel.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Tested-by: Holger Dengler <dengler@linux.ibm.com>
---
 target/s390x/gen-features.c      |  2 +
 target/s390x/tcg/cpacf.h         |  2 +
 target/s390x/tcg/cpacf_aes.c     | 65 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/crypto_helper.c |  4 ++
 4 files changed, 73 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 9898f880a6..6b206cee83 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -944,6 +944,8 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KMCTR_EAES_256,
     S390_FEAT_PCC_XTS_AES_128,
     S390_FEAT_PCC_XTS_AES_256,
+    S390_FEAT_PCC_XTS_EAES_128,
+    S390_FEAT_PCC_XTS_EAES_256,
     S390_FEAT_PCKMO_AES_128,
     S390_FEAT_PCKMO_AES_192,
     S390_FEAT_PCKMO_AES_256,
diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
index 71a2c6b914..1786a21f83 100644
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
index 18d8e2299b..d1f3b44a15 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -714,3 +714,68 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     return !len ? 0 : 3;
 }
+
+int cpacf_paes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                   uint64_t param_addr, uint8_t fc)
+{
+    uint8_t key[32], wkvp[32], tweak[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
+    int keysize, i;
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
+    read_guest_wrap_u8(env, mmu_idx, ra,
+                       param_addr + keysize, wkvp, sizeof(wkvp));
+    if (memcmp(wkvp, protkey_wkvp, sizeof(wkvp))) {
+        /* wkvp mismatch -> return with cc 1 */
+        return 1;
+    }
+
+    /* fetch block sequence nr from param block into buf */
+    read_guest_wrap_u8(env, mmu_idx, ra,
+                       param_addr + keysize + sizeof(wkvp) + AES_BLOCK_SIZE,
+                       buf, AES_BLOCK_SIZE);
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
+    read_guest_wrap_u8(env, mmu_idx, ra, param_addr, key, keysize);
+    /* decrypt the protected key */
+    decrypt_protkey(key, keysize);
+
+    /* fetch tweak from param block into tweak */
+    read_guest_wrap_u8(env, mmu_idx, ra,
+                       param_addr + keysize + sizeof(wkvp),
+                       tweak, AES_BLOCK_SIZE);
+
+    /* expand key */
+    AES_set_encrypt_key(key, keysize * 8, &exkey);
+
+    /* encrypt tweak */
+    AES_encrypt(tweak, buf, &exkey);
+
+    /* store encrypted tweak into xts parameter field of the param block */
+    write_guest_wrap_u8(env, mmu_idx, ra,
+                        param_addr + keysize + sizeof(wkvp) + 3 * AES_BLOCK_SIZE,
+                        buf, AES_BLOCK_SIZE);
+
+    return 0;
+}
diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 155c06ee4c..aa27889d97 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -207,6 +207,10 @@ static int cpacf_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
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

