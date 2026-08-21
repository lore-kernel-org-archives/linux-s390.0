Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AEF40DB25;
	Fri, 21 Aug 2026 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342086; cv=none; b=DECiI78k0ZbJadJJl2wmLUGGbCjhGQ8s8OEWVRkOMXsl9KX7txl7jlEONaVV4GjqTVl++WYHsRSMfzjp+fmirEKe6ceiZs4HhonFhXQ43XDYte8KdRdH4dEs8faEGZN33924nxvQhEUuoEUXTyZOZm8/0LNHnKvfpirsdmmkUGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342086; c=relaxed/simple;
	bh=09Zi8Tthhl+ZVVEziNc/E61IazOn+tw78cTGwvV6nKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNcB260ytNXUcJlGGEZ9qF4M2cvoDblM0wBuVdUg0btX46gDEbO9bDIK101Lg24B1eujlrDavHMVb1o7xYS8YSHvAdJgzJrHGl2l0NVVxunHS7j7tDDUkQOqjEb2B2Sa22NLTC87zYy0wAjbJRU5lnexWO3C7m3cQgTkjU9orKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rHTvg4c0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rHTvg4c0"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIW6MP2254770;
	Fri, 21 Aug 2026 19:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fFyEmBqPHxpjU8j/9
	P+tl5drEECIF4jCQTJ4zpbmDvQ=; b=rHTvg4c0tpG0jc+0m09RG2JBzcAqL4SS2
	RuOgtXd79HIUlJ7RIdGQ7uP2iY75+OTvlDqAt9xiRCDBbvle1UWGQ+FJjSrAL+Pz
	Wx6BkeoWQETyO23fya38uZoj1+OrOptMy/M6e7sX5vB/USZkrwZ1E9dfF/6YCY5X
	gIOwTSIfqaF78ulv5DczCs9TG3QDOJRR2JKd5fbjkhKLZx6gZ1NMpRJqLNfk7RMk
	sS5c/Vymo7lgCyw5GqjAGWwQLtjVS888U6M561sXMYjhp3thwUyxJFP1tkSG00qf
	RvXbdvaMBAi85BOJ8IUhMqnjslYMMSRKVXHCQKfj0JsrTh7xe6gjg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4krkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfHFG020569;
	Fri, 21 Aug 2026 19:53:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqpupd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJr8ip42861024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:53:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1108C20040;
	Fri, 21 Aug 2026 19:53:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C66572004B;
	Fri, 21 Aug 2026 19:53:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:53:07 +0000 (GMT)
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
        Sam James <sam@gentoo.org>, Fangrui Song <i@maskray.me>
Subject: [RFC PATCH v2 10/24] unwind_user/eh_frame: Detect .eh_frame_hdr sections in executables
Date: Fri, 21 Aug 2026 21:52:45 +0200
Message-ID: <20260821195259.2688377-11-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821195259.2688377-1-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX1LAfFIvPD+Hx
 I5AbNO8kUSVGNJPWDQgtzJZq7wH0tp/2PvD9p3Kc+5VwuccbsU54hfdCvpI1NVFcMB3f7DAwHBD
 l2mG+2CqRoJKJeQrQAP2du7tUPbZHNE=
X-Proofpoint-GUID: _ISUaloIPJWI5IfSkdhC2jJ4Ln3Jz1MD
X-Proofpoint-ORIG-GUID: FgiNgdWvg_b-dAHk-xG20BzG0jo95Gcd
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a88aca9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=DTHPRnzGk-c2I6QTfOIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX2G167PKX76KQ
 S8IuhleKu0MyJJEF7LWz/msiVyk0YvSf+wqF41YlG16tjYMT4ALqMLmOgpLCwI1OPSJj1zqHdO2
 9oQdKLf7ivGfTzCQjoczBZ9cZfWDmnnNIOrBiGTA81fZrvRBlfDM1d+ZCkMteaZJOEcQKUooYj7
 eMwMyfijHXB0sJ9E+mDJtxgJqFkdN/EW5wCwvs4YqGsWXGIkomFMiTJ9tfwLJ5+nBB9pum1SWgK
 6chvOjT/e0j56EcBu6tf9fYT+08y4lPmqFXARkGQNtmxZfAbiRa+GQrwrornnKY/M8WGEk9/s2E
 yhbKZUKfc0S1ty6G0uAdiE40iIQhF1dET40V3a0Q8RxWaV7vam43/Xi3k3Egff63TCDIpGJOOuE
 q4r/HV/o8DnnKjZazsGnyxz71mO72J5iwc52tTjbSbL0ztUtvmg6X2NHPTI1KN3Y/A2GY4ThX3u
 K+xV28YPIz9B2qfKV3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210155

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

