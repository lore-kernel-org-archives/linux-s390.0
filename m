Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B810F31E839
	for <linux-s390@vger.kernel.org>; Sat,  2 May 2026 07:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777705230; cv=none; b=OwAejSz0G4iEBiJqlfT02AyRCklgnTu3F0JU1R1vXEJBf7cFpOeh/2MOmk1gNce8ODpo9ImsVCffCzrbkFXyi/q5001V/4jb/2VQcCMyrKZ6XJehu8Mcmu6ncHN4NJg5h7GbSX5yTQVQ20GqH2KQNTbTBn0IlPiEpSWOveX1eKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777705230; c=relaxed/simple;
	bh=0h0Tfir28yPQPNz+cNoFW8Erqwl6wjPEai8mFcAvvM4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=duFuikXLGN5hg6TDK3Nft/fFoycIjQQE0t1lESqUKUrMZoYfAvwU63pCRtoG/r+w7kl6O1C6XfwpToIIdK409rEvRjfRbGWnbTEdamHmRP8hj3N4O10FFwu8+SiAMWK9teDkXCgQA/rZ71vPV2pqRqSr1VK8U3yYBGn57ChhM2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B8fe9WC1; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B8fe9WC1"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12e683ca86bso507684c88.1
        for <linux-s390@vger.kernel.org>; Sat, 02 May 2026 00:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777705228; x=1778310028; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CrOBiEIloSh8hzrU+l3UrRKP9W/TgO2dbvf2i5sJg4M=;
        b=B8fe9WC1U7IQ2qloNNoJSinA6xyF0eDe9jP1JYo70VmdYowjsSjiyWhs/XCJAf4rGo
         uqYvrCEUEJU78g8yK0BrzAr8rLBB9lK9B5J/UeYOWTEQdyENv0tWI1N5AR0WDAd1wRDo
         OxBJoe5cXzmtoIDyZPW5uvYS/KVrW+C2Js+z8XwMZbSsAO9l+wlCQE6Rpdpdd+4O9P9d
         Q6AUUuVgHZp95ktf6B1qspMTV8Duobt3TmpCVmkO3wtB33C25hSHAN1dvtgvfrw9QKw6
         WZ9S8UL7D127e24f6AJKeZTrvElwfnuz9dPJ1+wqzaDWLAmK2IXoHcaTND9IjyfE0tPr
         AyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777705228; x=1778310028;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CrOBiEIloSh8hzrU+l3UrRKP9W/TgO2dbvf2i5sJg4M=;
        b=NekTJsJaTiFXkqq8HNfjSyA9/pw+fB2UnKhaVFIr3y0M7JZSVZldA4qW3f1ADaQEhb
         iDfQYT0NHUucQL7lyCEotjEa6fhvQ+Ovq0IY8U4XpJ9+yt2+8Iyj/AHcx4shV5GoA8Rp
         upq0JSji8QQTDaINBeWyWEWvJUu7c7XD6w5DvcEk6FyX+Z2ByKuoFyKFTnYG+EW9MdrD
         m+kGy/fVIH6aKUPZFpZ8zs0EiZMYn1OzmbgBbM6hq8DbdBK7rfcMR27Z+apprWtiK40y
         BVM3889IWpzNyTvGTGK08vec0c9/7kmcT90WtcgUMUmjs3rvvLztr6jWm80oAJYEfSaf
         MXKg==
X-Forwarded-Encrypted: i=1; AFNElJ/URdzfafJOSLS7SNtqUrz43hFIFAc+z7/p8hw4Puqr6QZgSQsQIwoIQQt4krFYleaBqL5m+/GJHiBk@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7N6l17AKcce2eIebExpcrfs1mlYSyUKZo6XalXByciSC7lzsp
	370QHueBEY4dXpL250ExHDQWOrsrdUMVGiB/iW9KXIpwKBNJw4YQf5QqTmgArB163JsjLe0v16E
	QaG6I1mU0iQ==
X-Received: from dlbtz16.prod.google.com ([2002:a05:7022:ead0:b0:12c:3dfa:518e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3897:b0:12c:3d30:37c5
 with SMTP id a92af1059eb24-12dfd7bd8d3mr1079370c88.12.1777705227576; Sat, 02
 May 2026 00:00:27 -0700 (PDT)
Date: Fri,  1 May 2026 23:59:35 -0700
In-Reply-To: <20260502065935.291960-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409230620.4176210-2-irogers@google.com> <20260502065935.291960-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502065935.291960-18-irogers@google.com>
Subject: [PATCH v8 17/17] perf symbol: Lazily compute idle and use a global
 lock for updates
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
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

To avoid concurrent update issues with other bitfields in `struct symbol`,
this change uses the global lock `symbol_bits_lock` (introduced in a
previous commit) for updates to the `idle` field. A static helper
`symbol__set_idle` taking a boolean is used to encapsulate the lock and
mapping to `enum symbol_idle_kind`.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol-elf.c |   2 +-
 tools/perf/util/symbol.c     | 108 +++++++++++++++++++++++------------
 tools/perf/util/symbol.h     |  14 +++--
 3 files changed, 81 insertions(+), 43 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 7afa8a117139..e8f7fe3f19fc 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1727,7 +1727,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 
 		arch__sym_update(f, &sym);
 
-		__symbols__insert(dso__symbols(curr_dso), f, dso__kernel(dso));
+		__symbols__insert(dso__symbols(curr_dso), f);
 		nr++;
 	}
 	dso__put(curr_dso);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 1238a0d6ce6e..6c642067c4ed 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -51,7 +51,6 @@
 
 static int dso__load_kernel_sym(struct dso *dso, struct map *map);
 static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map);
-static bool symbol__is_idle(const char *name);
 
 static struct mutex symbol_bits_lock;
 
@@ -362,6 +361,13 @@ void symbol__set_annotate2(struct symbol *sym, bool annotate2)
 	mutex_unlock(&symbol_bits_lock);
 }
 
+static void symbol__set_idle(struct symbol *sym, bool idle)
+{
+	mutex_lock(&symbol_bits_lock);
+	sym->idle = idle ? SYMBOL_IDLE__IDLE : SYMBOL_IDLE__NOT_IDLE;
+	mutex_unlock(&symbol_bits_lock);
+}
+
 void symbols__delete(struct rb_root_cached *symbols)
 {
 	struct symbol *pos;
@@ -375,8 +381,7 @@ void symbols__delete(struct rb_root_cached *symbols)
 	}
 }
 
-void __symbols__insert(struct rb_root_cached *symbols,
-		       struct symbol *sym, bool kernel)
+void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym)
 {
 	struct rb_node **p = &symbols->rb_root.rb_node;
 	struct rb_node *parent = NULL;
@@ -384,17 +389,6 @@ void __symbols__insert(struct rb_root_cached *symbols,
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
@@ -411,7 +405,7 @@ void __symbols__insert(struct rb_root_cached *symbols,
 
 void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym)
 {
-	__symbols__insert(symbols, sym, false);
+	__symbols__insert(symbols, sym);
 }
 
 static struct symbol *symbols__find(struct rb_root_cached *symbols, u64 ip)
@@ -572,7 +566,7 @@ void dso__reset_find_symbol_cache(struct dso *dso)
 
 void dso__insert_symbol(struct dso *dso, struct symbol *sym)
 {
-	__symbols__insert(dso__symbols(dso), sym, dso__kernel(dso));
+	__symbols__insert(dso__symbols(dso), sym);
 
 	/* update the symbol cache if necessary */
 	if (dso__last_find_result_addr(dso) >= sym->start &&
@@ -738,43 +732,81 @@ int modules__parse(const char *filename, void *arg,
  * These are symbols in the kernel image, so make sure that
  * sym is from a kernel DSO.
  */
-static bool symbol__is_idle(const char *name)
+static int sym_name_cmp(const void *a, const void *b)
 {
-	const char * const idle_symbols[] = {
+	const char *name = a;
+	const char *const *sym = b;
+
+	return strcmp(name, *sym);
+}
+
+bool symbol__is_idle(struct symbol *sym, const struct dso *dso, struct perf_env *env)
+{
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
 
-	if (idle_symbols_list)
-		return strlist__has_entry(idle_symbols_list, name);
+	if (sym->idle)
+		return sym->idle == SYMBOL_IDLE__IDLE;
 
-	idle_symbols_list = strlist__new(NULL, NULL);
+	if (!dso || dso__kernel(dso) == DSO_SPACE__USER) {
+		symbol__set_idle(sym, /*idle=*/false);
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
+
+	if (bsearch(name, idle_symbols, ARRAY_SIZE(idle_symbols),
+		    sizeof(idle_symbols[0]), sym_name_cmp)) {
+		symbol__set_idle(sym, /*idle=*/true);
+		return true;
+	}
+
+	if (e_machine == EM_386 || e_machine == EM_X86_64) {
+		if (strstarts(name, "mwait_idle") ||
+		    strstarts(name, "intel_idle")) {
+			symbol__set_idle(sym, /*idle=*/true);
+			return true;
+		}
+	}
 
-	return strlist__has_entry(idle_symbols_list, name);
+	if (e_machine == EM_PPC64 && !strcmp(name, "ppc64_runlatch_off")) {
+		symbol__set_idle(sym, /*idle=*/true);
+		return true;
+	}
+
+	if (e_machine == EM_S390 && strstarts(name, "psw_idle")) {
+		int major = 0, minor = 0;
+		const char *release = perf_env__os_release(env);
+
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
@@ -803,7 +835,7 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
 	 * We will pass the symbols to the filter later, in
 	 * map__split_kallsyms, when we have split the maps per module
 	 */
-	__symbols__insert(root, sym, !strchr(name, '['));
+	__symbols__insert(root, sym);
 
 	return 0;
 }
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 5d98d7e84d57..717d2f876d58 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -43,6 +43,12 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
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
@@ -58,8 +64,8 @@ struct symbol {
 	u8		type:4;
 	/** ELF binding type as defined for st_info. E.g. STB_WEAK or STB_GLOBAL. */
 	u8		binding:4;
-	/** Set true for kernel symbols of idle routines. */
-	u8		idle:1;
+	/** Cache for symbol__is_idle holding enum symbol_idle_kind values. */
+	u8		idle:2;
 	/** Resolvable but tools ignore it (e.g. idle routines). */
 	u8		ignore:1;
 	/** Symbol for an inlined function. */
@@ -197,8 +203,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss);
 
 char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name);
 
-void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym,
-		       bool kernel);
+void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym);
 void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym);
 void symbols__fixup_duplicate(struct rb_root_cached *symbols);
 void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms);
@@ -281,5 +286,6 @@ enum {
 };
 
 int symbol__validate_sym_arguments(void);
+bool symbol__is_idle(struct symbol *sym, const struct dso *dso, struct perf_env *env);
 
 #endif /* __PERF_SYMBOL */
-- 
2.54.0.545.g6539524ca2-goog

