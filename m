Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgFLJt0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 12 Jun 2020 05:49:26 -0400
MIME-Version: 1.0
References: <20200611125144.GA2506@gondor.apana.org.au> <20200612043634.GA30181@gondor.apana.org.au>
In-Reply-To: <20200612043634.GA30181@gondor.apana.org.au>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 12 Jun 2020 12:49:07 +0300
Message-ID: <CAHp75Vd5rxS+tir9No9TSVdb2bcf=Bq71RiCx8MurhXO6DKEGA@mail.gmail.com>
Subject: Re: [v2 PATCH] printk: Make linux/printk.h self-contained
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On Fri, Jun 12, 2020 at 7:39 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> As it stands if you include printk.h by itself it will fail to
> compile because it requires definitions from ratelimit.h.  However,
> simply including ratelimit.h from printk.h does not work due to
> inclusion loops involving sched.h and kernel.h.
>
> This patch solves this by moving bits from ratelimit.h into a new
> header file which can then be included by printk.h without any
> worries about header loops.
>
> The build bot then revealed some intriguing failures arising out
> of this patch.  On s390 there is an inclusion loop with asm/bug.h
> and linux/kernel.h that triggers a compile failure, because kernel.h
> will cause asm-generic/bug.h to be included before s390's own
> asm/bug.h has finished processing.  This has been fixed by not
> including kernel.h in arch/s390/include/asm/bug.h.
>
> A related failure was seen on powerpc where asm/bug.h leads to
> the inclusion of linux/kernel.h via asm-generic/bug.h which then
> prematurely tries to use the very macros defined in asm/bug.h.
> The particular inclusion path which led to this involves lockdep.h.
> I have fixed this moving the type definitions lockdep.h into the
> new lockdep_types.h.

This change is a step to the right direction, thanks! FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

It seems you are opening a can of worms :-)
Have you a chance to look at [1]? I think it's a long road, but maybe
you are interested to help with?

[1]: https://lore.kernel.org/lkml/20200422125201.37618-1-andriy.shevchenko@linux.intel.com/


> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>
> diff --git a/include/linux/ratelimit_types.h b/include/linux/ratelimit_types.h
> new file mode 100644
> index 000000000000..b676aa419eef
> --- /dev/null
> +++ b/include/linux/ratelimit_types.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_RATELIMIT_TYPES_H
> +#define _LINUX_RATELIMIT_TYPES_H
> +
> +#include <linux/bits.h>
> +#include <linux/param.h>
> +#include <linux/spinlock_types.h>
> +
> +#define DEFAULT_RATELIMIT_INTERVAL     (5 * HZ)
> +#define DEFAULT_RATELIMIT_BURST                10
> +
> +/* issue num suppressed message on exit */
> +#define RATELIMIT_MSG_ON_RELEASE       BIT(0)
> +
> +struct ratelimit_state {
> +       raw_spinlock_t  lock;           /* protect the state */
> +
> +       int             interval;
> +       int             burst;
> +       int             printed;
> +       int             missed;
> +       unsigned long   begin;
> +       unsigned long   flags;
> +};
> +
> +#define RATELIMIT_STATE_INIT(name, interval_init, burst_init) {                \
> +               .lock           = __RAW_SPIN_LOCK_UNLOCKED(name.lock),  \
> +               .interval       = interval_init,                        \
> +               .burst          = burst_init,                           \
> +       }
> +
> +#define RATELIMIT_STATE_INIT_DISABLED                                  \
> +       RATELIMIT_STATE_INIT(ratelimit_state, 0, DEFAULT_RATELIMIT_BURST)
> +
> +#define DEFINE_RATELIMIT_STATE(name, interval_init, burst_init)                \
> +                                                                       \
> +       struct ratelimit_state name =                                   \
> +               RATELIMIT_STATE_INIT(name, interval_init, burst_init)   \
> +
> +extern int ___ratelimit(struct ratelimit_state *rs, const char *func);
> +#define __ratelimit(state) ___ratelimit(state, __func__)
> +
> +#endif /* _LINUX_RATELIMIT_TYPES_H */
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index e061635e0409..1cd862cfd2f4 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -7,6 +7,7 @@
>  #include <linux/kern_levels.h>
>  #include <linux/linkage.h>
>  #include <linux/cache.h>
> +#include <linux/ratelimit_types.h>
>
>  extern const char linux_banner[];
>  extern const char linux_proc_banner[];
> diff --git a/include/linux/ratelimit.h b/include/linux/ratelimit.h
> index 8ddf79e9207a..b17e0cd0a30c 100644
> --- a/include/linux/ratelimit.h
> +++ b/include/linux/ratelimit.h
> @@ -2,41 +2,10 @@
>  #ifndef _LINUX_RATELIMIT_H
>  #define _LINUX_RATELIMIT_H
>
> -#include <linux/param.h>
> +#include <linux/ratelimit_types.h>
>  #include <linux/sched.h>
>  #include <linux/spinlock.h>
>
> -#define DEFAULT_RATELIMIT_INTERVAL     (5 * HZ)
> -#define DEFAULT_RATELIMIT_BURST                10
> -
> -/* issue num suppressed message on exit */
> -#define RATELIMIT_MSG_ON_RELEASE       BIT(0)
> -
> -struct ratelimit_state {
> -       raw_spinlock_t  lock;           /* protect the state */
> -
> -       int             interval;
> -       int             burst;
> -       int             printed;
> -       int             missed;
> -       unsigned long   begin;
> -       unsigned long   flags;
> -};
> -
> -#define RATELIMIT_STATE_INIT(name, interval_init, burst_init) {                \
> -               .lock           = __RAW_SPIN_LOCK_UNLOCKED(name.lock),  \
> -               .interval       = interval_init,                        \
> -               .burst          = burst_init,                           \
> -       }
> -
> -#define RATELIMIT_STATE_INIT_DISABLED                                  \
> -       RATELIMIT_STATE_INIT(ratelimit_state, 0, DEFAULT_RATELIMIT_BURST)
> -
> -#define DEFINE_RATELIMIT_STATE(name, interval_init, burst_init)                \
> -                                                                       \
> -       struct ratelimit_state name =                                   \
> -               RATELIMIT_STATE_INIT(name, interval_init, burst_init)   \
> -
>  static inline void ratelimit_state_init(struct ratelimit_state *rs,
>                                         int interval, int burst)
>  {
> @@ -73,9 +42,6 @@ ratelimit_set_flags(struct ratelimit_state *rs, unsigned long flags)
>
>  extern struct ratelimit_state printk_ratelimit_state;
>
> -extern int ___ratelimit(struct ratelimit_state *rs, const char *func);
> -#define __ratelimit(state) ___ratelimit(state, __func__)
> -
>  #ifdef CONFIG_PRINTK
>
>  #define WARN_ON_RATELIMIT(condition, state)    ({              \
> diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
> index 7725f8006fdf..0b25f28351ed 100644
> --- a/arch/s390/include/asm/bug.h
> +++ b/arch/s390/include/asm/bug.h
> @@ -2,7 +2,7 @@
>  #ifndef _ASM_S390_BUG_H
>  #define _ASM_S390_BUG_H
>
> -#include <linux/kernel.h>
> +#include <linux/compiler.h>
>
>  #ifdef CONFIG_BUG
>
> diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
> new file mode 100644
> index 000000000000..7b9350624577
> --- /dev/null
> +++ b/include/linux/lockdep_types.h
> @@ -0,0 +1,196 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Runtime locking correctness validator
> + *
> + *  Copyright (C) 2006,2007 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
> + *  Copyright (C) 2007 Red Hat, Inc., Peter Zijlstra
> + *
> + * see Documentation/locking/lockdep-design.rst for more details.
> + */
> +#ifndef __LINUX_LOCKDEP_TYPES_H
> +#define __LINUX_LOCKDEP_TYPES_H
> +
> +#include <linux/types.h>
> +
> +#define MAX_LOCKDEP_SUBCLASSES         8UL
> +
> +enum lockdep_wait_type {
> +       LD_WAIT_INV = 0,        /* not checked, catch all */
> +
> +       LD_WAIT_FREE,           /* wait free, rcu etc.. */
> +       LD_WAIT_SPIN,           /* spin loops, raw_spinlock_t etc.. */
> +
> +#ifdef CONFIG_PROVE_RAW_LOCK_NESTING
> +       LD_WAIT_CONFIG,         /* CONFIG_PREEMPT_LOCK, spinlock_t etc.. */
> +#else
> +       LD_WAIT_CONFIG = LD_WAIT_SPIN,
> +#endif
> +       LD_WAIT_SLEEP,          /* sleeping locks, mutex_t etc.. */
> +
> +       LD_WAIT_MAX,            /* must be last */
> +};
> +
> +#ifdef CONFIG_LOCKDEP
> +
> +#include <linux/list.h>
> +
> +/*
> + * We'd rather not expose kernel/lockdep_states.h this wide, but we do need
> + * the total number of states... :-(
> + */
> +#define XXX_LOCK_USAGE_STATES          (1+2*4)
> +
> +/*
> + * NR_LOCKDEP_CACHING_CLASSES ... Number of classes
> + * cached in the instance of lockdep_map
> + *
> + * Currently main class (subclass == 0) and signle depth subclass
> + * are cached in lockdep_map. This optimization is mainly targeting
> + * on rq->lock. double_rq_lock() acquires this highly competitive with
> + * single depth.
> + */
> +#define NR_LOCKDEP_CACHING_CLASSES     2
> +
> +/*
> + * A lockdep key is associated with each lock object. For static locks we use
> + * the lock address itself as the key. Dynamically allocated lock objects can
> + * have a statically or dynamically allocated key. Dynamically allocated lock
> + * keys must be registered before being used and must be unregistered before
> + * the key memory is freed.
> + */
> +struct lockdep_subclass_key {
> +       char __one_byte;
> +} __attribute__ ((__packed__));
> +
> +/* hash_entry is used to keep track of dynamically allocated keys. */
> +struct lock_class_key {
> +       union {
> +               struct hlist_node               hash_entry;
> +               struct lockdep_subclass_key     subkeys[MAX_LOCKDEP_SUBCLASSES];
> +       };
> +};
> +
> +extern struct lock_class_key __lockdep_no_validate__;
> +
> +struct lock_trace;
> +
> +#define LOCKSTAT_POINTS                4
> +
> +/*
> + * The lock-class itself. The order of the structure members matters.
> + * reinit_class() zeroes the key member and all subsequent members.
> + */
> +struct lock_class {
> +       /*
> +        * class-hash:
> +        */
> +       struct hlist_node               hash_entry;
> +
> +       /*
> +        * Entry in all_lock_classes when in use. Entry in free_lock_classes
> +        * when not in use. Instances that are being freed are on one of the
> +        * zapped_classes lists.
> +        */
> +       struct list_head                lock_entry;
> +
> +       /*
> +        * These fields represent a directed graph of lock dependencies,
> +        * to every node we attach a list of "forward" and a list of
> +        * "backward" graph nodes.
> +        */
> +       struct list_head                locks_after, locks_before;
> +
> +       const struct lockdep_subclass_key *key;
> +       unsigned int                    subclass;
> +       unsigned int                    dep_gen_id;
> +
> +       /*
> +        * IRQ/softirq usage tracking bits:
> +        */
> +       unsigned long                   usage_mask;
> +       const struct lock_trace         *usage_traces[XXX_LOCK_USAGE_STATES];
> +
> +       /*
> +        * Generation counter, when doing certain classes of graph walking,
> +        * to ensure that we check one node only once:
> +        */
> +       int                             name_version;
> +       const char                      *name;
> +
> +       short                           wait_type_inner;
> +       short                           wait_type_outer;
> +
> +#ifdef CONFIG_LOCK_STAT
> +       unsigned long                   contention_point[LOCKSTAT_POINTS];
> +       unsigned long                   contending_point[LOCKSTAT_POINTS];
> +#endif
> +} __no_randomize_layout;
> +
> +#ifdef CONFIG_LOCK_STAT
> +struct lock_time {
> +       s64                             min;
> +       s64                             max;
> +       s64                             total;
> +       unsigned long                   nr;
> +};
> +
> +enum bounce_type {
> +       bounce_acquired_write,
> +       bounce_acquired_read,
> +       bounce_contended_write,
> +       bounce_contended_read,
> +       nr_bounce_types,
> +
> +       bounce_acquired = bounce_acquired_write,
> +       bounce_contended = bounce_contended_write,
> +};
> +
> +struct lock_class_stats {
> +       unsigned long                   contention_point[LOCKSTAT_POINTS];
> +       unsigned long                   contending_point[LOCKSTAT_POINTS];
> +       struct lock_time                read_waittime;
> +       struct lock_time                write_waittime;
> +       struct lock_time                read_holdtime;
> +       struct lock_time                write_holdtime;
> +       unsigned long                   bounces[nr_bounce_types];
> +};
> +
> +struct lock_class_stats lock_stats(struct lock_class *class);
> +void clear_lock_stats(struct lock_class *class);
> +#endif
> +
> +/*
> + * Map the lock object (the lock instance) to the lock-class object.
> + * This is embedded into specific lock instances:
> + */
> +struct lockdep_map {
> +       struct lock_class_key           *key;
> +       struct lock_class               *class_cache[NR_LOCKDEP_CACHING_CLASSES];
> +       const char                      *name;
> +       short                           wait_type_outer; /* can be taken in this context */
> +       short                           wait_type_inner; /* presents this context */
> +#ifdef CONFIG_LOCK_STAT
> +       int                             cpu;
> +       unsigned long                   ip;
> +#endif
> +};
> +
> +struct pin_cookie { unsigned int val; };
> +
> +#else /* !CONFIG_LOCKDEP */
> +
> +/*
> + * The class key takes no space if lockdep is disabled:
> + */
> +struct lock_class_key { };
> +
> +/*
> + * The lockdep_map takes no space if lockdep is disabled:
> + */
> +struct lockdep_map { };
> +
> +struct pin_cookie { };
> +
> +#endif /* !LOCKDEP */
> +
> +#endif /* __LINUX_LOCKDEP_TYPES_H */
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 206774ac6946..1655d767c2c7 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -10,181 +10,20 @@
>  #ifndef __LINUX_LOCKDEP_H
>  #define __LINUX_LOCKDEP_H
>
> +#include <linux/lockdep_types.h>
> +
>  struct task_struct;
> -struct lockdep_map;
>
>  /* for sysctl */
>  extern int prove_locking;
>  extern int lock_stat;
>
> -#define MAX_LOCKDEP_SUBCLASSES         8UL
> -
> -#include <linux/types.h>
> -
> -enum lockdep_wait_type {
> -       LD_WAIT_INV = 0,        /* not checked, catch all */
> -
> -       LD_WAIT_FREE,           /* wait free, rcu etc.. */
> -       LD_WAIT_SPIN,           /* spin loops, raw_spinlock_t etc.. */
> -
> -#ifdef CONFIG_PROVE_RAW_LOCK_NESTING
> -       LD_WAIT_CONFIG,         /* CONFIG_PREEMPT_LOCK, spinlock_t etc.. */
> -#else
> -       LD_WAIT_CONFIG = LD_WAIT_SPIN,
> -#endif
> -       LD_WAIT_SLEEP,          /* sleeping locks, mutex_t etc.. */
> -
> -       LD_WAIT_MAX,            /* must be last */
> -};
> -
>  #ifdef CONFIG_LOCKDEP
>
>  #include <linux/linkage.h>
> -#include <linux/list.h>
>  #include <linux/debug_locks.h>
>  #include <linux/stacktrace.h>
>
> -/*
> - * We'd rather not expose kernel/lockdep_states.h this wide, but we do need
> - * the total number of states... :-(
> - */
> -#define XXX_LOCK_USAGE_STATES          (1+2*4)
> -
> -/*
> - * NR_LOCKDEP_CACHING_CLASSES ... Number of classes
> - * cached in the instance of lockdep_map
> - *
> - * Currently main class (subclass == 0) and signle depth subclass
> - * are cached in lockdep_map. This optimization is mainly targeting
> - * on rq->lock. double_rq_lock() acquires this highly competitive with
> - * single depth.
> - */
> -#define NR_LOCKDEP_CACHING_CLASSES     2
> -
> -/*
> - * A lockdep key is associated with each lock object. For static locks we use
> - * the lock address itself as the key. Dynamically allocated lock objects can
> - * have a statically or dynamically allocated key. Dynamically allocated lock
> - * keys must be registered before being used and must be unregistered before
> - * the key memory is freed.
> - */
> -struct lockdep_subclass_key {
> -       char __one_byte;
> -} __attribute__ ((__packed__));
> -
> -/* hash_entry is used to keep track of dynamically allocated keys. */
> -struct lock_class_key {
> -       union {
> -               struct hlist_node               hash_entry;
> -               struct lockdep_subclass_key     subkeys[MAX_LOCKDEP_SUBCLASSES];
> -       };
> -};
> -
> -extern struct lock_class_key __lockdep_no_validate__;
> -
> -struct lock_trace;
> -
> -#define LOCKSTAT_POINTS                4
> -
> -/*
> - * The lock-class itself. The order of the structure members matters.
> - * reinit_class() zeroes the key member and all subsequent members.
> - */
> -struct lock_class {
> -       /*
> -        * class-hash:
> -        */
> -       struct hlist_node               hash_entry;
> -
> -       /*
> -        * Entry in all_lock_classes when in use. Entry in free_lock_classes
> -        * when not in use. Instances that are being freed are on one of the
> -        * zapped_classes lists.
> -        */
> -       struct list_head                lock_entry;
> -
> -       /*
> -        * These fields represent a directed graph of lock dependencies,
> -        * to every node we attach a list of "forward" and a list of
> -        * "backward" graph nodes.
> -        */
> -       struct list_head                locks_after, locks_before;
> -
> -       const struct lockdep_subclass_key *key;
> -       unsigned int                    subclass;
> -       unsigned int                    dep_gen_id;
> -
> -       /*
> -        * IRQ/softirq usage tracking bits:
> -        */
> -       unsigned long                   usage_mask;
> -       const struct lock_trace         *usage_traces[XXX_LOCK_USAGE_STATES];
> -
> -       /*
> -        * Generation counter, when doing certain classes of graph walking,
> -        * to ensure that we check one node only once:
> -        */
> -       int                             name_version;
> -       const char                      *name;
> -
> -       short                           wait_type_inner;
> -       short                           wait_type_outer;
> -
> -#ifdef CONFIG_LOCK_STAT
> -       unsigned long                   contention_point[LOCKSTAT_POINTS];
> -       unsigned long                   contending_point[LOCKSTAT_POINTS];
> -#endif
> -} __no_randomize_layout;
> -
> -#ifdef CONFIG_LOCK_STAT
> -struct lock_time {
> -       s64                             min;
> -       s64                             max;
> -       s64                             total;
> -       unsigned long                   nr;
> -};
> -
> -enum bounce_type {
> -       bounce_acquired_write,
> -       bounce_acquired_read,
> -       bounce_contended_write,
> -       bounce_contended_read,
> -       nr_bounce_types,
> -
> -       bounce_acquired = bounce_acquired_write,
> -       bounce_contended = bounce_contended_write,
> -};
> -
> -struct lock_class_stats {
> -       unsigned long                   contention_point[LOCKSTAT_POINTS];
> -       unsigned long                   contending_point[LOCKSTAT_POINTS];
> -       struct lock_time                read_waittime;
> -       struct lock_time                write_waittime;
> -       struct lock_time                read_holdtime;
> -       struct lock_time                write_holdtime;
> -       unsigned long                   bounces[nr_bounce_types];
> -};
> -
> -struct lock_class_stats lock_stats(struct lock_class *class);
> -void clear_lock_stats(struct lock_class *class);
> -#endif
> -
> -/*
> - * Map the lock object (the lock instance) to the lock-class object.
> - * This is embedded into specific lock instances:
> - */
> -struct lockdep_map {
> -       struct lock_class_key           *key;
> -       struct lock_class               *class_cache[NR_LOCKDEP_CACHING_CLASSES];
> -       const char                      *name;
> -       short                           wait_type_outer; /* can be taken in this context */
> -       short                           wait_type_inner; /* presents this context */
> -#ifdef CONFIG_LOCK_STAT
> -       int                             cpu;
> -       unsigned long                   ip;
> -#endif
> -};
> -
>  static inline void lockdep_copy_map(struct lockdep_map *to,
>                                     struct lockdep_map *from)
>  {
> @@ -421,8 +260,6 @@ static inline void lock_set_subclass(struct lockdep_map *lock,
>
>  extern void lock_downgrade(struct lockdep_map *lock, unsigned long ip);
>
> -struct pin_cookie { unsigned int val; };
> -
>  #define NIL_COOKIE (struct pin_cookie){ .val = 0U, }
>
>  extern struct pin_cookie lock_pin_lock(struct lockdep_map *lock);
> @@ -501,10 +338,6 @@ static inline void lockdep_set_selftest_task(struct task_struct *task)
>  # define lockdep_reset()               do { debug_locks = 1; } while (0)
>  # define lockdep_free_key_range(start, size)   do { } while (0)
>  # define lockdep_sys_exit()                    do { } while (0)
> -/*
> - * The class key takes no space if lockdep is disabled:
> - */
> -struct lock_class_key { };
>
>  static inline void lockdep_register_key(struct lock_class_key *key)
>  {
> @@ -514,11 +347,6 @@ static inline void lockdep_unregister_key(struct lock_class_key *key)
>  {
>  }
>
> -/*
> - * The lockdep_map takes no space if lockdep is disabled:
> - */
> -struct lockdep_map { };
> -
>  #define lockdep_depth(tsk)     (0)
>
>  #define lockdep_is_held_type(l, r)             (1)
> @@ -530,8 +358,6 @@ struct lockdep_map { };
>
>  #define lockdep_recursing(tsk)                 (0)
>
> -struct pin_cookie { };
> -
>  #define NIL_COOKIE (struct pin_cookie){ }
>
>  #define lockdep_pin_lock(l)                    ({ struct pin_cookie cookie = { }; cookie; })
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt



-- 
With Best Regards,
Andy Shevchenko
