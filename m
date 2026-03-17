Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020E42C0307
	for <linux-s390@vger.kernel.org>; Tue, 17 Mar 2026 03:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773716777; cv=none; b=VNrlCSIObpaPWYSmVlq2Fw7lzGqNL8URaVJlh75UKyePiXKobqVa7LbLEaUffDaCg3Ypqr0jrpj3JRQUOC41f6z9SZXLwlRtsASB69spRsVBir/PMh/0Oh/3c3Boq4j4slsHFpObcAXaOzwokVBy6bW9ZUqnSZmgGuBFmbaN2eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773716777; c=relaxed/simple;
	bh=4mSJoDt19c1s52Ar2qiFo/PGbNpyNgJireRDLID11TM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FR2Hy1V/kAl/GeNLUZc6itqLuusD1Fr8Mj8EoYPyq4ugFhngttn3oZC+fFbFof/uzceqOxsthWVvL/9Zkwqj5YFYLOD8Wm//bQmM+0eCDiUJjBSMU9cRZ5wMBLxOVj8pfuSxJHP8odElhZ1nnPKMypda4bNVgKeCaccbDroGK3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HP0tPOAR; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HP0tPOAR"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12721cd1a2aso35864179c88.1
        for <linux-s390@vger.kernel.org>; Mon, 16 Mar 2026 20:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773716775; x=1774321575; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jjPd8hYb03Ftsdibhr+aMw0AWnG2dzFR9qnmX2QMSHk=;
        b=HP0tPOARz4AVg+nU+dQLdliv3gbLBE1W7dMxYtdFa6KKfj57ZZxwoDaIgh60MFvy1e
         SAuhFGzTAv/N2if3rk+0KWoXyO+CII+jwhKeFVMZyseL1GtCPnLXH5JPI2wA/bN79+uV
         f8qSu33FxWr6ACkz0ep9yEQDA4t5bsP9mLj4iOqOOT3GtPVXgY9iSMw4imkDfHIiXaNr
         OaRgUvRXqowEsSDzXjAtD8B7/RG9ulCCf88hDEjTMPQkQEPwm9sRSiFUGGAiBub8fzrI
         FPj/GV0C7+p1UHrNp+DPZzZzy3wCRo1NhmYiC0FnijDbpaptYP4m4dmLI5BJgeAR3dKr
         A7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773716775; x=1774321575;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjPd8hYb03Ftsdibhr+aMw0AWnG2dzFR9qnmX2QMSHk=;
        b=ekTZ5H3d4jqH+r7ANU9I6E8rnrWB/c/J7/mjpDm2MLBhF/8THSZebzizTaXktuvkJz
         d2MwEQA3s1sCEazKDFl+1bvtMEe/jHIcdp12bB5fGHuJw/jnVv/NgGinMwW6+Nx9nfYm
         LuFu0KlbsbATJcb4dvLQOnxgYF0trmXYg5UHxbU8sLt1i1zcPUt87O5hORbRMBjOXIZu
         R0jeW1uADaT2zPx7trDjGxQPMUrB9zRGqzA9//Urnt69yHek9n0cpb/xvMFGW2Zz5elT
         58YssGBbb781lWgCsn17xuQYnjS0S/M+gGJB1pC//dQxdE5PnY8mjFLmOlmGVbNX0oZE
         5ouw==
X-Forwarded-Encrypted: i=1; AJvYcCUUKpT7Ss/deGN21QDuzNrs1NgfQdnXkqYnzhADvmxmOjozYgkuvl3FJYVmcK/vJ+/fbxlk7gTeHH/q@vger.kernel.org
X-Gm-Message-State: AOJu0YyGQ5rzU+4c1fmiV2mtKqnMAmuigcQCYN06z62aBPFHYg+aEGcA
	Bwq8uRfzxLp4T7qHIkNCZ6z4TAaQIcohagzFYiX5p/0PtgffGrdhk7A/PQmS+IoCLuZDBWk+gJ5
	iT/j8yEZ/HA==
X-Received: from dlbrs10.prod.google.com ([2002:a05:7022:f68a:b0:128:cf1e:df72])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2207:b0:11d:c86c:652e
 with SMTP id a92af1059eb24-128f3d1bb6bmr8508921c88.5.1773716774841; Mon, 16
 Mar 2026 20:06:14 -0700 (PDT)
Date: Mon, 16 Mar 2026 20:05:58 -0700
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
Message-ID: <20260317030601.567422-3-irogers@google.com>
Subject: [PATCH v4 2/5] perf target: Constify simple check functions
From: Ian Rogers <irogers@google.com>
To: tmricht@linux.ibm.com
Cc: irogers@google.com, acme@kernel.org, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, namhyung@kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Allow the target to be const in callers.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/target.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
index 84ebb9c940c6..bc2bff9c6842 100644
--- a/tools/perf/util/target.h
+++ b/tools/perf/util/target.h
@@ -49,22 +49,22 @@ uid_t parse_uid(const char *str);
 
 int target__strerror(struct target *target, int errnum, char *buf, size_t buflen);
 
-static inline bool target__has_task(struct target *target)
+static inline bool target__has_task(const struct target *target)
 {
 	return target->tid || target->pid;
 }
 
-static inline bool target__has_cpu(struct target *target)
+static inline bool target__has_cpu(const struct target *target)
 {
 	return target->system_wide || target->cpu_list;
 }
 
-static inline bool target__none(struct target *target)
+static inline bool target__none(const struct target *target)
 {
 	return !target__has_task(target) && !target__has_cpu(target);
 }
 
-static inline bool target__enable_on_exec(struct target *target)
+static inline bool target__enable_on_exec(const struct target *target)
 {
 	/*
 	 * Normally enable_on_exec should be set if:
@@ -75,12 +75,12 @@ static inline bool target__enable_on_exec(struct target *target)
 	return target__none(target) && !target->initial_delay;
 }
 
-static inline bool target__has_per_thread(struct target *target)
+static inline bool target__has_per_thread(const struct target *target)
 {
 	return target->system_wide && target->per_thread;
 }
 
-static inline bool target__uses_dummy_map(struct target *target)
+static inline bool target__uses_dummy_map(const struct target *target)
 {
 	bool use_dummy = false;
 
-- 
2.53.0.851.ga537e3e6e9-goog

