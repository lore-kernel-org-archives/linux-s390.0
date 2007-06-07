Return-Path: <linux-kernel-owner+w=401wt.eu-S1758957AbXFGHoc@vger.kernel.org>
Subject: Re: [RFC] [Patch 4/4] lock contention tracking slimmed down
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1181165656.7133.23.camel@dix>
References: <1181165656.7133.23.camel@dix>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 09:44:18 +0200
Message-Id: <1181202258.7348.217.camel@twins>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, jbaron@redhat.com, rostedt@goodmis.org, billh@gnuppy.monkey.org, mingo@elte.hu, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2007-06-06 at 23:34 +0200, Martin Peschke wrote:

> 
> Signed-off-by: Martin Peschke <mp3@de.ibm.com>
> ---
> 
>  include/linux/lockdep.h |   35 ++---
>  kernel/lockdep.c        |  122 ++-----------------
>  kernel/lockdep_proc.c   |  294 +++++++-----------------------------------------
>  3 files changed, 76 insertions(+), 375 deletions(-)
> 
> Index: linux/kernel/lockdep.c
> ===================================================================
> --- linux.orig/kernel/lockdep.c
> +++ linux/kernel/lockdep.c
> @@ -37,6 +37,7 @@
>  #include <linux/debug_locks.h>
>  #include <linux/irqflags.h>
>  #include <linux/utsname.h>
> +#include <linux/statistic.h>
>  
>  #include <asm/sections.h>
>  
> @@ -119,93 +120,9 @@ unsigned long nr_lock_classes;
>  static struct lock_class lock_classes[MAX_LOCKDEP_KEYS];
>  
>  #ifdef CONFIG_LOCK_STAT
>  static void lock_release_holdtime(struct held_lock *hlock)
>  {
> +	struct statistic *stat = hlock->class->stat;
>  	s64 holdtime;
>  
>  	if (!lock_stat)
> @@ -213,12 +130,10 @@ static void lock_release_holdtime(struct
>  
>  	holdtime = sched_clock() - hlock->holdtime_stamp;
>  
>  	if (hlock->read)
> +		statistic_inc(stat, LOCK_STAT_HOLD_READ, holdtime);
>  	else
> +		statistic_inc(stat, LOCK_STAT_HOLD_WRITE, holdtime);
>  }
>  #else
>  static inline void lock_release_holdtime(struct held_lock *hlock)
> @@ -2745,9 +2660,8 @@ __lock_contended(struct lockdep_map *loc
>  {
>  	struct task_struct *curr = current;
>  	struct held_lock *hlock, *prev_hlock;
>  	unsigned int depth;
> +	int i;
>  
>  	depth = curr->lockdep_depth;
>  	if (DEBUG_LOCKS_WARN_ON(!depth))
> @@ -2761,22 +2675,15 @@ __lock_contended(struct lockdep_map *loc
>  		 */
>  		if (prev_hlock && prev_hlock->irq_context != hlock->irq_context)
>  			break;
> +		if (hlock->instance == lock) {
> +			hlock->waittime_stamp = sched_clock();
> +			_statistic_inc(hlock->class->stat, LOCK_STAT_CONT, ip);
> +			return;
> +		}
>  		prev_hlock = hlock;
>  	}
>  	print_lock_contention_bug(curr, lock, ip);
>  	return;
>  }
>  
>  static void
> @@ -2784,7 +2691,7 @@ __lock_acquired(struct lockdep_map *lock
>  {
>  	struct task_struct *curr = current;
>  	struct held_lock *hlock, *prev_hlock;
> +	struct statistic *stat;
>  	unsigned int depth;
>  	u64 now;
>  	s64 waittime;
> @@ -2817,12 +2724,11 @@ found_it:
>  	waittime = now - hlock->waittime_stamp;
>  	hlock->holdtime_stamp = now;
>  
> +	stat = hlock->class->stat;
>  	if (hlock->read)
> +		_statistic_inc(stat, LOCK_STAT_WAIT_READ, waittime);
>  	else
> +		_statistic_inc(stat, LOCK_STAT_WAIT_WRITE, waittime);
>  }
>  
>  void lock_contended(struct lockdep_map *lock, unsigned long ip)
> Index: linux/include/linux/lockdep.h
> ===================================================================
> --- linux.orig/include/linux/lockdep.h
> +++ linux/include/linux/lockdep.h
> @@ -17,6 +17,7 @@ struct lockdep_map;
>  #include <linux/list.h>
>  #include <linux/debug_locks.h>
>  #include <linux/stacktrace.h>
> +#include <linux/statistic.h>
>  
>  /*
>   * Lock-class usage-state bits:
> @@ -72,6 +73,17 @@ struct lock_class_key {
>  	struct lockdep_subclass_key	subkeys[MAX_LOCKDEP_SUBCLASSES];
>  };
>  
> +#ifdef CONFIG_LOCK_STAT
> +enum lock_stat_enum {
> +	LOCK_STAT_CONT,
> +	LOCK_STAT_WAIT_READ,
> +	LOCK_STAT_WAIT_WRITE,
> +	LOCK_STAT_HOLD_READ,
> +	LOCK_STAT_HOLD_WRITE,
> +	_LOCK_STAT_NUMBER
> +};
> +#endif
> +
>  /*
>   * The lock-class itself:
>   */
> @@ -117,30 +129,11 @@ struct lock_class {
>  	int				name_version;
>  
>  #ifdef CONFIG_LOCK_STAT
> +	struct statistic		stat[_LOCK_STAT_NUMBER];
> +	struct statistic_coll		stat_coll;
>  #endif
>  };
>  
>  /*
>   * Map the lock object (the lock instance) to the lock-class object.
>   * This is embedded into specific lock instances:
> Index: linux/kernel/lockdep_proc.c
> ===================================================================
> --- linux.orig/kernel/lockdep_proc.c
> +++ linux/kernel/lockdep_proc.c
> @@ -349,260 +349,64 @@ static const struct file_operations proc
>  };
>  
>  #ifdef CONFIG_LOCK_STAT
> +struct statistic_info lock_stat_info[_LOCK_STAT_NUMBER] = {
> +	[LOCK_STAT_CONT] = {
> +		.name	  = "contentions",
> +		.x_unit	  = "instruction_pointer",
> +		.y_unit	  = "occurrence",
> +		.defaults = "type=sparse entries=4",
> +		.flags	  = STATISTIC_FLAGS_LABEL,
> +	},
> +	[LOCK_STAT_WAIT_READ] = {
> +		.name	  = "wait_read",
> +		.x_unit	  = "nanoseconds",
> +		.y_unit	  = "occurrence",
> +		.defaults = "type=utilisation",
> +	},
> +	[LOCK_STAT_WAIT_WRITE] = {
> +		.name	  = "wait_write",
> +		.x_unit	  = "nanoseconds",
> +		.y_unit	  = "occurrence",
> +		.defaults = "type=utilisation",
> +	},
> +	[LOCK_STAT_HOLD_READ] = {
> +		.name	  = "hold_read",
> +		.x_unit	  = "nanoseconds",
> +		.y_unit	  = "occurrence",
> +		.defaults = "type=utilisation",
> +	},
> +	[LOCK_STAT_HOLD_WRITE] = {
> +		.name	  = "hold_write",
> +		.x_unit	  = "nanoseconds",
> +		.y_unit	  = "occurrence",
> +		.defaults = "type=utilisation",
>  	}
>  };
>  
> +struct statistic_ui lock_stat_ui;
>  
> +static void lock_stat_label(struct statistic_coll *coll, int i,
> +			    void *key, char *buf, int size)
> +{
> +	sprint_symbol(buf, *(unsigned long *)key);
>  }
>  
> +static void lock_stat_init(void)
>  {
>  	struct lock_class *class;
> +	statistic_create(&lock_stat_ui, "lockstat");
> +	list_for_each_entry(class, &all_lock_classes, lock_entry) {
> +		class->stat_coll.stat = class->stat;
> +		class->stat_coll.info = lock_stat_info;
> +		class->stat_coll.number  = _LOCK_STAT_NUMBER;
> +		class->stat_coll.label = lock_stat_label;
> +		strncpy(class->stat_coll.name, class->name,
> +			STATISTIC_COLL_NAME_SIZE - 1);
> +		statistic_attach(&class->stat_coll, &lock_stat_ui);
>  	}
>  }
> +#endif
>  
>  static int __init lockdep_proc_init(void)
>  {
> @@ -617,9 +421,7 @@ static int __init lockdep_proc_init(void
>  		entry->proc_fops = &proc_lockdep_stats_operations;
>  
>  #ifdef CONFIG_LOCK_STAT
> +	lock_stat_init();
>  #endif
>  
>  	return 0;

I'm confused as to where the class->stat objects are initialised? Is
that done in lock_stat_init()? If so, then you have a bug.
