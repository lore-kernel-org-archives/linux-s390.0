Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3F73D47CB
	for <linux-s390@vger.kernel.org>; Fri, 13 Mar 2026 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773433701; cv=none; b=ljEHORuzoYPJ4OxWyDPYfHzfkIsMXnRV9rAgqrxN99vGxCQ5afdrTRskrfu24X2cKMrzmxaAirWqbgA7bqlR6PxhzJ41yWseh9mHlvnBlKcEXAzrQ2a+Cjc3K1s6CKFbpaYkKobKckXrjtbZsJxDounkkCGlSzkpo4Ed9vF11jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773433701; c=relaxed/simple;
	bh=wVIk574MaJ1ryn6M1d5QWZAOYLPanqIo/c++6wESi+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iXXaSXtDnE6KgdnKmvEtckZGkPZxDtS/zqiMBOT3uF9pdfkCacjFIAMifOfrQoDc0VDpAGebEkwl4xUmHiEAMDlo+l+9hY3nSGeoozC2B7pE++XhLgSKBaGc0hYR13HRwfOoAl3wphimZNpIE0An1sw9aN+RJribVIKyf2ZHy1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XbOKCQ9C; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XbOKCQ9C"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso3073620eec.0
        for <linux-s390@vger.kernel.org>; Fri, 13 Mar 2026 13:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773433699; x=1774038499; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BC7DFlkd9xaG2royXDyXDCwOCftcIJRM1qoiGuRC8ho=;
        b=XbOKCQ9CQFeJN4mpGB9azXX5o9PdAFhOiRd4cY9lnZmLivKe11MYitmIBUweb4lyZI
         +IMBDN23lqL1ohKG5YtsvjxvkzPzdQMvReFMDP9v1S00slCfAGPaM+Q+Oqgoan7v8LNx
         B49sHSVindCaai43pK+Vm1wPfmoNNHz3N/FaN7tw1qxRpibLuo+tRDsOCD1OhiUoiHSI
         fqXZu4Wpl1pI/g2niQJ5Orxk8MVzfNPYcOLfKtmT+ZtHGiX3b+Cg0idjKvGTeGup423X
         mpt6/udrslj1IbzqzHQYT79Xz6nTn0s8hWszmYs4ack4odk6S+/JALWufcuXSmpSqJ5R
         I70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773433699; x=1774038499;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BC7DFlkd9xaG2royXDyXDCwOCftcIJRM1qoiGuRC8ho=;
        b=gVK3YBs5WCbPzghwpO+gwnE0eNvoFCP2esqiXUoEbQiSMLnbtxDqQ5Q2nxtIPJCuvc
         97JghWxByVTUFq854VQV61WOIE8xomwlyNFHNunOrntg3ou2LdaFg7roMG0C2KAEq0/Y
         fhK62/Cxfhh62hv4dz8hm1QRdybwioFQaJyAi8ytIKRmyqHAeMjgLywRbR2M2I+SB7US
         Hz3Sq53BtOa15TVi2cFCqi7ZFpApezeZ/XrNNVkY6VEq82sw1xbqd8TlUWbE5R0Lzure
         lBWwWijnPCzbXL5wC5Z211Z97u+KqE1PgM2DaXILjIfoEgxwPtGxxSU39yT9mC6OS7nY
         OhnA==
X-Forwarded-Encrypted: i=1; AJvYcCXkME6QvBQKePYrp3KP2yxLXOXrlG58ypAxVyI64DUPH7u2ZhbrSls8s/qWxNnzpSzIpW4il1SvQVUi@vger.kernel.org
X-Gm-Message-State: AOJu0YzLQIWEI/OLWrlj8cA97Fvj1gh4dWZ3QvWJ8uXwzOMgg31sfT+E
	Vz5ZlINKy1H8+J+vTI+16JzmQt4wiLdzEji6I9LQHyBaedgGlPDy+WQj9MBLWLP08BEr3FpEKnR
	zPIqQrgMeNA==
X-Received: from dycaa5.prod.google.com ([2002:a05:7301:5405:b0:2be:54c:35e0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1292:b0:2be:290c:8ad5
 with SMTP id 5a478bee46e88-2bea54de8f7mr2005253eec.23.1773433698697; Fri, 13
 Mar 2026 13:28:18 -0700 (PDT)
Date: Fri, 13 Mar 2026 13:28:09 -0700
In-Reply-To: <20260313202811.2599195-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260312061628.1593105-1-irogers@google.com> <20260313202811.2599195-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260313202811.2599195-2-irogers@google.com>
Subject: [PATCH v3 1/3] perf evsel: Improve falling back from cycles
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

