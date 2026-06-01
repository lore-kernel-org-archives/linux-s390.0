Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259C73876BD
	for <linux-s390@vger.kernel.org>; Mon,  1 Jun 2026 06:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296885; cv=none; b=mCNkL5G9ccTuycA93e0TbfhncxSy5KbMy8A1ANMG7xBp7lD6t+Ga6OIMG4l4IYbV8RN1eumASuyrbeQAIEwvOqav+kFILduTOSRiVum8rDxw8xDK+AQjPTMr/Zd/5W3zPK/RrmnPHoiOu+KcdjPlZ6b473cbxJTkDz4Un7RCQno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296885; c=relaxed/simple;
	bh=8uoMqp0aJqUYXNK2EQueIMtfgaoPa8+9VIrvtSfSCEw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DosIbykenojhBjQFF0mRlygyvkoOh8ubUehvNlM+euFMIC4P4YyhISKTkvCBcaFYR9YPlu2roSOGY5lfGxJos7GXvgnFNSksEKGwzCitjOCg6GHymzLjTaloPjkVul2PcVIkYRvSZLF05J61cnZJGh4sNqwoTJmY9V5LfSLMzRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A8g8YyMf; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A8g8YyMf"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1353bfdbf99so2242072c88.0
        for <linux-s390@vger.kernel.org>; Sun, 31 May 2026 23:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780296883; x=1780901683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fuHGKH4OW88soTL/FBOGBXyBBZAx32Y7kqwtbJIjGP8=;
        b=A8g8YyMfZBqPQabprZ/l2ebQWZk4bXjPnl/HoMAoMAwIK8n/MANjKtnRex3RSw/VhE
         kMMVOyC7xnBWfNpnxHuKrbF1uQjxQsm/693iT5k0gcIaP6aitUVGcm1hn/VGuPrxwEBB
         NwzhRPoFHs5QpS5/DU98SqnChiEfEHa5qbM1WZpo9ennzHDW3oRQix88w4iLlKn6k284
         qPXcXz2BshigQgUjzV8UCAJ3TUPs8gHt+cvCTBpzcb6y1uePnM+9tPPt6rk8ivPNO8Hd
         hensjGdzKxphCU/4yKz44e4u6XHZPAHgilEtu2+rU9qnebktTyvYmDnY3oCDYcQKGzBc
         ehkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780296883; x=1780901683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fuHGKH4OW88soTL/FBOGBXyBBZAx32Y7kqwtbJIjGP8=;
        b=enayw1JvK6nu3nK6s7nIjJVjzIRLNffxwrQWaqGgN4tHQW8RsGYpv9juKAZ3/zHzZN
         9qR8oFfrt+ZEEMZa2iBVdYdVYPc8HSnMmAMy637zKxmI6uuv+Jf3I74MQJwxx0fJTtDM
         p6vY1Za4HxVvehPB0kO1fbCe7+3cPEwbpOrwpqXZK7C/OD/OIYxzJqXhQopUwSYBzI4B
         i2fWfQ+IK2ZFcTlpgGTyzQ5dF/YQP4qDxHRoAeX2wOy1H6hQE7tdprNffy55LHGzY4KN
         fIOAA+9jXgSlfGvd2sZcuCyQiONKzVyR3CSsadHLa6qGl9JNpH3LtUs//800hjzxZkjN
         9oAA==
X-Forwarded-Encrypted: i=1; AFNElJ//pktKU/ea+MSd2kRERWaelRK8N5f20i43+2Qb44U87bToCiyPWVvwM/ZEI5HMzbVKihAxetDtYbD3@vger.kernel.org
X-Gm-Message-State: AOJu0YwcfaGktKRWorOLlXsk7h3yqXD1wA9EHuFo29ZdFgz+uT1FWNwY
	ZLhpK0niwfF2Re86TQ/ncjRTSv7BUNqxsRvEqrqmvnRQdIJ4bdLWutNcV2ChtGaeO12/0FKk3dN
	k6tT96+dFsQ==
X-Received: from dlc3.prod.google.com ([2002:a05:7022:383:b0:12d:b2ba:b551])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6299:b0:137:64ce:70cf
 with SMTP id a92af1059eb24-137d3697e54mr3749858c88.0.1780296883235; Sun, 31
 May 2026 23:54:43 -0700 (PDT)
Date: Sun, 31 May 2026 23:54:04 -0700
In-Reply-To: <20260601065407.1597927-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503002248.1040791-1-irogers@google.com> <20260601065407.1597927-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601065407.1597927-16-irogers@google.com>
Subject: [PATCH v10 15/18] perf env: Remove unused perf_env__raw_arch
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
index 0db74ee05d08..f61e10864613 100644
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
index ba51b871c401..bc4801d8399b 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -192,7 +192,6 @@ const char *perf_env__arch(struct perf_env *env);
 const char *perf_env__arch_strerrno(uint16_t e_machine, int err);
 #endif
 const char *perf_env__cpuid(struct perf_env *env);
-const char *perf_env__raw_arch(struct perf_env *env);
 int perf_env__nr_cpus_avail(struct perf_env *env);
 
 void perf_env__init(struct perf_env *env);
-- 
2.54.0.823.g6e5bcc1fc9-goog

