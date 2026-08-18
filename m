Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756963A9852;
	Tue, 18 Aug 2026 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064636; cv=none; b=rKfE43YNgD4hcq7soBKHcyj6GVwWFFb4jrm3ZO4huP/Ah0bnhlQC+mZ9r7gA91a6+eCDWxTNduJO8jlJdXx/d85HSJZ/7zpyPOLWFES9Ij2lGOZVm9tr/KEyBFD6iZ/r/XJHVX+09MoIIGETOBRVbQtnjIv3LnQzldxhXyQcq6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064636; c=relaxed/simple;
	bh=lN8qqQ8zjEDTAgZ6kjHsMFZvNSfXO+JEbPkn4/MI/ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHxEdKysmqfndJLrj2zjb6AqWp/WYtV6SfVMf4TesxAmxK616PmyEOWM/DzkaaUCFam3VaIi3EQfSsGnHvHhdjSPj+EuAdiw7OGZpntpVZyHBhxA/pIFmD6Jxa4KLN/QNyWegXw1MrfujqgFcP8E/VBZZLoSDI0/JcJzqAzrwA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qTm2wqnr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qTm2wqnr"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3xUG402127;
	Tue, 18 Aug 2026 14:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pKBz1o/p432NUkHla
	qpUldZsAKwtSbndl7l42QkqzZo=; b=qTm2wqnr2CDTSw0peLuJGva+F0mBSzazq
	dR0gI6/8xCoIcmqs8oWkyhtZxKa5lqMg0P++LUaf8fiCynxcx5QkENh3K6wCdAiO
	pLniU8PF+gnIvmap6rRtOL+UR1ftf3pwg6xR+yCTcGxtbtP/UPgd4uzG2Pq6IHHp
	CeWp0VmiW5bNe6UKx5NwYl3r/KO9Ky7kUC7j4avJ9k6AKCvaut6UHwv3X6OT9G4X
	zZa6pCneO7z2OwzO+0Qs8dhZuYVTnoGWntiCEbGTyPA1VAU3c5Kbphs5WpefQ5Q6
	oI2uoYbSUS+2lhIJTxX26/NDTbtdcjusxXY7Eep2siSSaAuOw1f7g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhm0qmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IEfOqE029642;
	Tue, 18 Aug 2026 14:50:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngbhgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IEnx9943712888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 14:49:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4BEA20043;
	Tue, 18 Aug 2026 14:49:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51D582004B;
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
Subject: [RFC PATCH v1 08/25] unwind_user/eh_frame: Store .eh_frame_hdr section data in per-mm maple tree
Date: Tue, 18 Aug 2026 16:49:37 +0200
Message-ID: <20260818144954.2320378-9-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfXzI0waxrwv2MS
 5IDPuEW8JbHj05nrFWvNRPvtP4ZbfQlasvyw1/F1PlAX64H2dgXQZ9gBuqtSF+5HNcpFWHVvV6r
 zRGZE+KXQ0NbxqQ1kCHGJn5jG/SpcBEGhMQ+NThJdvJhAtOB8qkja/wz9k5BMB8JYz8G/bF8SUl
 rzEMfS/SWlBJSLFR63gZpaT+GrAkcwz4Ywiqou+cjZ04RfvgtQThi5W5Vwf359u5haJ9pMC97fB
 1K/OW6KziDh2F5VbFaMEnNORpAXAROc7JkkFCuipKhJ6L8eH7oD1tlpz6YfR5ke385l0l5oIWyq
 T82Pn2o3T6F/5DiGm60OVS1siHnXXZYD2Bwm+B810NBbfPm5J/wrrKZsPnqdhBuhY/MmXdI5/zz
 9qoQzZSLi2ELz3yVdSjFQ4j8lxIDnnWABx+n5UDKt5I0xhIV/L6oMXL9ykLDqASwajABwoWiDOh
 t+K1Jf/Uw6GfBZZvtOQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX+rjEIIw/UUnO
 PgGQh5TxKeUFH7DdGrHKHK31kktoKPX+Sqkd0c7zBVt0mbm3PHJLNBhNMmvJrFZWXkDKLuz3c7P
 lQwie2OZJCJzla7P/m5carbEt/NL9FQ=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a84711c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=XnyXtB0bseTY-2eMiq0A:9
X-Proofpoint-ORIG-GUID: FMU4cVuGnC3VDc_ukz2lE8oE7K8IE1Cu
X-Proofpoint-GUID: OWzBhcfdd0mD-kIJgwxxQIXbHIVGLM86
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180107

Associate .eh_frame_hdr sections with their mm by adding them to a
per-mm maple tree which is indexed by the corresponding text address
range.  A single .eh_frame_hdr section can be associated with multiple
text ranges.

Based on Josh Poimboeuf's, Steven Rostedt's, and my unwind user sframe
implementation.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 arch/x86/include/asm/mmu.h |  2 +-
 include/linux/eh_frame.h   | 20 +++++++++++
 include/linux/mm_types.h   |  3 ++
 kernel/fork.c              | 10 ++++++
 kernel/unwind/eh_frame.c   | 68 ++++++++++++++++++++++++++++++++++++--
 mm/init-mm.c               |  2 ++
 6 files changed, 101 insertions(+), 4 deletions(-)

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
index aaac2dd663d5..95df4911fd23 100644
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
@@ -19,14 +24,27 @@ struct eh_frame_section {
 	u8		binary_search_table_enc;
 };
 
+#define INIT_MM_EH_FRAME .eh_frame_mt = MTREE_INIT(eh_frame_mt, 0),
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
@@ -40,6 +58,8 @@ static inline int eh_frame_remove_section(unsigned long eh_frame_hdr_start)
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
index f0e2e131a9a5..c0d71818e197 100644
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
+	mt_init(&mm->eh_frame_mt);
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
index 8d2b638145bd..7bdf7589466a 100644
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
@@ -307,6 +309,7 @@ int eh_frame_add_section(unsigned long eh_frame_hdr_start,
 			 unsigned long text_start,
 			 unsigned long text_end)
 {
+	struct maple_tree *eh_frame_mt = &current->mm->eh_frame_mt;
 	struct mm_struct *mm = current->mm;
 	struct eh_frame_section *sec;
 	int ret;
@@ -349,15 +352,74 @@ int eh_frame_add_section(unsigned long eh_frame_hdr_start,
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
+static int __eh_frame_remove_section(struct mm_struct *mm,
+				     struct eh_frame_section *sec)
+{
+	if (!mtree_erase(&mm->eh_frame_mt, sec->text_start)) {
+		dbg("mtree_erase failed: text=%lx\n", sec->text_start);
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
+	unsigned long index = 0;
+	bool found = false;
+	int ret = 0;
+
+	guard(srcu)(&eh_frame_srcu);
+
+	mt_for_each(&mm->eh_frame_mt, sec, index, ULONG_MAX) {
+		if (sec->eh_frame_hdr_start == eh_frame_hdr_start) {
+			found = true;
+			ret |= __eh_frame_remove_section(mm, sec);
+		}
+	}
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

