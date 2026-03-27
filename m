Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9A436C0BA
	for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 04:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774587040; cv=none; b=uPZvwBITIjxfilDjElBjY0Qh2qJeu3k0gIbF8bDwXMJ7CGXomaCnvMnsuCmrC5fVleuL3e0gGsXNoqCy1OtE1k2i/HbPdV9HB9l89sEqcMN9MvubT5Osd1ot61++vGXu+OGfEZrNN2BFseOXctBYTzXYHilBETOUfzcLb6nlshg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774587040; c=relaxed/simple;
	bh=uxlEApcoFt3zoagTt4W9dkYrIKl7vQczKfyJY/2/YdM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n3RC6TLZNxKck3wu7HwfKPCp9buE2V/XeIwyxJByO84JhwqaHxIVCvZx3AeVCbYK6vubBOcsvhW5dMHA9CPggpxoUpd1A3+8MwguF5BLP2Zqnls7JoLyDwjFqk19wLiMan9NMiLMjwc4lu5n4cGrfAa/bctXrqt6rAWrlRoHLmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CyhCju7M; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CyhCju7M"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso1468519eec.0
        for <linux-s390@vger.kernel.org>; Thu, 26 Mar 2026 21:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774587038; x=1775191838; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IGyUKvzRwcUnG4/Npnp/POwUnKzsH4cjggqTcUHOoLQ=;
        b=CyhCju7MVvxPRxfRlEF54EmYfqbqoUAQk7n+CtBSEkJhvoFLnRbZMomoEmnQQaFDOp
         piCo2nTURkP70CNxWmPUY+1DnNloqhTQqNSEnXE3EvNwsaJTc2oBdk7aw7//KclSMCXt
         IR7iF60jmF3KfIyQP/1k6NEjnbFgOJyuw8fVIFZQCz4gvV6O9Rn3FdOrA/CEvUGwp3o+
         2wDoGKJI8K3uhmYpHkcms9bvqsoCMrvJ9y8cc92LZVzvYvlPhcly9Ybo0ChssnVlo8yw
         VDnymFzdclq0CprvEjQjjS7RyoScsJBsWaQkpMYRt+9Apl4DtkKGgZqOq+ndgyFUuyk+
         o6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774587038; x=1775191838;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGyUKvzRwcUnG4/Npnp/POwUnKzsH4cjggqTcUHOoLQ=;
        b=eqvURECrY1r8qMl/y1rytJR6f8PQ1EzLfaTYoG8bdHbuLtkBniCWcaewzpRHDmAyue
         WIYbqo9xlUdIeRT3jG9RvJsxj9fjGZpfGBN69qm/k8YNzaRQbDlU8CX0VLz/+rsylSmK
         3tRNL25J2xJiYu2A2USH9ROp6pc0hVHVUN9tBAYa8879Jan2gCsKDKaWxHVskBGWO3f6
         uizCf0juQhoaAp4frhXpWjoTyK8cJqCx2jy55f1amWGY2GqJIzulAyhYHu9CB6sJY/d0
         JM4TS0KI3XO0arzbikGSa4gURmijBnbBdpbCJVwmnTO/ZLjePemmdtNbWHAfM4MWK0PV
         CgzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRCCata09nilS+a/zCghvBMGF+OjLGfmsfs/UDpK5/j2+waJlYzDtxMU+1N27L4Gu5z6bowgdo7AVh@vger.kernel.org
X-Gm-Message-State: AOJu0YwLVP9H67q5wF9hhSIujnv5z9w6yh+CPi9fCbJg3GaH5izUAOrM
	oIFqs2SI7b6VylCH7V/JUsilAnWTh3A+fUxM/XBJphVpCYBwJgPHrzp+i1YSvPE/lNXs2PK/FLI
	GT97cnImFrg==
X-Received: from dybsi15.prod.google.com ([2002:a05:7301:488f:b0:2c1:e58:5b95])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:129b:b0:2c0:be45:6811
 with SMTP id 5a478bee46e88-2c185f9710emr544942eec.32.1774587037692; Thu, 26
 Mar 2026 21:50:37 -0700 (PDT)
Date: Thu, 26 Mar 2026 21:50:24 -0700
In-Reply-To: <20260327045025.2276517-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326174521.1829203-1-irogers@google.com> <20260327045025.2276517-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260327045025.2276517-2-irogers@google.com>
Subject: [PATCH v4 1/2] perf env: Add perf_env__e_machine helper and use in perf_env__arch
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: irogers@google.com, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, jameshongleiwang@126.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Add a helper that lazily computes the e_machine and falls back of
EM_HOST. Use the perf_env's arch to compute the e_machine if
available. Use a binary search for some efficiency in this, but handle
somewhat complex duplicate rules. Switch perf_env__arch to be derived
the e_machine for consistency. This switches arch from being uname
derived to matching that of the perf binary (via EM_HOST). Update
session to use the helper, which may mean using EM_HOST when no
threads are available. This also updates the perf data file header
that gets the e_machine/e_flags from the session.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/env.c     | 185 ++++++++++++++++++++++++++++++--------
 tools/perf/util/env.h     |   1 +
 tools/perf/util/session.c |  14 +--
 3 files changed, 157 insertions(+), 43 deletions(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 93d475a80f14..ae08178870d7 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -1,10 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "cpumap.h"
+#include "dwarf-regs.h"
 #include "debug.h"
 #include "env.h"
 #include "util/header.h"
 #include "util/rwsem.h"
 #include <linux/compiler.h>
+#include <linux/kernel.h>
 #include <linux/ctype.h>
 #include <linux/rbtree.h>
 #include <linux/string.h>
@@ -588,51 +590,160 @@ void cpu_cache_level__free(struct cpu_cache_level *cache)
 	zfree(&cache->size);
 }
 
+struct arch_to_e_machine {
+	const char *prefix;
+	uint16_t e_machine;
+};
+
 /*
- * Return architecture name in a normalized form.
- * The conversion logic comes from the Makefile.
+ * A mapping from an arch prefix string to an ELF machine that can be used in a
+ * bsearch. Some arch prefixes are shared an need additional processing as
+ * marked next to the architecture. The prefixes handle both perf's architecture
+ * naming and those from uname.
  */
-static const char *normalize_arch(char *arch)
-{
-	if (!strcmp(arch, "x86_64"))
-		return "x86";
-	if (arch[0] == 'i' && arch[2] == '8' && arch[3] == '6')
-		return "x86";
-	if (!strcmp(arch, "sun4u") || !strncmp(arch, "sparc", 5))
-		return "sparc";
-	if (!strncmp(arch, "aarch64", 7) || !strncmp(arch, "arm64", 5))
-		return "arm64";
-	if (!strncmp(arch, "arm", 3) || !strcmp(arch, "sa110"))
-		return "arm";
-	if (!strncmp(arch, "s390", 4))
-		return "s390";
-	if (!strncmp(arch, "parisc", 6))
-		return "parisc";
-	if (!strncmp(arch, "powerpc", 7) || !strncmp(arch, "ppc", 3))
-		return "powerpc";
-	if (!strncmp(arch, "mips", 4))
-		return "mips";
-	if (!strncmp(arch, "sh", 2) && isdigit(arch[2]))
-		return "sh";
-	if (!strncmp(arch, "loongarch", 9))
-		return "loongarch";
-
-	return arch;
+static const struct arch_to_e_machine prefix_to_e_machine[] = {
+	{"aarch64", EM_AARCH64},
+	{"alpha", EM_ALPHA},
+	{"arc", EM_ARC},
+	{"arm", EM_ARM}, /* Check also for EM_AARCH64. */
+	{"avr", EM_AVR},  /* Check also for EM_AVR32. */
+	{"bfin", EM_BLACKFIN},
+	{"blackfin", EM_BLACKFIN},
+	{"cris", EM_CRIS},
+	{"csky", EM_CSKY},
+	{"hppa", EM_PARISC},
+	{"i386", EM_386},
+	{"i486", EM_386},
+	{"i586", EM_386},
+	{"i686", EM_386},
+	{"loongarch", EM_LOONGARCH},
+	{"m32r", EM_M32R},
+	{"m68k", EM_68K},
+	{"microblaze", EM_MICROBLAZE},
+	{"mips", EM_MIPS},
+	{"msp430", EM_MSP430},
+	{"parisc", EM_PARISC},
+	{"powerpc", EM_PPC}, /* Check also for EM_PPC64. */
+	{"ppc", EM_PPC}, /* Check also for EM_PPC64. */
+	{"riscv", EM_RISCV},
+	{"s390", EM_S390},
+	{"sa110", EM_ARM},
+	{"sh", EM_SH},
+	{"sparc", EM_SPARC}, /* Check also for EM_SPARCV9. */
+	{"sun4u", EM_SPARC},
+	{"x86", EM_X86_64}, /* Check also for EM_386. */
+	{"xtensa", EM_XTENSA},
+};
+
+static int compare_prefix(const void *key, const void *element)
+{
+	const char *search_key = key;
+	const struct arch_to_e_machine *map_element = element;
+	size_t prefix_len = strlen(map_element->prefix);
+
+	return strncmp(search_key, map_element->prefix, prefix_len);
+}
+
+static uint16_t perf_arch_to_e_machine(const char *perf_arch, bool is_64_bit)
+{
+	/* Binary search for a matching prefix. */
+	const struct arch_to_e_machine *result;
+
+	if (!perf_arch)
+		return EM_HOST;
+
+	result = bsearch(perf_arch,
+			 prefix_to_e_machine, ARRAY_SIZE(prefix_to_e_machine),
+			 sizeof(prefix_to_e_machine[0]),
+			 compare_prefix);
+
+	if (!result) {
+		pr_debug("Unknown perf arch for ELF machine mapping: %s\n", perf_arch);
+		return EM_NONE;
+	}
+
+	/* Handle conflicting prefixes. */
+	switch (result->e_machine) {
+	case EM_ARM:
+		return !strcmp(perf_arch, "arm64") ? EM_AARCH64 : EM_ARM;
+	case EM_AVR:
+		return !strcmp(perf_arch, "avr32") ? EM_AVR32 : EM_AVR;
+	case EM_PPC:
+		return is_64_bit || strstarts(perf_arch, "ppc64") ? EM_PPC64 : EM_PPC;
+	case EM_SPARC:
+		return is_64_bit || !strcmp(perf_arch, "sparc64") ? EM_SPARCV9 : EM_SPARC;
+	case EM_X86_64:
+		return is_64_bit || !strcmp(perf_arch, "x86_64") ? EM_X86_64 : EM_386;
+	default:
+		return result->e_machine;
+	}
+}
+
+static const char *e_machine_to_perf_arch(uint16_t e_machine)
+{
+	/*
+	 * Table for if either the perf arch string differs from uname or there
+	 * are >1 ELF machine with the prefix.
+	 */
+	static const struct arch_to_e_machine extras[] = {
+		{"arm64", EM_AARCH64},
+		{"avr32", EM_AVR32},
+		{"powerpc", EM_PPC},
+		{"powerpc", EM_PPC64},
+		{"sparc", EM_SPARCV9},
+		{"x86", EM_386},
+		{"x86", EM_X86_64},
+		{"none", EM_NONE},
+	};
+
+	for (size_t i = 0; i < ARRAY_SIZE(extras); i++) {
+		if (extras[i].e_machine == e_machine)
+			return extras[i].prefix;
+	}
+
+	for (size_t i = 0; i < ARRAY_SIZE(prefix_to_e_machine); i++) {
+		if (prefix_to_e_machine[i].e_machine == e_machine)
+			return prefix_to_e_machine[i].prefix;
+
+	}
+	return "unknown";
+}
+
+uint16_t perf_env__e_machine(struct perf_env *env, uint32_t *e_flags)
+{
+	if (!env) {
+		if (e_flags)
+			*e_flags = EF_HOST;
+
+		return EM_HOST;
+	}
+	if (env->e_machine == EM_NONE) {
+		env->e_machine = perf_arch_to_e_machine(env->arch, env->kernel_is_64_bit);
+
+		if (env->e_machine == EM_HOST)
+			env->e_flags = EF_HOST;
+	}
+	if (e_flags)
+		*e_flags = env->e_flags;
+
+	return env->e_machine;
 }
 
 const char *perf_env__arch(struct perf_env *env)
 {
-	char *arch_name;
+	if (!env)
+		return e_machine_to_perf_arch(EM_HOST);
 
-	if (!env || !env->arch) { /* Assume local operation */
-		static struct utsname uts = { .machine[0] = '\0', };
-		if (uts.machine[0] == '\0' && uname(&uts) < 0)
-			return NULL;
-		arch_name = uts.machine;
-	} else
-		arch_name = env->arch;
+	if (!env->arch) {
+		/*
+		 * Lazily compute/allocate arch. The e_machine may have been
+		 * read from a data file and so may not be EM_HOST.
+		 */
+		uint16_t e_machine = perf_env__e_machine(env, /*e_flags=*/NULL);
 
-	return normalize_arch(arch_name);
+		env->arch = strdup(e_machine_to_perf_arch(e_machine));
+	}
+	return env->arch;
 }
 
 #if defined(HAVE_LIBTRACEEVENT)
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index a4501cbca375..91ff252712f4 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -186,6 +186,7 @@ int perf_env__read_cpu_topology_map(struct perf_env *env);
 
 void cpu_cache_level__free(struct cpu_cache_level *cache);
 
+uint16_t perf_env__e_machine(struct perf_env *env, uint32_t *e_flags);
 const char *perf_env__arch(struct perf_env *env);
 const char *perf_env__arch_strerrno(struct perf_env *env, int err);
 const char *perf_env__cpuid(struct perf_env *env);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 4b465abfa36c..dcc9bef303aa 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2996,14 +2996,16 @@ uint16_t perf_session__e_machine(struct perf_session *session, uint32_t *e_flags
 		return EM_HOST;
 	}
 
+	/* Is the env caching an e_machine? */
 	env = perf_session__env(session);
-	if (env && env->e_machine != EM_NONE) {
-		if (e_flags)
-			*e_flags = env->e_flags;
-
-		return env->e_machine;
-	}
+	if (env && env->e_machine != EM_NONE)
+		return perf_env__e_machine(env, e_flags);
 
+	/*
+	 * Compute from threads, note this is more accurate than
+	 * perf_env__e_machine that falls back on EM_HOST and doesn't consider
+	 * mixed 32-bit and 64-bit threads.
+	 */
 	machines__for_each_thread(&session->machines,
 				  perf_session__e_machine_cb,
 				  &args);
-- 
2.53.0.1018.g2bb0e51243-goog

