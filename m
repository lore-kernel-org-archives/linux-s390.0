Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA7D3A6EF1
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 06:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381528; cv=none; b=BFgtExOiWwIm5xrTC9cRCnqIXbp/losUM//MmFp7LcVWPbphnbfqMoAxSvR+8PWRI8f5xL4d5yp8UIR5I1R+RFh7LfDKfIUNmp6+KS8zinG9/OEYUH1vwiaBX6HH9gwTtF9Q6JcYMiUbJyutJ3SmYenQdMPHBAbmTYW/d2mA6Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381528; c=relaxed/simple;
	bh=Hot18PBTr0xlrnqsGHwaghakJVRFa4BOmAiFycM1yig=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U5UWmLTHSBQs454meC4eu56HnQ7cDwjICzZWnXVXgH68L3fwoX0aPMyDHPhapy9EycIaMpKefL0d0XXaTg0rwzohaU3ix4daYDrCKk/VbMjrSk6xhacrjv5OCcMOWtm8NkE4xW/s61TA4lBGFGvbCOOm7Vt0PzyqL8wCxEPsir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R8lCBVQF; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R8lCBVQF"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137f2083280so51143c88.1
        for <linux-s390@vger.kernel.org>; Mon, 01 Jun 2026 23:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780381521; x=1780986321; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/EoAq3VzUdAcwStCvHawZbW5RNzlYMnSm/cb/ao/L3Q=;
        b=R8lCBVQFs3MuX105/x+grWR17I9bYx/XpEZc+qNcucHlQGFk357xaCPEEdXL5c1Kuf
         ROx7J9YWEZZFMWcFmVlyUoIYh2ossySjiIPTmWxSun1GahTKTj0aiNu6T7Syb+Sa5uGR
         759jldXok0u9KbucE53tgCVevDsdx9GMTGHR21AVotWs+lANs7u4NpHt2MWKEfyjc2Na
         RIET7xInxmWayDLMl4rA1PmlzAK+ZS/08SdVZgJaVc4ubfWBo2W1hVXOKRRAaPD61u2h
         3mItux04AFSdZe82NjsC9MOjPuD4o5Pw61vgIIZSqY0wj6NtGDf2EySZv4f8lKga2wRW
         +SKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780381521; x=1780986321;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/EoAq3VzUdAcwStCvHawZbW5RNzlYMnSm/cb/ao/L3Q=;
        b=N1Sd78/uWiaJAcTTjBuG97jg37MRL5UDssv4XGzu12FeS6Ze7TtzdFHCXdxEnL9qpf
         Q5BpriywN6Q8OXu/D35qJNw1/gXATvIOO17AQRpoL/D60+dKO/05k2XtoHT+Jxs8AH6a
         prfxg8baor1kQqdcB5LIdzBIwoaXxAljxfHlSvnWNloPgtWA2DI5AP18+wGsMbWGR71e
         xcesPpIW8w3gJVT5d39KBnF86VoXbfnrlJtLkCBWL6KAEUsV3G8cPsTPf5657odVAFWP
         wyet6orSChFmEX3TTRaMfpjtjhsfXx8O6O+D+S6pEb9FGm/X9m8Zew55VQ/JDlw8dS5n
         Vjbg==
X-Forwarded-Encrypted: i=1; AFNElJ85UfeSu+sHXZhA2k469Xagh+R9Lux1ODqEQupTjQKZr5DzBgQ939peKc9IdwMSgJdyDHrwPsPhcsLY@vger.kernel.org
X-Gm-Message-State: AOJu0YzhNYcNWRHMLoavxRabCyxDJtyNEAiRatgHsfXHHJaZLRPVnOt9
	fZapDNM+h5mFohioRIMaQgFwYw8W4z4M1GZr4zJa2jdf/LhysT/+SpWuOGJHT0U1pGn15Ehz1JG
	s4JmpK7K1+w==
X-Received: from dlbrh17.prod.google.com ([2002:a05:7022:f311:b0:136:7c75:5916])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:421:b0:136:d421:9efa
 with SMTP id a92af1059eb24-137d425e193mr6582863c88.32.1780381520724; Mon, 01
 Jun 2026 23:25:20 -0700 (PDT)
Date: Mon,  1 Jun 2026 23:24:37 -0700
In-Reply-To: <20260602062452.2583619-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601065407.1597927-1-irogers@google.com> <20260602062452.2583619-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602062452.2583619-6-irogers@google.com>
Subject: [PATCH v11 05/19] perf print_insn: Use e_machine for fallback IP
 length check
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Avoid string comparisons with perf_env arch, switch to using the more
precise ELF machine.

Sort header files and fix missing definitions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/print_insn.c | 23 ++++++++++++++---------
 tools/perf/util/print_insn.h |  2 ++
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
index 02e6fbb8ca04..4068436f26ea 100644
--- a/tools/perf/util/print_insn.c
+++ b/tools/perf/util/print_insn.c
@@ -4,19 +4,24 @@
  *
  * Author(s): Changbin Du <changbin.du@huawei.com>
  */
+#include "print_insn.h"
+
 #include <inttypes.h>
-#include <string.h>
 #include <stdbool.h>
+#include <string.h>
+
+#include <dwarf-regs.h>
+
 #include "capstone.h"
 #include "debug.h"
+#include "dso.h"
+#include "dump-insn.h"
+#include "env.h"
+#include "machine.h"
+#include "map.h"
 #include "sample.h"
 #include "symbol.h"
-#include "machine.h"
 #include "thread.h"
-#include "print_insn.h"
-#include "dump-insn.h"
-#include "map.h"
-#include "dso.h"
 
 size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp)
 {
@@ -33,13 +38,13 @@ size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp)
 static bool is64bitip(struct machine *machine, struct addr_location *al)
 {
 	const struct dso *dso = al->map ? map__dso(al->map) : NULL;
+	uint16_t e_machine;
 
 	if (dso)
 		return dso__is_64_bit(dso);
 
-	return machine__is(machine, "x86_64") ||
-		machine__normalized_is(machine, "arm64") ||
-		machine__normalized_is(machine, "s390");
+	e_machine = perf_env__e_machine(machine->env, /*e_flags=*/NULL);
+	return e_machine == EM_X86_64 || e_machine == EM_AARCH64 || e_machine == EM_S390;
 }
 
 ssize_t fprintf_insn_asm(struct machine *machine, struct thread *thread, u8 cpumode,
diff --git a/tools/perf/util/print_insn.h b/tools/perf/util/print_insn.h
index a54f7e858e49..cefa5c5f246e 100644
--- a/tools/perf/util/print_insn.h
+++ b/tools/perf/util/print_insn.h
@@ -5,6 +5,8 @@
 #include <stddef.h>
 #include <stdio.h>
 
+#include <linux/types.h>
+
 struct addr_location;
 struct machine;
 struct perf_insn;
-- 
2.54.0.929.g9b7fa37559-goog

