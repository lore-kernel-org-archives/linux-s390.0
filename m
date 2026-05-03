Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C11246783
	for <linux-s390@vger.kernel.org>; Sun,  3 May 2026 00:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777767811; cv=none; b=RuYGvHhcRRgs/hta+1WE2YvwV7aRulqAOZWgpHTyMSd8pzTngoyBl9lKmO1NDA6d6iD8Dxg/kB4YGfTvUKKeg4XYc5A4pkgSO1Oxm5P+b8tHpFpsqHqmByfZF1+dnWshXRo5Crq5ek3MFUXfTmIi+2qZ5c1rBLLWfexxIXLRKfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777767811; c=relaxed/simple;
	bh=pikKL0ytl7bvVH0d9CpEQgzbFoqeQtrn9npsggARIwo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CkbyXdAzQIjyNc0hq7U9w0uzbi1UeRVo8GuN0vO6G+sca8z6E3qY1pAxtd0bGNNajigKflQjU6lK41u6QuGiMVEXwwVswwGbGa4QA0IyXrYKE9mGoJEZaZ3taGG0esbZ1sJtgN7CTjhTJfHWEYr386lIuL2ymex9hOQZmz6Z5Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A2sx0D2A; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A2sx0D2A"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2de07c12745so3840371eec.1
        for <linux-s390@vger.kernel.org>; Sat, 02 May 2026 17:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777767809; x=1778372609; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5SiYbjUQxW7Zl0nlxdQib3Qm3zWmIiIf5vHfJT4wj/o=;
        b=A2sx0D2AcjWzXD9/HyrbKjvnxn+Ql+7MZwSmeAOGl/arI2pW9ARdofHUqeSTA7pbLv
         WlSWnDOPihQ+Fy8ea4uLO89Kz4HWThqP/WmaBl3JuTla21Ze3ix8ceFB6QR4ETvijeWE
         0MIKsli58xyXSYk/CadR9Gs7ULBNFFTSkxWHqj/TS1qpS2PRLR6L068xHF/VToXO5chS
         UQBqyK1O5UDCrwnIPQdBMlVzrIYsAMASrvVEldZG95fPDYxl+kbFRbgn61da2VNJa2Xz
         hFgqQldOkqnQCXB6hApsx9F85a333fbDTnQH0SDuB1IKyFCUEXZG3ZdDem4aGKK/RJld
         ND3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777767809; x=1778372609;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5SiYbjUQxW7Zl0nlxdQib3Qm3zWmIiIf5vHfJT4wj/o=;
        b=FpbBma2MnjvInK9nntnjmRNBlY2R1s5Xx6V9Cn0kLIu40kRzw59vpIw/Tnojg5Kt0r
         tN/9i0vNvz32PDBM+5XVroQiSF7vtkONLblqD8zG2ZDeSCN6To+HI8v04m/ycjkNi14A
         AeEogG+NvpngyjKjuxexCVbBDGMvxCAQLOahLM7Cl76N6+CcxBKxK/1rb5nP3acmrUbj
         oDNQVWS6XAKzf9TlPpsaGWdpXo2oopLfeRen6RB7gTDYZfomNmC0eZpjWcEXdXhAosPq
         uk+1h9REIWm6H0GUPDbV8SZJ3RIUrX0XBhpOoQze9IvtVdg7tn2V8IueVK5VGallpNbW
         U6ng==
X-Forwarded-Encrypted: i=1; AFNElJ/FSsKg0BbxK4vkc5YXZqIooRuL7E5oSdNHKr5nqfJR8hYHsdHGljhu4hLR/1rUgjtYfWV4gKy+DYBA@vger.kernel.org
X-Gm-Message-State: AOJu0YwaKgF+08vosz/SmvpeJ9EdzNkxNO3h5utgrqCnCdhoa/gfAzxr
	Stmp29NuNYkV9NGCWQ1maiv6k/o1rv7nGoAZuZzScx9S9fB8hRmQ1yn8rMG2FsfJfJcFcxNN62w
	pFW8+HOpdwQ==
X-Received: from dybgh27.prod.google.com ([2002:a05:7301:1b:b0:2df:7541:1895])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1007:b0:2da:1a81:5ae
 with SMTP id 5a478bee46e88-2efb83ade46mr1983186eec.10.1777767808747; Sat, 02
 May 2026 17:23:28 -0700 (PDT)
Date: Sat,  2 May 2026 17:22:48 -0700
In-Reply-To: <20260503002248.1040791-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502065935.291960-1-irogers@google.com> <20260503002248.1040791-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503002248.1040791-19-irogers@google.com>
Subject: [PATCH v9 18/18] perf symbol: Lazily compute idle
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Switch from an idle boolean to a helper symbol__is_idle function. In
the function lazily compute whether a symbol is an idle function
taking into consideration the kernel version and architecture of the
machine. As symbols__insert no longer needs to know if a symbol is for
the kernel, remove the argument.

This change is inspired by mailing list discussion, particularly from
Thomas Richter <tmricht@linux.ibm.com> and Heiko Carstens
<hca@linux.ibm.com>:
https://lore.kernel.org/lkml/20260219113850.354271-1-tmricht@linux.ibm.com/

The change switches x86 matches to use strstarts which means
intel_idle_irq is matched as part of strstarts(name, "intel_idle"), a
change suggested by Honglei Wang <jameshongleiwang@126.com> in:
https://lore.kernel.org/lkml/20260323085255.98173-1-jameshongleiwang@126.com/

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c     |   3 +-
 tools/perf/util/symbol-elf.c |   2 +-
 tools/perf/util/symbol.c     | 114 +++++++++++++++++++++--------------
 tools/perf/util/symbol.h     |   8 +--
 4 files changed, 74 insertions(+), 53 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 9a0c388a7ec3..efb4b1172190 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -830,7 +830,8 @@ static void perf_event__process_sample(const struct perf_tool *tool,
 		}
 	}
 
-	if (al.sym == NULL || !symbol__is_idle(al.sym)) {
+	if (al.sym == NULL ||
+	    !symbol__is_idle(al.sym, al.map ? map__dso(al.map) : NULL, machine->env)) {
 		struct hists *hists = evsel__hists(evsel);
 		struct hist_entry_iter iter = {
 			.evsel		= evsel,
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index a9045d6fcb95..69484abc07b6 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1728,7 +1728,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 
 		arch__sym_update(f, &sym);
 
-		__symbols__insert(dso__symbols(curr_dso), f, dso__kernel(dso));
+		__symbols__insert(dso__symbols(curr_dso), f);
 		nr++;
 	}
 	dso__put(curr_dso);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 4702b8989354..2caa6b8b8609 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -50,7 +50,6 @@
 
 static int dso__load_kernel_sym(struct dso *dso, struct map *map);
 static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map);
-static bool symbol__compute_is_idle(const char *name);
 
 int vmlinux_path__nr_entries;
 char **vmlinux_path;
@@ -401,8 +400,7 @@ void symbols__delete(struct rb_root_cached *symbols)
 	}
 }
 
-void __symbols__insert(struct rb_root_cached *symbols,
-		       struct symbol *sym, bool kernel)
+void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym)
 {
 	struct rb_node **p = &symbols->rb_root.rb_node;
 	struct rb_node *parent = NULL;
@@ -410,17 +408,6 @@ void __symbols__insert(struct rb_root_cached *symbols,
 	struct symbol *s;
 	bool leftmost = true;
 
-	if (kernel) {
-		const char *name = sym->name;
-		/*
-		 * ppc64 uses function descriptors and appends a '.' to the
-		 * start of every instruction address. Remove it.
-		 */
-		if (name[0] == '.')
-			name++;
-		symbol__set_idle(sym, symbol__compute_is_idle(name));
-	}
-
 	while (*p != NULL) {
 		parent = *p;
 		s = rb_entry(parent, struct symbol, rb_node);
@@ -437,7 +424,7 @@ void __symbols__insert(struct rb_root_cached *symbols,
 
 void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym)
 {
-	__symbols__insert(symbols, sym, false);
+	__symbols__insert(symbols, sym);
 }
 
 static struct symbol *symbols__find(struct rb_root_cached *symbols, u64 ip)
@@ -598,7 +585,7 @@ void dso__reset_find_symbol_cache(struct dso *dso)
 
 void dso__insert_symbol(struct dso *dso, struct symbol *sym)
 {
-	__symbols__insert(dso__symbols(dso), sym, dso__kernel(dso));
+	__symbols__insert(dso__symbols(dso), sym);
 
 	/* update the symbol cache if necessary */
 	if (dso__last_find_result_addr(dso) >= sym->start &&
@@ -760,55 +747,90 @@ int modules__parse(const char *filename, void *arg,
 	return err;
 }
 
-bool symbol__is_idle(const struct symbol *sym)
-{
-	uint16_t flags = atomic_load(&sym->flags);
-	uint16_t idle_val = (flags & SYMBOL_FLAG_IDLE_MASK) >> SYMBOL_FLAG_IDLE_SHIFT;
-
-	return idle_val == SYMBOL_IDLE__IDLE;
-}
-
 /*
  * These are symbols in the kernel image, so make sure that
  * sym is from a kernel DSO.
  */
-static bool symbol__compute_is_idle(const char *name)
+static int sym_name_cmp(const void *a, const void *b)
+{
+	const char *name = a;
+	const char *const *sym = b;
+
+	return strcmp(name, *sym);
+}
+
+bool symbol__is_idle(struct symbol *sym, const struct dso *dso, struct perf_env *env)
 {
-	const char * const idle_symbols[] = {
+	static const char * const idle_symbols[] = {
 		"acpi_idle_do_entry",
 		"acpi_processor_ffh_cstate_enter",
 		"arch_cpu_idle",
 		"cpu_idle",
 		"cpu_startup_entry",
-		"idle_cpu",
-		"intel_idle",
-		"intel_idle_ibrs",
 		"default_idle",
-		"native_safe_halt",
 		"enter_idle",
 		"exit_idle",
-		"mwait_idle",
-		"mwait_idle_with_hints",
-		"mwait_idle_with_hints.constprop.0",
+		"idle_cpu",
+		"native_safe_halt",
 		"poll_idle",
-		"ppc64_runlatch_off",
 		"pseries_dedicated_idle_sleep",
-		"psw_idle",
-		"psw_idle_exit",
-		NULL
 	};
-	int i;
-	static struct strlist *idle_symbols_list;
+	const char *name = sym->name;
+	uint16_t e_machine = perf_env__e_machine(env, /*e_flags=*/NULL);
+
+	{
+		uint16_t flags = atomic_load(&sym->flags);
+		uint16_t idle_val = (flags & SYMBOL_FLAG_IDLE_MASK) >> SYMBOL_FLAG_IDLE_SHIFT;
+
+		if (idle_val != SYMBOL_IDLE__UNKNOWN)
+			return idle_val == SYMBOL_IDLE__IDLE;
+	}
+
+	if (!dso || dso__kernel(dso) == DSO_SPACE__USER) {
+		symbol__set_idle(sym, /*idle=*/false);
+		return false;
+	}
+
+	/*
+	 * ppc64 uses function descriptors and appends a '.' to the
+	 * start of every instruction address. Remove it.
+	 */
+	if (name[0] == '.')
+		name++;
+
+	if (bsearch(name, idle_symbols, ARRAY_SIZE(idle_symbols),
+		    sizeof(idle_symbols[0]), sym_name_cmp)) {
+		symbol__set_idle(sym, /*idle=*/true);
+		return true;
+	}
 
-	if (idle_symbols_list)
-		return strlist__has_entry(idle_symbols_list, name);
+	if (e_machine == EM_386 || e_machine == EM_X86_64) {
+		if (strstarts(name, "mwait_idle") ||
+		    strstarts(name, "intel_idle")) {
+			symbol__set_idle(sym, /*idle=*/true);
+			return true;
+		}
+	}
 
-	idle_symbols_list = strlist__new(NULL, NULL);
+	if (e_machine == EM_PPC64 && !strcmp(name, "ppc64_runlatch_off")) {
+		symbol__set_idle(sym, /*idle=*/true);
+		return true;
+	}
 
-	for (i = 0; idle_symbols[i]; i++)
-		strlist__add(idle_symbols_list, idle_symbols[i]);
+	if (e_machine == EM_S390 && strstarts(name, "psw_idle")) {
+		int major = 0, minor = 0;
+		const char *release = perf_env__os_release(env);
 
-	return strlist__has_entry(idle_symbols_list, name);
+		/* Before v6.10, s390 used psw_idle. */
+		if (release && sscanf(release, "%d.%d", &major, &minor) == 2 &&
+		    (major < 6 || (major == 6 && minor < 10))) {
+			symbol__set_idle(sym, /*idle=*/true);
+			return true;
+		}
+	}
+
+	symbol__set_idle(sym, /*idle=*/false);
+	return false;
 }
 
 static int map__process_kallsym_symbol(void *arg, const char *name,
@@ -837,7 +859,7 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
 	 * We will pass the symbols to the filter later, in
 	 * map__split_kallsyms, when we have split the maps per module
 	 */
-	__symbols__insert(root, sym, !strchr(name, '['));
+	__symbols__insert(root, sym);
 
 	return 0;
 }
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index a199646f21f7..422e98a4ea2f 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -28,6 +28,7 @@ struct map;
 struct maps;
 struct option;
 struct build_id;
+struct perf_env;
 
 /*
  * libelf 0.8.x and earlier do not support ELF_C_READ_MMAP;
@@ -60,7 +61,6 @@ enum symbol_idle_kind {
 #define SYMBOL_FLAG_INLINED         (1 << 11)
 #define SYMBOL_FLAG_ANNOTATE2       (1 << 12)
 #define SYMBOL_FLAG_IFUNC_ALIAS     (1 << 13)
-
 /**
  * A symtab entry. When allocated this may be preceded by an annotation (see
  * symbol__annotation) and/or a browser_index (see symbol__browser_index).
@@ -112,7 +112,7 @@ static inline bool symbol__ifunc_alias(const struct symbol *sym)
 	return (atomic_load(&sym->flags) & SYMBOL_FLAG_IFUNC_ALIAS) != 0;
 }
 
-bool symbol__is_idle(const struct symbol *sym);
+bool symbol__is_idle(struct symbol *sym, const struct dso *dso, struct perf_env *env);
 
 void symbol__set_ignore(struct symbol *sym, bool ignore);
 void symbol__set_annotate2(struct symbol *sym, bool annotate2);
@@ -196,7 +196,6 @@ int filename__read_debuglink(const char *filename, char *debuglink,
 			     size_t size);
 bool filename__has_section(const char *filename, const char *sec);
 
-struct perf_env;
 int symbol__init(struct perf_env *env);
 void symbol__exit(void);
 void symbol__elf_init(void);
@@ -236,8 +235,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss);
 
 char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name);
 
-void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym,
-		       bool kernel);
+void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym);
 void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym);
 void symbols__fixup_duplicate(struct rb_root_cached *symbols);
 void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms);
-- 
2.54.0.545.g6539524ca2-goog

