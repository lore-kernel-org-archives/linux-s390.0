Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73F83DEAEE
	for <linux-s390@vger.kernel.org>; Fri, 13 Mar 2026 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773433705; cv=none; b=Ls9vY65RIKl01eAAKQeP58UoYmZJohgyPU3kVYI7KVgT1tqWgdbmNElvmLCSuAp4yepQg2oY4sg9i60JzJCLUjq07yxGwziIz4mTc/gblsvKa0BGg/VTPLEI2y3qofvVcD2lujIr+FYWEfD5ncAr7Zutl1merovrMETgGMFikWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773433705; c=relaxed/simple;
	bh=Y1tiRV1EG29+sMZhK56SFMelGvlIQkNmYR96+JSu95Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J7pRjhQ9IyxwbBkAAE/cmxF0BDhNZ7vTFi/z8iq3YAxh7WrDwI8O3GCzRLKckotWV1EO5Yzvjnxlvn4oPblFJhHA8HidMMv5t2t+wZWCZUvPBHHcO7n1T0vP5RcXRpFYK86muuIkPnxV48th4MmoIR/FOQn2pztdkayvyJrtnaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nnFcwOGB; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nnFcwOGB"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12734af2ca4so1495569c88.0
        for <linux-s390@vger.kernel.org>; Fri, 13 Mar 2026 13:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773433703; x=1774038503; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hGYQ5+mcr9zuL+O4EQl29EcCB3SFK28wde9c/Pez8+k=;
        b=nnFcwOGBi8OHkKFYt4Qs3ZHXfPPOAw55+wOwiOHpLzmMvFMPA1oWuAOEmNFgaWXIQA
         R2ViJdo7r22tly+qWWAm0VPH1ggmduWSMz96Nhr5DDwepjs5PPvbNU7qKnm7clDGLxYa
         lg7bwarUoaViKR4bfJ1XOw/jMHDbH/Ie4gEGc64hK2YkYfyZacawp65HHtzlCrGgxu0G
         tYCccfjx0Irdsu5jr0PK1GJwUuV/r0ONe+OIhAH/6sQV2raydccMovGIXVNTubiT2F/+
         65btER6p7moJgvYZG8yyiQSsctUEMrbNqafOwL/P9RlLC8L0YSF/o139o+Sov+0ayO++
         Kxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773433703; x=1774038503;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hGYQ5+mcr9zuL+O4EQl29EcCB3SFK28wde9c/Pez8+k=;
        b=NaWSVuo2czqbuJjeiu/arQbXhOnfq8DTz21IXPKLo7PmQBSjDtT8Jl8AFAB9T4HRtc
         dFEfAUK1gVYAPOUmqiNn9j1tRCisie6H7wg3gPHBlK919XMGVbFJlGP6f2qxpUuTqCr1
         r2D7Nhg7Xt/tNfjcFf53mwq/XZH55fc4BAOJxn6BPbqw8deFOQl6tJDW2WXPVG27VZ3d
         ++T2PeOoQZ0rjO8pZZ3I4qI0xrMMvb41rV0Mh0ITQxuxScbhjUr+auiNhKNLfPamgDLG
         M9AKQafjDQHrjVOialKP3/uIZU+DBKlRqCpq+a6hpxJWWEnPdOqQFpCySCwL7vnMArl8
         RYJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8BjuO7NhuFJsTwIXmj+MKZ+IWf8+Io1/F+vDU3cK0SC+PkF0zCns7iEIP97KLl/4FYUwH5dHv1qhw@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm8eMy+E5ky6UTr9e5wEIJR833YP5i3OlDOKdpJrJgGIdPeoib
	QccFkWsKiw4xqlyId47L8X30aSi2Jy3P2iOFe916MCgyKwUJh0njsOeXysc8nSBQqa8YyWKnavC
	B+3ZHf/cMsQ==
X-Received: from dlae28.prod.google.com ([2002:a05:701b:231c:b0:128:ee69:eb75])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:618d:b0:128:d2b2:143b
 with SMTP id a92af1059eb24-128f3b4b03cmr1996806c88.9.1773433702538; Fri, 13
 Mar 2026 13:28:22 -0700 (PDT)
Date: Fri, 13 Mar 2026 13:28:11 -0700
In-Reply-To: <20260313202811.2599195-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260312061628.1593105-1-irogers@google.com> <20260313202811.2599195-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260313202811.2599195-4-irogers@google.com>
Subject: [PATCH v3 3/3] perf evlist: Improve default event for s390
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

If frame pointer callchains are requested on s390, warn and switch to
dwarf callchains.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c      |  3 ++-
 tools/perf/builtin-top.c         |  2 +-
 tools/perf/tests/event_update.c  |  4 +++-
 tools/perf/tests/expand-cgroup.c |  4 +++-
 tools/perf/tests/perf-record.c   |  7 ++++--
 tools/perf/tests/topology.c      |  4 +++-
 tools/perf/util/evlist.c         | 37 +++++++++++++++++++-------------
 tools/perf/util/evlist.h         |  2 +-
 tools/perf/util/evsel.c          | 11 ++++++++--
 9 files changed, 49 insertions(+), 25 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 60d764068302..07ecc8a5fec7 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -4310,7 +4310,8 @@ int cmd_record(int argc, const char **argv)
 		record.opts.tail_synthesize = true;
 
 	if (rec->evlist->core.nr_entries == 0) {
-		struct evlist *def_evlist = evlist__new_default();
+		struct evlist *def_evlist = evlist__new_default(&rec->opts.target,
+								callchain_param.enabled);
 
 		if (!def_evlist)
 			goto out;
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 710604c4f6f6..58bab595b024 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1695,7 +1695,7 @@ int cmd_top(int argc, const char **argv)
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
index 591bdf0b3e2a..e6c518cc4a69 100644
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
@@ -98,38 +99,44 @@ struct evlist *evlist__new(void)
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
 
-	if (evlist->core.nr_entries > 1) {
-		struct evsel *evsel;
-
-		evlist__for_each_entry(evlist, evsel)
-			evsel__set_sample_id(evsel, /*can_sample_identifier=*/false);
-	}
+	evlist__for_each_entry(evlist, evsel)
+		evsel__set_sample_id(evsel, /*can_sample_identifier=*/false);
 
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
index bd14d9bbc91f..caa95dc06ac5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1020,6 +1020,13 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
 {
 	bool function = evsel__is_function_event(evsel);
 	struct perf_event_attr *attr = &evsel->core.attr;
+	enum perf_call_graph_mode record_mode = param->record_mode;
+
+	if (EM_HOST == EM_S390 && param->record_mode == CALLCHAIN_FP) {
+		pr_warning("Framepointer unwinding switched to dwarf due to a lack of kernel support.\n"
+			   "Use '--call-graph dwarf' to silence this warning.\n");
+		record_mode = CALLCHAIN_DWARF;
+	}
 
 	evsel__set_sample_bit(evsel, CALLCHAIN);
 
@@ -1029,7 +1036,7 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
 		attr->exclude_callchain_user = 1;
 	if (opts->user_callchains)
 		attr->exclude_callchain_kernel = 1;
-	if (param->record_mode == CALLCHAIN_LBR) {
+	if (record_mode == CALLCHAIN_LBR) {
 		if (!opts->branch_stack) {
 			if (attr->exclude_user) {
 				pr_warning("LBR callstack option is only available "
@@ -1048,7 +1055,7 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
 				    "Falling back to framepointers.\n");
 	}
 
-	if (param->record_mode == CALLCHAIN_DWARF) {
+	if (record_mode == CALLCHAIN_DWARF) {
 		if (!function) {
 			uint16_t e_machine = evsel__e_machine(evsel, /*e_flags=*/NULL);
 
-- 
2.53.0.851.ga537e3e6e9-goog

