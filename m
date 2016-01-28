From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 1/5] all: s390: move wrapper infrastructure to generic
 headers
Date: Thu, 28 Jan 2016 13:16:18 +0100
Message-ID: <20160128121618.GB5418@osiris>
References: <1453741047-5498-1-git-send-email-ynorov@caviumnetworks.com>
 <1453741047-5498-2-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453741047-5498-2-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: arnd@arndb.de, catalin.marinas@arm.com, schwidefsky@de.ibm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, Prasun.Kapoor@caviumnetworks.com, pinskia@gmail.com, agraf@suse.de, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, Nathan_Lynch@mentor.com, klimov.linux@gmail.com
List-ID: <linux-s390.vger.kernel.org>

Hello Yury,

On Mon, Jan 25, 2016 at 07:57:23PM +0300, Yury Norov wrote:
> __SC_COMPAT_CAST for s390 is too specific due to 31-bit pointer length, so it's
> moved to arch/s390/include/asm/compat.h. Generic declaration assumes that long,
> unsigned long and pointer types are all 32-bit length.
> 
> linux/syscalls_structs.h header is introduced, because from now (see next patch)
> structure types listed there are needed for both normal and compat mode.
> 
> cond_syscall_wrapped now defined two symbols: sys_foo() and compat_sys_foo(), if
> compat wrappers are enabled.
> 
> Here __SC_WRAP() macro is introduced as well. s390 doesn't need it as it uses
> asm-generated syscall table. But architectures that generate that tables with
> C code (ARM64/ILP32) should redefine it as '#define __SC_WRAP(name) compat_##name'.
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>

...

> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index a76c917..1a761ea 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -718,4 +718,67 @@ asmlinkage long compat_sys_fanotify_mark(int, unsigned int, __u32, __u32,
>  #define is_compat_task() (0)
>  
>  #endif /* CONFIG_COMPAT */
> +
> +#ifdef CONFIG_COMPAT_WRAPPER
> +
> +#ifndef __TYPE_IS_PTR
> +#define __TYPE_IS_PTR(t) (!__builtin_types_compatible_p(typeof(0?(t)0:0ULL), u64))
> +#endif
> +
> +#ifndef __SC_COMPAT_TYPE
> +#define __SC_COMPAT_TYPE(t, a) \
> +	__typeof(__builtin_choose_expr(sizeof(t) > 4, 0L, (t)0)) a
> +#endif
> +
> +#ifndef __SC_COMPAT_CAST
> +#define __SC_COMPAT_CAST(t, a) ({					\
> +	BUILD_BUG_ON((sizeof(t) > 4) && !__TYPE_IS_L(t) &&		\
> +		     !__TYPE_IS_UL(t) && !__TYPE_IS_PTR(t));		\
> +	((t) ((t)(-1) < 0 ? (s64)(s32)(a) : (u64)(u32)(a)));		\
> +})
> +#endif
> +
> +#ifndef SYSCALL_DEFINE_WRAPx
> +/*
> + * The SYSCALL_DEFINE_WRAP macro generates system call wrappers to be used by
> + * compat tasks. These wrappers will only be used for system calls where only
> + * the system call arguments need sign or zero extension or zeroing of upper
> + * bits of pointers.
> + * Note: since the wrapper function will afterwards call a system call which
> + * again performs zero and sign extension for all system call arguments with
> + * a size of less than eight bytes, these compat wrappers only touch those
> + * system call arguments with a size of eight bytes ((unsigned) long and
> + * pointers). Zero and sign extension for e.g. int parameters will be done by
> + * the regular system call wrappers.
> + */
> +#define SYSCALL_DEFINE_WRAPx(x, name, ...)						\
> +asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));				\
> +asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))			\
> +		__attribute__((alias(__stringify(compat_SyS##name))));			\
> +asmlinkage long compat_SyS##name(__MAP(x,__SC_COMPAT_TYPE,__VA_ARGS__));		\
> +asmlinkage long compat_SyS##name(__MAP(x,__SC_COMPAT_TYPE,__VA_ARGS__))			\
> +{											\
> +	return sys##name(__MAP(x,__SC_COMPAT_CAST,__VA_ARGS__));			\
> +}											\
> +SYSCALL_DEFINEx(x, name, __VA_ARGS__)
> +#endif
> +
> +#define SYSCALL_DEFINE_WRAP1(name, ...) SYSCALL_DEFINE_WRAPx(1, _##name, __VA_ARGS__)
> +#define SYSCALL_DEFINE_WRAP2(name, ...) SYSCALL_DEFINE_WRAPx(2, _##name, __VA_ARGS__)
> +#define SYSCALL_DEFINE_WRAP3(name, ...) SYSCALL_DEFINE_WRAPx(3, _##name, __VA_ARGS__)
> +#define SYSCALL_DEFINE_WRAP4(name, ...) SYSCALL_DEFINE_WRAPx(4, _##name, __VA_ARGS__)
> +#define SYSCALL_DEFINE_WRAP5(name, ...) SYSCALL_DEFINE_WRAPx(5, _##name, __VA_ARGS__)
> +#define SYSCALL_DEFINE_WRAP6(name, ...) SYSCALL_DEFINE_WRAPx(6, _##name, __VA_ARGS__)
> +
> +#else
> +
> +#define SYSCALL_DEFINE_WRAP1	SYSCALL_DEFINE1
> +#define SYSCALL_DEFINE_WRAP2    SYSCALL_DEFINE2
> +#define SYSCALL_DEFINE_WRAP3    SYSCALL_DEFINE3
> +#define SYSCALL_DEFINE_WRAP4    SYSCALL_DEFINE4
> +#define SYSCALL_DEFINE_WRAP5    SYSCALL_DEFINE5
> +#define SYSCALL_DEFINE_WRAP6    SYSCALL_DEFINE6
> +
> +#endif /* CONFIG_COMPAT_WRAPPER */

How about if you rename SYSCALL_DEFINE_WRAP to SYSCALL_COMPAT_DEFINE which
has the semantics that no dedicated compat system call exists (aka system
call is compat safe).

Then convert all existing SYSCALL_DEFINE'd system calls for which no compat
variant exists to SYSCALL_COMPAT_DEFINE.

This would allow to specify "compat_sys_<syscallname>" in the compat system
call table for _all_ system calls.

No need to look up if a compat variant (or wrapper) exists or
sys_<syscallname> should be used instead. Also no possibility for security
bugs that could creep in because SYSCALL_DEFINE has been used instead of
SYSCALL_DEFINE_WRAP.

Ideally the implementation would only generate an alias if no sign/zero
extension is necessary.

Trivially this would be true for system calls without arguments like e.g.
sys_fork() which would get a compat_sys_fork alias without any further
code.

I'm not sure how difficult it is to implement the same logic for system
calls that have parameters. That is: either generate a
compat_sys_<syscallname> wrapper function, or if the SYSCALL_COMPAT_DEFINE
macro figures out that no zero sign extension is required, only an alias
without any additional code.

I think in the long term something like this is much easier to maintain.

Does that make sense?
