Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08133A75BB
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 06:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381529; cv=none; b=HMUTNYAXtMfahToR/SA7bJCQv8sGVsouWPytICzUWX4jNj2fFxRAPJjrvvs3Funysu7Vzpt/Wlumv5tR+pc7d9BK2DgqCcTfGWJJ0zHvEHr81icjj7fJ67fahcvKZgJ/RF73fdNhtB2vuyVFUDPUjmRBms6oZlxSacFuTC6BOkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381529; c=relaxed/simple;
	bh=uggu9Ed4XgP8/oXGEguF4UCtlrWJYr5XzPWI3Iz/dyc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u9h08FMRVO9YbKBoXhNvx6Ryfhy/blPO93ijBxgPyvTqAC+Oy2M5hn/bDihE7alpBulVbLSbQvXz2C04D16wk4mm43viZwKA7/FogWNFsD6nKIf07aG8ScxPlonZMdJtf3SUhuLgDOHZeOgcyLlQ3NCkpKY2j1fzBasn6QXrrSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bz4w//hF; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bz4w//hF"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137ea73393cso4577745c88.0
        for <linux-s390@vger.kernel.org>; Mon, 01 Jun 2026 23:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780381527; x=1780986327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yYKqXq805w0wcFXBmJBfrrbsatOJmwPurkk7tKq881M=;
        b=bz4w//hFF78+7LixCM/Fhr1E4g1C8RgduWVuNHprrUvwvhqg7UyRytFg37R7Xs/eGj
         1NDi9xtIhvqo2U//7IcrkKDJ8PGeGJMIF8vMUMD7xi9X0CEB0EUPqb/JwkmFEMy/b8Q9
         UzU74I+9l0S4x+nnDozGUMt2C+Om+Km5O6w8NmuZakjLU39nzO5JSmGDf4vYDMi8briE
         XuRpBRvDCyafkI5RdDslw1m6+cMBpwa5e6bjwQigTn36jtr9YiUZCI9+EXBRdMj+SSMf
         bF7OU5U5OFlAos/XpsKkrliWoAY4AIScf3JAate7mhMtjo2J2A9j86Wsrq3kgS0fFGW2
         cpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780381527; x=1780986327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yYKqXq805w0wcFXBmJBfrrbsatOJmwPurkk7tKq881M=;
        b=fQaxShxjNeMI7S0HExbKzNSu+xUh15k1IRsfHXTjZsT4X1ibr+HChxZTTHf0MiNzRc
         BA6iyeTqimBg3IasUz8oCr7cSDCMCndqi8F5o2XSd0QbNn2IZUY01sh/Ibg1F1X8msWi
         CsdQiyACmnE/gIW/V6MyEhMsmBm9JXixXLsaoCohNvQwBOTeNuiFrx9Fmas6YkhwxA9p
         N7X4NpiakufJWtHOLsOPhl09B0diwF+rGBZYZVgZRn8fnF5jKld7S8IgEloM7S/2xw0E
         sUQI9k10mcDnJpebzI6+HzP51P0JGQUTndqE5NddxIisfNJEF0qXWM9AWXVq1/VNj4Ch
         rprw==
X-Forwarded-Encrypted: i=1; AFNElJ+jS991Z1dG/RvYBlWAh/TZzSspusyXMu/diY/zJ2IInq6hysNNoEFrKBzaBZV7UlakYz6qdbU0qH1R@vger.kernel.org
X-Gm-Message-State: AOJu0YwommnAo/iz46jykbIp1FKOD9Pi8B5v6TgzIdikMBhbkNsHOscG
	Z6412bfgL/jA/kTtp651DBkUKTxoof2RXvE4MkUwE2aiHzxRdqhZCRQenxgGDRHimBmy/P3hlrY
	tmR9G+DkCAw==
X-Received: from dlea10-n2.prod.google.com ([2002:a05:701b:420a:20b0:12c:8ccc:748c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4393:b0:137:e532:f53f
 with SMTP id a92af1059eb24-137e532f5f8mr2730516c88.34.1780381526867; Mon, 01
 Jun 2026 23:25:26 -0700 (PDT)
Date: Mon,  1 Jun 2026 23:24:40 -0700
In-Reply-To: <20260602062452.2583619-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601065407.1597927-1-irogers@google.com> <20260602062452.2583619-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602062452.2583619-9-irogers@google.com>
Subject: [PATCH v11 08/19] perf sample-raw: Use perf_env e_machine rather than arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Use the e_machine rather than the arch to determine S390 and x86 types.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/sample-raw.c | 21 +++++++++++----------
 tools/perf/util/sample-raw.h |  6 +++++-
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/sample-raw.c b/tools/perf/util/sample-raw.c
index bcf442574d6e..e20b73c0c5bd 100644
--- a/tools/perf/util/sample-raw.c
+++ b/tools/perf/util/sample-raw.c
@@ -1,11 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include "sample-raw.h"
 
-#include <string.h>
+#include <elf.h>
 #include <linux/string.h>
-#include "evlist.h"
+
 #include "env.h"
+#include "evlist.h"
 #include "header.h"
-#include "sample-raw.h"
 #include "session.h"
 
 /*
@@ -14,14 +15,14 @@
  */
 void evlist__init_trace_event_sample_raw(struct evlist *evlist, struct perf_env *env)
 {
-	const char *arch_pf = perf_env__arch(env);
-	const char *cpuid = perf_env__cpuid(env);
+	uint16_t e_machine = perf_env__e_machine(env, /*e_flags=*/NULL);
 
-	if (arch_pf && !strcmp("s390", arch_pf))
+	if (e_machine == EM_S390) {
 		evlist->trace_event_sample_raw = evlist__s390_sample_raw;
-	else if (arch_pf && !strcmp("x86", arch_pf) &&
-		 cpuid && strstarts(cpuid, "AuthenticAMD") &&
-		 evlist__has_amd_ibs(evlist)) {
-		evlist->trace_event_sample_raw = evlist__amd_sample_raw;
+	} else if (e_machine == EM_X86_64 || e_machine == EM_386) {
+		const char *cpuid = perf_env__cpuid(env);
+
+		if (cpuid && strstarts(cpuid, "AuthenticAMD") && evlist__has_amd_ibs(evlist))
+			evlist->trace_event_sample_raw = evlist__amd_sample_raw;
 	}
 }
diff --git a/tools/perf/util/sample-raw.h b/tools/perf/util/sample-raw.h
index 896e9a87e373..c8d38c841c8c 100644
--- a/tools/perf/util/sample-raw.h
+++ b/tools/perf/util/sample-raw.h
@@ -2,7 +2,10 @@
 #ifndef __SAMPLE_RAW_H
 #define __SAMPLE_RAW_H 1
 
+#include <stdbool.h>
+
 struct evlist;
+struct perf_env;
 union perf_event;
 struct perf_sample;
 
@@ -12,4 +15,5 @@ bool evlist__has_amd_ibs(struct evlist *evlist);
 void evlist__amd_sample_raw(struct evlist *evlist, union perf_event *event,
 			    struct perf_sample *sample);
 void evlist__init_trace_event_sample_raw(struct evlist *evlist, struct perf_env *env);
-#endif /* __PERF_EVLIST_H */
+
+#endif /* __SAMPLE_RAW_H */
-- 
2.54.0.929.g9b7fa37559-goog

