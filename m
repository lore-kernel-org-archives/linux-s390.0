From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: Next April 24: [S390] allmodconfig build failure (trace/events)
Date: Fri, 24 Apr 2009 10:41:08 +0200
Message-ID: <20090424104108.0f2c0f05@osiris.boeblingen.de.ibm.com>
References: <20090424150456.ff35e4ea.sfr@canb.auug.org.au>
	<49F16654.8040208@in.ibm.com>
	<20090424072533.GE24912@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20090424072533.GE24912@elte.hu>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Sachin Sant <sachinp@in.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, linux-s390@vger.kernel.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 24 Apr 2009 09:25:33 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Sachin Sant <sachinp@in.ibm.com> wrote:
> 
> > Today's next tree build(s390 allmodconfig) failed with
> >
> > kernel/built-in.o: In function `trace_softirq_entry'
> > include/trace/events/irq.h:42: undefined reference to  
> > `'
> > include/trace/events/irq.h:42: undefined reference to  
> > `__tracepoint_softirq_entry'
> > kernel/built-in.o: In function `trace_softirq_exit':
> > include/trace/events/irq.h:48: undefined reference to  
> > `__tracepoint_softirq_exit'
> > include/trace/events/irq.h:48: undefined reference to  
> > `__tracepoint_softirq_exit'
> 
> Hm, that's weird - s390 does not build kernel/softirq.o? Hm, it does 
> - softirq.o is an obj-y object.

s390 does build kernel/softirq.o. However it's anything but obvious to
me how the tracepoint infrastructure works. Too many #ifdefs, #define's
and #undefine's...

I would expect that struct __tracepoint_softirq_entry somehow gets
defined via one of the TRACE_FORMAT macros, no?

kernel/softirq.i has these parts wrt. __tracepoint_softirq_entry:

# 42 "include/trace/events/irq.h"
extern struct tracepoint __tracepoint_softirq_entry; static inline __attribute__((always_inline)) void trace_softirq_entry(struc
t softirq_action *h, struct softirq_action *vec) { if (__builtin_expect(!!(__tracepoint_softirq_entry.state), 0)) do { void **it
_func; do { } while (0); it_func = ({ typeof((&__tracepoint_softirq_entry)->funcs) _________p1 = (*(volatile typeof((&__tracepoi
nt_softirq_entry)->funcs) *)&((&__tracepoint_softirq_entry)->funcs)); do { } while(0); (_________p1); }); if (it_func) { do { ((
void(*)(struct softirq_action *h, struct softirq_action *vec))(*it_func))(h, vec); } while (*(++it_func)); } do { } while (0); }
 while (0); } static inline __attribute__((always_inline)) int register_trace_softirq_entry(void (*probe)(struct softirq_action 
*h, struct softirq_action *vec)) { return tracepoint_probe_register("softirq_entry", (void *)probe); } static inline __attribute
__((always_inline)) int unregister_trace_softirq_entry(void (*probe)(struct softirq_action *h, struct softirq_action *vec)) { re
turn tracepoint_probe_unregister("softirq_entry", (void *)probe); };

extern struct tracepoint __tracepoint_softirq_exit; static inline __attribute__((always_inline)) void trace_softirq_exit(struct 
softirq_action *h, struct softirq_action *vec) { if (__builtin_expect(!!(__tracepoint_softirq_exit.state), 0)) do { void **it_fu
nc; do { } while (0); it_func = ({ typeof((&__tracepoint_softirq_exit)->funcs) _________p1 = (*(volatile typeof((&__tracepoint_s
oftirq_exit)->funcs) *)&((&__tracepoint_softirq_exit)->funcs)); do { } while(0); (_________p1); }); if (it_func) { do { ((void(*
)(struct softirq_action *h, struct softirq_action *vec))(*it_func))(h, vec); } while (*(++it_func)); } do { } while (0); } while
 (0); } static inline __attribute__((always_inline)) int register_trace_softirq_exit(void (*probe)(struct softirq_action *h, str
uct softirq_action *vec)) { return tracepoint_probe_register("softirq_exit", (void *)probe); } static inline __attribute__((alwa
ys_inline)) int unregister_trace_softirq_exit(void (*probe)(struct softirq_action *h, struct softirq_action *vec)) { return trac
epoint_probe_unregister("softirq_exit", (void *)probe); };

__do_softirq looks like below. So I would expect some header file include dependency? Dunno...

 void __do_softirq(void)
{
 struct softirq_action *h;
 __u32 pending;
 int max_restart = 10;
 int cpu;

 pending = ((*((struct _lowcore *) 0)).softirq_pending);
 account_system_vtime(((struct task_struct *const)(*((struct _lowcore *) 0)).current_task));

 __local_bh_disable((unsigned long)__builtin_return_address(0));
 do { ((struct task_struct *const)(*((struct _lowcore *) 0)).current_task)->softirq_context++; } while (0);

 cpu = ((*((struct _lowcore *) 0)).cpu_nr);
restart:

 (((*((struct _lowcore *) 0)).softirq_pending) = (0));

 do { trace_hardirqs_on(); raw_local_irq_enable(); } while (0);

 h = softirq_vec;

 do {
  if (pending & 1) {
   int prev_count = (current_thread_info()->preempt_count);

   trace_softirq_entry(h, softirq_vec);
   h->action(h);
   trace_softirq_exit(h, softirq_vec);
   if (__builtin_expect(!!(prev_count != (current_thread_info()->preempt_count)), 0)) {
    printk("<3>" "huh, entered softirq %td %s %p"
           "with preempt_count %08x,"
           " exited with %08x?\n", h - softirq_vec,
           softirq_to_name[h - softirq_vec],
           h->action, prev_count, (current_thread_info()->preempt_count));
    (current_thread_info()->preempt_count) = prev_count;
   }

   rcu_bh_qsctr_inc(cpu);
  }
  h++;
  pending >>= 1;
 } while (pending);

 do { raw_local_irq_disable(); trace_hardirqs_off(); } while (0);

 pending = ((*((struct _lowcore *) 0)).softirq_pending);
 if (pending && --max_restart)
  goto restart;

 if (pending)
  wakeup_softirqd();

 do { ((struct task_struct *const)(*((struct _lowcore *) 0)).current_task)->softirq_context--; } while (0);

 account_system_vtime(((struct task_struct *const)(*((struct _lowcore *) 0)).current_task));
 _local_bh_enable();
}
