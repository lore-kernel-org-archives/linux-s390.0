Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4EA2010EE
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413942; cv=none; b=moDBJTTArc126MxKmWjIR5QoYvdt9wEraMX110rnFG7KEXHqJaAHeldXx10qE97s3gSO4JScjrmp26IptcPY0CY8VGKggA/Bpuhs6Vp4smUfl20rG70nzIAvR4hsmh46IX0NyPtx1/iK7HxGB17H3if0jKYixX6imqVqU4AjXMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413942; c=relaxed/simple;
	bh=Hot18PBTr0xlrnqsGHwaghakJVRFa4BOmAiFycM1yig=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Egch2z+/XYoGLtdHcxbwCcPSQO1KTPLuwtndcp7/tx5kGz49N9D6vxFdUJ9qbI+AE2M/9oow1QxoFaktJ6qb65YccAGua/6oTWIEqaRmgLRDejz2KwzlQ0uo7BhSKcCP+IhnrjMssQtnz4Nr8p9pEvB/pyjfANrzpVEJR4/KpiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sy9vV1MS; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sy9vV1MS"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85798977dcso2842858a12.0
        for <linux-s390@vger.kernel.org>; Tue, 02 Jun 2026 08:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780413940; x=1781018740; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/EoAq3VzUdAcwStCvHawZbW5RNzlYMnSm/cb/ao/L3Q=;
        b=sy9vV1MShk0vYFVjWEOVubQOwH7fGf95PjyaYdVWIbR0B1km0hkoY8LpFK/RcT/tGa
         Dzm8qLfC/1VbX2qHwAJCto9zpTjvZBvPSfAybOm+ICW4mYvnCJZEgE0To1eHFWIoJmJn
         DxvyUfdvjG68fxa23swL8zPTOIEEGusFhFm4oWilLDoPUUvi82bGPPXAJG2IaP/57EGh
         U9bU86iRBqADpTZOIyHxu20pt8h8fg3k1yXonFdzXBoo0sp+uTyzsmi8mGmbfvuonkLl
         vWmFUf6rkK17MUlKQsOyfxR7FlNhDPdu3h5JA2lHTadA14Cm8psCHKFmk7vix88hEdiv
         SD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413940; x=1781018740;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/EoAq3VzUdAcwStCvHawZbW5RNzlYMnSm/cb/ao/L3Q=;
        b=JIWw3/OcmwCSsoRnQR+JzIRLFrkGO6c6d578aaUTGh5P1GNEtMujv0WJld+R9/NYzr
         Xq1kaABoUDgnJrSOh6KmlsJ26VQ+hUzFHyfjVeIbJeQfhnAOEmYT3am368OGyJM8YzPA
         hmWSUk6NUm041HpGyXqHjzMLd3IJRCXLrF6f20T08pnpPowCd03pZr/isQAGguBOYCMS
         PctstEUnEWq/JrNLMhDhqY4ltpi1rCTQMutj5T4ahRZO7JxzvRvLeSpRcJ8pGxsLmyBX
         0Eh7YVvkUjoWEGlajmdL1eelqA6os7BCYj6gAPicLaF33tRJD4tgJCHvAojZ0OTEcI8Y
         CCyQ==
X-Forwarded-Encrypted: i=1; AFNElJ9fSiruy/wLXo5mEWWakqeyEoV/volZUY7/V/dscraZpmNb4szHEKJA6cRoMfdsetPw2ORuY1qLJSmZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwv69UctwQoTFDIXbMjEG/qh13GUTeY6XF0mCOnGXZQRxNmf8k
	ZOii+9VnDAbWJippdemFi8P5/pM2lijjVW5mcYE0k4Exbu7WBHTDyaLMWxqjuiGeSwNtw6rqo+L
	fWL2LQ+kddQ==
X-Received: from pfbfh16.prod.google.com ([2002:a05:6a00:3910:b0:83f:1851:35f1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:984:b0:837:f79d:909
 with SMTP id d2e1a72fcca58-84282fa448bmr60769b3a.39.1780413939718; Tue, 02
 Jun 2026 08:25:39 -0700 (PDT)
Date: Tue,  2 Jun 2026 08:25:02 -0700
In-Reply-To: <20260602152516.2831152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602062452.2583619-1-irogers@google.com> <20260602152516.2831152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602152516.2831152-6-irogers@google.com>
Subject: [PATCH v12 05/19] perf print_insn: Use e_machine for fallback IP
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

