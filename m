Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E994D38655C
	for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2026 03:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773285576; cv=none; b=JsNlcrz9yUQacqukxP4GPLfE2uoJf9keXBlejBYgnmFea4liTviu4t/I6oNFXBrJlUPI++697yOFJygbtLsqko1TB+jgjvJcBAEZ1wQLsTtaligURum9XUEM6NpbOUkOl9a2M/R56A1rpFcAQHIGPRMKj7YuYVCxL8r/y5mtIck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773285576; c=relaxed/simple;
	bh=Jws1ULU2tjc/wo+Js7DYjzsloDswQGRFRzhDMFIBMgY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aG+4CiRwhi0+R4Jk1iCR9nq9ZMEuvwMMo2clHm6FTmXeQXBuL4uo1ak7Korp1F4zA4SNH9b2qilZz2foh0fPz95INeCjUProMCR2Ppli8nxk5zr+Gzry6g1dRHUrrMDIdB25UyLORP1ZaRlAo5AWgZg2ITVKuohdcuJL2JXIQVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N7Yd/ieA; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N7Yd/ieA"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b81ff82e3cso1158553eec.0
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2026 20:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773285574; x=1773890374; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PitVx6RkTUsKJIaqadpXzmjVlSndqDRkARSHs6rZsEo=;
        b=N7Yd/ieAFO83L0vcoya9WmOdmoPnXW92KSWlZU3Jqcj7FmrZnPspM+bX4SZwBUyyHS
         AFFAUF0guvDqRu/voX6xA/GCrtNRFT4OXbYXRWTNk3U4bArFUd4xM0ljbv1Q/xf2roBz
         WZeWCWYH+paZQYZuI4WYvQvFwre8H/GLTSSBSdA4OeRrXjhy+lGdDQkO/39W6OgJSv0P
         RaK1o+XBTisxxABDbGOpkRTyXwEgiyRnIBIeg4ahBQbrN9SmAvHG/0Gl+Tw026F/GtHp
         EtZpr1k9J3CBCOnQNgenGTmDbtiUsGp5Os056JHP1SoBhIebgMMkMqT5n+Akli7ADLWw
         MXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773285574; x=1773890374;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PitVx6RkTUsKJIaqadpXzmjVlSndqDRkARSHs6rZsEo=;
        b=hgf5LNLWPohbKGdwj1g1C1rroOlwgxyXYbyYD0wmzTltoA7reJpSn5DD1BfBnXlRcb
         R/Q9+vhO+7FLJNeKUE2HLnba8rBfC8rP+AkUCtWTRa/AhPHU6SCPeJwIT7arXS26gEps
         irmVfgWR3BI1z7RtgahWfINHZzRDYIIY/OCGcuN4y8Ma13/Q5OpfQw6Lr3uSBCGn5q/y
         hLkp6EBbPA0kcTaIQnIqKzqW3lbr97sGiWZyoxdjn/Gy0Frrj1VRyKZZbT2BxkiFROot
         bEkmuwA3E5J9sTwSfNXNLQeOuHKFSF482V/ULy1oV+sIysnfnNk+fBl7dQ6MXTiCuwq+
         G+aw==
X-Forwarded-Encrypted: i=1; AJvYcCVXzIusrjQMciU3zzDHRc0uXjta/zuKZIqy1rbLag8fipbCLoY/C4o0cNVB9DooxGio5rePhuPOSuUH@vger.kernel.org
X-Gm-Message-State: AOJu0YzedsdC3vjQ3JaMH8ZjZU2QNta1OHzZPRcvvQdBEqT9zSmS7NsA
	5vr06ZGtT2QL2N6neo18YgJiW0l+I9CB4DKZjK7lpk2yXF+AgGiEkrUSzYJ2DeTnwdHHkIsqBFK
	spAKdz5fD8g==
X-Received: from dlbrx1.prod.google.com ([2002:a05:7022:1701:b0:128:d2ba:d39a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:62a4:b0:128:cf85:a852
 with SMTP id a92af1059eb24-128ecc35b2emr844876c88.22.1773285573893; Wed, 11
 Mar 2026 20:19:33 -0700 (PDT)
Date: Wed, 11 Mar 2026 20:19:27 -0700
In-Reply-To: <20260312031928.1494864-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <131d7e1e-701e-4f5b-961f-c85af74f1d96@linux.ibm.com> <20260312031928.1494864-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260312031928.1494864-2-irogers@google.com>
Subject: [PATCH v1 1/2] perf evsel: Improve falling back from cycles
From: Ian Rogers <irogers@google.com>
To: tmricht@linux.ibm.com
Cc: acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, irogers@google.com, japo@linux.ibm.com, 
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
 tools/perf/util/evsel.c | 44 ++++++++++++++++++++++++++++-------------
 tools/perf/util/evsel.h |  2 ++
 2 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f59228c1a39e..2258fea2ef5b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3785,25 +3785,41 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
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
+
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
@@ -3830,7 +3846,7 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
 			  " samples", paranoid);
 		evsel->core.attr.exclude_kernel = 1;
 		evsel->core.attr.exclude_hv     = 1;
-
+		evsel->fallenback_eacces = true;
 		return true;
 	} else if (err == EOPNOTSUPP && !evsel->core.attr.exclude_guest &&
 		   !evsel->exclude_GH) {
@@ -3851,7 +3867,7 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
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

