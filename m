Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC54B1F1932
	for <linux-s390@vger.kernel.org>; Sun,  3 May 2026 00:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777767786; cv=none; b=pkfj44ENiF5/xxP3kaUzOG6iFKDmOCi6fipP91KpMNHAybHFXjWOp1GdzGIs11vCjAPRbkw21y9vFuKyd86TgjI3YFBx2y94lf/7tLzXl9sIrTnfbe6Dg63CQrdzADmeLEQ1q56kDwBRv9FW3E8+XDcIQA1++O1yycsfrd+vtaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777767786; c=relaxed/simple;
	bh=9QpqEPy+XyRDsxWYvbQ4axWxs+A3ZbBA767almG0lQA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n6VX5s1T6i09XteMQOq/eKvqLAsYVD2agEAgvzWqpZI6yON3C+0H8xhX758UpyIjmHNTsscR8+Rk/EGVd5tAyavTQERW1cjWL1D65+Ud+mRQk4X348QlEXKXauIzaAqLlr19Y5vX1P3QqduqV9O4xyHA2iRgXj0JkFH6mt6BbBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qGxvUwA8; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qGxvUwA8"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dbf4f678eso16486144c88.0
        for <linux-s390@vger.kernel.org>; Sat, 02 May 2026 17:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777767783; x=1778372583; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NeQPgFPRPmQNsYTAg5Wkl/fjmvLR66LnLvQXotERGZQ=;
        b=qGxvUwA8Eg3nnr5TR71ZdWacGRIXpgNCRK8oYfpUbxtR2roOi1SeCcltRflUD0yOV7
         wKeM1QmgZDiP4OvsfXGpA6ASZzC3z+USfCE/KIs+d0Kbe6yvpF/esmNj4VWfXsYLDPt3
         8cuE9y0SyzW9UkaEgoKmFcn+qbMJaJxiSoKw02FkC2aw/nQEVdLIrKXrckqO2wvV8BNY
         gQnXAdNAhGL4+b3QILsMVfA8QBT+GhaJFPc31g8TQGsub9Xq9IgoR/ydGeby4fkOxEla
         uBaJbwJ6QIL9fcLUn1hoiIyu4jw96RKcSmzZrjD1utXcTKbTxJBQV00q0mHMyb/3vqxr
         Sa5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777767783; x=1778372583;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NeQPgFPRPmQNsYTAg5Wkl/fjmvLR66LnLvQXotERGZQ=;
        b=r1YzNv2dwd1aNyyRIHR+aROrte2EdECRcZytvnF9S6ctqr40H/9Bj7BMq+SnLjOKkQ
         ukUZJKp1HP1a/P+ZHSXwyEFVjdKY42OLlb+69an3IAgWjP71+iUMDzEaYUZ78IoHS6xF
         ImP3B7lm7lq4R/Cc2FpC9T3NnEXwnVJZ4T3SCwwxAKF1Ic51Ih1IoVirMXtsBw7TS2Us
         2qN1ndRUiBMrekLCStoCGNxf0HHpAiawWaF5VC1fpelSq5RfUF9TiSc7qLJ+LibI0nb6
         Tn4ccur40wZBB3bjypOkpNJL54mLylQs/O+HrqY2jyR8Se7H1lyewR8Iq8Dwm68KaQRW
         sQ3w==
X-Forwarded-Encrypted: i=1; AFNElJ8oVBbRJvrrx5P5VkIU306QZuwdqssX2FyPFHyyz3/vgv6+ceVWjo+bwB3+SqMwL6i6GvaSDmrP0XIp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8WiFvxGL84uWnXCeG6JFrVZMIv4DJbN8E+uYzpIeopEMfWBBv
	CNL4rBuXiLsg0H8KrMZ4ZhODOat85qVIxw/whb7v6qlU1pUYjxaEMT4dGLeWpj9TAFyPfbYUere
	cxDbQ1nMMWA==
X-Received: from dlbcf14.prod.google.com ([2002:a05:7022:458e:b0:12d:ba61:2512])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:61a:b0:128:d2b3:5df
 with SMTP id a92af1059eb24-12dfd81a65emr2186874c88.23.1777767782878; Sat, 02
 May 2026 17:23:02 -0700 (PDT)
Date: Sat,  2 May 2026 17:22:35 -0700
In-Reply-To: <20260503002248.1040791-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502065935.291960-1-irogers@google.com> <20260503002248.1040791-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503002248.1040791-6-irogers@google.com>
Subject: [PATCH v9 05/18] perf print_insn: Use e_machine for fallback IP
 length check
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Avoid string comparisons with perf_env arch, switch to using the more
precise ELF machine.

Sort header files and fix missing definitions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/print_insn.c | 23 ++++++++++++++---------
 tools/perf/util/print_insn.h |  3 +++
 2 files changed, 17 insertions(+), 9 deletions(-)

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
index 07d11af3fc1c..1f2c2f25f973 100644
--- a/tools/perf/util/print_insn.h
+++ b/tools/perf/util/print_insn.h
@@ -5,6 +5,9 @@
 #include <stddef.h>
 #include <stdio.h>
 
+#include <linux/types.h>
+
+struct addr_location;
 struct perf_sample;
 struct thread;
 struct machine;
-- 
2.54.0.545.g6539524ca2-goog

