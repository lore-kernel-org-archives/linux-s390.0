From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 8/8] jump_table: move entries into ro_after_init region
Date: Mon, 2 Jul 2018 11:29:55 -0700
Message-ID: <CAGXu5jK0_vjuaig1Wz=TGyWh81LXg0zbGkoJDR-_YYig6yTqng@mail.gmail.com>
References: <20180702181145.4799-1-ard.biesheuvel@linaro.org> <20180702181145.4799-9-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702181145.4799-9-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Jessica Yu <jeyu@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jul 2, 2018 at 11:11 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> The __jump_table sections emitted into the core kernel and into
> each module consist of statically initialized references into
> other parts of the code, and with the exception of entries that
> point into init code, which are defused at post-init time, these
> data structures are never modified.
>
> So let's move them into the ro_after_init section, to prevent them
> from being corrupted inadvertently by buggy code, or deliberately
> by an attacker.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Yay more things read-only! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
>  arch/arm/kernel/vmlinux-xip.lds.S |  1 +
>  arch/s390/kernel/vmlinux.lds.S    |  1 +
>  include/asm-generic/vmlinux.lds.h | 11 +++++++----
>  kernel/module.c                   |  9 +++++++++
>  4 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
> index 3593d5c1acd2..763c41068ecc 100644
> --- a/arch/arm/kernel/vmlinux-xip.lds.S
> +++ b/arch/arm/kernel/vmlinux-xip.lds.S
> @@ -118,6 +118,7 @@ SECTIONS
>         RW_DATA_SECTION(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
>         .data.ro_after_init : AT(ADDR(.data.ro_after_init) - LOAD_OFFSET) {
>                 *(.data..ro_after_init)
> +               JUMP_TABLE_DATA
>         }
>         _edata = .;
>
> diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
> index f0414f52817b..a7cf61e46f88 100644
> --- a/arch/s390/kernel/vmlinux.lds.S
> +++ b/arch/s390/kernel/vmlinux.lds.S
> @@ -67,6 +67,7 @@ SECTIONS
>         __start_ro_after_init = .;
>         .data..ro_after_init : {
>                  *(.data..ro_after_init)
> +               JUMP_TABLE_DATA
>         }
>         EXCEPTION_TABLE(16)
>         . = ALIGN(PAGE_SIZE);
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index e373e2e10f6a..ed6befa4c47b 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -256,10 +256,6 @@
>         STRUCT_ALIGN();                                                 \
>         *(__tracepoints)                                                \
>         /* implement dynamic printk debug */                            \
> -       . = ALIGN(8);                                                   \
> -       __start___jump_table = .;                                       \
> -       KEEP(*(__jump_table))                                           \
> -       __stop___jump_table = .;                                        \
>         . = ALIGN(8);                                                   \
>         __start___verbose = .;                                          \
>         KEEP(*(__verbose))                                              \
> @@ -303,6 +299,12 @@
>         . = __start_init_task + THREAD_SIZE;                            \
>         __end_init_task = .;
>
> +#define JUMP_TABLE_DATA                                                        \
> +       . = ALIGN(8);                                                   \
> +       __start___jump_table = .;                                       \
> +       KEEP(*(__jump_table))                                           \
> +       __stop___jump_table = .;
> +
>  /*
>   * Allow architectures to handle ro_after_init data on their
>   * own by defining an empty RO_AFTER_INIT_DATA.
> @@ -311,6 +313,7 @@
>  #define RO_AFTER_INIT_DATA                                             \
>         __start_ro_after_init = .;                                      \
>         *(.data..ro_after_init)                                         \
> +       JUMP_TABLE_DATA                                                 \
>         __end_ro_after_init = .;
>  #endif
>
> diff --git a/kernel/module.c b/kernel/module.c
> index 7cb82e0fcac0..0d4e320e41cd 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3349,6 +3349,15 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
>          * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
>          */
>         ndx = find_sec(info, ".data..ro_after_init");
> +       if (ndx)
> +               info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
> +       /*
> +        * Mark the __jump_table section as ro_after_init as well: these data
> +        * structures are never modified, with the exception of entries that
> +        * refer to code in the __init section, which are annotated as such
> +        * at module load time.
> +        */
> +       ndx = find_sec(info, "__jump_table");
>         if (ndx)
>                 info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
>
> --
> 2.17.1
>



-- 
Kees Cook
Pixel Security
