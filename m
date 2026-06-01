Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D900383308
	for <linux-s390@vger.kernel.org>; Mon,  1 Jun 2026 06:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296874; cv=none; b=nUw8EhcmF9MabKRnzTXz044Ny6HIBKPQjICD4JPl7tWoGcs2j7WVFJzyfPmEQlXL0ETnmJUcnlsXBDXpJQ7DVsSuQJu434jqTMtDWuWMCVPsL44UMmMw/jYBgMbXsGrPzI5FpY8VL0F5+7L3VqAcTnq6o45taLNVgt9S1l1oRXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296874; c=relaxed/simple;
	bh=aypWcCWChxu4UgN3+4mGLRj5jbgQ/7vpfZhxtHZU+1I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=suDsN/AAYrbDkFZWTrCqZ8+C2Uyepu71085XoCU98xPAFB530e6v5szJsBSso4RLlGIxpt6HBUUoSKE1qWRKjpxcez8kf3vgc+lTOvyTOUyhAA9njCesh5QpLGHAqDdOZ+tJ5Vfw/RbpYQZzJMh+vE3IUq7T26hrBrvzmY6JG88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sX8fYHxd; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sX8fYHxd"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-3041ab826ddso17056988eec.0
        for <linux-s390@vger.kernel.org>; Sun, 31 May 2026 23:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780296869; x=1780901669; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VjPKO70Uw6tNKKfbzB4deN86ngAx0uxqS2L1F9dC/t8=;
        b=sX8fYHxdTi6roA/+OFmIcge4ReR0bn0L/uh7gXi0aUX3n+/gfKpZqG4K1nhHLBUIiW
         qnyF/CLNSm1oQwLE+Cd7+60bcN86RccENVvlxPANB/L7O7GxfjkZ2qEdAWhjf2IzYrl2
         ICRYxXUaKQ7xWbUUwH1nxUtd3NxlFMBB9x01t89ux2V+zImQWgNs4pqcrX481pKUgVT5
         dS4oTYzCIbWv0zMEVcX2I9Hr3iijIq648mj3jRPvvMclvkOe+90yPxsR4Eq2ebPtYOyk
         RbJmwUTVkYh7ziG5F55Wvx56aBkM7hjeMfGpF+Hl3T+lq6XImQgXr99Y1gwSrWUsXT32
         QrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780296869; x=1780901669;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VjPKO70Uw6tNKKfbzB4deN86ngAx0uxqS2L1F9dC/t8=;
        b=dZBkUIAG4XFkeEPCAy9Cf8tRIZmDMJvqvWWE/YdlRCJdhZdB46tq4JucIJZokBSYbK
         sRAMUhldryY4J7KTEpXWM8kD27dWvUd5wlr9tBmoc75l7akCdH5qhl3uLoxXnVpz7iTp
         lYc4nwn0mlfy+i1+U7p8cqdwbE1j0lwoGdseOtD/L2Uef15tzRDuHqisWtBKjm61HML2
         ddRkU8oNFAy6QCfObAxoBweqUPNz4bJkm0cnQkLMrPe819V9HyFHKG66tSl0LWEP1xdg
         MrKGNDYWCcFzVzRBcf7kgV0e2+wdh3bcs0Thu8I8LURYryvUkThDAjIlSyB6IhxuE0Mh
         CBgg==
X-Forwarded-Encrypted: i=1; AFNElJ8mJGeLOVbv1mwp7tpniG6FvDqglKLlIECe/2tFOA8ticTCGJ4QbIA6r/eClSRAsZWVWdpeO+8qnzP+@vger.kernel.org
X-Gm-Message-State: AOJu0YwT+4nUxc53hRNZlx11r9cfgfdGUKkSVpxx0wN8TfcaWYwx0Lua
	xjADqPGg7lYGam5tGnbq80b9XHCPbbDixj6ZdOXmtJ3yPIewuFaPt9/NnHHXN1ngbuhKZYSNoCC
	+K125LAQg5Q==
X-Received: from dyay11.prod.google.com ([2002:a05:693c:62cb:b0:304:eefd:96c6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:c87:b0:304:2e9b:8f57
 with SMTP id 5a478bee46e88-304fa6ef8a1mr4377062eec.34.1780296869235; Sun, 31
 May 2026 23:54:29 -0700 (PDT)
Date: Sun, 31 May 2026 23:53:57 -0700
In-Reply-To: <20260601065407.1597927-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503002248.1040791-1-irogers@google.com> <20260601065407.1597927-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601065407.1597927-9-irogers@google.com>
Subject: [PATCH v10 08/18] perf sample-raw: Use perf_env e_machine rather than arch
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
2.54.0.823.g6e5bcc1fc9-goog

