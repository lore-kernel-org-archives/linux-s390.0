Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757AB3A9DB9;
	Tue, 18 Aug 2026 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064639; cv=none; b=CIlOGTjIFJdsl8brmt5dJydK19SfYZ1Qr7brukGSYpvcxGKedDIXf8iUtyduVpj040pH5CosrjmqPJzJQsn0JObhhiteTqbheFqKORm8aVFp6U8XIdnXNle9mWoN/jzy4aoqnkHXFVPMkuWgy3G9gCRoHgzlHuZTzxfhKeCDRws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064639; c=relaxed/simple;
	bh=JS5uSnbG868SLb/wLoTn7Q6qYF10jvEGD5NkM11gFyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mohzH4ByWrBNXol8lZYu7lb9Rfs1gS4qfz2hq1mM5PCpIWNgYJDKiVxF7au4A35cIQ4HnxOUrWUhp+ije07KwTkDgnvuXRN1sLKMmvnO9iJnzRf6SrrplbzCAG3WRWHunTkm3nnaL7sa6IRIlwzNDLFtpSoROTrYkV+xMuOO8jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g/Gk6R2V; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g/Gk6R2V"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3hew542571;
	Tue, 18 Aug 2026 14:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DmYJosP7a3ctaCAQA
	fHKDxfDl8a84/TUZQJY7oZBI/0=; b=g/Gk6R2VkPT/P5s/lBesST2ujS9SgAosl
	c/P0hGAyskWeE/obNjyr2ND+gsPAvVinL3FyiY4GNjSuhGAjeJgdAfRvVSfpUseB
	Us2tphKcSOYdx4OrIKpULkQIKOTEvW8E5euGuk85BpLziY0BxPgs3vIfAG5mZEAv
	i++JkcN1JYCW6+4rloANMy4g+gNpZvHDeOYEueF+ni/V6XMd8gWY6PDWrpctas0X
	b3TU9xeEOANaiY6UaEq3YSu7O21CQrzYz/DArbxk1Ndvqh5Tb9+9ilwReGLctXl1
	AZopf+3kBO7zhfIug0mrQneb30gPwgrbqLOehVddEbcmoDOsnvpoQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt8bsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IEfMpX025410;
	Tue, 18 Aug 2026 14:50:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh3q58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IEo0Mk29819540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 14:50:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15B0120043;
	Tue, 18 Aug 2026 14:50:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABAC420040;
	Tue, 18 Aug 2026 14:49:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 14:49:59 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Indu Bhagat <ibhagatgnu@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Namhyung Kim <namhyung@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>,
        Sam James <sam@gentoo.org>
Subject: [RFC PATCH v1 09/25] unwind_user/eh_frame: Add support for reading .eh_frame section
Date: Tue, 18 Aug 2026 16:49:38 +0200
Message-ID: <20260818144954.2320378-10-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818144954.2320378-1-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a84711d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8
 a=QVDTdSu5COzsizyIqpwA:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfXz3hHHTXQTRA+
 S+xySZS2yY0+hmGaP5rI/86abLhPYCia6BncWmDFjWJTq9Jp8gw37MpKCe/dKb2hq5HIIQ5Wcjf
 tobAQV5yFI6mqMzfgAoRBMKTXkZd9so=
X-Proofpoint-GUID: Sj404Q0MiNBn0FwaH2wqTEh8EbHWLnrc
X-Proofpoint-ORIG-GUID: KmOuiz5-03_xp7Ka98iBBFWzT_Cel-G4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX6+aZ25vaPCmO
 qnFHaJ4AN8xAj3jpmM6FxzuKkT17SofkqnZ5tpzhBERI8HXlT2+Jk/tWASp+0SjMITs3/OT6JWs
 u0onwHGl2UVttl1YqZvkm82ACFTrd8+EcSUD6GrL+KQCRA3ag8KdcNKknb7GfYhueGm6Vc2xCUv
 TofqWKFG3KIpAE3cKL7GFnKZXQmetvIlzcjqPmy5ddn6F2RMUco6rGEq3oIw+r63Cb3B1nYW2J4
 1Hv68JznCdG1sW5pzZARMTRkUWai1hfTQ1bP2lGXBCpQexkBtSoTHm0xwA/J/cg1g6uvivP0lAR
 6i5r/nwvS4pGWtj5pyTky44d1Wrp67LwZdnEWZXNKBvantBSBzFsDP4AB+88cc6CyrZok4zChuO
 ncrlPedBUH91KdHZHma9YG/bnMktEpEnAcYovKhgGA7x0JkNWV9juG4HbZyX0MedoDrOAepOfhE
 RqFVP/M/yaxQ1z17R9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180107

In preparation for using .eh_frame to unwind user space stacks, add an
eh_frame_find() interface for finding the .eh_frame[_hdr] information
associated with a given text address.

The implementation parses DWARF Call Frame Information (CFI) from the
.eh_frame section, including:
- Common Information Entries (CIEs) that define default unwinding rules,
- Frame Description Entries (FDEs) that describe unwinding for specific
  function address ranges, and
- DWARF CFI instructions that specify how to restore registers.

For performance, use user_read_access_begin() and the corresponding
unsafe_*() accessors.  Note that use of pr_debug() in uaccess-enabled
regions would break noinstr validation, so there aren't any debug
messages yet.  That will be added in a subsequent commit.

Based on Josh Poimboeuf's, Steven Rostedt's, and my unwind user sframe
implementation.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 MAINTAINERS                                |   2 +
 include/asm-generic/Kbuild                 |   1 +
 include/asm-generic/unwind_user_eh_frame.h |  43 +
 include/linux/eh_frame.h                   |   7 +
 kernel/unwind/eh_frame.c                   | 943 ++++++++++++++++++++-
 kernel/unwind/eh_frame.h                   |  38 +
 kernel/unwind/eh_frame_debug.h             |  19 +
 7 files changed, 1048 insertions(+), 5 deletions(-)
 create mode 100644 include/asm-generic/unwind_user_eh_frame.h
 create mode 100644 kernel/unwind/eh_frame_debug.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f19f5bb87f00..d5f46f26996f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28202,7 +28202,9 @@ M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Steven Rostedt <rostedt@goodmis.org>
 S:	Maintained
 F:	arch/*/include/asm/unwind_user.h
+F:	arch/*/include/asm/unwind_user_eh_frame.h
 F:	include/asm-generic/unwind_user.h
+F:	include/asm-generic/unwind_user_eh_frame.h
 F:	include/linux/eh_frame.h
 F:	include/linux/unwind*.h
 F:	kernel/unwind/
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 15df9dcb42a5..bd031eb6adc4 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -62,6 +62,7 @@ mandatory-y += topology.h
 mandatory-y += trace_clock.h
 mandatory-y += uaccess.h
 mandatory-y += unwind_user.h
+mandatory-y += unwind_user_eh_frame.h
 mandatory-y += vermagic.h
 mandatory-y += vga.h
 mandatory-y += video.h
diff --git a/include/asm-generic/unwind_user_eh_frame.h b/include/asm-generic/unwind_user_eh_frame.h
new file mode 100644
index 000000000000..e6d207597206
--- /dev/null
+++ b/include/asm-generic/unwind_user_eh_frame.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_UNWIND_USER_EH_FRAME_H
+#define _ASM_GENERIC_UNWIND_USER_EH_FRAME_H
+
+#ifndef EH_FRAME_MAX_CIE_LENGTH
+#define EH_FRAME_MAX_CIE_LENGTH 128
+#endif
+
+#ifndef EH_FRAME_MAX_AUGSTR_LENGTH
+#define EH_FRAME_MAX_AUGSTR_LENGTH 16
+#endif
+
+#ifndef EH_FRAME_MAX_STATE_STACK
+#define EH_FRAME_MAX_STATE_STACK 8
+#endif
+
+#ifndef EH_FRAME_MAX_CODE_ALIGN
+#define EH_FRAME_MAX_CODE_ALIGN 8
+#endif
+
+#ifndef EH_FRAME_MIN_DATA_ALIGN
+#define EH_FRAME_MIN_DATA_ALIGN -8
+#endif
+
+#ifndef EH_FRAME_MAX_DATA_ALIGN
+#define EH_FRAME_MAX_DATA_ALIGN -1
+#endif
+
+#ifndef EH_FRAME_SP_VAL_OFFSET
+/* Most archs/ABIs define CFA as SP at call site, so that SP = CFA + 0 */
+#define EH_FRAME_SP_VAL_OFFSET 0
+#endif
+
+#ifndef eh_frame_reject_sp_rule
+static inline bool eh_frame_reject_sp_rule(void)
+{
+	return true;
+}
+#define eh_frame_reject_sp_rule eh_frame_reject_sp_rule
+#endif
+
+#endif /* _ASM_GENERIC_UNWIND_USER_EH_FRAME_H */
+
diff --git a/include/linux/eh_frame.h b/include/linux/eh_frame.h
index 95df4911fd23..e33041e4f9c0 100644
--- a/include/linux/eh_frame.h
+++ b/include/linux/eh_frame.h
@@ -4,6 +4,7 @@
 
 #include <linux/mm_types.h>
 #include <linux/srcu.h>
+#include <linux/unwind_user_types.h>
 
 #ifdef CONFIG_HAVE_UNWIND_USER_EH_FRAME
 
@@ -32,6 +33,7 @@ extern int eh_frame_add_section(unsigned long eh_frame_hdr_start,
 				unsigned long text_start,
 				unsigned long text_end);
 extern int eh_frame_remove_section(unsigned long eh_frame_hdr_start);
+extern int eh_frame_find(unsigned long ip, struct unwind_user_frame *frame);
 
 static inline bool current_has_eh_frame(void)
 {
@@ -58,6 +60,11 @@ static inline int eh_frame_remove_section(unsigned long eh_frame_hdr_start)
 	return -ENOSYS;
 }
 
+static inline int eh_frame_find(unsigned long ip, struct unwind_user_frame *frame)
+{
+	return -ENOSYS;
+}
+
 static inline bool current_has_eh_frame(void) { return false; }
 
 #endif /* CONFIG_HAVE_UNWIND_USER_EH_FRAME */
diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
index 7bdf7589466a..5ef8fef06a80 100644
--- a/kernel/unwind/eh_frame.c
+++ b/kernel/unwind/eh_frame.c
@@ -13,14 +13,83 @@
 #include <linux/string_helpers.h>
 #include <linux/eh_frame.h>
 #include <linux/unwind_user_types.h>
+#include <asm/unwind_user_eh_frame.h>
 
 #include "eh_frame.h"
-
-#define dbg(fmt, ...)							\
-	pr_debug("%s (%d): " fmt, current->comm, current->pid, ##__VA_ARGS__)
+#include "eh_frame_debug.h"
+
+/* Register state for CFI interpreter */
+enum eh_frame_cfa_rule {
+	CFA_UNDEFINED,		/* unrecoverable */
+	CFA_REG_OFFSET,		/* CFA = reg + offset */
+};
+
+enum eh_frame_reg_rule {
+	REG_UNDEFINED_IMPLICIT,	/* reg = reg */
+	REG_UNDEFINED_EXPLICIT,	/* unrecoverable; RA: outermost frame */
+	REG_SAME_VALUE,		/* reg = reg; TODO: reset to CIE initial CFI */
+	REG_OFFSET,		/* reg = *(CFA + offset) */
+	REG_VAL_OFFSET,		/* reg = CFA + offset */
+	REG_REGISTER,		/* reg = other_reg */
+};
+
+enum eh_frame_reg_index {
+	FP_IDX,			/* frame pointer (FP) */
+	RA_IDX,			/* return address (RA) */
+	NR_REGS
+};
+
+struct eh_frame_reg_state {
+	/* CFA recovery rule */
+	enum eh_frame_cfa_rule cfa_rule;
+	unsigned long cfa_regnum;
+	long cfa_offset;
+
+	/* FP and RA recovery rules (SP uses implicit recovery) */
+	enum eh_frame_reg_rule reg_rule[NR_REGS];
+	unsigned long reg_regnum[NR_REGS];
+	long reg_offset[NR_REGS];
+};
+
+struct eh_frame_cfi_context {
+	struct eh_frame_reg_state state;
+	struct eh_frame_reg_state stack[EH_FRAME_MAX_STATE_STACK];
+	int stack_depth;
+};
+
+struct eh_frame_cie {
+	unsigned long cfi_insn_start;
+	unsigned long cfi_insn_end;
+	int data_align;
+	unsigned int code_align;
+	u8 fde_addr_enc;		/* from CIE 'R' augmentation */
+	bool aug_data_present;		/* from CIE 'z' augmentation */
+	bool signal_frame;		/* from CIE 'S' augmentation */
+};
+
+struct eh_frame_fde {
+	unsigned long func_addr;
+	unsigned long func_size;
+	unsigned long cfi_insn_start;
+	unsigned long cfi_insn_end;
+
+	struct eh_frame_cie cie;	/* referenced CIE*/
+};
 
 DEFINE_STATIC_SRCU(eh_frame_srcu);
 
+#define GET_USER_INC(to, from, end)					\
+({									\
+	typeof(to) __to;						\
+	int ret;							\
+	if (from + sizeof(__to) > end)					\
+		return -EINVAL;						\
+	ret = get_user(__to, (typeof(to) __user *)from);		\
+	from += sizeof(__to);						\
+	to = __to;							\
+	ret;								\
+})
+
 #define UNSAFE_GET_USER_INC(to, from, end, label)			\
 ({									\
 	typeof(to) __to;						\
@@ -111,6 +180,7 @@ static __always_inline int encoded_pointer_size(u8 encoding)
 }
 
 static __always_inline int read_encoded_pointer(struct eh_frame_section *sec,
+						struct eh_frame_fde *fde,
 						unsigned long *addr,
 						unsigned long end,
 						u8 encoding,
@@ -140,6 +210,10 @@ static __always_inline int read_encoded_pointer(struct eh_frame_section *sec,
 		result = sec->text_start;
 		break;
 	case DW_EH_PE_funcrel:
+		if (!fde)
+			return -EINVAL;
+		result = fde->func_addr;
+		break;
 	case DW_EH_PE_aligned:
 		return -EOPNOTSUPP;
 	default:
@@ -219,6 +293,865 @@ static __always_inline int read_encoded_pointer(struct eh_frame_section *sec,
 	return -EFAULT;
 }
 
+static __always_inline int __read_cie(struct eh_frame_section *sec,
+				      unsigned long cie_addr,
+				      struct eh_frame_cie *cie)
+{
+	void __user *cie_ptr = (void __user *)cie_addr;
+	unsigned long cur = cie_addr, end;
+	u32 length, cie_id;
+	u8 version;
+	char aug_str[EH_FRAME_MAX_AUGSTR_LENGTH];
+	int aug_idx;
+	unsigned long code_align;
+	long data_align;
+	u8 ra_reg;
+	bool aug_data_present = false;
+	unsigned long aug_data_len, aug_data_end = cie_addr;
+	u8 fde_addr_enc = DW_EH_PE_absptr;
+	bool signal_frame = false;
+	int ret;
+
+	/* Read CIE length */
+	ret = GET_USER_INC(length, cur, sec->eh_frame_vma_end);
+	if (ret)
+		return ret;
+	if (!length || length == EH_FRAME_DWARF64_LENGTH || length > EH_FRAME_MAX_CIE_LENGTH)
+		return -EINVAL;
+	end = cie_addr + 4 + length;
+	if (end > sec->eh_frame_vma_end)
+		return -EFAULT;
+
+	scoped_user_read_access_size(cie_ptr, 4 + length, Efault) {
+		/* Read CIE_ID (must be 0 for CIE; FDE otherwise) */
+		UNSAFE_GET_USER_INC(cie_id, cur, end, Efault);
+		if (cie_id != EH_FRAME_CIE_ID)
+			return -EINVAL;
+
+		/* Read version */
+		UNSAFE_GET_USER_INC(version, cur, end, Efault);
+		if (version != 1)
+			return -EOPNOTSUPP;
+
+		/* Read augmentation string */
+		for (aug_idx = 0; aug_idx < sizeof(aug_str); aug_idx++) {
+			UNSAFE_GET_USER_INC(aug_str[aug_idx], cur, end, Efault);
+			if (aug_str[aug_idx] == '\0')
+				break;
+		}
+		if (aug_idx >= sizeof(aug_str))
+			return -EINVAL;
+
+		/* Read code alignment factor */
+		ret = read_uleb128(&cur, end, &code_align);
+		if (ret)
+			return ret;
+		if (!code_align || code_align > EH_FRAME_MAX_CODE_ALIGN)
+			return -EINVAL;
+
+		/* Read data alignment factor */
+		ret = read_sleb128(&cur, end, &data_align);
+		if (ret)
+			return ret;
+		if (!data_align || (data_align < EH_FRAME_MIN_DATA_ALIGN ||
+				    data_align > EH_FRAME_MAX_DATA_ALIGN))
+			return -EINVAL;
+
+		/* Read return address register number */
+		UNSAFE_GET_USER_INC(ra_reg, cur, end, Efault);
+		if (ra_reg != EH_FRAME_REG_RA)
+			return -EOPNOTSUPP;
+
+		/* Parse augmentation string and read augmentation data if present */
+		for (aug_idx = 0; aug_str[aug_idx]; aug_idx++) {
+			switch (aug_str[aug_idx]) {
+			case 'z':
+				/* Augmentation data present - must be first character */
+				if (aug_idx != 0)
+					return -EINVAL;
+				aug_data_present = true;
+				ret = read_uleb128(&cur, end, &aug_data_len);
+				if (ret)
+					return ret;
+				aug_data_end = cur + aug_data_len;
+				if (aug_data_end > end)
+					return -EINVAL;
+				break;
+			case 'L': {
+				/* LSDA encoding - skip */
+				u8 lsda_enc;
+				if (!aug_data_present)
+					return -EINVAL;
+				UNSAFE_GET_USER_INC(lsda_enc, cur, aug_data_end, Efault);
+				break;
+			}
+			case 'P': {
+				/* Personality encoding and routine - skip */
+				u8 personality_enc;
+				unsigned long personality_rtn;
+				if (!aug_data_present)
+					return -EINVAL;
+				UNSAFE_GET_USER_INC(personality_enc, cur, aug_data_end, Efault);
+				/*
+				 * Clear indirect flag to avoid user read from
+				 * arbitrary address; still skip field.
+				 */
+				personality_enc &= ~DW_EH_PE_indirect;
+				ret = read_encoded_pointer(sec, NULL, &cur, aug_data_end,
+							   personality_enc, &personality_rtn);
+				if (ret)
+					return ret;
+				break;
+			}
+			case 'R':
+				/* FDE encoding */
+				if (!aug_data_present)
+					return -EINVAL;
+				UNSAFE_GET_USER_INC(fde_addr_enc, cur, aug_data_end, Efault);
+				break;
+			case 'S':
+				/* Signal frame */
+				signal_frame = true;
+				break;
+			default:
+				/* Unknown augmentation */
+				return -EOPNOTSUPP;
+			}
+		}
+	}
+
+	cie->code_align		= code_align;
+	cie->data_align		= data_align;
+	cie->fde_addr_enc	= fde_addr_enc;
+	cie->aug_data_present	= aug_data_present;
+	cie->signal_frame	= signal_frame;
+	cie->cfi_insn_start	= cur;
+	cie->cfi_insn_end	= end;
+
+	return 0;
+
+Efault:
+	return -EFAULT;
+}
+
+static __always_inline int __read_fde(struct eh_frame_section *sec,
+				      unsigned long fde_addr,
+				      struct eh_frame_fde *fde)
+{
+	void __user *fde_ptr = (void __user *)fde_addr;
+	unsigned long cur = fde_addr, end;
+	u32 length, cie_offset;
+	unsigned long cie_addr, func_addr, func_size;
+	int ret;
+
+	/* Read FDE length */
+	ret = GET_USER_INC(length, cur, sec->eh_frame_vma_end);
+	if (ret)
+		return ret;
+	if (!length || length == EH_FRAME_DWARF64_LENGTH)
+		return -EINVAL;
+	end = fde_addr + 4 + length;
+	if (end > sec->eh_frame_vma_end)
+		return -EFAULT;
+
+	scoped_user_read_access_size(fde_ptr, 4 + length, Efault) {
+		/* Read CIE pointer (offset from current position) */
+		UNSAFE_GET_USER_INC(cie_offset, cur, end, Efault);
+		cie_addr = cur - 4 - cie_offset;
+		if (cie_addr + EH_FRAME_CIE_MIN_LENGTH > fde_addr)
+			return -EINVAL;
+		if (cie_addr < sec->eh_frame_start)
+			return -EINVAL;
+	}
+
+	/* Read the CIE to populate alignment factors, RA register, and FDE encoding */
+	ret = __read_cie(sec, cie_addr, &fde->cie);
+	if (ret)
+		return ret;
+
+	scoped_user_read_access_size(fde_ptr, 4 + length, Efault) {
+		/* Read PC begin (function start address) */
+		ret = read_encoded_pointer(sec, fde, &cur, end, fde->cie.fde_addr_enc, &func_addr);
+		if (ret)
+			return ret;
+		if (func_addr < sec->text_start || func_addr >= sec->text_end)
+			return -EINVAL;
+
+		/* Read PC range (function size) using PE format only */
+		u8 range_enc = DW_EH_PE_format(fde->cie.fde_addr_enc);
+		ret = read_encoded_pointer(sec, fde, &cur, end, range_enc, &func_size);
+		if (ret)
+			return ret;
+		if (func_addr + func_size > sec->text_end)
+			return -EINVAL;
+
+		/* Skip augmentation data if present */
+		if (fde->cie.aug_data_present) {
+			unsigned long aug_data_len;
+
+			ret = read_uleb128(&cur, end, &aug_data_len);
+			if (ret)
+				return ret;
+			if (cur + aug_data_len > end)
+				return -EINVAL;
+			cur += aug_data_len;
+		}
+	}
+
+	fde->func_addr		= func_addr;
+	fde->func_size		= func_size;
+	fde->cfi_insn_start	= cur;
+	fde->cfi_insn_end	= end;
+
+	return 0;
+
+Efault:
+	return -EFAULT;
+}
+
+
+static __always_inline int __find_fde(struct eh_frame_section *sec,
+				      unsigned long ip,
+				      struct eh_frame_fde *fde)
+{
+	void __user *table_start_ptr;
+	unsigned long table_size;
+	u8 table_enc;
+	int entry_size;
+	unsigned long low, high;
+	unsigned long found_cur = 0, found_func_addr;
+	unsigned long fde_addr;
+	int ret;
+
+	if (!sec->fde_count)
+		return -ENOENT;
+
+	table_enc = sec->binary_search_table_enc;
+	entry_size = 2 * encoded_pointer_size(table_enc);
+	if (!entry_size)
+		return -EINVAL;
+
+	table_start_ptr = (void __user *)sec->binary_search_table_start;
+	table_size = sec->binary_search_table_end - sec->binary_search_table_start;
+	scoped_user_read_access_size(table_start_ptr, table_size, Efault) {
+		/*
+		 * Binary search in .eh_frame_hdr table using half-open
+		 * interval [low, high) to avoid underflow of high if
+		 * target IP is lower than first entry.
+		 */
+		low = 0;
+		high = sec->fde_count;
+		while (low < high) {
+			unsigned long mid, cur, func_addr;
+
+			mid = low + ((high - low) / 2);
+			cur = sec->binary_search_table_start + mid * entry_size;
+
+			/* Read function start address from table */
+			ret = read_encoded_pointer(sec, NULL, &cur, sec->binary_search_table_end,
+						   table_enc, &func_addr);
+			if (ret)
+				return ret;
+
+			if (ip >= func_addr) {
+				found_cur = cur;
+				found_func_addr = func_addr;
+				low = mid + 1;
+			} else {
+				high = mid;
+			}
+		}
+
+		if (!found_cur)
+			return -ENOENT;
+
+		/* Read FDE address from table */
+		ret = read_encoded_pointer(sec, NULL, &found_cur, sec->binary_search_table_end,
+					   table_enc, &fde_addr);
+		if (ret)
+			return ret;
+		if (fde_addr < sec->eh_frame_start)
+			return -EINVAL;
+	}
+
+	ret = __read_fde(sec, fde_addr, fde);
+	if (ret)
+		return ret;
+	if (found_func_addr != fde->func_addr)
+		return -EINVAL;
+
+	/* Make sure it is not a gap */
+	if (ip < fde->func_addr || ip >= fde->func_addr + fde->func_size)
+		return -ENOENT;
+
+	return 0;
+
+Efault:
+	return -EFAULT;
+}
+
+/* Helper to convert DWARF register number to index (FP=0, RA=1) */
+static inline int reg_to_index(unsigned int reg)
+{
+	if (reg == EH_FRAME_REG_FP)
+		return 0;
+	if (reg == EH_FRAME_REG_RA)
+		return 1;
+	return -1;
+}
+
+static __always_inline int __do_cfi_insn(struct eh_frame_section *sec,
+					 struct eh_frame_fde *fde,
+					 unsigned long *cur_ptr,
+					 unsigned long end,
+					 unsigned long *ip_ptr,
+					 unsigned long target_ip,
+					 struct eh_frame_cfi_context *ctx)
+{
+	unsigned long cur = *cur_ptr;
+	unsigned long ip = *ip_ptr;
+	u8 opcode;
+	int ret;
+
+	UNSAFE_GET_USER_INC(opcode, cur, end, Efault);
+
+	switch (DW_CFA_opcode(opcode)) {
+	case DW_CFA_advance_loc: {
+		unsigned long offset = DW_CFA_operand(opcode) * fde->cie.code_align;
+
+		ip += offset;
+		break;
+	}
+
+	case DW_CFA_offset: {
+		u8 reg = DW_CFA_operand(opcode);
+		long offset;
+		int idx;
+
+		ret = read_uleb128(&cur, end, &offset);
+		if (ret)
+			return ret;
+		offset *= fde->cie.data_align;
+
+		if (reg == EH_FRAME_REG_SP && eh_frame_reject_sp_rule())
+			return -EOPNOTSUPP;
+
+		idx = reg_to_index(reg);
+		if (idx >= 0) {
+			ctx->state.reg_rule[idx] = REG_OFFSET;
+			ctx->state.reg_offset[idx] = offset;
+		}
+		break;
+	}
+
+	case DW_CFA_restore: {
+		u8 reg = DW_CFA_operand(opcode);
+		int idx;
+
+		idx = reg_to_index(reg);
+		if (idx >= 0)
+			ctx->state.reg_rule[idx] = REG_UNDEFINED_IMPLICIT;
+		break;
+	}
+
+	case 0: /* Extended opcodes */
+		switch (opcode) {
+		case DW_CFA_nop:
+			break;
+
+		case DW_CFA_advance_loc1: {
+			unsigned long offset;
+			u8 delta;
+
+			UNSAFE_GET_USER_INC(delta, cur, end, Efault);
+			offset = delta * fde->cie.code_align;
+			ip += offset;
+			break;
+		}
+
+		case DW_CFA_advance_loc2: {
+			unsigned long offset;
+			u16 delta;
+
+			UNSAFE_GET_USER_INC(delta, cur, end, Efault);
+			offset = delta * fde->cie.code_align;
+			ip += offset;
+			break;
+		}
+
+		case DW_CFA_advance_loc4: {
+			unsigned long offset;
+			u32 delta;
+
+			UNSAFE_GET_USER_INC(delta, cur, end, Efault);
+			offset = delta * fde->cie.code_align;
+			ip += offset;
+			break;
+		}
+
+		case DW_CFA_def_cfa: {
+			unsigned long reg, offset;
+
+			ret = read_uleb128(&cur, end, &reg);
+			if (ret)
+				return ret;
+			ret = read_uleb128(&cur, end, &offset);
+			if (ret)
+				return ret;
+
+			if (offset > LONG_MAX)
+				return -EOPNOTSUPP;
+
+			ctx->state.cfa_rule = CFA_REG_OFFSET;
+			ctx->state.cfa_regnum = reg;
+			ctx->state.cfa_offset = offset;
+			break;
+		}
+
+		case DW_CFA_def_cfa_sf: {
+			unsigned long reg;
+			long offset;
+
+			ret = read_uleb128(&cur, end, &reg);
+			if (ret)
+				return ret;
+			ret = read_sleb128(&cur, end, &offset);
+			if (ret)
+				return ret;
+			offset *= fde->cie.data_align;
+
+			ctx->state.cfa_rule = CFA_REG_OFFSET;
+			ctx->state.cfa_regnum = reg;
+			ctx->state.cfa_offset = offset;
+			break;
+		}
+
+		case DW_CFA_def_cfa_register: {
+			unsigned long reg;
+
+			ret = read_uleb128(&cur, end, &reg);
+			if (ret)
+				return ret;
+
+			ctx->state.cfa_rule = CFA_REG_OFFSET;
+			ctx->state.cfa_regnum = reg;
+			break;
+		}
+
+		case DW_CFA_def_cfa_offset: {
+			unsigned long offset;
+
+			ret = read_uleb128(&cur, end, &offset);
+			if (ret)
+				return ret;
+
+			if (offset > LONG_MAX)
+				return -EOPNOTSUPP;
+
+			ctx->state.cfa_offset = offset;
+			break;
+		}
+
+		case DW_CFA_def_cfa_offset_sf: {
+			long offset;
+
+			ret = read_sleb128(&cur, end, &offset);
+			if (ret)
+				return ret;
+			offset *= fde->cie.data_align;
+
+			ctx->state.cfa_offset = offset;
+			break;
+		}
+
+		case DW_CFA_undefined: {
+			unsigned long reg;
+			int idx;
+
+			ret = read_uleb128(&cur, end, &reg);
+			if (ret)
+				return ret;
+
+			if (reg == EH_FRAME_REG_SP)
+				return -EOPNOTSUPP;
+
+			idx = reg_to_index(reg);
+			if (idx >= 0)
+				ctx->state.reg_rule[idx] = REG_UNDEFINED_EXPLICIT;
+			break;
+		}
+
+		case DW_CFA_same_value: {
+			unsigned long reg;
+			int idx;
+
+			ret = read_uleb128(&cur, end, &reg);
+			if (ret)
+				return ret;
+
+			if (reg == EH_FRAME_REG_SP && eh_frame_reject_sp_rule())
+				return -EOPNOTSUPP;
+
+			idx = reg_to_index(reg);
+			if (idx >= 0)
+				ctx->state.reg_rule[idx] = REG_SAME_VALUE;
+			break;
+		}
+
+		case DW_CFA_offset_extended: {
+			unsigned long reg, _offset;
+			long offset;
+			int idx;
+
+			ret = read_uleb128(&cur, end, &reg);
+			if (ret)
+				return ret;
+			ret = read_uleb128(&cur, end, &_offset);
+			if (ret)
+				return ret;
+			offset = _offset * fde->cie.data_align;
+
+			if (reg == EH_FRAME_REG_SP && eh_frame_reject_sp_rule())
+				return -EOPNOTSUPP;
+
+			idx = reg_to_index(reg);
+			if (idx >= 0) {
+				ctx->state.reg_rule[idx] = REG_OFFSET;
+				ctx->state.reg_offset[idx] = offset;
+			}
+			break;
+		}
+
+		case DW_CFA_offset_extended_sf: {
+			unsigned long reg;
+			long offset;
+			int idx;
+
+			ret = read_uleb128(&cur, end, &reg);
+			if (ret)
+				return ret;
+			ret = read_sleb128(&cur, end, &offset);
+			if (ret)
+				return ret;
+			offset *= fde->cie.data_align;
+
+			if (reg == EH_FRAME_REG_SP && eh_frame_reject_sp_rule())
+				return -EOPNOTSUPP;
+
+			idx = reg_to_index(reg);
+			if (idx >= 0) {
+				ctx->state.reg_rule[idx] = REG_OFFSET;
+				ctx->state.reg_offset[idx] = offset;
+			}
+			break;
+		}
+
+		case DW_CFA_val_offset: {
+			unsigned long reg, _offset;
+			long offset;
+			int idx;
+
+			ret = read_uleb128(&cur, end, &reg);
+			if (ret)
+				return ret;
+			ret = read_uleb128(&cur, end, &_offset);
+			if (ret)
+				return ret;
+			offset = _offset * fde->cie.data_align;
+
+			if (reg == EH_FRAME_REG_SP && offset != EH_FRAME_SP_VAL_OFFSET)
+				return -EOPNOTSUPP;
+
+			idx = reg_to_index(reg);
+			if (idx >= 0) {
+				ctx->state.reg_rule[idx] = REG_VAL_OFFSET;
+				ctx->state.reg_offset[idx] = offset;
+			}
+			break;
+		}
+
+		case DW_CFA_val_offset_sf: {
+			unsigned long reg;
+			long offset;
+			int idx;
+
+			ret = read_uleb128(&cur, end, &reg);
+			if (ret)
+				return ret;
+			ret = read_sleb128(&cur, end, &offset);
+			if (ret)
+				return ret;
+			offset *= fde->cie.data_align;
+
+			if (reg == EH_FRAME_REG_SP && offset != EH_FRAME_SP_VAL_OFFSET)
+				return -EOPNOTSUPP;
+
+			idx = reg_to_index(reg);
+			if (idx >= 0) {
+				ctx->state.reg_rule[idx] = REG_VAL_OFFSET;
+				ctx->state.reg_offset[idx] = offset;
+			}
+			break;
+		}
+
+		case DW_CFA_register: {
+			unsigned long reg1, reg2;
+			int idx;
+
+			ret = read_uleb128(&cur, end, &reg1);
+			if (ret)
+				return ret;
+			ret = read_uleb128(&cur, end, &reg2);
+			if (ret)
+				return ret;
+
+			if (reg1 == EH_FRAME_REG_SP && eh_frame_reject_sp_rule())
+				return -EOPNOTSUPP;
+
+			idx = reg_to_index(reg1);
+			if (idx >= 0) {
+				ctx->state.reg_rule[idx] = REG_REGISTER;
+				ctx->state.reg_regnum[idx] = reg2;
+			}
+			break;
+		}
+
+		case DW_CFA_expression:
+		case DW_CFA_val_expression: {
+			unsigned long reg, expr_len;
+
+			ret = read_uleb128(&cur, end, &reg);
+			if (ret)
+				return ret;
+			ret = read_uleb128(&cur, end, &expr_len);
+			if (ret)
+				return ret;
+
+			if (cur + expr_len > end)
+				return -EINVAL;
+
+			if (reg == EH_FRAME_REG_SP || reg == EH_FRAME_REG_FP || reg == EH_FRAME_REG_RA)
+				return -EOPNOTSUPP;
+
+			cur += expr_len;
+			break;
+		}
+
+		case DW_CFA_remember_state:
+			if (ctx->stack_depth >= EH_FRAME_MAX_STATE_STACK)
+				return -EINVAL;
+			ctx->stack[ctx->stack_depth++] = ctx->state;
+			break;
+
+		case DW_CFA_restore_state:
+			if (ctx->stack_depth <= 0)
+				return -EINVAL;
+			ctx->state = ctx->stack[--ctx->stack_depth];
+			break;
+
+		default:
+			return -EOPNOTSUPP;
+		}
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	*cur_ptr = cur;
+	*ip_ptr = ip;
+	return 0;
+
+Efault:
+	return -EFAULT;
+}
+
+static __always_inline int __do_cfi_program(struct eh_frame_section *sec,
+					    struct eh_frame_fde *fde,
+					    unsigned long target_ip,
+					    struct eh_frame_cfi_context *ctx)
+{
+	void __user *cfi_ptr;
+	unsigned long cfi_size;
+	unsigned long ip = fde->func_addr;
+	unsigned long cur;
+	int ret;
+
+	/* Initialize state */
+	ctx->state.cfa_rule = CFA_UNDEFINED;
+	ctx->state.reg_rule[FP_IDX] = REG_UNDEFINED_IMPLICIT;
+	ctx->state.reg_rule[RA_IDX] = REG_UNDEFINED_IMPLICIT;
+	ctx->stack_depth = 0;
+
+	/* Process CIE initial CFI instructions (if any) */
+	cfi_ptr = (void __user *)fde->cie.cfi_insn_start;
+	cfi_size = fde->cie.cfi_insn_end - fde->cie.cfi_insn_start;
+	scoped_user_read_access_size(cfi_ptr, cfi_size, Efault) {
+		cur = fde->cie.cfi_insn_start;
+		while (cur < fde->cie.cfi_insn_end) {
+			ret = __do_cfi_insn(sec, fde, &cur, fde->cie.cfi_insn_end, &ip, target_ip, ctx);
+			if (ret)
+				return ret;
+		}
+	}
+
+	/* Do not allow remember/restore between CIE and FDE */
+	ctx->stack_depth = 0;
+
+	/* Process FDE CFI instructions up to target IP */
+	cfi_ptr = (void __user *)fde->cfi_insn_start;
+	cfi_size = fde->cfi_insn_end - fde->cfi_insn_start;
+	scoped_user_read_access_size(cfi_ptr, cfi_size, Efault) {
+		cur = fde->cfi_insn_start;
+		while (cur < fde->cfi_insn_end && ip <= target_ip) {
+			ret = __do_cfi_insn(sec, fde, &cur, fde->cfi_insn_end, &ip, target_ip, ctx);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+
+Efault:
+	return -EFAULT;
+}
+
+static __always_inline int __find_frame_row(struct eh_frame_section *sec,
+					    struct eh_frame_fde *fde,
+					    unsigned long ip,
+					    struct unwind_user_frame *frame)
+{
+	struct eh_frame_cfi_context ctx;
+	int ret;
+
+	/* TODO: Signal frame - not supported yet */
+	if (fde->cie.signal_frame)
+		return -EOPNOTSUPP;
+
+	ret = __do_cfi_program(sec, fde, ip, &ctx);
+	if (ret)
+		return ret;
+
+	/* Convert CFA rule */
+	if (ctx.state.cfa_rule != CFA_REG_OFFSET)
+		return -EINVAL;
+
+	if (ctx.state.cfa_regnum == EH_FRAME_REG_SP)
+		frame->cfa.rule = UNWIND_USER_CFA_RULE_SP_OFFSET;
+	else if (ctx.state.cfa_regnum == EH_FRAME_REG_FP)
+		frame->cfa.rule = UNWIND_USER_CFA_RULE_FP_OFFSET;
+	else {
+		if (ctx.state.cfa_regnum > UINT_MAX)
+			return -EINVAL;
+		frame->cfa.rule = UNWIND_USER_CFA_RULE_REG_OFFSET;
+		frame->cfa.regnum = ctx.state.cfa_regnum;
+	}
+
+	if (ctx.state.cfa_offset < INT_MIN ||
+	    ctx.state.cfa_offset > INT_MAX)
+		return -EOPNOTSUPP;
+	frame->cfa.offset = ctx.state.cfa_offset;
+
+	/* Convert RA rule */
+	frame->outermost = false;
+	switch (ctx.state.reg_rule[RA_IDX]) {
+	case REG_UNDEFINED_IMPLICIT:
+		frame->ra.rule = UNWIND_USER_RULE_RETAIN;
+		break;
+	case REG_UNDEFINED_EXPLICIT:
+		frame->outermost = true;
+		break;
+	case REG_SAME_VALUE:
+		frame->ra.rule = UNWIND_USER_RULE_RETAIN;
+		break;
+	case REG_OFFSET:
+		if (ctx.state.reg_offset[RA_IDX] < INT_MIN ||
+		    ctx.state.reg_offset[RA_IDX] > INT_MAX)
+			return -EOPNOTSUPP;
+		frame->ra.rule = UNWIND_USER_RULE_CFA_OFFSET_DEREF;
+		frame->ra.offset = ctx.state.reg_offset[RA_IDX];
+		break;
+	case REG_VAL_OFFSET:
+		if (ctx.state.reg_offset[RA_IDX] < INT_MIN ||
+		    ctx.state.reg_offset[RA_IDX] > INT_MAX)
+			return -EOPNOTSUPP;
+		frame->ra.rule = UNWIND_USER_RULE_CFA_OFFSET;
+		frame->ra.offset = ctx.state.reg_offset[RA_IDX];
+		break;
+	case REG_REGISTER:
+		if (ctx.state.reg_regnum[RA_IDX] > UINT_MAX)
+			return -EINVAL;
+		frame->ra.rule = UNWIND_USER_RULE_REG_OFFSET;
+		frame->ra.regnum = ctx.state.reg_regnum[RA_IDX];
+		frame->ra.offset = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Convert FP rule */
+	switch (ctx.state.reg_rule[FP_IDX]) {
+	case REG_UNDEFINED_IMPLICIT:
+	case REG_UNDEFINED_EXPLICIT:
+		frame->fp.rule = UNWIND_USER_RULE_RETAIN;
+		break;
+	case REG_SAME_VALUE:
+		frame->fp.rule = UNWIND_USER_RULE_RETAIN;
+		break;
+	case REG_OFFSET:
+		if (ctx.state.reg_offset[FP_IDX] < INT_MIN ||
+		    ctx.state.reg_offset[FP_IDX] > INT_MAX)
+			return -EOPNOTSUPP;
+		frame->fp.rule = UNWIND_USER_RULE_CFA_OFFSET_DEREF;
+		frame->fp.offset = ctx.state.reg_offset[FP_IDX];
+		break;
+	case REG_VAL_OFFSET:
+		if (ctx.state.reg_offset[FP_IDX] < INT_MIN ||
+		    ctx.state.reg_offset[FP_IDX] > INT_MAX)
+			return -EOPNOTSUPP;
+		frame->fp.rule = UNWIND_USER_RULE_CFA_OFFSET;
+		frame->fp.offset = ctx.state.reg_offset[FP_IDX];
+		break;
+	case REG_REGISTER:
+		if (ctx.state.reg_regnum[FP_IDX] > UINT_MAX)
+			return -EINVAL;
+		frame->fp.rule = UNWIND_USER_RULE_REG_OFFSET;
+		frame->fp.regnum = ctx.state.reg_regnum[FP_IDX];
+		frame->fp.offset = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* SP offset from CFA used in implicit CFA rule */
+	frame->sp_off = EH_FRAME_SP_VAL_OFFSET;
+
+	return 0;
+}
+
+int eh_frame_find(unsigned long ip, struct unwind_user_frame *frame)
+{
+	struct mm_struct *mm = current->mm;
+	struct eh_frame_section *sec;
+	struct eh_frame_fde fde;
+	int ret;
+
+	if (!mm)
+		return -EINVAL;
+
+	guard(srcu)(&eh_frame_srcu);
+
+	sec = mtree_load(&mm->eh_frame_mt, ip);
+	if (!sec)
+		return -ENOENT;
+
+	ret = __find_fde(sec, ip, &fde);
+	if (!ret)
+		ret = __find_frame_row(sec, &fde, ip, frame);
+
+	return ret;
+}
+
 static void free_section(struct eh_frame_section *sec)
 {
 	kfree(sec);
@@ -258,13 +1191,13 @@ static int eh_frame_read_header(struct eh_frame_section *sec)
 			return -EINVAL;
 
 		/* Read pointer to .eh_frame */
-		ret = read_encoded_pointer(sec, &cur, end,
+		ret = read_encoded_pointer(sec, NULL, &cur, end,
 					   eh_frame_ptr_enc, &eh_frame_start);
 		if (ret)
 			return ret;
 
 		/* Read FDE count */
-		ret = read_encoded_pointer(sec, &cur, end,
+		ret = read_encoded_pointer(sec, NULL, &cur, end,
 					   fde_count_enc, &fde_count);
 		if (ret)
 			return ret;
diff --git a/kernel/unwind/eh_frame.h b/kernel/unwind/eh_frame.h
index 77eda5376dfb..9a0c71102742 100644
--- a/kernel/unwind/eh_frame.h
+++ b/kernel/unwind/eh_frame.h
@@ -2,6 +2,38 @@
 #ifndef _EH_FRAME_H
 #define _EH_FRAME_H
 
+/* DWARF CFI opcodes */
+#define DW_CFA_advance_loc		0x40
+#define DW_CFA_offset			0x80
+#define DW_CFA_restore			0xc0
+#define DW_CFA_nop			0x00
+#define DW_CFA_set_loc			0x01
+#define DW_CFA_advance_loc1		0x02
+#define DW_CFA_advance_loc2		0x03
+#define DW_CFA_advance_loc4		0x04
+#define DW_CFA_offset_extended		0x05
+#define DW_CFA_restore_extended		0x06
+#define DW_CFA_undefined		0x07
+#define DW_CFA_same_value		0x08
+#define DW_CFA_register			0x09
+#define DW_CFA_remember_state		0x0a
+#define DW_CFA_restore_state		0x0b
+#define DW_CFA_def_cfa			0x0c
+#define DW_CFA_def_cfa_register		0x0d
+#define DW_CFA_def_cfa_offset		0x0e
+#define DW_CFA_def_cfa_expression	0x0f
+#define DW_CFA_expression		0x10
+#define DW_CFA_offset_extended_sf	0x11
+#define DW_CFA_def_cfa_sf		0x12
+#define DW_CFA_def_cfa_offset_sf	0x13
+#define DW_CFA_val_offset		0x14
+#define DW_CFA_val_offset_sf		0x15
+#define DW_CFA_val_expression		0x16
+
+/* Helpers for CFI opcodes */
+#define DW_CFA_opcode(insn)		((insn) & 0xc0)
+#define DW_CFA_operand(insn)		((insn) & 0x3f)
+
 /* DWARF exception header pointer encodings */
 #define DW_EH_PE_omit			0xff
 /* Formats */
@@ -27,4 +59,10 @@
 #define DW_EH_PE_format(encoding)	((encoding) & 0x0f)
 #define DW_EH_PE_application(encoding)	((encoding) & 0x70)
 
+/* CIE/FDE constants */
+#define EH_FRAME_CIE_ID			0
+#define EH_FRAME_DWARF64_LENGTH		0xffffffff
+#define EH_FRAME_CIE_MIN_LENGTH		13
+#define EH_FRAME_FDE_MIN_LENGTH		10
+
 #endif /* _EH_FRAME_H */
diff --git a/kernel/unwind/eh_frame_debug.h b/kernel/unwind/eh_frame_debug.h
new file mode 100644
index 000000000000..5a3e4e7f065a
--- /dev/null
+++ b/kernel/unwind/eh_frame_debug.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EH_FRAME_DEBUG_H
+#define _EH_FRAME_DEBUG_H
+
+#include <linux/eh_frame.h>
+#include "eh_frame.h"
+
+#ifdef CONFIG_DYNAMIC_DEBUG
+
+#define dbg(fmt, ...)							\
+	pr_debug("%s (%d): " fmt, current->comm, current->pid, ##__VA_ARGS__)
+
+#else /* !CONFIG_DYNAMIC_DEBUG */
+
+#define dbg(args...)			no_printk(args)
+
+#endif /* !CONFIG_DYNAMIC_DEBUG */
+
+#endif /* _EH_FRAME_DEBUG_H */
-- 
2.53.0

