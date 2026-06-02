Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02C83A6F19
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 06:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381529; cv=none; b=DIIW3Ew+Mydx61ntObBGeQ86aVUmbS7K9/xtPKGGvrtOlxN0IwnFegWFTfn0FSRT6Bty8Po17hIjo59pI//MnlPkpqcszMuzK3FjkGgPttWpd2ttIhyF69oQ0vkfN5n9g3AP+cKZ6szOGRV7j1UpkjcQV5RGsVAOp+gEws6a2t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381529; c=relaxed/simple;
	bh=Z4WrN2+59MV/rg4sfdg9lA449vNSt4qPYiJQIWHMBoA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C8b0aQS1Z4HWaAfy6Q+w68J8eazjyKX06sbscQNE+81hYRNAVfSSCvpaVV33nzKHx+iDcka1GdZGldsM17IKwT5qU+kBBPAWO5tpoC/tq7FQ9qURrWG+ln6sqoHLk8T8TaeLrD3J7sflWmiN79dVLA1E0cYPChA2JCegE6zWqlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PqZleeph; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PqZleeph"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137d4309062so7461357c88.0
        for <linux-s390@vger.kernel.org>; Mon, 01 Jun 2026 23:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780381525; x=1780986325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VKmVi04Xi/VezwoSJHiJtxgWwe8v8etyrpuu8J1PVow=;
        b=PqZleephCnuDN9GCf1D5MkIltAqz9msJ/N8X20new5AVszrCAoBqDxoOkdQjGg9P7V
         TroN395OYqw5be3XDenvGvjvUEoE5nfjMwNUGP13/vkLKNXXa+0UVLa/vp7RMKy3H72c
         S1Mqh1tro3PyBs113qQqiUeMTti1xRinnSoyC332xwqvsOM5eYDH7aAmKDAr4+e3M4e8
         KPRxa32K8bqB8Fb2WRb9iUEAEUXGN565XHVyi51EGgfBcI4TQWfRwX4rb76PnG356BJ7
         vEx4I4slgHTSPf6ZZVQLviMQWmwCy4l//3eqHqcawDTZDd9pHTD3uDOkBef7A8mjWed+
         htUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780381525; x=1780986325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VKmVi04Xi/VezwoSJHiJtxgWwe8v8etyrpuu8J1PVow=;
        b=TXPMp67dFN22n4PUvy4wgDbXpE0XxL176PiE+yMjJadiT5lKOYMNnFADH2LallbjpN
         zSsR32IPPjI9HGKQoT25kk1q6JAAT1CsUAb+9ceZwCpG59FawFPb7BvkoCwNsPh4ctPa
         L0QEIlm1iJKzTtRw7ieCPX39dEHP2HUmEZWCL0vlJsLg9tyMPEowttMJW90qG613w2dB
         87l0IR+lN/BYVM0QZH4LSkgVlvRh7oiYsDPbScG40MvpNDjt9VjNsMc0OKNxA8fMwFls
         92r6gUxHj+fDai2UMMxB2srcVxOKpKQlKVRVpaXcIucxv8nYnkqJBdzlJsGpzSM3FTF0
         7YQg==
X-Forwarded-Encrypted: i=1; AFNElJ8Jzwry0AMnIAKTSvYw0DvvzyGkj9G+UZbjrW8Wt4ZUKUY2Cwl1IZwY49c3jwEJi874AEcSLUVN/QVc@vger.kernel.org
X-Gm-Message-State: AOJu0YyWYCVdvK2ZMIWNwp0sa/sXn7sU6UTlTMPej56vwoI83HV7/Vff
	kil+dHlU2WDYt9HZfmNjeOKHGoAzsgzacszRQlIAmfr2dBkEH3rJNVDmhwzfFUvBASCTbPKIfoo
	YeyO3ymIFlw==
X-Received: from dlea2-n1.prod.google.com ([2002:a05:701b:4202:10b0:12d:bc1d:8783])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f98:b0:12a:7165:7405
 with SMTP id a92af1059eb24-137d3f197b8mr7137251c88.8.1780381525020; Mon, 01
 Jun 2026 23:25:25 -0700 (PDT)
Date: Mon,  1 Jun 2026 23:24:39 -0700
In-Reply-To: <20260602062452.2583619-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601065407.1597927-1-irogers@google.com> <20260602062452.2583619-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602062452.2583619-8-irogers@google.com>
Subject: [PATCH v11 07/19] perf machine: Use perf_env e_machine rather than arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The arch string is derived from uname and may be normalized causing
potential differences meaning the ELF machine can be more
precise. Reduce the scope of machine__is as often it is better to use
a thread for the e_machine rather than the machine. Switch from string
to ELF machine constant comparisons.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 35 ++++++++++++++++++-----------------
 tools/perf/util/machine.h |  2 --
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e5d1e8b882a9..47be7a44a5f7 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -9,6 +9,7 @@
 #include "debug.h"
 #include "dso.h"
 #include "env.h"
+#include "dwarf-regs.h"
 #include "event.h"
 #include "evsel.h"
 #include "hist.h"
@@ -1627,10 +1628,24 @@ static bool machine__uses_kcore(struct machine *machine)
 	return dsos__for_each_dso(&machine->dsos, machine__uses_kcore_cb, NULL) != 0 ? true : false;
 }
 
+static bool machine__is(struct machine *machine, uint16_t e_machine)
+{
+	if (!machine)
+		return false;
+
+	if (!machine->env) {
+		if (machine__is_host(machine))
+			return e_machine == EM_HOST;
+		return false;
+	}
+
+	return perf_env__e_machine(machine->env, NULL) == e_machine;
+}
+
 static bool perf_event__is_extra_kernel_mmap(struct machine *machine,
 					     struct extra_kernel_map *xm)
 {
-	return machine__is(machine, "x86_64") &&
+	return machine__is(machine, EM_X86_64) &&
 	       is_entry_trampoline(xm->name);
 }
 
@@ -2786,7 +2801,7 @@ static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
 static u64 get_leaf_frame_caller(struct perf_sample *sample,
 		struct thread *thread, int usr_idx)
 {
-	if (machine__normalized_is(maps__machine(thread__maps(thread)), "arm64"))
+	if (thread__e_machine(thread, /*machine=*/NULL, /*e_flags=*/NULL) == EM_AARCH64)
 		return get_leaf_frame_caller_aarch64(sample, thread, usr_idx);
 	else
 		return 0;
@@ -3157,20 +3172,6 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
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
@@ -3197,7 +3198,7 @@ int machine__get_kernel_start(struct machine *machine)
 		 * start of kernel text, but still above 2^63. So leave
 		 * kernel_start = 1ULL << 63 for x86_64.
 		 */
-		if (!err && !machine__is(machine, "x86_64"))
+		if (!err && !machine__is(machine, EM_X86_64))
 			machine->kernel_start = map__start(map);
 	}
 	return err;
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 048b24e9bd38..aaddfb70ea66 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -224,8 +224,6 @@ static inline bool machine__is_host(struct machine *machine)
 }
 
 bool machine__is_lock_function(struct machine *machine, u64 addr);
-bool machine__is(struct machine *machine, const char *arch);
-bool machine__normalized_is(struct machine *machine, const char *arch);
 int machine__nr_cpus_avail(struct machine *machine);
 
 struct thread *machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
-- 
2.54.0.929.g9b7fa37559-goog

