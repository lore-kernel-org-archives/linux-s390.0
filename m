Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661E03A783D
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 06:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381537; cv=none; b=ZvCu4Hjs8IfQVctupzBgdhx36/2eMVpkzNb1Iy15kTmexyRD0obaPH/hIUbg2E/Z5p7s/KvUkc7tB5A3xvlUqHKvvaEKbxAu4264W12tWUIxTr79XF/2ZMEVTpwU9puceELneKXtRAiY7d+yCZtfneTzhBjuahHC/+A9yfu3eO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381537; c=relaxed/simple;
	bh=bD79XLC74sOKkh5WkeXQ/YhX86xrlFEHMGX/zIPcIz8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U2r87ZVETNC7nqpEA/DLDjzFp2I5uBPx/1gbSB7Znu4xl5hNyV/gUjeyZYumXY9sKlkJzB6pqTodXcyDWRSsbOtbgWlSp30Gm9Ki+tA+lsGSDVjy3AZeqm2YtNGHN0vhWJGwoDTRWSPVSut0gBurID+N7nmu733IsORUJsCDjmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GCqkCG71; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GCqkCG71"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137ea73393cso4578052c88.0
        for <linux-s390@vger.kernel.org>; Mon, 01 Jun 2026 23:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780381535; x=1780986335; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CY84B4INAWbD1Cf/mmc/o03IBqOHUDgX8UA9AM+aba4=;
        b=GCqkCG71POHy89+Z7zMJpvFdoGelCZHpvKghn7LthQ/XMbRKWhF5IQR8tG9j1IzaPv
         uDfdzt5YSzd7nzMsKfwzsfnsMGYXJkeOzYPU2eSAMz1rUG2NJ1ugJ+30kRd2ofHeRyj8
         vwWPbksecnmobwvMrc2pq9WtenNxJL+F0X+C/HHjgHLcsKeLuWHesm+i+j28QwJsyHFi
         /yxK8MdSZUpgyRaQqZM9PAQ5//pQ21mYRkYIcTjfxsADEu0iUSON+2TCWzMyTNQK9agl
         Hk8dPo2NAqeUFBNJTNRavREeFhUOZty9nCV1Zf9D+Q/EdYZhfuP2TYdDQF392BVGRE34
         LVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780381535; x=1780986335;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CY84B4INAWbD1Cf/mmc/o03IBqOHUDgX8UA9AM+aba4=;
        b=T4UTBtX3zSnAopKky3l1hipN497Ft2XNhLlOdwidLBAAmFusZEgq9vJyxKaqbaIkmv
         qQb3khnoY8MMDQTzrGzc4VIvoOTcEcYz+Tf+4wGtSSgWh/LjRQhgJU3hecHYMsEnhwjn
         04pm/gX5vY0EISr4XzApfnfcKJQg1R2hOjhNSOZXMF3IdN32njDYkI4//2JT/2PdN+wd
         UmJV45cz1LgQ1acWDJW10redAAebiaSWfZtH/Xyhg1/Lck57H1o22bwFnxIO7dK0H/fC
         xG1smmEdGQ92/fx2b44+df4RaQKyhF/lf9JjnxxTWjKCugztFitBF3S9GbJ0l1AK4AVI
         eKDA==
X-Forwarded-Encrypted: i=1; AFNElJ8hFG0ohn1WK9PRFefZ7zIKcYxotLilXAiRC7lqZttIf7ObGJhO/HwTxOMnmIlVAEkgiC5hLNovzska@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo8TW1lyi+HXvQW0/bhk/cJhm2UN4soSlREcKGuU37K0b49ORA
	co+jGqpo7DMNLisBH1dwpgIRd4ifrcibNUbH2SwXqgMH0Mf/2n9mlk8eJDjJsXHNkqnnWu080ns
	ekW00iPCL/w==
X-Received: from dlea10-n2.prod.google.com ([2002:a05:701b:420a:20b0:12c:8ccc:748c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:61b:b0:12d:b7e5:a691
 with SMTP id a92af1059eb24-137d4026bcamr6351510c88.7.1780381534349; Mon, 01
 Jun 2026 23:25:34 -0700 (PDT)
Date: Mon,  1 Jun 2026 23:24:44 -0700
In-Reply-To: <20260602062452.2583619-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601065407.1597927-1-irogers@google.com> <20260602062452.2583619-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602062452.2583619-13-irogers@google.com>
Subject: [PATCH v11 12/19] perf c2c: Use perf_env e_machine rather than arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Use the e_machine rather than arch string matching for AARCH64.

Add include of dwarf-regs.h in case the EM_AARCH64 isn't defined, sort
the headers given this include.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-c2c.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 36f386949923..def5ed395f17 100644
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
2.54.0.929.g9b7fa37559-goog

