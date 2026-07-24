Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C18439008;
	Fri, 24 Jul 2026 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902424; cv=none; b=Y/089lmEpKo5JGmwqX15C6Om+o/P9sxHl+H30peqXO1Legz7ySaexcDE+6KjX+uAr3mhmmoNMDTsR0kzHAumvVotwer1AEqJ18zrhUT6qNWk1BIqqUi0DvtqCGb6oUROjdHJF9Q8d59TjHW5NVPq6XwiG4WiQE3G1edz6PO8UDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902424; c=relaxed/simple;
	bh=qzdJEes+JcGSIMNS1SLAblNgi10KpFF/c7yicoMeH7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/JJWW5f2bxYwl2Pt0w96YAaw6O7wOjC+K+/1x6V/W8oUu6Nl/lj/wu7yMnSWft5LRLOaMKkJNFrf+glTiK1wL9kCqHIyc6sETxgg0Tc23Rj+NxSVvzLSxhjmhsDS7HC/BJVagkUQ6xdfQBtNB+kVK/ZS7bdF9LhgQEp5MBloiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f4ATmUMR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f4ATmUMR"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODfjd2100527;
	Fri, 24 Jul 2026 14:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3Gup2122irWeVTFwr
	bTkTPgiSdur334BEncEwPBZo24=; b=f4ATmUMRShIEZtlwU0newHMUk2nm/a+OS
	G8zZ1x7r8Iiw/DEVpOGEpivOsOkOCBp4MSyKYqAGXzU/HIIIrOJJo1TcaCeUQ/S6
	QSReaJQ2o0Nqg60ZgcEZ7M6iQ8KZjeoWXbXdREsTtu31glEvpuh6YZsqc/a22t0K
	m7zY3q2O7rGvROtqonaQRnrNdldOdTeGfrzPak6ZSmuoPq8SR+kuaWH1bMIHX5l0
	6gW5dLJKI3/7okeEvSbJ36OKJz7pRmAphBxMUDGjRCl0qcoFylgE18r/CXuiHXSZ
	jNTweATaJ3ogSR5ALiEBWc4BPa+PwZVncUGpI/Ua1cRFihMJm0kzw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8gs8arv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:13:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ODo3rv024916;
	Fri, 24 Jul 2026 14:13:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahh68x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:13:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OEDNPs47382922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 14:13:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54A4520116;
	Fri, 24 Jul 2026 14:13:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D68D2012A;
	Fri, 24 Jul 2026 14:13:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 14:13:23 +0000 (GMT)
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
Subject: [PATCH 6/6] s390/bpf: Add kCFI support
Date: Fri, 24 Jul 2026 16:13:18 +0200
Message-ID: <20260724141318.1037434-7-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724141318.1037434-1-hca@linux.ibm.com>
References: <20260724141318.1037434-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfX7s4hQFR6dyO/
 yU//FEHDsfBWnBBqkCBq2lorxL69FsSOuiYOtpa9iaxSzNw39yKMTJM/TcSBs65QBHyPslMPqu/
 1EVgBtJvVh17/ZoI7q6oUoCcL8mLfGM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfX51a4/FY8yNIo
 FVL7HF8JlpwBT7LKzlejFFd4zMyKPkeP45Bi9FL7xVV3dhik26/tcMN3JCxyKR6yvSr3xHxjGjd
 Bmd+7PhYWfY3V2+Zggr6Nj1N9CkOcIvdHFkUc8RBG7rdTUrlx5SWGLijavEw/mgrfpnDaNYNiO7
 0hghr83sYnH+SB9MuPCBTio7LONhrM5zNwdvBtbSqelrJiKUHogbSRXE/y5hWnbyFYR6MKqk1+x
 2fAy4M/sFoWNFRnccBbOVs1BRl3HvQUddmG6R++Z3EPcZm04onDdknVe7oeaadrqcyMkh6Z827+
 1/uMPM3DaTG/ozo8YLR4Cg+g2kWEjRl/k7/QZVugoTBNVNASMjVfggra8opm7KRGLqBEH/Q33VW
 ehY7osXKO4YQ7VNouoxq0vvEzMrvEENlcZ4iC6mNPnMRlz2RJUrUwNEOe4mCFuls6h7LaexdS5m
 VMFU9xtgT8EHVZhqUyw==
X-Authority-Analysis: v=2.4 cv=Q9LiJY2a c=1 sm=1 tr=0 ts=6a637309 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=bPLy7VutBQud47ZB1NcA:9
X-Proofpoint-ORIG-GUID: oMa11n_Y9UKCYcPNaaYAs0qJMEEvpXng
X-Proofpoint-GUID: 6xkqPT-oPyxkUZsJsKQ8nqlhyGuI0UDV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240128

This is the s390 variant of commit 710618c760c0 ("arm64/cfi,bpf: Support
kCFI + BPF on arm64").

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/cfi.h  |  7 +++++++
 arch/s390/net/bpf_jit_comp.c | 26 ++++++++++++++++++++++----
 2 files changed, 29 insertions(+), 4 deletions(-)
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
index 31749c0362ca..74642e0b4ee1 100644
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
@@ -2401,9 +2417,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 		jit_data->ctx = jit;
 		jit_data->pass = pass;
 	}
-	fp->bpf_func = (void *) jit.prg_buf;
+	fp->bpf_func = (void *)jit.prg_buf + cfi_get_offset();
 	fp->jited = 1;
-	fp->jited_len = jit.size;
+	fp->jited_len = jit.size - cfi_get_offset();
 
 	if (!fp->is_func || extra_pass) {
 		bpf_prog_fill_jited_linfo(fp, jit.addrs + 1);
@@ -2671,8 +2687,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
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

