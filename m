Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF7386575
	for <linux-s390@vger.kernel.org>; Mon,  1 Jun 2026 06:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296879; cv=none; b=D/oNaqQptiUSre6OO13Y1Q6MQtd/ELxNOkUCRffih5epMef0e0wrhhZF8NR8ZDtbJObC47kJnNoUJT4T+LKEPcP8hphcrP923nFmT7Im+HQE3GEnLPvWDVK+RihiVgyZqcZJe7hbg+JUQhEBIndgb0pyNWlEih8Fg9vQbu/sknw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296879; c=relaxed/simple;
	bh=ZS+PuPcuxfpypEg7CyiU1rjR7Jy+Z+y6peaFHU7xaDg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qFx/84Oay1yo49hwWEkI8/H66qKcmMXUyKVU/qn6PWznR5iR6YnqcGNlD5tTIgQZPLHrko0wlmaxMYuLt4nK8zs8U1EwnwZ2OysbJyFLDjhCfIf/9wpbAPCbLYFjiJYRKirNXHXmne1eWoh0bON4LqCrZZxSfedP35iZB3uLlQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mvah0QIC; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mvah0QIC"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304d8613efbso4352025eec.1
        for <linux-s390@vger.kernel.org>; Sun, 31 May 2026 23:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780296877; x=1780901677; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rVM9lLh1LoUGa3yn0TIFcsOtKqCsDpL9U10ydZo9Txk=;
        b=mvah0QICuzN63pcUJ8lLVRWbbzkn9hQZdAcMt24rGXPQpRm/DHlE4gEqtt+mu9FUfb
         lC1WN4fVdTXI51AWhZp7mNA+gm5CNV+GwinmQApyZe/qcDrzDALOqtEtlTBQ3cdiJLcP
         fl4LS9DClyMBEFEw4U9q3+iKGzl0Nkhk4mrBI58wGYz1LcErUtp1DqPLOWKEFbNxwWxX
         LQWDJD32gTDs/Mhm5w9mTTRGMTOTcwqlkdsYb+4YgfuM63ZrHsBc+pdMdgjWg0q1/b6i
         Kl+tdSZdWQFwplxAGajzTt8Hct70MsPPO+iWFZzSxWqUAQJ3fikdoscUz3Zpj/75sAfC
         FK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780296877; x=1780901677;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rVM9lLh1LoUGa3yn0TIFcsOtKqCsDpL9U10ydZo9Txk=;
        b=TFfnFilra1x0d7zkGp0PnnFdPrNRJ0BkvCjUIR+5L/9P+WGf+fuTzuovF4qtDCQyNl
         QWs1tfzEKq7Zpl7Mno3DpqmK63rOTiMpwEK60Dy5QC/vFyK6NA99vdjpqYmhN4KzqT5n
         goYzstkTf2thFs4TmhQ5fW11Devw8gB4Qc6vhP+3jctOE9g2BRD1f6pSvkUwzrPTApzA
         vEPFMgLMJHtZaxzOSTam6KUyyWS5A27PBTsSWGjEcjK+I8kR/A/iroSvbenqZoOx8eD0
         UTVqM7VtoZLFFoyEBS8g8kVzCfTaeKMl9FJ5I6z0IE/AfOhqH45irpGm3Db2Vqgip4/4
         JfIA==
X-Forwarded-Encrypted: i=1; AFNElJ+FJzyhvvI5mGy3H8OB3VCm31pFJm+uZzLqvYeElJP9J6IEQIsY9IEYDiD9Z1oBSkBqJb6enF6r8II+@vger.kernel.org
X-Gm-Message-State: AOJu0YyItTW5kgmsZ89p93p8m6ieNKLUCEl4B5p9LGElpyEuSOnH2NNL
	XsNK21sXdwJ8txScdXcQLHkg/KbkHE0p9KCwGku8g6AGmBw1G3f35AbgFASUMS0P8qq9hOBy1FC
	7Aricmxuoeg==
X-Received: from dyaf2-n1.prod.google.com ([2002:a05:693c:8382:10b0:304:dfee:3633])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:ef83:b0:2de:2f38:a7cb
 with SMTP id 5a478bee46e88-304fa64c547mr3992863eec.18.1780296877117; Sun, 31
 May 2026 23:54:37 -0700 (PDT)
Date: Sun, 31 May 2026 23:54:01 -0700
In-Reply-To: <20260601065407.1597927-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503002248.1040791-1-irogers@google.com> <20260601065407.1597927-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601065407.1597927-13-irogers@google.com>
Subject: [PATCH v10 12/18] perf c2c: Use perf_env e_machine rather than arch
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
2.54.0.823.g6e5bcc1fc9-goog

