Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1DB39E6F1
	for <linux-s390@vger.kernel.org>; Thu,  9 Apr 2026 23:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775775992; cv=none; b=OXQfxvMwpHffzB2M2qtC2v9zSzXwBjXhmUeOeETuY0kE9YgZ+hVSeYBGDPMzilDJfyWFb+0lqmTq071TXDfGw650QwFWIdS4HzJwuQr09BMDPc0uVSJrutEHuQ3A0qhKPSLNGXxBTexJpJ6ha1NrPGg7Vq3CIzdtDjR/2eFSE7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775775992; c=relaxed/simple;
	bh=+Y8cvPVVvvqdbquJvuJg+J4k4bR2AGmtJbF1vmdOsI0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TsHJKqt+8ABSU12NqehTfKwOZGXbQ1fxq82Uh4WleX8w88YVOdYfdcrKCObIJO1ZdHdjXr7Eph1xLasmwCLmC1ToUfh3TYwKtxc7CVIUo/HS3bStyuBuzShyY7UwrncyQY0SCENoU7JYE9aQzfiu9g8DNNBCuHrF7uQjK17i5zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WmkRy1zH; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WmkRy1zH"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0ba59a830so1950792eec.0
        for <linux-s390@vger.kernel.org>; Thu, 09 Apr 2026 16:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775775990; x=1776380790; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=93K47+1MFWVpbraQHFk+5E8Mf2fMBiBw3PCbHNvpcbw=;
        b=WmkRy1zHobL9de6u+gpcXyxm0BRG7zR4V1ILVvsfDR6KaMtbwjfd+h/y4qNWfmyP6s
         PJc0CmyzWX9eLnNWtKS/dAEDmcRFI6VSh9qZC9PDCpgfi27MpNBchD9AnXK9bJ41IF4O
         xH9ZVirAvHEXFFevBcZtPcZf2ZGD0c9kimIKqNO/vBumhI4py/eGS4J50zAwZUsrnjyF
         taImqmBNct+WjIc7XCxpb3EtQql/4AXXpWogWayqK/U/wyTRNHSdqfFIFIrF8v5oq96v
         UvDph3zHEjGKELqwu6czbG2+7TXKBIjWq32Bwwc+qjH/ZNCEdOqPbCmuNstev99BLLj1
         Pp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775775990; x=1776380790;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=93K47+1MFWVpbraQHFk+5E8Mf2fMBiBw3PCbHNvpcbw=;
        b=L5ztmGLViuHPaEpcQ0fMIV6AyIYwJk9aS1siZKC2hbm9b6jRaQfapi5yFS3EnMMBvM
         //TTQLNXloQCaPd7lHdVfKvPni0NFIcg8Cs78JmhrB5aF+Jz5xmU9MVhVZJ1gg9CNnbc
         rC7sUD/JPhnm7byeVVzzE/dDdk7dpmqgVw8o+bO/stjMJFsrtGXCDeG7d5S3aW1k2e2C
         i+q4VQMhbarmzOVscd4dh91Xl77WydNVFac8AyOYQXzY/WQ+QIzbMdviBLXuKuZXkc/Q
         5GR6HTVfhvVU0hHg+x2wlThUIy91AznBBfR/6gPp6XODjlrhtv6/hOEIyP4AUxO/J4yR
         nRsA==
X-Forwarded-Encrypted: i=1; AJvYcCXA2NxpdEyNDdsGyghVqGwMKN78HFeaW9My/VwhjUOx6yY9+ut7yligDzgdOEDczc45NHXRDuMjMxGm@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6mfC+ZCrpu8kT28Yr53v7VEfJg9OabEze8RVXOLsNQqVE7DKM
	RwOVx6SRmE7mQa5ZZzTgqICqujRBRZirkbfOmENLcgiEiRaE67R9/Xkqe42gEYvjWYrAi1XHotG
	31ZvREgu8xA==
X-Received: from dycc15.prod.google.com ([2002:a05:693c:60cf:b0:2c6:415a:9023])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:220d:b0:2be:1f56:ed21
 with SMTP id 5a478bee46e88-2d5876a0820mr632825eec.7.1775775989741; Thu, 09
 Apr 2026 16:06:29 -0700 (PDT)
Date: Thu,  9 Apr 2026 16:06:18 -0700
In-Reply-To: <20260409230620.4176210-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260406170905.2614260-1-irogers@google.com> <20260409230620.4176210-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409230620.4176210-2-irogers@google.com>
Subject: [PATCH v6 1/3] perf env: Add perf_env__e_machine helper and use in perf_env__arch
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, jameshongleiwang@126.com, 
	japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
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
 tools/perf/util/header.c  |  44 ++++++---
 tools/perf/util/session.c |  14 +--
 4 files changed, 191 insertions(+), 53 deletions(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 1e54e2c86360..339d62ca37bb 100644
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
index c7052ac1f856..d36a0fb2cd04 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -187,6 +187,7 @@ int perf_env__read_cpu_topology_map(struct perf_env *env);
 
 void cpu_cache_level__free(struct cpu_cache_level *cache);
 
+uint16_t perf_env__e_machine(struct perf_env *env, uint32_t *e_flags);
 const char *perf_env__arch(struct perf_env *env);
 const char *perf_env__arch_strerrno(struct perf_env *env, int err);
 const char *perf_env__cpuid(struct perf_env *env);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index c6efddb70aee..9bb4a271b4f8 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -370,21 +370,25 @@ static int write_osrelease(struct feat_fd *ff,
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
 
-	return do_write_string(ff, uts.machine);
+	if (!arch) {
+		int ret = uname(&uts);
+
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
@@ -2675,10 +2679,30 @@ static int process_##__feat(struct feat_fd *ff, void *data __maybe_unused) \
 FEAT_PROCESS_STR_FUN(hostname, hostname);
 FEAT_PROCESS_STR_FUN(osrelease, os_release);
 FEAT_PROCESS_STR_FUN(version, version);
-FEAT_PROCESS_STR_FUN(arch, arch);
 FEAT_PROCESS_STR_FUN(cpudesc, cpu_desc);
 FEAT_PROCESS_STR_FUN(cpuid, cpuid);
 
+static int process_arch(struct feat_fd *ff, void *data __maybe_unused)
+{
+	uint16_t saved_e_machine = ff->ph->env.e_machine;
+
+	free(ff->ph->env.arch);
+	ff->ph->env.arch = do_read_string(ff);
+	if (!ff->ph->env.arch)
+		return -ENOMEM;
+	/*
+	 * Make the arch string canonical by computing the e_machine from it,
+	 * then turning the e_machine back into an arch string.
+	 */
+	ff->ph->env.e_machine = EM_NONE;
+	if (perf_env__e_machine(&ff->ph->env, /*e_flags=*/NULL) != EM_NONE) {
+		zfree(&ff->ph->env.arch);
+		perf_env__arch(&ff->ph->env);
+	}
+	ff->ph->env.e_machine = saved_e_machine;
+	return 0;
+}
+
 static int process_e_machine(struct feat_fd *ff, void *data __maybe_unused)
 {
 	int ret;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index fe0de2a0277f..726568b88803 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -3023,14 +3023,16 @@ uint16_t perf_session__e_machine(struct perf_session *session, uint32_t *e_flags
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
2.53.0.1213.gd9a14994de-goog

