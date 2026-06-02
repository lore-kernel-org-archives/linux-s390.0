Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AC13F4114
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413954; cv=none; b=XsDjKd3Cw+doabREoHPXUzOwJ0gJKAVLDNd/UnmVa+S47WilL65zKX/xoDFul8SsGY1J9FCc9ArTaHbdAWGIicyUqvxJ+1Z2ilEuIQ1nxnAM52DVD0kebBAW642ELpZrLa95KPnuK8guZoVxe7WZOL8YOLRmT3SXoO5c9ETSZNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413954; c=relaxed/simple;
	bh=uggu9Ed4XgP8/oXGEguF4UCtlrWJYr5XzPWI3Iz/dyc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a/iag1CAJBGX/irZkdgdLkVvq9PD2behqwDP3n9eO3ObpyX5IPjW8Ik4Deu5qQvPvAdwKYZDQMxMIVMIpMVTKxQ7Vz+Qb48Z6RnEqgnCAfhXARQyo/CPjdhDKkk4wLBX3ZzAtdSTzvYFimjoNzODQFnCLw3koZUV/0A6p5hUl1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bLL7YU71; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bLL7YU71"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-3074797dfa9so557153eec.1
        for <linux-s390@vger.kernel.org>; Tue, 02 Jun 2026 08:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780413953; x=1781018753; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yYKqXq805w0wcFXBmJBfrrbsatOJmwPurkk7tKq881M=;
        b=bLL7YU711vgqrPEVEMaCyi/R/tttlJI0YnOZmYYTk5GlUhpK4VdJGUk+Q5S0AtSWcM
         5E+HgHw7ne8cLZPBPwWJDA5InizSbDBMYi2QvIouHkM/9u6a9QMrJc9riABlQ4x0ZZI7
         LVu4hCzheP647CB1K6b4JSq4HlDkX/bU/PyeXQ5XePI7t6VLznnYM6rfbX+2j4HyGTi9
         ZyGP/KvRw12nPFaLyHEWW+4/f1kBSBo3jv7DK/WkMqqt3lT/VRYs5GIrcFjNVQkxM6FM
         vPYX+xNxwwDd+NZcGX3IjWCht0w9YACM5KDTzD+USjO1tZAqbw8LY99OFQ6CdB00NWBO
         jdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413953; x=1781018753;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yYKqXq805w0wcFXBmJBfrrbsatOJmwPurkk7tKq881M=;
        b=nyIkHTnRyhrzrMQNmrGRMEBEA/g8cDsWGKfoBRHgDc4mzrdpXuT5E2+MwE97ijRQW0
         OawP9Lfdty9P0sXAe3XheOArg/gTUkK5qFBxJGy3ykVXvgee0K+mMt5KPue9vuCWygE2
         DcuiPxCAfmOpA51qVVQ2Llw50VaJrnAyA8mBmxZuGbkdwlNdZkITiBE7R2s8vM2M/P95
         7vry0M+vGDbdw3ZOCe2u/G3RvSFFbjmhfeoV7QnN9gk+uAUKGjFyS1ZT+/CgNBI5VrYb
         OaEQJpjpWxyA0FOn5ahcBL8z8KlG+yiM8BE2uEUWJUYxRoX8ZSu25gVFHM3y2aS5Tp+7
         iO1A==
X-Forwarded-Encrypted: i=1; AFNElJ+TlxvA+emAv+N6qzBGkc/esVq7rSVpyWZ2Rc0KuHz3GP5kSpEHiuAGUy6gDXmMdAgZLUG6r1l3dHoG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4xhLB0wCXK4nqVlXcM+ki/fPWRkdhFonws5AytFiOwTmKy6pG
	iVi55yOXW3S5w4YuzFE9HQBXDyktN2mVcu0FNRjUVUljp5oQgq74/fOmgbPRMkCOLCrSdSitUee
	n8lW3AMUa/A==
X-Received: from dycns4.prod.google.com ([2002:a05:7300:f784:b0:2ed:a84e:18d3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:72c5:b0:304:5a53:7dac
 with SMTP id 5a478bee46e88-304fa62a1c5mr7250460eec.25.1780413952808; Tue, 02
 Jun 2026 08:25:52 -0700 (PDT)
Date: Tue,  2 Jun 2026 08:25:05 -0700
In-Reply-To: <20260602152516.2831152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602062452.2583619-1-irogers@google.com> <20260602152516.2831152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602152516.2831152-9-irogers@google.com>
Subject: [PATCH v12 08/19] perf sample-raw: Use perf_env e_machine rather than arch
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

