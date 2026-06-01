Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3485383C89
	for <linux-s390@vger.kernel.org>; Mon,  1 Jun 2026 06:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296875; cv=none; b=AI8kdFwEQWSAlUDugdFUDy3JMdbDFtzsUVM5hcv1fpSpCWxR7+zcyJ1ItdPb+u2xsW0fdfhIqrTQaxYixaX+GFWv33OTnUGLxmaQU6mgLZ+85jbhu8cl1GeC5x78l4sXLIpPUFXOGwsNpOkEiHz9gm7sFTX9vACM8KQTqttkRRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296875; c=relaxed/simple;
	bh=paAhGMuVcFCJawkYRHI1yb+PMES60j9yTRYSD8knZOU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rKHksM1eotTGUHjG3xQZJHhs0WgFL5oiQoz52iFHrNbBvdanV56XP4SEp0e0z8D5vTdovI0hyU8WRR4eK8bpgzyFdM1V5GOp6DPp33c0xuNPbuHNubl9p7nRchjcz14S/du2zVo+n0uciiwsouJFdeHdAkJ0wi7gruH0pbL6sws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DLOlB3aC; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DLOlB3aC"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-135916eefa0so13425980c88.1
        for <linux-s390@vger.kernel.org>; Sun, 31 May 2026 23:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780296873; x=1780901673; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=stvvHCX8qouUxL2lu5v4L2Thox3XkwMaO5uo38gU10I=;
        b=DLOlB3aCpDWRfmFK/zRCT7ik4CXnc64mjK9KiPVXN49T7rZeIJbOSDgIPUu+QpGBtn
         Tnd/Smmeg/WMwYZmRyGU764GOl4yPNro2eKFietI75gOmLZW+v9SL3+nGTJQtE0JAOu3
         5vbeHFw2C3AJ+StFwaBhdMgiB1jyqOGeZJn3YdjxG891a1WKWvuVo5wAzgqVCGcUSyo9
         h66NavW7Mtb+exYbwz/lQLbdr0jSgUQyF4PXneumhA/l18g5VT2x1iIALX6/ORskZ328
         Yf1Ol8Y1fWDiSJEtIra6ZO4vneRQldPwC+Dfh7RtXBe0lssO/qdU37lmPnmrCJCTD6HA
         +FmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780296873; x=1780901673;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=stvvHCX8qouUxL2lu5v4L2Thox3XkwMaO5uo38gU10I=;
        b=fTJpBYOgeyJWbR4xL00ZWnboVJMSHpfjKSNi8AmmjKQ1/8xLXVnprBPDLs/bu09Cjc
         lvydsZxq5nC0hiv3EGGPXKoJSRrVo67FGG55hkiPw5iQCwZoCXuUzRfa8aNw4LpyepOX
         JsHkS3dR5OQqxdpWQ3AH1Hwut/ImfIObVuOO6VIhjjtwPNvUpPeN/97FE8VcCMy7aCAe
         luMNqI8Za/TMVHAC+JCHk23LeRSummpQyMI9DtZm61l/oOKSei8oSdbafisIHzktpjKB
         6/w6zhgePTMBc6Y7lN+gRiqwPgVuUwnQRJQblsUQL6BYzTr671LzrI5jqJ77IW+rv3oY
         Y4tw==
X-Forwarded-Encrypted: i=1; AFNElJ/jqTtA0Ee1MYcjEFOAYxG7K449BeYFIn3lboWMrF42LNEs/8ezSJ9/tLs4eDWXR4yGTL2UUrdbHt+9@vger.kernel.org
X-Gm-Message-State: AOJu0YyhTXK9lJuQK2m6egBJ9XtSCwWpf6ctqiY/lZUEfR6EP6ib19Ww
	50JCElmYEzj32Ne0y7csnURSZvsb0gmoYIkMqOJs1Nl/Q8wD2mNNMb9B7C70YLm5fX1JGcpCIET
	N7owRLhOM9w==
X-Received: from dlea3-n2.prod.google.com ([2002:a05:701b:4203:20b0:135:dd6a:be57])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:41:b0:135:608a:2864
 with SMTP id a92af1059eb24-137d42494e3mr4069314c88.33.1780296872813; Sun, 31
 May 2026 23:54:32 -0700 (PDT)
Date: Sun, 31 May 2026 23:53:59 -0700
In-Reply-To: <20260601065407.1597927-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503002248.1040791-1-irogers@google.com> <20260601065407.1597927-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601065407.1597927-11-irogers@google.com>
Subject: [PATCH v10 10/18] perf arch common: Use perf_env e_machine rather
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
index ad0cab830a4d..805a15ed99bc 100644
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
+	return e_machine != EM_SPARC && e_machine != EM_SPARCV9;
 }
-- 
2.54.0.823.g6e5bcc1fc9-goog

