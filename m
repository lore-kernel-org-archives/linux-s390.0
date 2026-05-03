Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7A723645D
	for <linux-s390@vger.kernel.org>; Sun,  3 May 2026 00:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777767806; cv=none; b=kfMnkuqpduSoyvOzxDtTELceZehjH9tvtcb9s0YdhRifje/ZW8dQ5FLs+qOTXXRPYVXd8Jw53wpGAP1bKSvL+iQMREqpxcwZ4cjz2SElHNFx/MbCsach1oLMXLCwWSWBNyqN5dWNZJH04O8bcZIU4tZcAJM7hFdYEH2Qh5ruTb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777767806; c=relaxed/simple;
	bh=w5kpdZYj1td3iRz5bsagJOu+tDvOqzls3fa/ZafOK4s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JVjuT2aThTBDUqrLqQ4xBbxAb7nn7S0S0Wkt2CkSYAe8dL7l5prAVNjFjRoVksqcQdDmQClHYfNTgOXY6En/HqzhSPx6dlitQyY3A3PFtvOcvjSfCvHU5SdP6VaXNpRz352tkGTN1tPTE/lrt7UbRCfQa6o1XBSxNRVhc/YCT7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C6/teL5l; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C6/teL5l"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dc1c0b7ccso3700233c88.1
        for <linux-s390@vger.kernel.org>; Sat, 02 May 2026 17:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777767804; x=1778372604; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9x9Wl/o6+3fkfHLuSXv5iQt4Ma9xKjje9sib/Ct92Ic=;
        b=C6/teL5lTIOfyiRp+NHXpFYmdq+x6+/Udq+gRtAdRFQL9gqQ7oW9WRbM2LORgV9cke
         XkheO4HrANutjI5OqmB+jf6GrsU8cZDMT8XSLe9A1RLBFne0Yn+bRTTS43fUu0nBdHPR
         Cne3Q/DUYkkj+/4jfwjfXaMda/cgHJqkesi08qF9k5LeZFnKTo9A2dhJRMTalryfpbTR
         Tds/HW5x0b3bqFM0JWCV8V8otXxRRR5CDCUKwpEfuQWB5Kdusgha9SU/r6cyAMS0BVRd
         ZTW691c0/bfr87crzZkgU6N8kIvKxJks5yh2P29UjhiVosYY4hL055ookrgLLpf7hK2J
         yo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777767804; x=1778372604;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9x9Wl/o6+3fkfHLuSXv5iQt4Ma9xKjje9sib/Ct92Ic=;
        b=JR7wFgLIsMnkBFXA1DndBovvGP7OUUnef2+mf/p/B0Kd+/q7aPdHXzocU3kM6nQhu9
         w1NrjK6GjllfUVaFfKOfHCfGQ5f7VsqxwezY+U6L3rb2FZ2INc0cJnB+GpJuvGsIajUK
         Pp4yETXuvt7tJv1k/XAqrXa+FJV3EQHtqmCm1AKORy8KmtbTx1M7DtZdGFAgpRGY/eAt
         HPLLEeaYmvN/5tVqwUlsbnMnTDNkYp/OsiNzlHr7wQwh5j4MVwDR2hiVZuoaFd/Lq8+n
         K8x5ezEEjx3p8VOIOgDq6zvfucO6j6+vr4KnyWlFKD5rFN+Wx717vJcT8blYlD4eBNBB
         bZFQ==
X-Forwarded-Encrypted: i=1; AFNElJ9/vDA+MBKSPgnsmqx7pN5l/JHxGhNgQGcvPJUhdUR2muVWkWDhXtEpToeiEVibAGF0E7m3UGhFKL0e@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5fr4Si3SKEBN37R4prEXxvl597bKLPWLFoT53lFLybxTtF6u8
	SCJi6/NwDuirDSM6P588vlLI/Hq2MLl04THGezEeLEvY/kP0HCbgvh1PteXhdyDEro/yXH3V5FK
	Tn791+URxWA==
X-Received: from dlrr17.prod.google.com ([2002:a05:701a:c951:b0:12d:b6de:8dbe])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ef01:b0:12d:c4b7:5625
 with SMTP id a92af1059eb24-12dfd5439b5mr2076377c88.9.1777767804253; Sat, 02
 May 2026 17:23:24 -0700 (PDT)
Date: Sat,  2 May 2026 17:22:46 -0700
In-Reply-To: <20260503002248.1040791-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502065935.291960-1-irogers@google.com> <20260503002248.1040791-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503002248.1040791-17-irogers@google.com>
Subject: [PATCH v9 16/18] perf env: Add helper to lazily compute the os_release
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

In live mode the os_release isn't being initialized, make a lazy
initialization helper that assumes when the os_release isn't
initialized this is live mode.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/data-convert-bt.c |  2 +-
 tools/perf/util/env.c             | 21 +++++++++++++++++++++
 tools/perf/util/env.h             |  1 +
 tools/perf/util/header.c          | 16 +++++++++++-----
 tools/perf/util/symbol.c          |  4 ++--
 5 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 3b8f2df823a9..2c88420fe33e 100644
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
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 29d5fe37528b..45dde40042b5 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -351,6 +351,27 @@ bool perf_arch_is_big_endian(const char *arch)
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
index bdf6c5d0fd5d..ce0c392ead69 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -370,13 +370,19 @@ static int write_osrelease(struct feat_fd *ff,
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
index a4b1f837a5a5..fabed5b0fa57 100644
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
2.54.0.545.g6539524ca2-goog

