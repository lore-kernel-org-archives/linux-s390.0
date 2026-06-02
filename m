Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55F13A784F
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 06:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381532; cv=none; b=I5gyNyNrqvVav6IGpmM0hJKcJkaiagLJKdnjJzk7MZsy3xillDWiu1z6y+jVhMBSgeVct2w3EGX1AjyBSeogt4/QA8001KWk9+NM/xO42/5NTvGNmuks7VJPiI6R2T637DZSrDIbT+0xRy/yMPlBnDEmx7BOkG7jZopxk/cl75w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381532; c=relaxed/simple;
	bh=F2CPix35dUffd03PpiODYF/Y/HMWspE7itJrwYnRzhA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B+r9ymLBKeTW04IaqipIKmZparSigfjyA0b7kQHHDzjtgWuUVN1NvjuLIdvwOkPTcfkjjLf6lKORirWBhvlMqBpV9sEz4c1VJLYIXjd3Nq8xZ4N0EXKw19V8p8eYYejASVBEXOf3jzsFDdZ/mucJWrCuJtBsEsRpgmY1DSzuECY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uCF8uO1P; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uCF8uO1P"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137dd516985so3698357c88.1
        for <linux-s390@vger.kernel.org>; Mon, 01 Jun 2026 23:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780381529; x=1780986329; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=amlPmLXVpdwhmAERUmH3g/HD3HbPai/uUl8j2YKLcm4=;
        b=uCF8uO1PJqt9HWOH7i0GzqZCWYntUdeDU1Zvnkl+j30DucnRDc36cBlYyYwGhg0Qbe
         3+u5KOqcAHvCxhr00J8DAG7+71Wk5Cd9BYQahy2iG7Dc2QwQoGXdQGQJpWnVayr1fs4Q
         EcyGi7KrfomcE5KDoUyjzVQJcm8FEpKfgxusCJF/bDaVl9buXS4WZbg+C502l2MObWaI
         25phoh9rpMICT4bshIPqZvgmN3zSo4CY5hNmmdIqjhj7n0aYAZN75ZZ+9kEGQXov3sa6
         Q7SCo+3Y+L+TnZ2vUhiu1yzI6DwcDdnWAMxh/WBb0UAVCG86z5CbOVeX6bIVkfd0Ot/P
         eg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780381529; x=1780986329;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amlPmLXVpdwhmAERUmH3g/HD3HbPai/uUl8j2YKLcm4=;
        b=auu/g8HBI0R4DMzFT6AufpZ3DziN7MCXecVVQpInuSRBzBJNTw9MDtf/bMWcgJSSid
         N3zeEwqWV70Rv6vg62NKIA1VaQvS9nR52lEKiAnkwOGxPr/JauUfmne4iQrdO9QZdsQg
         O3RgXsxT/uwKI4LtL61obqcwg55/XvrfIf7Gl8XtAlELovZpAvtIcWfI2TNpBmLTju5Y
         l5zmbYWQjot+p8xEVeW/P+yVfMYM84BxbYL4H5T2lq7hSbr7C8eOT/0tixWa9tES6qTM
         zuAqLqJzDe+MBNj/QB0O4o9uLphBiaKkrETc5lZQVgcNmd4GJg0NARHx9wPi6o69b+6A
         ntNw==
X-Forwarded-Encrypted: i=1; AFNElJ+ahn0s9NRUl6T/sddYuLzd1GBRyFMcIWck0EHSzcteiHQxGeS8UjJKyKCQYLyu/mF6g1sVh/Yxl8BD@vger.kernel.org
X-Gm-Message-State: AOJu0YzFm7/cM9qS0VuY2E1ajn0sPwrzIn7kM4FtON3UetzTUy6cVYEh
	Vfa8l4KTrHNB4xLzMGgC/hNq1BYZS4uGIunBrfyw7BDWnGXkiYX2KWItPK5LhKXfNylYfMPOZzv
	fif4MJmDwlQ==
X-Received: from dlbbq39.prod.google.com ([2002:a05:7022:6727:b0:135:cac1:fe63])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:60a4:b0:136:d237:b428
 with SMTP id a92af1059eb24-137d412b133mr6736941c88.22.1780381528852; Mon, 01
 Jun 2026 23:25:28 -0700 (PDT)
Date: Mon,  1 Jun 2026 23:24:41 -0700
In-Reply-To: <20260602062452.2583619-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601065407.1597927-1-irogers@google.com> <20260602062452.2583619-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602062452.2583619-10-irogers@google.com>
Subject: [PATCH v11 09/19] perf sort: Use perf_env e_machine rather than arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Use the e_machine rather than the arch to determine x86 or PPC types.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/sort.c | 58 +++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 0020089cb13c..90bc4a31bb55 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1,40 +1,45 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "sort.h"
+
 #include <ctype.h>
 #include <errno.h>
 #include <inttypes.h>
-#include <regex.h>
 #include <stdlib.h>
+
+#include <elf.h>
+#include <linux/kernel.h>
 #include <linux/mman.h>
+#include <linux/string.h>
 #include <linux/time64.h>
+
+#include <regex.h>
+
+#include "annotate-data.h"
+#include "annotate.h"
+#include "branch.h"
+#include "cacheline.h"
+#include "cgroup.h"
+#include "comm.h"
 #include "debug.h"
 #include "dso.h"
-#include "sort.h"
+#include "event.h"
+#include "evlist.h"
+#include "evsel.h"
 #include "hist.h"
-#include "cacheline.h"
-#include "comm.h"
+#include "machine.h"
 #include "map.h"
-#include "maps.h"
-#include "symbol.h"
 #include "map_symbol.h"
-#include "branch.h"
-#include "thread.h"
-#include "evsel.h"
-#include "evlist.h"
-#include "srcline.h"
-#include "strlist.h"
-#include "strbuf.h"
+#include "maps.h"
 #include "mem-events.h"
 #include "mem-info.h"
-#include "annotate.h"
-#include "annotate-data.h"
-#include "event.h"
-#include "time-utils.h"
-#include "cgroup.h"
-#include "machine.h"
 #include "session.h"
+#include "srcline.h"
+#include "strbuf.h"
+#include "strlist.h"
+#include "symbol.h"
+#include "thread.h"
+#include "time-utils.h"
 #include "trace-event.h"
-#include <linux/kernel.h>
-#include <linux/string.h>
 
 #ifdef HAVE_LIBTRACEEVENT
 #include <event-parse.h>
@@ -2673,9 +2678,10 @@ struct sort_dimension {
 
 static int arch_support_sort_key(const char *sort_key, struct perf_env *env)
 {
-	const char *arch = perf_env__arch(env);
+	uint16_t e_machine = perf_env__e_machine(env, /*e_eflags=*/NULL);
 
-	if (!strcmp("x86", arch) || !strcmp("powerpc", arch)) {
+	if (e_machine == EM_X86_64 || e_machine == EM_386 || e_machine == EM_PPC64 ||
+	    e_machine == EM_PPC) {
 		if (!strcmp(sort_key, "p_stage_cyc"))
 			return 1;
 		if (!strcmp(sort_key, "local_p_stage_cyc"))
@@ -2686,14 +2692,14 @@ static int arch_support_sort_key(const char *sort_key, struct perf_env *env)
 
 static const char *arch_perf_header_entry(const char *se_header, struct perf_env *env)
 {
-	const char *arch = perf_env__arch(env);
+	uint16_t e_machine = perf_env__e_machine(env, /*e_eflags=*/NULL);
 
-	if (!strcmp("x86", arch)) {
+	if (e_machine == EM_X86_64 || e_machine == EM_386) {
 		if (!strcmp(se_header, "Local Pipeline Stage Cycle"))
 			return "Local Retire Latency";
 		else if (!strcmp(se_header, "Pipeline Stage Cycle"))
 			return "Retire Latency";
-	} else if (!strcmp("powerpc", arch)) {
+	} else if (e_machine == EM_PPC64 || e_machine == EM_PPC) {
 		if (!strcmp(se_header, "Local INSTR Latency"))
 			return "Finish Cyc";
 		else if (!strcmp(se_header, "INSTR Latency"))
-- 
2.54.0.929.g9b7fa37559-goog

