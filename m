Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D663876B7
	for <linux-s390@vger.kernel.org>; Mon,  1 Jun 2026 06:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296883; cv=none; b=JM6CNnXwoXjrDanEYsI7j6ZOP8tBLGDSzL5XSvM5S02SpQmomcAgHk3BRGwOcjECgL+C3Cx+IhVTxbllp+yCncbsW2jqPBWVJidtZWBCzeGTxFBymSmMzx1xsAu3I82NZEKl+pEzhsOgz3ZRZMfIDzO/q6eI1O5LY6EQTmDmG1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296883; c=relaxed/simple;
	bh=AfVtJGxFq3/GN+KKs+vE+6HNkbzX+bmU4sHY3PCjgPY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uvEeYOwPe8/VjYu81+uE4gicTukIsqVYUd9HdR7iPTsOT6aFuQQjBuGwJvxPqbfSFiAba2xxM8jWI/Fqa7p7dWtX1s7/vpNy/30zE0dTr2TFWVgKO3odtHw5jSx6oiXDwCDvugsE2wXo1XV1ggVkB2FmCnaa67x8y8hs4La9VhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cZIMiSLm; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cZIMiSLm"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137dbe27199so255061c88.1
        for <linux-s390@vger.kernel.org>; Sun, 31 May 2026 23:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780296881; x=1780901681; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m9l7jwInauSUuEQMp0ByvVmmWHt+qu3CfU7xQtt2+Fw=;
        b=cZIMiSLmQi3kM5VZUNNF+EbsvHjQRl/dTHVCZiCOR8XX3ECeInVE2V1JQj9kdCiOwJ
         zpVy1s0sDe8iGal4CdzkyZ9OhE/lEPCgxyZniOoJs/um6qkSKTZxqwYsbZP366oZFyxa
         Lh0GVeErLs+uoAZ2fcgq4rsMHV2eGZ5al1zZk3n2jhrE6vtZjccod+Bs9VKy7mE86nwM
         U3EJL3P9Xc6qrCJrVdYS5HvQaqUCwgnvQlS8wrFF8d2v9Nhm7DaY1xHM/3shWcqgOkLH
         wUkPsLLypJS3kNk9/zJJN36OOoQVh1g402EWgSEkVscIYDqlI08HTXr55/D3vsQSLUS1
         DnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780296881; x=1780901681;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m9l7jwInauSUuEQMp0ByvVmmWHt+qu3CfU7xQtt2+Fw=;
        b=OD6nu68Wy0cXur4xzr8OBFUiE8rxBFwujr5tDh2tIhBj5EpR/Gsuu9e8fwN4LPAvYp
         JQ3B8mQtx7Ng8l5ewOEEYJluyrri+XH922jlEjVBZcqGf6Fpu1NNd6JBrb/W+pBg0mff
         ZXWf1ISznizRN1pgy2DeqZ5n8z+gWRElGkGsgGprx/c/O5qHKxok6yJstiLe26Azs66U
         w/2zOBhjo789i8DJQk5RTefymdPn4yJG0NgfVOj0hj40DoqsTicw+fGfNQmmfDbbkEm8
         c6rZ4/B1/InSnq8HUJ5QgryqYXa6eQxv65uOGncoVj3JUTQsUHLo5mJ/iD5oLSePgtXP
         n9fg==
X-Forwarded-Encrypted: i=1; AFNElJ84xcvZFLqL7JCcBTElhxM3g02yZOuDFxPpvVeLBRGRw8NOQv+tiilC23HM6WU88bzkcUW+opqI4rda@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmlq16kHxuA4Qx3uxpETaMGFSG1S42wv9sP/jXgVGF+D+XUwgx
	3znzxmHLDSbbVCK+vf1NI6Q/ZHbKbVDllUqOTvhH20GzwgZwaotNqdZRjI/gEh0Esax81+U3fn8
	hmzeEr6G53Q==
X-Received: from dleb13-n1.prod.google.com ([2002:a05:701b:424d:10b0:135:d8c9:120a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e24:b0:12c:6a24:a24f
 with SMTP id a92af1059eb24-137d4294858mr4288098c88.33.1780296881243; Sun, 31
 May 2026 23:54:41 -0700 (PDT)
Date: Sun, 31 May 2026 23:54:03 -0700
In-Reply-To: <20260601065407.1597927-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503002248.1040791-1-irogers@google.com> <20260601065407.1597927-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601065407.1597927-15-irogers@google.com>
Subject: [PATCH v10 14/18] perf env: Refactor perf_env__arch_strerrno
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

perf_env__arch_strerrno is only available with libtraceevent so hide
the declaration if no libtraceevent.

The previous approach maps an architecture string to a function
pointer to a function that takes an int errno values and returns a
string. The new approach takes an e_machine and an errno value and
returns a string.

As the only call site is in builtin-trace.c, the e_machine is already
present and potentially more specific than the perf_env arch string
that is a single global value.

The major complication in this approach is having the shell script
that generates the C code map a linux directory name to the matching
ELF machine constants.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c                  |  7 ++--
 tools/perf/trace/beauty/Build               |  1 +
 tools/perf/trace/beauty/arch_errno_names.sh | 41 ++++++++++++++++++---
 tools/perf/util/env.c                       | 15 +++-----
 tools/perf/util/env.h                       |  8 ++--
 tools/perf/util/libdw.c                     |  2 +-
 6 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 2530b4035e4f..377f0a18b00e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3032,9 +3032,8 @@ static int trace__sys_exit(struct trace *trace,
 	} else if (ret < 0) {
 errno_print: {
 		char bf[STRERR_BUFSIZE];
-		struct perf_env *env = evsel__env(evsel) ?: &trace->host_env;
 		const char *emsg = str_error_r(-ret, bf, sizeof(bf));
-		const char *e = perf_env__arch_strerrno(env, err);
+		const char *e = perf_env__arch_strerrno(e_machine, err);
 
 		fprintf(trace->output, "-1 %s (%s)", e, emsg);
 	}
@@ -4921,7 +4920,9 @@ static size_t syscall__dump_stats(struct trace *trace, int e_machine, FILE *fp,
 
 				for (e = 0; e < stats->max_errno; ++e) {
 					if (stats->errnos[e] != 0)
-						fprintf(fp, "\t\t\t\t%s: %d\n", perf_env__arch_strerrno(trace->host->env, e + 1), stats->errnos[e]);
+						fprintf(fp, "\t\t\t\t%s: %d\n",
+							perf_env__arch_strerrno(e_machine, e + 1),
+							stats->errnos[e]);
 				}
 			}
 			lines++;
diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index 996e63cdf765..bf9553f683f8 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -36,6 +36,7 @@ perf-y += signum.o
 perf-y += socket_type.o
 perf-y += waitid_options.o
 perf-util-y += arch_errno_names.o
+
 perf-y += tracepoints/
 
 ifdef SHELLCHECK
diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/trace/beauty/arch_errno_names.sh
index d48d8561a7bb..aae3d92a7893 100755
--- a/tools/perf/trace/beauty/arch_errno_names.sh
+++ b/tools/perf/trace/beauty/arch_errno_names.sh
@@ -52,21 +52,50 @@ process_arch()
 		|IFS=, create_errno_lookup_func "$arch"
 }
 
+arch_to_e_machine()
+{
+	case "$1" in
+	alpha)      printf '\tcase EM_ALPHA:\n' ;;
+	arc)        printf '\tcase EM_ARC:\n' ;;
+	arm)        printf '\tcase EM_ARM:\n' ;;
+	arm64)      printf '\tcase EM_AARCH64:\n' ;;
+	csky)       printf '\tcase EM_CSKY:\n' ;;
+	hexagon)    printf '\tcase EM_HEXAGON:\n' ;;
+	loongarch)  printf '\tcase EM_LOONGARCH:\n' ;;
+	microblaze) printf '\tcase EM_MICROBLAZE:\n' ;;
+	mips)       printf '\tcase EM_MIPS:\n' ;;
+	parisc)     printf '\tcase EM_PARISC:\n' ;;
+	powerpc)    printf '\tcase EM_PPC:\n\tcase EM_PPC64:\n' ;;
+	riscv)      printf '\tcase EM_RISCV:\n' ;;
+	s390)       printf '\tcase EM_S390:\n' ;;
+	sh)         printf '\tcase EM_SH:\n' ;;
+	sparc)      printf '\tcase EM_SPARC:\n\tcase EM_SPARCV9:\n' ;;
+	x86)        printf '\tcase EM_386:\n\tcase EM_X86_64:\n' ;;
+	xtensa)     printf '\tcase EM_XTENSA:\n' ;;
+	esac
+}
+
 create_arch_errno_table_func()
 {
 	archlist="$1"
 	default="$2"
 
-	printf 'arch_syscalls__strerrno_t *\n'
-	printf 'arch_syscalls__strerrno_function(const char *arch)\n'
+	printf 'const char *arch_syscalls__strerrno(uint16_t e_machine, int err);\n\n'
+	printf '__attribute__((unused)) const char *\n'
+	printf 'arch_syscalls__strerrno(uint16_t e_machine, int err)\n'
 	printf '{\n'
+	printf '\tswitch (e_machine) {\n'
 	for arch in $archlist; do
 		arch_str=$(arch_string "$arch")
-		printf '\tif (!strcmp(arch, "%s"))\n' "$arch_str"
-		printf '\t\treturn errno_to_name__%s;\n' "$arch_str"
+		ems=$(arch_to_e_machine "$arch_str")
+		if [ -n "$ems" ]; then
+			printf '%s\n' "$ems"
+			printf '\t\treturn errno_to_name__%s(err);\n' "$arch_str"
+		fi
 	done
 	arch_str=$(arch_string "$default")
-	printf '\treturn errno_to_name__%s;\n' "$arch_str"
+	printf '\tdefault:\n\t\treturn errno_to_name__%s(err);\n' "$arch_str"
+	printf '\t}\n'
 	printf '}\n'
 }
 
@@ -74,6 +103,8 @@ cat <<EoHEADER
 /* SPDX-License-Identifier: GPL-2.0 */
 
 #include <string.h>
+#include <stdint.h>
+#include <elf.h>
 
 EoHEADER
 
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index b8331d4dd347..0db74ee05d08 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -863,17 +863,14 @@ const char *perf_env__arch(struct perf_env *env)
 	return env->arch ?: arch;
 }
 
-const char *perf_env__arch_strerrno(struct perf_env *env __maybe_unused, int err __maybe_unused)
-{
-#if defined(HAVE_LIBTRACEEVENT)
-	if (env->arch_strerrno == NULL)
-		env->arch_strerrno = arch_syscalls__strerrno_function(perf_env__arch(env));
+const char *arch_syscalls__strerrno(uint16_t e_machine, int err);
 
-	return env->arch_strerrno ? env->arch_strerrno(err) : "no arch specific strerrno function";
-#else
-	return "!HAVE_LIBTRACEEVENT";
-#endif
+#if defined(HAVE_LIBTRACEEVENT)
+const char *perf_env__arch_strerrno(uint16_t e_machine, int err)
+{
+	return arch_syscalls__strerrno(e_machine, err);
 }
+#endif
 
 const char *perf_env__cpuid(struct perf_env *env)
 {
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index dd9907dbc345..ba51b871c401 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -67,8 +67,6 @@ struct cpu_domain_map {
 	struct domain_info	**domains;
 };
 
-typedef const char *(arch_syscalls__strerrno_t)(int err);
-
 struct perf_env {
 	char			*hostname;
 	char			*os_release;
@@ -158,7 +156,6 @@ struct perf_env {
 		 */
 		bool	enabled;
 	} clock;
-	arch_syscalls__strerrno_t *arch_strerrno;
 };
 
 enum perf_compress_type {
@@ -191,8 +188,9 @@ void cpu_cache_level__free(struct cpu_cache_level *cache);
 uint16_t perf_env__e_machine_nocache(struct perf_env *env, uint32_t *e_flags);
 uint16_t perf_env__e_machine(struct perf_env *env, uint32_t *e_flags);
 const char *perf_env__arch(struct perf_env *env);
-const char *perf_env__arch_strerrno(struct perf_env *env, int err);
-arch_syscalls__strerrno_t *arch_syscalls__strerrno_function(const char *arch);
+#if defined(HAVE_LIBTRACEEVENT)
+const char *perf_env__arch_strerrno(uint16_t e_machine, int err);
+#endif
 const char *perf_env__cpuid(struct perf_env *env);
 const char *perf_env__raw_arch(struct perf_env *env);
 int perf_env__nr_cpus_avail(struct perf_env *env);
diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
index 84713b2a7ad5..d5d2958902c0 100644
--- a/tools/perf/util/libdw.c
+++ b/tools/perf/util/libdw.c
@@ -130,7 +130,7 @@ static int libdw_a2l_cb(Dwarf_Die *die, void *_args)
 	return 0;
 
 abort_delete_sym:
-	if (inline_sym->inlined)
+	if (symbol__inlined(inline_sym))
 		symbol__delete(inline_sym);
 abort_enomem:
 	args->err = -ENOMEM;
-- 
2.54.0.823.g6e5bcc1fc9-goog

