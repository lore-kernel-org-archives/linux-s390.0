Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1A83168FB
	for <linux-s390@vger.kernel.org>; Sat,  2 May 2026 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777705221; cv=none; b=Pp5TsvU4brZikHi7SMdbrQ+a7HQGNFNDQfjZwsJXyE5N1PCFRldRiqnNJA9tUSMk3j2lgAGYzBs8AhAtcg5+awkb/f02zIu4BIpRmif+w1zQTvOGdRGVYOZ0otO9bqC5KHI7/uj0Pd6pz2aVWmrVVhIcvscz0KmA+n+gytq4Etg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777705221; c=relaxed/simple;
	bh=+Cl1G/nddw26s0e/jdTjYJbJetplE+ZRQZhfLxtQ3pY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qFU0cs95udKh78M6bi68B5zsRfBUg91Mk3biO+XQCanXX7jfbAiHau2m8D9ky+60XdRh6q/9lYxwDlDopZwYPmvBjzAC2Tqs9Ofl3O2jCerdG5yl/c9WtpaPxVON8Kl30LRgyMbAk2e4bgZNbBNO3xaAw1nouUnjC7qleZUxowE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ef3Q57NW; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ef3Q57NW"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c35f2c09dso3492416c88.0
        for <linux-s390@vger.kernel.org>; Sat, 02 May 2026 00:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777705219; x=1778310019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zvI9UJNOPT800HWIPIx+1jvWqW+QsHZl+3ObCWjaf40=;
        b=Ef3Q57NWaUnlzkVBGA9fMWTDlQa1lTpinrYZhQyJeiq3uLnEeXN5V2uA8BZOkZYkMT
         viH2FXb3AJDxm67Cr3AWI3HghYtbnxikrv/1S+nXSC2v0M8x8l67g4RG2VCw/22eXxpN
         pEWGmx2HmL7YFj0OHm3pHlnfKTKxSFFQwTQJOMC1YggXq9odjWMbhru6b2+RcxFTT0pJ
         W4NN7+qrtMQvR0w4kj0JhfdRUtD2USTj2qkjhxwh899mpfQt0pt9Xmq38hngnAdM+qXr
         a+xyvgVuQ6WHVaiCB07S/DcuJbWyL4w7/4TBml9X1hVad47SRgf6gCgK67+/7h3iJ1JA
         aMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777705219; x=1778310019;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvI9UJNOPT800HWIPIx+1jvWqW+QsHZl+3ObCWjaf40=;
        b=qMLcuGISvBcjXs9h8WOkV7Jc1HKUnqExCmYzGGjYYZTAoLeFw/5UuG0fV3eQ+sUNik
         fLgKQpglZwHX9PxRu/NDv8oCczyiPFZPgXNWr9CNyEyfOxcs70gbKY5h26KVi7Ebs5re
         HY/qRqJ1cK4od8BWFSmOMbd0WUBtBvkiDAkO3JlAM4Jz+7iiXdT8fj22Qp2Ts7LHXqi4
         dLOZOM08KIvmAiiBF/hSg7pid5JepZgh90LmaLNC23SKP5FT0dRuHxnlw3Zq/sJ8uDrI
         KVM0gSHmEbRuQKuY7fizQ0j6qzsXZlstuxep6XXyy17Ohj8vMqNj23VE/uDR3U6jslXx
         inag==
X-Forwarded-Encrypted: i=1; AFNElJ9USYKjd0vTKjMSaC6P5dPFsoj1reoz6n9SLUWjzysJjlXF23pVIxnmmSYWirsz92KIkhRztcKXbDSY@vger.kernel.org
X-Gm-Message-State: AOJu0YwxXicbwOGcRXdlcvXdXiS+7/rEB4y2LiAevz02WrucAHPxYGoI
	urEItmIxEIRXIxtoruI4Gsqf34hicAL/W2M97roPfmY5QUylb8jIjIYJa9hQpswbaZqYexVYGXc
	CJJbqPZpKXA==
X-Received: from dlbcm1.prod.google.com ([2002:a05:7022:6881:b0:12c:177a:ac1d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:61a:b0:128:bf8d:44d2
 with SMTP id a92af1059eb24-12dfd7ae6eemr947303c88.2.1777705219127; Sat, 02
 May 2026 00:00:19 -0700 (PDT)
Date: Fri,  1 May 2026 23:59:31 -0700
In-Reply-To: <20260502065935.291960-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409230620.4176210-2-irogers@google.com> <20260502065935.291960-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502065935.291960-14-irogers@google.com>
Subject: [PATCH v8 13/17] perf env: Refactor perf_env__arch_strerrno
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
 tools/perf/builtin-trace.c                  |  5 ++-
 tools/perf/trace/beauty/arch_errno_names.sh | 40 ++++++++++++++++++---
 tools/perf/util/env.c                       | 13 +++----
 tools/perf/util/env.h                       |  7 ++--
 4 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e58c49d047a2..d1f21b5e7c98 100644
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
@@ -4890,7 +4889,7 @@ static size_t syscall__dump_stats(struct trace *trace, int e_machine, FILE *fp,
 
 				for (e = 0; e < stats->max_errno; ++e) {
 					if (stats->errnos[e] != 0)
-						fprintf(fp, "\t\t\t\t%s: %d\n", perf_env__arch_strerrno(trace->host->env, e + 1), stats->errnos[e]);
+						fprintf(fp, "\t\t\t\t%s: %d\n", perf_env__arch_strerrno(e_machine, e + 1), stats->errnos[e]);
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
index 4ff4caab3b32..97f4aa1131a1 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -786,17 +786,12 @@ const char *perf_env__arch(struct perf_env *env)
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
index 7151a9138e3f..68dead1b36a6 100644
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
@@ -190,7 +187,9 @@ void cpu_cache_level__free(struct cpu_cache_level *cache);
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

