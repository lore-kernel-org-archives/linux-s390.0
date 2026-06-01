Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C24383C86
	for <linux-s390@vger.kernel.org>; Mon,  1 Jun 2026 06:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296874; cv=none; b=QCcIFTHWDjXYZH5sdMxoaaquA9ptDcWD/PDLhFHUOJDhX5siM330cajF3nCPvfVv/Hvb5gkyRMrcBjjWurM+TgV6cvFag4mfLymGrH81VhxbzudJSZuOGXGJhLIqZ0Tr/sWWpWKeR6BnsmeS6fse6qXPrKeX3/lSzE8yqTmYoYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296874; c=relaxed/simple;
	bh=/QMmXJBKQNb4K6haqK+hePSPO4Dmf7jySR0tC2WlGiw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gLK+nNRiD8LUcJo2Nxxs8Jm0vxK0cPMEn4XN3TRQCR0dmkVmhk2cLNCt7zE0dxDfiylxfQn9BdIlodclSdm/9wg71pKUuytmQTps1pIjGc9HgPAojlBT7Jhluukr9QtHD4XTCSUxsjyWrI5rkR0mJhWhxKzainG4SgFRvNuCbMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vK3h5V62; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vK3h5V62"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137e32a2facso2221780c88.1
        for <linux-s390@vger.kernel.org>; Sun, 31 May 2026 23:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780296871; x=1780901671; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HaYSSe7MrXhzop/WSi7SwbpLSKEaLKbhaDVaNUSRXpI=;
        b=vK3h5V62BNA3uVNX2sXn7dvr3FdKsr7xv67UM3M+8R01bAVPxUYd29t4NYjXzboLsZ
         uH4+swlrNWVAly9gCIvgj+tTOVwP5WYLMfRCSZjyTFQLexcdyc+fl866li3nbtou8ZBt
         91FsPSgTl6ffKg1MEiSOVUjpCupqWEpFd1mQpF52LQBWW70zN/ojv7S+apUKK9ljNVsH
         HPaqLvm9efIBX/Bms0AAPXwuVGi7cTqr9eqoqh2QBXUI+GWM/rSD1sqBHHxDvhrP6InJ
         ODZOEQsXivFi0vetmS2cDqDeTREUy6rI4FQ1nMEsMs2Iwtpg10fDokTeNOnXmwMYgtJx
         cRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780296871; x=1780901671;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HaYSSe7MrXhzop/WSi7SwbpLSKEaLKbhaDVaNUSRXpI=;
        b=EBYm969KKSfBCVZ698O9VRidAPF6XwGaAiui/P5n72CGmmANbYQcThQHBu4nbLM3WB
         rDDwy0fay4fvufdpmKnfp+PTEUlljC81rHt3kJCvJz0sXRCYxwxyxsW49Kbq31O7/r4H
         IAL3Gk+Aij04WQEzkF+9N1HYdkFy3aTc1h+dj38wnrLigiYAFwnntusjQsMjR6CeEDbm
         s2Jy9UBHZUDz1NQyPc1XNYMTYbLUl9S9UgDTBdYYbPpelTfUfQc2rxm7YStSsGBTvjcY
         qU/FZD1JJ7/FQZfSBmZ5q1Ljj1LPMSCRO1bWQw1v1fGKlnJh2xk4SAawI2SosoN+NBEd
         dueA==
X-Forwarded-Encrypted: i=1; AFNElJ9VsPGwE82agQ12rp+gqs41mLhTpGTCaEAQZrrSvrrCzVBg0Mx9rSqhzzoNPnJQGV0pEWwfNNbXiael@vger.kernel.org
X-Gm-Message-State: AOJu0YwyK1D4oX0XAziSQInZtXr2YqfJYwAaTum9mn7jGn2/YmFljarC
	qMyrzFYO+yvtrZuh2ODhzGovuXz1CbCHJSYcocbU3YxT/1XFcleEb0SW2SSiYXujwtRWoxMmBfv
	Gintq/6So0w==
X-Received: from dlbbo37.prod.google.com ([2002:a05:7022:43a5:b0:135:d0cf:93de])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:117:b0:11a:e426:911a
 with SMTP id a92af1059eb24-137d3f132bbmr5142893c88.15.1780296870856; Sun, 31
 May 2026 23:54:30 -0700 (PDT)
Date: Sun, 31 May 2026 23:53:58 -0700
In-Reply-To: <20260601065407.1597927-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503002248.1040791-1-irogers@google.com> <20260601065407.1597927-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601065407.1597927-10-irogers@google.com>
Subject: [PATCH v10 09/18] perf sort: Use perf_env e_machine rather than arch
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
2.54.0.823.g6e5bcc1fc9-goog

