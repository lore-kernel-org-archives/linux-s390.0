Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A78837F74E
	for <linux-s390@vger.kernel.org>; Tue, 17 Mar 2026 05:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773726829; cv=none; b=AUuVS4ZA1+EdyHJimmCiJubwlDgP2l3HRcGgLId7rOnYhr2bVvV+0Cr1mqaTklDTbYxsHZqWhtOM56Jr1Df7c39NV+WYK6JkeKjABkFYYPmMw9v7DJ+BGbo5bV8FL0G1SRXXRjuqx02EGVKPfeALxH8IsCLw6lUfhhUcrDJyos4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773726829; c=relaxed/simple;
	bh=YnHls8NIVjy5Ei7a4hKc1qV28zK+UaZo7VK2CAN8c3w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sEa+wbkA5gMfrSmeaot70ErRufRiDzcr6U820ls4KQwBW6Js/Il3nojxH62XXWrT9sKdrXmr0ltXCFB6TO/GuSvTk3f07VPq021/cd5nk1ISao0EGCPlZ/9EyrhLPd/wbAujKDgZsgFDB8IS84gJYSoSI4tgW/ubO6qpttzR2e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CZaH7B0f; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CZaH7B0f"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdc1b30ac8so81194590eec.1
        for <linux-s390@vger.kernel.org>; Mon, 16 Mar 2026 22:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773726826; x=1774331626; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4sR/GkKKCK4vlTKAx1HdQnSDfMDIglmN+8LdctHHquI=;
        b=CZaH7B0f+C3xa/FsGjzd/HvczyHWkhOwyx965AwK3zmQoiBc/JrHWYAd3CCIUY559M
         3vlDLuP0SLRA9sLA67mNoOndErkPDHBQCcvHcBuIQsapKb+yudMkJscfxgNsEu/W4rCZ
         pJ8QYrTeQTgEdXv6aWgP/aI1euy+TwESvLxg9Y68sfg/qXzz/YBiw5xfU/rTpH/gPQUy
         iPs+4WxLbpOlG+R9H6PgjYDbcONPmTfZBkCbPgE4i3CKM+kX/0cr9sBduLVV9fvKfANC
         K70a1U/WMO80EylvO10jHUgoaFF4nAxHuG5Iog46I0xTe5hn/2Iy1eMh9C2DBaSGxXjM
         9hIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773726826; x=1774331626;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4sR/GkKKCK4vlTKAx1HdQnSDfMDIglmN+8LdctHHquI=;
        b=l5mIAdX+2dxwr/6jX1qv6z7KBh/nJccSSeLnaPMDtYPiMamYgO3+MjPKzlw2QnS0Fu
         EBI0ArP1SF76i2QQpsvynkiq7n6QWZLULIxVG60y16ITqRNAV3jdtlgv5hDEctaBW4L8
         fSavZw8lj+K/cilOyz3cou3hsw45ZwF4hh6zDswzBxo9AdqF/HJLm1rg4YIU5QHceL2l
         u40NnkXebIlowURzJ8Y9RiBNeVf7W1AUNW0OdSRUoVqs3nIZJZjjwp6xrlrwLvWAg6/n
         +bJ7mChF4gZkwrBWkwCt8AfrCxLE/r9QkNNMJwBzYS3cyWykpJA3cNFVKO/oZtEaGdqB
         Rhgw==
X-Forwarded-Encrypted: i=1; AJvYcCXKpgs+TVhlCTZ1kcbCPaU7W//8EcXD6XArnFR5bbCrpjDkm6fONq1LNlPd19VNPdUOP/owu+7VIFBD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/DSN36zx/kKPHO1a7IGr3nAqUKcnEGUsoTxIk1ado443ZXFVM
	7pxyjwb7nMfsEQQTsWoAoGJLiGz7FjS6ZUKIFw53ztaNH05rNJTuaizLNp1j8l/poNYJqqrmfXs
	3/PPesitH5w==
X-Received: from dybvz8.prod.google.com ([2002:a05:7301:7a08:b0:2be:2465:40e5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:4308:b0:2c0:d690:7b8
 with SMTP id 5a478bee46e88-2c0d6901e3cmr1075723eec.23.1773726825768; Mon, 16
 Mar 2026 22:53:45 -0700 (PDT)
Date: Mon, 16 Mar 2026 22:53:32 -0700
In-Reply-To: <20260317055334.760347-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260317030601.567422-1-irogers@google.com> <20260317055334.760347-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260317055334.760347-4-irogers@google.com>
Subject: [PATCH v5 3/5] perf evsel: Constify option arguments to config functions
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

