Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEB4380FC2
	for <linux-s390@vger.kernel.org>; Mon,  1 Jun 2026 06:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296860; cv=none; b=spYD7hRTkjRrTGaNJnPA0dDilLw6TjnY31kVoDEYDRuWhi6IBl9tysAr29lmo237MeUeUKdFXZvhqE+WvVpw6skAw8zEetNGarVeLudFAWL5hMb6FAmC3Zax2Tu86UNFV5WJ7d7uhOZZDqOarAnR1EYJjJIfCJ1n4PNgx+wT75w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296860; c=relaxed/simple;
	bh=IEXCGVJtERzqMAp1H5OD0+bpoOcYMisJpGhX1y/e7Sc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=flo204/4yf/4SBWdFc+/C75VHErH15ZCobVjN4Mdqi2qWZBPNF3ey9Rr8zejpg9+wX5dGuKIL6b9NDNO8DvEaeVJkCQgohweqGjOi8oYqPzm/ZiajNqlD5gxuHm6gUQ3CgMzKzbeYDDFkIabUuOzryhFFGmWjHOcOr8Y/bB4Bbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HJEmVs8M; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HJEmVs8M"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-135f2aa4742so6739556c88.1
        for <linux-s390@vger.kernel.org>; Sun, 31 May 2026 23:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780296855; x=1780901655; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hF0jxFy4fSGz+r6lDhFvr2i2eisffYkvRRILwCTwN+U=;
        b=HJEmVs8MAeX/kWgbbNCGgsu19bKIMdvIn1jOr6wwsrF2N5xrum3LO+URF0q0tHvZ9o
         K2tNwqrCgUic9RDtbn6G0Vb3gB0x3JaS39sPKIL/EaOLJeHr8Tq4njKhIOqcDorvnvvN
         YMFlQWOSLI7kGHRqtUDYRtRDXEuIGFogP2HZo/XNVgfjNhJzi4VUKotYQmt9vr8MK9Q5
         ECbbo1Z35jZ+d9rsAUA3G3s76gXlqQseO1ap0OrYDjlWJgWmfqWacD+jN2cDILFN/Q+v
         DZvwZIDqeaoXQIPQ92YSfdeuxHf7zBoiQFn/hNqsxy/QH/sItyIQOtE5X6slj6BpjD9W
         2UUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780296855; x=1780901655;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hF0jxFy4fSGz+r6lDhFvr2i2eisffYkvRRILwCTwN+U=;
        b=K6OjbWNF2Q65a8Exh7d+G7fRGNiVSecV5VhPlD8ZtxIUdc3COuQb04d0gwRrdGPKO9
         esK4h6bimfeVmlXgyg4NjUSigjvCgb3EIfVjIkuUwdjj2a/9RxOrBnOa1LlVKIh4trYE
         Ojty3TLdHcD4g5FTjLa4WbkFnvBPujwF1G9NWcehIiW0vd1CiNWunKSak2cm0EWVNF/l
         dnTe2jUk6D5TDQqP/X8I0bqn9Qqfxextk0v0wUEwq6dzlczpXcsnFt9t2F+NrDD+BcRr
         TgASMdFqextiVRZb7rt1ejr7nCLVg/cgxizYGJg32ZFEKz8oiod7DPQwFSOKT41c4rFY
         rMXw==
X-Forwarded-Encrypted: i=1; AFNElJ+NkDXvIB0BzCRBatai3qTC2BAXPMjdmxIuz6l6ias7Ccb8dc1SX7oI6iIAbbDTQL8GwjzWsl0Q1pT3@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv2WQGZArLGgVShvyqkbNHjDZ41ld/0lM5K7FLwGhQT/7/tRv+
	hq3BLV7aaZhV1vLIA/xhGnadQPC6i1wrufNiUm1gQxgesDjqeT4HWQQY8AZEtWR9LzAV3BlGXNs
	XHRPgAjuuJw==
X-Received: from dlee16.prod.google.com ([2002:a05:7022:6290:b0:136:3f5e:fe1c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:43:b0:136:6230:5834
 with SMTP id a92af1059eb24-137d427a4bbmr4077235c88.31.1780296855115; Sun, 31
 May 2026 23:54:15 -0700 (PDT)
Date: Sun, 31 May 2026 23:53:50 -0700
In-Reply-To: <20260601065407.1597927-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503002248.1040791-1-irogers@google.com> <20260601065407.1597927-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601065407.1597927-2-irogers@google.com>
Subject: [PATCH v10 01/18] perf env: Add perf_env__e_machine helper and use in perf_env__arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Add a helper that lazily computes the e_machine and falls back to EM_HOST.
Use the perf_env's arch to compute the e_machine if available, using a
binary search for efficiency while handling duplicate rules.

Switch perf_env__arch to be derived from e_machine for consistency.
To support 32-bit compat binaries on 64-bit hosts during dynamic local
or live operations, unpopulated arch fallback paths query uname() at
runtime to dynamically resolve the correct host e_machine, safely
preventing bitness misclassification regressions.

Update session and header to use the helper to safely record e_machine
and flags without forcing premature thread scanning.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/env.c     | 300 ++++++++++++++++++++++++++++++++------
 tools/perf/util/env.h     |   2 +
 tools/perf/util/header.c  |  32 ++--
 tools/perf/util/session.c |  26 ++--
 4 files changed, 295 insertions(+), 65 deletions(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 20953ef7b9d8..23dcd7a108a1 100644
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
@@ -309,15 +311,27 @@ void perf_env__init(struct perf_env *env)
 
 static void perf_env__init_kernel_mode(struct perf_env *env)
 {
-	const char *arch = perf_env__raw_arch(env);
+	const char *arch = env->arch;
 
-	if (!strncmp(arch, "x86_64", 6) || !strncmp(arch, "aarch64", 7) ||
-	    !strncmp(arch, "arm64", 5) || !strncmp(arch, "mips64", 6) ||
-	    !strncmp(arch, "parisc64", 8) || !strncmp(arch, "riscv64", 7) ||
-	    !strncmp(arch, "s390x", 5) || !strncmp(arch, "sparc64", 7))
-		env->kernel_is_64_bit = 1;
-	else
-		env->kernel_is_64_bit = 0;
+	if (!arch) {
+		static struct utsname uts = { .machine[0] = '\0', };
+
+		if (uts.machine[0] == '\0')
+			uname(&uts);
+		if (uts.machine[0] != '\0')
+			arch = uts.machine;
+	}
+
+	if (arch) {
+		if (str_ends_with(arch, "64") || !strncmp(arch, "s390x", 5))
+			env->kernel_is_64_bit = 1;
+		else
+			env->kernel_is_64_bit = 0;
+		return;
+	}
+
+	/* Fallback if completely unresolvable (assume host-bitness) */
+	env->kernel_is_64_bit = (sizeof(void *) == 8) ? 1 : 0;
 }
 
 int perf_env__kernel_is_64_bit(struct perf_env *env)
@@ -588,51 +602,249 @@ void cpu_cache_level__free(struct cpu_cache_level *cache)
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
+static uint16_t perf_arch_to_e_machine(const char *perf_arch, int is_64_bit)
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
+	/*
+	 * Handle conflicting prefixes. If the is_64_bit is unknown (-1) then
+	 * assume 64-bit. We can't use perf_env__kernel_is_64_bit as that
+	 * depends on the arch string.
+	 */
+	switch (result->e_machine) {
+	case EM_ARM:
+		return !strcmp(perf_arch, "arm64") || !strcmp(perf_arch, "aarch64") ? EM_AARCH64 : EM_ARM;
+	case EM_AVR:
+		return !strcmp(perf_arch, "avr32") ? EM_AVR32 : EM_AVR;
+	case EM_PPC:
+		if (is_64_bit == 1)
+			return EM_PPC64;
+		if (is_64_bit == 0)
+			return EM_PPC;
+		return strstarts(perf_arch, "ppc64") ? EM_PPC64 : EM_PPC;
+	case EM_SPARC:
+		if (is_64_bit == 1)
+			return EM_SPARCV9;
+		if (is_64_bit == 0)
+			return EM_SPARC;
+		return !strcmp(perf_arch, "sparc64") || !strcmp(perf_arch, "sun4u") ? EM_SPARCV9 : EM_SPARC;
+	case EM_X86_64:
+		if (is_64_bit == 1)
+			return EM_X86_64;
+		if (is_64_bit == 0)
+			return EM_386;
+		return !strcmp(perf_arch, "x86_64") || !strcmp(perf_arch, "x86") ? EM_X86_64 : EM_386;
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
+uint16_t perf_env__e_machine_nocache(struct perf_env *env, uint32_t *e_flags)
+{
+	uint16_t e_machine = EM_NONE;
+	const char *arch = NULL;
+	int is_64_bit = -1;
+
+	if (e_flags)
+		*e_flags = 0;
+
+	if (env) {
+		arch = env->arch;
+		is_64_bit = env->kernel_is_64_bit;
+	}
+
+	if (!arch) {
+		static struct utsname uts = { .machine[0] = '\0', };
+
+		if (uts.machine[0] == '\0')
+			uname(&uts);
+		if (uts.machine[0] != '\0')
+			arch = uts.machine;
+	}
+
+	e_machine = perf_arch_to_e_machine(arch, is_64_bit);
+
+	if (e_flags)
+		*e_flags = (e_machine == EM_HOST) ? EF_HOST : 0;
+
+	return e_machine;
+}
+
+uint16_t perf_env__e_machine(struct perf_env *env, uint32_t *e_flags)
+{
+	uint16_t e_machine;
+	uint32_t local_e_flags = 0;
+
+	if (env && env->e_machine != EM_NONE) {
+		if (e_flags)
+			*e_flags = env->e_flags;
+
+		return env->e_machine;
+	}
+	e_machine = perf_env__e_machine_nocache(env, &local_e_flags);
+	/*
+	 * Only cache the e_machine in perf_env if env->arch is not NULL.
+	 * If env->arch is NULL, the e_machine is just a fallback to EM_HOST.
+	 * Caching it permanently would prevent dynamic, more accurate
+	 * thread-based session e_machine scanning later in
+	 * perf_session__e_machine().
+	 */
+	if (env && env->arch) {
+		env->e_machine = e_machine;
+		env->e_flags = local_e_flags;
+	}
+	if (e_flags)
+		*e_flags = local_e_flags;
+
+	return e_machine;
 }
 
 const char *perf_env__arch(struct perf_env *env)
 {
-	char *arch_name;
+	uint16_t e_machine;
+	const char *arch;
 
-	if (!env || !env->arch) { /* Assume local operation */
+	if (!env) {
 		static struct utsname uts = { .machine[0] = '\0', };
-		if (uts.machine[0] == '\0' && uname(&uts) < 0)
-			return NULL;
-		arch_name = uts.machine;
-	} else
-		arch_name = env->arch;
+		uint16_t host_e_machine;
+
+		if (uts.machine[0] == '\0')
+			uname(&uts);
+		if (uts.machine[0] != '\0') {
+			host_e_machine = perf_arch_to_e_machine(uts.machine, -1);
+			return e_machine_to_perf_arch(host_e_machine);
+		}
+		return e_machine_to_perf_arch(EM_HOST);
+	}
+
+	if (env->arch)
+		return env->arch;
 
-	return normalize_arch(arch_name);
+	/*
+	 * Lazily compute/allocate arch. The e_machine may have been
+	 * read from a data file and so may not be EM_HOST.
+	 */
+	e_machine = perf_env__e_machine(env, /*e_flags=*/NULL);
+	arch = e_machine_to_perf_arch(e_machine);
+
+	if (e_machine == EM_RISCV && perf_env__kernel_is_64_bit(env) == 1)
+		arch = "riscv64";
+	else if (e_machine == EM_MIPS && perf_env__kernel_is_64_bit(env) == 1)
+		arch = "mips64";
+	else if (e_machine == EM_PARISC && perf_env__kernel_is_64_bit(env) == 1)
+		arch = "parisc64";
+
+	/*
+	 * Only cache the normalized arch string in env->arch if the
+	 * e_machine was successfully resolved (i.e. not the unpopulated
+	 * fallback to EM_HOST), allowing threads to dynamically indicate
+	 * a better ELF machine type later.
+	 */
+	if (env && env->e_machine != EM_NONE)
+		env->arch = strdup(arch);
+	/*
+	 * Avoid potential crashes on the arch string if memory allocation in
+	 * strdup fails and NULL were to be returned.
+	 */
+	return env->arch ?: arch;
 }
 
 const char *perf_env__arch_strerrno(struct perf_env *env __maybe_unused, int err __maybe_unused)
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 739d884fc236..bde192fd5be5 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -187,6 +187,8 @@ int perf_env__read_cpu_topology_map(struct perf_env *env);
 
 void cpu_cache_level__free(struct cpu_cache_level *cache);
 
+uint16_t perf_env__e_machine_nocache(struct perf_env *env, uint32_t *e_flags);
+uint16_t perf_env__e_machine(struct perf_env *env, uint32_t *e_flags);
 const char *perf_env__arch(struct perf_env *env);
 const char *perf_env__arch_strerrno(struct perf_env *env, int err);
 arch_syscalls__strerrno_t *arch_syscalls__strerrno_function(const char *arch);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 5b1fa1653d2a..220e7720fbdb 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -441,21 +441,25 @@ static int write_osrelease(struct feat_fd *ff,
 	return do_write_string(ff, uts.release);
 }
 
-static int write_arch(struct feat_fd *ff,
-		      struct evlist *evlist __maybe_unused)
+static int write_arch(struct feat_fd *ff, struct evlist *evlist)
 {
 	struct utsname uts;
-	int ret;
+	const char *arch = NULL;
 
-	ret = uname(&uts);
-	if (ret < 0)
-		return -1;
+	if (evlist->session)
+		arch = perf_env__arch(perf_session__env(evlist->session));
+
+	if (!arch) {
+		int ret = uname(&uts);
 
-	return do_write_string(ff, uts.machine);
+		if (ret < 0)
+			return -1;
+		arch = uts.machine;
+	}
+	return do_write_string(ff, arch);
 }
 
-static int write_e_machine(struct feat_fd *ff,
-			   struct evlist *evlist __maybe_unused)
+static int write_e_machine(struct feat_fd *ff, struct evlist *evlist)
 {
 	/* e_machine expanded from 16 to 32-bits for alignment. */
 	uint32_t e_flags;
@@ -2841,10 +2845,18 @@ static int process_##__feat(struct feat_fd *ff, void *data __maybe_unused) \
 FEAT_PROCESS_STR_FUN(hostname, hostname);
 FEAT_PROCESS_STR_FUN(osrelease, os_release);
 FEAT_PROCESS_STR_FUN(version, version);
-FEAT_PROCESS_STR_FUN(arch, arch);
 FEAT_PROCESS_STR_FUN(cpudesc, cpu_desc);
 FEAT_PROCESS_STR_FUN(cpuid, cpuid);
 
+static int process_arch(struct feat_fd *ff, void *data __maybe_unused)
+{
+	free(ff->ph->env.arch);
+	ff->ph->env.arch = do_read_string(ff);
+	if (!ff->ph->env.arch)
+		return -ENOMEM;
+	return 0;
+}
+
 static int process_e_machine(struct feat_fd *ff, void *data __maybe_unused)
 {
 	int ret;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index e2e821b77766..4791c052aebe 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -4080,14 +4080,19 @@ uint16_t perf_session__e_machine(struct perf_session *session, uint32_t *e_flags
 		return EM_HOST;
 	}
 
+	/*
+	 * Is the env caching an e_machine? If not we want to compute from the
+	 * more accurate threads.
+	 */
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
@@ -4105,10 +4110,9 @@ uint16_t perf_session__e_machine(struct perf_session *session, uint32_t *e_flags
 
 	/*
 	 * Couldn't determine from the perf_env or current set of
-	 * threads. Default to the host.
+	 * threads. Potentially use logic that uses the arch string otherwise
+	 * default to the host. Don't cache in the perf_env in case later
+	 * threads indicate a better ELF machine type.
 	 */
-	if (e_flags)
-		*e_flags = EF_HOST;
-
-	return EM_HOST;
+	return perf_env__e_machine_nocache(env, e_flags);
 }
-- 
2.54.0.823.g6e5bcc1fc9-goog

