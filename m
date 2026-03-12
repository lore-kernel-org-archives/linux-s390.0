Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA1B1C3BFC
	for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2026 06:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773296195; cv=none; b=Rgk/XiGMZIEik6CzKFUkkfMa8taYlLlzBnLrXlc6F66MOcMxqI/ikCVza4CwtX15yZQ/dRR+nEKvxWvgthTCnlmuKAOx1aJZamwowGxNopy/CR8vJhZE7Kq1U3ufvsKx1bF8lHwMkfKmsG90BLqerNsOPG4GL9heTQFk+d0Wo6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773296195; c=relaxed/simple;
	bh=Z5QaxiCHj5K0GmoIJrY5Xe88uPpAGGMKJgSWdAQAxy0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jL3VRCikVKdHsrID9WGCF7zVmWvdhV6MNXdQvwDSISk65DGGWTM5YJ9CuZaZLX3BgZ/iWzKDOZz003oRdD1twHRrKdaQcKQC9wBnr8FCQu42x19tQ6kOf/aPClBqXDIx4/60RK2LZbVygIv2mCz8ZPdqsRUcm2jzfzptR7DaPyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IuDg33Or; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IuDg33Or"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-829b8bb5173so425133b3a.3
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2026 23:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773296193; x=1773900993; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wbBdPFRzOAuAtLIlVyUjb3PSrQgEZIOE4FDHqZdQ/kI=;
        b=IuDg33OrkDkYRekw7MOYMKco/wcKahVc2WNKK27YN4c2OLNF6QfKtxRiHtp+GfgHX9
         OOoqGNPrVs4uOAGBB7eCbDz4T1D8qV95CzUG4QHVuZfemtIQoArqAmm5sSOBzkc6Z0tN
         /aYmYZAlYIJNKbbJ0rraXDoMixNufVe6C62mj+92qSCarY/3cCMGvTBeUPIol2ZMZqcx
         JLwSU27cCU7Xon/CAWis5yofCkYfeg2aJtgfeAoktkFajt3G9Fha7C6lG3OHK5GbJbfi
         5ru5v0pWjKnl2s0X/m34LBn9/Rm1azm4YOJ9v83HjVwi1hxrKSJ9sxl20s8GxEWTCMTE
         rOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773296193; x=1773900993;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wbBdPFRzOAuAtLIlVyUjb3PSrQgEZIOE4FDHqZdQ/kI=;
        b=aiz9xq3wZlEHHu77IopqLSkzGpRCDax9dQfXoQVsfHycW7CkVMa8KWb9sMIkt9gy1e
         Xq1/H9YZhly29CWS8lZYf87s7F8oYuiUwxK4McM4cZySOllPyorAxPuYVxLSb4fhu3EZ
         Kj6JaO9jMmb+R0fDO7GKAPGMHKuOZXYBmUEEzYtSRTLFCnB6VGDcctHe6ePM27KH4CFy
         d4lrInPNGd2KF0WctigyXmF5kcWN5+ZyQ8OAccMMco1Bw9ERwDXD5e39BsjsPobKG71E
         /6S7UP1NE1PtqIgk/EJtE7DggbrGBb+BLjxPTzce2d2TnAUUgJv2FHrkEWoJhYHDCJP4
         oIMA==
X-Forwarded-Encrypted: i=1; AJvYcCWYFLAI7EHmm8+gh4eEUTubYui20/ucj5qU9TirvXkKscprK8ZrqXLDorVzsnLJkDpw+ndpwh5Cy+24@vger.kernel.org
X-Gm-Message-State: AOJu0YxQvm+10zERTDFUryHwVFyYzxLwzDHeYtR3WzdYshks2fry+Y6D
	ekfB0XdVdKoqLO9awDZ9lccZVacg9rCZAmhheq0X6sUHPE1fxVPAiNYN2Hflgxk0b7Nffhxcwj4
	K+tAtzo/3GA==
X-Received: from pfiu15.prod.google.com ([2002:a05:6a00:124f:b0:829:813e:c970])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:88c3:0:b0:81e:8e66:38e0
 with SMTP id d2e1a72fcca58-829f70d1156mr4528769b3a.20.1773296193179; Wed, 11
 Mar 2026 23:16:33 -0700 (PDT)
Date: Wed, 11 Mar 2026 23:16:27 -0700
In-Reply-To: <20260312061628.1593105-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260312031928.1494864-1-irogers@google.com> <20260312061628.1593105-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260312061628.1593105-2-irogers@google.com>
Subject: [PATCH v2 1/2] perf evsel: Improve falling back from cycles
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
v2: Also update evsel->core.is_pmu_core when switchingto a software event.
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

