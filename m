Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A447B3F2101
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413947; cv=none; b=flYdaoxQ9W+RA3D+tVhGUOgSAB0y++aeKAyDgTQxftklDRm65mwWOEvW+dNU8sqcdbIR8ovH8ET0KcJ/znWr0GS6qi99/Oj5YBbj3U+1ih0Ff7hMpHS5AP5n/rAP9Evie2Zj9gFuFVzlLtQDNhz6ENh9uKh3icLBLhnqs6BVbm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413947; c=relaxed/simple;
	bh=0E8FGILepgrTA6ONyBxd8a3wp5kiZDScmQzg7pssilk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JdgEv0r3EDyWrmwRF6YBrSLxKVwTzqg9oq1OeL6hD6kNOQf0hoW2nrgVhuWE/iTHEFcy8Cj8g82JHD3KIYRB6l5FQdDgJ4DjCX6u7jNTiex2DXJy6HAqDM0WZbQ7VOtfCg70nrxit22X8RR2tJF/mvytvUSZw/qGbus9gl+wPi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ikXpNy7U; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ikXpNy7U"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304b8d0ee63so9674115eec.0
        for <linux-s390@vger.kernel.org>; Tue, 02 Jun 2026 08:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780413946; x=1781018746; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/QgB1qOgUmUCrnPstfXNyo3WG7TO2qaKYGbmxO6cXBE=;
        b=ikXpNy7UB8DL1vy3PrIkQ4VBxLWiJu1DXO5EtoldvJ10lemz6lMNH0kgmtfpdUxXNj
         QGLwmef6aTyEz4a7sciYbVk9xquIz5lNzt3mwtLPcIqG5UNjefBRIXMezqgCl7WAs3Ph
         iRpOH2YRrCphZ6Y4IzyQtbYXOHHZcL6O0zx4lLZc/jh39eluiImqmListDDijCrwzyvw
         T34mvyFaoezyYduCFapvQP++HGgfLru2IdYC4O6oPaFUpn/nVu8bOdJVd0GcDX8/qYCM
         IoTsa6+7zhrY3J4fKjoqFYl1P1Jp9GNZzhPoD2ldSRpXkv0LPUCbhBGoS4Bl0EY23XJv
         WZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413946; x=1781018746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/QgB1qOgUmUCrnPstfXNyo3WG7TO2qaKYGbmxO6cXBE=;
        b=dkf2KpeyZ/JTO+yMoBeesvmh8//5vZfwARDTOnB6ZtIJCS9Np71UeAbjmpT47V4uV5
         1nVd81WTiuYqv93KzpoJUGWC9Cv5xpHb4zg30cT7wmQe4RiGGdI1sd7Aa7+IRiNvjsny
         DqWU96HR6NadZYUFLsN9H7A3GGUKqrQg3VXqeL/T/Zz9aOiUygNtVkOntTVdfnnII4F9
         /hcxqAyZUk4SAJCScUKZxECbDjkic5ZB2n6OYRT0mvl6VM0qLMJu5bBAyo2jj4YTBIYB
         Ht+Zyyw/nXaJfAjKX9MCAF19T2t4UD455w54RyBZ/AORI0VDRETiDm3ujqtJcPzkLFTU
         A3RQ==
X-Forwarded-Encrypted: i=1; AFNElJ9uRIWTBxAekCtfMPXx/4g935sGCWotxI/xbYdmiT/TC90b9ZjC41LHFa3+BRaFJX6rm19ZcKffcuVy@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg3AST5p7a/ifcH2X9kA1yfCEDlURru97Ui/nX4HkD1W1nGwA6
	yWiBHEAAV9q3qKRj1gnRXvuMJYds3Q9NDFeJhU6eNOnIOzIufYTTRrqmVpKVUAeINKVksX/U7ey
	WG+Q+oCx5iQ==
X-Received: from dyckx5.prod.google.com ([2002:a05:7300:c7c5:b0:2d5:d26c:d4bc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:80c6:b0:2c5:220c:5670
 with SMTP id 5a478bee46e88-304fa49cde7mr6868612eec.2.1780413945550; Tue, 02
 Jun 2026 08:25:45 -0700 (PDT)
Date: Tue,  2 Jun 2026 08:25:03 -0700
In-Reply-To: <20260602152516.2831152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602062452.2583619-1-irogers@google.com> <20260602152516.2831152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602152516.2831152-7-irogers@google.com>
Subject: [PATCH v12 06/19] perf symbol: Avoid use of machine__is
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
2.54.0.929.g9b7fa37559-goog

