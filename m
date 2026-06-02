Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337F63A9D9B
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 06:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381542; cv=none; b=lcA2lfaYoAU0YuES8TLDgOOdyuivcwJPJ0bHhTUeWjDBlyMjlOKiOA9TmKjxPpBJT3GG9vIbh9ya3/E86gy/mKSJmgzh7ljlEGP0TEWVHxNmS4s/foOA7a5uwTdGJuLsYckDtByAOhTEhmQ6Qbwu8hz/QFXgIRtb3zqaJLjtVIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381542; c=relaxed/simple;
	bh=wBx2XjIbGKm4f6lxUHRV7mNoOSTxIfLQoUK89yQfzt4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pO+rrSu1zQQQ1SSGF8U4U/Rv2Wj9g9OGCcecLYCaHXDCMftDbmmdLMVw/MzWeCb+Wrz4EyWgLQnZ0TPZDbqAhG3t2x/qX3hE7BKX0vN/lAKlz13CJgyms6oPyaX0uXJn5C3oaUl5iofm0K1qQM9gCscU0bhln+i4DWEjpfZoywk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ckZliROS; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ckZliROS"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-135de949041so19146844c88.0
        for <linux-s390@vger.kernel.org>; Mon, 01 Jun 2026 23:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780381540; x=1780986340; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=harhKEg0rLSKe3QU5NRI1JfZjDmZUxT37Wq4SdyYcDA=;
        b=ckZliROSsgzWyApV3wmO6jGdaMMrutW79bBgzWt5Y7Ng7gtmIsemLzG1vd9N8V3Y3z
         D23XfxaXFPlVBP+sfm5wNa6ZyadZTiJRhxenBjgEG6oe2zp5CwRpoOcgzNH94C6StWpU
         duY1lPRtjZt6rJrvNyCqdBAf4CStxNHPMvgcrwczPJOjBLZ+4noH9Ni7fe90x2WT//sR
         KQ6bMQIAZgd+JUuO75cPfOSvK2ES61LoeNJ5JTe0MfWNFsMG8xwLktltIUg6LuXNxQ0M
         noTVfVy4GoKmmqtIZ3AJoehDbUbrVjrECbgwPmArwPbGUTzz0eVluTa867wie/bloCep
         o3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780381540; x=1780986340;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=harhKEg0rLSKe3QU5NRI1JfZjDmZUxT37Wq4SdyYcDA=;
        b=CgSOSKUiAmsXqh5pTad6pHArDdS60n13CXNsCveiIcMBd3MmunGGtQ9Wcr4i0tno33
         jnHDe+IKyCaYNEra65syjFQXKGfnvn6X8EyFwEDAcZWXgaTmfPm7vyxYbONihY7vu/kW
         0JpuElXYqVdzY3NwJr+6+utd2lHqq4Ma4ks47zHFWM0IgqTxfBJ83oOj36OmvX313CZq
         GNZNwc8dDVlSRw9MQpUh/o4MnNz5vxDGPixP6iqfHJZPSolsjr5750nHuWU7d/LqHhUF
         1j1w71FSspXr6AyGyZWUXD+nXo58cLQ0+UWERdpN/YocpARYrtTGRlQJV0exGxb4JhqH
         OeDQ==
X-Forwarded-Encrypted: i=1; AFNElJ/41JhnYLZitKmbGd2t406kjjRTst4HC1PDbqw/VIwy0kfjcxZQQCNPDJB32103Z8RwAluuqfKp3OoQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxJwR2MGuDxHTF7nh7c+QDbFiV2a27Sgwyv9/coQOp080ami0vS
	Rgcps+x32hOqfZ07MTQFaNe/ptOj9bBMmMMjj8hxc/Vt8MpmVNiCXB7nq6FOlXETtjTHtSxEwgv
	OclVW/CVnGg==
X-Received: from dlan16-n1.prod.google.com ([2002:a05:7022:eb50:10b0:137:c9b:c045])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:60a4:b0:136:da48:a3e0
 with SMTP id a92af1059eb24-137d4131b70mr6816594c88.28.1780381540139; Mon, 01
 Jun 2026 23:25:40 -0700 (PDT)
Date: Mon,  1 Jun 2026 23:24:47 -0700
In-Reply-To: <20260602062452.2583619-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601065407.1597927-1-irogers@google.com> <20260602062452.2583619-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602062452.2583619-16-irogers@google.com>
Subject: [PATCH v11 15/19] perf env: Remove unused perf_env__raw_arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The switch to using e_machine has made the perf_env__raw_arch function
unused so remove it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/env.c | 18 ------------------
 tools/perf/util/env.h |  1 -
 2 files changed, 19 deletions(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index b41562fb06c6..28c54c58193e 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -470,19 +470,6 @@ int perf_env__read_cpuid(struct perf_env *env)
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
@@ -601,11 +588,6 @@ int perf_env__read_core_pmu_caps(struct perf_env *env)
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
index 5a917271ca0d..83e74328798f 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -190,7 +190,6 @@ uint16_t perf_env__e_machine(struct perf_env *env, uint32_t *e_flags);
 const char *perf_env__arch(struct perf_env *env);
 const char *perf_env__arch_strerrno(uint16_t e_machine, int err);
 const char *perf_env__cpuid(struct perf_env *env);
-const char *perf_env__raw_arch(struct perf_env *env);
 int perf_env__nr_cpus_avail(struct perf_env *env);
 
 void perf_env__init(struct perf_env *env);
-- 
2.54.0.929.g9b7fa37559-goog

