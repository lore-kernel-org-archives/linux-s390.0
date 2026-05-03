Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BC71C5F13
	for <linux-s390@vger.kernel.org>; Sun,  3 May 2026 00:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777767799; cv=none; b=BiVnmuSIZ56osYjmKOnqhFW4bqcLPxXLPlIbOBtb0LcVqkXJPGK/j/ItwZhRk0jQ/bShmU8ii0Mf3RmxIYT82fEFkNqNOcDmB6owQuOuS65IpbcSx9Ig7tKv3vcGdADvXjicyV0yqY2RVg7hjx83oR+koSzCekGeaC5ts6l7ffU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777767799; c=relaxed/simple;
	bh=eqeOWxhFyM7dwpKHN7IomuaifDbDMcmVmoxsj1Wk+h4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hSh9nxcRnv4d4GJifAoE4OCPgJO/Xwgm9fAoYMqj4rxVHsMB9figykGjvNle8zLbnjJWW74LffKqTMHWE0Z/CH+Ay/Sr+k9SdYoExCDLIGln3ljFsvnuLLtvVfWQnTSLw6ntiRpAXFyHCD347igHlzg+C19e37Ggdxa21y1Rd+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MnQwJBGM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MnQwJBGM"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-362d9dd9a49so3223666a91.0
        for <linux-s390@vger.kernel.org>; Sat, 02 May 2026 17:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777767793; x=1778372593; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c1UEnrZj6LrH1rbpoINuKLPntj2HeRkp2Oo3eKcuhyg=;
        b=MnQwJBGMQvLqOqZAAAcfIYDJzayjknxvLK9qFRqRLKqAOOxTsrDUio9iQ+Adf94QDX
         zrSL8BWOWFGW+SdtDyOeuCETL+la2t81drwRCNKP+YI2TpuopIO81gC59HbH8qgP4st1
         E0A+yAz4utkeeL+6mLepZkpl9LRhKPBJ6ESn1BoOuJhxSQvFkYowclCldTvRr9sykBTf
         GhNwNRR2/JihhEoDztcxeVIBcDUQc4vZ6CAudiTTmE3RgkRBEuFyQtVqg9fUUVneb7cT
         99WCVpoCv01WgBLho1WQ3eRa4fQdKBnzs6XBux348ynARRn2xTfbib7wlGEQMeUU5YRh
         s8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777767793; x=1778372593;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1UEnrZj6LrH1rbpoINuKLPntj2HeRkp2Oo3eKcuhyg=;
        b=mt26hc7Ja6PhhYHMgqv3h6+PSdytxilU+8gXNJvK7sn8XAV60NYtYYvsOcbPULN3Yy
         I/6J3/D8aS8pQiiNuOzc7omcGDMs/JDuVfgxzECRuApc7VV0I/APbec1e0UcdhUmLweS
         Lp1I231YFvQe10/7PZ+vvEGlBqs/BF0OiyJDk3i8PzS86E611sQKmvONGTcAxVhHn+UW
         C0/S6a38xAhB5IVKbRmgVWKhVJgZxQRkz3JKJTqwIw/P0zaswPWwR6BP5B5rWYWr+ByU
         8/X/prLaJGyXtzjFTFai9XMoMFYDNV9CoPKwV4LjcKzthItLxfs/y3ScQ+/uupr1VLWW
         b//w==
X-Forwarded-Encrypted: i=1; AFNElJ8zAljqzL3PtLuYxbWVexPopdQVrHTSflkwFyEt1GEu9zUXUvqyk37JpHoFCGv/R/r+8/msV2FvyaDn@vger.kernel.org
X-Gm-Message-State: AOJu0YxbhR5BDj82b4sOWuW73VsCDopplrX5qjjNjgkOUgo4kSBLPZih
	T/yltVeiTX+rN3vYFSEfOQ1+w4hoktTdA14PxoFnGiJNL047sV0d5Sekaf6LseZ/25hfj5y9WZK
	jKZQBg8sABQ==
X-Received: from pjbmg18.prod.google.com ([2002:a17:90b:3712:b0:362:ba47:7b37])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b0e:b0:35f:bd51:cf60
 with SMTP id 98e67ed59e1d1-3650cd7115fmr4357446a91.1.1777767792718; Sat, 02
 May 2026 17:23:12 -0700 (PDT)
Date: Sat,  2 May 2026 17:22:40 -0700
In-Reply-To: <20260503002248.1040791-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502065935.291960-1-irogers@google.com> <20260503002248.1040791-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503002248.1040791-11-irogers@google.com>
Subject: [PATCH v9 10/18] perf arch common: Use perf_env e_machine rather than arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Use the e_machine rather than arch string matching.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/common.c | 62 ++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
index 21836f70f231..1d8aff9b32d6 100644
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
@@ -145,7 +150,8 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
 					  const char *name, char **path)
 {
 	int idx;
-	const char *arch = perf_env__arch(env), *cross_env;
+	uint16_t e_machine = perf_env__e_machine(env, /*e_flags=*/NULL);
+	const char *cross_env;
 	const char *const *path_list;
 	char *buf = NULL;
 
@@ -153,7 +159,7 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
 	 * We don't need to try to find objdump path for native system.
 	 * Just use default binutils path (e.g.: "objdump").
 	 */
-	if (!strcmp(perf_env__arch(NULL), arch))
+	if (e_machine == EM_HOST)
 		goto out;
 
 	cross_env = getenv("CROSS_COMPILE");
@@ -170,30 +176,42 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
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
 
@@ -202,7 +220,7 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
 		ui__error("Please install %s for %s.\n"
 			  "You can add it to PATH, set CROSS_COMPILE or "
 			  "override the default using --%s.\n",
-			  name, arch, name);
+			  name, perf_env__arch(env), name);
 		goto out_error;
 	}
 
@@ -237,5 +255,5 @@ int perf_env__lookup_objdump(struct perf_env *env, char **path)
  */
 bool perf_env__single_address_space(struct perf_env *env)
 {
-	return strcmp(perf_env__arch(env), "sparc");
+	return perf_env__e_machine(env, /*e_flags=*/NULL) != EM_SPARCV9;
 }
-- 
2.54.0.545.g6539524ca2-goog

