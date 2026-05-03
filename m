Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB2914884C
	for <linux-s390@vger.kernel.org>; Sun,  3 May 2026 00:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777767799; cv=none; b=CxJPNYmJCXM1iF4OZW5qZA/sazRWXZxE6sXs/pqkCy1zNzZK7mdpTAUl7UmjSa0S51xdFiK7kJa7BNkPl+zFgOt4IlRu5JjIlbdzYuDtFBXHvd4QrRIplnOYBb/SE0YICTJRZ7NFHYI1a7T0nLwiqJA1qcPzFj/audd7r/kQgzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777767799; c=relaxed/simple;
	bh=d95RN7/rMJzrpe1UoXLER23VbQTmBzaPGsXRYVYoWgg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t/PS7u/JEuE86LtMxcRyC8Zd8WEf+lLHiYgvJg7l2VcZfY0IQCuyUxWABge213Ae2f4qay59KXVUVJNUjTMMLXvZ/fUMute063tonrBMx0TRyA8MFmG1IdZVPc9T6ySaZ1O1UT2697kW3cvcTkjUPEZstYVdh/kFmKMM6gmCnLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LTe7jf/1; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LTe7jf/1"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c8ccc7593so2441567c88.1
        for <linux-s390@vger.kernel.org>; Sat, 02 May 2026 17:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777767797; x=1778372597; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=22j8DoF2fXHm+jGHFBjOBjrvQEypyYf+IRlyHBjQD5I=;
        b=LTe7jf/1QwwTcq36henFTWK9JftSDZjimq6F8m7MIncX1q3HEUR70vzMv5CVFzqMMU
         KBx2XUBi+ooEB7mCnWbG0697ntMEDAmrnyVMFSlQRAuGMN+Zb7gcB31bPHVm2lDdANDk
         OZQsrUbFI+SJUXco1EW35iKy/iOThveGvvuP1VinxIxigTyHm0pRdsGq812TvrBKb7HL
         m1Ye1H+6bK8KWVHkOxnEQWJYQZ4b0fJDsMam1paea6b2EtnL8Y8j5pEdAQtvSynqWvXL
         GCHt4T01oC9DfJ5ISfs6nyyo2RO+J/UJX6FcMGwq7NFq9X+2agHZXq0YvRhymsYy4Yqu
         ttWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777767797; x=1778372597;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22j8DoF2fXHm+jGHFBjOBjrvQEypyYf+IRlyHBjQD5I=;
        b=LKI6aCC94DsNeDeV58jX3M1NRwQG6ZP03Gj4P2609k17ANCfuzkm1Df/dsdnxb9UFW
         YIaah6ir0AEcNUTXj1VhGnfYx5eyPtX6vx6n8oFTCiLu2gPIXEhsg5ZYIa/gjMU5me94
         GakGr4ARKHFYj8RIaLPaMmrN4vl5mx2yGAvQMdAohvwwWVFA8XjWNMz3e9fQtURtLXDA
         Xc/BrtJsqT7MS/4hV3ub8I0gECxG4Gj3JV8VqZkOTB20tZentS1wy3KLjTmT87vnw9kp
         uH3hxxMQSrkd7ycqUZYVtahcrpDBNU7Jym0nkRcwJrbE4rUxay8UnK/7n1Maq9QqV/Nn
         bUxw==
X-Forwarded-Encrypted: i=1; AFNElJ9kshThxrdAjkM6Elwf2h4vtHXDMT/S/r+3orqHp53bLVAhFafO5MyfqZuOE8cQOr1k1tT/zD4NmMXc@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7fi74BSyHo439LXn5yY3jKrDQMNrCwtpi0vEtWnv8NMQJyNbx
	UDM6onHIbyxJH/mtj+meOy3Ph+DsC+daHVaMf5xaeptCHbCb64CofQzrESQX6lrkx0F+lpAW/Ru
	ueSjk6JwS4w==
X-Received: from dll26.prod.google.com ([2002:a05:7022:21a:b0:12d:b48e:8597])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:68a1:b0:128:dcbd:e27c
 with SMTP id a92af1059eb24-12dfd823241mr2253597c88.20.1777767796555; Sat, 02
 May 2026 17:23:16 -0700 (PDT)
Date: Sat,  2 May 2026 17:22:42 -0700
In-Reply-To: <20260503002248.1040791-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502065935.291960-1-irogers@google.com> <20260503002248.1040791-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503002248.1040791-13-irogers@google.com>
Subject: [PATCH v9 12/18] perf c2c: Use perf_env e_machine rather than arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Use the e_machine rather than arch string matching for AARCH64.

Add include of dwarf-regs.h in case the EM_AARCH64 isn't defined, sort
the headers given this include.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-c2c.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 72a7802775ee..c55cab53531b 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -12,41 +12,45 @@
  */
 #include <errno.h>
 #include <inttypes.h>
+
+#include <asm/bug.h>
 #include <linux/compiler.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/stringify.h>
 #include <linux/zalloc.h>
-#include <asm/bug.h>
 #include <sys/param.h>
-#include "debug.h"
-#include "builtin.h"
+
+#include <dwarf-regs.h>
 #include <perf/cpumap.h>
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
-#include "map_symbol.h"
-#include "mem-events.h"
-#include "session.h"
-#include "hist.h"
-#include "sort.h"
-#include "tool.h"
+
+#include "builtin.h"
 #include "cacheline.h"
 #include "data.h"
+#include "debug.h"
 #include "event.h"
 #include "evlist.h"
 #include "evsel.h"
-#include "ui/browsers/hists.h"
-#include "thread.h"
-#include "mem2node.h"
+#include "hist.h"
+#include "map_symbol.h"
+#include "mem-events.h"
 #include "mem-info.h"
-#include "symbol.h"
-#include "ui/ui.h"
-#include "ui/progress.h"
+#include "mem2node.h"
 #include "pmus.h"
+#include "session.h"
+#include "sort.h"
 #include "string2.h"
-#include "util/util.h"
-#include "util/symbol.h"
+#include "symbol.h"
+#include "thread.h"
+#include "tool.h"
+#include "ui/browsers/hists.h"
+#include "ui/progress.h"
+#include "ui/ui.h"
 #include "util/annotate.h"
+#include "util/symbol.h"
+#include "util/util.h"
 
 struct c2c_hists {
 	struct hists		hists;
@@ -3202,7 +3206,7 @@ static int perf_c2c__report(int argc, const char **argv)
 	 * default display type.
 	 */
 	if (!display) {
-		if (!strcmp(perf_env__arch(env), "arm64"))
+		if (perf_env__e_machine(env, /*e_flags=*/NULL) == EM_AARCH64)
 			display = "peer";
 		else
 			display = "tot";
-- 
2.54.0.545.g6539524ca2-goog

