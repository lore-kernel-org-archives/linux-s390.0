Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA38380FDF
	for <linux-s390@vger.kernel.org>; Mon,  1 Jun 2026 06:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296868; cv=none; b=gcxlY1o32BvSWlkwkWhgSJN6ll04gTM3GA9ILb5hZWeCXmSy5JNuk/9FyNwJfcHQQ+AQ5nMaSZNfgTO5k0JspoqcIZUaGWQCb8DKDVvmOPjuTqePG0cM2KPZJcNnaw8bOoXG25FrYKvkfTkPHUHMDJYkYacfUvptr0iuPh5WNjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296868; c=relaxed/simple;
	bh=ZWlpiDR5rqxF9BsLX33/iMtIeBO3s9wTTkZvmeMp3Jk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aT5mryOopg1mBIIkKr3C8R5B1hCKp7bSVROhuNRyVtkI9yQG/EsQue4m6vVpulNPNmqppsqS4QsQupRHCUEZaVSRVME2O845lP8sC6WsthC9oKvz9Zqfwg1SX6kIhr613fiIGMLqMJbWUUjE+/yK5GB08ltIl+IIKEKMSyX95p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xf/m9KUT; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xf/m9KUT"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304b8d0ee63so7180940eec.0
        for <linux-s390@vger.kernel.org>; Sun, 31 May 2026 23:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780296864; x=1780901664; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+yvjTMhUQpFCMKyM3D3vzIS0OTnjZbpM9x7Pw9L2nmE=;
        b=Xf/m9KUTvmxY9NYEEXiyc6QZunhkHQSvk9NLjVHvD0ZCic1V48tSyDdXkoL6BvROk0
         3WPuTUlnyUEBRPRJzE2AMYefINbZ2xZR2dZKKqnO2HsfbISaZo4OATWjR4u1ZAOa0AtK
         86gFxj6SW4A+SsysSZr0GEZLHHrH2b8Gl/UfvokIw2cqzm0yZHxyoMUK6ykm2T/yGIuH
         esDXj+og5qbTtWPMTGVN6PZ87n1KroYlEWk2PYVGMD6/srZmq+FV88WzmXngUF4Otw7W
         grF8zNj5ilnBAH6GWMxhsWbycicf2x4P8MYjUhcAhEIYte6h6F1LixKB5oYxp0EbDEMD
         mS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780296864; x=1780901664;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+yvjTMhUQpFCMKyM3D3vzIS0OTnjZbpM9x7Pw9L2nmE=;
        b=cUppY3XJDv35wsDL6k+C6BR3tq3WRLs8e0x/ZPBMz2RZ9vpRrPXq1v1L9aXJktxjgg
         xaDVOrXACk8S6YQn67Qih+jBaLIbpuGDWdO/hv5/O/eXoc3JzMu7mcrsIxQ3O/JVzkFx
         TIS/2ItcJbXhW7RsRMlsLiREYhl6N0QkfFjbMXY4Xn1JyKgDO1GTfY+seIgaJJWdZ8Ul
         x3IRuiUKi4HHynPnqKDl9ZNL9sPELpgNHRJKNJfmDTpTpSQhIOHPCWmn5JwmKg786zS4
         FKyFx1lnKE/aBv7n9LOPh/3CaWM05rR+0heJLzZC85nlmKE1KO0uGDYwMGQceIvEEuME
         0yFw==
X-Forwarded-Encrypted: i=1; AFNElJ8xGbJoXn4jSfMl74lrvSoRq4Jv6ngIpick+YS6S4Kkh4ODcvtvvgDDiJYmGInq+BafNksNnpdgoUjO@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5/LtfAncYTKZ4Go+75xpUIc+WtAe+kpdCfD41fH2xnvx1jqB1
	L+Duz/BdGDMQtdJVQrAwti5Y4LFxsUHzfoxSKxKzOh0aCtISLn4BK+s57tyTQZ2umib/Ad4C4A6
	wkJIjNhrQIw==
X-Received: from dybcr38.prod.google.com ([2002:a05:7300:aca6:b0:2d9:8c75:b19e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:8605:b0:2dd:6937:79d5
 with SMTP id 5a478bee46e88-304fa4c7c24mr4877511eec.8.1780296863813; Sun, 31
 May 2026 23:54:23 -0700 (PDT)
Date: Sun, 31 May 2026 23:53:54 -0700
In-Reply-To: <20260601065407.1597927-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503002248.1040791-1-irogers@google.com> <20260601065407.1597927-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601065407.1597927-6-irogers@google.com>
Subject: [PATCH v10 05/18] perf print_insn: Use e_machine for fallback IP
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
2.54.0.823.g6e5bcc1fc9-goog

