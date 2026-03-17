Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B69D3803C4
	for <linux-s390@vger.kernel.org>; Tue, 17 Mar 2026 05:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773726822; cv=none; b=Gnl48tCyCgGGuWxKCBaszhY5dmUb+Sxn4ckfb5+g+1eW2DbPrevCd+1IxeuiG7yRjdyeT9V9twUdcv8rejkAh+98XamDNAUetQgQNSuhJ4FSEtjCdcWT2dtJb3fZj3kLXf/ni1m9j8YS65DP/UEU4siG8L6FW8jzxUK0xp7dhy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773726822; c=relaxed/simple;
	bh=wVIk574MaJ1ryn6M1d5QWZAOYLPanqIo/c++6wESi+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sln4gZhVg+RReIZK8DZmrHeCKIXWSdaRRb5aYR1snATvDnfoonfMkuxhVVHWJpv4UfWmWmDf3IL+0ta7zNcQijUoG9DkPOUB8Y8eTTudywcs00F2KdLcQICfxvzfRvacjXIRHXkawSE50HlbVI11EVx2hUvS4/i+a2efBj0q3w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MRqxRyLa; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MRqxRyLa"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b05d170cadso17462785ad.0
        for <linux-s390@vger.kernel.org>; Mon, 16 Mar 2026 22:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773726820; x=1774331620; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BC7DFlkd9xaG2royXDyXDCwOCftcIJRM1qoiGuRC8ho=;
        b=MRqxRyLaIvo3tpzZaKLBDWkql2Zxe/wwtzOBVu1szYKPELi6FbdARCqKTQ0iFNDTHO
         RW4BxWUws7HUEcrA7b4cE9dPGys0hf2d/hkkVRN6akt+MzaVCIHElo5fc4zv10Myn0WQ
         o4WsPbTvqXxifeSJ0yMXaHZMxW+jIH30m6pThwsYCkP5Y2g16P0pp2V891BMKZpU6wLQ
         tuAaozUA/geN1olQld/6GlDKD/GzEF21zu/Mbf4s8N0lOuxA8TV210degSYIhURQZBSw
         0pt4oeUhDVNa8HNqtjrmdJ6LyIokiU+biTTFTrMwgKQYQ7+PpvNR1JPRg86YsE4qWolb
         LPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773726820; x=1774331620;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BC7DFlkd9xaG2royXDyXDCwOCftcIJRM1qoiGuRC8ho=;
        b=D7fy51RXLIjrlElUlCga+BB9bX29qf7bkN8N7DafnkLy79Pv5ACWwpZ/UYgnJ5EeFg
         ahYDjoClfU7/wDVTejdT5a/Hyj43x7Z/vudQ137/R/6RLkRDx1rGt5UbTTqoPtvAlmhO
         RjNfUr+tG5hgFOzKONYiKVwouE2gvGYFNqhmto4uC8NTArGgLZoNwVrkJwfNWIlikH+M
         afUwkgwMPxIt0eXOjvXvTUD7muv5IAQr0JqS11NZAEl4yIGWPw4cRafsPetAMSAamUo6
         I1qzHKY3XgMgkQH9Q3oMgCJM4b0qif/kO6aRCxM4Ns6eZWf0Ktv404ju2qsET7/vRvk6
         xeLg==
X-Forwarded-Encrypted: i=1; AJvYcCXFpuLTNGI/Dp0R+3VT2WUerTpefLwDgG2Hbi+rebTVxYS1hs18LfWJyIu4TPeaXd3Jxvu9Ziv6Z/9P@vger.kernel.org
X-Gm-Message-State: AOJu0YxbNdwlmUYnwsXVF89N/wcGtoPmQ+Dvx+zqDDu9ixleWsaMu7eb
	xUHTuvhCxtY21Oeh2GWSZOfnUOsOCxY7eWnGygmDOCTR3yQG43JCF+CQqVrxvtUsMZFpLzIMaIh
	+I9bYAc895Q==
X-Received: from plan1.prod.google.com ([2002:a17:903:4041:b0:2b0:5ba8:77e7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c4:b0:2b0:5cb4:d89d
 with SMTP id d9443c01a7336-2b05cb4d98dmr50571635ad.29.1773726820372; Mon, 16
 Mar 2026 22:53:40 -0700 (PDT)
Date: Mon, 16 Mar 2026 22:53:30 -0700
In-Reply-To: <20260317055334.760347-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260317030601.567422-1-irogers@google.com> <20260317055334.760347-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260317055334.760347-2-irogers@google.com>
Subject: [PATCH v5 1/5] perf evsel: Improve falling back from cycles
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

