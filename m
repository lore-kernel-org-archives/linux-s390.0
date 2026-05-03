Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61491F1932
	for <linux-s390@vger.kernel.org>; Sun,  3 May 2026 00:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777767781; cv=none; b=p/socuaBSoNIamJzRCYUNUA/1DilanYeTh6NsuWj7VUNQbMAwic7yIIK7abFFLJ4euRUfEd5tiNWrLxhpzdDAiO/q6yJzClxO/P8MD9kJPclb1vlPzNS8Jry/eQV9Cv8vtf/ma7EYO8Q5nzX05Ah9R4iRqpQNAucp2smf5ECfEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777767781; c=relaxed/simple;
	bh=8PL93q6LEy/RmlxfgsqWPGb3e4SH9u+3BZxs6IJPiDY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H4Rus4/aF1au/P7OuJa6BF3ALJtNdkUxwRdrw5Qb8aJ3YPtfmnbV/ldC3U7EZ+vbtLQJnYuUm1ThE8ipbv8pVnqJuHnR8E99wN2fUdjkGQYirPImWrWuQwNcugWAQADhRfAYRyz8beycSuRoFK0ULf6UxZau8NvXy34j1JKmELk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BCWsFuDd; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BCWsFuDd"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12dfe06b670so4797302c88.0
        for <linux-s390@vger.kernel.org>; Sat, 02 May 2026 17:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777767779; x=1778372579; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yEm+9CK0i9MQLsvr/lRfYtx0/DM0+D55tOmGa7sB074=;
        b=BCWsFuDdKVZ3V7mTxBVAfb/uz+mHwskt56L7B9lAfc3+RUCUrOBADivfzyRX02v9hu
         H4bERbZvBK1fDIbzonTRnxuwhRcPzZIZ8aLKz4GxoA6BpdKp9qyAkziKvee7Z/jg+lfp
         kXxYc9rzW1arGGNlNLPIDfqRwbwfkZoT9hik/eYISEqhumib+JEDEYgrRvRfLtpWqGeR
         JMyTCe+5hIq7uXtAi7sVkg+Lq4S4grPR26t107iNsnTcNl8jVeTuLHCZ/MZSOIPc0gFq
         WO87L+tcDMn32GynvxVDts4SqrFee9Bj0bkHTP5a52SX9j0I/ius7AI74xDeD2UGMqw9
         2Nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777767779; x=1778372579;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yEm+9CK0i9MQLsvr/lRfYtx0/DM0+D55tOmGa7sB074=;
        b=VujQb8LbMzEp5kN/p4vF3w7gGQ8n6Y3HNRZdWH7Ze66vny4hS1oQXNCCAu/khLQidF
         h+igf/IQD6jcT402W8EHcmqzX+fFwwEddnFydTM/jPIPa1zS3gwWGf8O63DaZBrztqtI
         vt1E5QpQVHBZjElBCT3uy7BkwCcIzdPM05iNqd1HHEmuCm8pA9lArtLwSdawNBCFMGLb
         5Xw9Wdz6Wd4TaJhecPVKBhPo8Bv7NqBNr4vja9Du46zkM2ndn8G8XLLCiW82QRX2Hg97
         t69jhntqF+7ps8Ytegl9z+r9cZfE/ixt8UbLf246JKmaSrAoB80CZuGVs7RLOFYoWv1/
         5iWw==
X-Forwarded-Encrypted: i=1; AFNElJ8DrVuyEEwOdcQ8vxhGvOF7kdlsoaNwKRw7Uzpubowdag5BqnXVxIE9QyZ3ytjZKfSxD3TqTP7l2MUT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv5ouxLYldZBwQ1J8WF8bbT5sT1xhEvpwsrYwiEsy23agAJipJ
	zoR5R4zAwRfnAXPDCom0W1Pn2MTFb1kTuoOmGOMF++hf8VG4X4QanD61WEdwvtuYU9Cum2gA70I
	jjpULuVBjWA==
X-Received: from dlai27.prod.google.com ([2002:a05:701b:271b:b0:12c:8c98:df0e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4391:b0:128:ce44:be8f
 with SMTP id a92af1059eb24-12dfd7da1c2mr1992714c88.2.1777767778906; Sat, 02
 May 2026 17:22:58 -0700 (PDT)
Date: Sat,  2 May 2026 17:22:33 -0700
In-Reply-To: <20260503002248.1040791-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502065935.291960-1-irogers@google.com> <20260503002248.1040791-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503002248.1040791-4-irogers@google.com>
Subject: [PATCH v9 03/18] perf env, dso, thread: Add _endian variants for
 e_machine helpers
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
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
 tools/perf/util/dso.c    | 19 +++++++++++++------
 tools/perf/util/dso.h    | 14 ++++++++++++--
 tools/perf/util/env.c    | 12 ++++++++++++
 tools/perf/util/env.h    |  1 +
 tools/perf/util/thread.c | 22 ++++++++++++++++------
 tools/perf/util/thread.h |  8 +++++++-
 6 files changed, 61 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index b791e1b6b2cf..6439b2a3c898 100644
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
+				machine && machine->env ? machine->env->arch : NULL);
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
index 0edc67a468ab..1a4db133262b 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -339,6 +339,18 @@ int perf_env__kernel_is_64_bit(struct perf_env *env)
 	return env->kernel_is_64_bit;
 }
 
+bool perf_arch_is_big_endian(const char *arch)
+{
+	if (!arch)
+		return __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__;
+
+	if (str_ends_with(arch, "_be") || !strcmp(arch, "sparc") || !strcmp(arch, "sparc64") ||
+	    !strcmp(arch, "s390") || !strcmp(arch, "s390x") || !strcmp(arch, "powerpc"))
+		return true;
+
+	return false;
+}
+
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[])
 {
 	int i;
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 7151a9138e3f..c355df2dba7b 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -175,6 +175,7 @@ void free_cpu_domain_info(struct cpu_domain_map **cd_map, u32 schedstat_version,
 void perf_env__exit(struct perf_env *env);
 
 int perf_env__kernel_is_64_bit(struct perf_env *env);
+bool perf_arch_is_big_endian(const char *arch);
 
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[]);
 
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 22be77225bb0..8611293deca9 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -449,7 +449,7 @@ void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
 	}
 }
 
-static uint16_t read_proc_e_machine_for_pid(pid_t pid, uint32_t *e_flags)
+static uint16_t read_proc_e_machine_for_pid(pid_t pid, uint32_t *e_flags, bool *is_big_endian)
 {
 	char path[6 /* "/proc/" */ + 11 /* max length of pid */ + 5 /* "/exe\0" */];
 	int fd;
@@ -458,7 +458,8 @@ static uint16_t read_proc_e_machine_for_pid(pid_t pid, uint32_t *e_flags)
 	snprintf(path, sizeof(path), "/proc/%d/exe", pid);
 	fd = open(path, O_RDONLY);
 	if (fd >= 0) {
-		e_machine = dso__read_e_machine(/*optional_dso=*/NULL, fd, e_flags);
+		e_machine = dso__read_e_machine_endian(/*optional_dso=*/NULL, fd, e_flags,
+						       is_big_endian);
 		close(fd);
 	}
 	return e_machine;
@@ -468,6 +469,7 @@ struct thread__e_machine_callback_args {
 	struct machine *machine;
 	uint32_t e_flags;
 	uint16_t e_machine;
+	bool is_big_endian;
 };
 
 static int thread__e_machine_callback(struct map *map, void *_args)
@@ -478,11 +480,13 @@ static int thread__e_machine_callback(struct map *map, void *_args)
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
 	uint16_t e_machine = RC_CHK_ACCESS(thread)->e_machine;
@@ -491,6 +495,7 @@ uint16_t thread__e_machine(struct thread *thread, struct machine *machine, uint3
 		.machine = machine,
 		.e_flags = 0,
 		.e_machine = EM_NONE,
+		.is_big_endian = false,
 	};
 
 	if (e_machine != EM_NONE) {
@@ -510,7 +515,8 @@ uint16_t thread__e_machine(struct thread *thread, struct machine *machine, uint3
 		struct thread *parent = machine__findnew_thread(machine, pid, pid);
 
 		if (parent) {
-			e_machine = thread__e_machine(parent, machine, &local_e_flags);
+			e_machine = thread__e_machine_endian(parent, machine, &local_e_flags,
+							     is_big_endian);
 			thread__put(parent);
 			goto out;
 		}
@@ -522,6 +528,8 @@ uint16_t thread__e_machine(struct thread *thread, struct machine *machine, uint3
 	if (args.e_machine != EM_NONE) {
 		e_machine = args.e_machine;
 		local_e_flags = args.e_flags;
+		if (is_big_endian)
+			*is_big_endian = args.is_big_endian;
 	} else {
 		/* Maps failed, perhaps we're live with map events disabled. */
 		bool is_live = machine->machines == NULL;
@@ -536,7 +544,7 @@ uint16_t thread__e_machine(struct thread *thread, struct machine *machine, uint3
 		}
 		/* Read from /proc/pid/exe if live. */
 		if (is_live)
-			e_machine = read_proc_e_machine_for_pid(pid, &local_e_flags);
+			e_machine = read_proc_e_machine_for_pid(pid, &local_e_flags, is_big_endian);
 	}
 out:
 	if (e_machine != EM_NONE) {
@@ -545,6 +553,8 @@ uint16_t thread__e_machine(struct thread *thread, struct machine *machine, uint3
 	} else {
 		e_machine = EM_HOST;
 		local_e_flags = EF_HOST;
+		if (is_big_endian)
+			*is_big_endian = (__BYTE_ORDER__ == __ORDER_BIG_ENDIAN__);
 	}
 	if (e_flags)
 		*e_flags = local_e_flags;
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index f5792d3e8a16..8b58590c89de 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -311,7 +311,13 @@ static inline void thread__set_filter_entry_depth(struct thread *thread, int dep
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
-- 
2.54.0.545.g6539524ca2-goog

