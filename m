Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F85130BF70
	for <linux-s390@vger.kernel.org>; Sat,  2 May 2026 07:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777705213; cv=none; b=FETl/vo2Tgef+8O7tTXfDG/O9rwgc91YmJTOn2qxsRs/3do2xsXOuv/WFuzJdRpmupdBm7Gt/vzyPVMwVjmJsi8NiDaC84NS4ZIPKGd7tU1AbIl/gjddM8OtsDazbEeqLkais6ZHoUMESMLUd14dXp9eLG/L8+85hKh3rPHsgFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777705213; c=relaxed/simple;
	bh=/g19K4HeaUNMX95kGXSMwY9kZbGyi17nk8eWwkTFbEo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NJqq2O/msTbb0UESx2qAQXm7MM5RqGm5d+OfHi7mNDtR7yBq3h8BYiXLLONj7TFAt9iHoj+CoSyOr+i59JxbC0FsBmwxs/cT2V6rUbKcT6E/hH60UKRoxuPlULx7AfxttYOFcU8eBe1tZasUXt7mgB/pOXLuxeUOj66hR7ts/Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i5R1DpVS; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i5R1DpVS"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so3927567eec.1
        for <linux-s390@vger.kernel.org>; Sat, 02 May 2026 00:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777705203; x=1778310003; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uTtIRHRKCWvPzr+ogiuYCalROJTpC+azMEHxFbhdWy4=;
        b=i5R1DpVSXTYiQkOAwhI5k3lpvLCldmQjgZ/KoIIpwJiA5jhOaR+TeWQ3GWjG7/AyGH
         M83qE24MPyBO+nMH86gNCJK1jKOyIMy2vzUZSDyeXtg9u7rzk2Yy7UW9Jf98+ncieWOj
         DZPg7XoFKr3iqUiSYz1Y84A1qiE3LXJYtrBcLIUVeBRZNEmaA3QjHoH9MSq3DtfqyE82
         l1uumF6IwCw2KkA5/o8hnknFJRlBwVHsHTJ6DQI0d7+iqo23/gj3OcCw5qDw+okO4Agy
         b/4FFnrxnJ3WPl1eGqqiaeayF8sCLCcSqDhmnCSuYff2CXONLAYo0c7ckWO+FOPz3ZVz
         DxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777705203; x=1778310003;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTtIRHRKCWvPzr+ogiuYCalROJTpC+azMEHxFbhdWy4=;
        b=s7xPLm2WCFhnKLESY9DjYdwEcSay14ZXZGKTkTPbtw5JUGqttFhaT11eolBOhl30W6
         MTeDemqagu5QUhmEnepxdLVO/2sKM2s8NoEfD1actqhCtLYy+gxqGxNPzZJ+e8DU0/9v
         rRim7USJfA1p6OFpTjUxC9IXFlQpURLaaceMpxcc1NRWZDGPs8IHkpy/LNBuKTDQffbF
         knIIABMlfbfBwxgCVeWmCRuXu29cZ3SNrKIS9pn+cNPVhwyDzClPnnPCo0BAOK30WBXV
         /VUmP/Xpx0TTwuwKK0fvExYhAi+8AbNGBF00V8rXkLaSOUng3s54aBscrTC0QKeZCUiL
         /R/g==
X-Forwarded-Encrypted: i=1; AFNElJ8Mv9OB2Qma0QUFwV6SXc5yf1I49iIxAMC54BUXGrNY3PATLp9xQeoJ42wFL9uz5sIJQWlNfVUe43e0@vger.kernel.org
X-Gm-Message-State: AOJu0YyL3ggTAPIm3hElkIL23s2YzeoDKRkK11eB822cpAQDwizZoXKF
	Lr4IgbhVcl2qUE0LFhBdIWqkwgmrfwjhwuvWgbUozU56DvqMfFoMZyUBjRZjCmq4eNo0xQoTXWC
	LK68Cirj6tg==
X-Received: from dybmr11.prod.google.com ([2002:a05:7300:cacb:b0:2f0:2767:d69])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6c2b:b0:2ee:f85:ec3c
 with SMTP id 5a478bee46e88-2efbb8758fdmr841650eec.30.1777705202593; Sat, 02
 May 2026 00:00:02 -0700 (PDT)
Date: Fri,  1 May 2026 23:59:23 -0700
In-Reply-To: <20260502065935.291960-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409230620.4176210-2-irogers@google.com> <20260502065935.291960-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502065935.291960-6-irogers@google.com>
Subject: [PATCH v8 05/17] perf machine: Use perf_env e_machine rather than arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The arch string is derived from uname and may be normalized causing
potential differences meaning the ELF machine can be more
precise. Reduce the scope of machine__is as often it is better to use
a thread for the e_machine rather than the machine. Switch from string
to ELF machine constant comparisons.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 25 ++++++++-----------------
 tools/perf/util/machine.h |  2 --
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e76f8c86e62a..6d32d3cb5cb7 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1611,10 +1611,15 @@ static bool machine__uses_kcore(struct machine *machine)
 	return dsos__for_each_dso(&machine->dsos, machine__uses_kcore_cb, NULL) != 0 ? true : false;
 }
 
+static bool machine__is(struct machine *machine, uint16_t e_machine)
+{
+	return machine && perf_env__e_machine(machine->env, NULL) == e_machine;
+}
+
 static bool perf_event__is_extra_kernel_mmap(struct machine *machine,
 					     struct extra_kernel_map *xm)
 {
-	return machine__is(machine, "x86_64") &&
+	return machine__is(machine, EM_X86_64) &&
 	       is_entry_trampoline(xm->name);
 }
 
@@ -2770,7 +2775,7 @@ static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
 static u64 get_leaf_frame_caller(struct perf_sample *sample,
 		struct thread *thread, int usr_idx)
 {
-	if (machine__normalized_is(maps__machine(thread__maps(thread)), "arm64"))
+	if (thread__e_machine(thread, /*machine=*/NULL, /*e_flags=*/NULL) == EM_AARCH64)
 		return get_leaf_frame_caller_aarch64(sample, thread, usr_idx);
 	else
 		return 0;
@@ -3141,20 +3146,6 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
 	return 0;
 }
 
-/*
- * Compares the raw arch string. N.B. see instead perf_env__arch() or
- * machine__normalized_is() if a normalized arch is needed.
- */
-bool machine__is(struct machine *machine, const char *arch)
-{
-	return machine && !strcmp(perf_env__raw_arch(machine->env), arch);
-}
-
-bool machine__normalized_is(struct machine *machine, const char *arch)
-{
-	return machine && !strcmp(perf_env__arch(machine->env), arch);
-}
-
 int machine__nr_cpus_avail(struct machine *machine)
 {
 	return machine ? perf_env__nr_cpus_avail(machine->env) : 0;
@@ -3181,7 +3172,7 @@ int machine__get_kernel_start(struct machine *machine)
 		 * start of kernel text, but still above 2^63. So leave
 		 * kernel_start = 1ULL << 63 for x86_64.
 		 */
-		if (!err && !machine__is(machine, "x86_64"))
+		if (!err && !machine__is(machine, EM_X86_64))
 			machine->kernel_start = map__start(map);
 	}
 	return err;
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 22a42c5825fa..003c970b3e4b 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -227,8 +227,6 @@ static inline bool machine__is_host(struct machine *machine)
 }
 
 bool machine__is_lock_function(struct machine *machine, u64 addr);
-bool machine__is(struct machine *machine, const char *arch);
-bool machine__normalized_is(struct machine *machine, const char *arch);
 int machine__nr_cpus_avail(struct machine *machine);
 
 struct thread *machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
-- 
2.54.0.545.g6539524ca2-goog

