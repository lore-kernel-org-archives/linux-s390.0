Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC95D388E5B
	for <linux-s390@vger.kernel.org>; Mon,  1 Jun 2026 06:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296889; cv=none; b=hSxgozdjWYcTU8AN7fKAm1n6zjgnZvCazCeYt2TSkzLk7p79vgioLihyVFSkocWPfPk78teMh/cnisElOZRURi+k3nFZ0ue/f6hPv6Bn63DyWUJiqwh8D4CIpXwXK0y5gKcU8duJns2nSSZG5gfxd9o7+XLAVTQcxMyw2h7WEIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296889; c=relaxed/simple;
	bh=ppIZRWJCIdi0R6WxKrossCdeWWpHulk9rHQKH754pEA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WQzlUEq93kX2BGETX3vBZwgdRMEmc0+m8rIlxVYGiIWl9UNwK8jYVcFaNu4ahKEmKDBuOiJeo4FGkVh5+H3lHUxgm40wH1Ioa5WhKjzrOHnIZDwr5JI6mOwefYIR/udYIpju3I52QC7TKd5S7uR/OwIiXPq7EUOzoQaxoih0NmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ghlNsQHw; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ghlNsQHw"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137dd5100c7so1647422c88.1
        for <linux-s390@vger.kernel.org>; Sun, 31 May 2026 23:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780296886; x=1780901686; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6O94M81hJ4N35pLsSIuLDeaMOkTmNZoPh2aSEVGaEqc=;
        b=ghlNsQHwX9GTXdqA8qpt95798fpEdhQsnJRg+E0OaM9iKHZ+pNOOmnWHPl8o9lweTq
         aFf4AN32g/2ccYG6wEsEi5L1BAA82V5NIaLWsVFFextutLMfJoFDEuHmA7z+/2G50AOx
         bpj7jM1H39X/MrTAqiGJHcqXyE0SAQmuMlmP5MY0zZtvn0jVhIu74BVaSsTR6VIQGf4i
         rOy7DQ1p26tenJum9BnCnmawaB0FRY327UmommIekIc2u8qFap7ttrhijoHPTp03kEZJ
         SNOzKroPqs1ki2WSIt4Jj7PRJXhAezOsDWoUuf539dq6HTRGtCCv9fpbGRtywieDcOFe
         OGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780296886; x=1780901686;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6O94M81hJ4N35pLsSIuLDeaMOkTmNZoPh2aSEVGaEqc=;
        b=YeGZsEPFPqhHpOJ0o4sh4q/NoEancm3+tNXudvi9tcglcZzf59E8S8vOe8aJeSe6Rx
         KS9Ys8noi8RYTXaue0ZBmpnRBJciLLewZ6k+IB/sPT7UlT8jZ333wGPk/w7FP+qJ1x5J
         u4Kd4YNOPhYLb0ou7h8AFv2kfqoFuIzuOUNsoSnY+dqzHbXrMSz/7u+xHDpKK/wdg/0x
         CgMnHCA0Fcyh5bHt4PbU2tFYupLufAT0AN/MBrKWELHDCw/gsvK36zJFwFhFJUTYqztJ
         5NZO9L2cSziWIw6O5AE+aJKN7PuxiecDmQVlRYxgSU7PheEsq8SWRACF0JeyoeFrefzc
         HloA==
X-Forwarded-Encrypted: i=1; AFNElJ8fCAms6CXLMkWF9mM7eFa6H0gSBEtjf34kkJwJQyBKCOqWAUei2oDDnW2z9jZzRiWhg5g46fkcKyXF@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm5XHl4wKa6nJrUyXIOAZOkRmTaUuEaBvHvlVeFUgBuyCKawY6
	YzlxeSRyuyQi+9sui8NvNO9XkqM9IcR2WcIFNBTZ3hk1UW1H/kEegiNIpdWMoJJP74hFKLp5pBi
	gC91PedADtQ==
X-Received: from dlnn6.prod.google.com ([2002:a05:7022:6186:b0:137:e705:d11f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:497:b0:130:7246:10aa
 with SMTP id a92af1059eb24-137d3c0a46bmr3914743c88.12.1780296885587; Sun, 31
 May 2026 23:54:45 -0700 (PDT)
Date: Sun, 31 May 2026 23:54:05 -0700
In-Reply-To: <20260601065407.1597927-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503002248.1040791-1-irogers@google.com> <20260601065407.1597927-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601065407.1597927-17-irogers@google.com>
Subject: [PATCH v10 16/18] perf env: Add helper to lazily compute the os_release
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

In live mode the os_release isn't being initialized, make a lazy
initialization helper that assumes when the os_release isn't
initialized this is live mode.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/data-convert-bt.c   |  2 +-
 tools/perf/util/data-convert-json.c |  6 ++++--
 tools/perf/util/env.c               | 21 +++++++++++++++++++++
 tools/perf/util/env.h               |  1 +
 tools/perf/util/header.c            | 16 +++++++++++-----
 tools/perf/util/symbol.c            |  4 ++--
 6 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index b3f745cff2a7..cc51b8677c8e 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1414,7 +1414,7 @@ do {									\
 
 	ADD("host",    env->hostname);
 	ADD("sysname", "Linux");
-	ADD("release", env->os_release);
+	ADD("release", perf_env__os_release(env));
 	ADD("version", env->version);
 	ADD("machine", env->arch);
 	ADD("domain", "kernel");
diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index a7da93a7ff0e..c71dfb77c697 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -16,6 +16,7 @@
 #include "linux/err.h"
 #include "util/auxtrace.h"
 #include "util/debug.h"
+#include "util/env.h"
 #include "util/dso.h"
 #include "util/event.h"
 #include "util/evsel.h"
@@ -272,7 +273,7 @@ static void output_headers(struct perf_session *session, struct convert_json *c)
 {
 	struct stat st;
 	const struct perf_header *header = &session->header;
-	const struct perf_env *env = perf_session__env(session);
+	struct perf_env *env = perf_session__env(session);
 	int ret;
 	int fd = perf_data__fd(session->data);
 	int i;
@@ -296,7 +297,8 @@ static void output_headers(struct perf_session *session, struct convert_json *c)
 	output_json_key_format(out, true, 2, "feat-offset", "%" PRIu64, header->feat_offset);
 
 	output_json_key_string(out, true, 2, "hostname", env->hostname);
-	output_json_key_string(out, true, 2, "os-release", env->os_release);
+	output_json_key_string(out, true, 2, "os-release",
+			       perf_env__os_release(env));
 	output_json_key_string(out, true, 2, "arch", env->arch);
 
 	if (env->cpu_desc)
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index f61e10864613..b4fb7420b604 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -358,6 +358,27 @@ bool perf_arch_is_big_endian(const char *arch)
 	return false;
 }
 
+const char *perf_env__os_release(struct perf_env *env)
+{
+	struct utsname uts;
+	int ret;
+
+	if (!env)
+		return perf_version_string;
+
+	if (env->os_release)
+		return env->os_release;
+
+	/*
+	 * The os_release is being accessed but wasn't initialized from a data
+	 * file, assume this is 'live' mode and use the release from uname. If
+	 * uname or strdup fails then use the current perf tool version.
+	 */
+	ret = uname(&uts);
+	env->os_release = strdup(ret < 0 ? perf_version_string : uts.release);
+	return env->os_release ?: perf_version_string;
+}
+
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[])
 {
 	int i;
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index bc4801d8399b..bbf10446204c 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -173,6 +173,7 @@ void perf_env__exit(struct perf_env *env);
 
 int perf_env__kernel_is_64_bit(struct perf_env *env);
 bool perf_arch_is_big_endian(const char *arch);
+const char *perf_env__os_release(struct perf_env *env);
 
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[]);
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index ecdac427d9c4..d7f41db7322c 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -432,13 +432,19 @@ static int write_osrelease(struct feat_fd *ff,
 			   struct evlist *evlist __maybe_unused)
 {
 	struct utsname uts;
-	int ret;
+	const char *release = NULL;
 
-	ret = uname(&uts);
-	if (ret < 0)
-		return -1;
+	if (evlist->session)
+		release = perf_env__os_release(perf_session__env(evlist->session));
 
-	return do_write_string(ff, uts.release);
+	if (!release) {
+		int ret = uname(&uts);
+
+		if (ret < 0)
+			return -1;
+		release = uts.release;
+	}
+	return do_write_string(ff, release);
 }
 
 static int write_arch(struct feat_fd *ff, struct evlist *evlist)
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 2ce512f08a1d..077d19af5240 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2225,7 +2225,7 @@ static int vmlinux_path__init(struct perf_env *env)
 {
 	struct utsname uts;
 	char bf[PATH_MAX];
-	char *kernel_version;
+	const char *kernel_version;
 	unsigned int i;
 
 	vmlinux_path = malloc(sizeof(char *) * (ARRAY_SIZE(vmlinux_paths) +
@@ -2242,7 +2242,7 @@ static int vmlinux_path__init(struct perf_env *env)
 		return 0;
 
 	if (env) {
-		kernel_version = env->os_release;
+		kernel_version = perf_env__os_release(env);
 	} else {
 		if (uname(&uts) < 0)
 			goto out_fail;
-- 
2.54.0.823.g6e5bcc1fc9-goog

