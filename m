Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E5F3A9D9B
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 06:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381540; cv=none; b=WQPeuc18yDUuq2T4+DvCCxSrNztVz9vaOr3ac44Yvm3uXKYw1eq393BEOIvwkqqW4E7mowpyHNIz4PaW+J813WcNtCjLtSC64RfcAdNn3cx5ssuMyalahAUKLf0sQzh8GTkbtwxHCSZZqPKcCbRccgQwS//Z4d/snsPTGkKE1Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381540; c=relaxed/simple;
	bh=AJ+cfGDfN/nv1QtOco5T/vUczZG+yKOvnd/MSYaYhLs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B+bxQYWpPOAN2pd34EZ+UFz/ieeo4Of2p2yId7JVyO1wvk3hJ2FF5/mpurX2o5Nx7Hsm7/wqRmjUtHN/x61ABkXu4nz/7bFQCtmoOmEgm0ODQAZuk1cwAcDKAofmpXb0w8nrtC1kZ5YjakqmreiH84TrlfmzK8zUeYK41hgY9zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oHGKwFsI; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oHGKwFsI"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-135916eefa0so18406946c88.1
        for <linux-s390@vger.kernel.org>; Mon, 01 Jun 2026 23:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780381537; x=1780986337; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=if2KD53xtMqvcoFidrX8tSNh3zZDo7SrSprlPMzY0lU=;
        b=oHGKwFsIKRIp7YRGLY/NOKTV78JHzr7SVuXjmzaFcYVcj+zWbEelGypeLpyiF612BM
         V0fqhq8euLwgV12/Dyb5zXPyAfZgEtN2d9ARqzN+mzD+EUHK2J7NhsJdjvvbPeyOIFuM
         Dv7/RVU62bMZ644ZNmzk4tjiZM8RGR+5SQg7H/CzV4uo665tKGLt8MCgcqRHUsESuTnM
         lKUB7y9bQ+ET4xlJ+zyvIggMqqx6DqQ6T3z+vT4pRVeFE1RhCurGd09oahR/upvHozGW
         VJvYgOi+wFk5urRAiFR9AyWhHYKJ0dfHhkyKTyhdmJVfdZp7kMfkWg756FvrjQMJOd5f
         wSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780381537; x=1780986337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=if2KD53xtMqvcoFidrX8tSNh3zZDo7SrSprlPMzY0lU=;
        b=q4VHvFemLFNcAcwc0iJGOgVy3ijH5iqggJ0GFWjbBz89kFElW7yjLd0ArfoyLAUXX4
         O1X0WFWOOJR9DlCj++ctXoYVDawkcQMEuwHktn+0GwF2fnZFdXtPcGcmJj8pWyDl690F
         I5qd7FX7eh4CYllKxLngCANmDlXSJ0hmGrZ0loX2ybCywuVIh32jtLL/i6w7qMigLtGk
         Mu7ARqmcl1jtEv8svc/FXK4p7McsbHVqcfZRCocD3uR2y0fzs7J5nAF6DodfolO7LDmW
         2E65VAEaMjapiEfRGazjou03zBjYXHbFrpoHBzT6dk0FR9k9sf8sFkiDzjsXTDvOR5MC
         bmPQ==
X-Forwarded-Encrypted: i=1; AFNElJ+x5JFhytdrw6CSS8zsSCYFJNHIujt/Y0f91VO810OiuvjYxaWmT0PotP3DyTzhjU0od3O1FPtzVYUw@vger.kernel.org
X-Gm-Message-State: AOJu0YwBjbcX8CThEQY6SmFPp9adKtjl8xsGt/iWcK3tEgXIehmLvNiJ
	ssDZ35ZOPpdnreNX5JGiROvrSk71lD144Xz3WW25hFzTt57y4wHawYPSxXNN9JUzgMXdQsOmVEb
	4xItE0V2+8g==
X-Received: from dldoa2.prod.google.com ([2002:a05:701a:ca82:b0:137:efa2:589d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:238c:b0:12b:ebb9:1c18
 with SMTP id a92af1059eb24-137d4243a4cmr6526798c88.31.1780381536359; Mon, 01
 Jun 2026 23:25:36 -0700 (PDT)
Date: Mon,  1 Jun 2026 23:24:45 -0700
In-Reply-To: <20260602062452.2583619-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601065407.1597927-1-irogers@google.com> <20260602062452.2583619-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602062452.2583619-14-irogers@google.com>
Subject: [PATCH v11 13/19] perf lock-contention: Use perf_env e_machine rather
 than arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Use the e_machine rather than arch string matching for powerpc.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/lock-contention.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/lock-contention.c b/tools/perf/util/lock-contention.c
index 92e7b7b572a2..119a7206f3cd 100644
--- a/tools/perf/util/lock-contention.c
+++ b/tools/perf/util/lock-contention.c
@@ -104,7 +104,8 @@ bool match_callstack_filter(struct machine *machine, u64 *callstack, int max_sta
 	struct map *kmap;
 	struct symbol *sym;
 	u64 ip;
-	const char *arch = perf_env__arch(machine->env);
+	uint16_t e_machine = perf_env__e_machine(machine->env, /*e_flags=*/NULL);
+	bool is_powerpc = e_machine == EM_PPC64 || e_machine == EM_PPC;
 
 	if (list_empty(&callstack_filters))
 		return true;
@@ -125,8 +126,7 @@ bool match_callstack_filter(struct machine *machine, u64 *callstack, int max_sta
 		 * incase first or second callstack index entry has 0
 		 * address for powerpc.
 		 */
-		if (!callstack || (!callstack[i] && (strcmp(arch, "powerpc") ||
-						(i != 1 && i != 2))))
+		if (!callstack || (!callstack[i] && (!is_powerpc || (i != 1 && i != 2))))
 			break;
 
 		ip = callstack[i];
-- 
2.54.0.929.g9b7fa37559-goog

