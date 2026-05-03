Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF977191F84
	for <linux-s390@vger.kernel.org>; Sun,  3 May 2026 00:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777767777; cv=none; b=XD5c9AvU6qE4nEpz1FTPSNFGhBdRcsJfwb/dibIJ6Gvbg0Ln0g8JXaRygSsOn3xi+JsJb6HcRXfjwRMrNjZirfJdS9/f/XyLedxRv8zFtNuOUltvSypPm7GdapW2+g6O7STIE3quuUqftS8hunB8huUDf4VxxlDARqHxXG58xCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777767777; c=relaxed/simple;
	bh=E5WuLgSvCu+Huy2Y/j/l91kxZitYlpVjBvqNsRrWqHA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U3zh4LMTUe52DsJY8nLrHm3X1dDTBGE0+NhPTvXKpVIeQ/HuS91PsWI6xjHF1T8/mOox4VZ2DjhidITwLC5W4djk95lYHKznt5O4MkspbYddc2rhh4mQNj/3KqnLfs71BCHcsx35qEa3udB6Gmy3nmZdLxRb7GtvePMd5SZcXnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N3TVLzwl; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N3TVLzwl"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dfb99429bso533205c88.1
        for <linux-s390@vger.kernel.org>; Sat, 02 May 2026 17:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777767775; x=1778372575; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NE4nGAv7YSfIGpZCRFnu2hIyoVTHwCm9GN3Jcb5rWf4=;
        b=N3TVLzwlhHo0qgxkVv+tC0V9NRE6/QnnuVwYgHL8QbLDlrKMQeLt/4eUvU4FIjDlz5
         vhVO0iRD6mqqepauIUKvMMQRNWGbjx4cdE9TM0Wg1Qh2jqyfd0tewMlqlbLey7KmJ88Q
         ws6KRbM+8wxha9cThMDCLfQKIIaQJsAtUXR/OsmMCpIsUlsn7cRGTXZXF449L28juFVT
         k5/uyBXHPf4XSvekLnz7MxbQ1IQpOpHp4ll6NGqwZYWv8e1H48jIdLdxEMK+xbLozmCv
         2J6ItblbBOm0FZlmJLm0d3lHPn6qE+ytBAfEOp6BWj9us7RKTNthrC5FsfMfUTmafpOb
         W7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777767775; x=1778372575;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NE4nGAv7YSfIGpZCRFnu2hIyoVTHwCm9GN3Jcb5rWf4=;
        b=W+EsZ1zYaFAY2u5uBnosVvmbzJ0LSjzi9HwBBdh11pNPjnuQ9TT6R/+Nzc/WAWsxZU
         do8FckbaVhmUC8RlWcH0rc+VairtTu8+hxch9DP5FsV+pdPkADAw3CVEMEWs1i43gMid
         uhG13szn5s9IybkjgU90tSCA1i9EoesuWPai7BiAIOjzdS5R5SIJLkMbYmJS+7czE5ut
         PJ82K8nfeeMSaEPizKg1p7AjGXAnQkBQkywA7XDXy61gvv6pM+KYZSVptssQduIL0esT
         /Raw4lDvCw70OPy+Pe9qYTK3CCqLheF3vQkalqqdIK7WWmy19KfZI2BBbPkNXMzcMYZn
         AUXQ==
X-Forwarded-Encrypted: i=1; AFNElJ9YHqQ8/oRE1pkfLEJSf+spNP5IFDNdM1VZlW8WIVSNPw56/iRoref/V7ZT0bDe+yXCvqw1bGPND+HX@vger.kernel.org
X-Gm-Message-State: AOJu0YzoZwE1F4TrjvzEQuf9PGCVg7ZlEC+B/l3IRbYTKkCePpVIYiu5
	IqAHGKefEmqL7tJ8orgy5vVL4ftmVRWbuAoQBrwRkiJeCnU1ZP6ND/oCCimXSm7bPlBgdsxc4p/
	cvRNRbC36tw==
X-Received: from dlbps8.prod.google.com ([2002:a05:7023:888:b0:12d:b2ba:b551])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:404:b0:12d:de3e:cbfd
 with SMTP id a92af1059eb24-12dfd8411d0mr1946033c88.36.1777767774726; Sat, 02
 May 2026 17:22:54 -0700 (PDT)
Date: Sat,  2 May 2026 17:22:31 -0700
In-Reply-To: <20260503002248.1040791-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502065935.291960-1-irogers@google.com> <20260503002248.1040791-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503002248.1040791-2-irogers@google.com>
Subject: [PATCH v9 01/18] perf env: Add perf_env__e_machine helper and use in perf_env__arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Add a helper that lazily computes the e_machine and falls back to
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
 tools/perf/util/env.c     | 231 +++++++++++++++++++++++++++++++-------
 tools/perf/util/env.h     |   2 +
 tools/perf/util/header.c  |  35 ++++--
 tools/perf/util/session.c |  26 +++--
 4 files changed, 231 insertions(+), 63 deletions(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 1e54e2c86360..0edc67a468ab 100644
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
@@ -309,12 +311,21 @@ void perf_env__init(struct perf_env *env)
 
 static void perf_env__init_kernel_mode(struct perf_env *env)
 {
-	const char *arch = perf_env__raw_arch(env);
+	uint16_t e_machine = env->e_machine;
 
-	if (!strncmp(arch, "x86_64", 6) || !strncmp(arch, "aarch64", 7) ||
-	    !strncmp(arch, "arm64", 5) || !strncmp(arch, "mips64", 6) ||
-	    !strncmp(arch, "parisc64", 8) || !strncmp(arch, "riscv64", 7) ||
-	    !strncmp(arch, "s390x", 5) || !strncmp(arch, "sparc64", 7))
+	if (env->arch && (e_machine == EM_NONE || e_machine == EM_MIPS || e_machine == EM_RISCV)) {
+		if (str_ends_with(env->arch, "64") || !strncmp(env->arch, "s390x", 5))
+			env->kernel_is_64_bit = 1;
+		else
+			env->kernel_is_64_bit = 0;
+		return;
+	}
+	if (e_machine == EM_NONE)
+		e_machine = perf_env__e_machine(env, /*e_flags=*/NULL);
+
+	if (e_machine == EM_X86_64 || e_machine == EM_AARCH64 ||
+	    e_machine == EM_PPC64 || e_machine == EM_SPARCV9 ||
+	    e_machine == EM_S390)
 		env->kernel_is_64_bit = 1;
 	else
 		env->kernel_is_64_bit = 0;
@@ -588,51 +599,187 @@ void cpu_cache_level__free(struct cpu_cache_level *cache)
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
+		return !strcmp(perf_arch, "arm64") ? EM_AARCH64 : EM_ARM;
+	case EM_AVR:
+		return !strcmp(perf_arch, "avr32") ? EM_AVR32 : EM_AVR;
+	case EM_PPC:
+		return (is_64_bit != 0) || strstarts(perf_arch, "ppc64") ? EM_PPC64 : EM_PPC;
+	case EM_SPARC:
+		return (is_64_bit != 0) || !strcmp(perf_arch, "sparc64") ? EM_SPARCV9 : EM_SPARC;
+	case EM_X86_64:
+		return (is_64_bit != 0) || !strcmp(perf_arch, "x86_64") ? EM_X86_64 : EM_386;
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
+	uint16_t e_machine = EM_HOST;
+
+	if (env)
+		e_machine = perf_arch_to_e_machine(env->arch, env->kernel_is_64_bit);
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
+	if (env) {
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
-		static struct utsname uts = { .machine[0] = '\0', };
-		if (uts.machine[0] == '\0' && uname(&uts) < 0)
-			return NULL;
-		arch_name = uts.machine;
-	} else
-		arch_name = env->arch;
+	if (!env)
+		return e_machine_to_perf_arch(EM_HOST);
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
+	env->arch = strdup(arch);
+	/*
+	 * Avoid potential crashes on the arch string if memory allocation in
+	 * strdup fails and NULL were to be returned.
+	 */
+	return env->arch ?: arch;
 }
 
 #if defined(HAVE_LIBTRACEEVENT)
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index c7052ac1f856..7151a9138e3f 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -187,6 +187,8 @@ int perf_env__read_cpu_topology_map(struct perf_env *env);
 
 void cpu_cache_level__free(struct cpu_cache_level *cache);
 
+uint16_t perf_env__e_machine_nocache(struct perf_env *env, uint32_t *e_flags);
+uint16_t perf_env__e_machine(struct perf_env *env, uint32_t *e_flags);
 const char *perf_env__arch(struct perf_env *env);
 const char *perf_env__arch_strerrno(struct perf_env *env, int err);
 const char *perf_env__cpuid(struct perf_env *env);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index f30e48eb3fc3..f1ae61392cce 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -379,21 +379,28 @@ static int write_osrelease(struct feat_fd *ff,
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
+	if (evlist->session) {
+		/* Force the computation in the perf_env of the e_machine of the threads. */
+		perf_session__e_machine(evlist->session, /*e_flags=*/NULL);
+		arch = perf_env__arch(perf_session__env(evlist->session));
+	}
 
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
@@ -2684,10 +2691,18 @@ static int process_##__feat(struct feat_fd *ff, void *data __maybe_unused) \
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
index fe0de2a0277f..3e64db2d27c2 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -3023,14 +3023,19 @@ uint16_t perf_session__e_machine(struct perf_session *session, uint32_t *e_flags
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
@@ -3048,10 +3053,9 @@ uint16_t perf_session__e_machine(struct perf_session *session, uint32_t *e_flags
 
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
2.54.0.545.g6539524ca2-goog

