Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E15280324
	for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2026 23:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773877567; cv=none; b=HXyg3R0MnFy8u3dqGP5EI9mWNdg7R4+v1LrgUEgUuFl0y7fZU2ZqZYMS/a9PzOCd9Xu4kxgQ7veJI24hsZ1SQNQ8yBPvslus31MSJ+JTT4R0XWi5j0saNrcMalCohQRja6Qzv9eLB1lGcrseeRa7SR2+i4aa8C1LuOtHF/CUDiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773877567; c=relaxed/simple;
	bh=U8LqxsgGl8pPzMoHQSm3GXUaosjRDy/a3rvRqghM3i4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JcI/12Y75DEJYmFaKCGs+0f8fhD4XefKyGbUiWbjgAA/hZ9VsE6kb0IccXk501VF6fNgH6EKXeWmY3HG2nL4RjmMa3rvbDMixkivIr5aPOlF91hcU0cSOkQVRPDLhYyVAilEoKF8T64fk0Sd1vii/pnsFcS6hrwqjG3+yGiL/+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YJJpnqBk; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YJJpnqBk"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-128d285d6c3so410704c88.1
        for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2026 16:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773877565; x=1774482365; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FHgnOqAqVJ/nZ21E+abJVIPEw9OV5mDZ+DHTpPzA2N8=;
        b=YJJpnqBkiT68ho/nAKjUhO1hO5eOO8U6zswV3CoyDTPuxhLx+HivLXX/LajsfnAsxy
         9do3LJPLgQqmEpdLeqAcl8bORSDkbNTyYpmJSdRIUPVImQTAFo/CYdvWPmQoi2vsJcjw
         NqIvapejS5CLO/ByLAf227R/xLhjnEHLa3LDCTYqh9J9wKB9OCL9ogSkwIfYC1RfPWJK
         7lZNt9vg7ltxNpEywW3fyC4KFIjfF6595g6YycP8IxZn91JqyEitJSvGmJY+SF0BT8fU
         mV+/hlW0ks3ySin7OZZ0Ewni9fu91kvBNP7L/vy3QILF6IPccn0valXkFhc3Bp1toUms
         Mydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773877565; x=1774482365;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FHgnOqAqVJ/nZ21E+abJVIPEw9OV5mDZ+DHTpPzA2N8=;
        b=pr/NJ+gMM7Gj4F6qBT8BcQhDXtqTbreVYLWVzNwpgpv6EgBMjijWKrbWx2dGP1pGFZ
         LaQmYtGxNjxe7de3nE1IU+vAZuL4i1eZkVy3O18MKRKO4obbyzE8LXjJz9ZWE6C31192
         aJ+tVxopNjnTJ3n1z5mqgIHdgsLa4ADtC0PBwmD+zHX4j0DKs62Uda+h5x9My5LjzSrY
         qe1gazQxe68OIxW5BlnYXLQCAHdQsRQqZFc2Tr7P4VKZeW7yM3FUTp4Tq8Z5wPSMQLuu
         fiVysexgFI7TkHJ6sr7uCoHqKHCltNXLCRx1hXSu3Cstjb2nmqJ7s0Nt8av6Xf72dccZ
         c05w==
X-Forwarded-Encrypted: i=1; AJvYcCWW32xwxYmghN7jl0CDsQIwb9LK2l7PLh3JiTQ3rk2WeSPbPbM0OvBF9fmUhurTvinVtio6Tl4N8a1F@vger.kernel.org
X-Gm-Message-State: AOJu0YybXgXCMgU0qZtsj7sVLZnMXvlOoughmFfTT6LRNTfNvie7b8ij
	22UZ9ABqlBwbv1Vg7AGFLMRBQ4vwnqhoKhKvj1/j+9qPUq6jYAfzhCl6WDaSAn+seiOElHme3/Y
	GmxRdqlYp/g==
X-Received: from dlbvs5.prod.google.com ([2002:a05:7022:3f05:b0:128:cff2:6560])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:250f:b0:128:ea68:27f4
 with SMTP id a92af1059eb24-1299baa0042mr2372545c88.4.1773877564922; Wed, 18
 Mar 2026 16:46:04 -0700 (PDT)
Date: Wed, 18 Mar 2026 16:45:56 -0700
In-Reply-To: <20260318234600.730340-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260318175808.582009-1-irogers@google.com> <20260318234600.730340-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260318234600.730340-2-irogers@google.com>
Subject: [PATCH v8 1/5] perf evsel: Improve falling back from cycles
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: irogers@google.com, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Switch to using evsel__match rather than comparing perf_event_attr
values, this is robust on hybrid architectures.
Ensure evsel->pmu matches the evsel->core.attr.
Remove exclude bits that get set in other fallback attempts when
switching the event.
Log the event name with modifiers when switching the event on fallback.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
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

