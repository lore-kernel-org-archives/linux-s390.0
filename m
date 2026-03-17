Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484E73803C4
	for <linux-s390@vger.kernel.org>; Tue, 17 Mar 2026 05:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773726830; cv=none; b=YWI6xWnt52yUjhNSm6jkAG0u2NuWYD3BbPWI/pc2ra+XMneJzjTNGtUPqb2pVW5cTx/v2J1p0C8eBM+IinIy4C9bkpX7evUjZUnGvLN/v/sIhChhE5naHnIQd6r5jxqVi3uBPTYv+Pq/1O7/u7BqsTVU/JMcIoiVDkhGMbca9nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773726830; c=relaxed/simple;
	bh=NGYnryMhEdIBmDPY7BmWjrHAQZEWEyXEqXN7d4e1LD4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cy7okEHcgs9tJIEdeCu0gI/oIuyrpEYy9lU7FfjtwrnSvcz4bKBzEohuNLCpFhp2xqNrSP9kl4GVjUuYiwvthpEuj7jLrs0gMjvOnlTIU2SGeX2aiiZj5ZAeEzhip6QzU0MIHSpbHu71+Fzxo8V6hs1spq22fR+v+sF31vKgDyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rd4VONSz; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rd4VONSz"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0cb775215so25381710eec.0
        for <linux-s390@vger.kernel.org>; Mon, 16 Mar 2026 22:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773726828; x=1774331628; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dsJEhWEmvNQrHkNRryerc+5Jcaj55mH9xilOwt1mqeI=;
        b=rd4VONSzMKGBl2T2Ebki61KjT/36/14Toyh5OWi8ocMBTiHTc6VWXB/TTchQE8csco
         RJ3t1ksYQPpofeqyIYuhXXI7uBFuQrnkbveHww0auB27R5BhINnsc5eVHkNwde4G3ufo
         iec5NdL4QCsZzxCYJAviAIBp6LOL+L4lnjJ7wWLv6lpSkdqZOTuW25nsfLTKSSy+5uq0
         lyCMq1ICdebk5xCvzIkCvsQizRP/MkuOtV92T6pmH1IBhr8lSM8aKB8ze20hrUdg8YN7
         PhfqAGxOm9cRnDl8BLGkFo/k9jB47i9kNKXTuq/97g3b89Z8EvTFbWXgcZq/64vhHxdP
         KpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773726828; x=1774331628;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dsJEhWEmvNQrHkNRryerc+5Jcaj55mH9xilOwt1mqeI=;
        b=UAbX3MZdm4UXJoAAPxp54LCi51oU02YSnU5QUwQyUs4qxvjjulZaoQ0zOv/9V1gIdb
         ZsBOMo1CHRumgQJ+f9OdrfW/7X1KDqSnEy3fzhabeJ8bhcBkEBsLjfrXE9tDjBsVY7uC
         IATAaQIAwpYjgEL46VSomvSCggqMEGFjol7Bn9ppcf6Fw3Gb2WPIGf7m1GhcHTj9D1b6
         MKBpdS15ietA4DoYVt+fahXAQsO+l2ZvpHuwWJxrQEEqBAuiVIPLxpMJdbAZ2QBJ5m1C
         DdS/ePDAx+aXDucdXJHAGEVVyBlF0Q0wEEJgy7xqu+H7W2XdARFIhKeZZK/zs0C01mKC
         r9+g==
X-Forwarded-Encrypted: i=1; AJvYcCVjLqe1jsAkL+rdFEbeUnwKNinomujyRXbItZ6QAa2Lu45Tgb9kfwr/nCtU3YHjIikcX/7kfEUlZNfX@vger.kernel.org
X-Gm-Message-State: AOJu0YyYa+36CcVke3xrtd30lBeSsL8PKvyyipywplC2h5eOQdFHB3L8
	BWDsm2wL3Osa7/3ofCdjvXlK0neExCKXfUx5w7rKykIozlWty2xEjZcqQ2gILQdDVzu7gaSiUSt
	XEx6GZMfw/A==
X-Received: from dycng12.prod.google.com ([2002:a05:7300:ce0c:b0:2c0:cd67:64cd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:ad28:b0:2be:833c:1486
 with SMTP id 5a478bee46e88-2bea559090cmr7205419eec.18.1773726827933; Mon, 16
 Mar 2026 22:53:47 -0700 (PDT)
Date: Mon, 16 Mar 2026 22:53:33 -0700
In-Reply-To: <20260317055334.760347-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260317030601.567422-1-irogers@google.com> <20260317055334.760347-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260317055334.760347-5-irogers@google.com>
Subject: [PATCH v5 4/5] perf callchain: Refactor callchain option parsing
From: Ian Rogers <irogers@google.com>
To: tmricht@linux.ibm.com
Cc: irogers@google.com, acme@kernel.org, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, namhyung@kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

record_opts__parse_callchain is shared by builtin-record and
builtin-trace, it is declared in callchain.h. Move the declaration to
callchain.c for consistency with the header. In other cases make the
option callback a small static stub that then calls into callchain.c.
Make the no argument '-g' callchain option just a short-cut for
'--call-graph fp' so that there is consistency in how the arguments
are handled.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 58 +++++--------------------------------
 tools/perf/builtin-top.c    | 14 ++++-----
 tools/perf/builtin-trace.c  |  9 +++++-
 tools/perf/util/callchain.c | 39 +++++++++++++++++++++++++
 tools/perf/util/callchain.h | 12 ++------
 5 files changed, 64 insertions(+), 68 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 40917a0be238..af1fe6b7c65c 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2975,65 +2975,21 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	return status;
 }
 
-static void callchain_debug(struct callchain_param *callchain)
-{
-	static const char *str[CALLCHAIN_MAX] = { "NONE", "FP", "DWARF", "LBR" };
-
-	pr_debug("callchain: type %s\n", str[callchain->record_mode]);
-
-	if (callchain->record_mode == CALLCHAIN_DWARF)
-		pr_debug("callchain: stack dump size %d\n",
-			 callchain->dump_size);
-}
-
-int record_opts__parse_callchain(struct record_opts *record,
-				 struct callchain_param *callchain,
-				 const char *arg, bool unset)
-{
-	int ret;
-	callchain->enabled = !unset;
-
-	/* --no-call-graph */
-	if (unset) {
-		callchain->record_mode = CALLCHAIN_NONE;
-		pr_debug("callchain: disabled\n");
-		return 0;
-	}
-
-	ret = parse_callchain_record_opt(arg, callchain);
-	if (!ret) {
-		/* Enable data address sampling for DWARF unwind. */
-		if (callchain->record_mode == CALLCHAIN_DWARF &&
-		    !record->record_data_mmap_set)
-			record->record_data_mmap = true;
-		callchain_debug(callchain);
-	}
-
-	return ret;
-}
-
-int record_parse_callchain_opt(const struct option *opt,
+static int record_parse_callchain_opt(const struct option *opt,
 			       const char *arg,
 			       int unset)
 {
 	return record_opts__parse_callchain(opt->value, &callchain_param, arg, unset);
 }
 
-int record_callchain_opt(const struct option *opt,
-			 const char *arg __maybe_unused,
-			 int unset __maybe_unused)
+static int record_callchain_opt(const struct option *opt,
+				const char *arg __maybe_unused,
+				int unset)
 {
-	struct callchain_param *callchain = opt->value;
-
-	callchain->enabled = true;
-
-	if (callchain->record_mode == CALLCHAIN_NONE)
-		callchain->record_mode = CALLCHAIN_FP;
-
-	callchain_debug(callchain);
-	return 0;
+	return record_opts__parse_callchain(opt->value, &callchain_param, "fp", unset);
 }
 
+
 static int perf_record_config(const char *var, const char *value, void *cb)
 {
 	struct record *rec = cb;
@@ -3525,7 +3481,7 @@ static struct option __record_options[] = {
 	OPT_CALLBACK(0, "mmap-flush", &record.opts, "number",
 		     "Minimal number of bytes that is extracted from mmap data pages (default: 1)",
 		     record__mmap_flush_parse),
-	OPT_CALLBACK_NOOPT('g', NULL, &callchain_param,
+	OPT_CALLBACK_NOOPT('g', NULL, &record.opts,
 			   NULL, "enables call-graph recording" ,
 			   &record_callchain_opt),
 	OPT_CALLBACK(0, "call-graph", &record.opts,
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 710604c4f6f6..2a949d956d0b 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1386,13 +1386,6 @@ static int __cmd_top(struct perf_top *top)
 	return ret;
 }
 
-static int
-callchain_opt(const struct option *opt, const char *arg, int unset)
-{
-	symbol_conf.use_callchain = true;
-	return record_callchain_opt(opt, arg, unset);
-}
-
 static int
 parse_callchain_opt(const struct option *opt, const char *arg, int unset)
 {
@@ -1413,6 +1406,13 @@ parse_callchain_opt(const struct option *opt, const char *arg, int unset)
 	return parse_callchain_top_opt(arg);
 }
 
+static int
+callchain_opt(const struct option *opt, const char *arg __maybe_unused, int unset)
+{
+	return parse_callchain_opt(opt, "fp", unset);
+}
+
+
 static int perf_top_config(const char *var, const char *value, void *cb __maybe_unused)
 {
 	if (!strcmp(var, "top.call-graph")) {
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1c38f3d16a31..f487fbaa0ad6 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -5300,6 +5300,13 @@ static int trace__parse_summary_mode(const struct option *opt, const char *str,
 	return 0;
 }
 
+static int trace_parse_callchain_opt(const struct option *opt,
+				     const char *arg,
+				     int unset)
+{
+	return record_opts__parse_callchain(opt->value, &callchain_param, arg, unset);
+}
+
 static int trace__config(const char *var, const char *value, void *arg)
 {
 	struct trace *trace = arg;
@@ -5447,7 +5454,7 @@ int cmd_trace(int argc, const char **argv)
 	OPT_BOOLEAN('f', "force", &trace.force, "don't complain, do it"),
 	OPT_CALLBACK(0, "call-graph", &trace.opts,
 		     "record_mode[,record_size]", record_callchain_help,
-		     &record_parse_callchain_opt),
+		     &trace_parse_callchain_opt),
 	OPT_BOOLEAN(0, "libtraceevent_print", &trace.libtraceevent_print,
 		    "Use libtraceevent to print the tracepoint arguments."),
 	OPT_BOOLEAN(0, "kernel-syscall-graph", &trace.kernel_syscallchains,
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 8ff0898799ee..d97421fbf159 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -30,6 +30,7 @@
 #include "map.h"
 #include "callchain.h"
 #include "branch.h"
+#include "record.h"
 #include "symbol.h"
 #include "thread.h"
 #include "util.h"
@@ -328,6 +329,44 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
 	return ret;
 }
 
+static void callchain_debug(const struct callchain_param *callchain)
+{
+	static const char *str[CALLCHAIN_MAX] = { "NONE", "FP", "DWARF", "LBR" };
+
+	pr_debug("callchain: type %s\n", str[callchain->record_mode]);
+
+	if (callchain->record_mode == CALLCHAIN_DWARF)
+		pr_debug("callchain: stack dump size %d\n",
+			 callchain->dump_size);
+}
+
+int record_opts__parse_callchain(struct record_opts *record,
+				 struct callchain_param *callchain,
+				 const char *arg, bool unset)
+{
+	int ret;
+
+	callchain->enabled = !unset;
+
+	/* --no-call-graph */
+	if (unset) {
+		callchain->record_mode = CALLCHAIN_NONE;
+		pr_debug("callchain: disabled\n");
+		return 0;
+	}
+
+	ret = parse_callchain_record_opt(arg, callchain);
+	if (!ret) {
+		/* Enable data address sampling for DWARF unwind. */
+		if (callchain->record_mode == CALLCHAIN_DWARF &&
+		    !record->record_data_mmap_set)
+			record->record_data_mmap = true;
+		callchain_debug(callchain);
+	}
+
+	return ret;
+}
+
 int perf_callchain_config(const char *var, const char *value)
 {
 	char *endptr;
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index df54ddb8c0cb..06d463ccc7a0 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -9,11 +9,13 @@
 
 struct addr_location;
 struct evsel;
+struct hist_entry;
+struct hists;
 struct ip_callchain;
 struct map;
 struct perf_sample;
+struct record_opts;
 struct thread;
-struct hists;
 
 #define HELP_PAD "\t\t\t\t"
 
@@ -237,14 +239,6 @@ struct callchain_cursor *get_tls_callchain_cursor(void);
 int callchain_cursor__copy(struct callchain_cursor *dst,
 			   struct callchain_cursor *src);
 
-struct option;
-struct hist_entry;
-
-int record_parse_callchain_opt(const struct option *opt, const char *arg, int unset);
-int record_callchain_opt(const struct option *opt, const char *arg, int unset);
-
-struct record_opts;
-
 int record_opts__parse_callchain(struct record_opts *record,
 				 struct callchain_param *callchain,
 				 const char *arg, bool unset);
-- 
2.53.0.851.ga537e3e6e9-goog

