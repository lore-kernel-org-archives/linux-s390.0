Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B092EDD6B;
	Mon, 27 Jul 2026 14:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161163; cv=none; b=X/6gXoZtrhnpY4aQpiFBqfaB1gvmWC7wY97F60XYrOuNPamiD4GKTMkxlu8/B09A7RRD7NqG2zHy3nDOXk1yUVO8+JiPcy1Kqb0c4wG/o/ntFSkVRmhZ/EDGEHalkiVqom8m7zPRCbPNBTvlA9mLzHGQB7FbB0LMBlir+Zcby7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161163; c=relaxed/simple;
	bh=L3mWDtGysR4pJqHCKF4sxqcH6KSbYFX6IZuYu6aSHIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HT0sEHgpcUAoMzC2zMMOnksxj9/Mh5YJ7UBifv2vIxfKgQF/4aEkMYT3SdSjbZAxb/svLUd4LfazHO/4PdiZZTb9Am4ViswNuZNuGU5ErpwH2nY9cjQvLaT3hRevmah9X1kYyyawW26l410BRQmmI7io4z7FGAKUlObp5ZnOS9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jICCsBx2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jICCsBx2"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDndU52298995;
	Mon, 27 Jul 2026 14:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PwoGMUALkYTalcbpa
	tb6npKl5m0IVCUG457Cs7GADfQ=; b=jICCsBx2TDfo2r5jXGQTZNEE9wADrmPNe
	HZxOpCQGm6d+YN4+aAhzj4u+Ebn1tyGa+R+I+BRl4xj3NuGGTdD+JGqB/gq+StIA
	b5uekH+jkN0O4LYKlXKwuYre+WRyddlCFXI12wCCHmIQiK0XacHV6MI5ebAML4aS
	KYRKafQvszAVDlKE5ylUddzaQnlzta0T8TLIcnyEOMC1P/ZIY9pAXVFk4DvkNmgh
	Jq+Ob3CT1Ef4jQpaPUBjBVreVbZnN9Tbso/loNuzXVqhFTacPtxzCnIHDheTJtzK
	8PfSD1VKVPz5YV6srJyp2hPwH//wmi9Xbp1PZ7ZE8QO+Qh3STBPfg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyhyy1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 14:05:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RDua7e005516;
	Mon, 27 Jul 2026 14:05:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq5tp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 14:05:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RE5bw552625738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 14:05:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FEA820082;
	Mon, 27 Jul 2026 14:05:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B3512007F;
	Mon, 27 Jul 2026 14:05:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 14:05:37 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Stefan Schulze Frielinghaus <stefansf@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Dominik Steenken <dost@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Maxim Khmelevskii <max@linux.ibm.com>,
        Jens Remus <jremus@linux.ibm.com>,
        Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: llvm@lists.linux.dev, bpf@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] s390/bpf: Add kCFI support
Date: Mon, 27 Jul 2026 16:05:12 +0200
Message-ID: <20260727140514.116501-6-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727140514.116501-1-hca@linux.ibm.com>
References: <20260727140514.116501-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzMiBTYWx0ZWRfX+tK/lfh/GJcK
 mHx1jN6bKBuO7PM9NeqT4r4kzXpL1dgOA/CJhAOW0REmmNkdejxeVbJ0e7GR1RVFUhZaUZJzucY
 k981HwdZI/Vr43SMLTxndVFqLN2Injo=
X-Proofpoint-GUID: ceu7hCuVmu3tBHp6ehWpQpkZ-ImfniDX
X-Proofpoint-ORIG-GUID: YHworiecHjWE6iMFClfewBXCR_GteaJG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzMiBTYWx0ZWRfX7Z4EpHEERBko
 YpFd7CH0Jap0kSvhqz2TynP+4XcdvI8BDjr7fB8yzgpSW2nkuTi47InhrqfJkKBNTvVuiiZE7Vy
 18nVOLTCjMNcr1VbiSpKBoxcJMZFIiIRjRbpNRH3pwV445FYkC0WRbo8BrqDU0hBdfPkoJyaNlY
 lizOSHKHeVavOB60bwvw1myjhbDmBEge9s68Oq1DP/6LUnCDYVftyzBT9FurRddMPsGqUU7zFba
 fiqVJMLSf/ANcl0hXV71LRsuzuogRRpuNM17f8jNThD0T7yR6RSHhwDWiLoY0LVWYkn9vMTKuzT
 6dnyDt0ccbvFemeLx2wSzRZ7xl5fUzcdSkdXHbzRrcrrX6NCRI5l8lHV6mTkxw4o84dg1TnEUkO
 IVN3jqr2eUVUj8ScAb6ZFhZk7QrLdEzrpuHicoqA5XKsntVF1Z54dUKPQCLtWK96YQRjrg9zQiP
 VAEK2siuAQpPgmBX7JA==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6765b6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Mj8nGTbcY6PlKodxJdYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270132

This is the s390 variant of commit 710618c760c0 ("arm64/cfi,bpf: Support
kCFI + BPF on arm64").

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/cfi.h  |  7 +++++++
 arch/s390/net/bpf_jit_comp.c | 28 ++++++++++++++++++++++++----
 2 files changed, 31 insertions(+), 4 deletions(-)
 create mode 100644 arch/s390/include/asm/cfi.h

diff --git a/arch/s390/include/asm/cfi.h b/arch/s390/include/asm/cfi.h
new file mode 100644
index 000000000000..9af2c7cb70ca
--- /dev/null
+++ b/arch/s390/include/asm/cfi.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_S390_CFI_H
+#define _ASM_S390_CFI_H
+
+#define __bpfcall
+
+#endif /* _ASM_S390_CFI_H */
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 31749c0362ca..7f45c106444d 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -21,6 +21,7 @@
 #include <linux/filter.h>
 #include <linux/init.h>
 #include <linux/bpf.h>
+#include <linux/cfi.h>
 #include <linux/mm.h>
 #include <linux/kernel.h>
 #include <asm/cacheflush.h>
@@ -356,6 +357,19 @@ static void emit6_pcrel_rilc(struct bpf_jit *jit, u32 op, u8 mask, s64 pcrel)
 	}							\
 })
 
+static inline void emit_u32_data(const u32 data, struct bpf_jit *jit)
+{
+	if (jit->prg_buf)
+		*(u32 *)(jit->prg_buf + jit->prg) = data;
+	jit->prg += 4;
+}
+
+static inline void emit_kcfi(u32 hash, struct bpf_jit *jit)
+{
+	if (IS_ENABLED(CONFIG_CFI))
+		emit_u32_data(hash, jit);
+}
+
 /*
  * Return whether this is the first pass. The first pass is special, since we
  * don't know any sizes yet, and thus must be conservative.
@@ -597,6 +611,8 @@ static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp)
 {
 	BUILD_BUG_ON(sizeof(struct prog_frame) != STACK_FRAME_OVERHEAD);
 
+	emit_kcfi(bpf_is_subprog(fp) ? cfi_bpf_subprog_hash : cfi_bpf_hash, jit);
+
 	/* No-op for hotpatching */
 	/* brcl 0,prologue_plt */
 	EMIT6_PCREL_RILC(0xc0040000, 0, jit->prologue_plt);
@@ -616,7 +632,7 @@ static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp)
 		bpf_skip(jit, 6);
 	}
 	/* Tail calls have to skip above initialization */
-	jit->tail_call_start = jit->prg;
+	jit->tail_call_start = jit->prg - cfi_get_offset();
 	if (fp->aux->exception_cb) {
 		/*
 		 * Switch stack, the new address is in the 2nd parameter.
@@ -2401,11 +2417,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 		jit_data->ctx = jit;
 		jit_data->pass = pass;
 	}
-	fp->bpf_func = (void *) jit.prg_buf;
+	fp->bpf_func = (void *)jit.prg_buf + cfi_get_offset();
 	fp->jited = 1;
-	fp->jited_len = jit.size;
+	fp->jited_len = jit.size - cfi_get_offset();
 
 	if (!fp->is_func || extra_pass) {
+		for (int i = 0; i < fp->len; i++)
+			jit.addrs[i] -= cfi_get_offset();
 		bpf_prog_fill_jited_linfo(fp, jit.addrs + 1);
 free_addrs:
 		kvfree(jit.addrs);
@@ -2671,8 +2689,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		return -ENOTSUPP;
 
 	/* Return to %r14 in the struct_ops case. */
-	if (flags & BPF_TRAMP_F_INDIRECT)
+	if (flags & BPF_TRAMP_F_INDIRECT) {
 		flags |= BPF_TRAMP_F_SKIP_FRAME;
+		emit_kcfi(cfi_get_func_hash(func_addr), jit);
+	}
 
 	/*
 	 * Compute how many arguments we need to pass to BPF programs.
-- 
2.53.0

