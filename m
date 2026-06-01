Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0B73806CD
	for <linux-s390@vger.kernel.org>; Mon,  1 Jun 2026 06:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296865; cv=none; b=oZFRlriB18heAH9S9a78fsAqOaWtAVAAu8QQibqyqdqTc/IxJ1snQGVHais4p+7Mi2yighGG2cb1yUD66ofstwRS4H1wntE3zl+7gu3hlnsYzRVLCWLaxSc9UBMWcg1i8VPnBHEdOhOpQV2iqHpL0UyYzwMnQtwGCqmyKuX+vjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296865; c=relaxed/simple;
	bh=xiNyuixfvZSVBPpWnPyAbuM4RcR6DKqp5rCTPFn5Vr8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n+DJ++lnHKNYiLZ1mVSt8nMkVQSAllhiCthNXoXjtRKG97vxmtmfcQvak7zqBT1uM6oeK/8lndDp2povnfTE5M08JVisS/tJcISJqdNdf6++SfJEGd9SWlArMw97wDWoW7MzornJEVdoJheetHjjKHopOLiJO4yag+bVf5jAr/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LtJRf6zM; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LtJRf6zM"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137dd516985so1655538c88.1
        for <linux-s390@vger.kernel.org>; Sun, 31 May 2026 23:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780296859; x=1780901659; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H+Hx7srfn40If55DPatzqKalqdjucGxcj8cFUkFjYzg=;
        b=LtJRf6zMD2DwMAXruvGjkYK3URz42NF1ypqPanTZw18vKLHpY7C91oqTXSRwKi9crs
         nOUW+8CxLfltkjeRXBaFIavWVOfvbfPvMs52sh9ApPbcogN3rm6AuQhx+AY/NYYd58ga
         cj91jW8pNzJvgJwEup+RQ2X8LG/gUp2ihNJkecAX96lBSrJzfmLaDF/f0MsWUCqhSj9i
         sfwW6aU8cWNApaRtRxJttGzTXSAnynXfPmxnj3cUpDl0eQRkLzIg9aVSI1+XvwKx4gIY
         7m5tRwoxpgDD3c//OjMrS09hBsfzLf0PqjbhyBI7ih92yqzAh17mCyXjbrS8hIn3UNMC
         NsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780296859; x=1780901659;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+Hx7srfn40If55DPatzqKalqdjucGxcj8cFUkFjYzg=;
        b=gzu1COA4yBHCk5vLHU+EbDQEKpWyKMAZA13B6hV7l69SGfymKakgAQtjikr9msLgyO
         QTmvkF+7j92/DdQ5znnWyu+XDElSnQdwemNbxx/Wrpq+mMHZ0wkh6qUNjS3tMsogsUmt
         cnMSywIvFOCNnuuVQBl5q3+6V7C5cpBgMwFTQLFC6rSDh3O/Ko8x0JDWnXBkDS06dzyZ
         4+bqEM6Mj7QepLg4cU/o33Tm7wbCN/tdVszysUywaqB22Zhy+oEIFOAT2SQccWHwGZAy
         Yv7wx1CQ4C2eI5bUCfuV9tvrb42OP+xkerU1Uel7m0ElxBgBrI/XRye52sQsZOBFKxzk
         aXzg==
X-Forwarded-Encrypted: i=1; AFNElJ+z7hXIuTQ883mHVaso2eL8xNr+bowKM4i6rmYgAN3O7BsnXwbBAM9OJAl39PFepTPJbd9ZcWLoqJEN@vger.kernel.org
X-Gm-Message-State: AOJu0YwAk4g3C02gixa3hlCLCrG2qw9O1yeho02N87faygXv3YlF/6iL
	pYT8RW+fg3L/z8a8r04CDSKRdhQKHJOMR6wrceLRJLs0DMhaUH0T5C0ZL0TBshN0Pdcv025jcrw
	q/gSAkrRBDQ==
X-Received: from dlkk5.prod.google.com ([2002:a05:7022:6085:b0:135:dc3d:ab61])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ef18:b0:134:a710:d908
 with SMTP id a92af1059eb24-137d3e03856mr4145694c88.13.1780296858971; Sun, 31
 May 2026 23:54:18 -0700 (PDT)
Date: Sun, 31 May 2026 23:53:52 -0700
In-Reply-To: <20260601065407.1597927-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503002248.1040791-1-irogers@google.com> <20260601065407.1597927-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601065407.1597927-4-irogers@google.com>
Subject: [PATCH v10 03/18] perf env, dso, thread: Add _endian variants for
 e_machine helpers
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Add perf_arch_is_big_endian(), dso__read_e_machine_endian(),
dso__e_machine_endian(), and thread__e_machine_endian() to support
bi-endianness and cross-architecture analysis without breaking the
existing API.

These helpers allow querying the absolute endianness of a DSO or
thread, which is required for tools like Capstone that need to set the
correct disassembly mode.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c    | 19 +++++++++-----
 tools/perf/util/dso.h    | 14 +++++++++--
 tools/perf/util/env.c    | 16 ++++++++++++
 tools/perf/util/env.h    |  1 +
 tools/perf/util/thread.c | 54 ++++++++++++++++++++++++++++++----------
 tools/perf/util/thread.h | 23 ++++++++++++++++-
 6 files changed, 105 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index b791e1b6b2cf..7dced896c64e 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1220,7 +1220,8 @@ static enum dso_swap_type dso_swap_type__from_elf_data(unsigned char eidata)
 }
 
 /* Reads e_machine from fd, optionally caching data in dso. */
-uint16_t dso__read_e_machine(struct dso *optional_dso, int fd, uint32_t *e_flags)
+uint16_t dso__read_e_machine_endian(struct dso *optional_dso, int fd, uint32_t *e_flags,
+				    bool *is_big_endian)
 {
 	uint16_t e_machine = EM_NONE;
 	unsigned char e_ident[EI_NIDENT];
@@ -1250,6 +1251,9 @@ uint16_t dso__read_e_machine(struct dso *optional_dso, int fd, uint32_t *e_flags
 	if (swap_type == DSO_SWAP__UNSET)
 		return EM_NONE; // Bad ELF data encoding.
 
+	if (is_big_endian)
+		*is_big_endian = (e_ident[EI_DATA] == ELFDATA2MSB);
+
 	/* Cache the need for swapping. */
 	if (optional_dso) {
 		assert(dso__needs_swap(optional_dso) == DSO_SWAP__UNSET ||
@@ -1288,7 +1292,8 @@ uint16_t dso__read_e_machine(struct dso *optional_dso, int fd, uint32_t *e_flags
 	return e_machine;
 }
 
-uint16_t dso__e_machine(struct dso *dso, struct machine *machine, uint32_t *e_flags)
+uint16_t dso__e_machine_endian(struct dso *dso, struct machine *machine, uint32_t *e_flags,
+			       bool *is_big_endian)
 {
 	uint16_t e_machine = EM_NONE;
 	int fd;
@@ -1308,9 +1313,11 @@ uint16_t dso__e_machine(struct dso *dso, struct machine *machine, uint32_t *e_fl
 	case DSO_BINARY_TYPE__BPF_IMAGE:
 	case DSO_BINARY_TYPE__OOL:
 	case DSO_BINARY_TYPE__JAVA_JIT:
-		if (e_flags)
-			*e_flags = EF_HOST;
-		return EM_HOST;
+		if (is_big_endian) {
+			*is_big_endian = perf_arch_is_big_endian(
+				machine && machine->env ? perf_env__arch(machine->env) : NULL);
+		}
+		return perf_env__e_machine(machine ? machine->env : NULL, e_flags);
 	case DSO_BINARY_TYPE__DEBUGLINK:
 	case DSO_BINARY_TYPE__BUILD_ID_CACHE:
 	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
@@ -1338,7 +1345,7 @@ uint16_t dso__e_machine(struct dso *dso, struct machine *machine, uint32_t *e_fl
 	try_to_open_dso(dso, machine);
 	fd = dso__data(dso)->fd;
 	if (fd >= 0)
-		e_machine = dso__read_e_machine(dso, fd, e_flags);
+		e_machine = dso__read_e_machine_endian(dso, fd, e_flags, is_big_endian);
 	else if (e_flags)
 		*e_flags = 0;
 
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index ede691e9a249..2916b954a804 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -866,8 +866,18 @@ int dso__data_file_size(struct dso *dso, struct machine *machine);
 off_t dso__data_size(struct dso *dso, struct machine *machine);
 ssize_t dso__data_read_offset(struct dso *dso, struct machine *machine,
 			      u64 offset, u8 *data, ssize_t size);
-uint16_t dso__read_e_machine(struct dso *optional_dso, int fd, uint32_t *e_flags);
-uint16_t dso__e_machine(struct dso *dso, struct machine *machine, uint32_t *e_flags);
+uint16_t dso__read_e_machine_endian(struct dso *optional_dso, int fd, uint32_t *e_flags,
+				    bool *is_big_endian);
+static inline uint16_t dso__read_e_machine(struct dso *optional_dso, int fd, uint32_t *e_flags)
+{
+	return dso__read_e_machine_endian(optional_dso, fd, e_flags, NULL);
+}
+uint16_t dso__e_machine_endian(struct dso *dso, struct machine *machine, uint32_t *e_flags,
+			       bool *is_big_endian);
+static inline uint16_t dso__e_machine(struct dso *dso, struct machine *machine, uint32_t *e_flags)
+{
+	return dso__e_machine_endian(dso, machine, e_flags, NULL);
+}
 ssize_t dso__data_read_addr(struct dso *dso, struct map *map,
 			    struct machine *machine, u64 addr,
 			    u8 *data, ssize_t size);
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 23dcd7a108a1..b8331d4dd347 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -342,6 +342,22 @@ int perf_env__kernel_is_64_bit(struct perf_env *env)
 	return env->kernel_is_64_bit;
 }
 
+bool perf_arch_is_big_endian(const char *arch)
+{
+	if (!arch)
+		return __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__;
+
+	if (str_ends_with(arch, "_be") || !strcmp(arch, "sparc") || !strcmp(arch, "sparc64") ||
+	    !strcmp(arch, "s390") || !strcmp(arch, "s390x") || !strcmp(arch, "powerpc") ||
+	    !strcmp(arch, "ppc") || !strcmp(arch, "ppc64") ||
+	    !strcmp(arch, "mips") || !strcmp(arch, "mips64") || !strcmp(arch, "parisc") ||
+	    !strcmp(arch, "parisc64") || !strcmp(arch, "m68k") ||
+	    !strcmp(arch, "armeb") || !strcmp(arch, "mipseb") || !strcmp(arch, "mips64eb"))
+		return true;
+
+	return false;
+}
+
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[])
 {
 	int i;
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index bde192fd5be5..dd9907dbc345 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -175,6 +175,7 @@ void free_cpu_domain_info(struct cpu_domain_map **cd_map, u32 schedstat_version,
 void perf_env__exit(struct perf_env *env);
 
 int perf_env__kernel_is_64_bit(struct perf_env *env);
+bool perf_arch_is_big_endian(const char *arch);
 
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[]);
 
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index aac9cb75dcf4..23a0775a8260 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -56,6 +56,7 @@ struct thread *thread__new(pid_t pid, pid_t tid)
 		thread__set_cpu(thread, -1);
 		thread__set_guest_cpu(thread, -1);
 		thread__set_e_machine(thread, EM_NONE);
+		thread__set_e_is_big_endian(thread, false);
 		thread__set_lbr_stitch_enable(thread, false);
 		INIT_LIST_HEAD(thread__namespaces_list(thread));
 		INIT_LIST_HEAD(thread__comm_list(thread));
@@ -429,7 +430,7 @@ void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
 	}
 }
 
-static uint16_t read_proc_e_machine_for_pid(pid_t pid, uint32_t *e_flags)
+static uint16_t read_proc_e_machine_for_pid(pid_t pid, uint32_t *e_flags, bool *is_big_endian)
 {
 	char path[6 /* "/proc/" */ + 11 /* max length of pid */ + 5 /* "/exe\0" */];
 	int fd;
@@ -438,7 +439,8 @@ static uint16_t read_proc_e_machine_for_pid(pid_t pid, uint32_t *e_flags)
 	snprintf(path, sizeof(path), "/proc/%d/exe", pid);
 	fd = open(path, O_RDONLY);
 	if (fd >= 0) {
-		e_machine = dso__read_e_machine(/*optional_dso=*/NULL, fd, e_flags);
+		e_machine = dso__read_e_machine_endian(/*optional_dso=*/NULL, fd, e_flags,
+						       is_big_endian);
 		close(fd);
 	}
 	return e_machine;
@@ -448,6 +450,7 @@ struct thread__e_machine_callback_args {
 	struct machine *machine;
 	uint32_t e_flags;
 	uint16_t e_machine;
+	bool is_big_endian;
 };
 
 static int thread__e_machine_callback(struct map *map, void *_args)
@@ -458,24 +461,36 @@ static int thread__e_machine_callback(struct map *map, void *_args)
 	if (!dso)
 		return 0; // No dso, continue search.
 
-	args->e_machine = dso__e_machine(dso, args->machine, &args->e_flags);
+	args->e_machine =
+		dso__e_machine_endian(dso, args->machine, &args->e_flags, &args->is_big_endian);
 	return args->e_machine != EM_NONE ? 1 /* stop search */ : 0 /* continue search */;
 }
 
-uint16_t thread__e_machine(struct thread *thread, struct machine *machine, uint32_t *e_flags)
+uint16_t thread__e_machine_endian(struct thread *thread, struct machine *machine, uint32_t *e_flags,
+				  bool *is_big_endian)
 {
 	pid_t tid, pid;
-	uint16_t e_machine = RC_CHK_ACCESS(thread)->e_machine;
+	uint16_t e_machine;
 	uint32_t local_e_flags = 0;
-	struct thread__e_machine_callback_args args = {
-		.machine = machine,
-		.e_flags = 0,
-		.e_machine = EM_NONE,
-	};
+	struct thread__e_machine_callback_args args;
+
+	if (!thread) {
+		if (is_big_endian)
+			*is_big_endian = perf_arch_is_big_endian(NULL);
+		return perf_env__e_machine(machine ? machine->env : NULL, e_flags);
+	}
+
+	e_machine = RC_CHK_ACCESS(thread)->e_machine;
+	args.machine = machine;
+	args.e_flags = 0;
+	args.e_machine = EM_NONE;
+	args.is_big_endian = false;
 
 	if (e_machine != EM_NONE) {
 		if (e_flags)
 			*e_flags = thread__e_flags(thread);
+		if (is_big_endian)
+			*is_big_endian = thread__e_is_big_endian(thread);
 		return e_machine;
 	}
 
@@ -483,6 +498,7 @@ uint16_t thread__e_machine(struct thread *thread, struct machine *machine, uint3
 		struct maps *maps = thread__maps(thread);
 
 		machine = maps__machine(maps);
+		args.machine = machine;
 	}
 	tid = thread__tid(thread);
 	pid = thread__pid(thread);
@@ -490,7 +506,8 @@ uint16_t thread__e_machine(struct thread *thread, struct machine *machine, uint3
 		struct thread *parent = machine__findnew_thread(machine, pid, pid);
 
 		if (parent) {
-			e_machine = thread__e_machine(parent, machine, &local_e_flags);
+			e_machine = thread__e_machine_endian(parent, machine, &local_e_flags,
+							     &args.is_big_endian);
 			thread__put(parent);
 			goto out;
 		}
@@ -515,16 +532,27 @@ uint16_t thread__e_machine(struct thread *thread, struct machine *machine, uint3
 			is_live = !!session->data;
 		}
 		/* Read from /proc/pid/exe if live. */
-		if (is_live)
-			e_machine = read_proc_e_machine_for_pid(pid, &local_e_flags);
+		if (is_live) {
+			e_machine = read_proc_e_machine_for_pid(pid, &local_e_flags,
+								&args.is_big_endian);
+		} else if (machine && machine->env) {
+			/* Offline analysis: fallback to environment metadata. */
+			e_machine = perf_env__e_machine(machine->env, &local_e_flags);
+			args.is_big_endian = perf_arch_is_big_endian(perf_env__arch(machine->env));
+		}
 	}
 out:
 	if (e_machine != EM_NONE) {
 		thread__set_e_machine(thread, e_machine);
 		thread__set_e_flags(thread, local_e_flags);
+		thread__set_e_is_big_endian(thread, args.is_big_endian);
+		if (is_big_endian)
+			*is_big_endian = args.is_big_endian;
 	} else {
 		e_machine = EM_HOST;
 		local_e_flags = EF_HOST;
+		if (is_big_endian)
+			*is_big_endian = (__BYTE_ORDER__ == __ORDER_BIG_ENDIAN__);
 	}
 	if (e_flags)
 		*e_flags = local_e_flags;
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index f5792d3e8a16..d82fce8173ae 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -69,6 +69,11 @@ DECLARE_RC_STRUCT(thread) {
 	 * computed.
 	 */
 	uint16_t		e_machine;
+	/**
+	 * @e_is_big_endian: True if the ELF architecture of the thread is big endian.
+	 * Valid if e_machine != EM_NONE.
+	 */
+	bool			e_is_big_endian;
 	/* LBR call stack stitch */
 	bool			lbr_stitch_enable;
 	struct lbr_stitch	*lbr_stitch;
@@ -311,7 +316,13 @@ static inline void thread__set_filter_entry_depth(struct thread *thread, int dep
 	RC_CHK_ACCESS(thread)->filter_entry_depth = depth;
 }
 
-uint16_t thread__e_machine(struct thread *thread, struct machine *machine, uint32_t *e_flags);
+uint16_t thread__e_machine_endian(struct thread *thread, struct machine *machine, uint32_t *e_flags,
+				  bool *is_big_endian);
+static inline uint16_t thread__e_machine(struct thread *thread, struct machine *machine,
+					 uint32_t *e_flags)
+{
+	return thread__e_machine_endian(thread, machine, e_flags, NULL);
+}
 
 static inline void thread__set_e_machine(struct thread *thread, uint16_t e_machine)
 {
@@ -328,6 +339,16 @@ static inline void thread__set_e_flags(struct thread *thread, uint32_t e_flags)
 	RC_CHK_ACCESS(thread)->e_flags = e_flags;
 }
 
+static inline bool thread__e_is_big_endian(const struct thread *thread)
+{
+	return RC_CHK_ACCESS(thread)->e_is_big_endian;
+}
+
+static inline void thread__set_e_is_big_endian(struct thread *thread, bool is_big_endian)
+{
+	RC_CHK_ACCESS(thread)->e_is_big_endian = is_big_endian;
+}
+
 
 static inline bool thread__lbr_stitch_enable(const struct thread *thread)
 {
-- 
2.54.0.823.g6e5bcc1fc9-goog

