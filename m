From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v5 3/3] kallsyms: add support for relative offsets in kallsyms address table
Date: Mon,  8 Feb 2016 18:57:48 +0100
Message-ID: <1454954268-3225-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1454954268-3225-1-git-send-email-ard.biesheuvel@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454954268-3225-1-git-send-email-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, keescook@chromium.org, akpm@linux-foundation.org, mingo@kernel.org, hpa@zytor.com, heiko.carstens@de.ibm.com, benh@kernel.crashing.org, mpe@ellerman.id.au, mmarek@suse.cz, rusty@rustcorp.com.au, arnd@arndb.de, linux-arch@vger.kernel.org, linux@roeck-us.net
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
List-ID: <linux-s390.vger.kernel.org>

Similar to how relative extables are implemented, it is possible to emit
the kallsyms table in such a way that it contains offsets relative to some
anchor point in the kernel image rather than absolute addresses.

On 64-bit architectures, it cuts the size of the kallsyms address table in
half, since offsets between kernel symbols can typically be expressed in 32
bits. This saves several hundreds of kilobytes of permanent .rodata on
average. In addition, the kallsyms address table is no longer subject to
dynamic relocation when CONFIG_RELOCATABLE is in effect, so the relocation
work done after decompression now doesn't have to do relocation updates for
all these values. This saves up to 24 bytes (i.e., the size of a ELF64 RELA
relocation table entry) per value, which easily adds up to a couple of
megabytes of uncompressed __init data on ppc64 or arm64. Even if these
relocation entries typically compress well, the combined size reduction of
2.8 MB uncompressed for a ppc64_defconfig build (of which 2.4 MB is __init
data) results in a ~500 KB space saving in the compressed image.

Since it is useful for some architectures (like x86) to retain the ability
to emit absolute values as well, this patch also adds support for capturing
both absolute and relative values when KALLSYMS_ABSOLUTE_PERCPU is in
effect, by emitting absolute per-cpu addresses as positive 32-bit values,
and addresses relative to the lowest encountered relative symbol as
negative values, which are subtracted from the runtime address of this base
symbol to produce the actual address.

Support for the above is enabled by default for all architectures except
IA-64 and Tile-GX, whose symbols are too far apart to capture in this
manner.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 init/Kconfig            | 18 ++++
 kernel/kallsyms.c       | 42 +++++++--
 scripts/kallsyms.c      | 89 +++++++++++++++++---
 scripts/link-vmlinux.sh |  4 +
 scripts/namespace.pl    |  2 +
 5 files changed, 136 insertions(+), 19 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index b17824a875fa..6d48682fbcae 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1424,6 +1424,24 @@ config KALLSYMS_ABSOLUTE_PERCPU
 	bool
 	default X86_64 && SMP
 
+config KALLSYMS_BASE_RELATIVE
+	bool
+	depends on KALLSYMS
+	default !IA64 && !(TILE && 64BIT)
+	help
+	  Instead of emitting them as absolute values in the native word size,
+	  emit the symbol references in the kallsyms table as 32-bit entries,
+	  each containing a relative value in the range [base, base + U32_MAX]
+	  or, when KALLSYMS_ABSOLUTE_PERCPU is in effect, each containing either
+	  an absolute value in the range [0, S32_MAX] or a relative value in the
+	  range [base, base + S32_MAX], where base is the lowest relative symbol
+	  address encountered in the image.
+
+	  On 64-bit builds, this reduces the size of the address table by 50%,
+	  but more importantly, it results in entries whose values are build
+	  time constants, and no relocation pass is required at runtime to fix
+	  up the entries based on the runtime load address of the kernel.
+
 config PRINTK
 	default y
 	bool "Enable support for printk" if EXPERT
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 5c5987f10819..fafd1a3ef0da 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -38,6 +38,7 @@
  * during the second link stage.
  */
 extern const unsigned long kallsyms_addresses[] __weak;
+extern const int kallsyms_offsets[] __weak;
 extern const u8 kallsyms_names[] __weak;
 
 /*
@@ -47,6 +48,9 @@ extern const u8 kallsyms_names[] __weak;
 extern const unsigned long kallsyms_num_syms
 __attribute__((weak, section(".rodata")));
 
+extern const unsigned long kallsyms_relative_base
+__attribute__((weak, section(".rodata")));
+
 extern const u8 kallsyms_token_table[] __weak;
 extern const u16 kallsyms_token_index[] __weak;
 
@@ -176,6 +180,23 @@ static unsigned int get_symbol_offset(unsigned long pos)
 	return name - kallsyms_names;
 }
 
+static unsigned long kallsyms_sym_address(int idx)
+{
+	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
+		return kallsyms_addresses[idx];
+
+	/* values are unsigned offsets if --absolute-percpu is not in effect */
+	if (!IS_ENABLED(CONFIG_KALLSYMS_ABSOLUTE_PERCPU))
+		return kallsyms_relative_base + (u32)kallsyms_offsets[idx];
+
+	/* ...otherwise, positive offsets are absolute values */
+	if (kallsyms_offsets[idx] >= 0)
+		return kallsyms_offsets[idx];
+
+	/* ...and negative offsets are relative to kallsyms_relative_base - 1 */
+	return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
+}
+
 /* Lookup the address for this symbol. Returns 0 if not found. */
 unsigned long kallsyms_lookup_name(const char *name)
 {
@@ -187,7 +208,7 @@ unsigned long kallsyms_lookup_name(const char *name)
 		off = kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
 
 		if (strcmp(namebuf, name) == 0)
-			return kallsyms_addresses[i];
+			return kallsyms_sym_address(i);
 	}
 	return module_kallsyms_lookup_name(name);
 }
@@ -204,7 +225,7 @@ int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
 
 	for (i = 0, off = 0; i < kallsyms_num_syms; i++) {
 		off = kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
-		ret = fn(data, namebuf, NULL, kallsyms_addresses[i]);
+		ret = fn(data, namebuf, NULL, kallsyms_sym_address(i));
 		if (ret != 0)
 			return ret;
 	}
@@ -220,7 +241,10 @@ static unsigned long get_symbol_pos(unsigned long addr,
 	unsigned long i, low, high, mid;
 
 	/* This kernel should never had been booted. */
-	BUG_ON(!kallsyms_addresses);
+	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
+		BUG_ON(!kallsyms_addresses);
+	else
+		BUG_ON(!kallsyms_offsets);
 
 	/* Do a binary search on the sorted kallsyms_addresses array. */
 	low = 0;
@@ -228,7 +252,7 @@ static unsigned long get_symbol_pos(unsigned long addr,
 
 	while (high - low > 1) {
 		mid = low + (high - low) / 2;
-		if (kallsyms_addresses[mid] <= addr)
+		if (kallsyms_sym_address(mid) <= addr)
 			low = mid;
 		else
 			high = mid;
@@ -238,15 +262,15 @@ static unsigned long get_symbol_pos(unsigned long addr,
 	 * Search for the first aliased symbol. Aliased
 	 * symbols are symbols with the same address.
 	 */
-	while (low && kallsyms_addresses[low-1] == kallsyms_addresses[low])
+	while (low && kallsyms_sym_address(low-1) == kallsyms_sym_address(low))
 		--low;
 
-	symbol_start = kallsyms_addresses[low];
+	symbol_start = kallsyms_sym_address(low);
 
 	/* Search for next non-aliased symbol. */
 	for (i = low + 1; i < kallsyms_num_syms; i++) {
-		if (kallsyms_addresses[i] > symbol_start) {
-			symbol_end = kallsyms_addresses[i];
+		if (kallsyms_sym_address(i) > symbol_start) {
+			symbol_end = kallsyms_sym_address(i);
 			break;
 		}
 	}
@@ -470,7 +494,7 @@ static unsigned long get_ksymbol_core(struct kallsym_iter *iter)
 	unsigned off = iter->nameoff;
 
 	iter->module_name[0] = '\0';
-	iter->value = kallsyms_addresses[iter->pos];
+	iter->value = kallsyms_sym_address(iter->pos);
 
 	iter->type = kallsyms_get_symbol_type(off);
 
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index d39a1eeb080e..073d4601b982 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -22,6 +22,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <ctype.h>
+#include <limits.h>
 
 #ifndef ARRAY_SIZE
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
@@ -43,6 +44,7 @@ struct addr_range {
 };
 
 static unsigned long long _text;
+static unsigned long long relative_base;
 static struct addr_range text_ranges[] = {
 	{ "_stext",     "_etext"     },
 	{ "_sinittext", "_einittext" },
@@ -62,6 +64,7 @@ static int all_symbols = 0;
 static int absolute_percpu = 0;
 static char symbol_prefix_char = '\0';
 static unsigned long long kernel_start_addr = 0;
+static int base_relative = 0;
 
 int token_profit[0x10000];
 
@@ -75,7 +78,7 @@ static void usage(void)
 	fprintf(stderr, "Usage: kallsyms [--all-symbols] "
 			"[--symbol-prefix=<prefix char>] "
 			"[--page-offset=<CONFIG_PAGE_OFFSET>] "
-			"< in.map > out.S\n");
+			"[--base-relative] < in.map > out.S\n");
 	exit(1);
 }
 
@@ -205,6 +208,8 @@ static int symbol_valid(struct sym_entry *s)
 	 */
 	static char *special_symbols[] = {
 		"kallsyms_addresses",
+		"kallsyms_offsets",
+		"kallsyms_relative_base",
 		"kallsyms_num_syms",
 		"kallsyms_names",
 		"kallsyms_markers",
@@ -349,16 +354,48 @@ static void write_src(void)
 
 	printf("\t.section .rodata, \"a\"\n");
 
-	/* Provide proper symbols relocatability by their '_text'
-	 * relativeness.  The symbol names cannot be used to construct
-	 * normal symbol references as the list of symbols contains
-	 * symbols that are declared static and are private to their
-	 * .o files.  This prevents .tmp_kallsyms.o or any other
-	 * object from referencing them.
+	/* Provide proper symbols relocatability by their relativeness
+	 * to a fixed anchor point in the runtime image, either '_text'
+	 * for absolute address tables, in which case the linker will
+	 * emit the final addresses at build time. Otherwise, use the
+	 * offset relative to the lowest value encountered of all relative
+	 * symbols, and emit non-relocatable fixed offsets that will be fixed
+	 * up at runtime.
+	 *
+	 * The symbol names cannot be used to construct normal symbol
+	 * references as the list of symbols contains symbols that are
+	 * declared static and are private to their .o files.  This prevents
+	 * .tmp_kallsyms.o or any other object from referencing them.
 	 */
-	output_label("kallsyms_addresses");
+	if (!base_relative)
+		output_label("kallsyms_addresses");
+	else
+		output_label("kallsyms_offsets");
+
 	for (i = 0; i < table_cnt; i++) {
-		if (!symbol_absolute(&table[i])) {
+		if (base_relative) {
+			long long offset;
+			int overflow;
+
+			if (!absolute_percpu) {
+				offset = table[i].addr - relative_base;
+				overflow = (offset < 0 || offset > UINT_MAX);
+			} else if (symbol_absolute(&table[i])) {
+				offset = table[i].addr;
+				overflow = (offset < 0 || offset > INT_MAX);
+			} else {
+				offset = relative_base - table[i].addr - 1;
+				overflow = (offset < INT_MIN || offset >= 0);
+			}
+			if (overflow) {
+				fprintf(stderr, "kallsyms failure: "
+					"%s symbol value %#llx out of range in relative mode\n",
+					symbol_absolute(&table[i]) ? "absolute" : "relative",
+					table[i].addr);
+				exit(EXIT_FAILURE);
+			}
+			printf("\t.long\t%#x\n", (int)offset);
+		} else if (!symbol_absolute(&table[i])) {
 			if (_text <= table[i].addr)
 				printf("\tPTR\t_text + %#llx\n",
 					table[i].addr - _text);
@@ -371,6 +408,12 @@ static void write_src(void)
 	}
 	printf("\n");
 
+	if (base_relative) {
+		output_label("kallsyms_relative_base");
+		printf("\tPTR\t_text - %#llx\n", _text - relative_base);
+		printf("\n");
+	}
+
 	output_label("kallsyms_num_syms");
 	printf("\tPTR\t%d\n", table_cnt);
 	printf("\n");
@@ -695,6 +738,18 @@ static void make_percpus_absolute(void)
 		}
 }
 
+/* find the minimum non-absolute symbol address */
+static void record_relative_base(void)
+{
+	unsigned int i;
+
+	relative_base = -1ULL;
+	for (i = 0; i < table_cnt; i++)
+		if (!symbol_absolute(&table[i]) &&
+		    table[i].addr < relative_base)
+			relative_base = table[i].addr;
+}
+
 int main(int argc, char **argv)
 {
 	if (argc >= 2) {
@@ -713,7 +768,9 @@ int main(int argc, char **argv)
 			} else if (strncmp(argv[i], "--page-offset=", 14) == 0) {
 				const char *p = &argv[i][14];
 				kernel_start_addr = strtoull(p, NULL, 16);
-			} else
+			} else if (strcmp(argv[i], "--base-relative") == 0)
+				base_relative = 1;
+			else
 				usage();
 		}
 	} else if (argc != 1)
@@ -722,6 +779,8 @@ int main(int argc, char **argv)
 	read_map(stdin);
 	if (absolute_percpu)
 		make_percpus_absolute();
+	if (base_relative)
+		record_relative_base();
 	sort_symbols();
 	optimize_token_table();
 	write_src();
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 7a08bf9a9576..453ede9d2f3d 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -90,6 +90,10 @@ kallsyms()
 		kallsymopt="${kallsymopt} --absolute-percpu"
 	fi
 
+	if [ -n "${CONFIG_KALLSYMS_BASE_RELATIVE}" ]; then
+		kallsymopt="${kallsymopt} --base-relative"
+	fi
+
 	local aflags="${KBUILD_AFLAGS} ${KBUILD_AFLAGS_KERNEL}               \
 		      ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS}"
 
diff --git a/scripts/namespace.pl b/scripts/namespace.pl
index a71be6b7cdec..9f3c9d47a4a5 100755
--- a/scripts/namespace.pl
+++ b/scripts/namespace.pl
@@ -117,6 +117,8 @@ my %nameexception = (
     'kallsyms_names'	=> 1,
     'kallsyms_num_syms'	=> 1,
     'kallsyms_addresses'=> 1,
+    'kallsyms_offsets'	=> 1,
+    'kallsyms_relative_base'=> 1,
     '__this_module'	=> 1,
     '_etext'		=> 1,
     '_edata'		=> 1,
-- 
2.5.0
