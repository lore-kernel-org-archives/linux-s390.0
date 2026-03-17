Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9BC2C026F
	for <linux-s390@vger.kernel.org>; Tue, 17 Mar 2026 03:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773716785; cv=none; b=mLelXlPnVRy+/BLagv+/AQUBhO1Zl70ceXSEIuTCLXnd8sPHJY1g9zwC+S/3MppNPTTQXvJ6DH6UACAro/zJOGGiOTpN7FMKYuBy9YOUp1tzV5wr6Vl+NIPhTgGG4QaNQpQIaM1Ouu81C+3+szIyvrSJGwP6tdbnLZgqHXEB5WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773716785; c=relaxed/simple;
	bh=0T5+Gr3wi71gLdCCrZTsYWqFzob7IGKsffItAl2oKd8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pm9n5HFO4BB2gFZpCIq6NuERumh3XahYP1Ih3D/aMOsqmxDinGYPmqJwqZrYE/AYgRW4FILtHpEcFIKfePATl6Pl9BaTPERfQz5ZxyltbgDVqQqPZeuZdHgPDf6am6lZRZoqoSFxpc+aQvM+ni5JzMOb66KnMVgTViK0bVYQYIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PuULf5cb; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PuULf5cb"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-128edc72e5bso23758319c88.1
        for <linux-s390@vger.kernel.org>; Mon, 16 Mar 2026 20:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773716783; x=1774321583; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/bQJ/BLiJ4Z3TZocKrA/GIS6qvvcfJbGWDZdIMkxhtU=;
        b=PuULf5cbvUXsvIbxGFZ/vxsZT1TCEFPc0pU4NSAHKi8Rs7vrKi/lrZkf7px63rEULu
         3PmsqPw6EbEauN0K+NIuM+jBAfZ4zpCQeULIqG75F3rs77FuUbKm6TA9XwxCKninNyw2
         EbJ35tCn6TtSJhN3AyHUp0Fs27sbPw/FpHBELSGtTJYc/1AbECT5Mk6Vi/8rhYrGNcIr
         2NRxrxiL499poePKopO87bYyEm+XfLRgr+RY71ahNpQZ4qq+29G67NeuZkg8IZLBh7vd
         T0k6fn9XCsB4IwXLlkHH4jlW/IEWqGIuBy+XsOMICpZMS/DJxgj5suCrf447FaWSqckq
         txAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773716783; x=1774321583;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/bQJ/BLiJ4Z3TZocKrA/GIS6qvvcfJbGWDZdIMkxhtU=;
        b=PyoSQz/ZFJKmFv+VizfnzjAlpNPwuWHbLW/0wsLp1qeEd/fVTPtitpqY2igWlyfL2b
         uXvATsTzWrxGBGnBgehkFtRFJkUVDlkG8xNKnwSFNv0q8OtkowJMjWCOi328dpYsbGbV
         d8jU0UOXbaxY+KQwkcokQg7PfBj7QFcxgfr7cE3t2Rf+doF6JVBNnqTxoHFtsFNllnO6
         TXsOnLYj01k2w035XPQdjVFC4So48ugiI451GJnITgbZfJclYXVAtPb5I7v6y78E4f+r
         Uo+T82ejR7vnr9bcY3/jEPWmlLzo1mfT5QJGIYWKAVtFb3Krlk0SdbrHCUi1TYYBAslv
         xJBA==
X-Forwarded-Encrypted: i=1; AJvYcCV4yPiww12STv34nljk1p1tlJ6By8UnqWOCgtB+zOTk5/pgd7c+XHW3HoD2suW36a3jDYlktio/H/WB@vger.kernel.org
X-Gm-Message-State: AOJu0YyJZC06gVFFkCN02xHm3u+Rz+crtGHoEH3f9B4aVbLbS+m8e5GW
	vXex85F5oPbYaIXaxu23jjorHHlh56BKwQwtQl2AH80ol99RX50B3fGDQoLYxBGBICTK7i/8qv3
	tE543PqTjGQ==
X-Received: from dlboy10.prod.google.com ([2002:a05:7022:128a:b0:128:f497:319c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:422:b0:127:3440:e5d5
 with SMTP id a92af1059eb24-128f3dc591cmr7312597c88.21.1773716783156; Mon, 16
 Mar 2026 20:06:23 -0700 (PDT)
Date: Mon, 16 Mar 2026 20:06:01 -0700
In-Reply-To: <20260317030601.567422-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fU9SJu=x2+aKTV4eXXLVv77SbtBr0shDLTfWw9eByYZ4Q@mail.gmail.com>
 <20260317030601.567422-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260317030601.567422-6-irogers@google.com>
Subject: [PATCH v4 5/5] perf evlist: Improve default event for s390
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
 tools/perf/builtin-record.c      |  5 +++--
 tools/perf/builtin-top.c         |  2 +-
 tools/perf/tests/event_update.c  |  4 +++-
 tools/perf/tests/expand-cgroup.c |  4 +++-
 tools/perf/tests/perf-record.c   |  7 +++++--
 tools/perf/tests/topology.c      |  4 +++-
 tools/perf/util/callchain.c      | 16 ++++++++--------
 tools/perf/util/evlist.c         | 32 +++++++++++++++++++++-----------
 tools/perf/util/evlist.h         |  2 +-
 tools/perf/util/evsel.c          |  5 +++++
 10 files changed, 53 insertions(+), 28 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e65cd7bf1477..604c00c58152 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3466,7 +3466,7 @@ static struct option __record_options[] = {
 	OPT_CALLBACK(0, "mmap-flush", &record.opts, "number",
 		     "Minimal number of bytes that is extracted from mmap data pages (default: 1)",
 		     record__mmap_flush_parse),
-	OPT_CALLBACK_NOOPT('g', NULL, &callchain_param,
+	OPT_CALLBACK_NOOPT('g', NULL, &record.opts,
 			   NULL, "enables call-graph recording" ,
 			   &record_callchain_opt),
 	OPT_CALLBACK(0, "call-graph", &record.opts,
@@ -4250,7 +4250,8 @@ int cmd_record(int argc, const char **argv)
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
 
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 1203d9d23fda..bc3c1e955b02 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -30,6 +30,7 @@
 #include "machine.h"
 #include "map.h"
 #include "callchain.h"
+#include "dwarf-regs.h"
 #include "branch.h"
 #include "record.h"
 #include "symbol.h"
@@ -378,14 +379,13 @@ int record_callchain_opt(const struct option *opt,
 			 const char *arg __maybe_unused,
 			 int unset __maybe_unused)
 {
-	struct callchain_param *callchain = opt->value;
-
-	callchain->enabled = true;
-
-	if (callchain->record_mode == CALLCHAIN_NONE)
-		callchain->record_mode = CALLCHAIN_FP;
-
-	callchain_debug(callchain);
+	callchain_param.enabled = true;
+	if (callchain_param.record_mode == CALLCHAIN_NONE) {
+		/* s390 lacks kernel framepoint unwinding. */
+		record_opts__parse_callchain(opt->value, &callchain_param,
+					     EM_HOST != EM_S390 ? "fp" : "dwarf",
+					     /*unset=*/0);
+	}
 	return 0;
 }
 
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

