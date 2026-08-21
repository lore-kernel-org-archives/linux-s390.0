Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDA740EB88;
	Fri, 21 Aug 2026 19:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342016; cv=none; b=AXW1CyCEPpIkhCzFcIodE0le3B4m1GrZAbyXXvUJISfqwdLCzvHHq4g0Gihk+3ODi5YapW2AaV1AcWn5r5IQEQam7wRlZucLXSNHxCEVyyX0Oh7/4cogi9F1ici4mWDhdZxWZ4HfviRtqWaILj6yYrZ6GWiidGj1I289cVU6+r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342016; c=relaxed/simple;
	bh=+FII3ZleZb3oyEqGkP8JYRC62Ua6H8UV4CkPYFoBSS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sWQPe7y0VFyrCmQ3Tf4r/A2GX5c5aiJnPWXNHvdytK6gqi5A8zM7nStH+L9KfebUJpsKTyuH2n+N0UapaCvbNhOiGNQ649mcXMzl/79tX4zd9wEiq2ZEfB55gExdb2ZLBLVdwhN4goYrfamGhG4vJ1CzzcW3QzKvDm5QTGTIIdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BxBzHINU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BxBzHINU"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIViSn1237447;
	Fri, 21 Aug 2026 19:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zNEI/rvzWWiCdBJ45
	dXHM6TCzn9R2LbS7/L7IPC1vYA=; b=BxBzHINUHVTeZ/UVLbCnM1gU3NxkTbczp
	lOMcl981/fyHGanXxcLdVIBFmMWeT2BSdtsyQXWdRC7UkUMclAzsjHeQe5iFyo4N
	/HlBIlgdpjgDbZVMM/PUtyloCBrG6dlBhSxps5yFqkdrAkJ7Tfsp8rcUckZXNKqf
	EW/a3ndHzDkWmGqyR1/1tctZnwOS7SHSMQTSeJRr8uDh/SHez9Xgczo/shJ/FxI6
	2aP5dUBn0QikmJM/8PdLiF2QV6KXJX+BLt/dUgU5tu7ffB3YhtAmN3FjsyYhO6tp
	MVKoE7PMDTTUpe8SoR1Xx4mUn1UmrAOLkiWl41kk3TkP1qk1EFTsg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu2kr0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfIo1016590;
	Fri, 21 Aug 2026 19:53:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhpnkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJr96a45679054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:53:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6855820040;
	Fri, 21 Aug 2026 19:53:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AB2F2004B;
	Fri, 21 Aug 2026 19:53:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:53:09 +0000 (GMT)
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
Subject: [RFC PATCH v2 15/24] unwind_user/eh_frame: Duplicate registered .eh_frame[_hdr] section data on clone/fork
Date: Fri, 21 Aug 2026 21:52:50 +0200
Message-ID: <20260821195259.2688377-16-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a88acaa cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=D1Fd06331sE75a_1HDMA:9
X-Proofpoint-GUID: jEmS4Qqtg_JGoA_Q4fcGRFlzMHhtNirM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX7LYlMIt3RLpI
 V475rJgnO+2DGP5MuYXojcdJtxphmoc/P/kIL4FozlenH6bfeERRjepps3Nizlp0ZBO+82AnGKO
 /4OoW2EDoBUKNHfEMniTehW0tZpw25JrVJlhYaXTbC5L82Q37zmu+tI5KPP75k5QWRBrZr3hUpt
 dbskFlV6LCnRtrtWH/Zb9vneKlCwpZ5e6t9Neq5U6SPv+ZmXJEicfH6INceC91uAssnNZDOinto
 Nxba65V1bGDIwpFpVff3cAg/91VM9Ep4/tS//JKB5rjCwVyD4KWh7nY3fFZYGmG8j0AphW7Vuhj
 Vuz14iDFlP4ER5sM091mbIkIj/f6vutu1b5Ujtsh8tQSWfPlltoifcRDlyqnAuWOM3FbYUvLebX
 y8kGdcp6STjzJBe22vJ5yAc10bzXBKzs2QkTWNcPoBYSdZ8jZZShG9GerNfUgkYWXEnw3un+Q7M
 5gFVIshFUb0URKX2GrQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX21cqWDdLir9a
 h2Gj8g3xhw58tb/R5jr+vPgnJ6MVtGnhUs8Zu51qPepKnDAv6Jc5N8Gmj94M4Xjui4fO02Srz1L
 m+LXXUVOck7jRUnAArr5+LYHRcmcxCg=
X-Proofpoint-ORIG-GUID: _h4cdYqwFwZjAcD6Hm2pdlrqqzDZo3dt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210155

When duplicating a process' virtual memory mappings also duplicate all
of its registered .eh_frame_hdr sections stored in the per-mm maple tree
to enable stacktracing using eh_frame of the child process.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 include/linux/eh_frame.h       |  7 +++++
 kernel/unwind/eh_frame.c       | 48 ++++++++++++++++++++++++++++++++++
 kernel/unwind/eh_frame_debug.h |  7 +++++
 mm/mmap.c                      |  5 ++++
 4 files changed, 67 insertions(+)

diff --git a/include/linux/eh_frame.h b/include/linux/eh_frame.h
index 70b4f9d12828..3c88ab2f7858 100644
--- a/include/linux/eh_frame.h
+++ b/include/linux/eh_frame.h
@@ -32,6 +32,7 @@ struct eh_frame_section {
 #define EH_FRAME_MT_FLAGS (MT_FLAGS_USE_RCU)
 
 #define INIT_MM_EH_FRAME .eh_frame_mt = MTREE_INIT(eh_frame_mt, EH_FRAME_MT_FLAGS),
+extern int eh_frame_dup_mm(struct mm_struct *mm, struct mm_struct *oldmm);
 extern void eh_frame_free_mm(struct mm_struct *mm);
 
 extern int eh_frame_add_section(unsigned long eh_frame_hdr_start,
@@ -51,6 +52,12 @@ static inline bool current_has_eh_frame(void)
 #else /* !CONFIG_HAVE_UNWIND_USER_EH_FRAME */
 
 #define INIT_MM_EH_FRAME
+
+static inline int eh_frame_dup_mm(struct mm_struct *mm, struct mm_struct *oldmm)
+{
+	return 0;
+}
+
 static inline void eh_frame_free_mm(struct mm_struct *mm) {}
 
 static inline int eh_frame_add_section(unsigned long eh_frame_hdr_start,
diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
index b0be56e31508..1ac7308814a1 100644
--- a/kernel/unwind/eh_frame.c
+++ b/kernel/unwind/eh_frame.c
@@ -1501,6 +1501,54 @@ int eh_frame_remove_section(unsigned long eh_frame_hdr_start)
 	return 0;
 }
 
+static void __eh_frame_dup_section(struct eh_frame_section *sec,
+				   struct eh_frame_section *oldsec)
+{
+	sec->eh_frame_hdr_start	= oldsec->eh_frame_hdr_start;
+	sec->eh_frame_hdr_end	= oldsec->eh_frame_hdr_end;
+	sec->text_start		= oldsec->text_start;
+	sec->text_end		= oldsec->text_end;
+
+	sec->eh_frame_start		= oldsec->eh_frame_start;
+	sec->eh_frame_vma_end		= oldsec->eh_frame_vma_end;
+	sec->binary_search_table_start	= oldsec->binary_search_table_start;
+	sec->binary_search_table_end	= oldsec->binary_search_table_end;
+	sec->fde_count			= oldsec->fde_count;
+	sec->binary_search_table_enc	= oldsec->binary_search_table_enc;
+
+	dbg_dup(sec, oldsec);
+}
+
+int eh_frame_dup_mm(struct mm_struct *mm, struct mm_struct *oldmm)
+{
+	struct eh_frame_section *sec, *oldsec;
+	unsigned long index = 0;
+	int ret;
+
+	guard(srcu)(&eh_frame_srcu);
+
+	mt_for_each(&oldmm->eh_frame_mt, oldsec, index, ULONG_MAX) {
+		sec = kzalloc(sizeof(*sec), GFP_KERNEL_ACCOUNT);
+		if (!sec)
+			return -ENOMEM;
+
+		__eh_frame_dup_section(sec, oldsec);
+
+		ret = mtree_insert_range(&mm->eh_frame_mt,
+					 sec->text_start,
+					 sec->text_end - 1,
+					 sec, GFP_KERNEL_ACCOUNT);
+		if (ret)
+			goto err_free;
+	}
+
+	return 0;
+
+err_free:
+	free_section(sec);
+	return ret;
+}
+
 void eh_frame_free_mm(struct mm_struct *mm)
 {
 	struct eh_frame_section *sec;
diff --git a/kernel/unwind/eh_frame_debug.h b/kernel/unwind/eh_frame_debug.h
index bcb2d03ab9ab..e72e011ba539 100644
--- a/kernel/unwind/eh_frame_debug.h
+++ b/kernel/unwind/eh_frame_debug.h
@@ -41,6 +41,12 @@ static inline void dbg_init(struct eh_frame_section *sec)
 		sec->filename = kstrdup("(vma unknown???)", GFP_KERNEL_ACCOUNT);
 }
 
+static inline void dbg_dup(struct eh_frame_section *sec, struct eh_frame_section *oldsec)
+{
+	if (oldsec->filename)
+		sec->filename = kstrdup(oldsec->filename, GFP_KERNEL_ACCOUNT);
+}
+
 static inline void dbg_free(struct eh_frame_section *sec)
 {
 	kfree(sec->filename);
@@ -53,6 +59,7 @@ static inline void dbg_free(struct eh_frame_section *sec)
 #define dbg_sec_ehfh(args...)		no_printk(args)
 
 static inline void dbg_init(struct eh_frame_section *sec) {}
+static inline void dbg_dup(struct eh_frame_section *sec, struct eh_frame_section *oldsec) {}
 static inline void dbg_free(struct eh_frame_section *sec) {}
 
 #endif /* !CONFIG_DYNAMIC_DEBUG */
diff --git a/mm/mmap.c b/mm/mmap.c
index 2311ae7c2ff4..7715a799810e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -48,6 +48,7 @@
 #include <linux/sched/mm.h>
 #include <linux/ksm.h>
 #include <linux/memfd.h>
+#include <linux/eh_frame.h>
 
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
@@ -1844,6 +1845,9 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 			goto loop_out;
 		}
 	}
+	retval = eh_frame_dup_mm(mm, oldmm);
+	if (retval)
+		goto loop_out;
 	/* a new mm has just been created */
 	retval = arch_dup_mmap(oldmm, mm);
 loop_out:
@@ -1893,6 +1897,7 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 			vm_unacct_memory(charge);
 		}
 		__mt_destroy(&mm->mm_mt);
+		eh_frame_free_mm(mm);
 		/*
 		 * The mm_struct is going to exit, but the locks will be dropped
 		 * first.  Set the mm_struct as unstable is advisable as it is
-- 
2.53.0

