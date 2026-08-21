Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48EA40F750;
	Fri, 21 Aug 2026 19:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342099; cv=none; b=Kwwqek9Vbse4AJIRyt/FgundSlQC71mnt81WctuTdsvN6Sp1+lfgi8gpzwQgK9boXFBOiS/pAmgQdkuOHuKy9FFtkVyRirPodfMPspAnI/kZRAYcO21Gp7NdC834hQDYk3KWCfEZhS6cAArUF883bblqVGwPcI6TZC5kIqJN1tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342099; c=relaxed/simple;
	bh=Qic6tZo8dpzXnnNo0Q+j0ZFItm0ie2g/DHNovuqs3W8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjGiJN2DINomDxhqO6SAgBSmWK3WlqMEVVNY+PueilFPSbO4VguQJ5B0nuXRpaJIFb8irCWC6RSqYiq1KIhmrvlLp4ZHiZ7neHUb3KzDEDBwTc2wvnKeDhle9LX5QBaWGMBaUQKf8nIRPDhuB0zBcA5IflwK4sFW7YVCbnmWxvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KfFaVDIX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KfFaVDIX"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVYr32363665;
	Fri, 21 Aug 2026 19:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vNICQd0UftvHB9ldO
	irCCMEFxhzAhr23NSdN+vt2OTo=; b=KfFaVDIXpgbUhIufE73OJFH2Dd3r4UcoN
	e0qOZauVkhdet6ocnKsYKpqYVmRqebs+d0TgmCLkTVLjZUokmQaD1xtJKqlZXD1q
	8a6jOdvqU/gRkM4yCBfoblt6CI6oCZNIC1SwYrMHWjwIlckkeI2HijrruLA5o32O
	XtryKL56u0NvUiQNOn0ExcuINK5EMiAdgyKygmuQQMbfvPpn3AhuILy+gUGAOJf/
	q9xF56b8JZ9keDXGxbXAR/aECqGGT81ydJRWXHAiPfrNPcOtLo9aeCglDwmnepCw
	+TXpp9K/IivyBnqI24dfCDtupQbE7g58ltuXzyv/ozXdYtc3BEiOA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0uxks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfNE8020636;
	Fri, 21 Aug 2026 19:53:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqpupc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJr7SA45154636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:53:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C49620040;
	Fri, 21 Aug 2026 19:53:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 268C82004D;
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
Subject: [RFC PATCH v2 08/24] unwind_user/eh_frame: Store .eh_frame_hdr section data in per-mm maple tree
Date: Fri, 21 Aug 2026 21:52:43 +0200
Message-ID: <20260821195259.2688377-9-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a88aca8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=O9OvWtXlmRKlQNak06kA:9
X-Proofpoint-ORIG-GUID: 5CT6L7o0fB-Z1z-_49XVsCNeW5Cuy0l1
X-Proofpoint-GUID: bJLXSuhHLLoeZRKbnFQ_54uQglss9TFN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfXyq6JG32NR1tI
 vDW0RopSH9lggYmZR6mJmuZGfW9EfsXzlyxnQD2UExjoXp0Nmj9fr3gc/I5g9bA8VbAPTXbPLre
 CN80Yu/Joiiw7CiCCnv2WAA7sUYOz8s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX3OpNQkwkvA7t
 ekuctLGkiYGYIg5Sv6ffvna0g9daoD3qdMKyejoIa9CojzAgnIf0gj49OmCu3DTw3y7gdO0ihCr
 tjPofiEvwgDKt1L+TYDGI8dbG8Fjfhf490JNCrEwOUGhp77FPNytNcpuIZWUd1lM1q+3lyTJRf7
 xB0oUkdZfDncfgK7OfaKshmQrx5Rm1hHC7/2UXzkhJ7TDlVY8M3ENldlt80s7LEiJIxsW5n9DTI
 oEXu6NSEyb+U0PDNm6Q5EH8SL4fKBjl6OYXOldkQifVNJ84tqgQkK1IrIU/lXp1gE1jqDTtrDH+
 RrY7STXnpuT4ELvHkyJ5YA8JhmLQjCTEEpp84cOYz3w5ubqKkwBvUJCx7xjprI51EPFqGed8a3y
 P/W7J60gF0ud5ika8fdjo7kEwJzys3yjxWeDzaFnof1uFXfty+nlnaU+kl+4VVp0wWYUER7hVRa
 fLPOVHz5la+dH1CYkGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210155

Associate .eh_frame_hdr sections with their mm by adding them to a
per-mm maple tree which is indexed by the corresponding text address
range.  A single .eh_frame_hdr section can be associated with multiple
text ranges.

Based on Josh Poimboeuf's, Steven Rostedt's, and my unwind user sframe
implementation.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in RFC v2:
    - INIT_MM_EH_FRAME and mm_init_eh_frame(): Use MT_FLAGS_USE_RCU to
      enable concurrent eh_frame_mt read and write access. (Sashiko AI)
    - eh_frame_remove_section(): Fix ABA problem by using the advanced
      maple tree API to hold the internal spinlock while iterating over
      the eh_frame_mt and removing the eh_frame section(s). (Sashiko AI)

 arch/x86/include/asm/mmu.h |  2 +-
 include/linux/eh_frame.h   | 22 ++++++++++++
 include/linux/mm_types.h   |  3 ++
 kernel/fork.c              | 10 ++++++
 kernel/unwind/eh_frame.c   | 70 ++++++++++++++++++++++++++++++++++++--
 mm/init-mm.c               |  2 ++
 6 files changed, 105 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 0fe9c569d171..227a32899a59 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -87,7 +87,7 @@ typedef struct {
 	.context = {							\
 		.ctx_id = 1,						\
 		.lock = __MUTEX_INITIALIZER(mm.context.lock),		\
-	}
+	},
 
 void leave_mm(void);
 #define leave_mm leave_mm
diff --git a/include/linux/eh_frame.h b/include/linux/eh_frame.h
index aaac2dd663d5..c4279ee77c13 100644
--- a/include/linux/eh_frame.h
+++ b/include/linux/eh_frame.h
@@ -2,9 +2,14 @@
 #ifndef _LINUX_EH_FRAME_H
 #define _LINUX_EH_FRAME_H
 
+#include <linux/mm_types.h>
+#include <linux/srcu.h>
+
 #ifdef CONFIG_HAVE_UNWIND_USER_EH_FRAME
 
 struct eh_frame_section {
+	struct rcu_head	rcu;
+
 	unsigned long	eh_frame_hdr_start;
 	unsigned long	eh_frame_hdr_end;
 	unsigned long	text_start;
@@ -19,14 +24,29 @@ struct eh_frame_section {
 	u8		binary_search_table_enc;
 };
 
+#define EH_FRAME_MT_FLAGS (MT_FLAGS_USE_RCU)
+
+#define INIT_MM_EH_FRAME .eh_frame_mt = MTREE_INIT(eh_frame_mt, EH_FRAME_MT_FLAGS),
+extern void eh_frame_free_mm(struct mm_struct *mm);
+
 extern int eh_frame_add_section(unsigned long eh_frame_hdr_start,
 				unsigned long eh_frame_hdr_end,
 				unsigned long text_start,
 				unsigned long text_end);
 extern int eh_frame_remove_section(unsigned long eh_frame_hdr_start);
 
+static inline bool current_has_eh_frame(void)
+{
+	struct mm_struct *mm = current->mm;
+
+	return mm && !mtree_empty(&mm->eh_frame_mt);
+}
+
 #else /* !CONFIG_HAVE_UNWIND_USER_EH_FRAME */
 
+#define INIT_MM_EH_FRAME
+static inline void eh_frame_free_mm(struct mm_struct *mm) {}
+
 static inline int eh_frame_add_section(unsigned long eh_frame_hdr_start,
 				       unsigned long eh_frame_hdr_end,
 				       unsigned long text_start,
@@ -40,6 +60,8 @@ static inline int eh_frame_remove_section(unsigned long eh_frame_hdr_start)
 	return -ENOSYS;
 }
 
+static inline bool current_has_eh_frame(void) { return false; }
+
 #endif /* CONFIG_HAVE_UNWIND_USER_EH_FRAME */
 
 #endif /* _LINUX_EH_FRAME_H */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index b18c2b2e7d2c..ac51d6212e86 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1404,6 +1404,9 @@ struct mm_struct {
 #ifdef CONFIG_MM_ID
 		mm_id_t mm_id;
 #endif /* CONFIG_MM_ID */
+#ifdef CONFIG_HAVE_UNWIND_USER_EH_FRAME
+		struct maple_tree eh_frame_mt;
+#endif
 	} __randomize_layout;
 
 	/*
diff --git a/kernel/fork.c b/kernel/fork.c
index f0e2e131a9a5..dab67d2eb096 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -111,6 +111,7 @@
 #include <linux/tick.h>
 #include <linux/unwind_deferred.h>
 #include <linux/pgalloc.h>
+#include <linux/eh_frame.h>
 #include <linux/uaccess.h>
 
 #include <asm/mmu_context.h>
@@ -738,6 +739,7 @@ void __mmdrop(struct mm_struct *mm)
 	mm_pasid_drop(mm);
 	mm_destroy_cid(mm);
 	percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
+	eh_frame_free_mm(mm);
 
 	free_mm(mm);
 }
@@ -1082,6 +1084,13 @@ static void mmap_init_lock(struct mm_struct *mm)
 #endif
 }
 
+static void mm_init_eh_frame(struct mm_struct *mm)
+{
+#ifdef CONFIG_HAVE_UNWIND_USER_EH_FRAME
+	mt_init_flags(&mm->eh_frame_mt, EH_FRAME_MT_FLAGS);
+#endif
+}
+
 static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p)
 {
 	mt_init_flags(&mm->mm_mt, MM_MT_FLAGS);
@@ -1109,6 +1118,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p)
 	mm->pmd_huge_pte = NULL;
 #endif
 	mm_init_uprobes_state(mm);
+	mm_init_eh_frame(mm);
 	hugetlb_count_init(mm);
 	futex_mm_init(mm);
 
diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
index f25a0923e315..8cf19c5298fd 100644
--- a/kernel/unwind/eh_frame.c
+++ b/kernel/unwind/eh_frame.c
@@ -19,6 +19,8 @@
 #define dbg(fmt, ...)							\
 	pr_debug("%s (%d): " fmt, current->comm, current->pid, ##__VA_ARGS__)
 
+DEFINE_STATIC_SRCU(eh_frame_srcu);
+
 #define UNSAFE_GET_USER_INC(to, from, end, label)			\
 ({									\
 	typeof(to) __to;						\
@@ -310,6 +312,7 @@ int eh_frame_add_section(unsigned long eh_frame_hdr_start,
 			 unsigned long text_start,
 			 unsigned long text_end)
 {
+	struct maple_tree *eh_frame_mt = &current->mm->eh_frame_mt;
 	struct mm_struct *mm = current->mm;
 	struct eh_frame_section *sec;
 	int ret;
@@ -352,15 +355,76 @@ int eh_frame_add_section(unsigned long eh_frame_hdr_start,
 	if (ret)
 		goto err_free;
 
-	/* TODO nowhere to store it yet - just free it and return an error */
-	ret = -ENOSYS;
+	ret = mtree_insert_range(eh_frame_mt, sec->text_start, sec->text_end - 1,
+				 sec, GFP_KERNEL_ACCOUNT);
+	if (ret) {
+		dbg("mtree_insert_range failed: text=%lx-%lx\n",
+		    sec->text_start, sec->text_end);
+		goto err_free;
+	}
+
+	return 0;
 
 err_free:
 	free_section(sec);
 	return ret;
 }
 
+static void eh_frame_free_srcu(struct rcu_head *rcu)
+{
+	struct eh_frame_section *sec = container_of(rcu, struct eh_frame_section, rcu);
+
+	free_section(sec);
+}
+
+static int __eh_frame_remove_section(struct ma_state *mas,
+				     struct eh_frame_section *sec)
+{
+	if (mas_erase(mas) != sec) {
+		dbg("mas_erase failed: text=%lx\n", sec->text_start);
+		return -EINVAL;
+	}
+
+	call_srcu(&eh_frame_srcu, &sec->rcu, eh_frame_free_srcu);
+
+	return 0;
+}
+
 int eh_frame_remove_section(unsigned long eh_frame_hdr_start)
 {
-	return -ENOSYS;
+	struct mm_struct *mm = current->mm;
+	struct eh_frame_section *sec;
+	MA_STATE(mas, &mm->eh_frame_mt, 0, 0);
+	bool found = false;
+	int ret = 0;
+
+	guard(srcu)(&eh_frame_srcu);
+
+	mtree_lock(&mm->eh_frame_mt);
+	mas_for_each(&mas, sec, ULONG_MAX) {
+		if (sec->eh_frame_hdr_start == eh_frame_hdr_start) {
+			found = true;
+			ret |= __eh_frame_remove_section(&mas, sec);
+		}
+	}
+	mtree_unlock(&mm->eh_frame_mt);
+
+	if (!found || ret)
+		return -EINVAL;
+
+	return 0;
+}
+
+void eh_frame_free_mm(struct mm_struct *mm)
+{
+	struct eh_frame_section *sec;
+	unsigned long index = 0;
+
+	if (!mm)
+		return;
+
+	mt_for_each(&mm->eh_frame_mt, sec, index, ULONG_MAX)
+		free_section(sec);
+
+	mtree_destroy(&mm->eh_frame_mt);
 }
diff --git a/mm/init-mm.c b/mm/init-mm.c
index 3e792aad7626..25c26341fc4f 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -11,6 +11,7 @@
 #include <linux/atomic.h>
 #include <linux/user_namespace.h>
 #include <linux/iommu.h>
+#include <linux/eh_frame.h>
 #include <asm/mmu.h>
 
 #ifndef INIT_MM_CONTEXT
@@ -48,6 +49,7 @@ struct mm_struct init_mm = {
 #endif
 	.flexible_array	= MM_STRUCT_FLEXIBLE_ARRAY_INIT,
 	INIT_MM_CONTEXT(init_mm)
+	INIT_MM_EH_FRAME
 };
 
 void setup_initial_init_mm(void *start_code, void *end_code,
-- 
2.53.0

