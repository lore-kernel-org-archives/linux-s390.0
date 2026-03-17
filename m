Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6393137BE96
	for <linux-s390@vger.kernel.org>; Tue, 17 Mar 2026 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770210; cv=none; b=Cww+FY2dGNVRvjKCEvnKRdsh0ISSRny9ExV+S9IT/2ny8PG4s0YUOumdT2b5XIIKgVky+5FkJzLVLhKDeYm25QIGkUoUBxd+Cx/g6gKpJfBBfXiuw6pQZ24dBeZX48pJRGOHj3YKXSAZuSjoHty6yZv4xBaJ+YpRW+2khvIP45I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770210; c=relaxed/simple;
	bh=wVIk574MaJ1ryn6M1d5QWZAOYLPanqIo/c++6wESi+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E9wMkwLU5YJfaJi5g2nbZr65pw8IVCEBsfuup5yhDq8omyCBCs64EbeQwIw3wrHmP+eSyUP04EXpHu+aDOFaYXuiZNELJ8Qxj1G7kxrjHoBQ88I02i3IebmfaLCeJ/nXiFGvETxeMndlC4oDPV7TqFQsPs27YeOvNtzLfHcEkQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cphu19cC; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cphu19cC"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bea61591fdso104912542eec.0
        for <linux-s390@vger.kernel.org>; Tue, 17 Mar 2026 10:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773770209; x=1774375009; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BC7DFlkd9xaG2royXDyXDCwOCftcIJRM1qoiGuRC8ho=;
        b=Cphu19cCRMHzHSBEJMnmYw/pT3cZXgHiJFL+jIOalZiimrS+0aD6arzArc3IGmyWgE
         kFufh7F2AL6X0Qc/QwuWxrapRj2kjN88feeTqK2YXkqA+yZclVbpz8p6kq3iIiZyAuW+
         NOugaJXH/599aiJjVn/z6ri1Iwa1E91/46VsffK3ds2W6ruEuI+TGW17rWi0Yq55RAjV
         LTIco/RmfSO07y2c5W+d81GysnRfAtwrwQane3dfXNokwy9aBh9qrTTRFrZk9WFeYYW2
         Ry0JlC/4SqY5hIIydTmYqpV/W37tLe5Yic/dBvg9qVjpWCWqGFUkbTuIZM9+qjrO+aRS
         +g/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773770209; x=1774375009;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BC7DFlkd9xaG2royXDyXDCwOCftcIJRM1qoiGuRC8ho=;
        b=dQB0GPnmSHvWyTZIOw7k2tk6I1ohcujyXDmAOrG4iOJCu7UT6kzQIBy9N8qkYcPa5B
         wHqZYMXy4gyfWazcEMzf0PmWfXgdFRtvMDR7/se5K9/55HCENMQNoCFbnd4vZyuUCpNs
         73VH1ng5WUgMyP6bJ3vU8YGvh/NQH2sJ3Uj0j8VaoeepxfbfS4IHmNCSe0d7SGag4z55
         vcqQ14lPob5oVVTyPhL67Q/OaST8elyHSuVMvyFCJuNydk4hXidn/IsQECoq5vfMUhPX
         e1PMuCFme017mIHyW6GtIaoBslLeX4L/wPL1o7Pc8O4jZChOhSy87hmjRC5DEU41Aya9
         oGJg==
X-Forwarded-Encrypted: i=1; AJvYcCW0xA8UyMbxxYlkaHlC7oxSEucbFew0w3tvm7pFQovsKhH4tTXEodrD4tUbYYvlKy+lwT+VX6zOw2Ae@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzgg6cKzG476O33sq6+HblYnw5Rr8koZjpnC4xhcFXUNAcpsCA
	iP69M88FFsCtc9Mi2qS655j08W4SmoNbBWB23MhFYTivAhFseBLU76ziM0yc75g9DggdNggqV0+
	NYeOS8dbVDQ==
X-Received: from dycmh3.prod.google.com ([2002:a05:693c:2583:b0:2be:2e48:5d13])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6790:b0:2c0:ad52:e657
 with SMTP id 5a478bee46e88-2c0e50cb1bcmr159118eec.21.1773770208351; Tue, 17
 Mar 2026 10:56:48 -0700 (PDT)
Date: Tue, 17 Mar 2026 10:56:38 -0700
In-Reply-To: <20260317175642.161647-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fUO8azimnOV2Ogb93nZ3eXnaLdGo6b+3wPVf0tMz29JqQ@mail.gmail.com>
 <20260317175642.161647-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260317175642.161647-2-irogers@google.com>
Subject: [PATCH v6 1/5] perf evsel: Improve falling back from cycles
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

