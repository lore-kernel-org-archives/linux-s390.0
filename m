From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v5 2/3] kallsyms: don't overload absolute symbol type for percpu symbols
Date: Mon,  8 Feb 2016 18:57:47 +0100
Message-ID: <1454954268-3225-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1454954268-3225-1-git-send-email-ard.biesheuvel@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454954268-3225-1-git-send-email-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, keescook@chromium.org, akpm@linux-foundation.org, mingo@kernel.org, hpa@zytor.com, heiko.carstens@de.ibm.com, benh@kernel.crashing.org, mpe@ellerman.id.au, mmarek@suse.cz, rusty@rustcorp.com.au, arnd@arndb.de, linux-arch@vger.kernel.org, linux@roeck-us.net
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
List-ID: <linux-s390.vger.kernel.org>

Commit c6bda7c988a5 ("kallsyms: fix percpu vars on x86-64 with relocation")
overloaded the 'A' (absolute) symbol type to signify that a symbol is not
subject to dynamic relocation. However, the original A type does not imply
that at all, and depending on the version of the toolchain, many A type
symbols are emitted that are in fact relative to the kernel text, i.e., if
the kernel is relocated at runtime, these symbols should be updated as well.

For instance, on sparc32, the following symbols are emitted as absolute
(kindly provided by Guenter Roeck):

  f035a420 A _etext
  f03d9000 A _sdata
  f03de8c4 A jiffies
  f03f8860 A _edata
  f03fc000 A __init_begin
  f041bdc8 A __init_text_end
  f0423000 A __bss_start
  f0423000 A __init_end
  f044457d A __bss_stop
  f044457d A _end

On x86_64, similar behavior can be observed:

  ffffffff81a00000 A __end_rodata_hpage_align
  ffffffff81b19000 A __vvar_page
  ffffffff81d3d000 A _end

Even if only a couple of them pass the symbol range check that results in
them to be taken into account for the final kallsyms symbol table, it is
obvious that 'A' does not mean the symbol does not need to be updated at
relocation time, and overloading its meaning to signify that is perhaps not
a good idea.

So instead, add a new percpu_absolute member to struct sym_entry, and when
--absolute-percpu is in effect, use it to record symbols whose addresses
should be emitted as final values rather than values that still require
relocation at runtime. That way, we can drop the check against the 'A' type.

Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>
Acked-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 scripts/kallsyms.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 8fa81e84e295..d39a1eeb080e 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -34,6 +34,7 @@ struct sym_entry {
 	unsigned int len;
 	unsigned int start_pos;
 	unsigned char *sym;
+	unsigned int percpu_absolute;
 };
 
 struct addr_range {
@@ -171,6 +172,8 @@ static int read_symbol(FILE *in, struct sym_entry *s)
 	strcpy((char *)s->sym + 1, str);
 	s->sym[0] = stype;
 
+	s->percpu_absolute = 0;
+
 	/* Record if we've found __per_cpu_start/end. */
 	check_symbol_range(sym, s->addr, &percpu_range, 1);
 
@@ -325,7 +328,7 @@ static int expand_symbol(unsigned char *data, int len, char *result)
 
 static int symbol_absolute(struct sym_entry *s)
 {
-	return toupper(s->sym[0]) == 'A';
+	return s->percpu_absolute;
 }
 
 static void write_src(void)
@@ -681,8 +684,15 @@ static void make_percpus_absolute(void)
 	unsigned int i;
 
 	for (i = 0; i < table_cnt; i++)
-		if (symbol_in_range(&table[i], &percpu_range, 1))
+		if (symbol_in_range(&table[i], &percpu_range, 1)) {
+			/*
+			 * Keep the 'A' override for percpu symbols to
+			 * ensure consistent behavior compared to older
+			 * versions of this tool.
+			 */
 			table[i].sym[0] = 'A';
+			table[i].percpu_absolute = 1;
+		}
 }
 
 int main(int argc, char **argv)
-- 
2.5.0
