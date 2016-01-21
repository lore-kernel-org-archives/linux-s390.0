From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v2] kallsyms: add support for relative offsets in kallsyms address table
Date: Thu, 21 Jan 2016 11:48:19 +0100
Message-ID: <1453373299-28181-1-git-send-email-ard.biesheuvel@linaro.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, keescook@chromium.org, akpm@linux-foundation.org, mingo@kernel.org, hpa@zytor.com, heiko.carstens@de.ibm.com, benh@kernel.crashing.org, mpe@ellerman.id.au, mmarek@suse.cz, rusty@rustcorp.com.au, arnd@arndb.de, linux-arch@vger.kernel.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
List-ID: <linux-s390.vger.kernel.org>

Similar to how relative extables are implemented, it is possible to emit
the kallsyms table in such a way that it contains offsets relative to some
anchor point in the kernel image rather than absolute addresses. The benefit
is that such table entries are no longer subject to dynamic relocation when
the build time and runtime offsets of the kernel image are different. Also,
on 64-bit architectures, it essentially cuts the size of the address table
in half since offsets can typically be expressed in 32 bits.

Since it is useful for some architectures (like x86) to retain the ability
to emit absolute values as well, this patch adds support for both, by
emitting absolute addresses as positive 32-bit values, and addresses
relative to the lowest encountered relative symbol as negative values, which
are subtracted from the runtime address of this base symbol to produce the
actual address.

Support for the above is enabled by default for all architectures except
IA-64, whose symbols are too far apart to capture in this manner.

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Tested-by: Michael Ellerman <mpe@ellerman.id.au> # powerpc
Tested-by: Kees Cook <keescook@chromium.org> # x86_64
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
v2:
- use a variable base detected at build time rather than the fixed _text, which
  allows most architectures to make use of this, even if some of its relative
  symbols live before _text in the memory map
- enable it implicitly for all architectures except ia64

I took the liberty to preserve all the tags, since v1 would fail the build
if _text was above the lowest encountered relative symbol, so for the
architectures that have been tested by others (s390, x86 and power), v1 and
v2 are essentially equivalent.
I have build tested alpha and frv myself, and tested ARM and arm64 both build
time and runtime. More data points are always welcome, of course!

 init/Kconfig            | 16 ++++
 kernel/kallsyms.c       | 38 +++++++---
 scripts/kallsyms.c      | 78 +++++++++++++++++---
 scripts/link-vmlinux.sh |  4 +
 scripts/namespace.pl    |  1 +
 5 files changed, 118 insertions(+), 19 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 5b86082fa238..f8a0134c36b4 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1427,6 +1427,22 @@ config KALLSYMS_ALL
 
 	   Say N unless you really need all symbols.
 
+config KALLSYMS_BASE_RELATIVE
+	bool
+	depends on KALLSYMS
+	default !IA64
+	help
+	  Instead of emitting them as absolute values in the native word size,
+	  emit the symbol references in the kallsyms table as 32-bit entries,
+	  each containing either an absolute value in the range [0, S32_MAX] or
+	  a relative value in the range [base, base + S32_MAX], where base is
+	  the lowest relative symbol address encountered in the image.
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
index 5c5987f10819..10a8af9d5744 100644
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
 
@@ -176,6 +180,19 @@ static unsigned int get_symbol_offset(unsigned long pos)
 	return name - kallsyms_names;
 }
 
+static unsigned long kallsyms_sym_address(int idx)
+{
+	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
+		return kallsyms_addresses[idx];
+
+	/* positive offsets are absolute values */
+	if (kallsyms_offsets[idx] >= 0)
+		return kallsyms_offsets[idx];
+
+	/* negative offsets are relative to kallsyms_relative_base - 1 */
+	return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
+}
+
 /* Lookup the address for this symbol. Returns 0 if not found. */
 unsigned long kallsyms_lookup_name(const char *name)
 {
@@ -187,7 +204,7 @@ unsigned long kallsyms_lookup_name(const char *name)
 		off = kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
 
 		if (strcmp(namebuf, name) == 0)
-			return kallsyms_addresses[i];
+			return kallsyms_sym_address(i);
 	}
 	return module_kallsyms_lookup_name(name);
 }
@@ -204,7 +221,7 @@ int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
 
 	for (i = 0, off = 0; i < kallsyms_num_syms; i++) {
 		off = kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
-		ret = fn(data, namebuf, NULL, kallsyms_addresses[i]);
+		ret = fn(data, namebuf, NULL, kallsyms_sym_address(i));
 		if (ret != 0)
 			return ret;
 	}
@@ -220,7 +237,10 @@ static unsigned long get_symbol_pos(unsigned long addr,
 	unsigned long i, low, high, mid;
 
 	/* This kernel should never had been booted. */
-	BUG_ON(!kallsyms_addresses);
+	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
+		BUG_ON(!kallsyms_addresses);
+	else
+		BUG_ON(!kallsyms_offsets);
 
 	/* Do a binary search on the sorted kallsyms_addresses array. */
 	low = 0;
@@ -228,7 +248,7 @@ static unsigned long get_symbol_pos(unsigned long addr,
 
 	while (high - low > 1) {
 		mid = low + (high - low) / 2;
-		if (kallsyms_addresses[mid] <= addr)
+		if (kallsyms_sym_address(mid) <= addr)
 			low = mid;
 		else
 			high = mid;
@@ -238,15 +258,15 @@ static unsigned long get_symbol_pos(unsigned long addr,
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
@@ -470,7 +490,7 @@ static unsigned long get_ksymbol_core(struct kallsym_iter *iter)
 	unsigned off = iter->nameoff;
 
 	iter->module_name[0] = '\0';
-	iter->value = kallsyms_addresses[iter->pos];
+	iter->value = kallsyms_sym_address(iter->pos);
 
 	iter->type = kallsyms_get_symbol_type(off);
 
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 8fa81e84e295..7b46e536e6a9 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -22,6 +22,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <ctype.h>
+#include <limits.h>
 
 #ifndef ARRAY_SIZE
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
@@ -42,6 +43,7 @@ struct addr_range {
 };
 
 static unsigned long long _text;
+static unsigned long long relative_base;
 static struct addr_range text_ranges[] = {
 	{ "_stext",     "_etext"     },
 	{ "_sinittext", "_einittext" },
@@ -61,6 +63,7 @@ static int all_symbols = 0;
 static int absolute_percpu = 0;
 static char symbol_prefix_char = '\0';
 static unsigned long long kernel_start_addr = 0;
+static int base_relative = 0;
 
 int token_profit[0x10000];
 
@@ -74,7 +77,7 @@ static void usage(void)
 	fprintf(stderr, "Usage: kallsyms [--all-symbols] "
 			"[--symbol-prefix=<prefix char>] "
 			"[--page-offset=<CONFIG_PAGE_OFFSET>] "
-			"< in.map > out.S\n");
+			"[--base-relative] < in.map > out.S\n");
 	exit(1);
 }
 
@@ -202,6 +205,8 @@ static int symbol_valid(struct sym_entry *s)
 	 */
 	static char *special_symbols[] = {
 		"kallsyms_addresses",
+		"kallsyms_offsets",
+		"kallsyms_relative_base",
 		"kallsyms_num_syms",
 		"kallsyms_names",
 		"kallsyms_markers",
@@ -346,16 +351,47 @@ static void write_src(void)
 
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
+
+			if (symbol_absolute(&table[i])) {
+				offset = table[i].addr;
+				if (offset < 0 || offset > INT_MAX) {
+					fprintf(stderr, "kallsyms failure: "
+						"absolute symbol value %#llx out of range in relative mode\n",
+						table[i].addr);
+					exit(EXIT_FAILURE);
+				}
+			} else {
+				offset = relative_base - table[i].addr - 1;
+				if (offset < INT_MIN || offset >= 0) {
+					fprintf(stderr, "kallsyms failure: "
+						"relative symbol value %#llx out of range in relative mode\n",
+						table[i].addr);
+					exit(EXIT_FAILURE);
+				}
+			}
+			printf("\t.long\t%#x\n", (int)offset);
+		} else if (!symbol_absolute(&table[i])) {
 			if (_text <= table[i].addr)
 				printf("\tPTR\t_text + %#llx\n",
 					table[i].addr - _text);
@@ -368,6 +404,12 @@ static void write_src(void)
 	}
 	printf("\n");
 
+	if (base_relative) {
+		output_label("kallsyms_relative_base");
+		printf("\tPTR\t%#llx\n", relative_base);
+		printf("\n");
+	}
+
 	output_label("kallsyms_num_syms");
 	printf("\tPTR\t%d\n", table_cnt);
 	printf("\n");
@@ -685,6 +727,18 @@ static void make_percpus_absolute(void)
 			table[i].sym[0] = 'A';
 }
 
+/* find the minimum non-absolute symbol address */
+static void record_relative_base(void)
+{
+	unsigned int i;
+
+	relative_base = ULLONG_MAX;
+	for (i = 0; i < table_cnt; i++)
+		if (!symbol_absolute(&table[i]) &&
+		    table[i].addr < relative_base)
+			relative_base = table[i].addr;
+}
+
 int main(int argc, char **argv)
 {
 	if (argc >= 2) {
@@ -703,7 +757,9 @@ int main(int argc, char **argv)
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
@@ -712,6 +768,8 @@ int main(int argc, char **argv)
 	read_map(stdin);
 	if (absolute_percpu)
 		make_percpus_absolute();
+	if (base_relative)
+		record_relative_base();
 	sort_symbols();
 	optimize_token_table();
 	write_src();
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index ba6c34ea5429..b58bf908b153 100755
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
index a71be6b7cdec..e059ab240364 100755
--- a/scripts/namespace.pl
+++ b/scripts/namespace.pl
@@ -117,6 +117,8 @@ my %nameexception = (
     'kallsyms_names'   => 1,
     'kallsyms_num_syms'        => 1,
     'kallsyms_addresses'=> 1,
+    'kallsyms_offsets' => 1,
+    'kallsyms_relative_base'=> 1,
     '__this_module'    => 1,
     '_etext'           => 1,
     '_edata'           => 1,
-- 
2.5.0
