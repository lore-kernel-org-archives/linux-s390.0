Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFC714A62D;
	Thu, 13 Jun 2024 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293217; cv=none; b=If2McNODmkWekw9y8tOOeGPb2JnyPi7ppFGUY1wjTIk5bW7PhiE4Jbt0Yl3e+zj9J9FHc8EbTyLbhSNlnojCM91LGuj4SdlsMPdMw/mO3FyYFgJCfCgmTUyqXsSaeQqobtac5lwuC9hanvQo+RbNpgOwr3Sh2KU+IC1YlyQyHkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293217; c=relaxed/simple;
	bh=CBwonVN5qdYsbauALkUyypsV6xqE8x/13TEVjhHgzYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILWka8JSpCami1U2YNSy5WCTYPoFMLuyZgXZsmn0Yatfow3RRw17xuW0U50+bYoIxM6B1J8RNE32aUgqa47t1FHKtBeDMLPV356vborGBVOaMIn6Rb7RY9TwUskt6Id4XXX/6gvAkFZACzigkf89BNbalE40DseLgOM2Yfo0mKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qK+vecRb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qK+vecRb"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DFaxh5028926;
	Thu, 13 Jun 2024 15:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=EtpzWUsKPF6Xq
	g09UGXz7IHFcSozBdT63cYyYIkbG/E=; b=qK+vecRbYYzCJkRsHBWubrva3REep
	w/L05qAPzmCKy04ck7vhAnXHPdQL7ZgY4AB0/HwhxaazpXScZzYfEI7dT2/HXWEQ
	sK6/3glkhSZDbHnN3sJeK1GUk6U8wd3J5meIeDstRJEMRWqT7aHpxfePPMVFag4G
	wT4UdP62uM8MtrSW2QWQa09IjK1EVvq3NzwKhJ+N3BQxJpkT9oBvYST3Ljo/8G7X
	LSyp1nWkVWc7Ywi81lW8IyUbgTH6UASVaM1n9CfRpdAUt0SefudhICkZlF1fUC63
	gCQ2yuJj8651Sly70S2kImGowL4ZHICA2AxR/mgD8iysnBsEdRexIi7bA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yr320r32t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 15:39:46 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45DFdjpx002434;
	Thu, 13 Jun 2024 15:39:45 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yr320r32q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 15:39:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45DEU7Sm008700;
	Thu, 13 Jun 2024 15:39:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yn4b3rk0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 15:39:44 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45DFddjr52036052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 15:39:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB49C2005A;
	Thu, 13 Jun 2024 15:39:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 783B82006C;
	Thu, 13 Jun 2024 15:39:38 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Jun 2024 15:39:38 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 11/35] kmsan: Allow disabling KMSAN checks for the current task
Date: Thu, 13 Jun 2024 17:34:13 +0200
Message-ID: <20240613153924.961511-12-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240613153924.961511-1-iii@linux.ibm.com>
References: <20240613153924.961511-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LKpz0MVqEHZkt6RKhjF39DHCXdemLjnE
X-Proofpoint-ORIG-GUID: 4diWKsJb6QpzSM8Rww7A3YFM9_vI0f-x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_09,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130112

Like for KASAN, it's useful to temporarily disable KMSAN checks around,
e.g., redzone accesses. Introduce kmsan_disable_current() and
kmsan_enable_current(), which are similar to their KASAN counterparts.

Make them reentrant in order to handle memory allocations in interrupt
context. Repurpose the allow_reporting field for this.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 Documentation/dev-tools/kmsan.rst |  4 ++--
 include/linux/kmsan.h             | 24 ++++++++++++++++++++++++
 include/linux/kmsan_types.h       |  2 +-
 mm/kmsan/core.c                   |  1 -
 mm/kmsan/hooks.c                  | 18 +++++++++++++++---
 mm/kmsan/report.c                 |  7 ++++---
 tools/objtool/check.c             |  2 ++
 7 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/Documentation/dev-tools/kmsan.rst b/Documentation/dev-tools/kmsan.rst
index 323eedad53cd..022a823f5f1b 100644
--- a/Documentation/dev-tools/kmsan.rst
+++ b/Documentation/dev-tools/kmsan.rst
@@ -338,11 +338,11 @@ Per-task KMSAN state
 ~~~~~~~~~~~~~~~~~~~~
 
 Every task_struct has an associated KMSAN task state that holds the KMSAN
-context (see above) and a per-task flag disallowing KMSAN reports::
+context (see above) and a per-task counter disallowing KMSAN reports::
 
   struct kmsan_context {
     ...
-    bool allow_reporting;
+    unsigned int depth;
     struct kmsan_context_state cstate;
     ...
   }
diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
index fe6c2212bdb1..23de1b3d6aee 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -239,6 +239,22 @@ void kmsan_unpoison_entry_regs(const struct pt_regs *regs);
  */
 void *kmsan_get_metadata(void *addr, bool is_origin);
 
+/*
+ * kmsan_enable_current(): Enable KMSAN for the current task.
+ *
+ * Each kmsan_enable_current() current call must be preceded by a
+ * kmsan_disable_current() call. These call pairs may be nested.
+ */
+void kmsan_enable_current(void);
+
+/*
+ * kmsan_disable_current(): Disable KMSAN for the current task.
+ *
+ * Each kmsan_disable_current() current call must be followed by a
+ * kmsan_enable_current() call. These call pairs may be nested.
+ */
+void kmsan_disable_current(void);
+
 #else
 
 static inline void kmsan_init_shadow(void)
@@ -338,6 +354,14 @@ static inline void kmsan_unpoison_entry_regs(const struct pt_regs *regs)
 {
 }
 
+static inline void kmsan_enable_current(void)
+{
+}
+
+static inline void kmsan_disable_current(void)
+{
+}
+
 #endif
 
 #endif /* _LINUX_KMSAN_H */
diff --git a/include/linux/kmsan_types.h b/include/linux/kmsan_types.h
index 929287981afe..dfc59918b3c0 100644
--- a/include/linux/kmsan_types.h
+++ b/include/linux/kmsan_types.h
@@ -31,7 +31,7 @@ struct kmsan_context_state {
 struct kmsan_ctx {
 	struct kmsan_context_state cstate;
 	int kmsan_in_runtime;
-	bool allow_reporting;
+	unsigned int depth;
 };
 
 #endif /* _LINUX_KMSAN_TYPES_H */
diff --git a/mm/kmsan/core.c b/mm/kmsan/core.c
index 95f859e38c53..81b22220711a 100644
--- a/mm/kmsan/core.c
+++ b/mm/kmsan/core.c
@@ -43,7 +43,6 @@ void kmsan_internal_task_create(struct task_struct *task)
 	struct thread_info *info = current_thread_info();
 
 	__memset(ctx, 0, sizeof(*ctx));
-	ctx->allow_reporting = true;
 	kmsan_internal_unpoison_memory(info, sizeof(*info), false);
 }
 
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index b408714f9ba3..267d0afa2e8b 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -39,12 +39,10 @@ void kmsan_task_create(struct task_struct *task)
 
 void kmsan_task_exit(struct task_struct *task)
 {
-	struct kmsan_ctx *ctx = &task->kmsan_ctx;
-
 	if (!kmsan_enabled || kmsan_in_runtime())
 		return;
 
-	ctx->allow_reporting = false;
+	kmsan_disable_current();
 }
 
 void kmsan_slab_alloc(struct kmem_cache *s, void *object, gfp_t flags)
@@ -424,3 +422,17 @@ void kmsan_check_memory(const void *addr, size_t size)
 					   REASON_ANY);
 }
 EXPORT_SYMBOL(kmsan_check_memory);
+
+void kmsan_enable_current(void)
+{
+	KMSAN_WARN_ON(current->kmsan_ctx.depth == 0);
+	current->kmsan_ctx.depth--;
+}
+EXPORT_SYMBOL(kmsan_enable_current);
+
+void kmsan_disable_current(void)
+{
+	current->kmsan_ctx.depth++;
+	KMSAN_WARN_ON(current->kmsan_ctx.depth == 0);
+}
+EXPORT_SYMBOL(kmsan_disable_current);
diff --git a/mm/kmsan/report.c b/mm/kmsan/report.c
index c79d3b0d2d0d..92e73ec61435 100644
--- a/mm/kmsan/report.c
+++ b/mm/kmsan/report.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/console.h>
+#include <linux/kmsan.h>
 #include <linux/moduleparam.h>
 #include <linux/stackdepot.h>
 #include <linux/stacktrace.h>
@@ -158,12 +159,12 @@ void kmsan_report(depot_stack_handle_t origin, void *address, int size,
 
 	if (!kmsan_enabled)
 		return;
-	if (!current->kmsan_ctx.allow_reporting)
+	if (current->kmsan_ctx.depth)
 		return;
 	if (!origin)
 		return;
 
-	current->kmsan_ctx.allow_reporting = false;
+	kmsan_disable_current();
 	ua_flags = user_access_save();
 	raw_spin_lock(&kmsan_report_lock);
 	pr_err("=====================================================\n");
@@ -216,5 +217,5 @@ void kmsan_report(depot_stack_handle_t origin, void *address, int size,
 	if (panic_on_kmsan)
 		panic("kmsan.panic set ...\n");
 	user_access_restore(ua_flags);
-	current->kmsan_ctx.allow_reporting = true;
+	kmsan_enable_current();
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0a33d9195b7a..01237d167223 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1202,6 +1202,8 @@ static const char *uaccess_safe_builtin[] = {
 	"__sanitizer_cov_trace_switch",
 	/* KMSAN */
 	"kmsan_copy_to_user",
+	"kmsan_disable_current",
+	"kmsan_enable_current",
 	"kmsan_report",
 	"kmsan_unpoison_entry_regs",
 	"kmsan_unpoison_memory",
-- 
2.45.1

