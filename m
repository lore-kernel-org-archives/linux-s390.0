Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD18318EC4
	for <linux-s390@vger.kernel.org>; Sat,  2 May 2026 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777705223; cv=none; b=Bh8IkHvliEClSnBAu3Q+OhbxXWPWgCjoTSB1VI+aHnFNFdy6b7tt3MP3JCQqzxDhFvJvmYaB3sK7jD+Zk4d/wdnB9xZSHaTIUWw8EEXZqY2qV/Iq30B8xOZ7DRsH7fg1+qFuaOgr5reaoNIB3QLELFd2De+ZDn5sFbbwnYNIRNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777705223; c=relaxed/simple;
	bh=c4FiPhwMPGjOldhXx4uHpCVyzOAjd9KqZ+0a05dC6CQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JXwGPfEl4D+RpxZV5sxbC9gdFBhPHX39pnNy7Q9myNU48vZCOHuRc8aa3mzJ1oUCZRRtPqxGm5G0dY3V8VpQeT0YGRX+h8a36bgMoaoITPT0YxyDzqal4DOAw7yKwmv5N5SHi/foFbLyAnGc7niI2dFy/OKW8239utc2v3Voekk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TiWcYNau; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TiWcYNau"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2efc342ef15so831646eec.1
        for <linux-s390@vger.kernel.org>; Sat, 02 May 2026 00:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777705221; x=1778310021; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NWG6WVYKqonosS/UYZznxYSjLbNNh2VpTpdvGbEDeek=;
        b=TiWcYNauAR8lclOwkz40/HL/Zd9KGhgQLInFOcBid1KY4q+nEAaUd4d0lGFJDv9saD
         7AF0YExkR9DO1Kj1FxBt27OOr0tl2/sdlK72GC/fnx6/Clq0HbeACcoHVRdElXEAGM6v
         YVjOTWVXAVJeTz7zYVy/KzL1jQ5qao7mrdbNmx6EtUaGsFIECJb5qwTPNcGcABl0tYd+
         tJvP0pU41Deyn+d1fS6eOPCK5acnVaW3vkudQQzBaZxDx+9Qcdo39pVGzesmNRFMhKrc
         gs/8EPp7h9WJoPzFlmJxdlsKvyEKP6oMlKthPJ6H9/SXI4MJ/AThBhdM5bCANkE3ERx4
         KI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777705221; x=1778310021;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NWG6WVYKqonosS/UYZznxYSjLbNNh2VpTpdvGbEDeek=;
        b=nHw+/OXsoxReNz4bzpwnmkcRYrrIzS18i9FiP+TjwZecU/XyUHAwb3ykju5MueG9RZ
         j7Hvg8OrjJAlgW7r2Ec0wLzSD2DWAKGdljH6h0tH6alfU9mJ46k1gZEdn7a+4LZ7acaP
         886U+L9nPclrPHZ9leUSZLYNphiMR/zITfHj7KFBr5cuv+Vr/SxXGiwMxz2utUew3TXY
         qyVFRe0IEMzwU7vPTU50CHj4E8K1oSEyGWgkDqF8z1A00Ht/yhxYJZW91132Ts9b+A/T
         uFO9vY3TAhRTNhx3WJCp9I8anyk6B7892zgDz7TiirZs90Uibv6IyHCDUKXM/nUSdybf
         6EBw==
X-Forwarded-Encrypted: i=1; AFNElJ9S1CRLjsLbvV1EDfJpyX/CnxU4nY8EILNhNdVPnLGboGENolWH+WjDh0VAlMvAN1R5uqGfUt/Regf8@vger.kernel.org
X-Gm-Message-State: AOJu0YxoAWTTipdTNgmzACE4fCPI1FNWwlQUd0G1UhBqAdaZYCF1fO3z
	W2sbxomx7OxzrRzGn6A+wCNvM6GKETN+uvYe8tX3N+aCU3n0/hhiQjOqwf8bQbUZCsMMbELYSiU
	XNK3/e8H5ZA==
X-Received: from dlaj8.prod.google.com ([2002:a05:701b:2808:b0:12a:ad8d:be18])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:699d:b0:12d:ea4f:99dd
 with SMTP id a92af1059eb24-12dfd83a00amr1001470c88.34.1777705220946; Sat, 02
 May 2026 00:00:20 -0700 (PDT)
Date: Fri,  1 May 2026 23:59:32 -0700
In-Reply-To: <20260502065935.291960-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409230620.4176210-2-irogers@google.com> <20260502065935.291960-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502065935.291960-15-irogers@google.com>
Subject: [PATCH v8 14/17] perf env: Remove unused perf_env__raw_arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The switch to using e_machine has made the perf_env__raw_arch function
unused so remove it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/env.c | 18 ------------------
 tools/perf/util/env.h |  1 -
 2 files changed, 19 deletions(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 97f4aa1131a1..5944acd28996 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -451,19 +451,6 @@ int perf_env__read_cpuid(struct perf_env *env)
 	return 0;
 }
 
-static int perf_env__read_arch(struct perf_env *env)
-{
-	struct utsname uts;
-
-	if (env->arch)
-		return 0;
-
-	if (!uname(&uts))
-		env->arch = strdup(uts.machine);
-
-	return env->arch ? 0 : -ENOMEM;
-}
-
 static int perf_env__read_nr_cpus_avail(struct perf_env *env)
 {
 	if (env->nr_cpus_avail == 0)
@@ -582,11 +569,6 @@ int perf_env__read_core_pmu_caps(struct perf_env *env)
 	return ret;
 }
 
-const char *perf_env__raw_arch(struct perf_env *env)
-{
-	return env && !perf_env__read_arch(env) ? env->arch : "unknown";
-}
-
 int perf_env__nr_cpus_avail(struct perf_env *env)
 {
 	return env && !perf_env__read_nr_cpus_avail(env) ? env->nr_cpus_avail : 0;
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 68dead1b36a6..a95fd7eb3524 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -191,7 +191,6 @@ const char *perf_env__arch(struct perf_env *env);
 const char *perf_env__arch_strerrno(uint16_t e_machine, int err);
 #endif
 const char *perf_env__cpuid(struct perf_env *env);
-const char *perf_env__raw_arch(struct perf_env *env);
 int perf_env__nr_cpus_avail(struct perf_env *env);
 
 void perf_env__init(struct perf_env *env);
-- 
2.54.0.545.g6539524ca2-goog

