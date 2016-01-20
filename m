Return-Path: <keescook@google.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1453280738-18721-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1453280738-18721-1-git-send-email-ard.biesheuvel@linaro.org>
 <1453280738-18721-2-git-send-email-ard.biesheuvel@linaro.org>
Date: Wed, 20 Jan 2016 11:13:22 -0800
Message-ID: <CAGXu5jKq4PFQFYqPCMbc5HgPDnNSJrzMoBAGZ=vpxeCh=rcPQg@mail.gmail.com>
Subject: Re: [PATCH 1/4] kallsyms: add support for relative offsets in
 kallsyms address table
From: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "x86@kernel.org" <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Michal Marek <mmarek@suse.cz>, Rusty Russell <rusty@rustcorp.com.au>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jan 20, 2016 at 1:05 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Similar to how relative extables are implemented, it is possible to emit
> the kallsyms table in such a way that it contains offsets relative to some
> anchor point in the kernel image rather than absolute addresses. The benefit
> is that such table entries are no longer subject to dynamic relocation when
> the build time and runtime offsets of the kernel image are different. Also,
> on 64-bit architectures, it essentially cuts the size of the address table
> in half since offsets can typically be expressed in 32 bits.
>
> Since it is useful for some architectures (like x86) to retain the ability
> to emit absolute values as well, this patch adds support for both, by
> emitting absolute addresses as positive 32-bit values, and addresses
> relative to _text as negative values, which are subtracted from the runtime
> address of _text to produce the actual address. Positive values are used as
> they are found in the table.
>
> Support for the above is enabled by setting CONFIG_KALLSYMS_TEXT_RELATIVE.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

A nice space-saver! :)

-Kees

> ---
>  init/Kconfig            | 14 ++++++++
>  kernel/kallsyms.c       | 35 +++++++++++++-----
>  scripts/kallsyms.c      | 38 +++++++++++++++++---
>  scripts/link-vmlinux.sh |  4 +++
>  scripts/namespace.pl    |  1 +
>  5 files changed, 79 insertions(+), 13 deletions(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 5b86082fa238..73e00b040572 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1427,6 +1427,20 @@ config KALLSYMS_ALL
>
>            Say N unless you really need all symbols.
>
> +config KALLSYMS_TEXT_RELATIVE
> +       bool
> +       help
> +         Instead of emitting them as absolute values in the native word size,
> +         emit the symbol references in the kallsyms table as 32-bit entries,
> +         each containing either an absolute value in the range [0, S32_MAX] or
> +         a text relative value in the range [_text, _text + S32_MAX], encoded
> +         as negative values.
> +
> +         On 64-bit builds, this reduces the size of the address table by 50%,
> +         but more importantly, it results in entries whose values are build
> +         time constants, and no relocation pass is required at runtime to fix
> +         up the entries based on the runtime load address of the kernel.
> +
>  config PRINTK
>         default y
>         bool "Enable support for printk" if EXPERT
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 5c5987f10819..e612f7f9e71b 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -38,6 +38,7 @@
>   * during the second link stage.
>   */
>  extern const unsigned long kallsyms_addresses[] __weak;
> +extern const int kallsyms_offsets[] __weak;
>  extern const u8 kallsyms_names[] __weak;
>
>  /*
> @@ -176,6 +177,19 @@ static unsigned int get_symbol_offset(unsigned long pos)
>         return name - kallsyms_names;
>  }
>
> +static unsigned long kallsyms_sym_address(int idx)
> +{
> +       if (!IS_ENABLED(CONFIG_KALLSYMS_TEXT_RELATIVE))
> +               return kallsyms_addresses[idx];
> +
> +       /* positive offsets are absolute values */
> +       if (kallsyms_offsets[idx] >= 0)
> +               return kallsyms_offsets[idx];
> +
> +       /* negative offsets are relative to _text - 1 */
> +       return (unsigned long)_text - 1 - kallsyms_offsets[idx];
> +}
> +
>  /* Lookup the address for this symbol. Returns 0 if not found. */
>  unsigned long kallsyms_lookup_name(const char *name)
>  {
> @@ -187,7 +201,7 @@ unsigned long kallsyms_lookup_name(const char *name)
>                 off = kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
>
>                 if (strcmp(namebuf, name) == 0)
> -                       return kallsyms_addresses[i];
> +                       return kallsyms_sym_address(i);
>         }
>         return module_kallsyms_lookup_name(name);
>  }
> @@ -204,7 +218,7 @@ int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
>
>         for (i = 0, off = 0; i < kallsyms_num_syms; i++) {
>                 off = kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
> -               ret = fn(data, namebuf, NULL, kallsyms_addresses[i]);
> +               ret = fn(data, namebuf, NULL, kallsyms_sym_address(i));
>                 if (ret != 0)
>                         return ret;
>         }
> @@ -220,7 +234,10 @@ static unsigned long get_symbol_pos(unsigned long addr,
>         unsigned long i, low, high, mid;
>
>         /* This kernel should never had been booted. */
> -       BUG_ON(!kallsyms_addresses);
> +       if (!IS_ENABLED(CONFIG_KALLSYMS_TEXT_RELATIVE))
> +               BUG_ON(!kallsyms_addresses);
> +       else
> +               BUG_ON(!kallsyms_offsets);
>
>         /* Do a binary search on the sorted kallsyms_addresses array. */
>         low = 0;
> @@ -228,7 +245,7 @@ static unsigned long get_symbol_pos(unsigned long addr,
>
>         while (high - low > 1) {
>                 mid = low + (high - low) / 2;
> -               if (kallsyms_addresses[mid] <= addr)
> +               if (kallsyms_sym_address(mid) <= addr)
>                         low = mid;
>                 else
>                         high = mid;
> @@ -238,15 +255,15 @@ static unsigned long get_symbol_pos(unsigned long addr,
>          * Search for the first aliased symbol. Aliased
>          * symbols are symbols with the same address.
>          */
> -       while (low && kallsyms_addresses[low-1] == kallsyms_addresses[low])
> +       while (low && kallsyms_sym_address(low-1) == kallsyms_sym_address(low))
>                 --low;
>
> -       symbol_start = kallsyms_addresses[low];
> +       symbol_start = kallsyms_sym_address(low);
>
>         /* Search for next non-aliased symbol. */
>         for (i = low + 1; i < kallsyms_num_syms; i++) {
> -               if (kallsyms_addresses[i] > symbol_start) {
> -                       symbol_end = kallsyms_addresses[i];
> +               if (kallsyms_sym_address(i) > symbol_start) {
> +                       symbol_end = kallsyms_sym_address(i);
>                         break;
>                 }
>         }
> @@ -470,7 +487,7 @@ static unsigned long get_ksymbol_core(struct kallsym_iter *iter)
>         unsigned off = iter->nameoff;
>
>         iter->module_name[0] = '\0';
> -       iter->value = kallsyms_addresses[iter->pos];
> +       iter->value = kallsyms_sym_address(iter->pos);
>
>         iter->type = kallsyms_get_symbol_type(off);
>
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 8fa81e84e295..07656c102e60 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -22,6 +22,7 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <ctype.h>
> +#include <limits.h>
>
>  #ifndef ARRAY_SIZE
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
> @@ -61,6 +62,7 @@ static int all_symbols = 0;
>  static int absolute_percpu = 0;
>  static char symbol_prefix_char = '\0';
>  static unsigned long long kernel_start_addr = 0;
> +static int text_relative = 0;
>
>  int token_profit[0x10000];
>
> @@ -74,7 +76,7 @@ static void usage(void)
>         fprintf(stderr, "Usage: kallsyms [--all-symbols] "
>                         "[--symbol-prefix=<prefix char>] "
>                         "[--page-offset=<CONFIG_PAGE_OFFSET>] "
> -                       "< in.map > out.S\n");
> +                       "[--text-relative] < in.map > out.S\n");
>         exit(1);
>  }
>
> @@ -202,6 +204,7 @@ static int symbol_valid(struct sym_entry *s)
>          */
>         static char *special_symbols[] = {
>                 "kallsyms_addresses",
> +               "kallsyms_offsets",
>                 "kallsyms_num_syms",
>                 "kallsyms_names",
>                 "kallsyms_markers",
> @@ -353,9 +356,34 @@ static void write_src(void)
>          * .o files.  This prevents .tmp_kallsyms.o or any other
>          * object from referencing them.
>          */
> -       output_label("kallsyms_addresses");
> +       if (!text_relative)
> +               output_label("kallsyms_addresses");
> +       else
> +               output_label("kallsyms_offsets");
> +
>         for (i = 0; i < table_cnt; i++) {
> -               if (!symbol_absolute(&table[i])) {
> +               if (text_relative) {
> +                       long long offset;
> +
> +                       if (symbol_absolute(&table[i])) {
> +                               offset = table[i].addr;
> +                               if (offset < 0 || offset > INT_MAX) {
> +                                       fprintf(stderr, "kallsyms failure: "
> +                                               "absolute symbol value %#llx out of range in relative mode\n",
> +                                               table[i].addr);
> +                                       exit(EXIT_FAILURE);
> +                               }
> +                       } else {
> +                               offset = _text - table[i].addr - 1;
> +                               if (offset < INT_MIN || offset >= 0) {
> +                                       fprintf(stderr, "kallsyms failure: "
> +                                               "relative symbol value %#llx out of range in relative mode\n",
> +                                               table[i].addr);
> +                                       exit(EXIT_FAILURE);
> +                               }
> +                       }
> +                       printf("\t.long\t%#x\n", (int)offset);
> +               } else if (!symbol_absolute(&table[i])) {
>                         if (_text <= table[i].addr)
>                                 printf("\tPTR\t_text + %#llx\n",
>                                         table[i].addr - _text);
> @@ -703,7 +731,9 @@ int main(int argc, char **argv)
>                         } else if (strncmp(argv[i], "--page-offset=", 14) == 0) {
>                                 const char *p = &argv[i][14];
>                                 kernel_start_addr = strtoull(p, NULL, 16);
> -                       } else
> +                       } else if (strcmp(argv[i], "--text-relative") == 0)
> +                               text_relative = 1;
> +                       else
>                                 usage();
>                 }
>         } else if (argc != 1)
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index ba6c34ea5429..e0f957f6a54c 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -90,6 +90,10 @@ kallsyms()
>                 kallsymopt="${kallsymopt} --absolute-percpu"
>         fi
>
> +       if [ -n "${CONFIG_KALLSYMS_TEXT_RELATIVE}" ]; then
> +               kallsymopt="${kallsymopt} --text-relative"
> +       fi
> +
>         local aflags="${KBUILD_AFLAGS} ${KBUILD_AFLAGS_KERNEL}               \
>                       ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS}"
>
> diff --git a/scripts/namespace.pl b/scripts/namespace.pl
> index a71be6b7cdec..e059ab240364 100755
> --- a/scripts/namespace.pl
> +++ b/scripts/namespace.pl
> @@ -117,6 +117,7 @@ my %nameexception = (
>      'kallsyms_names'   => 1,
>      'kallsyms_num_syms'        => 1,
>      'kallsyms_addresses'=> 1,
> +    'kallsyms_offsets' => 1,
>      '__this_module'    => 1,
>      '_etext'           => 1,
>      '_edata'           => 1,
> --
> 2.5.0
>



-- 
Kees Cook
Chrome OS & Brillo Security
