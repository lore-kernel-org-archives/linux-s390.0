Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237FA3A9D8F
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 06:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381541; cv=none; b=BpZmdQXCITq3NK5Ne7EEeZqA7vxy7fhJCpGCJdIap9PEoiXns6UoRmzHWtsTmZcuCJM7+GQYARSU0M6Ar+MG0peshgyIPHRj6soMuUdbxWRKKC3dpmpYO3H7Vhfx1GFGL58dVsDVg9erpgiztk6ZEurdZFUvNHYoiFM+47Sc7h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381541; c=relaxed/simple;
	bh=SqxISLW1CA6sEUZz+3i2XQAzpM0vkpmankpAgb9Yfl4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h5OgDjAQvvSpuszaW1GhnqrsxHx2VpcpV9SfZoKGSsieuzaNponSJZ0hvvu5VQUAFnxlKIIUtjSmBoNd5BcW1bNlOKyBewLYkS6mXNAZtnQP/rIJU3VChwB2SWgUxyV0UCyL/9j7Mns7lhajrgLJAoTZke7nw6588jjqgO0NMj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dmWzo0IJ; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dmWzo0IJ"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304f23c55b2so3584859eec.0
        for <linux-s390@vger.kernel.org>; Mon, 01 Jun 2026 23:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780381538; x=1780986338; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LATv8zYjtJ7yPtRej1rBNl3vNhfPbdBjAvEhoz51t4o=;
        b=dmWzo0IJYxyMk7HRMRLAnwTlAsi7+S9J4Pr1+bnp5uQjYO4euZRK5nAUZD5MY4TAvA
         CelWpvMIGADkfrmtmif5bKrljXs4INxCTynWpgD/pmR7KT+QcQ8ELzu/hPkD7Nlqwwss
         qsGZULidTq1jp9ygnXetKQW8AYxV+nkErgEYB3XBJHE2tBx7sl+tSFVeHlpedvWwrQn1
         GDODvG7ZnhDOSa+9HdjP8OCzmyBm86pvccTKoAP9qiDVKsMIpEGIFxs24Yr9s8Yiw3KC
         Hl0fngcA/kP4FqwgPM5VEzFlQx5iG8/Jx+W16+C3ffHgBdmnwxiGBJtsed2dEks7GCYo
         o4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780381538; x=1780986338;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LATv8zYjtJ7yPtRej1rBNl3vNhfPbdBjAvEhoz51t4o=;
        b=Ii4W1LCQEZjje48OiRVwZXS6X4g1ESw94sbviz2aSVBnXeVXWlBtf9x1nUZzTG2AQX
         nxaxdahBeC6Y5+4nuY1Ar+XfEUxFOo3waFnJ+tyAt8x6IPftL/d0G6mkEz6TYFJPlVaw
         fKsCGRkJqroncZBF9M3SJA2p4HXZcKsPg/BfHMAasyyzsCcP7yILRUHsxfPIq/NJGd3q
         nl3l4Gqw1IpYCf3mJq+s+lPi8NwMGnWdZY3ZJZWos4Q4QCSYJxymZ3t1NcY/96EXaH3W
         6+CnA6AN0RsxxSSyZ37MHPcFmqIbgEQe61bKQnevcTy1p5ylh5tZzDM+r+78I0lLNX0U
         4v6Q==
X-Forwarded-Encrypted: i=1; AFNElJ+t/kcer8WSnda3NyZIq/uRfov0G7tYvCfxE09MHvTfh7fZJcZ/BWJ45KSvj0yiB7d1LlSWC4AaBr7H@vger.kernel.org
X-Gm-Message-State: AOJu0YzLJgbki11TKiXsrIVI7hobDBONVAxmlzJTQ9qxiUD7vDpWHG0U
	dByIPnP+26VfdWGNEv8EWk/VlNrK7KUPXk8ZVZ8MpchlC348NLR+3IpJV8PY6SLtXP+btSEod8f
	l7AOho6FAvg==
X-Received: from dycpw7.prod.google.com ([2002:a05:7300:de47:b0:2f9:af7:5043])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2c86:b0:304:5b65:5971
 with SMTP id 5a478bee46e88-304fa64c86cmr6484195eec.20.1780381538079; Mon, 01
 Jun 2026 23:25:38 -0700 (PDT)
Date: Mon,  1 Jun 2026 23:24:46 -0700
In-Reply-To: <20260602062452.2583619-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601065407.1597927-1-irogers@google.com> <20260602062452.2583619-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602062452.2583619-15-irogers@google.com>
Subject: [PATCH v11 14/19] perf env: Refactor perf_env__arch_strerrno
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
 tools/perf/util/env.c                       | 13 ++-----
 tools/perf/util/env.h                       |  6 +--
 5 files changed, 46 insertions(+), 22 deletions(-)

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
index fae70b07ba8d..b41562fb06c6 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -851,16 +851,11 @@ const char *perf_env__arch(struct perf_env *env)
 	return arch;
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
+const char *perf_env__arch_strerrno(uint16_t e_machine, int err)
+{
+	return arch_syscalls__strerrno(e_machine, err);
 }
 
 const char *perf_env__cpuid(struct perf_env *env)
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index dd9907dbc345..5a917271ca0d 100644
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
@@ -191,8 +188,7 @@ void cpu_cache_level__free(struct cpu_cache_level *cache);
 uint16_t perf_env__e_machine_nocache(struct perf_env *env, uint32_t *e_flags);
 uint16_t perf_env__e_machine(struct perf_env *env, uint32_t *e_flags);
 const char *perf_env__arch(struct perf_env *env);
-const char *perf_env__arch_strerrno(struct perf_env *env, int err);
-arch_syscalls__strerrno_t *arch_syscalls__strerrno_function(const char *arch);
+const char *perf_env__arch_strerrno(uint16_t e_machine, int err);
 const char *perf_env__cpuid(struct perf_env *env);
 const char *perf_env__raw_arch(struct perf_env *env);
 int perf_env__nr_cpus_avail(struct perf_env *env);
-- 
2.54.0.929.g9b7fa37559-goog

