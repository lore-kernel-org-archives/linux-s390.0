Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23E51FF7C8
	for <linux-s390@vger.kernel.org>; Sun,  3 May 2026 00:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777767797; cv=none; b=Dg8mI15f2Xe4pKzF99OQi0nMJP6szJ7MBnZ3g0zSki0iRC/Q1F3DH6qlY8lHdHDWSmESPo38cMU66dE6DOr6+k0gEmnyLpRi1qPfUG6hORaSGKhG9cpJWEreKzwOfRwoq2LKCVmzYzG3jRGs/CU9JIzk2ASEEDvplGhMyeqQLZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777767797; c=relaxed/simple;
	bh=3YxL5VzE6bHl3FdRH/Jn9cIz8yFva46ZW763ff/pUc0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CRmWmCGhNaIu0PT9quUKNyj5Yj/AVEXdsTyXURljKQzPLZS9BOzkZOBC2YtlboFNY3Cnx8AIWPg/8yVY24biY8h0e55PTz6b7WKhnQxBQukY5jabw2sfDLV/WHxkjO6t8gAUhMYwpDizf+lcCozAqx8bqEjBCuAt9jixHdskcrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dLJHpHro; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dLJHpHro"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12df8bc580cso1255615c88.0
        for <linux-s390@vger.kernel.org>; Sat, 02 May 2026 17:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777767791; x=1778372591; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/6FeuxlGm3VrKdgs8XUfTlIan59NM0soqe95RHdyhTY=;
        b=dLJHpHroKqVd5fnvGBI+1fe5sA9FFPEbsYNby1D0Nr44ta/8F+fpw8aBr1vkRPu7rR
         Wr4gcy9EERlCVeKjAmrg0k8AVeshXAC/IQKMOehRCvCdY0A/G3dcJ42Ph7scPzqiTxKv
         3JcOtDUw+Yg4ZwVCmqJ19myvKoiWzGNXB/Eq723nJobwyPkw9PYFDxrQ4hqhqbrakVyQ
         5Am0P19M2cPZAZCQPjH+35hXHVIzf5BnQWJvYN7H5Ei3OhrfSvBLXgdm79mK9B+/vFKy
         ePpv4rQ4rrO0TyCO8AVJ9PUqN2T/SrZRM9cY1BgU5kkTofKaq1SBQGsDRPMdsAkXO0/j
         4HDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777767791; x=1778372591;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6FeuxlGm3VrKdgs8XUfTlIan59NM0soqe95RHdyhTY=;
        b=iv+a2DZPjb7R5pCIIEQ0/ZsDr2sBd+SUOyh2QeIPLyZLMukNPH/mhqTpwP4BoMeBEn
         xR8QqwDGhxXqT5kxcSXtZWXd7zSeaEdr7pH66U/7e6td09LEMTPpSJd9Y0MEGmiNtEY5
         e74jJs8sd/rE873xfEl+Hwzj2xZbRo14p73ZTsNOFWlEAJwpK3hU6ZOu9GwqdOZoTMdL
         Nliej1CHouGdiL0czhjscDQed/V/v1ajkkwOzJvbnmTsKEFOq11ap5uj0hQChX97cC9v
         pWyWPhR2cf0MeC7KWhrX4lITbe56DCs7t1lii1GM6hOCs7UcNr8QcErcsWYDuYwkeKVb
         GN1g==
X-Forwarded-Encrypted: i=1; AFNElJ9CrV4P6RpnHVu2N4RrYg2ucpqThKHb0Qrs9q8HOV7OCKB3e+pa5cdRmPEz8sm2vY1j0/iI3w/lxwPK@vger.kernel.org
X-Gm-Message-State: AOJu0Yze8aFtZascf2o9itn8T4Sn3V9xghdU3l4ekecqQmwuH1gkvAJT
	BANIpyHxVpwdljpub1PxswCrK0I+WKE7K3bSSQHo3oiNvjs+jnoZAV1FhEtOGzd5cv67wAdQnLJ
	U/Fm9OO1VAg==
X-Received: from dyib18.prod.google.com ([2002:a05:7300:79d2:b0:2d9:3c6b:a26b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:203:b0:12c:9037:5126
 with SMTP id a92af1059eb24-12dec61125amr5551297c88.9.1777767790824; Sat, 02
 May 2026 17:23:10 -0700 (PDT)
Date: Sat,  2 May 2026 17:22:39 -0700
In-Reply-To: <20260503002248.1040791-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502065935.291960-1-irogers@google.com> <20260503002248.1040791-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503002248.1040791-10-irogers@google.com>
Subject: [PATCH v9 09/18] perf sort: Use perf_env e_machine rather than arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Use the e_machine rather than the arch to determine x86 or PPC types.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/sort.c | 58 +++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 0020089cb13c..90bc4a31bb55 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1,40 +1,45 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "sort.h"
+
 #include <ctype.h>
 #include <errno.h>
 #include <inttypes.h>
-#include <regex.h>
 #include <stdlib.h>
+
+#include <elf.h>
+#include <linux/kernel.h>
 #include <linux/mman.h>
+#include <linux/string.h>
 #include <linux/time64.h>
+
+#include <regex.h>
+
+#include "annotate-data.h"
+#include "annotate.h"
+#include "branch.h"
+#include "cacheline.h"
+#include "cgroup.h"
+#include "comm.h"
 #include "debug.h"
 #include "dso.h"
-#include "sort.h"
+#include "event.h"
+#include "evlist.h"
+#include "evsel.h"
 #include "hist.h"
-#include "cacheline.h"
-#include "comm.h"
+#include "machine.h"
 #include "map.h"
-#include "maps.h"
-#include "symbol.h"
 #include "map_symbol.h"
-#include "branch.h"
-#include "thread.h"
-#include "evsel.h"
-#include "evlist.h"
-#include "srcline.h"
-#include "strlist.h"
-#include "strbuf.h"
+#include "maps.h"
 #include "mem-events.h"
 #include "mem-info.h"
-#include "annotate.h"
-#include "annotate-data.h"
-#include "event.h"
-#include "time-utils.h"
-#include "cgroup.h"
-#include "machine.h"
 #include "session.h"
+#include "srcline.h"
+#include "strbuf.h"
+#include "strlist.h"
+#include "symbol.h"
+#include "thread.h"
+#include "time-utils.h"
 #include "trace-event.h"
-#include <linux/kernel.h>
-#include <linux/string.h>
 
 #ifdef HAVE_LIBTRACEEVENT
 #include <event-parse.h>
@@ -2673,9 +2678,10 @@ struct sort_dimension {
 
 static int arch_support_sort_key(const char *sort_key, struct perf_env *env)
 {
-	const char *arch = perf_env__arch(env);
+	uint16_t e_machine = perf_env__e_machine(env, /*e_eflags=*/NULL);
 
-	if (!strcmp("x86", arch) || !strcmp("powerpc", arch)) {
+	if (e_machine == EM_X86_64 || e_machine == EM_386 || e_machine == EM_PPC64 ||
+	    e_machine == EM_PPC) {
 		if (!strcmp(sort_key, "p_stage_cyc"))
 			return 1;
 		if (!strcmp(sort_key, "local_p_stage_cyc"))
@@ -2686,14 +2692,14 @@ static int arch_support_sort_key(const char *sort_key, struct perf_env *env)
 
 static const char *arch_perf_header_entry(const char *se_header, struct perf_env *env)
 {
-	const char *arch = perf_env__arch(env);
+	uint16_t e_machine = perf_env__e_machine(env, /*e_eflags=*/NULL);
 
-	if (!strcmp("x86", arch)) {
+	if (e_machine == EM_X86_64 || e_machine == EM_386) {
 		if (!strcmp(se_header, "Local Pipeline Stage Cycle"))
 			return "Local Retire Latency";
 		else if (!strcmp(se_header, "Pipeline Stage Cycle"))
 			return "Retire Latency";
-	} else if (!strcmp("powerpc", arch)) {
+	} else if (e_machine == EM_PPC64 || e_machine == EM_PPC) {
 		if (!strcmp(se_header, "Local INSTR Latency"))
 			return "Finish Cyc";
 		else if (!strcmp(se_header, "INSTR Latency"))
-- 
2.54.0.545.g6539524ca2-goog

