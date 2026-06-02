Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151293A7D78
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 06:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381546; cv=none; b=XVVYdFQp7wizzWZIj3IBZmMU9CZvoL3p1/bGaPHjMEaL+bfOlC8SUMAg8g4DZBm8jYch8vMUWy3nN6NNh/CrE6EnUAl5BlRcFLTdFp7TsV9yOZHviV9C+RQjTvciB4DNPqOArnuzG1nUVEn+1Tuh+8Nc1ygl2uR+xWPXutP5uh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381546; c=relaxed/simple;
	bh=oEPhQLX1Ek4JDEAMVVpTFAR48XHl01x2bHjumb3ugBY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OWcyCWaoh6qvMw9JQJDG8Qp571fcBDlohY3Mf+wXuBqASIgaq1qnW0TzSROVD2tDOmv5O4eJWnZE5YGQ8fsxCEsiHMHmKJUc7S8zen05/DSBk0Sk2SDuHWVgaKSqyFAKpesai5BmFmvckOX2x3kuiyou9Klbq/P+/YJLr/ADuPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l9U+5Vxw; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l9U+5Vxw"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304df51ff3eso5042642eec.0
        for <linux-s390@vger.kernel.org>; Mon, 01 Jun 2026 23:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780381544; x=1780986344; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UDEMzS2LWsX2K2Wf8/+Lc3Fjy/mUFJQImrq1SId6ylE=;
        b=l9U+5VxwcVO4v0mmz0hm+WJWIi+ppLlIkfTSRdlpT4NDMuM2DulkpyQ4jF2E8GVMD2
         i70e2iQ/gKKlOSgm4nYHX0RbSWZ6j/00WxyT0jC5WXDoQsD89ddClbCeu4iGSkq56Pdy
         hKuiNVZ5s71CwBDbMNVtWF2uqKgiwe3qAE2EIE0QilAqL3t1aiCtKDemYlLx8zdHPhI1
         U3WQmGnsb+iXIM4YJGiWNshJeUwC0ilr8WXU2JxGnLWt5xHYU3OjUa3MLHp4QOtWrcjV
         0nBprkTKj26hth0UEz2nB2+yFVqKXyhItfWQuI/HbVqSmkRGCYd0D9O3zKuU0oTU3uR9
         DeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780381544; x=1780986344;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UDEMzS2LWsX2K2Wf8/+Lc3Fjy/mUFJQImrq1SId6ylE=;
        b=j29ibNSGgm3DFcIMMPBU2WZtF/sc93XWR7iogKZ+6fMj3YXth+veOxsRuh4RQA7Dvu
         rIhloy0t1TzzX53zcdFHpnpCaT6SkPmtbP7yG5O/hc7KCPUDUyWzXFUC5tTGEIGSrGze
         G6Ey/kZL7fHrT4+xMB8s6rkQV/7GLe1QKtrxU9pt5Bs+zp/SpsPYD4sLlQZHUdyyia91
         kmlGEV+sNlPWJOF92bbfvgeIgiy2My1Je1egdSWTMXqZ5qVbsEY+2cwZDqzeJO28uZSZ
         3EuvTPT8uxglrBRQlyzzBo2pMWUVQXXgJtvlqFjSm9ZF2UKEPG2Jj4eNbGQSCoyQwlEX
         5gUA==
X-Forwarded-Encrypted: i=1; AFNElJ87+hbJLrT5diZD4Y1AUafrCslkBW7pTEGpfouK+pGMBUUNtzNLOsEA+wfdXngthK6PyLlRkqym764s@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4uxrtD4N8wxv3PQx+6zrxzYPCbStXi1Yl6lPlAjdkjsat9vJW
	DfyyEA/ES9Xy5TxpU2KhanA/EgJpjWKJktmcdJLZgpdiMP8BjnsGzI/jvFaBYyOvkC+zAN4MLQ6
	NRWVKJkRmHg==
X-Received: from dycmo12.prod.google.com ([2002:a05:693c:26cc:b0:2e5:fa99:f6e4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:8605:b0:304:de43:130
 with SMTP id 5a478bee46e88-304fa4cfa07mr7002031eec.2.1780381543973; Mon, 01
 Jun 2026 23:25:43 -0700 (PDT)
Date: Mon,  1 Jun 2026 23:24:49 -0700
In-Reply-To: <20260602062452.2583619-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601065407.1597927-1-irogers@google.com> <20260602062452.2583619-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602062452.2583619-18-irogers@google.com>
Subject: [PATCH v11 17/19] perf env: Add helper to lazily compute the os_release
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
 tools/perf/util/data-convert-json.c |  6 +++--
 tools/perf/util/env.c               | 38 +++++++++++++++++++++++++++++
 tools/perf/util/env.h               |  1 +
 tools/perf/util/header.c            | 16 ++++++++----
 tools/perf/util/symbol.c            |  4 +--
 6 files changed, 57 insertions(+), 10 deletions(-)

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
index 4de07cc7ef5d..61b30f08493a 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -361,6 +361,44 @@ bool perf_arch_is_big_endian(const char *arch)
 	return false;
 }
 
+const char *perf_env__os_release(struct perf_env *env)
+{
+	struct utsname uts;
+	int ret;
+	const char *release;
+
+	if (!env)
+		return perf_version_string;
+
+	mutex_lock(&env->lock);
+	if (env->os_release) {
+		release = env->os_release;
+		goto out;
+	}
+
+	/*
+	 * If env->arch is set, this is an offline target environment.
+	 * If the os_release is not populated in the file, we do not want
+	 * to poison it with the host's release which would break guest checks.
+	 */
+	if (env->arch) {
+		release = NULL;
+		goto out;
+	}
+
+	/*
+	 * The os_release is being accessed but wasn't initialized from a data
+	 * file, assume this is 'live' mode and use the release from uname. If
+	 * uname or strdup fails then use the current perf tool version.
+	 */
+	ret = uname(&uts);
+	env->os_release = strdup(ret < 0 ? perf_version_string : uts.release);
+	release = env->os_release ?: perf_version_string;
+out:
+	mutex_unlock(&env->lock);
+	return release;
+}
+
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[])
 {
 	int i;
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 6aaf80c640bd..7621d1f73b83 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -176,6 +176,7 @@ void perf_env__exit(struct perf_env *env);
 
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
2.54.0.929.g9b7fa37559-goog

