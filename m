Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5049037D11A
	for <linux-s390@vger.kernel.org>; Tue, 17 Mar 2026 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770220; cv=none; b=lw7cHvuCcrSgR2dc5gE8CQcYyejTye6rG5/Lod9TNzI5gTB5pOCpYNFRN/lsUD9PWGztfTIt5rrxOon/AuEvdFlGFBuWfLVbfV5XSOungoSCORkhTuKbrnKKnCfKIlgJC+IOuEHu2N17M/XKN+HXSU84kbDpcr/8fa+ikikTrDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770220; c=relaxed/simple;
	bh=d5pvIfQ6xcigH9j/9OyJB9iVHO88rUeVRxWZEvR0zSY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NfEamxlwcBtZJTX54j9jaLQFtvA3Bz/ozvqu5YyFFWjwhvwRq6vFYCfwWOQAIgSP0R/fv67euD12kMalahYLDqFj9foRERCPk96WMcpZnVWrZ5buSWQ5HeHJ5zVXAuMMhx1hGPM7u+U8AA8DzlCEFJIP5HgcN/Xrp1iONXOI2Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qgm79p1a; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qgm79p1a"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso5514907eec.0
        for <linux-s390@vger.kernel.org>; Tue, 17 Mar 2026 10:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773770218; x=1774375018; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lEgf/kr/qS+QFmeXxQE7lOMnSFqHvQJ5TUUD2h52kZw=;
        b=Qgm79p1aRtFjNmOflkiMCx+2/vYbAiWesppJnD4ND6SmKOpgC4X895SWR/+bXV8OJm
         V3S6i6Iboi3QEF7zqoNJSSItimjGsPlEwaScWXvZwSPcIzb3bptppEp/FN2lgD+TubTe
         QVa5K8/r/E01gXgss9+Xe36SfbHtMJy78eIdfLPqs57q1BX6v8f7oPH6FLvXHOQjCU5T
         bKPU32LisruGo961zIIK3HNxaqJ/ffpMDwVA/iPMy0191W2WixoL+NAxEABY7b1Pyb13
         hgfLcHHvWRLva9uVj9GpZR6bT7bhjnHrsJWJaZYE6MMqB3D9lLAOo/SVDazMKMD0Bj5t
         0APQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773770218; x=1774375018;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lEgf/kr/qS+QFmeXxQE7lOMnSFqHvQJ5TUUD2h52kZw=;
        b=QnM+xuOIAfUIW6LzUavHCBmltF+pGJj1RB4Zhz5Nf36SttU3ucyg/JGW9RUbQdA7JA
         T6xoBSO5WN3LMdC4AXLTv8fql143HIOO4wawKat7hPhRrFgG1WncN8L5rbZY7jO2Chpj
         MNayrP4TtbW68EY3goasBbqlqpkATtYIssEI9kl4wCvlKz7VEB+6gkB5jzEt5UeVW08B
         OOhKH32grt7uPUY05zZFsIBiNIvvDGGi2LsmP7W90AStY+xFPmMliYkRZt4wb1bsUjhf
         /NbNPMmmUQn/adI/yM9IJ6ceKj2hrQ4ypZSWrJlZ39X8DXWLi0LJi66v/9X1QcMB72ny
         8dYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCkIm78hhuqwReDnfxfIQp3t7xkrtxRMPP++WoCyV2D0y7wVdL2TzlqslQ/xttX3hpLjl05uSG6PaZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwwxxM5eQ00GMsGnWlnl5UlB+YVjdAtLMUOcAFwXZCvV0kvXjST
	lBJ3kxzf0RBW2QUI+7tNFSQ3spQzMQcgFqqI1js/9MEhp496paI6nlYgFLcJo6pU1rfCVf8D3JV
	YjJcJJ+w8ZQ==
X-Received: from dyaw2-n2.prod.google.com ([2002:a05:693c:4142:20b0:2be:aaeb:7e1b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:320b:b0:2ba:a60a:15e6
 with SMTP id 5a478bee46e88-2c0e5062a64mr166169eec.16.1773770218066; Tue, 17
 Mar 2026 10:56:58 -0700 (PDT)
Date: Tue, 17 Mar 2026 10:56:42 -0700
In-Reply-To: <20260317175642.161647-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fUO8azimnOV2Ogb93nZ3eXnaLdGo6b+3wPVf0tMz29JqQ@mail.gmail.com>
 <20260317175642.161647-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260317175642.161647-6-irogers@google.com>
Subject: [PATCH v6 5/5] perf evlist: Improve default event for s390
From: Ian Rogers <irogers@google.com>
To: tmricht@linux.ibm.com
Cc: irogers@google.com, acme@kernel.org, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, namhyung@kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Frame pointer callchains are not supported on s390 and dwarf
callchains are only supported on software events.

Switch the default event from the hardware 'cycles' event to the
software 'cpu-clock' or 'task-clock' on s390 if callchains are
enabled. Move the target initialization earlier in builtin-top so it
is ready for use by evlist__new_default.

If frame pointer callchains are requested on s390 show a
warning. Modify the '-g' option of `perf top` and `perf record` to
default to dwarf callchains on s390.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c      |  8 ++++--
 tools/perf/builtin-top.c         | 49 ++++++++++++++++----------------
 tools/perf/tests/event_update.c  |  4 ++-
 tools/perf/tests/expand-cgroup.c |  4 ++-
 tools/perf/tests/perf-record.c   |  7 +++--
 tools/perf/tests/topology.c      |  4 ++-
 tools/perf/util/evlist.c         | 32 ++++++++++++++-------
 tools/perf/util/evlist.h         |  2 +-
 tools/perf/util/evsel.c          |  5 ++++
 9 files changed, 72 insertions(+), 43 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 26223f9505c2..a03acfe66c27 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -55,6 +55,7 @@
 #include "asm/bug.h"
 #include "perf.h"
 #include "cputopo.h"
+#include "dwarf-regs.h"
 
 #include <errno.h>
 #include <inttypes.h>
@@ -2990,7 +2991,9 @@ static int record_callchain_opt(const struct option *opt,
 	if (callchain_param.record_mode != CALLCHAIN_NONE)
 		return 0;
 
-	return record_opts__parse_callchain(opt->value, &callchain_param, "fp", unset);
+	return record_opts__parse_callchain(opt->value, &callchain_param,
+					    EM_HOST != EM_S390 ? "fp" : "dwarf",
+					    unset);
 }
 
 
@@ -4269,7 +4272,8 @@ int cmd_record(int argc, const char **argv)
 		record.opts.tail_synthesize = true;
 
 	if (rec->evlist->core.nr_entries == 0) {
-		struct evlist *def_evlist = evlist__new_default();
+		struct evlist *def_evlist = evlist__new_default(&rec->opts.target,
+								callchain_param.enabled);
 
 		if (!def_evlist)
 			goto out;
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 5d2587228975..f13560d5b1a3 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -56,6 +56,7 @@
 #include "util/debug.h"
 #include "util/ordered-events.h"
 #include "util/pfm.h"
+#include "dwarf-regs.h"
 
 #include <assert.h>
 #include <elf.h>
@@ -1415,7 +1416,7 @@ callchain_opt(const struct option *opt, const char *arg __maybe_unused, int unse
 	if (callchain->record_mode != CALLCHAIN_NONE)
 		return 0;
 
-	return parse_callchain_opt(opt, "fp", unset);
+	return parse_callchain_opt(opt, EM_HOST != EM_S390 ? "fp" : "dwarf", unset);
 }
 
 
@@ -1700,8 +1701,30 @@ int cmd_top(int argc, const char **argv)
 	if (annotate_check_args() < 0)
 		goto out_delete_evlist;
 
+	status = target__validate(target);
+	if (status) {
+		target__strerror(target, status, errbuf, BUFSIZ);
+		ui__warning("%s\n", errbuf);
+	}
+
+	if (top.uid_str) {
+		uid_t uid = parse_uid(top.uid_str);
+
+		if (uid == UINT_MAX) {
+			ui__error("Invalid User: %s", top.uid_str);
+			status = -EINVAL;
+			goto out_delete_evlist;
+		}
+		status = parse_uid_filter(top.evlist, uid);
+		if (status)
+			goto out_delete_evlist;
+	}
+
+	if (target__none(target))
+		target->system_wide = true;
+
 	if (!top.evlist->core.nr_entries) {
-		struct evlist *def_evlist = evlist__new_default();
+		struct evlist *def_evlist = evlist__new_default(target, callchain_param.enabled);
 
 		if (!def_evlist)
 			goto out_delete_evlist;
@@ -1794,28 +1817,6 @@ int cmd_top(int argc, const char **argv)
 		goto out_delete_evlist;
 	}
 
-	status = target__validate(target);
-	if (status) {
-		target__strerror(target, status, errbuf, BUFSIZ);
-		ui__warning("%s\n", errbuf);
-	}
-
-	if (top.uid_str) {
-		uid_t uid = parse_uid(top.uid_str);
-
-		if (uid == UINT_MAX) {
-			ui__error("Invalid User: %s", top.uid_str);
-			status = -EINVAL;
-			goto out_delete_evlist;
-		}
-		status = parse_uid_filter(top.evlist, uid);
-		if (status)
-			goto out_delete_evlist;
-	}
-
-	if (target__none(target))
-		target->system_wide = true;
-
 	if (evlist__create_maps(top.evlist, target) < 0) {
 		ui__error("Couldn't create thread/CPU maps: %s\n",
 			  errno == ENOENT ? "No such process" : str_error_r(errno, errbuf, sizeof(errbuf)));
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

