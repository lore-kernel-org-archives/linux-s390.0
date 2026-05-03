Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF971E8342
	for <linux-s390@vger.kernel.org>; Sun,  3 May 2026 00:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777767791; cv=none; b=OwYeLesbTUJSg6vQM8DaeD4Uy0F99+Kh1RuG+8oviqViZU838RPvFVGvX57XjqDHeFhQVGyy30dIW9YlXEXhLsY16Bxre+2cg0nc7TD6gAvJu9NHxFLn7alS0dMZ4uHyIpdT9tF8QBMkpV5YdJ5jcodlBZjT+Q/AtLmI8VaRj+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777767791; c=relaxed/simple;
	bh=/g19K4HeaUNMX95kGXSMwY9kZbGyi17nk8eWwkTFbEo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d0RVza98Z8byV/jS/+dndEXfMkUBJNk5anjgyD6vJwx9dALu3J7rUeazGzBrzr7u3gDVJpQN+lXgEI0rDDRyWD4gCMR7MFvoxkBlvaxIhUyfBBEvDTBCGU0VoNSLAORlpSAmxYS2PZ/7X9HJ+lvJqGe4IYrDQgpz/55jiUKNTLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qcNJ+e6A; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qcNJ+e6A"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ef37c3f773so1269679eec.1
        for <linux-s390@vger.kernel.org>; Sat, 02 May 2026 17:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777767787; x=1778372587; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uTtIRHRKCWvPzr+ogiuYCalROJTpC+azMEHxFbhdWy4=;
        b=qcNJ+e6AZ4yfr18FX3vTVoQbU/TJHqfjGfea1tTBhLFMdClOPYoe0wzKoKRRMhRPEq
         Ug+4XASpWfpG1DZi6EoEgjNVTQFYYZLatVpOlXgMuaLAP5tjyo9113bp+Uzuf4vNeECv
         ISSp0NVQMr0PzdIP9Pz5UX3s/7TvgmsBhreuMAUzk7ka51EM9czUIrMbVXHeu2KQVjBJ
         lEeqySOlmOCBJzwelc6tonTotQ+NJeXQidKVSwy1D/+6JLxi+lEeTU4USwOtw1KiGHG9
         PapSZ8SdTsJn8NUUeupmFhXcKAFgD8Vp6XkteCdU8aPGmF12fjbQzf1ctZIN2lJTUrI9
         PcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777767787; x=1778372587;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTtIRHRKCWvPzr+ogiuYCalROJTpC+azMEHxFbhdWy4=;
        b=a8fSp7Rhau+1GanpAevIQhiiz/xmeL1BoivaJv2OIOXD4ewyMFf/Gz9Iuz0dixQfEe
         mnShKT75lJYtQk33Pbo75dbPY0D6NiXjFBBInK0Bmj2kJc9TqrjFxGCIfLs1r18Z1Yvu
         0P4Z/D3Z/2ctLWVyuNcCSwcUb7LBamv2xanSMHUJX1uOyGmwTHReFSGZTdnH5KEhvB8S
         aI7vuyCoP7cE7j5YCi3545gHDTD0V2mlVh7Y3Mfyn0dpLmHRbUqQacF5j0ZTswdSRu0G
         4DkbStbKDoMum2omNWioAuvyhbmg5xPy1t8SRr5UFVad/LDtQx9ZjJD91v9U1UuE7Jb1
         FgOw==
X-Forwarded-Encrypted: i=1; AFNElJ/3hC1XSX/LBcgnym9964in3yPbSwYw8R5GNP+Wfaba/RScV1tcscxCUkWA3QTNnYiNqlFLYACSlQyW@vger.kernel.org
X-Gm-Message-State: AOJu0YzimEhHrcUqDMgEB0T6ET7R3HWfNind2nNzjnTyRcgl/yV8gMaf
	6I0b1fZu66c6QHk6gYvq7IGuiQSyOeU3XLYiB3YRS+Ybx1WFd8lW3onxnOhHr8vAkjsjXTVzJqI
	tKz7C53T0AA==
X-Received: from dybgi1.prod.google.com ([2002:a05:7301:81:b0:2df:c53c:24a5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:fe0b:b0:2ed:b131:240e
 with SMTP id 5a478bee46e88-2efba1750bfmr2023743eec.23.1777767786711; Sat, 02
 May 2026 17:23:06 -0700 (PDT)
Date: Sat,  2 May 2026 17:22:37 -0700
In-Reply-To: <20260503002248.1040791-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502065935.291960-1-irogers@google.com> <20260503002248.1040791-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503002248.1040791-8-irogers@google.com>
Subject: [PATCH v9 07/18] perf machine: Use perf_env e_machine rather than arch
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

