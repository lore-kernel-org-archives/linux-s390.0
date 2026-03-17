Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CAF2C11F8
	for <linux-s390@vger.kernel.org>; Tue, 17 Mar 2026 03:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773716775; cv=none; b=gi8TyHl+dQUad7BMyDix/19RRMi1dh/LuGIZ2N28ara9TAZugWYDSchdrxDMKGz8KXvpZAoQbX3GGJeCvVufQoeAQ7S1WrfuWXp0odJ0ZiOWuRGX0qm/8Teu7J1N6U1ANBgvn4bqIhqiEPKWal/LCRYTextvGyUjevUn/2/PyT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773716775; c=relaxed/simple;
	bh=wVIk574MaJ1ryn6M1d5QWZAOYLPanqIo/c++6wESi+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a3fxGAzU2Hfb7InHk4oJGQtcKKPOwaHJ5mA47fDgJTxewgERMkwHkdHb8GKxdw/56ijSQ13GyGzG/nkGSysrNh0BFv2+VOLC4AkZ7qwvlARfFCck/F5gU2St3FhkcNptiXK69Uj46uw94hHQZIAsNVtLxLTmwqeBfh6nKfEG/cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kc5Zsrc7; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kc5Zsrc7"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-128d0a51897so105890372c88.0
        for <linux-s390@vger.kernel.org>; Mon, 16 Mar 2026 20:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773716773; x=1774321573; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BC7DFlkd9xaG2royXDyXDCwOCftcIJRM1qoiGuRC8ho=;
        b=kc5Zsrc75XtQXWMlr9QFNaqSkuB0Pj8HMKsqmsEzWKZbEvzDTHgUz6fbuDR8tSHJDW
         BJgJ0d5HDruUjQ2v6cJ5RgM0PiQxJmqPNQk5XIq+PskB4v6pyhS6FS6z3sMPdPz5KxUZ
         QqLas6rMF+IJVjy38ioJGeSXyPiJbkv3goNLqDaHGkv8Mk0MUFTMEFNS3FDJu+xEJL+5
         Pu4D9ATtznrdbkZjzWfaKWXvdv8d0NuJtTx94SMQ+V17LFHJkGehlrqsGzZ63/tUk8vi
         DG7Be8QMjqqbCpnQAYvimeCnxbOevh4zpk6SYdcBYxucHaU9120kZ/TB0FSVyJgGWwS1
         dggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773716773; x=1774321573;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BC7DFlkd9xaG2royXDyXDCwOCftcIJRM1qoiGuRC8ho=;
        b=C/l/Ne/aVfkAoGEyNmSrOzBUPk62KDX3w0YGqlGwQaPVaZIlxlojYx3vbQ4+gyNFgv
         0GD9kiD92YtTbSgCwLSQiFmet1sykr4GI9uYPKznOqvcVFlBDIM/wtsxHLYKcEtgbiRq
         wF9Yo2engHeOC9qPARzh7w5j2MQf1QuYwM+24FfoEu7mtuiydbAIgntnPtAGoPODrlE2
         EfvWrpoe4/NmPJxnIDPqMBEBf9cLYzzz8s5WLkOzNWdtc3IlKrSby+4rz21noSTGXUcu
         vGbAjjyfdPCoxuuotwC2RrvwzF4YRfsBLUSVO+xpd415Yfc1DU6ymcOLopUyTOB6A0Jz
         GPlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBYUE/mQzxDH8kWftwhJbwYrzNG58ORIe5fMVD+CPPmqY6d2N5NkoYdw/cDg6o9BE4VDOHBJTMpxkD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+z48dWbycs0BNNDAkFPWR1Rw68om3IyDtTYrD6xLdPjr8Q+To
	IKY+dvWGXQm35uwmPb52syBPnaVi696SNzc3HUPq9nTccHfbC0GK2hg5q8ct1dVBbOy5W3gz4Nq
	lnLYS6QLUtA==
X-Received: from dlae14.prod.google.com ([2002:a05:701b:230e:b0:128:d97e:9ee4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2393:b0:11b:2de8:6271
 with SMTP id a92af1059eb24-128f3e350bcmr7954454c88.39.1773716772453; Mon, 16
 Mar 2026 20:06:12 -0700 (PDT)
Date: Mon, 16 Mar 2026 20:05:57 -0700
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
Message-ID: <20260317030601.567422-2-irogers@google.com>
Subject: [PATCH v4 1/5] perf evsel: Improve falling back from cycles
From: Ian Rogers <irogers@google.com>
To: tmricht@linux.ibm.com
Cc: irogers@google.com, acme@kernel.org, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, namhyung@kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Switch to using evsel__match rather than comparing perf_event_attr
values, this is robust on hybrid architectures.
Ensure evsel->pmu matches the evsel->core.attr.
Remove exclude bits that get set in other fallback attempts when
switching the event.
Log the event name with modifiers when switching the event on fallback.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 45 ++++++++++++++++++++++++++++-------------
 tools/perf/util/evsel.h |  2 ++
 2 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f59228c1a39e..bd14d9bbc91f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3785,25 +3785,42 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
 {
 	int paranoid;
 
-	if ((err == ENOENT || err == ENXIO || err == ENODEV) &&
-	    evsel->core.attr.type   == PERF_TYPE_HARDWARE &&
-	    evsel->core.attr.config == PERF_COUNT_HW_CPU_CYCLES) {
+	if ((err == ENODEV || err == ENOENT || err == ENXIO) &&
+	    evsel__match(evsel, HARDWARE, HW_CPU_CYCLES)) {
 		/*
-		 * If it's cycles then fall back to hrtimer based cpu-clock sw
-		 * counter, which is always available even if no PMU support.
-		 *
-		 * PPC returns ENXIO until 2.6.37 (behavior changed with commit
-		 * b0a873e).
+		 * If it's the legacy hardware cycles event fails then fall back
+		 * to hrtimer based cpu-clock sw counter, which is always
+		 * available even if no PMU support. PPC returned ENXIO rather
+		 * than ENODEV or ENOENT until 2.6.37.
 		 */
-		evsel->core.attr.type   = PERF_TYPE_SOFTWARE;
+		evsel->pmu = perf_pmus__find_by_type(PERF_TYPE_SOFTWARE);
+		assert(evsel->pmu); /* software is a "well-known" and can't fail PMU type. */
+
+		/* Configure the event. */
+		evsel->core.attr.type = PERF_TYPE_SOFTWARE;
 		evsel->core.attr.config = target__has_cpu(target)
 			? PERF_COUNT_SW_CPU_CLOCK
 			: PERF_COUNT_SW_TASK_CLOCK;
-		scnprintf(msg, msgsize,
-			"The cycles event is not supported, trying to fall back to %s",
-			target__has_cpu(target) ? "cpu-clock" : "task-clock");
+		evsel->core.is_pmu_core = false;
+
+		/* Remove excludes for new event. */
+		if (evsel->fallenback_eacces) {
+			evsel->core.attr.exclude_kernel = 0;
+			evsel->core.attr.exclude_hv     = 0;
+			evsel->fallenback_eacces = false;
+		}
+		if (evsel->fallenback_eopnotsupp) {
+			evsel->core.attr.exclude_guest = 0;
+			evsel->fallenback_eopnotsupp = false;
+		}
 
+		/* Name is recomputed by evsel__name. */
 		zfree(&evsel->name);
+
+		/* Log message. */
+		scnprintf(msg, msgsize,
+			  "The cycles event is not supported, trying to fall back to %s",
+			  evsel__name(evsel));
 		return true;
 	} else if (err == EACCES && !evsel->core.attr.exclude_kernel &&
 		   (paranoid = perf_event_paranoid()) > 1) {
@@ -3830,7 +3847,7 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
 			  " samples", paranoid);
 		evsel->core.attr.exclude_kernel = 1;
 		evsel->core.attr.exclude_hv     = 1;
-
+		evsel->fallenback_eacces = true;
 		return true;
 	} else if (err == EOPNOTSUPP && !evsel->core.attr.exclude_guest &&
 		   !evsel->exclude_GH) {
@@ -3851,7 +3868,7 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
 		/* Apple M1 requires exclude_guest */
 		scnprintf(msg, msgsize, "Trying to fall back to excluding guest samples");
 		evsel->core.attr.exclude_guest = 1;
-
+		evsel->fallenback_eopnotsupp = true;
 		return true;
 	}
 no_fallback:
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index a3d754c029a0..97f57fab28ce 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -124,6 +124,8 @@ struct evsel {
 	bool			default_metricgroup; /* A member of the Default metricgroup */
 	bool			default_show_events; /* If a default group member, show the event */
 	bool			needs_uniquify;
+	bool			fallenback_eacces;
+	bool			fallenback_eopnotsupp;
 	struct hashmap		*per_pkg_mask;
 	int			err;
 	int			script_output_type;
-- 
2.53.0.851.ga537e3e6e9-goog

