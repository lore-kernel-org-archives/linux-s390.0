Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949B22EA732
	for <linux-s390@vger.kernel.org>; Sat,  2 May 2026 07:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777705215; cv=none; b=aderK1c/lLAvzSOKZ0DBVIMeJCntdNuFaWrvKgSgcoTEzau3xJf1wFmCh2RiM3HjhFomeLsJYxVY47lOJz+mkdRtU19CyPwQN0A9O/IB3B03I/MhASuqI6c+kXl43+fM4EAsvrvti4RZYBLHT2SjWwteY4nC2Cp3oUQlupQ7PLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777705215; c=relaxed/simple;
	bh=8pZBTMKNN/jJqySvgJqw5r7/hkTpkvHX1Y98+t8TyYo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qmTyIO2u7N24aBtGH3+c3ddcAD7GBnSaD+iVI1ZUcWrGZtrVhkJUHlWiAsR3BNhQT+hwKTsZRHuIdw96zofWa8Ndl+NXWFfpFa4Ooq3HAzgWiZkGMLmg1XO8sc/BJwGdOZMvGURosf5QpUjnzWyO5mFvikoO8ffIDHjOPY/4uYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lGkDc6Ur; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lGkDc6Ur"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dba1e866dso2474307c88.1
        for <linux-s390@vger.kernel.org>; Sat, 02 May 2026 00:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777705213; x=1778310013; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NzXq1ispBEt7q5g+srS1tYr5zmRtUudu86fKDB5S4d0=;
        b=lGkDc6Urtu1pLrcRrzy+4/OAMqGuURPB+3RWCnBk6zWGLIP/tU8lCpxHVCvpSP+U/d
         fjZ/rWc6crnwKqSkCwk7xJ9q4XLyMUTk2JPyW6348QeXnj1eEywzSSu2YPatMGBA6TiJ
         BT5vspWDnTYSnDJMXjXwNn4XhXwfzxBYOEw5gSGEwTvK5rSCGTdWJCCzBtPC84FWQxS6
         47dOZytoJ0pOQ17+71RK3qprl7xSzItl1spw+RQG4BdS98RGE9nxzw/GL2gdWqcEI53v
         ry1fEWGweysVTv9JOwVSf1N3V7X1QANK4lx1pYls7ZUJOfw2Lj5IZcHcEGXFAsvNOkPJ
         4egQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777705213; x=1778310013;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NzXq1ispBEt7q5g+srS1tYr5zmRtUudu86fKDB5S4d0=;
        b=NObsVuU+wA1o1+ObzbYBYjhaU9pC2BGy6I2OxoaQ3rMMmi5kYDLOJl5mqVDuTqw3he
         3Db1znElDsHbR+hxd4J7iUiKk3IeAeDbqVsw1Xl4H/HGdrsTJ9jLPracQmP/pBhEea+Y
         BhA4lYx/j/sv7eKyj6VOFz72jcbUC3xuiTgO3WIGSiu7Ty4pRX8VhH6jXmJZUQi/f8LD
         XsRZI/dCpENFma2UsrvBOjjhZt8Oof7D0Q7vFH2GyL8yPbVYb/UyqUJc56msRAOWczfr
         tx94+zb+ZQz6TyZmvZrxUa6or3pqSZ3JnEKLHIwHAs0BBaaVdwkJ3WYV8pZI1C5TECke
         z5Bg==
X-Forwarded-Encrypted: i=1; AFNElJ9Yf1J7Mpnd8cvlsFX/nP0c0pZbY04AtLre/9plB9A8BFbGTLfQ/mkj8TSjlSoyyu+etAdjiinOgLxc@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt245MQ0z3LQvky3iU64CLOwwPuj4iKZvwOUAkBcjMP/3Jl5Se
	w45YS5vlloLtBMh2c1m7k7M9Olvu0qUfPNa/I5QN/OKFWLT1ExFd0wRNfVZrZsG1mf+uLQJqAzW
	qvydt6PQE+Q==
X-Received: from dlbuu10.prod.google.com ([2002:a05:7022:7e8a:b0:12c:87ba:191d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:221a:b0:119:e569:f874
 with SMTP id a92af1059eb24-12dfd5c35e0mr875871c88.17.1777705212271; Sat, 02
 May 2026 00:00:12 -0700 (PDT)
Date: Fri,  1 May 2026 23:59:28 -0700
In-Reply-To: <20260502065935.291960-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409230620.4176210-2-irogers@google.com> <20260502065935.291960-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502065935.291960-11-irogers@google.com>
Subject: [PATCH v8 10/17] perf header: In print_pmu_caps use perf_env e_machine
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Switch from arch to e_machine in print_pmu_caps.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 8d5152bde25d..c6436269df4b 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2348,15 +2348,16 @@ static void print_cpu_pmu_caps(struct feat_fd *ff, FILE *fp)
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
2.54.0.545.g6539524ca2-goog

