Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFE33F54AD
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413963; cv=none; b=p/s8suHuHvDN3P0uRERFje7inF27Wdh0Dae/ZJXejuL9zDMF6BfHo+P+y9pU/pMOw0XZquTcEkwh6KfAQtxCUk4TNOIRikdGuf3sua50W8zfOJzGK2FpThRockIgykKohk0UBWKPkPRj4SCA96aHZQ6CMkOWA+ndg+TROuFWduc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413963; c=relaxed/simple;
	bh=1vKpGyCR08D55Ms8rIa5echQivY8IcjS5P3lKw+8Tnw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rs68uc0PZ18olAdgy464PInE7n/ZsJpaINloZFBLxELTpBILnzWJW+6JlWn0s10elTaB/NFzD9BD1zmSEAji5N1P6E62twJyjspRtK/ISxBHdj6wJeF/BNOSMeDC9IIMEp40PPayC/uz3tzL8tV6XTE1qd4iuT27ozq8N1ao05g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ix7WyXc+; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ix7WyXc+"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304ee7d1368so4352891eec.0
        for <linux-s390@vger.kernel.org>; Tue, 02 Jun 2026 08:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780413961; x=1781018761; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r4kzHtgoNcTXiq9f50i9J7MtKzWtq9qgg2LJuweT+II=;
        b=Ix7WyXc+RO/SIsZQ/51osuaNBAKel9vxBPUyA2hkK33zp+zoEdNttQty7nkXCNO8DX
         ibIbHK7OYyCUMcZOUUN4nqFRUEmwKDx+7Ar06B0Y43N+XR3XMINZ5rjv+ht4Jb9ewuPl
         JkusNiIXzi0I8qpFLXVjfK/j54asBAnPpjEBTZusmTE8iRFFZEJ94lTkPA5Bof34SHiB
         ArymQJmZl51inpQYmeyPA+fzk522JsTjrTOgSHdN8l8xr1NX6nVxwp/AbKtdwNGR96D+
         7gyNdo62cpxMPyXqvXK/AAkB45SCICck4lzbMP08ZBUBq5L5veJntLEFqt4pfL6JFge2
         46RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413961; x=1781018761;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r4kzHtgoNcTXiq9f50i9J7MtKzWtq9qgg2LJuweT+II=;
        b=UuaSQUsDRXseQgWjw3v0U7bqFiENQx6yyYnN0FZIKkRerfsWcpprzj6b9hors92Wvm
         d0jXj4Zp22LApSUHpsNxVm4EYzAdGdiAv5o0m1LdIxdP7LWeqJJB3UNPzDLGUK9xkCM5
         AQWzUKtu9WmAIB9OY3+Sjg6cm6Lzujfk4xYXZ5lSFwF3kCBoyNt9OC554+sh6zg3dOhj
         hydiorYckwQPlsS291tgKnIUxzvYdKZD+JaSWWuG6jR87LtAqSaC1xsZn/p4HZ/7nGVO
         vz3YpdsQgH+9shIKdkyDF8GmmurLUpecgC1at2zUa7IXV/wibJO/jddgo85RsdNHAjsg
         BhQA==
X-Forwarded-Encrypted: i=1; AFNElJ//qS6f9GySAdEg+gmfuFvSOjKGlEAhBSmvO8j4gMBZWZcGy6KdjXYt+ZNd6AiiTb3OQlORwUDmkGMI@vger.kernel.org
X-Gm-Message-State: AOJu0YzRQcnBR0VMMl+md0s9jXoY0DezKGARJgscOQ/MllbhQGRrfjxX
	OG1LfIJX1/Kp2B1+dgPXyBSVyJj8w/5HPaHepi8XhG025SGzC8+NqFL9J9XYKsZR8dZtCuykAeb
	98k9ToQNGuA==
X-Received: from dyhd9.prod.google.com ([2002:a05:7300:8289:b0:303:521c:29a5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6d22:b0:304:e997:e211
 with SMTP id 5a478bee46e88-304fa5e6456mr7994998eec.21.1780413961232; Tue, 02
 Jun 2026 08:26:01 -0700 (PDT)
Date: Tue,  2 Jun 2026 08:25:08 -0700
In-Reply-To: <20260602152516.2831152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602062452.2583619-1-irogers@google.com> <20260602152516.2831152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602152516.2831152-12-irogers@google.com>
Subject: [PATCH v12 11/19] perf header: In print_pmu_caps use perf_env e_machine
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Switch from arch to e_machine in print_pmu_caps.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 220e7720fbdb..ecdac427d9c4 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2461,15 +2461,16 @@ static void print_cpu_pmu_caps(struct feat_fd *ff, FILE *fp)
 static void print_pmu_caps(struct feat_fd *ff, FILE *fp)
 {
 	struct perf_env *env = &ff->ph->env;
-	struct pmu_caps *pmu_caps;
+	uint16_t e_machine = perf_env__e_machine(env, /*e_flags=*/NULL);
 
 	for (int i = 0; i < env->nr_pmus_with_caps; i++) {
-		pmu_caps = &env->pmu_caps[i];
+		struct pmu_caps *pmu_caps = &env->pmu_caps[i];
+
 		__print_pmu_caps(fp, pmu_caps->nr_caps, pmu_caps->caps,
 				 pmu_caps->pmu_name);
 	}
 
-	if (strcmp(perf_env__arch(env), "x86") == 0 &&
+	if ((e_machine == EM_X86_64 || e_machine == EM_386) &&
 	    perf_env__has_pmu_mapping(env, "ibs_op")) {
 		char *max_precise = perf_env__find_pmu_cap(env, "cpu", "max_precise");
 
-- 
2.54.0.929.g9b7fa37559-goog

