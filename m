Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE0A2C029D
	for <linux-s390@vger.kernel.org>; Tue, 17 Mar 2026 03:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773716783; cv=none; b=eK/RzM5Ijj8hFaC9GUar8jzoOZuv1n8ky790ic7yUN3R09ES2n/oxADKaYpitFpdenTSnFXziNDwV2SZUFeeEDp0y2jEvgWsWq7oETM1BNcvP/3khViP7A063cnyHa2tUu3Rf6iilQjgm2+9pjfw3kTxKy9Y4t4adtyQHA5RC6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773716783; c=relaxed/simple;
	bh=wFHt+RXPYaoMpN49aVwmknQS6OkUFFM8RCJ8fUdhfGo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lTxu+mKgZN/pHj0hVCAoT2rtejw7Egzv1030KMj7xh6BYdOXU0toTl4DQCn17btmm/os+rEAzl3z6u7qCBKXS1DHpTCn4VFaxC3CEwPT2bGLrLHek5bH3hP0ARo9vSms/KdQOtlxXps5PDChsPPW8VkM+nhRgE62WVutUFcnytA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CR/xH+Xv; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CR/xH+Xv"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-128d0a51897so105893570c88.0
        for <linux-s390@vger.kernel.org>; Mon, 16 Mar 2026 20:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773716781; x=1774321581; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JtlcpARj3/CUpU+u9sBllSJiui9gfcTa1xLpo8ZWqOw=;
        b=CR/xH+Xv1ZDirm47BNXSADybqEA8t4iS7izG9uCbY0o2ZEwwamIq/hgDB2bvJAdudt
         LCmkoLejd7puAgMWBT2TOx82/B9imILStxYluGJjCs0gA+i3Z3kcCCYjpAJWHarWi0dz
         snfePmwYca5y6gQ3B/aJSYV10IjgPJ4UHTVN0EN+KTeAT8GkUdfXvoKW3uwLXYYGhpYD
         IISaJmv6EtKtXBpXXMh10h2nK2waUkMKXlw7/553V6bPCL3S0WT1uYArhdj17HzpRMT4
         WTUieHpgWtLw3YQLvWenL3oanXMGYJhFXWezYV24jz21U8G3iviN2Cd3VfSyXapW3sgV
         tuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773716781; x=1774321581;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JtlcpARj3/CUpU+u9sBllSJiui9gfcTa1xLpo8ZWqOw=;
        b=okIfR2vwBJ0jkSrUS/inPYLDl7Vr6dv6oOwXyrVe+g9ACbWsHMnRAYcbbCsBdHSAcJ
         kI9v4vUOm/5FbZBD0Fki55yLfCuT/9NXmkb53CBX1azdVNCYhVq3XTs3kuTk+sao7ywk
         Qdu23XvCGrpsC9nNfZaOYf+mAZlf2kpkR84F75tb/49rkTjngFr3bANP3w/ZEksx7+rS
         5SN4DvAn6jsEKyhGYlCddbySmVzbi9Kt0o+4X2msew04eB/09AcbT2wi0w3ws8NwxXRu
         scXkE93EQoQBOze/Vl+ORIpgZbCvikj/MYRs1T2toblCl3b4V7ppvj8oqbe81l5/Vh90
         coeQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8X+ezpwTyp1bgi+SEnRhk1p0kGG1Md9YBQJzelQA17Mm4bZZN0DpGlKLM2RITFk3KneXDiVPlQ/uL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Q7oxQUIsayqI0LK55NrP+rAUmuuItMtkZbZN5gy9Mx48Taz6
	zqPsCQUyoYBT6VFDLwXjbgiT2jypeF3VdjtnrI0aU351FKcdF+D/vMcFbEV3whEgCgPmewy0rgk
	tCZVkMOeRRg==
X-Received: from dlec14-n2.prod.google.com ([2002:a05:701b:428e:20b0:128:d754:39d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e25:b0:121:a01a:8e2f
 with SMTP id a92af1059eb24-128f3e471camr6960875c88.42.1773716779361; Mon, 16
 Mar 2026 20:06:19 -0700 (PDT)
Date: Mon, 16 Mar 2026 20:06:00 -0700
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
Message-ID: <20260317030601.567422-5-irogers@google.com>
Subject: [PATCH v4 4/5] perf callchain: Move callchain option parsing out of builtin
From: Ian Rogers <irogers@google.com>
To: tmricht@linux.ibm.com
Cc: irogers@google.com, acme@kernel.org, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, namhyung@kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

record_opts__parse_callchain, record_callchain_opt,
record_parse_callchain_opt are shared by builtin-record, builtin-top
and builtin-trace, they are declared in callchain.h. Move the
declarations to callchain.c for consistency with the header.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 59 -----------------------------------
 tools/perf/util/callchain.c | 61 +++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 59 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 40917a0be238..e65cd7bf1477 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2975,65 +2975,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
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
-			       const char *arg,
-			       int unset)
-{
-	return record_opts__parse_callchain(opt->value, &callchain_param, arg, unset);
-}
-
-int record_callchain_opt(const struct option *opt,
-			 const char *arg __maybe_unused,
-			 int unset __maybe_unused)
-{
-	struct callchain_param *callchain = opt->value;
-
-	callchain->enabled = true;
-
-	if (callchain->record_mode == CALLCHAIN_NONE)
-		callchain->record_mode = CALLCHAIN_FP;
-
-	callchain_debug(callchain);
-	return 0;
-}
-
 static int perf_record_config(const char *var, const char *value, void *cb)
 {
 	struct record *rec = cb;
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 8ff0898799ee..1203d9d23fda 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -16,6 +16,7 @@
 #include <stdbool.h>
 #include <errno.h>
 #include <math.h>
+#include <subcmd/parse-options.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
 
@@ -30,6 +31,7 @@
 #include "map.h"
 #include "callchain.h"
 #include "branch.h"
+#include "record.h"
 #include "symbol.h"
 #include "thread.h"
 #include "util.h"
@@ -328,6 +330,65 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
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
+int record_parse_callchain_opt(const struct option *opt,
+			       const char *arg,
+			       int unset)
+{
+	return record_opts__parse_callchain(opt->value, &callchain_param, arg, unset);
+}
+
+int record_callchain_opt(const struct option *opt,
+			 const char *arg __maybe_unused,
+			 int unset __maybe_unused)
+{
+	struct callchain_param *callchain = opt->value;
+
+	callchain->enabled = true;
+
+	if (callchain->record_mode == CALLCHAIN_NONE)
+		callchain->record_mode = CALLCHAIN_FP;
+
+	callchain_debug(callchain);
+	return 0;
+}
+
 int perf_callchain_config(const char *var, const char *value)
 {
 	char *endptr;
-- 
2.53.0.851.ga537e3e6e9-goog

