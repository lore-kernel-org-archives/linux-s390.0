Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1DB32C92A
	for <linux-s390@vger.kernel.org>; Mon,  2 Mar 2026 23:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772495031; cv=none; b=Uc31+nAb0mneiqSVU0nAmNBp/yqUIRDxP9ALnbvHBncR/5h0uNl0ntzwJedOwOuWrdI0V59C4d7evQF8beyJkXg4IaLNfyDeamRp9Ol0AFBBLr9LDwoqKrmEOx37MQdZ3zt2OFUxEoCpNC0SyTZLiZ04iG18KmTdWa3Vg4Z39PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772495031; c=relaxed/simple;
	bh=ZXBL+5A+xj6PBzbZaMo9szkM6u6ZuD5MOQdpI1cLlvc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EdK1H7AEZ4occE4LjmhJ+feJAu5BuXrvwFPZ96JGWhVIm9Uk3odoVmj/NInEv3Fuo+PprZdq90UTRON8Rd/3IiZiYmjkt5g1pZSsN43caY2rFaQCdNW6Q3dR+uv0UPECSkP0jAehqbT6pmiKWe9T6LuLchnschBYhLRtpPkBThE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x2v+xrh+; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x2v+xrh+"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdd4ce8dc3so8787933eec.0
        for <linux-s390@vger.kernel.org>; Mon, 02 Mar 2026 15:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772495029; x=1773099829; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nzvKvv9gvoGGL/3tD8JfobFmT6RVRX2crxIrQP8xSL4=;
        b=x2v+xrh+LYakxieRAyAFUjNK1zdAYbIV6FDwtV4lA9ZR2fiIw3T9uiUDOdfTd+ItDS
         RrgseStrhUpk+DNCgyfy3MbPzix34AA7sJOo45IPnPS3bfWwrZVUQG3tc56pLPn5AZ9T
         hsTInv41OTl936257AB6dDHxIxj8ojYrN9tZNw+A2lsRHVyqEbJtOlzfXFfmwH9TUr01
         sZ0y6xr9YDCjiwN9Uz/hskpDhfHtozpkokr9UnB9m1hXT9ZubEleFLcu8Cm/7S2554QK
         bUMFthb2pUBdXUf9YtUsxMqAJpM06E1csRidZDhLl5Gkx3bODb7t4GiUNQ13mJQ6pKn2
         hpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772495029; x=1773099829;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzvKvv9gvoGGL/3tD8JfobFmT6RVRX2crxIrQP8xSL4=;
        b=q3kez1ujtQ8UhIYG3cOVB1B+I8AUx4lTVr/YD6rfJRE5uITDFA4lrm4pL60IsVj2Y+
         smHG7MNcuoJCAiJhrgcQT3PAI0ttysTIR/LHkoZ1CIyBUWXqVXF4ugZmTziYJajGulAM
         RYqfj8L6kIf98EwV6YS0OlGomY7Sb/WfGxJ9t6CoL+SAaegoOJpRXDL5OddtKlqXTdQD
         NoWiJGgST9Z3yotxysHWuHGuYx6mFyndHjOr39ldF++5RzaaXfln04R+misYt24V749q
         dTX4qWvsPSU90T5zRFEvhqBG0ULmZKCA5IFCnISHC94o74OiQoWzTfExaf1q7Mn/0eaq
         SBTg==
X-Forwarded-Encrypted: i=1; AJvYcCXTtZEW5ukyOfXlkPj0QPZo1CpCgCbiygb77wTaR9e5Lu9qxAEtaeKF2YEI33MRj/D0uKKhieEZNHSN@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl2+6c4v/s4MdbAWgXjD5RgAqe3DJN/0XnspCKndAy34Ai2wvz
	9s6GjxI1E9KZzNqJrnePK3gDFkZ0yyXKJrtA709au1ArOkAndlMdrTga7ggI65VUCR+onZpdfIa
	tEqJBClFsqg==
X-Received: from dybry3.prod.google.com ([2002:a05:7301:4d03:b0:2be:1b5f:fedf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:2b84:b0:2ba:6723:5060
 with SMTP id 5a478bee46e88-2bde1f9c64cmr5956467eec.31.1772495028981; Mon, 02
 Mar 2026 15:43:48 -0800 (PST)
Date: Mon,  2 Mar 2026 15:43:43 -0800
In-Reply-To: <20260219113850.354271-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260219113850.354271-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260302234343.564937-1-irogers@google.com>
Subject: [PATCH v1] perf symbol: Lazily compute idle and use the perf_env
From: Ian Rogers <irogers@google.com>
To: tmricht@linux.ibm.com
Cc: acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	namhyung@kernel.org, sumanthk@linux.ibm.com, Ian Rogers <irogers@google.com>
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

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c     |   6 +-
 tools/perf/util/symbol-elf.c |   2 +-
 tools/perf/util/symbol.c     | 106 ++++++++++++++++++++++-------------
 tools/perf/util/symbol.h     |  15 +++--
 4 files changed, 85 insertions(+), 44 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 710604c4f6f6..bc3c8e3b6ec0 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -750,6 +750,7 @@ static void perf_event__process_sample(const struct perf_tool *tool,
 {
 	struct perf_top *top = container_of(tool, struct perf_top, tool);
 	struct addr_location al;
+	struct dso *dso = NULL;
 
 	if (!machine && perf_guest) {
 		static struct intlist *seen;
@@ -829,7 +830,10 @@ static void perf_event__process_sample(const struct perf_tool *tool,
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
index 76912c62b6a0..6bb46384aa0c 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1725,7 +1725,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 
 		arch__sym_update(f, &sym);
 
-		__symbols__insert(dso__symbols(curr_dso), f, dso__kernel(dso));
+		__symbols__insert(dso__symbols(curr_dso), f);
 		nr++;
 	}
 	dso__put(curr_dso);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 8662001e1e25..6155f509ca70 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -25,6 +25,8 @@
 #include "demangle-ocaml.h"
 #include "demangle-rust-v0.h"
 #include "dso.h"
+#include "dwarf-regs.h"
+#include "env.h"
 #include "util.h" // lsdir()
 #include "debug.h"
 #include "event.h"
@@ -51,7 +53,6 @@
 
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
@@ -716,47 +705,88 @@ int modules__parse(const char *filename, void *arg,
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
+
+	if (sym->idle)
+		return sym->idle == SYMBOL_IDLE__IDLE;
+
+	if (!dso || dso__kernel(dso) == DSO_SPACE__USER) {
+		sym->idle = SYMBOL_IDLE__NOT_IDLE;
+		return false;
+	}
 
-	if (idle_symbols_list)
-		return strlist__has_entry(idle_symbols_list, name);
+	/*
+	 * ppc64 uses function descriptors and appends a '.' to the
+	 * start of every instruction address. Remove it.
+	 */
+	if (name[0] == '.')
+		name++;
+
+
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
+	if (e_machine == EM_PPC64 &&!strcmp(name, "ppc64_runlatch_off")) {
+		sym->idle = SYMBOL_IDLE__IDLE;
+		return true;
+	}
 
-	idle_symbols_list = strlist__new(NULL, NULL);
+	if (e_machine == EM_S390) {
+		int major = 0, minor = 0;
+		const char *release = env && env->os_release
+			? env->os_release : perf_version_string;
 
-	for (i = 0; idle_symbols[i]; i++)
-		strlist__add(idle_symbols_list, idle_symbols[i]);
+		sscanf(release, "%d.%d", &major, &minor);
 
-	return strlist__has_entry(idle_symbols_list, name);
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
@@ -785,7 +815,7 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
 	 * We will pass the symbols to the filter later, in
 	 * map__split_kallsyms, when we have split the maps per module
 	 */
-	__symbols__insert(root, sym, !strchr(name, '['));
+	__symbols__insert(root, sym);
 
 	return 0;
 }
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 3fb5d146d9b1..508dd9f336e9 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -24,6 +24,7 @@ struct dso;
 struct map;
 struct maps;
 struct option;
+struct perf_env;
 struct build_id;
 
 /*
@@ -41,6 +42,12 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
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
@@ -56,8 +63,8 @@ struct symbol {
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
@@ -184,8 +191,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss);
 
 char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name);
 
-void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym,
-		       bool kernel);
+void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym);
 void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym);
 void symbols__fixup_duplicate(struct rb_root_cached *symbols);
 void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms);
@@ -269,5 +275,6 @@ enum {
 };
 
 int symbol__validate_sym_arguments(void);
+bool symbol__is_idle(struct symbol *sym, const struct dso *dso, const struct perf_env *env);
 
 #endif /* __PERF_SYMBOL */
-- 
2.53.0.473.g4a7958ca14-goog

