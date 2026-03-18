Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737113A7838
	for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2026 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773856708; cv=none; b=qXxNWD5RhmioWo/s7TxXTuiIAeyX5VyueoDbkMXVqBF9boiA1ClD7n5NkT2Gwg8X1F+8M706Si/aa61ZrgBdPAclO2n09nuc+ZspQFLd0o8Ax6DC5s3SFQffvgIJxFEVc72KQ1n9C4Ro7NAVMKI+VA0zm0qOi5IfbPPRX8lgN6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773856708; c=relaxed/simple;
	bh=A0GmPbCjJnn1aBXkaKYVs2MSN28WJDd3xDZa3Kc40Go=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ptkzymvGdlUY+Gb0DI5theQCuhztx011g59WPCft/ybzMHZQBKkqK4BX65iY78p49oB8AAIxDHBQArDJbcRf1W++u341B0sQGGRM+d7Q//D5f/Kes1IhHGH3YPFQkWU2XryWR9tBFYvhaVaaPZ2f8uPiWWYDSH18IjJ0bkS+BFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i0j9hNqe; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i0j9hNqe"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-128d0a51897so4089730c88.0
        for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2026 10:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773856707; x=1774461507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nSZEuWL4PES8N47OQb2rrJbHDGRdHRzrhZzS2INVBJI=;
        b=i0j9hNqeYP8EiPRrn6b0Px8nZPj+jsInVA86ZFghwybxGjAt1WxDOGKoKtdTjtNE7i
         C46S93OzD0dDrsz5BNNgyJGZbpf9fj4GS63klkPkVqHNZyJkufFZJAWepRABCwO7p2I4
         XzbkrPvEvoNgGAeFcUCzwA3gjvtrkvlN5G71iTUELKSsPhMnGmpTUnW6ezAHBDSPwLM2
         cm0aR7zIeoEcR0pSYiqmOXYOP4eB4APssi1gP/5CC3uJSBJIIlZ3Mw+laZe4rU7BPpBK
         FfUdULBeW7wEvza6FFpbZ20gSgggRLaQbFWdVYabUtrm9cOrK1QYzM9zLKMSuw2Et6Xt
         KUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773856707; x=1774461507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nSZEuWL4PES8N47OQb2rrJbHDGRdHRzrhZzS2INVBJI=;
        b=CqKpdFzEe9q/eioY9r9TsVlBg3q66/zBLvfC14LyC9bPnrcnlOqqlAooAIZ2wQ1+mD
         GJ6nDCqK7YRia94HjssG2sDlYr0JS4EAbh2atJDUt8Lsz3F4GtZ9p+9sDWN+7Y3cqZdr
         a5oZxijMQR7jJJodbaSDyvuGoTssqRX75uVHUx5E3hyv1N1zRX9o8YNnFcdnV+EWO+UK
         W1C1QxI00M+s3yd8prdOiZHkO0KqpBTgpRu+wR7q6f/JRbhOgXoI7PPiDAXh4pumaK3C
         yxo/FSAyyc7eWWoW1GI3FDJkIFQCPlTPehi2yrMD8Q1hXjK+Apqz6gXKIoD1e2QRnscC
         5lfg==
X-Forwarded-Encrypted: i=1; AJvYcCWECSKUMfGLKDjb4do6UiHT7LiPeVDmGR7SvM+tDmuN1lzvDk9oUfNLRCYBJKKXhGDZq7gJkfkaLIs+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2csH5QCNtEKBom5AM+SA82XLYaiSl1jnxkqtsC2hJjcDNCfMp
	Cqsz1vPmmoAY82j9cttgM8WTjxrPGTVOeCj31C4Of9dvq+rLZTapgSf6fuRroFDTeb0l8ilf+9+
	WpIYtMqK9eA==
X-Received: from dldz19-n1.prod.google.com ([2002:a05:701b:4193:10b0:127:8aee:c50c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:125:b0:11b:9b9f:426b
 with SMTP id a92af1059eb24-129a715f0f3mr2275763c88.20.1773856706446; Wed, 18
 Mar 2026 10:58:26 -0700 (PDT)
Date: Wed, 18 Mar 2026 10:58:06 -0700
In-Reply-To: <20260318175808.582009-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fWCf1TFMW8epW8moOcUbMuzRjrG1r38SWFevH35mqR0+w@mail.gmail.com>
 <20260318175808.582009-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260318175808.582009-4-irogers@google.com>
Subject: [PATCH v7 3/5] perf evsel: Constify option arguments to config functions
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
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
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

