Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BD23368A3
	for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2026 23:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773877571; cv=none; b=dB4HRPcMCF+XQuGgrAS2RInVlj/kI74+Gdoa7cyjLv9WISwgdX/9PwjjRQfObOZ7nfHGju0gk0nr1sst8VNDLn+Jy+PBRowfrUZ0dkXc2Op2+0F4tWI6pp1rf8sekFHY1+1uKBrQYWX8ZqD8/NDM6+8I6dDkZ21ee/BUY0nZqVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773877571; c=relaxed/simple;
	bh=A0GmPbCjJnn1aBXkaKYVs2MSN28WJDd3xDZa3Kc40Go=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZF8ZRaZX4Spy88I17lGb+tqDMmakLHRVxAL59nfvMj6pCqs2f9cPjvw4YUz4YkScq8bOQqqarU8cWlcn5QVCk2JVuWcRcduAfPF225VkfS3t1NMPUTqe0p6Cuf/q9ukNu0pqkc45tluNmc+Caj5t9D3hyJLK9UNbb8lVCV5ZMJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iEdIfV69; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iEdIfV69"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so405881eec.1
        for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2026 16:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773877569; x=1774482369; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nSZEuWL4PES8N47OQb2rrJbHDGRdHRzrhZzS2INVBJI=;
        b=iEdIfV69T+tyM0zjCMfTP58dENPRL7GP5hT9vTvlkAs63Jun1Ba47HloosEgKTGvkc
         NzqGDNxUSCAF5FxniAP/Id/EuCkaMOdh6XV8K8TQqqu2/a/dCXfRGs1zXyT8MgNPVb9R
         9Y7WIlunDSdcvsWoZAH6v34eu1XL0kKXx4xS2z2yzmOEuZfLbXAMudxP0ZM4SEY60Hjs
         JRAxpISZSYmAFr9UXTnAN2vMY4BdgLmqVJFw9Y8oSBfaZ3gfcAKYFuPxYaluXCpFZaWC
         aXqsYCKcTK/cur0Yr8gcSxDpl/DL3ky0U/aLwaMYhQSijXFqrejapj9FwsNZ9BuGhFdn
         BQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773877569; x=1774482369;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nSZEuWL4PES8N47OQb2rrJbHDGRdHRzrhZzS2INVBJI=;
        b=rCho1P49plvfz8EV1AuLc6bSsPGQYW5+lau69qA/JuUA8m2Kwct6/ohhRn4gdWMb2d
         MNmE4pJohwdo9AePRasCwPKyY6QtWVzHNPByj4jZlL4K69kuuDItyUZVgtospWsJnb0N
         1fzQAHh+C3nzwwCCcC18HihpHz8yEy4f14/2lDle/3FGZFfTkKCKAfS+UiIqT+t/wrtO
         i9MR3D7eyDfLeFO9prCQmAibXohKEDb4gVbafXRzUdSWEAMYpeAk6e3UtZtN0Pcs2qW7
         xN0c564KoGxpM9dGnwTZ78MYVe+alX+Vefxn+wAMbx990uhOyEbGWXD/CwlpdcZvwSM6
         K+ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNrbp1cZTrdcxzgUQqyhp+PorUVSjbZenN5oOObcNpSRzB45cT3Uvss1+O2dbgSziJTUoji8psCfX9@vger.kernel.org
X-Gm-Message-State: AOJu0YzL/f42Ld1soNafC6BfZqseuBInvgTuZaamVqdB93OlXz3IAAsN
	06SdoJF95hEZwsObGTezFv83MqofoQncNGwf2klTFao3W+CoaXLGpr5paw362HsVaZsyMsFg4Xh
	Rx2JDcEEHqg==
X-Received: from dybsy18.prod.google.com ([2002:a05:7301:7012:b0:2be:798b:cb2f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:3011:b0:2be:1779:3289
 with SMTP id 5a478bee46e88-2c0e518a4eamr2682053eec.35.1773877569345; Wed, 18
 Mar 2026 16:46:09 -0700 (PDT)
Date: Wed, 18 Mar 2026 16:45:58 -0700
In-Reply-To: <20260318234600.730340-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260318175808.582009-1-irogers@google.com> <20260318234600.730340-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260318234600.730340-4-irogers@google.com>
Subject: [PATCH v8 3/5] perf evsel: Constify option arguments to config functions
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: irogers@google.com, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
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

