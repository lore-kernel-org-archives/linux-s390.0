Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013B2381B0C
	for <linux-s390@vger.kernel.org>; Mon,  1 Jun 2026 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296871; cv=none; b=Eg1gaRbXH9IFcnMnyxsyG4QwPidZSlVsOFD4c5CaMmnsbvOSHiPeNkbljU++MDQSZiEAOkmf0YOZ5dDObqSpdijLRkT0FhduW4uVfsQfsJnLFOan9CdiwQZq8gn1DCkJzwWe2NvC024CromJuqAdW0V1e+gvBj0WvQjHyytmhhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296871; c=relaxed/simple;
	bh=Y8Rf13zfpkxw1oj6pH0PZcyvU9uedOBfB/1NbOk7564=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C3zvdwmzOJBHQm3XBIDH1luwo4JfzBH6IgKM038QHkwJ2uAhHJQTRHllZpBGdBNWf/EjNeABve4oV3AnYqkXzpc5erGEkkdV5L6PR+vHchmxPKcPxxOsvQ2ExvHDDNNKgJxyeFcxM3YwOZxtJVNY2sME8W8wcTQTrfBgenmJ/XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UVFcsvRC; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UVFcsvRC"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-13537722193so12924197c88.0
        for <linux-s390@vger.kernel.org>; Sun, 31 May 2026 23:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780296866; x=1780901666; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZR+AyCfqaiav/AMnhzc3hZKuPa0HeRBaZVNt7UCysX0=;
        b=UVFcsvRC4bpMHmjQUa4awCg2i+K4o2FDRrE87AWCve8xTEbNQN8yo7TlJ4RGMJwL+e
         uALFKkOYUEHtRd4f15CdbSQaMBwR/1MD2+yC9h1I3ZvyvOYvhk4LvdW/HK7U96mFlnf9
         1lS98qOukRQrVcLQysL794axUwyysfmLJtrgUg43/xNgqwzHzQVGRA7oUWGhEqAjXn31
         bf3YTMoJ6HQ9fR4FraKqAB7itzImKMMutsPDeGTdY8NM5gE+I2aJgxRs6iEHXj5ie8Uy
         I5N7/bxmjYhQsIIF2gVVG3vz6deECLaATNP/iw0rocKD6KCJI3tHncjpxUFO/0NdFZKL
         3R9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780296866; x=1780901666;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZR+AyCfqaiav/AMnhzc3hZKuPa0HeRBaZVNt7UCysX0=;
        b=c7dA0RzIVw/qSAOT5sRuSW0V9AP2wwDqyFePlIezIviQglgpJthYFLDAdwo0H2t2sh
         JGxhgJWdQZrfGQqLuhKUpisw804S4tfUM7M8NcB9z5lew/xWbbt2Imk2SfM7QMdh6hm1
         onyZIR2VYx0Q5bNUIWG+7Wpkj0OSsAfr2EExOKkVTFNjgWqBf6Vk5nBPzGGd3XWC2B/H
         EKIrXA08ARSG6E7tm2SO+f08D2zT17U0xlEj4/sw5P93HtKcsBh3nC+2eiZdDi8FQ3ma
         /vy8Ne7PPFXDPIIxW9vU7VF9o/BNwkpxQATmkxTbd+DTcbtEnXXPWScrsfLuDTPmafZV
         cj/A==
X-Forwarded-Encrypted: i=1; AFNElJ9cAF/7XmgiKwjlekb0gpG0QlWihvGeesqV9rTmsfK7Ts1ezLuzAcSIF7BaVV+8xeyDos+OTamVwUDA@vger.kernel.org
X-Gm-Message-State: AOJu0YwHb9IBsveD6fFILhci/p8N6r6O2cutvixaxr7nMu0MtR5ojabh
	WRYLflz0z+oetYYg3y/gAC6EWVNo9jyxHR753LBKu+NQvPTqoky+Hm2PSES0ScyYVnzvX7f1zKh
	CHFTQ6C7Hfg==
X-Received: from dlee26.prod.google.com ([2002:a05:7022:629a:b0:136:787c:b82c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2228:b0:136:e42d:2c2b
 with SMTP id a92af1059eb24-137d3f1367bmr4361266c88.17.1780296865875; Sun, 31
 May 2026 23:54:25 -0700 (PDT)
Date: Sun, 31 May 2026 23:53:55 -0700
In-Reply-To: <20260601065407.1597927-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503002248.1040791-1-irogers@google.com> <20260601065407.1597927-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601065407.1597927-7-irogers@google.com>
Subject: [PATCH v10 06/18] perf symbol: Avoid use of machine__is
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Switch to using the ELF machine from the dso or running machine rather
than the machine perf_env arch that may fall back on EM_HOST. This
also avoids potentially imprecise string comparisons.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 714b6e6048fa..2ce512f08a1d 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -851,6 +851,23 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 	return count;
 }
 
+static uint16_t machine_or_dso_e_machine(struct machine *machine, struct dso *dso)
+{
+	uint16_t e_machine = EM_NONE;
+	/* DSO should be most accurate */
+	if (dso)
+		e_machine = dso__e_machine(dso, machine, /*e_flags=*/NULL);
+
+	if (e_machine != EM_NONE)
+		return e_machine;
+
+	/* Check the global environment next. */
+	if (machine && machine->env && machine->env->e_machine != EM_NONE)
+		return machine->env->e_machine;
+
+	return perf_env__e_machine(machine ? machine->env : NULL, /*e_flags=*/NULL);
+}
+
 /*
  * Split the symbols into maps, making sure there are no overlaps, i.e. the
  * kernel range is broken in several maps, named [kernel].N, as we don't have
@@ -866,14 +883,13 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	struct rb_root_cached *root = dso__symbols(dso);
 	struct rb_node *next = rb_first_cached(root);
 	int kernel_range = 0;
-	bool x86_64;
+	uint16_t e_machine = EM_NONE;
 
 	if (!kmaps)
 		return -1;
 
 	machine = maps__machine(kmaps);
-
-	x86_64 = machine__is(machine, "x86_64");
+	e_machine = machine_or_dso_e_machine(machine, dso);
 
 	while (next) {
 		char *module;
@@ -925,7 +941,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			 */
 			pos->start = map__map_ip(curr_map, pos->start);
 			pos->end   = map__map_ip(curr_map, pos->end);
-		} else if (x86_64 && is_entry_trampoline(pos->name)) {
+		} else if (e_machine == EM_X86_64 && is_entry_trampoline(pos->name)) {
 			/*
 			 * These symbols are not needed anymore since the
 			 * trampoline maps refer to the text section and it's
@@ -1428,7 +1444,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 		free(new_node);
 	}
 
-	if (machine__is(machine, "x86_64")) {
+	if (machine_or_dso_e_machine(machine, dso) == EM_X86_64) {
 		u64 addr;
 
 		/*
@@ -1716,7 +1732,7 @@ int dso__load(struct dso *dso, struct map *map)
 			ret = dso__load_guest_kernel_sym(dso, map);
 
 		machine = maps__machine(map__kmaps(map));
-		if (machine__is(machine, "x86_64"))
+		if (machine && machine_or_dso_e_machine(machine, dso) == EM_X86_64)
 			machine__map_x86_64_entry_trampolines(machine, dso);
 		goto out;
 	}
-- 
2.54.0.823.g6e5bcc1fc9-goog

