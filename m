Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A202638C41D
	for <linux-s390@vger.kernel.org>; Mon,  6 Apr 2026 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775495354; cv=none; b=Q7r9BgK/ACeBX4itIMCYAKxdxCBadI8HcpvYASuzYKOaZFJLuZZi4fVwkZ4wPhxBP6HRG3EbMetFUnlxbii7LRctTt7n5s1YsMd4TaNLcLsbXmIdbkoQKdNzep+TSZq0g+g8zAyRqL6CK+HhyWWHh+kUvBrAAPCZCob3UmlSUTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775495354; c=relaxed/simple;
	bh=LZdCoMke5/0u4HN9HKrDslh21tKocju+fLLNMYjItQg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HzCiUqfBG28HxM8xdC3uYzz4hXyrELMUeL01VDI4zYTfHXtT5vejLF1qUXMVcOaaptZeHR5qZwGhwTcrG0wcY/4qEoVV3jrPd2zk9Jipg6Vc9omcwU3jHIQ0Nbp/Nzym8wTU/5qi2ghSpbGD4mng1VAv/Lm/HmYZtNQN4BH1gws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=deanAEhB; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="deanAEhB"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0ba59a830so5640160eec.0
        for <linux-s390@vger.kernel.org>; Mon, 06 Apr 2026 10:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775495353; x=1776100153; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPRV5zYhae9dacVlewfNI7WCT0hXtp/bTPy6oXFI5wI=;
        b=deanAEhB9aC8cjFys1zw0NG4JRDNAMfGz7aomxIr6UnSNx5BYFuu0Y4a1INZ9oTT2h
         nKY1HJ7g7evpwHkpJxfMUqGI2bybWZkJOlZVTcdsWbrraX+n2g044ct9lRtweY0UYHYd
         lOZrdwoY42+eZrRL7igk+dCUI9yQa0xQJiIh31VWQCNfAu5BnGJxo64VRSrRyq7wDJPa
         jeof4MP+DA3XNCY9+YbD5HbOqNPuh+rPl0Zgk3OFHuLsNE4DijuAR59Bh00q1L9FiXU3
         Qzx/p5j/U4Mio6Xe8zUAoL6XXEzeYdrWZdMuN149ztzQNPSLYdbyykM6uV7LF5rLOt0U
         Uh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775495353; x=1776100153;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPRV5zYhae9dacVlewfNI7WCT0hXtp/bTPy6oXFI5wI=;
        b=ojBBCnmNHwVj8t0ODWouyMXnb+hS3bVs+SGXKNR91fDmuVcSehQ15wuNCRtAEmGFEN
         RD+UqrYDrgXA4GlxlL7j5KP2oOHxPqgmmIPNrgQstkwE3qpAl9JTPl/CwDi67Lu9uVbk
         vz8EUS3osI3/BSVgGcKHopoHlzrjpwp3PjXwYSj0n3Iv6vl9vYK77sPFCysanOgG1mqJ
         rEQP4QRzCgQE9d+UlxLCA60eAorlwoe3HfdFFbQHRsKjXgp2n0NfIuVkxEQwpXjbY1dG
         o6jAB4SfgTlcaKfJKhXHHNw9nGB0uhZIN8PjMWwwXQyloCKDcGDg463u+0IaujQ7fUV3
         fd3g==
X-Forwarded-Encrypted: i=1; AJvYcCWYw8hEtqqEFC0g4lgIfKA4ZusgnhADKe9Qk/T2jqC+8dSvE04UkVHSGluH9XRgYpBoOVf3J98pQu9Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwUESzO68gJCTjib7F6KBsvZ5KNDWEldOq/IAvm65325cug7kB7
	3WyOhHlV49kth+qmAX1ef+uAeMAOPhCC6OBI45vSEAlnO+mrpeOKdguetvnHywt5i2M0zZsX/cA
	JZE7ijF+sqw==
X-Received: from dyhd22.prod.google.com ([2002:a05:7300:8296:b0:2c0:b626:c453])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4090:b0:2c8:7172:3b97
 with SMTP id 5a478bee46e88-2cbfa8ba560mr5981842eec.13.1775495352516; Mon, 06
 Apr 2026 10:09:12 -0700 (PDT)
Date: Mon,  6 Apr 2026 10:09:04 -0700
In-Reply-To: <20260406170905.2614260-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fXxa2rvxMqZoD5ayETiPjS8cf7A49TdVwwt+10uPu58Pw@mail.gmail.com>
 <20260406170905.2614260-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260406170905.2614260-3-irogers@google.com>
Subject: [PATCH v5 2/3] perf env: Add helper to lazily compute the os_release
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, jameshongleiwang@126.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

In live mode the os_release isn't being initialized, make a lazy
initialization helper that assumes when the os_release isn't
initialized this is live mode.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/data-convert-bt.c |  2 +-
 tools/perf/util/env.c             | 21 +++++++++++++++++++++
 tools/perf/util/env.h             |  1 +
 tools/perf/util/symbol.c          |  4 ++--
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index bece77cbc493..bc5805183100 100644
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
index 339d62ca37bb..34b737950f73 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -330,6 +330,27 @@ int perf_env__kernel_is_64_bit(struct perf_env *env)
 	return env->kernel_is_64_bit;
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
+	 * uname fails then use the current perf tool version.
+	 */
+	ret = uname(&uts);
+	env->os_release = strdup(ret < 0 ? perf_version_string : uts.release);
+	return env->os_release;
+}
+
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[])
 {
 	int i;
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 91ff252712f4..bf30a02dccf7 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -174,6 +174,7 @@ void free_cpu_domain_info(struct cpu_domain_map **cd_map, u32 schedstat_version,
 void perf_env__exit(struct perf_env *env);
 
 int perf_env__kernel_is_64_bit(struct perf_env *env);
+const char *perf_env__os_release(struct perf_env *env);
 
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[]);
 
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index b4b30675688d..ea7d2f2dbcb7 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2208,7 +2208,7 @@ static int vmlinux_path__init(struct perf_env *env)
 {
 	struct utsname uts;
 	char bf[PATH_MAX];
-	char *kernel_version;
+	const char *kernel_version;
 	unsigned int i;
 
 	vmlinux_path = malloc(sizeof(char *) * (ARRAY_SIZE(vmlinux_paths) +
@@ -2225,7 +2225,7 @@ static int vmlinux_path__init(struct perf_env *env)
 		return 0;
 
 	if (env) {
-		kernel_version = env->os_release;
+		kernel_version = perf_env__os_release(env);
 	} else {
 		if (uname(&uts) < 0)
 			goto out_fail;
-- 
2.53.0.1213.gd9a14994de-goog

