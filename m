Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B8537EFEE
	for <linux-s390@vger.kernel.org>; Tue, 17 Mar 2026 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770215; cv=none; b=Skr7RmOCDdWsVGBKmEUYIkAZH8eboYb8ccNa7IV+GsVCOhdERhZHpL54muTsLLdMMqvRiXEQwQRHXvgO9TQh9eFOgtqznII8uJuMH+E2XbF2g2CqLEeMMaW3RaszwkHsOYz09TZTGWSGRpKnrJKl1fOZO/8MQjTC/PjxI+mFE4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770215; c=relaxed/simple;
	bh=YnHls8NIVjy5Ei7a4hKc1qV28zK+UaZo7VK2CAN8c3w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LuFxnzjv0uRd4yRExxsHl4bTVzeInFwYcvv/xsE+Sa9OenIyQYXfL3smcYIj/OfJbznFTUF1AaHQfE8CPoW+2OT8NbXpbsmKJKTIXbwB2u4TKjaGZ6s5HffFI3qKnZZF6RpMB/PEku0HZ+8Lvr1jpQFUUbJ7k4+AqYisKwHfwWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ougIvL7E; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ougIvL7E"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bead0a9123so2072863eec.1
        for <linux-s390@vger.kernel.org>; Tue, 17 Mar 2026 10:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773770213; x=1774375013; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4sR/GkKKCK4vlTKAx1HdQnSDfMDIglmN+8LdctHHquI=;
        b=ougIvL7E76jUUfEYd6e7fJILp0+C/OSnnajGRqFkDULtrsMdv9Ye9fa+d3tFzPax6k
         rDSSFnkeL3ENi42CMnc63O/unAJkXTl7yOODBg32tgWWqDmYxm/RUt2GCVR52NPFEs6E
         7BDRCoku1sj+PS2QzqWHRl+IGOR8/gQebwRrRDHyPkPnllfPGwZVio9D/MWCVXsVqSSa
         w00Bo/2fdBiVx+7qJrAxL9+Wo1n5Vd/zWN83fZzig5mtMHPqTeJK4T+fU4RVFFSV7crQ
         yObJg3n/HIPZFUaVnBNQAJoW6xIGaMxasU/L8Ib70KlVI3W9y7ulo5QsHHC5whqF0AbA
         OswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773770213; x=1774375013;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4sR/GkKKCK4vlTKAx1HdQnSDfMDIglmN+8LdctHHquI=;
        b=DjzjGzSATnUCjsgDPONn5B+LAS4jc4GntUFEVmlEsU/i2Lo2WYrYukpPez9R63hHfA
         tQQ1+pai8O0zewJ1DO1Mcv0iOqYrQqRfEDrKoG7IrYZ8JBuNxVbHzk97YgntFE3UUvkY
         UboqpX02nz/0Hw1UyEI+FL4H1kDiinCLIMyf3wZZpuIdcAPsftkOkMY7WUQIqfKlxZ4n
         so0CrDcyEvBReUQhMSm7ot56ARKG7EcR+YTdamMA6YaaoMdKX/10qcBO9lbvvpizLrrC
         Ea8SlfR3mO8F3EoGgrrHNplzOfLlnu/YLigUJmV680ix5RrPts069XHgQ8Uf8uaqP3Af
         ilGA==
X-Forwarded-Encrypted: i=1; AJvYcCXR2uh0Jknv86IHU9CPL0Z92tlLO0h1/TqoqSWzx8zMj+Fmh+Ka4AXwH3dJAFVLOiMoOh2x4vSJo9Oe@vger.kernel.org
X-Gm-Message-State: AOJu0Yze6dfOBG9R0QucNTWQVBktMC6uePh/q1z1Z+Cdh1hylgryePcC
	s8rZM6Q+lhaZ5xEdJ2mbGOmqQSrdMvZI7LRuQaLzDRCZ4AUaHMH+YcqsVZ2dyql5dILCt32vqVh
	gsBNgbHUaOg==
X-Received: from dycmh3.prod.google.com ([2002:a05:693c:2583:b0:2be:2e48:5d13])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:dc87:b0:2bd:dd33:7996
 with SMTP id 5a478bee46e88-2c0e503eb8amr177097eec.19.1773770213078; Tue, 17
 Mar 2026 10:56:53 -0700 (PDT)
Date: Tue, 17 Mar 2026 10:56:40 -0700
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
Message-ID: <20260317175642.161647-4-irogers@google.com>
Subject: [PATCH v6 3/5] perf evsel: Constify option arguments to config functions
From: Ian Rogers <irogers@google.com>
To: tmricht@linux.ibm.com
Cc: irogers@google.com, acme@kernel.org, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, namhyung@kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The options are used to configure the evsel but are not themselves
configured. Make the arguments const to better capture this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 20 ++++++++++----------
 tools/perf/util/evsel.h |  8 ++++----
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index bd14d9bbc91f..54c8922a8e47 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1015,8 +1015,8 @@ uint16_t evsel__e_machine(struct evsel *evsel, uint32_t *e_flags)
 	return perf_session__e_machine(session, e_flags);
 }
 
-static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *opts,
-				      struct callchain_param *param)
+static void __evsel__config_callchain(struct evsel *evsel, const struct record_opts *opts,
+				      const struct callchain_param *param)
 {
 	bool function = evsel__is_function_event(evsel);
 	struct perf_event_attr *attr = &evsel->core.attr;
@@ -1080,14 +1080,14 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
 		attr->defer_callchain = 1;
 }
 
-void evsel__config_callchain(struct evsel *evsel, struct record_opts *opts,
-			     struct callchain_param *param)
+void evsel__config_callchain(struct evsel *evsel, const struct record_opts *opts,
+			     const struct callchain_param *param)
 {
 	if (param->enabled)
 		return __evsel__config_callchain(evsel, opts, param);
 }
 
-static void evsel__reset_callgraph(struct evsel *evsel, struct callchain_param *param)
+static void evsel__reset_callgraph(struct evsel *evsel, const struct callchain_param *param)
 {
 	struct perf_event_attr *attr = &evsel->core.attr;
 
@@ -1106,7 +1106,7 @@ static void evsel__reset_callgraph(struct evsel *evsel, struct callchain_param *
 
 static void evsel__apply_ratio_to_prev(struct evsel *evsel,
 				       struct perf_event_attr *attr,
-				       struct record_opts *opts,
+				       const struct record_opts *opts,
 				       const char *buf)
 {
 	struct perf_event_attr *prev_attr = NULL;
@@ -1170,7 +1170,7 @@ static void evsel__apply_ratio_to_prev(struct evsel *evsel,
 }
 
 static void evsel__apply_config_terms(struct evsel *evsel,
-				      struct record_opts *opts, bool track)
+				      const struct record_opts *opts, bool track)
 {
 	struct evsel_config_term *term;
 	struct list_head *config_terms = &evsel->config_terms;
@@ -1445,7 +1445,7 @@ void __weak arch_evsel__apply_ratio_to_prev(struct evsel *evsel __maybe_unused,
 {
 }
 
-static void evsel__set_default_freq_period(struct record_opts *opts,
+static void evsel__set_default_freq_period(const struct record_opts *opts,
 					   struct perf_event_attr *attr)
 {
 	if (opts->freq) {
@@ -1490,8 +1490,8 @@ bool evsel__is_offcpu_event(struct evsel *evsel)
  *     enable/disable events specifically, as there's no
  *     initial traced exec call.
  */
-void evsel__config(struct evsel *evsel, struct record_opts *opts,
-		   struct callchain_param *callchain)
+void evsel__config(struct evsel *evsel, const struct record_opts *opts,
+		   const struct callchain_param *callchain)
 {
 	struct evsel *leader = evsel__leader(evsel);
 	struct perf_event_attr *attr = &evsel->core.attr;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 97f57fab28ce..339b5c08a33d 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -287,10 +287,10 @@ void evsel__set_priv_destructor(void (*destructor)(void *priv));
 
 struct callchain_param;
 
-void evsel__config(struct evsel *evsel, struct record_opts *opts,
-		   struct callchain_param *callchain);
-void evsel__config_callchain(struct evsel *evsel, struct record_opts *opts,
-			     struct callchain_param *callchain);
+void evsel__config(struct evsel *evsel, const struct record_opts *opts,
+		   const struct callchain_param *callchain);
+void evsel__config_callchain(struct evsel *evsel, const struct record_opts *opts,
+			     const  struct callchain_param *callchain);
 
 int __evsel__sample_size(u64 sample_type);
 void evsel__calc_id_pos(struct evsel *evsel);
-- 
2.53.0.851.ga537e3e6e9-goog

