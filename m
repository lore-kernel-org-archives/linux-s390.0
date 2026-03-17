Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B0737F8D4
	for <linux-s390@vger.kernel.org>; Tue, 17 Mar 2026 05:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773726833; cv=none; b=nmoPF9H4aJmQO4vwScBvYUPMtNYqAhQpSPpwlbOdsqbicJY0t9MmktMRKUqVpNSL3QtAdR7aGj+qRSwRN5DKnjKwtrloV5ENwlkppBPK2wcdJ42CMAH/KpsvVThAtBMPNXOiKyY56lHIZgZV0gDF5AwZShmR7KRYtvC4yJYIbBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773726833; c=relaxed/simple;
	bh=Axfy6NjjxmduxcvXsqF3sLzos55b1PwttR68soQDBPY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GJ/tcIRB4stVFtnf7dTOCkX6QlWp+pDrZIrkQ7uYEkkaLKuyW1QAdZEs98kQ3kVXufJDyRRFAQN5qV9XRg5YbIe/wppDbHzv9eSbl9whTwnFKEg+pTTcARKEC4ist39Q1Poa7eThb168lsENuL78LYr2XwRtTwRWOpf997j38s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iS9Y4Ddj; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iS9Y4Ddj"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bead0a9123so22512205eec.1
        for <linux-s390@vger.kernel.org>; Mon, 16 Mar 2026 22:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773726831; x=1774331631; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1y9l7GOlMwY9cVT1XEv6vvs7n+TqRuMl4hN3XZ5vC3w=;
        b=iS9Y4Ddja3dTnD5SNFBcWYNOLjUYUn0OPtVJ6K8M3HK0AO4IzlKEKzxM4pDbSQvd5f
         sCmOJVNOc7Av2AYsBh3HiKJK/053rmnHVYIjy3u5xDPaS4XsOhA4Dx52OylX9AKVNNch
         hUC5jqa1WFEF7jocdfnKEJXfuxzdR7pxWi9AMcNR6UF7aEHwJxZBev4lo5BX8ZU6fMpb
         E1HVF1uxbKRI7r87OIe5d8HBsgJeLu8KM3Ceb5efg/yzf6cnvP0r0rqhtJPD4oBqF3vC
         eGnXFcZpR7r0P1qzUckg74rWo9QuryT93pyt71vOE2IVtdHxjNBgzpVR5QZ09s8Jd44X
         y+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773726831; x=1774331631;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1y9l7GOlMwY9cVT1XEv6vvs7n+TqRuMl4hN3XZ5vC3w=;
        b=Pey7Dvj0VhNKiT/IZOSnWeqHSeS1DzcoCYWLcSyRQUJjXIrI5aF1n096nN/EaK5JJ/
         qk7IFWlBQJNumzrBKdWf4lQZMnROYe1YWIuXDUjwdU6ukJPo4rb5l0U1i1l65W6DdSSL
         9T253MEKPiiUEntXN/7fCuPMtyEkUdIoqkGBGMlpj/vqflRuYQnmBQYN5ddPHORHxVPw
         cXgH0wUDZhzk/K0F+1NEYXxvS/B/D+omXOeWWqIhnRWGSN7fnx0qwiGNj6MqxPGt71A5
         SMDLQOBH3rosT7p9BC1SjWoscwiMgb9yUn0KC158FsJQ89qaoB/XCp2rsOf+7TpndbIw
         ew/A==
X-Forwarded-Encrypted: i=1; AJvYcCVhJdlfqWqGVoYWSn1W4dA/7qN8U7wN84UmHFanJlbq3OWoQ6yfqkUVzPvWzDpznj0Uyq8PRzNJET9C@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd3Egh4OrR3q90vM3eNECiuoY3yGGbxkoZOsKDLd8t51YVoE/K
	6AjPxUea9fkCcBzOy4sx305JBTdW4ENH40ynf2DuYq6bKe5TRqIgePu3Y5lmDfPz7wmFoKNI1Mu
	hyHFLGlXoeA==
X-Received: from dyek37.prod.google.com ([2002:a05:7300:6425:b0:2c0:c2b7:5f36])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:2f8a:b0:2c0:dd6e:7c87
 with SMTP id 5a478bee46e88-2c0dd6ea02emr56147eec.32.1773726830473; Mon, 16
 Mar 2026 22:53:50 -0700 (PDT)
Date: Mon, 16 Mar 2026 22:53:34 -0700
In-Reply-To: <20260317055334.760347-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260317030601.567422-1-irogers@google.com> <20260317055334.760347-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260317055334.760347-6-irogers@google.com>
Subject: [PATCH v5 5/5] perf evlist: Improve default event for s390
From: Ian Rogers <irogers@google.com>
To: tmricht@linux.ibm.com
Cc: irogers@google.com, acme@kernel.org, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, namhyung@kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Frame pointer callchains are not supported on s390 and dwarf
callchains are only supported on software events.

Switch the default event from cycles to cpu-clock or task-clock on
s390 if callchains are enabled.

If frame pointer callchains are requested on s390 show a
warning. Modify the '-g' option of `perf top` and `perf record` to
default to dwarf callchains on s390.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c      |  8 ++++++--
 tools/perf/builtin-top.c         |  5 +++--
 tools/perf/tests/event_update.c  |  4 +++-
 tools/perf/tests/expand-cgroup.c |  4 +++-
 tools/perf/tests/perf-record.c   |  7 +++++--
 tools/perf/tests/topology.c      |  4 +++-
 tools/perf/util/evlist.c         | 32 +++++++++++++++++++++-----------
 tools/perf/util/evlist.h         |  2 +-
 tools/perf/util/evsel.c          |  5 +++++
 9 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index af1fe6b7c65c..ef97c7a54088 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -55,6 +55,7 @@
 #include "asm/bug.h"
 #include "perf.h"
 #include "cputopo.h"
+#include "dwarf-regs.h"
 
 #include <errno.h>
 #include <inttypes.h>
@@ -2986,7 +2987,9 @@ static int record_callchain_opt(const struct option *opt,
 				const char *arg __maybe_unused,
 				int unset)
 {
-	return record_opts__parse_callchain(opt->value, &callchain_param, "fp", unset);
+	return record_opts__parse_callchain(opt->value, &callchain_param,
+					    EM_HOST != EM_S390 ? "fp" : "dwarf",
+					    unset);
 }
 
 
@@ -4265,7 +4268,8 @@ int cmd_record(int argc, const char **argv)
 		record.opts.tail_synthesize = true;
 
 	if (rec->evlist->core.nr_entries == 0) {
-		struct evlist *def_evlist = evlist__new_default();
+		struct evlist *def_evlist = evlist__new_default(&rec->opts.target,
+								callchain_param.enabled);
 
 		if (!def_evlist)
 			goto out;
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 2a949d956d0b..84211a78977e 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -56,6 +56,7 @@
 #include "util/debug.h"
 #include "util/ordered-events.h"
 #include "util/pfm.h"
+#include "dwarf-regs.h"
 
 #include <assert.h>
 #include <elf.h>
@@ -1409,7 +1410,7 @@ parse_callchain_opt(const struct option *opt, const char *arg, int unset)
 static int
 callchain_opt(const struct option *opt, const char *arg __maybe_unused, int unset)
 {
-	return parse_callchain_opt(opt, "fp", unset);
+	return parse_callchain_opt(opt, EM_HOST != EM_S390 ? "fp" : "dwarf", unset);
 }
 
 
@@ -1695,7 +1696,7 @@ int cmd_top(int argc, const char **argv)
 		goto out_delete_evlist;
 
 	if (!top.evlist->core.nr_entries) {
-		struct evlist *def_evlist = evlist__new_default();
+		struct evlist *def_evlist = evlist__new_default(target, callchain_param.enabled);
 
 		if (!def_evlist)
 			goto out_delete_evlist;
diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index cb9e6de2e033..facc65e29f20 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -8,6 +8,7 @@
 #include "header.h"
 #include "machine.h"
 #include "util/synthetic-events.h"
+#include "target.h"
 #include "tool.h"
 #include "tests.h"
 #include "debug.h"
@@ -81,7 +82,8 @@ static int test__event_update(struct test_suite *test __maybe_unused, int subtes
 {
 	struct evsel *evsel;
 	struct event_name tmp;
-	struct evlist *evlist = evlist__new_default();
+	struct target target = {};
+	struct evlist *evlist = evlist__new_default(&target, /*sample_callchains=*/false);
 
 	TEST_ASSERT_VAL("failed to get evlist", evlist);
 
diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
index c7b32a220ca1..dd547f2f77cc 100644
--- a/tools/perf/tests/expand-cgroup.c
+++ b/tools/perf/tests/expand-cgroup.c
@@ -8,6 +8,7 @@
 #include "parse-events.h"
 #include "pmu-events/pmu-events.h"
 #include "pfm.h"
+#include "target.h"
 #include <subcmd/parse-options.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -99,7 +100,8 @@ out:	for (i = 0; i < nr_events; i++)
 static int expand_default_events(void)
 {
 	int ret;
-	struct evlist *evlist = evlist__new_default();
+	struct target target = {};
+	struct evlist *evlist = evlist__new_default(&target, /*sample_callchains=*/false);
 
 	TEST_ASSERT_VAL("failed to get evlist", evlist);
 
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index efbd9cd60c63..c6e31ab8a6b8 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -84,8 +84,11 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 	CPU_ZERO_S(cpu_mask_size, cpu_mask);
 
 	perf_sample__init(&sample, /*all=*/false);
-	if (evlist == NULL) /* Fallback for kernels lacking PERF_COUNT_SW_DUMMY */
-		evlist = evlist__new_default();
+	if (evlist == NULL) { /* Fallback for kernels lacking PERF_COUNT_SW_DUMMY */
+		struct target target = {};
+
+		evlist = evlist__new_default(&target, /*sample_callchains=*/false);
+	}
 
 	if (evlist == NULL) {
 		pr_debug("Not enough memory to create evlist\n");
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index ec01150d208d..a34a7ab19a80 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -9,6 +9,7 @@
 #include "evlist.h"
 #include "debug.h"
 #include "pmus.h"
+#include "target.h"
 #include <linux/err.h>
 
 #define TEMPL "/tmp/perf-test-XXXXXX"
@@ -37,11 +38,12 @@ static int session_write_header(char *path)
 		.path = path,
 		.mode = PERF_DATA_MODE_WRITE,
 	};
+	struct target target = {};
 
 	session = perf_session__new(&data, NULL);
 	TEST_ASSERT_VAL("can't get session", !IS_ERR(session));
 
-	session->evlist = evlist__new_default();
+	session->evlist = evlist__new_default(&target, /*sample_callchains=*/false);
 	TEST_ASSERT_VAL("can't get evlist", session->evlist);
 	session->evlist->session = session;
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 591bdf0b3e2a..c702741a9173 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -13,6 +13,7 @@
 #include "util/mmap.h"
 #include "thread_map.h"
 #include "target.h"
+#include "dwarf-regs.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "record.h"
@@ -98,38 +99,47 @@ struct evlist *evlist__new(void)
 	return evlist;
 }
 
-struct evlist *evlist__new_default(void)
+struct evlist *evlist__new_default(const struct target *target, bool sample_callchains)
 {
 	struct evlist *evlist = evlist__new();
 	bool can_profile_kernel;
 	struct perf_pmu *pmu = NULL;
+	struct evsel *evsel;
+	char buf[256];
+	int err;
 
 	if (!evlist)
 		return NULL;
 
 	can_profile_kernel = perf_event_paranoid_check(1);
 
-	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
-		char buf[256];
-		int err;
-
-		snprintf(buf, sizeof(buf), "%s/cycles/%s", pmu->name,
+	if (EM_HOST == EM_S390 && sample_callchains) {
+		snprintf(buf, sizeof(buf), "software/%s/%s",
+			 target__has_cpu(target) ? "cpu-clock" : "task-clock",
 			 can_profile_kernel ? "P" : "Pu");
 		err = parse_event(evlist, buf);
-		if (err) {
-			evlist__delete(evlist);
-			return NULL;
+		if (err)
+			goto out_err;
+	} else {
+		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+			snprintf(buf, sizeof(buf), "%s/cycles/%s", pmu->name,
+				can_profile_kernel ? "P" : "Pu");
+			err = parse_event(evlist, buf);
+			if (err)
+				goto out_err;
 		}
 	}
 
+	/* If there is only 1 event a sample identifier isn't necessary. */
 	if (evlist->core.nr_entries > 1) {
-		struct evsel *evsel;
-
 		evlist__for_each_entry(evlist, evsel)
 			evsel__set_sample_id(evsel, /*can_sample_identifier=*/false);
 	}
 
 	return evlist;
+out_err:
+	evlist__delete(evlist);
+	return NULL;
 }
 
 struct evlist *evlist__new_dummy(void)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index d17c3b57a409..e507f5f20ef6 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -104,7 +104,7 @@ struct evsel_str_handler {
 };
 
 struct evlist *evlist__new(void);
-struct evlist *evlist__new_default(void);
+struct evlist *evlist__new_default(const struct target *target, bool sample_callchains);
 struct evlist *evlist__new_dummy(void);
 void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 		  struct perf_thread_map *threads);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 54c8922a8e47..5a294595a677 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1021,6 +1021,11 @@ static void __evsel__config_callchain(struct evsel *evsel, const struct record_o
 	bool function = evsel__is_function_event(evsel);
 	struct perf_event_attr *attr = &evsel->core.attr;
 
+	if (EM_HOST == EM_S390 && param->record_mode == CALLCHAIN_FP) {
+		pr_warning_once(
+			"Framepointer unwinding lacks kernel support. Use '--call-graph dwarf'\n");
+	}
+
 	evsel__set_sample_bit(evsel, CALLCHAIN);
 
 	attr->sample_max_stack = param->max_stack;
-- 
2.53.0.851.ga537e3e6e9-goog

