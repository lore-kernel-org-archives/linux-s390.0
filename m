Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181052C026F
	for <linux-s390@vger.kernel.org>; Tue, 17 Mar 2026 03:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773716779; cv=none; b=Y9GEBf5f1vt82FK9ryfxSNT8FIw4ZQhILHEg3tLAFJJWDiVb2TfOjNpnsoh5JJMJg3RtbnwgBEdseu2/rWxp9S22cOQf6Xrq0/96OnoVrj8i/YarLFkotEVy0z3IKh+HLU+LwQmL0Ex8/rmWgzCHMRaar0FX3dZomooJpF7f8/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773716779; c=relaxed/simple;
	bh=YnHls8NIVjy5Ei7a4hKc1qV28zK+UaZo7VK2CAN8c3w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fcy8ZSv2Avm4UYjmqN9n6IDOSHdkx7D5ZbxnxY25bma51iA03ec0kNrSODlmep5poPVzaShIqZ0qD3a8xZI8HQwSreHtf1GNBcc0ITPP9A1fQqpMdT5YrvU4Ed+wASXlv+kMo867e9yWZ6zpSj/Bf+25Ct2YEWrxizKLxHsIVtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=phgrFpbQ; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="phgrFpbQ"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso5090613eec.0
        for <linux-s390@vger.kernel.org>; Mon, 16 Mar 2026 20:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773716777; x=1774321577; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4sR/GkKKCK4vlTKAx1HdQnSDfMDIglmN+8LdctHHquI=;
        b=phgrFpbQhbW8TOEegw+TiIH53Xfx/T8UxSvC1oxAxR+QrNUdTfAGhzEuzfCPdEPgrY
         vt/Ejcj5Hpycr94HElZ9FzstGoMEDIiJ8ef+ySmUxqQw9m8tngbyzRS8Axbw1ed1M3jo
         PisUcYOkWSLE2/haTAzmkkAswQGYjpLvy8KOdw2zfOlC2KcIUXdL5aM3pCjFNULvP687
         8MCx0hm7fCm+qnNEExk+GGxMj2T+ljIh6Z9SsdVKf3ul7NNi3vO/v6pr/FRD3TbyV1vR
         iMXq7n3p3aDdUzDTomMB5LsMg0E7qVLkGNkTBiGecFDH7c7VUkaIBpPnWNKbeo5bxcR9
         KvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773716777; x=1774321577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4sR/GkKKCK4vlTKAx1HdQnSDfMDIglmN+8LdctHHquI=;
        b=K4zbvLsR2McOsP4W2YxYgRwXWj2IJUt005J8WyjURIukZXZ2/gO1G/3aVllaQA5uGZ
         4j8yjSTfDeAvX6VeGcX9wCbP20ZIRXEpzN8x5sUHk2e7AoehoMNgBZ0a6+Go2RptviSQ
         nXB0Gvw+l6H8lcHmugvONOtn8C6U4/G/jWaAKwboa/oIm0bpJUBbVnG/9BzRXRmJnZaL
         6+eDZcmHN+A+rUI/ZXHumB93BWfbZZrFRpTeGNaTbmp1m50brQHIjE4tdXWqe1h7zIA1
         QahNqr7k7+1AgUynAVCxgpxLk5uIftkN/rZSlReKJ5+Q75uP5nAqW4NhNJn/NTckriBT
         XKDw==
X-Forwarded-Encrypted: i=1; AJvYcCVbbO5GaYWcw6zX0VGA54outlbpiKVcbFD7duh/4OoaO/ptYUbtAbqO4AuG+X26Q6w5wzkIyQNfENVY@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5IE7m8om7vchgb5lX+m2Utk0RCrE0GW7GGxwu6S1XU2fiCQCc
	9vezUEnLcyh939vGNQO+7dOnRa4CW8wXsN01dXcyxhea5949H7GlwbBPkAAO311qpSKcaLECbVs
	CztuyDgfoQQ==
X-Received: from dycsb4.prod.google.com ([2002:a05:693c:3004:b0:2be:71e1:f4b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:6319:b0:2c0:d67f:35f4
 with SMTP id 5a478bee46e88-2c0d67f479emr566320eec.0.1773716776986; Mon, 16
 Mar 2026 20:06:16 -0700 (PDT)
Date: Mon, 16 Mar 2026 20:05:59 -0700
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
Message-ID: <20260317030601.567422-4-irogers@google.com>
Subject: [PATCH v4 3/5] perf evsel: Constify option arguments to config functions
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

