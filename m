Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171723E9F9D
	for <linux-s390@vger.kernel.org>; Wed, 25 Mar 2026 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774455530; cv=none; b=YwnB1BAviXicZwrfd5ePvZSrHop5nb/g+nSaTnv35mxvehjPGneZewGbk3fFFk7H7kgDZiUMu92f1PF8OmWV5tAZouz0wfj8SS9xNivOjRdmRNEv5AQJEHxUgnE+qsktDdrDjPCU+MGz5LxiAy66HVCb+suV5AwRDHDvx8FHuIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774455530; c=relaxed/simple;
	bh=ujXVSPWi9K19hqWKNR2YVC6FSEsshyigdTUKmE+YX+c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hkzf+8uMU3LROcZOCyeb+56mrpJvj/QrYp0fnJXITFE8GK5VkVYSDRI0gZuDFC9YXsWzKkgXTFENKFb3y0afKONZeorFWE32KT0B7HNXZjG5SWYE9boilgGGzJVXCNxyL8l42DI5w1Ac0gyBAuW7U+dB69UHEc1siyNw6+W0qV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IKntJImp; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IKntJImp"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0ffce2570so201563eec.1
        for <linux-s390@vger.kernel.org>; Wed, 25 Mar 2026 09:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774455527; x=1775060327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c2lap/UJ8BFoo4cOMxZbeksxuRKLVHxwjfRDIyMOFwc=;
        b=IKntJImp2XZ6KFYQeqYjWHhweUdbDrizLLKTDjbichTFN2ba6o4ZCTwyz5AUTSPn47
         Iyyja0oqbC/fMlkDdCMgUpNFDcoXWI9BpIKFut1v/buTcIXTADOZ1FiRzfO+LfxUnFR/
         SWKzZRJTn0ID2ATDi5mSXyBBtsV0Cv9+TvFnuMACoByJnP9bG+zkT4b9blMA9Ru9jQoF
         A8o9IgnXizvlJplwVoA5sajdcOPlegpoIYBZlPzG7lKaHBnpR0JvTFCp6vWSHIycugf5
         OpbxiclCxZDQOayoprjU8Hbr8RYPjt4ieGhDPdPJmTjGeOGiTUHrZHXBXbhb/ixxnYjA
         H7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774455527; x=1775060327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2lap/UJ8BFoo4cOMxZbeksxuRKLVHxwjfRDIyMOFwc=;
        b=pV8SWaK5DiyoLSljXNnIr6IFUS7o/E+jRGExrvseCx+C6Kfupup5e+Oywhezx36T8b
         72Srf8RHD5IDKWt4lTHXkib1b2apy3IG3lTLYsopdspFzVSWW/ncAXf9lJmhwgd1RrIa
         w7Svd/07DH7wrFtTZTNGjrxESpoh6jWKGuwoZvCWx/F/QOr2Rbqfma9z9YDPalXnv4JK
         bWg0o5oDbMO3sMYkyHgZKBuF+ppO0uBcOenTkv0bisq33ZnLaD3wGvDICoVb4zolLQsY
         mM/7CGeIYlfYPfK16M3alRPfm26ro5mexsDTCgKERnzqpmWltVFSTO2TgaKOU/AFMrOH
         WwmA==
X-Forwarded-Encrypted: i=1; AJvYcCUVPCkAhAXdyT0IU4lxuTzKo6QntkLadywk1zNJidBxc+lmGLyBrjl7/ujbtduEmw09jZuYV9N/M0rf@vger.kernel.org
X-Gm-Message-State: AOJu0YwOEi5yQytR7GfXq/yLgUcphS2lJMCPBKMuEziz9QOzdKmXmIuQ
	sQAqt6dtLGM3wtcMsji7sWzF3K9pMOmR1V3DnG2gInYNBkkuSBvyQPeKz7d/EbqJaC/B3sVMZj1
	0hZHj6LnV0A==
X-Received: from dyw28.prod.google.com ([2002:a05:7300:881c:b0:2be:4118:56f1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7304:b0:2c0:c96a:a4db
 with SMTP id 5a478bee46e88-2c15d2ba52bmr2456264eec.4.1774455526788; Wed, 25
 Mar 2026 09:18:46 -0700 (PDT)
Date: Wed, 25 Mar 2026 09:18:36 -0700
In-Reply-To: <20260302234343.564937-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260302234343.564937-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260325161836.1029457-1-irogers@google.com>
Subject: [PATCH v2] perf symbol: Lazily compute idle and use the perf_env
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: irogers@google.com, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, jameshongleiwang@126.com
Content-Type: text/plain; charset="UTF-8"

Move the idle boolean to a helper symbol__is_idle function. In the
function lazily compute whether a symbol is an idle function taking
into consideration the kernel version and architecture of the
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

Signed-off-by: Ian Rogers <irogers@google.com>
---
v1: https://lore.kernel.org/lkml/20260302234343.564937-1-irogers@google.com/
---
 tools/perf/builtin-top.c     |   6 +-
 tools/perf/util/symbol-elf.c |   2 +-
 tools/perf/util/symbol.c     | 105 ++++++++++++++++++++++-------------
 tools/perf/util/symbol.h     |  15 +++--
 4 files changed, 84 insertions(+), 44 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 37950efb28ac..bdc1c761cd61 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -751,6 +751,7 @@ static void perf_event__process_sample(const struct perf_tool *tool,
 {
 	struct perf_top *top = container_of(tool, struct perf_top, tool);
 	struct addr_location al;
+	struct dso *dso = NULL;
 
 	if (!machine && perf_guest) {
 		static struct intlist *seen;
@@ -830,7 +831,10 @@ static void perf_event__process_sample(const struct perf_tool *tool,
 		}
 	}
 
-	if (al.sym == NULL || !al.sym->idle) {
+	if (al.map)
+		dso = map__dso(al.map);
+
+	if (al.sym == NULL || !symbol__is_idle(al.sym, dso, machine->env)) {
 		struct hists *hists = evsel__hists(evsel);
 		struct hist_entry_iter iter = {
 			.evsel		= evsel,
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 3cd4e5a03cc5..9fabf5146d89 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1723,7 +1723,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 
 		arch__sym_update(f, &sym);
 
-		__symbols__insert(dso__symbols(curr_dso), f, dso__kernel(dso));
+		__symbols__insert(dso__symbols(curr_dso), f);
 		nr++;
 	}
 	dso__put(curr_dso);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index ce9195717f44..1a357af93a0a 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -25,6 +25,8 @@
 #include "demangle-ocaml.h"
 #include "demangle-rust-v0.h"
 #include "dso.h"
+#include "dwarf-regs.h"
+#include "env.h"
 #include "util.h" // lsdir()
 #include "event.h"
 #include "machine.h"
@@ -50,7 +52,6 @@
 
 static int dso__load_kernel_sym(struct dso *dso, struct map *map);
 static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map);
-static bool symbol__is_idle(const char *name);
 
 int vmlinux_path__nr_entries;
 char **vmlinux_path;
@@ -357,8 +358,7 @@ void symbols__delete(struct rb_root_cached *symbols)
 	}
 }
 
-void __symbols__insert(struct rb_root_cached *symbols,
-		       struct symbol *sym, bool kernel)
+void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym)
 {
 	struct rb_node **p = &symbols->rb_root.rb_node;
 	struct rb_node *parent = NULL;
@@ -366,17 +366,6 @@ void __symbols__insert(struct rb_root_cached *symbols,
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
-		sym->idle = symbol__is_idle(name);
-	}
-
 	while (*p != NULL) {
 		parent = *p;
 		s = rb_entry(parent, struct symbol, rb_node);
@@ -393,7 +382,7 @@ void __symbols__insert(struct rb_root_cached *symbols,
 
 void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym)
 {
-	__symbols__insert(symbols, sym, false);
+	__symbols__insert(symbols, sym);
 }
 
 static struct symbol *symbols__find(struct rb_root_cached *symbols, u64 ip)
@@ -554,7 +543,7 @@ void dso__reset_find_symbol_cache(struct dso *dso)
 
 void dso__insert_symbol(struct dso *dso, struct symbol *sym)
 {
-	__symbols__insert(dso__symbols(dso), sym, dso__kernel(dso));
+	__symbols__insert(dso__symbols(dso), sym);
 
 	/* update the symbol cache if necessary */
 	if (dso__last_find_result_addr(dso) >= sym->start &&
@@ -716,47 +705,87 @@ int modules__parse(const char *filename, void *arg,
 	return err;
 }
 
+static int sym_name_cmp(const void *a, const void *b)
+{
+	const char *name = a;
+	const char *const *sym = b;
+
+	return strcmp(name, *sym);
+}
+
 /*
  * These are symbols in the kernel image, so make sure that
  * sym is from a kernel DSO.
  */
-static bool symbol__is_idle(const char *name)
+bool symbol__is_idle(struct symbol *sym, const struct dso *dso, const struct perf_env *env)
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
+	uint16_t e_machine = env ? env->e_machine : EM_HOST;
 
-	if (idle_symbols_list)
-		return strlist__has_entry(idle_symbols_list, name);
+	if (sym->idle)
+		return sym->idle == SYMBOL_IDLE__IDLE;
 
-	idle_symbols_list = strlist__new(NULL, NULL);
+	if (!dso || dso__kernel(dso) == DSO_SPACE__USER) {
+		sym->idle = SYMBOL_IDLE__NOT_IDLE;
+		return false;
+	}
 
-	for (i = 0; idle_symbols[i]; i++)
-		strlist__add(idle_symbols_list, idle_symbols[i]);
+	/*
+	 * ppc64 uses function descriptors and appends a '.' to the
+	 * start of every instruction address. Remove it.
+	 */
+	if (name[0] == '.')
+		name++;
 
-	return strlist__has_entry(idle_symbols_list, name);
+	if (bsearch(name, idle_symbols, ARRAY_SIZE(idle_symbols),
+		    sizeof(idle_symbols[0]), sym_name_cmp)) {
+		sym->idle = SYMBOL_IDLE__IDLE;
+		return true;
+	}
+
+	if (e_machine == EM_386 || e_machine == EM_X86_64) {
+		if (strstarts(name, "mwait_idle") ||
+		    strstarts(name, "intel_idle")) {
+			sym->idle = SYMBOL_IDLE__IDLE;
+			return true;
+		}
+	}
+
+	if (e_machine == EM_PPC64 && !strcmp(name, "ppc64_runlatch_off")) {
+		sym->idle = SYMBOL_IDLE__IDLE;
+		return true;
+	}
+
+	if (e_machine == EM_S390) {
+		int major = 0, minor = 0;
+		const char *release = env && env->os_release
+			? env->os_release : perf_version_string;
+
+		sscanf(release, "%d.%d", &major, &minor);
+
+		/* Before v6.10, s390 used psw_idle. */
+		if ((major < 6 || (major == 6 && minor < 10)) && strstarts(name, "psw_idle")) {
+			sym->idle = SYMBOL_IDLE__IDLE;
+			return true;
+		}
+	}
+
+	sym->idle = SYMBOL_IDLE__NOT_IDLE;
+	return false;
 }
 
 static int map__process_kallsym_symbol(void *arg, const char *name,
@@ -785,7 +814,7 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
 	 * We will pass the symbols to the filter later, in
 	 * map__split_kallsyms, when we have split the maps per module
 	 */
-	__symbols__insert(root, sym, !strchr(name, '['));
+	__symbols__insert(root, sym);
 
 	return 0;
 }
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index c67814d6d6d6..f26f67bd7982 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -25,6 +25,7 @@ struct dso;
 struct map;
 struct maps;
 struct option;
+struct perf_env;
 struct build_id;
 
 /*
@@ -42,6 +43,12 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
 			     GElf_Shdr *shp, const char *name, size_t *idx);
 #endif
 
+enum symbol_idle_kind {
+	SYMBOL_IDLE__UNKNOWN = 0,
+	SYMBOL_IDLE__NOT_IDLE = 1,
+	SYMBOL_IDLE__IDLE = 2,
+};
+
 /**
  * A symtab entry. When allocated this may be preceded by an annotation (see
  * symbol__annotation) and/or a browser_index (see symbol__browser_index).
@@ -57,8 +64,8 @@ struct symbol {
 	u8		type:4;
 	/** ELF binding type as defined for st_info. E.g. STB_WEAK or STB_GLOBAL. */
 	u8		binding:4;
-	/** Set true for kernel symbols of idle routines. */
-	u8		idle:1;
+	/** Cache for symbol__is_idle. */
+	enum symbol_idle_kind idle:2;
 	/** Resolvable but tools ignore it (e.g. idle routines). */
 	u8		ignore:1;
 	/** Symbol for an inlined function. */
@@ -202,8 +209,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss);
 
 char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name);
 
-void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym,
-		       bool kernel);
+void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym);
 void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym);
 void symbols__fixup_duplicate(struct rb_root_cached *symbols);
 void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms);
@@ -286,5 +292,6 @@ enum {
 };
 
 int symbol__validate_sym_arguments(void);
+bool symbol__is_idle(struct symbol *sym, const struct dso *dso, const struct perf_env *env);
 
 #endif /* __PERF_SYMBOL */
-- 
2.53.0.1018.g2bb0e51243-goog

