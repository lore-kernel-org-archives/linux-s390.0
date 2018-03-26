From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [RFC] new SYSCALL_DEFINE/COMPAT_SYSCALL_DEFINE wrappers
Date: Mon, 26 Mar 2018 01:40:17 +0100
Message-ID: <20180326004017.GA2211@ZenIV.linux.org.uk>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
 <20180318161056.5377-5-linux@dominikbrodowski.net>
 <20180318174014.GR30522@ZenIV.linux.org.uk>
 <CA+55aFwuZCpAZRpsTGiUmG065ZHHpj+03_NeWiy-OGkMGw7e3g@mail.gmail.com>
 <20180318181848.GU30522@ZenIV.linux.org.uk>
 <20180319042300.GW30522@ZenIV.linux.org.uk>
 <20180319092920.tbh2xwkruegshzqe@gmail.com>
 <20180319232342.GX30522@ZenIV.linux.org.uk>
 <20180322001532.GA18399@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180322001532.GA18399@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, linux-mips <linux-mips@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Mar 22, 2018 at 12:15:32AM +0000, Al Viro wrote:

> FWIW, I have something that is almost reasonable on preprocessor side;
> however, that has uncovered the following fun:
[snip]

According to gcc folks, the right way to do it is type-punning via
union.  Anyway, below is something that kinda-sorta works as a
replacement of macrology in compat.h and syscalls.h.

Kinda-sorta part:
	* asmlinkage_protect is taken out for now, so m68k has problems.
	* syscalls that run out of 6 slots barf violently.  For mips it's
wrong (there we have 8 slots); for stuff like arm and ppc it's right, but
it means that things like e.g. compat sync_file_range() should not even
be compiled on those.  __ARCH_WANT_SYS_SYNC_FILE_RANGE, presumably...
In any case, we *can't* do pt_regs-based wrappers for those syscalls on
such architectures, so ifdefs around those puppies are probably the right
thing to do.
	* s390 macrology in compat_wrapper.c not even touched; it needs
a trivial update to keep working (__MAP callbacks take an extra argument,
unused for those users).
	* sys_... and compat_sys_... aliases are unchanged; if we kill
direct callers, we can trivially rename SyS##name and compat_SyS##name
to sys##name and compat_sys##name and get rid of aliases.

It allows an architecture to decide whether it wants 6-argument wrappers
or pt_regs ones - that's encapsulated into several macros.  Padding is
done properly; things like truncate64() et.al. can be done as single
COMPAT_SYSCALL_DEFINE.  Moreover, AFAICS the same wrappers work just fine
for arm64 - no worse than asm glue currently used there.

I've tried to put the sane amount of comments in there, hopefully
explaining what the hell is that nest of horrors doing.  It's ugly,
but less eye-bleeding that I thought it would be.

I'm not sure if it's a good idea; something of that sort would probably be
useful for any kind of pt_regs-passing wrappers, though.  Review would be
welcome...

#include <linux/compiler.h>
#include <linux/linkage.h>
#include <linux/build_bug.h>
#include <trace/syscall.h>

/*
 * __MAP - apply a macro to syscall arguments
 * __MAP(n, m, t1, a1, t2, a2, ..., tn, an) will expand to
 *    m(, t1, a1), m(_, t2, a2), ..., m(_..._, tn, an)
 * The first argument must be equal to the amount of type/name
 * pairs given.  Note that this list of pairs (i.e. the arguments
 * of __MAP starting at the third one) is in the same format as
 * for SYSCALL_DEFINE<n>/COMPAT_SYSCALL_DEFINE<n>
 */
#define __MAP0(m,p,...)
#define __MAP1(m,p,t,a) m(p,t,a)
#define __MAP2(m,p,t,a,...) m(p,t,a), __MAP1(m,p##_,__VA_ARGS__)
#define __MAP3(m,p,t,a,...) m(p,t,a), __MAP2(m,p##_,__VA_ARGS__)
#define __MAP4(m,p,t,a,...) m(p,t,a), __MAP3(m,p##_,__VA_ARGS__)
#define __MAP5(m,p,t,a,...) m(p,t,a), __MAP4(m,p##_,__VA_ARGS__)
#define __MAP6(m,p,t,a,...) m(p,t,a), __MAP5(m,p##_,__VA_ARGS__)
#define __MAP(n,m,...) __MAP##n(m,,__VA_ARGS__)

#define __TYPE_AS(t, v)	__same_type((__force t)0, v)
#define __TYPE_IS_L(t)	(__TYPE_AS(t, 0L))
#define __TYPE_IS_UL(t)	(__TYPE_AS(t, 0UL))
#define __TYPE_IS_LL(t) (__TYPE_AS(t, 0LL) || __TYPE_AS(t, 0ULL))

/*
 * __SC_SIZES32(n, t1, a1, ..., tn, an)
 * __SC_SIZES64(n, t1, a1, ..., tn, an)
 * Build an enum describing the number of slots taken by syscall arguments.
 * Example: __SC_SIZES32(3, int, a, loff_t, b, void *, c) ends up with
 * enum {__SC_BIG_ = 0, __SC_BIG__ = 1, __SC_BIG___ = 0};
 * __SC_BIG<k underscores> => does k-th argument take two slots.
 * Note that __SC_SIZES64 will always define them as zeroes.
 */
#define __SC_SIZE32(p,t,a) __SC_BIG_##p = __TYPE_IS_LL(t)
#define __SC_SIZE64(p,t,a) __SC_BIG_##p = 0
#define __SC_SIZES32(n,...) enum{__MAP(n,__SC_SIZE32,__VA_ARGS__)}
#define __SC_SIZES64(n,...) enum{__MAP(n,__SC_SIZE64,__VA_ARGS__)}


/*
 * Distributing the argument slots.  That depends upon the C ABI for target
 * architecture.  Background: there is an arch-specific sequence of word-sized
 * objects and function arguments are mapped on that sequence.  Each argument
 * takes one or two slots (we are dealing only with integer and pointer types;
 * the rules for floating point, structs, etc. can be a lot more complex).
 * 
 * Syscall ABI marshals the arguments across the userland boundary.  In almost
 * all cases it is done by having 6 registers, each assigned to a slot in
 * the sequence.  The value of those registers are stored in the corresponding
 * slots and control is passed to a wrapper C function implementing the syscall.
 * There the values are normalized and passed to the syscall itself.
 *
 * In case of biarch architectures we need to know the allocation rules for
 * 32bit counterpart - the 64bit ones are trivial (each argument takes exactly
 * one slot, the nth argument goes into nth slot and that's it).
 *
 * Rules are encoded in a pair of macros - __SC_FIRST_ARG and __SC_NEXT_ARG.
 * For the absolute majority of architectures it is simply "take the next
 * one or two slots, depending upon the argument size", and those are fine
 * with defaults.  Something trickier needs to override those.
 */
#ifndef __SC_FIRST_ARG
/*
 * Unless the ABI is really pathological, default will do.
 */
#define __SC_FIRST_ARG 0
#endif

#ifndef __SC_NEXT_ARG
/* For architectures with no alignment requirements.  Most of our targets are
 * such: alpha arc cris frv h8300 ia64 m32r m68k microblaze mn10300 nios2
 * openrisc riscv sparc x86.
*/
#define __SC_NEXT_ARG(p, next, big) next
#endif

#if 0
// Those should live in the corresponding arch/.../include/asm/ABI.h:

// arm, mips, parisc, powerpc, xtensa: double-slot arguments are aligned
// to even slot there.

#define __SC_NEXT_ARG(p, next, big) next + (big & next)

// s390: double-slot can't occupy slots 4 and 5.

#define __SC_NEXT_ARG(p, next, big) next + (big && next == 4)

// blackfin: double-slot can't occupy slots 2 and 3.

#define __SC_NEXT_ARG(p, next, big) next + (big && next == 2)

// sh: this is really nasty.
// Double-slot ones can't occupy slots 3 and 4; if slot 3 had been skipped due
// to that, the next single-slot argument goes there.  That's where we need
// to keep track of more than just the size of the argument and the slots occupied
// by the previous one.


#define __SC_FIRST_ARG 0, __SC_S_ = 0
#define __SC_NEXT_ARG(p, next, big) \
		(big && next == 3) ? 4 : \
		(!big && next == __SC_S##p) ? 3 : \
		(next < __SC_S##p) ? __SC_S##p : next, \
	__SC_S_##p = \
		(big && next == 3) ? 6 : \
 		(next != __SC_S##p) ? 0 : \
		__SC_S##p + (big ? 2 : 0)
#endif

/*
 * __SC_SLOTS(n, t1, a1, ..., tn, an)
 * Build an enum describing the slots taken by each argument.
 * Assumes __SC_BIG_... already in the scope and __SC_{FIRST,NEXT}_ARG
 * defined according to the architecture.
 */
#define __SC_IF(x,y) y
#define __SC_IF_(x,y) x
#define __SC_IF__ __SC_IF_
#define __SC_IF___ __SC_IF_
#define __SC_IF____ __SC_IF_
#define __SC_IF_____ __SC_IF_
#define __SC_SLOT(p,t,a) __SC_OFF_##p = \
	__SC_IF##p(__SC_NEXT_ARG(p, (__SC_OFF##p + __SC_BIG##p + 1), __SC_BIG_##p),\
		   __SC_FIRST_ARG)
#define __SC_SLOTS(n,...) enum{ __MAP(n,__SC_SLOT,__VA_ARGS__) }

/*
 * Syscall ABI marshalling. Syscall dispatcher can either arrange loading
 * of registers into slots on its own and have the syscall wrapper called
 * (in that case we want the wrapper looking like a 6-argument function,
 * with each argument taking a slot) or pass a pointer to struct pt_regs
 * and have wrapper fetch the individual registers from there.  In the
 * former case all knowledge of the mapping from registers to slots sits
 * in the caller, in the latter - in wrappers.  Other strategies are
 * also possible; depends upon the architecture.
 *
 * For syscall wrappers we want the prototype to be used for wrapper and
 * macros for accessing individual slots.  Default is 6-argument wrappers;
 * if architecture wants something different, it should supply
 * __SC_{32,64}PROTO for the prototype and __SC_{32,64}ARG{1..6} for
 * arguments.  Example: for struct pt_regs on x86 we want,
 * in arch/x86/include/asm/ABI.h,
 * #define __SC_64PROTO struct pt_regs *regs
 * #define __SC_64ARG1 regs->di
 * #define __SC_64ARG2 regs->si
 * #define __SC_64ARG3 regs->dx
 * #define __SC_64ARG4 regs->r10
 * #define __SC_64ARG5 regs->r8
 * #define __SC_64ARG6 regs->r9
 * #define __SC_32PROTO struct pt_regs *regs
 * #define __SC_32ARG1 regs->bx
 * #define __SC_32ARG2 regs->cx
 * #define __SC_32ARG3 regs->dx
 * #define __SC_32ARG4 regs->si
 * #define __SC_32ARG5 regs->di
 * #define __SC_32ARG6 regs->bp
 */
#ifndef __SC_64PROTO
#define __SC_64PROTO u64 __SC_64ARG1, u64 __SC_64ARG2, u64 __SC_64ARG3,\
		    u64 __SC_64ARG4, u64 __SC_64ARG5, u64 __SC_64ARG6
#endif
#ifndef __SC_32PROTO
#define __SC_32PROTO u32 __SC_32ARG1, u32 __SC_32ARG2, u32 __SC_32ARG3,\
		    u32 __SC_32ARG4, u32 __SC_32ARG5, u32 __SC_32ARG6
#endif

static __always_inline __nostackprotector u64 combine_long_long(u32 a, u32 b)
{
	union { u32 c[2]; u64 d; } x = {.c={a,b}};
	return x.d;
}
extern u32 __SC_32_ARG7(void) __compiletime_error("too many argument slots");
extern u64 __SC_64_ARG7(void) __compiletime_error("too many argument slots");
#define __SC_32ARG7 __SC_64_ARG7()
#define __SC_64ARG7 __SC_32_ARG7()
#define __SC_W(s,n) (n == 0 ? __SC_##s##ARG1 : \
		   n == 1 ? __SC_##s##ARG2 : \
		   n == 2 ? __SC_##s##ARG3 : \
		   n == 3 ? __SC_##s##ARG4 : \
		   n == 4 ? __SC_##s##ARG5 : \
		   n == 5 ? __SC_##s##ARG6 : \
		   __SC_##s##ARG7)
#define __SC_D(s,n) \
	(n == 0 ? combine_long_long(__SC_##s##ARG1,__SC_##s##ARG2) : \
	 n == 1 ? combine_long_long(__SC_##s##ARG2,__SC_##s##ARG3) : \
	 n == 2 ? combine_long_long(__SC_##s##ARG3,__SC_##s##ARG4) : \
	 n == 3 ? combine_long_long(__SC_##s##ARG4,__SC_##s##ARG5) : \
	 n == 4 ? combine_long_long(__SC_##s##ARG5,__SC_##s##ARG6) : \
	 combine_long_long(__SC_##s##ARG6,__SC_##s##ARG7))
#define __SC_ARG32(p, t, a)	\
	(__force t)__builtin_choose_expr(__SC_BIG_##p, \
		__SC_D(32, __SC_OFF_##p), __SC_W(32, __SC_OFF_##p))
#define __SC_ARG64(p, t, a)	\
	(__force t)__builtin_choose_expr(__SC_BIG_##p, \
		__SC_D(64, __SC_OFF_##p), __SC_W(64, __SC_OFF_##p))
#define __SC_ARGS32(n, ...) __MAP(n, __SC_ARG32, __VA_ARGS__)
#define __SC_ARGS64(n, ...) __MAP(n, __SC_ARG64, __VA_ARGS__)

#ifdef CONFIG_64BIT
#define __SC_PROTO __SC_64PROTO
#define __SC_ARGS __SC_ARGS64
#define __SC_SIZES __SC_SIZES64
#else
#define __SC_PROTO __SC_32PROTO
#define __SC_ARGS __SC_ARGS32
#define __SC_SIZES __SC_SIZES32
#endif

/* The following is ftrace glue, almost verbatim from mainline */

#ifdef CONFIG_FTRACE_SYSCALLS
#define __SC_STR_ADECL(p, t, a)	#a
#define __SC_STR_TDECL(p, t, a)	#t

extern struct trace_event_class event_class_syscall_enter;
extern struct trace_event_class event_class_syscall_exit;
extern struct trace_event_functions enter_syscall_print_funcs;
extern struct trace_event_functions exit_syscall_print_funcs;

#define SYSCALL_TRACE_ENTER_EVENT(sname)				\
	static struct syscall_metadata __syscall_meta_##sname;		\
	static struct trace_event_call __used				\
	  event_enter_##sname = {					\
		.class			= &event_class_syscall_enter,	\
		{							\
			.name                   = "sys_enter"#sname,	\
		},							\
		.event.funcs            = &enter_syscall_print_funcs,	\
		.data			= (void *)&__syscall_meta_##sname,\
		.flags                  = TRACE_EVENT_FL_CAP_ANY,	\
	};								\
	static struct trace_event_call __used				\
	  __attribute__((section("_ftrace_events")))			\
	 *__event_enter_##sname = &event_enter_##sname;

#define SYSCALL_TRACE_EXIT_EVENT(sname)					\
	static struct syscall_metadata __syscall_meta_##sname;		\
	static struct trace_event_call __used				\
	  event_exit_##sname = {					\
		.class			= &event_class_syscall_exit,	\
		{							\
			.name                   = "sys_exit"#sname,	\
		},							\
		.event.funcs		= &exit_syscall_print_funcs,	\
		.data			= (void *)&__syscall_meta_##sname,\
		.flags                  = TRACE_EVENT_FL_CAP_ANY,	\
	};								\
	static struct trace_event_call __used				\
	  __attribute__((section("_ftrace_events")))			\
	*__event_exit_##sname = &event_exit_##sname;

#define SYSCALL_METADATA(sname, nb, ...)			\
	static const char *types_##sname[] = {			\
		__MAP(nb,__SC_STR_TDECL,__VA_ARGS__)		\
	};							\
	static const char *args_##sname[] = {			\
		__MAP(nb,__SC_STR_ADECL,__VA_ARGS__)		\
	};							\
	SYSCALL_TRACE_ENTER_EVENT(sname);			\
	SYSCALL_TRACE_EXIT_EVENT(sname);			\
	static struct syscall_metadata __used			\
	  __syscall_meta_##sname = {				\
		.name 		= "sys"#sname,			\
		.syscall_nr	= -1,	/* Filled in at boot */	\
		.nb_args 	= nb,				\
		.types		= nb ? types_##sname : NULL,	\
		.args		= nb ? args_##sname : NULL,	\
		.enter_event	= &event_enter_##sname,		\
		.exit_event	= &event_exit_##sname,		\
		.enter_fields	= LIST_HEAD_INIT(__syscall_meta_##sname.enter_fields), \
	};							\
	static struct syscall_metadata __used			\
	  __attribute__((section("__syscalls_metadata")))	\
	 *__p_syscall_meta_##sname = &__syscall_meta_##sname;

static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
{
	return tp_event->class == &event_class_syscall_enter ||
	       tp_event->class == &event_class_syscall_exit;
}

#else
#define SYSCALL_METADATA(sname, nb, ...)

static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
{
	return 0;
}
#endif

#define SYSCALL_DEFINE0(sname)					\
	SYSCALL_METADATA(_##sname, 0);				\
	asmlinkage long sys_##sname(void)

#define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
#define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
#define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
#define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
#define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
#define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)

#define SYSCALL_DEFINEx(x, sname, ...)				\
	SYSCALL_METADATA(sname, x, __VA_ARGS__)			\
	__SYSCALL_DEFINEx(x, sname, __VA_ARGS__)

#define __SC_DECL(p, t, a)	t a
#define __SC_TEST(p, t, a) (void)BUILD_BUG_ON_ZERO(!__TYPE_IS_LL(t) && sizeof(t) > sizeof(long))
#define __SYSCALL_DEFINEx(x, name, ...)					\
	asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
		__attribute__((alias(__stringify(SyS##name))));		\
	static inline long SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
	asmlinkage long SyS##name(__SC_PROTO);				\
	asmlinkage long SyS##name(__SC_PROTO)				\
	{								\
		__SC_SIZES(x,__VA_ARGS__);				\
		__SC_SLOTS(x,__VA_ARGS__);				\
		__MAP(x,__SC_TEST,__VA_ARGS__);				\
		return SYSC##name(__SC_ARGS(x,__VA_ARGS__));		\
	}								\
	static inline long SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__))

#ifdef CONFIG_COMPAT
#define __SC_COMPAT_PROTO __SC_32PROTO
#define __SC_COMPAT_ARGS __SC_ARGS32
#define __SC_COMPAT_SIZES __SC_SIZES32

#define COMPAT_SYSCALL_DEFINE0(name) \
	asmlinkage long compat_sys_##name(void)

#define COMPAT_SYSCALL_DEFINE1(name, ...) \
        COMPAT_SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
#define COMPAT_SYSCALL_DEFINE2(name, ...) \
	COMPAT_SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
#define COMPAT_SYSCALL_DEFINE3(name, ...) \
	COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
#define COMPAT_SYSCALL_DEFINE4(name, ...) \
	COMPAT_SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
#define COMPAT_SYSCALL_DEFINE5(name, ...) \
	COMPAT_SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
#define COMPAT_SYSCALL_DEFINE6(name, ...) \
	COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)

#define COMPAT_SYSCALL_DEFINEx(x, name, ...)				\
	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))\
		__attribute__((alias(__stringify(compat_SyS##name))));  \
	static inline long C_SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
	asmlinkage long compat_SyS##name(__SC_COMPAT_PROTO);		\
	asmlinkage long compat_SyS##name(__SC_COMPAT_PROTO)		\
	{								\
		__SC_COMPAT_SIZES(x,__VA_ARGS__);			\
		__SC_SLOTS(x,__VA_ARGS__);				\
		return C_SYSC##name(__SC_COMPAT_ARGS(x,__VA_ARGS__));	\
	}								\
	static inline long C_SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__))
#endif
