Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB60832E12E;
	Thu, 24 Sep 2026 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253658; cv=none; b=cDrINa83WUpVW55H+PdQAtfQFzOq5MRpo35aESdCFOyJ27pjRwwafyrfIkapE3P8zjGbrys+IhY887pIECUn0okE09HoO313WhzGJjxh/sG82xVUkmCUzzGIbsQNdFhj/ejuf+G25qY11NYleKnzqPmVr/DskmOoCm1z+db3eGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253658; c=relaxed/simple;
	bh=BHEyQwcCSBEVbynaeG+86CLCfYIlwMXWifOsfwGvo5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzBXJI2BpXTfeZxf+P0WF67KcJt4QMcPRPr3Yd913IeE1AvJ7JIx7jRL0S3LxNY3cKwRanTWJ+S1VMVhthPo4H+6pSHINpRXzj66cOCG3lqC0/7DcKsxpYDHEJ16H0oX7eOldDUN6QhLTD/5gqdC8sYeAF3cJoK0Ie2BaOTUCec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=W69v5a/T; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="W69v5a/T"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=uKE5y6EMmXIqossweWCMUz/hP2GEVJE5zV2+OYUWr6c=;
	t=1790253655; x=1791463255; b=W69v5a/TgqXKmkocsFLnhmp1Pucu7QaLx9N9nJqfwpXAiuK
	OTWUsGLSMOG9+Er4RExs/Hsc2k2k8S1yX+sC+k+tf/VyCSDhOy9UEem9Lng+Bh+Li1CRLkz7RURMP
	jy/aFvzy4yX0CksdbrEXtr8wUeDYqVX8yiQOvoMYhhqL/nm1L7Xi+9fwKieRqkN76A9eM9ZStlUGS
	F2CGEAnnYuTbaRVGaZ+TPZ/ZNXkKRmAs+VQAk0hiyAVoNDSQL4VO7ntOFHrUDXroIwN5gO+9ECsm9
	khcitFy9gb12JgvUTYqsS/hy9YbR5UhZO25eY+piulXZ086hQnsnOCbQvBUlZjjA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x9iks-000000092x8-1BN0;
	Thu, 24 Sep 2026 14:40:50 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-s390@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/4] ORC: pull out module handling from x86/loongarch
Date: Thu, 24 Sep 2026 14:35:51 +0200
Message-ID: <20260924144039.1f625ed6f732.Ief8583cee373b18ea2151118373ff3d8ab73ac60@changeid>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924124039.1621965-6-johannes@sipsolutions.net>
References: <20260924124039.1621965-6-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The x86 and loongarch code for ORC unwinder are just
copied code, and I don't want to add another copy for
UML. Pull out the common module section handling into
the regular module code to reduce duplication.

I used the x86 version, but loongarch is identical
except for variable declaration order.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 MAINTAINERS                         |   2 +
 arch/loongarch/include/asm/module.h |   7 --
 arch/loongarch/include/asm/unwind.h |   2 -
 arch/loongarch/kernel/module.c      |  10 +--
 arch/loongarch/kernel/unwind_orc.c  | 128 +---------------------------
 arch/x86/include/asm/module.h       |   6 --
 arch/x86/include/asm/unwind.h       |   5 --
 arch/x86/kernel/module.c            |  10 ---
 arch/x86/kernel/unwind_orc.c        | 127 +--------------------------
 include/linux/module.h              |   7 ++
 include/linux/moduleloader.h        |   6 ++
 include/linux/orc.h                 |  24 ++++++
 kernel/module/main.c                |  23 ++++-
 lib/Makefile                        |   3 +
 lib/orc.c                           | 119 ++++++++++++++++++++++++++
 15 files changed, 186 insertions(+), 293 deletions(-)
 create mode 100644 include/linux/orc.h
 create mode 100644 lib/orc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index cc3cae2e378b..f1911d21a2eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29636,6 +29636,8 @@ F:	arch/x86/include/asm/unwind*.h
 F:	arch/x86/kernel/dumpstack.c
 F:	arch/x86/kernel/stacktrace.c
 F:	arch/x86/kernel/unwind_*.c
+F:	include/linux/orc.h
+F:	lib/orc.c
 
 X86 TRUST DOMAIN EXTENSIONS (TDX)
 M:	Kiryl Shutsemau <kas@kernel.org>
diff --git a/arch/loongarch/include/asm/module.h b/arch/loongarch/include/asm/module.h
index d56a968273de..cc421db73ed4 100644
--- a/arch/loongarch/include/asm/module.h
+++ b/arch/loongarch/include/asm/module.h
@@ -6,7 +6,6 @@
 #define _ASM_MODULE_H
 
 #include <asm/inst.h>
-#include <asm/orc_types.h>
 #include <asm-generic/module.h>
 
 #define RELA_STACK_DEPTH 16
@@ -22,12 +21,6 @@ struct mod_arch_specific {
 	struct mod_section plt;
 	struct mod_section plt_idx;
 
-#ifdef CONFIG_UNWINDER_ORC
-	unsigned int num_orcs;
-	int *orc_unwind_ip;
-	struct orc_entry *orc_unwind;
-#endif
-
 	/* For CONFIG_DYNAMIC_FTRACE */
 	struct plt_entry *ftrace_trampolines;
 };
diff --git a/arch/loongarch/include/asm/unwind.h b/arch/loongarch/include/asm/unwind.h
index 40a6763c5aec..7a5f1458373f 100644
--- a/arch/loongarch/include/asm/unwind.h
+++ b/arch/loongarch/include/asm/unwind.h
@@ -89,10 +89,8 @@ static __always_inline unsigned long __unwind_get_return_address(struct unwind_s
 
 #ifdef CONFIG_UNWINDER_ORC
 void unwind_init(void);
-void unwind_module_init(struct module *mod, void *orc_ip, size_t orc_ip_size, void *orc, size_t orc_size);
 #else
 static inline void unwind_init(void) {}
-static inline void unwind_module_init(struct module *mod, void *orc_ip, size_t orc_ip_size, void *orc, size_t orc_size) {}
 #endif
 
 #endif /* _ASM_UNWIND_H */
diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
index 7d4d571ee55e..21f7542003d4 100644
--- a/arch/loongarch/kernel/module.c
+++ b/arch/loongarch/kernel/module.c
@@ -20,7 +20,6 @@
 #include <linux/kernel.h>
 #include <asm/alternative.h>
 #include <asm/inst.h>
-#include <asm/unwind.h>
 
 /*
  * reloc_rela_handler() - Apply a particular relocation to a module
@@ -607,15 +606,11 @@ int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs, struct module *mod)
 {
 	const char *secstrs = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
-	const Elf_Shdr *s, *alt = NULL, *orc = NULL, *orc_ip = NULL, *ftrace = NULL;
+	const Elf_Shdr *s, *alt = NULL, *ftrace = NULL;
 
 	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
 		if (!strcmp(".altinstructions", secstrs + s->sh_name))
 			alt = s;
-		if (!strcmp(".orc_unwind", secstrs + s->sh_name))
-			orc = s;
-		if (!strcmp(".orc_unwind_ip", secstrs + s->sh_name))
-			orc_ip = s;
 		if (!strcmp(".ftrace_trampoline", secstrs + s->sh_name))
 			ftrace = s;
 	}
@@ -623,9 +618,6 @@ int module_finalize(const Elf_Ehdr *hdr,
 	if (alt)
 		apply_alternatives((void *)alt->sh_addr, (void *)alt->sh_addr + alt->sh_size);
 
-	if (orc && orc_ip)
-		unwind_module_init(mod, (void *)orc_ip->sh_addr, orc_ip->sh_size, (void *)orc->sh_addr, orc->sh_size);
-
 	if (ftrace)
 		module_init_ftrace_plt(hdr, ftrace, mod);
 
diff --git a/arch/loongarch/kernel/unwind_orc.c b/arch/loongarch/kernel/unwind_orc.c
index 9cfb5bb1991f..129f248836a7 100644
--- a/arch/loongarch/kernel/unwind_orc.c
+++ b/arch/loongarch/kernel/unwind_orc.c
@@ -2,7 +2,7 @@
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/objtool.h>
-#include <linux/sort.h>
+#include <linux/orc.h>
 #include <asm/exception.h>
 #include <asm/orc_header.h>
 #include <asm/orc_lookup.h>
@@ -51,58 +51,6 @@ static struct orc_entry orc_null_entry = {
 	.type		= ORC_TYPE_CALL
 };
 
-static inline unsigned long orc_ip(const int *ip)
-{
-	return (unsigned long)ip + *ip;
-}
-
-static struct orc_entry *__orc_find(int *ip_table, struct orc_entry *u_table,
-				    unsigned int num_entries, unsigned long ip)
-{
-	int *first = ip_table;
-	int *mid = first, *found = first;
-	int *last = ip_table + num_entries - 1;
-
-	if (!num_entries)
-		return NULL;
-
-	/*
-	 * Do a binary range search to find the rightmost duplicate of a given
-	 * starting address.  Some entries are section terminators which are
-	 * "weak" entries for ensuring there are no gaps.  They should be
-	 * ignored when they conflict with a real entry.
-	 */
-	while (first <= last) {
-		mid = first + ((last - first) / 2);
-
-		if (orc_ip(mid) <= ip) {
-			found = mid;
-			first = mid + 1;
-		} else
-			last = mid - 1;
-	}
-
-	return u_table + (found - ip_table);
-}
-
-#ifdef CONFIG_MODULES
-static struct orc_entry *orc_module_find(unsigned long ip)
-{
-	struct module *mod;
-
-	mod = __module_address(ip);
-	if (!mod || !mod->arch.orc_unwind || !mod->arch.orc_unwind_ip)
-		return NULL;
-
-	return __orc_find(mod->arch.orc_unwind_ip, mod->arch.orc_unwind, mod->arch.num_orcs, ip);
-}
-#else
-static struct orc_entry *orc_module_find(unsigned long ip)
-{
-	return NULL;
-}
-#endif
-
 #ifdef CONFIG_DYNAMIC_FTRACE
 static struct orc_entry *orc_find(unsigned long ip);
 
@@ -194,80 +142,6 @@ static struct orc_entry *orc_find(unsigned long ip)
 	return orc_ftrace_find(ip);
 }
 
-#ifdef CONFIG_MODULES
-
-static DEFINE_MUTEX(sort_mutex);
-static int *cur_orc_ip_table = __start_orc_unwind_ip;
-static struct orc_entry *cur_orc_table = __start_orc_unwind;
-
-static void orc_sort_swap(void *_a, void *_b, int size)
-{
-	int delta = _b - _a;
-	int *a = _a, *b = _b, tmp;
-	struct orc_entry *orc_a, *orc_b;
-
-	/* Swap the .orc_unwind_ip entries: */
-	tmp = *a;
-	*a = *b + delta;
-	*b = tmp - delta;
-
-	/* Swap the corresponding .orc_unwind entries: */
-	orc_a = cur_orc_table + (a - cur_orc_ip_table);
-	orc_b = cur_orc_table + (b - cur_orc_ip_table);
-	swap(*orc_a, *orc_b);
-}
-
-static int orc_sort_cmp(const void *_a, const void *_b)
-{
-	const int *a = _a, *b = _b;
-	unsigned long a_val = orc_ip(a);
-	unsigned long b_val = orc_ip(b);
-	struct orc_entry *orc_a;
-
-	if (a_val > b_val)
-		return 1;
-	if (a_val < b_val)
-		return -1;
-
-	/*
-	 * The "weak" section terminator entries need to always be first
-	 * to ensure the lookup code skips them in favor of real entries.
-	 * These terminator entries exist to handle any gaps created by
-	 * whitelisted .o files which didn't get objtool generation.
-	 */
-	orc_a = cur_orc_table + (a - cur_orc_ip_table);
-
-	return orc_a->type == ORC_TYPE_UNDEFINED ? -1 : 1;
-}
-
-void unwind_module_init(struct module *mod, void *_orc_ip, size_t orc_ip_size,
-			void *_orc, size_t orc_size)
-{
-	int *orc_ip = _orc_ip;
-	struct orc_entry *orc = _orc;
-	unsigned int num_entries = orc_ip_size / sizeof(int);
-
-	WARN_ON_ONCE(orc_ip_size % sizeof(int) != 0 ||
-		     orc_size % sizeof(*orc) != 0 ||
-		     num_entries != orc_size / sizeof(*orc));
-
-	/*
-	 * The 'cur_orc_*' globals allow the orc_sort_swap() callback to
-	 * associate an .orc_unwind_ip table entry with its corresponding
-	 * .orc_unwind entry so they can both be swapped.
-	 */
-	mutex_lock(&sort_mutex);
-	cur_orc_ip_table = orc_ip;
-	cur_orc_table = orc;
-	sort(orc_ip, num_entries, sizeof(int), orc_sort_cmp, orc_sort_swap);
-	mutex_unlock(&sort_mutex);
-
-	mod->arch.orc_unwind_ip = orc_ip;
-	mod->arch.orc_unwind = orc;
-	mod->arch.num_orcs = num_entries;
-}
-#endif
-
 void __init unwind_init(void)
 {
 	int i;
diff --git a/arch/x86/include/asm/module.h b/arch/x86/include/asm/module.h
index 3c2de4ce3b10..6717e85e8605 100644
--- a/arch/x86/include/asm/module.h
+++ b/arch/x86/include/asm/module.h
@@ -3,7 +3,6 @@
 #define _ASM_X86_MODULE_H
 
 #include <asm-generic/module.h>
-#include <asm/orc_types.h>
 
 struct its_array {
 #ifdef CONFIG_MITIGATION_ITS
@@ -13,11 +12,6 @@ struct its_array {
 };
 
 struct mod_arch_specific {
-#ifdef CONFIG_UNWINDER_ORC
-	unsigned int num_orcs;
-	int *orc_unwind_ip;
-	struct orc_entry *orc_unwind;
-#endif
 	struct its_array its_pages;
 };
 
diff --git a/arch/x86/include/asm/unwind.h b/arch/x86/include/asm/unwind.h
index 7cede4dc21f0..71af8246c69e 100644
--- a/arch/x86/include/asm/unwind.h
+++ b/arch/x86/include/asm/unwind.h
@@ -94,13 +94,8 @@ static inline struct pt_regs *unwind_get_entry_regs(struct unwind_state *state,
 
 #ifdef CONFIG_UNWINDER_ORC
 void unwind_init(void);
-void unwind_module_init(struct module *mod, void *orc_ip, size_t orc_ip_size,
-			void *orc, size_t orc_size);
 #else
 static inline void unwind_init(void) {}
-static inline
-void unwind_module_init(struct module *mod, void *orc_ip, size_t orc_ip_size,
-			void *orc, size_t orc_size) {}
 #endif
 
 static inline
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 33080ad889b7..cf59f9f42d0b 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -23,7 +23,6 @@
 #include <asm/text-patching.h>
 #include <asm/page.h>
 #include <asm/setup.h>
-#include <asm/unwind.h>
 
 #if 0
 #define DEBUGP(fmt, ...)				\
@@ -228,7 +227,6 @@ int module_finalize(const Elf_Ehdr *hdr,
 		    struct module *me)
 {
 	const Elf_Shdr *s, *alt = NULL,
-		*orc = NULL, *orc_ip = NULL,
 		*retpolines = NULL, *returns = NULL, *ibt_endbr = NULL,
 		*calls = NULL, *cfi = NULL;
 	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
@@ -236,10 +234,6 @@ int module_finalize(const Elf_Ehdr *hdr,
 	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
 		if (!strcmp(".altinstructions", secstrings + s->sh_name))
 			alt = s;
-		if (!strcmp(".orc_unwind", secstrings + s->sh_name))
-			orc = s;
-		if (!strcmp(".orc_unwind_ip", secstrings + s->sh_name))
-			orc_ip = s;
 		if (!strcmp(".retpoline_sites", secstrings + s->sh_name))
 			retpolines = s;
 		if (!strcmp(".return_sites", secstrings + s->sh_name))
@@ -299,10 +293,6 @@ int module_finalize(const Elf_Ehdr *hdr,
 		apply_seal_endbr(iseg, iseg + ibt_endbr->sh_size);
 	}
 
-	if (orc && orc_ip)
-		unwind_module_init(me, (void *)orc_ip->sh_addr, orc_ip->sh_size,
-				   (void *)orc->sh_addr, orc->sh_size);
-
 	return 0;
 }
 
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 6407bc9256bf..6ea1ea28e9df 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/objtool.h>
 #include <linux/module.h>
-#include <linux/sort.h>
+#include <linux/orc.h>
 #include <linux/bpf.h>
 #include <asm/ptrace.h>
 #include <asm/stacktrace.h>
@@ -76,58 +76,6 @@ static void unwind_dump(struct unwind_state *state)
 	}
 }
 
-static inline unsigned long orc_ip(const int *ip)
-{
-	return (unsigned long)ip + *ip;
-}
-
-static struct orc_entry *__orc_find(int *ip_table, struct orc_entry *u_table,
-				    unsigned int num_entries, unsigned long ip)
-{
-	int *first = ip_table;
-	int *last = ip_table + num_entries - 1;
-	int *mid, *found = first;
-
-	if (!num_entries)
-		return NULL;
-
-	/*
-	 * Do a binary range search to find the rightmost duplicate of a given
-	 * starting address.  Some entries are section terminators which are
-	 * "weak" entries for ensuring there are no gaps.  They should be
-	 * ignored when they conflict with a real entry.
-	 */
-	while (first <= last) {
-		mid = first + ((last - first) / 2);
-
-		if (orc_ip(mid) <= ip) {
-			found = mid;
-			first = mid + 1;
-		} else
-			last = mid - 1;
-	}
-
-	return u_table + (found - ip_table);
-}
-
-#ifdef CONFIG_MODULES
-static struct orc_entry *orc_module_find(unsigned long ip)
-{
-	struct module *mod;
-
-	mod = __module_address(ip);
-	if (!mod || !mod->arch.orc_unwind || !mod->arch.orc_unwind_ip)
-		return NULL;
-	return __orc_find(mod->arch.orc_unwind_ip, mod->arch.orc_unwind,
-			  mod->arch.num_orcs, ip);
-}
-#else
-static struct orc_entry *orc_module_find(unsigned long ip)
-{
-	return NULL;
-}
-#endif
-
 #ifdef CONFIG_DYNAMIC_FTRACE
 static struct orc_entry *orc_find(unsigned long ip);
 
@@ -257,79 +205,6 @@ static struct orc_entry *orc_find(unsigned long ip)
 	return orc_ftrace_find(ip);
 }
 
-#ifdef CONFIG_MODULES
-
-static DEFINE_MUTEX(sort_mutex);
-static int *cur_orc_ip_table = __start_orc_unwind_ip;
-static struct orc_entry *cur_orc_table = __start_orc_unwind;
-
-static void orc_sort_swap(void *_a, void *_b, int size)
-{
-	struct orc_entry *orc_a, *orc_b;
-	int *a = _a, *b = _b, tmp;
-	int delta = _b - _a;
-
-	/* Swap the .orc_unwind_ip entries: */
-	tmp = *a;
-	*a = *b + delta;
-	*b = tmp - delta;
-
-	/* Swap the corresponding .orc_unwind entries: */
-	orc_a = cur_orc_table + (a - cur_orc_ip_table);
-	orc_b = cur_orc_table + (b - cur_orc_ip_table);
-	swap(*orc_a, *orc_b);
-}
-
-static int orc_sort_cmp(const void *_a, const void *_b)
-{
-	struct orc_entry *orc_a;
-	const int *a = _a, *b = _b;
-	unsigned long a_val = orc_ip(a);
-	unsigned long b_val = orc_ip(b);
-
-	if (a_val > b_val)
-		return 1;
-	if (a_val < b_val)
-		return -1;
-
-	/*
-	 * The "weak" section terminator entries need to always be first
-	 * to ensure the lookup code skips them in favor of real entries.
-	 * These terminator entries exist to handle any gaps created by
-	 * whitelisted .o files which didn't get objtool generation.
-	 */
-	orc_a = cur_orc_table + (a - cur_orc_ip_table);
-	return orc_a->type == ORC_TYPE_UNDEFINED ? -1 : 1;
-}
-
-void unwind_module_init(struct module *mod, void *_orc_ip, size_t orc_ip_size,
-			void *_orc, size_t orc_size)
-{
-	int *orc_ip = _orc_ip;
-	struct orc_entry *orc = _orc;
-	unsigned int num_entries = orc_ip_size / sizeof(int);
-
-	WARN_ON_ONCE(orc_ip_size % sizeof(int) != 0 ||
-		     orc_size % sizeof(*orc) != 0 ||
-		     num_entries != orc_size / sizeof(*orc));
-
-	/*
-	 * The 'cur_orc_*' globals allow the orc_sort_swap() callback to
-	 * associate an .orc_unwind_ip table entry with its corresponding
-	 * .orc_unwind entry so they can both be swapped.
-	 */
-	mutex_lock(&sort_mutex);
-	cur_orc_ip_table = orc_ip;
-	cur_orc_table = orc;
-	sort(orc_ip, num_entries, sizeof(int), orc_sort_cmp, orc_sort_swap);
-	mutex_unlock(&sort_mutex);
-
-	mod->arch.orc_unwind_ip = orc_ip;
-	mod->arch.orc_unwind = orc;
-	mod->arch.num_orcs = num_entries;
-}
-#endif
-
 void __init unwind_init(void)
 {
 	size_t orc_ip_size = (void *)__stop_orc_unwind_ip - (void *)__start_orc_unwind_ip;
diff --git a/include/linux/module.h b/include/linux/module.h
index 96cc98568eea..089b34c83eb0 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -42,6 +42,7 @@ struct modversion_info {
 
 struct module;
 struct exception_table_entry;
+struct orc_entry;
 
 struct module_kobject {
 	struct kobject kobj;
@@ -465,6 +466,12 @@ struct module {
 	struct bug_entry *bug_table;
 #endif
 
+#ifdef CONFIG_UNWINDER_ORC
+	unsigned int num_orcs;
+	int *orc_unwind_ip;
+	struct orc_entry *orc_unwind;
+#endif
+
 #ifdef CONFIG_KALLSYMS
 	/* Protected by RCU and/or module_mutex: use rcu_dereference() */
 	struct mod_kallsyms __rcu *kallsyms;
diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index e395461d59e5..893ca5717383 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -108,6 +108,12 @@ int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *mod);
 
+#ifdef CONFIG_UNWINDER_ORC
+/* Sort the module's ORC tables and make them available to the unwinder. */
+void unwind_module_init(struct module *mod, void *orc_ip, size_t orc_ip_size,
+			void *orc, size_t orc_size);
+#endif
+
 #ifdef CONFIG_MODULES
 void flush_module_init_free_work(void);
 #else
diff --git a/include/linux/orc.h b/include/linux/orc.h
new file mode 100644
index 000000000000..c2e84cf85132
--- /dev/null
+++ b/include/linux/orc.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_ORC_H
+#define _LINUX_ORC_H
+
+#include <asm/orc_types.h>
+
+static inline unsigned long orc_ip(const int *ip)
+{
+	return (unsigned long)ip + *ip;
+}
+
+struct orc_entry *__orc_find(int *ip_table, struct orc_entry *u_table,
+			     unsigned int num_entries, unsigned long ip);
+
+#ifdef CONFIG_MODULES
+struct orc_entry *orc_module_find(unsigned long ip);
+#else
+static inline struct orc_entry *orc_module_find(unsigned long ip)
+{
+	return NULL;
+}
+#endif
+
+#endif /* _LINUX_ORC_H */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index d0e1e0bd2ad0..d0cbaa2a5d0c 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3015,8 +3015,24 @@ int __weak module_finalize(const Elf_Ehdr *hdr,
 	return 0;
 }
 
+static void module_unwind_init(struct module *mod, const struct load_info *info)
+{
+#ifdef CONFIG_UNWINDER_ORC
+	unsigned int orc = find_sec(info, ".orc_unwind");
+	unsigned int orc_ip = find_sec(info, ".orc_unwind_ip");
+
+	if (orc && orc_ip)
+		unwind_module_init(mod, (void *)info->sechdrs[orc_ip].sh_addr,
+				   info->sechdrs[orc_ip].sh_size,
+				   (void *)info->sechdrs[orc].sh_addr,
+				   info->sechdrs[orc].sh_size);
+#endif
+}
+
 static int post_relocation(struct module *mod, const struct load_info *info)
 {
+	int err;
+
 	/* Sort exception table now relocations are done. */
 	sort_extable(mod->extable, mod->extable + mod->num_exentries);
 
@@ -3028,7 +3044,12 @@ static int post_relocation(struct module *mod, const struct load_info *info)
 	add_kallsyms(mod, info);
 
 	/* Arch-specific module finalizing. */
-	return module_finalize(info->hdr, info->sechdrs, mod);
+	err = module_finalize(info->hdr, info->sechdrs, mod);
+	if (err)
+		return err;
+
+	module_unwind_init(mod, info);
+	return 0;
 }
 
 /* Call module constructors. */
diff --git a/lib/Makefile b/lib/Makefile
index dfab958327c5..1ccd88ca9e7b 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -255,6 +255,9 @@ KASAN_SANITIZE_stackdepot.o := n
 KMSAN_SANITIZE_stackdepot.o := n
 KCOV_INSTRUMENT_stackdepot.o := n
 
+obj-$(CONFIG_UNWINDER_ORC) += orc.o
+KCOV_INSTRUMENT_orc.o := n
+
 obj-$(CONFIG_REF_TRACKER) += ref_tracker.o
 
 libfdt_files = fdt.o fdt_ro.o fdt_wip.o fdt_rw.o fdt_sw.o fdt_strerror.o \
diff --git a/lib/orc.c b/lib/orc.c
new file mode 100644
index 000000000000..980bd563b2cd
--- /dev/null
+++ b/lib/orc.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/module.h>
+#include <linux/moduleloader.h>
+#include <linux/mutex.h>
+#include <linux/orc.h>
+#include <linux/sort.h>
+
+struct orc_entry *__orc_find(int *ip_table, struct orc_entry *u_table,
+			     unsigned int num_entries, unsigned long ip)
+{
+	int *first = ip_table;
+	int *last = ip_table + num_entries - 1;
+	int *mid, *found = first;
+
+	if (!num_entries)
+		return NULL;
+
+	/*
+	 * Do a binary range search to find the rightmost duplicate of a given
+	 * starting address.  Some entries are section terminators which are
+	 * "weak" entries for ensuring there are no gaps.  They should be
+	 * ignored when they conflict with a real entry.
+	 */
+	while (first <= last) {
+		mid = first + ((last - first) / 2);
+
+		if (orc_ip(mid) <= ip) {
+			found = mid;
+			first = mid + 1;
+		} else {
+			last = mid - 1;
+		}
+	}
+
+	return u_table + (found - ip_table);
+}
+
+#ifdef CONFIG_MODULES
+struct orc_entry *orc_module_find(unsigned long ip)
+{
+	struct module *mod;
+
+	mod = __module_address(ip);
+	if (!mod || !mod->orc_unwind || !mod->orc_unwind_ip)
+		return NULL;
+	return __orc_find(mod->orc_unwind_ip, mod->orc_unwind,
+			  mod->num_orcs, ip);
+}
+
+static DEFINE_MUTEX(sort_mutex);
+static int *cur_orc_ip_table;
+static struct orc_entry *cur_orc_table;
+
+static void orc_sort_swap(void *_a, void *_b, int size)
+{
+	struct orc_entry *orc_a, *orc_b;
+	int *a = _a, *b = _b, tmp;
+	int delta = _b - _a;
+
+	/* Swap the .orc_unwind_ip entries: */
+	tmp = *a;
+	*a = *b + delta;
+	*b = tmp - delta;
+
+	/* Swap the corresponding .orc_unwind entries: */
+	orc_a = cur_orc_table + (a - cur_orc_ip_table);
+	orc_b = cur_orc_table + (b - cur_orc_ip_table);
+	swap(*orc_a, *orc_b);
+}
+
+static int orc_sort_cmp(const void *_a, const void *_b)
+{
+	struct orc_entry *orc_a;
+	const int *a = _a, *b = _b;
+	unsigned long a_val = orc_ip(a);
+	unsigned long b_val = orc_ip(b);
+
+	if (a_val > b_val)
+		return 1;
+	if (a_val < b_val)
+		return -1;
+
+	/*
+	 * The "weak" section terminator entries need to always be first
+	 * to ensure the lookup code skips them in favor of real entries.
+	 * These terminator entries exist to handle any gaps created by
+	 * whitelisted .o files which didn't get objtool generation.
+	 */
+	orc_a = cur_orc_table + (a - cur_orc_ip_table);
+	return orc_a->type == ORC_TYPE_UNDEFINED ? -1 : 1;
+}
+
+void unwind_module_init(struct module *mod, void *_orc_ip, size_t orc_ip_size,
+			void *_orc, size_t orc_size)
+{
+	int *orc_ip = _orc_ip;
+	struct orc_entry *orc = _orc;
+	unsigned int num_entries = orc_ip_size / sizeof(int);
+
+	WARN_ON_ONCE(orc_ip_size % sizeof(int) != 0 ||
+		     orc_size % sizeof(*orc) != 0 ||
+		     num_entries != orc_size / sizeof(*orc));
+
+	/*
+	 * The 'cur_orc_*' globals allow the orc_sort_swap() callback to
+	 * associate an .orc_unwind_ip table entry with its corresponding
+	 * .orc_unwind entry so they can both be swapped.
+	 */
+	mutex_lock(&sort_mutex);
+	cur_orc_ip_table = orc_ip;
+	cur_orc_table = orc;
+	sort(orc_ip, num_entries, sizeof(int), orc_sort_cmp, orc_sort_swap);
+	mutex_unlock(&sort_mutex);
+
+	mod->orc_unwind_ip = orc_ip;
+	mod->orc_unwind = orc;
+	mod->num_orcs = num_entries;
+}
+#endif
-- 
2.55.0

