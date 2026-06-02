Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4E83A7587
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 06:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381535; cv=none; b=aBX1j/b2G8rNdgllF4p1e50Sxvwc+jdZwlAOR0eNTZgIfJxMTnqzUos1n1yYUbcA8hmsgyiZG7VuxI/V4AOdLrIx9L9kTbI/CwvBvWi+/DJyXHlS1er/85pvkQEUNefTPq+iDO0YkAJ6cwTpglK89+NHIafGxTCLswE5xf/LtJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381535; c=relaxed/simple;
	bh=1TN4Off0WzSGb6E8PmC/hd8tjykbHBLDgI/eo85jqRM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O3XGXdMK+hYavbYqjHOJo5iftjk3vv3I/C3t9nzUJRG6uR5LlXvWLk2F53mZOrf8gneJK65997xu5OQonCUfo06RusGrDEooqk2q9bFusb9V4Pg+a7qz5dUZCh/vIYPemb5xE0GweMM7QAYnQOb3aZEBbdIPYXX5uIxkfs2fvQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DRBSAwTT; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DRBSAwTT"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-13709ab38a8so11425430c88.0
        for <linux-s390@vger.kernel.org>; Mon, 01 Jun 2026 23:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780381531; x=1780986331; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gjedQh85bqRmyx/dzkbLSjIKr+my71zFRmku8NoRk3U=;
        b=DRBSAwTTSSzgnOM8NUQtStnr6+h5zNk760t1JLHAwrb7JkEkce94lmCc6PMZdtMN8d
         P3k7pRcOM9/eymuW6pqTb6epZ4eOzY5zkB8iEzDsFdIPDDQQHC+CrR1XtbSAp6UnvJh/
         wzI60k2MUkQaYD5r6Cch8mSyO5sZniL3YQVR8rM5V1w+IRNoWI5FESYkgbBxqUf75GVq
         shyZ8nepWacXb/YyxuYTrQ/gkJZbgjEdqQegzKT6Vp+jpLbAOHXbQ46RXFpkc0qXO2LI
         EnjmOElBr3SXPheYauK69zMXDyAIyUETG7YFDGqFKOs8JoQOyfl1VLfUAGQUGZj1JZ1p
         WRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780381531; x=1780986331;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjedQh85bqRmyx/dzkbLSjIKr+my71zFRmku8NoRk3U=;
        b=iwL9NTssEDEZWrduTI6NHleWrkzO2EPKScIU0nbk4Y1qjy9Eana3zDsQgaZOLBqbHo
         WtNwLU733g8nJARRelFBhOB8gxAAaw/6YcsLW2wCDQsFXy8WSvGHKQOnQy90HNOk6X2Z
         MkcGQ+fOMFA95bFjHrStvpyJ6nakkNh6ySL5v2jYxJjEM8ffqQgEtOJnpAc0WVN5RjO6
         gynih+wdSbnG3rd2A/K1VfXKNzY9haVufjLPEh8l/3Xrs1iS3j/QmqciSj8zY1o6vyIu
         kPk6ZH8H/EyD6Xr7UkKdrLl4Q+jvw0yi8VnZSqnHQ30PeXRCNOuLl9nAaACSc6KH/K35
         X4lw==
X-Forwarded-Encrypted: i=1; AFNElJ93V9/ZDEq/k2cEtWJvGZgP91NuCg2Pc4haw7y/BfHBlw0u56CfCOJYCkhJMwKBpRlbnNM0DB161cVh@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqr8Wqr2Y1aML0bkyJwIoG4k6kL10dHwBsc0dhTg47rCXb/F6t
	uf0kIZLBLCioIvGZbeF/8uPoX/Eb/0zklvatwxrG7T9M3Q2ARh2EpKzhnoxz1yMFakQpVMOHpyh
	pPSAedi80fA==
X-Received: from dlbsj13.prod.google.com ([2002:a05:7022:f90d:b0:137:e5ae:4179])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:382:b0:137:1ae1:bc2e
 with SMTP id a92af1059eb24-137d412f9camr6070348c88.11.1780381530903; Mon, 01
 Jun 2026 23:25:30 -0700 (PDT)
Date: Mon,  1 Jun 2026 23:24:42 -0700
In-Reply-To: <20260602062452.2583619-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601065407.1597927-1-irogers@google.com> <20260602062452.2583619-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602062452.2583619-11-irogers@google.com>
Subject: [PATCH v11 10/19] perf arch common: Use perf_env e_machine rather
 than arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Use the e_machine rather than arch string matching.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/common.c | 92 ++++++++++++++++++++++++++++++----------
 1 file changed, 69 insertions(+), 23 deletions(-)

diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
index ad0cab830a4d..5ad50e331c55 100644
--- a/tools/perf/arch/common.c
+++ b/tools/perf/arch/common.c
@@ -1,13 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "common.h"
+
 #include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+
+#include <linux/zalloc.h>
 #include <unistd.h>
-#include "common.h"
-#include "../util/env.h"
+
+#include <dwarf-regs.h>
+
 #include "../util/debug.h"
-#include <linux/zalloc.h>
+#include "../util/env.h"
 
 static const char *const arc_triplets[] = {
 	"arc-linux-",
@@ -141,11 +146,40 @@ static int lookup_triplets(const char *const *triplets, const char *name)
 	return -1;
 }
 
+static bool is_native_compatible(struct perf_env *env, uint16_t target, uint16_t host)
+{
+	if (target != host) {
+		/* A 64-bit host can natively disassemble its 32-bit compat architecture */
+		if (host == EM_X86_64 && target == EM_386)
+			return true;
+		if (host == EM_AARCH64 && target == EM_ARM)
+			return true;
+		if (host == EM_PPC64 && target == EM_PPC)
+			return true;
+		if (host == EM_SPARCV9 && target == EM_SPARC)
+			return true;
+		return false;
+	}
+
+	/* target == host case */
+	if (target == EM_RISCV) {
+		bool target_is_64 = perf_env__kernel_is_64_bit(env);
+		bool host_is_64 = (sizeof(void *) == 8);
+
+		/* 32-bit host cannot natively disassemble 64-bit target */
+		if (!host_is_64 && target_is_64)
+			return false;
+	}
+
+	return true;
+}
+
 static int perf_env__lookup_binutils_path(struct perf_env *env,
 					  const char *name, char **path)
 {
 	int idx;
-	const char *arch = perf_env__arch(env), *cross_env;
+	uint16_t e_machine = perf_env__e_machine(env, /*e_flags=*/NULL);
+	const char *cross_env;
 	const char *const *path_list;
 	char *buf = NULL;
 
@@ -153,7 +187,7 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
 	 * We don't need to try to find objdump path for native system.
 	 * Just use default binutils path (e.g.: "objdump").
 	 */
-	if (!strcmp(perf_env__arch(NULL), arch))
+	if (is_native_compatible(env, e_machine, EM_HOST))
 		goto out;
 
 	cross_env = getenv("CROSS_COMPILE");
@@ -170,30 +204,42 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
 		zfree(&buf);
 	}
 
-	if (!strcmp(arch, "arc"))
+	switch (e_machine) {
+	case EM_ARC:
 		path_list = arc_triplets;
-	else if (!strcmp(arch, "arm"))
+		break;
+	case EM_ARM:
 		path_list = arm_triplets;
-	else if (!strcmp(arch, "arm64"))
+		break;
+	case EM_AARCH64:
 		path_list = arm64_triplets;
-	else if (!strcmp(arch, "powerpc"))
+		break;
+	case EM_PPC:
+	case EM_PPC64:
 		path_list = powerpc_triplets;
-	else if (!strcmp(arch, "riscv32"))
-		path_list = riscv32_triplets;
-	else if (!strcmp(arch, "riscv64"))
-		path_list = riscv64_triplets;
-	else if (!strcmp(arch, "sh"))
+		break;
+	case EM_RISCV:
+		path_list = perf_env__kernel_is_64_bit(env) ? riscv64_triplets : riscv32_triplets;
+		break;
+	case EM_SH:
 		path_list = sh_triplets;
-	else if (!strcmp(arch, "s390"))
+		break;
+	case EM_S390:
 		path_list = s390_triplets;
-	else if (!strcmp(arch, "sparc"))
+		break;
+	case EM_SPARC:
+	case EM_SPARCV9:
 		path_list = sparc_triplets;
-	else if (!strcmp(arch, "x86"))
+		break;
+	case EM_X86_64:
+	case EM_386:
 		path_list = x86_triplets;
-	else if (!strcmp(arch, "mips"))
+		break;
+	case EM_MIPS:
 		path_list = mips_triplets;
-	else {
-		ui__error("binutils for %s not supported.\n", arch);
+		break;
+	default:
+		ui__error("binutils for %s not supported.\n", perf_env__arch(env));
 		goto out_error;
 	}
 
@@ -202,7 +248,7 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
 		ui__error("Please install %s for %s.\n"
 			  "You can add it to PATH, set CROSS_COMPILE or "
 			  "override the default using --%s.\n",
-			  name, arch, name);
+			  name, perf_env__arch(env), name);
 		goto out_error;
 	}
 
@@ -237,7 +283,7 @@ int perf_env__lookup_objdump(struct perf_env *env, char **path)
  */
 bool perf_env__single_address_space(struct perf_env *env)
 {
-	const char *arch = perf_env__arch(env);
+	uint16_t e_machine = perf_env__e_machine(env, /*e_flags=*/NULL);
 
-	return strcmp(arch, "s390") && strcmp(arch, "sparc");
+	return e_machine != EM_SPARC && e_machine != EM_SPARCV9 && e_machine != EM_S390;
 }
-- 
2.54.0.929.g9b7fa37559-goog

