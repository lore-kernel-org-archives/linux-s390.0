From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 7/8] jump_label: annotate entries that operate on
 __init code earlier
Date: Mon, 2 Jul 2018 11:28:42 -0700
Message-ID: <CAGXu5jL4xfKXr4y4sqGQZWYHHcmTb+W-0+zwCriLv2yvZApyeA@mail.gmail.com>
References: <20180702181145.4799-1-ard.biesheuvel@linaro.org> <20180702181145.4799-8-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702181145.4799-8-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Jessica Yu <jeyu@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jul 2, 2018 at 11:11 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Jump table entries are mostly read-only, with the exception of the
> init and module loader code that defuses entries that point into init
> code when the code being referred to is freed.
>
> For robustness, it would be better to move these entries into the
> ro_after_init section, but clearing the 'code' member of each jump
> table entry referring to init code at module load time races with the
> module_enable_ro() call that remaps the ro_after_init section read
> only, so we'd like to do it earlier.
>
> So given that whether such an entry refers to init code can be decided
> much earlier, we can pull this check forward. Since we may still need
> the code entry at this point, let's switch to setting a low bit in the
> 'key' member just like we do to annotate the default state of a jump
> table entry.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  include/linux/jump_label.h | 11 ++---
>  init/main.c                |  1 -
>  kernel/jump_label.c        | 48 ++++++--------------
>  3 files changed, 18 insertions(+), 42 deletions(-)

Net reduction in code, too! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>
> diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
> index 871826fd0c3b..feee8abc96be 100644
> --- a/include/linux/jump_label.h
> +++ b/include/linux/jump_label.h
> @@ -141,7 +141,7 @@ static inline unsigned long jump_entry_target(const struct jump_entry *entry)
>
>  static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
>  {
> -       long offset = entry->key & ~1L;
> +       long offset = entry->key & ~3L;
>
>         return (struct static_key *)((unsigned long)&entry->key + offset);
>  }
> @@ -160,7 +160,7 @@ static inline unsigned long jump_entry_target(const struct jump_entry *entry)
>
>  static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
>  {
> -       return (struct static_key *)((unsigned long)entry->key & ~1UL);
> +       return (struct static_key *)((unsigned long)entry->key & ~3UL);
>  }
>
>  #endif
> @@ -172,12 +172,12 @@ static inline bool jump_entry_is_branch(const struct jump_entry *entry)
>
>  static inline bool jump_entry_is_init(const struct jump_entry *entry)
>  {
> -       return entry->code == 0;
> +       return (unsigned long)entry->key & 2UL;
>  }
>
>  static inline void jump_entry_set_init(struct jump_entry *entry)
>  {
> -       entry->code = 0;
> +       entry->key |= 2;
>  }
>
>  #endif
> @@ -213,7 +213,6 @@ extern struct jump_entry __start___jump_table[];
>  extern struct jump_entry __stop___jump_table[];
>
>  extern void jump_label_init(void);
> -extern void jump_label_invalidate_initmem(void);
>  extern void jump_label_lock(void);
>  extern void jump_label_unlock(void);
>  extern void arch_jump_label_transform(struct jump_entry *entry,
> @@ -261,8 +260,6 @@ static __always_inline void jump_label_init(void)
>         static_key_initialized = true;
>  }
>
> -static inline void jump_label_invalidate_initmem(void) {}
> -
>  static __always_inline bool static_key_false(struct static_key *key)
>  {
>         if (unlikely(static_key_count(key) > 0))
> diff --git a/init/main.c b/init/main.c
> index e59a01f163d6..d1a6b8a896e5 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1062,7 +1062,6 @@ static int __ref kernel_init(void *unused)
>         /* need to finish all async __init code before freeing the memory */
>         async_synchronize_full();
>         ftrace_free_init_mem();
> -       jump_label_invalidate_initmem();
>         free_initmem();
>         mark_readonly();
>         system_state = SYSTEM_RUNNING;
> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index d424e1d22d63..7cdd49aeaf6a 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -373,14 +373,15 @@ static enum jump_label_type jump_label_type(struct jump_entry *entry)
>
>  static void __jump_label_update(struct static_key *key,
>                                 struct jump_entry *entry,
> -                               struct jump_entry *stop)
> +                               struct jump_entry *stop,
> +                               bool init)
>  {
>         for (; (entry < stop) && (jump_entry_key(entry) == key); entry++) {
>                 /*
>                  * An entry->code of 0 indicates an entry which has been
>                  * disabled because it was in an init text area.
>                  */
> -               if (!jump_entry_is_init(entry)) {
> +               if (init || !jump_entry_is_init(entry)) {
>                         if (kernel_text_address(jump_entry_code(entry)))
>                                 arch_jump_label_transform(entry, jump_label_type(entry));
>                         else
> @@ -420,6 +421,9 @@ void __init jump_label_init(void)
>                 if (jump_label_type(iter) == JUMP_LABEL_NOP)
>                         arch_jump_label_transform_static(iter, JUMP_LABEL_NOP);
>
> +               if (init_section_contains((void *)jump_entry_code(iter), 1))
> +                       jump_entry_set_init(iter);
> +
>                 iterk = jump_entry_key(iter);
>                 if (iterk == key)
>                         continue;
> @@ -432,19 +436,6 @@ void __init jump_label_init(void)
>         cpus_read_unlock();
>  }
>
> -/* Disable any jump label entries in __init/__exit code */
> -void __init jump_label_invalidate_initmem(void)
> -{
> -       struct jump_entry *iter_start = __start___jump_table;
> -       struct jump_entry *iter_stop = __stop___jump_table;
> -       struct jump_entry *iter;
> -
> -       for (iter = iter_start; iter < iter_stop; iter++) {
> -               if (init_section_contains((void *)jump_entry_code(iter), 1))
> -                       jump_entry_set_init(iter);
> -       }
> -}
> -
>  #ifdef CONFIG_MODULES
>
>  static enum jump_label_type jump_label_init_type(struct jump_entry *entry)
> @@ -524,7 +515,8 @@ static void __jump_label_mod_update(struct static_key *key)
>                         stop = __stop___jump_table;
>                 else
>                         stop = m->jump_entries + m->num_jump_entries;
> -               __jump_label_update(key, mod->entries, stop);
> +               __jump_label_update(key, mod->entries, stop,
> +                                   m->state == MODULE_STATE_COMING);
>         }
>  }
>
> @@ -570,6 +562,9 @@ static int jump_label_add_module(struct module *mod)
>         for (iter = iter_start; iter < iter_stop; iter++) {
>                 struct static_key *iterk;
>
> +               if (within_module_init(jump_entry_code(iter), mod))
> +                       jump_entry_set_init(iter);
> +
>                 iterk = jump_entry_key(iter);
>                 if (iterk == key)
>                         continue;
> @@ -605,7 +600,7 @@ static int jump_label_add_module(struct module *mod)
>
>                 /* Only update if we've changed from our initial state */
>                 if (jump_label_type(iter) != jump_label_init_type(iter))
> -                       __jump_label_update(key, iter, iter_stop);
> +                       __jump_label_update(key, iter, iter_stop, true);
>         }
>
>         return 0;
> @@ -661,19 +656,6 @@ static void jump_label_del_module(struct module *mod)
>         }
>  }
>
> -/* Disable any jump label entries in module init code */
> -static void jump_label_invalidate_module_init(struct module *mod)
> -{
> -       struct jump_entry *iter_start = mod->jump_entries;
> -       struct jump_entry *iter_stop = iter_start + mod->num_jump_entries;
> -       struct jump_entry *iter;
> -
> -       for (iter = iter_start; iter < iter_stop; iter++) {
> -               if (within_module_init(jump_entry_code(iter), mod))
> -                       jump_entry_set_init(iter);
> -       }
> -}
> -
>  static int
>  jump_label_module_notify(struct notifier_block *self, unsigned long val,
>                          void *data)
> @@ -695,9 +677,6 @@ jump_label_module_notify(struct notifier_block *self, unsigned long val,
>         case MODULE_STATE_GOING:
>                 jump_label_del_module(mod);
>                 break;
> -       case MODULE_STATE_LIVE:
> -               jump_label_invalidate_module_init(mod);
> -               break;
>         }
>
>         jump_label_unlock();
> @@ -767,7 +746,8 @@ static void jump_label_update(struct static_key *key)
>         entry = static_key_entries(key);
>         /* if there are no users, entry can be NULL */
>         if (entry)
> -               __jump_label_update(key, entry, stop);
> +               __jump_label_update(key, entry, stop,
> +                                   system_state < SYSTEM_RUNNING);
>  }
>
>  #ifdef CONFIG_STATIC_KEYS_SELFTEST
> --
> 2.17.1
>



-- 
Kees Cook
Pixel Security
