Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5DF215F42
	for <linux-s390@vger.kernel.org>; Sun,  3 May 2026 00:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777767803; cv=none; b=TSyGjGe+9OTQ4LJcYz3spchYNHSZjg99821YNO8cnfRFOKj9r8Vs/bnhwOP8kCdZq//SxCgd1cEPsBcsGai4fJ0Nj2bRqy1pphn0fJsSldmD3jA63MUKaW/fTGyqoZC6vOK19TT0wBPiPkD1DZpW6HQJULWVbltIzh6ntWFk3sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777767803; c=relaxed/simple;
	bh=5jhU6nHm5t52x/E6UfkGF7nwddgtnU+zivsqR1+Mzjk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zgb64sbCG9+wPbai2Yy6t8Wx6r0K/shsJJjvZZjp6lpx9yqLEWPYvaKwDow1XyOtFqGIF+4hex3CeGZxmkSpLuQNB3teYBXOvKvgu8tlGtJCQL6fzHroRDzoXcLP2nlA5RyMJ/CMTJTv41Ss02hQGzy1V6XPYU7rH0SMAzrtEFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TYceMjjb; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TYceMjjb"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so4566408eec.1
        for <linux-s390@vger.kernel.org>; Sat, 02 May 2026 17:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777767801; x=1778372601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=osisIhDCjYBr9yPonf3Zb/MCBx8M3bxED2pwUnaO1Z4=;
        b=TYceMjjbMCAx09wqdZsUILtf/KsVZt555XHv9Mxm6UadLzOY3I7yq3xnwyz4V6lw7U
         kQdp2+JAzvl7IlfGR9xHnpEdfowacawVtBFkzQcq9Snsx6kaN/NH7yX9CcrI9BHzOnJA
         fAAR3F87KNYAgdC2KsGj5hVPQM+Pi75uSbJaJ2YadPrQvk+VmWDrl2jq4r41wtQYkSgz
         kQse58jCTI4rqOuwsuZDmt89htv9WDA2Y/2n48Z4hUWz9F0x7rADNRVZn0PZujxbGrKq
         159TP4cnYzqCL0hVixIkk5X2eie6rVxLrTtbB2bKvSk9dd2LewUWEpOjjqvkiRnLeEPw
         CdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777767801; x=1778372601;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=osisIhDCjYBr9yPonf3Zb/MCBx8M3bxED2pwUnaO1Z4=;
        b=FyXJzWaLWLSWKWTsu+1x+vl2nJ8F5j4S77urlTgpgjL7l3N4cBKzYRvv5OS8WzNN6S
         QB5T37LD7fVCUz7Gkuv2tNNNFmpTjZXNWs3TRJ6azKAy28+Xacm9l7PNlEi5jnsrQrOo
         PwJEzhZtMABGJo4ScSzVmPc4BGH3Azy6/4HJOLtQo047tp1LEbK9pxzgaYIHUOGF7QVF
         2iO4lw+1H28sAJx4Iw6Vas+qy2Klw4XFpRnviNgpwgVRGYZxpCjdSIa+slHdqEKIJRVg
         mQQQedLn+EGbwjDsZUB3OrEk4v1vcXh/5QS4I/YIzMBM4ZJjEMWqxrGBW7AYu1RGSpr8
         r/vw==
X-Forwarded-Encrypted: i=1; AFNElJ9s6iMjhK6V7Dl5rNfxc29Lt5CmlqNocePcYov/E8l5Ik4ZMU9lsP3Qd+mljqotx8r5olfe1/ucJaHt@vger.kernel.org
X-Gm-Message-State: AOJu0YzsgC6sgtWDPrKN5UmjDdddY3nSvEI4ghsbLicELCaTUfAJfnXN
	InD/SdraTLtfSL0x7E8LAP0Acswpvj4Xsb8bq44mHtnwzJ1Fqbd8LsMkO2g6ToORplxrNrJtkag
	ViwDxarDbPA==
X-Received: from dleb18-n1.prod.google.com ([2002:a05:701b:4252:10b0:12c:1286:e1ba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:50f:b0:12a:6c4b:9d01
 with SMTP id a92af1059eb24-12dfd79e70fmr1907543c88.7.1777767800375; Sat, 02
 May 2026 17:23:20 -0700 (PDT)
Date: Sat,  2 May 2026 17:22:44 -0700
In-Reply-To: <20260503002248.1040791-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502065935.291960-1-irogers@google.com> <20260503002248.1040791-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503002248.1040791-15-irogers@google.com>
Subject: [PATCH v9 14/18] perf env: Refactor perf_env__arch_strerrno
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
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
 tools/perf/trace/beauty/arch_errno_names.sh | 40 ++++++++++++++++++---
 tools/perf/util/env.c                       | 13 +++----
 tools/perf/util/env.h                       |  7 ++--
 4 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e58c49d047a2..d278af18542f 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3008,9 +3008,8 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 	} else if (ret < 0) {
 errno_print: {
 		char bf[STRERR_BUFSIZE];
-		struct perf_env *env = evsel__env(evsel) ?: &trace->host_env;
 		const char *emsg = str_error_r(-ret, bf, sizeof(bf));
-		const char *e = perf_env__arch_strerrno(env, err);
+		const char *e = perf_env__arch_strerrno(e_machine, err);
 
 		fprintf(trace->output, "-1 %s (%s)", e, emsg);
 	}
@@ -4890,7 +4889,9 @@ static size_t syscall__dump_stats(struct trace *trace, int e_machine, FILE *fp,
 
 				for (e = 0; e < stats->max_errno; ++e) {
 					if (stats->errnos[e] != 0)
-						fprintf(fp, "\t\t\t\t%s: %d\n", perf_env__arch_strerrno(trace->host->env, e + 1), stats->errnos[e]);
+						fprintf(fp, "\t\t\t\t%s: %d\n",
+							perf_env__arch_strerrno(e_machine, e + 1),
+							stats->errnos[e]);
 				}
 			}
 			lines++;
diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/trace/beauty/arch_errno_names.sh
index b22890b8d272..89b742927168 100755
--- a/tools/perf/trace/beauty/arch_errno_names.sh
+++ b/tools/perf/trace/beauty/arch_errno_names.sh
@@ -52,21 +52,49 @@ process_arch()
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
 
-	printf 'static arch_syscalls__strerrno_t *\n'
-	printf 'arch_syscalls__strerrno_function(const char *arch)\n'
+	printf 'static const char *\n'
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
 
@@ -74,6 +102,8 @@ cat <<EoHEADER
 /* SPDX-License-Identifier: GPL-2.0 */
 
 #include <string.h>
+#include <stdint.h>
+#include <elf.h>
 
 EoHEADER
 
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 1a4db133262b..8ac7aff0b27c 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -798,17 +798,12 @@ const char *perf_env__arch(struct perf_env *env)
 #include "trace/beauty/arch_errno_names.c"
 #endif
 
-const char *perf_env__arch_strerrno(struct perf_env *env __maybe_unused, int err __maybe_unused)
-{
 #if defined(HAVE_LIBTRACEEVENT)
-	if (env->arch_strerrno == NULL)
-		env->arch_strerrno = arch_syscalls__strerrno_function(perf_env__arch(env));
-
-	return env->arch_strerrno ? env->arch_strerrno(err) : "no arch specific strerrno function";
-#else
-	return "!HAVE_LIBTRACEEVENT";
-#endif
+const char *perf_env__arch_strerrno(uint16_t e_machine, int err)
+{
+	return arch_syscalls__strerrno(e_machine, err);
 }
+#endif
 
 const char *perf_env__cpuid(struct perf_env *env)
 {
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index c355df2dba7b..ba51b871c401 100644
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
@@ -191,7 +188,9 @@ void cpu_cache_level__free(struct cpu_cache_level *cache);
 uint16_t perf_env__e_machine_nocache(struct perf_env *env, uint32_t *e_flags);
 uint16_t perf_env__e_machine(struct perf_env *env, uint32_t *e_flags);
 const char *perf_env__arch(struct perf_env *env);
-const char *perf_env__arch_strerrno(struct perf_env *env, int err);
+#if defined(HAVE_LIBTRACEEVENT)
+const char *perf_env__arch_strerrno(uint16_t e_machine, int err);
+#endif
 const char *perf_env__cpuid(struct perf_env *env);
 const char *perf_env__raw_arch(struct perf_env *env);
 int perf_env__nr_cpus_avail(struct perf_env *env);
-- 
2.54.0.545.g6539524ca2-goog

