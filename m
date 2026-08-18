Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DDA318BA8;
	Tue, 18 Aug 2026 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064640; cv=none; b=n8n5YLrRlbMsK42unJouk5HkrBttIhG+byb0E5cUsSiBozF4PZ6NCjCt/g9T8FE9Zow8RT6ik1QxhtmwqTUYVfnUBxIA2QtCr2SEEDqpisVzVrrazULjNy+EAA5p0kGpgJwMwKK0/j39m+3uHarbclTNvJvEH/UtcDbXjfJySQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064640; c=relaxed/simple;
	bh=09Zi8Tthhl+ZVVEziNc/E61IazOn+tw78cTGwvV6nKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COX+0ZK8uwVFwCKXVwYCiM7Qzu12tZ/BtK8572PyeIx6X2lzeMVMyCFdimVcYV/SojijC/nM8Wl9EXPtyyUSXUHU17euzCe1cQGSX9iBh1CfcjQpJNTpwrwMHqb2YZ2ynqFcgmfMg9J+YpHrzgq/NwEpUthCbzMwoR+8rB9R/4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p58qJWui; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p58qJWui"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3pxL2831707;
	Tue, 18 Aug 2026 14:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fFyEmBqPHxpjU8j/9
	P+tl5drEECIF4jCQTJ4zpbmDvQ=; b=p58qJWuiv9fix22KBRnhxClNibK7wO9MF
	WFeU5rBQEM8BxwDEz5sztZKavpto1RyLUBy9OzsxzESaTkb0Ko23bn9ttfZNJQoc
	/KoXO4msteHqVb3liHmR9wGnpYfV/2+wqG4TGCQuAHb0fKDuxgkFMhG0hXgg/pY/
	IyytsSY0EVkwxEPuuNuAxGJmlXLANFu9kPdICoXoIFuG18rJ0USYX6VMx4UDH2Cs
	jPfN8yFM3MUanyJn6HNka3hHSsUfGeaTtGahclBUZ09869SXOT/j6Bh26BMwIoNd
	8x6l1iKyX5giW6PI/4pPAFd1ry+x+L9PrWlMu4gWQJ79NGDjBGLmw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqrvr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IEfH1I032407;
	Tue, 18 Aug 2026 14:50:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ybgc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IEo0rY11534722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 14:50:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E65C20040;
	Tue, 18 Aug 2026 14:50:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C8672004B;
	Tue, 18 Aug 2026 14:50:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 14:50:00 +0000 (GMT)
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
Subject: [RFC PATCH v1 10/25] unwind_user/eh_frame: Detect .eh_frame_hdr sections in executables
Date: Tue, 18 Aug 2026 16:49:39 +0200
Message-ID: <20260818144954.2320378-11-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX/5nSXbU3GVtB
 zlNbN+Ld3TAkNbV9FwJ9boImvND0aHqSU7ZBEb7QW2LMQMdfozLXqRHCe79ksy+9SVHVsX3GEO9
 9KdOXaftkCkq73PJqRG9uuIXpfmDeuiGo9fRwZnD3fqQC4E6KPfUQiYRAI8E8s78GxI1fQPJxq7
 Q9p4sLh4qaKTs7ai+kfCpcZNuLsrSOr/fdwvDAATPqO5t6QNflsMNpJHdnwQf8Qp6YCgBphx48r
 iD+AnLBca3qYkra/mQAFDhjzRIdoOKZnH9VJ9jtWUjWMft6axiIWjDSYhfWCwciVR7KKLMvDhRm
 6fgy9XCbXa2LWifBn2lTLAE3FMUuMFJmelNHG7N39Vf1MZ4TmDbCM2smAY2KLDCf8T5G5oZBWLg
 wcxUPhQk4FgLOocal3zhgSYnTU6PRKH9STCpMu5LNNOpwxuNyvQR4S43Rbae2jQWL9pKYwltUPO
 P7/3JPcba1dAAWX6agQ==
X-Proofpoint-ORIG-GUID: ClqFjA_j_kL3f2BEpke6kmFIdkqgCqvF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX0bfV/B1X36Xx
 dF7VORzxaJkUSmwpZfk2ofpiFtU1mpwad4BNP3tGceLR12VLVu2rfrY99HEJZTTby3Dkdoz/fQ/
 PRPj9j91a4Ruzuc87ghm+3WIs7Rt8k4=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a84711d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=DTHPRnzGk-c2I6QTfOIA:9
X-Proofpoint-GUID: 77TD-xJ2uchAasDAyFIZ00spHfed0Ezv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180107

When loading an ELF executable, automatically detect .eh_frame_hdr
sections and associate them with the mm_struct.

Based on Josh Poimboeuf's, Steven Rostedt's, and my unwind user sframe
implementation.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 fs/binfmt_elf.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 16a56b6b3f6c..8c1cdd8318c5 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -48,6 +48,7 @@
 #include <linux/uaccess.h>
 #include <uapi/linux/rseq.h>
 #include <linux/rseq.h>
+#include <linux/eh_frame.h>
 #include <asm/param.h>
 #include <asm/page.h>
 
@@ -637,6 +638,23 @@ static inline int make_prot(u32 p_flags, struct arch_elf_state *arch_state,
 	return arch_elf_adjust_prot(prot, arch_state, has_interp, is_interp);
 }
 
+static void elf_add_eh_frame(const struct elf_phdr *text,
+			     const struct elf_phdr *eh_frame,
+			     unsigned long base_addr)
+{
+	unsigned long eh_frame_start, eh_frame_end,
+		      text_start, text_end;
+
+	eh_frame_start = base_addr + eh_frame->p_vaddr;
+	eh_frame_end   = eh_frame_start + eh_frame->p_memsz;
+
+	text_start   = base_addr + text->p_vaddr;
+	text_end     = text_start + text->p_memsz;
+
+	/* Ignore return value, eh_frame[_hdr] section isn't critical */
+	eh_frame_add_section(eh_frame_start, eh_frame_end, text_start, text_end);
+}
+
 /* This is much more generalized than the library routine read function,
    so we keep this separate.  Technically the library read function
    is only provided so that we can read a.out libraries that have
@@ -647,7 +665,7 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 		unsigned long no_base, struct elf_phdr *interp_elf_phdata,
 		struct arch_elf_state *arch_state)
 {
-	struct elf_phdr *eppnt;
+	struct elf_phdr *eppnt, *eh_frame_phdr = NULL;
 	unsigned long load_addr = 0;
 	int load_addr_set = 0;
 	unsigned long error = ~0UL;
@@ -673,7 +691,8 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 
 	eppnt = interp_elf_phdata;
 	for (i = 0; i < interp_elf_ex->e_phnum; i++, eppnt++) {
-		if (eppnt->p_type == PT_LOAD) {
+		switch (eppnt->p_type) {
+		case PT_LOAD: {
 			int elf_type = MAP_PRIVATE;
 			int elf_prot = make_prot(eppnt->p_flags, arch_state,
 						 true, true);
@@ -712,6 +731,19 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 				error = -ENOMEM;
 				goto out;
 			}
+			break;
+		}
+		case PT_GNU_EH_FRAME:
+			eh_frame_phdr = eppnt;
+			break;
+		}
+	}
+
+	if (eh_frame_phdr) {
+		eppnt = interp_elf_phdata;
+		for (i = 0; i < interp_elf_ex->e_phnum; i++, eppnt++) {
+			if (eppnt->p_flags & PF_X && eppnt->p_type == PT_LOAD)
+				elf_add_eh_frame(eppnt, eh_frame_phdr, load_addr);
 		}
 	}
 
@@ -837,6 +869,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	unsigned long error;
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
 	struct elf_phdr *elf_property_phdata = NULL;
+	struct elf_phdr *eh_frame_phdr = NULL;
 	unsigned long elf_brk;
 	bool brk_moved = false;
 	int retval, i;
@@ -945,6 +978,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 				executable_stack = EXSTACK_DISABLE_X;
 			break;
 
+		case PT_GNU_EH_FRAME:
+			eh_frame_phdr = elf_ppnt;
+			break;
+
 		case PT_LOPROC ... PT_HIPROC:
 			retval = arch_elf_pt_proc(elf_ex, elf_ppnt,
 						  bprm->file, false,
@@ -1242,6 +1279,14 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			elf_brk = k;
 	}
 
+	if (eh_frame_phdr) {
+		for (i = 0, elf_ppnt = elf_phdata;
+		     i < elf_ex->e_phnum; i++, elf_ppnt++) {
+			if (elf_ppnt->p_flags & PF_X && elf_ppnt->p_type == PT_LOAD)
+				elf_add_eh_frame(elf_ppnt, eh_frame_phdr, load_bias);
+		}
+	}
+
 	e_entry = elf_ex->e_entry + load_bias;
 	phdr_addr += load_bias;
 	elf_brk += load_bias;
-- 
2.53.0

