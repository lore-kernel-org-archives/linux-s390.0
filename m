Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 29 Apr 2018 09:31:01 -0700
Message-ID: <000000000000451f9d056aff4397@google.com>
Subject: WARNING: ODEBUG bug in __sk_destruct
From: syzbot <syzbot+92209502e7aab127c75f@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Hello,

syzbot hit the following crash on net-next commit
af201bab50a89aa6cf4df952b2c3bf55895c8eee (Fri Apr 27 15:12:10 2018 +0000)
udp: remove stray export symbol
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=92209502e7aab127c75f

So far this crash happened 5 times on net-next.
Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6049832271609856
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=4410550353033654931
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+92209502e7aab127c75f@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: work_struct hint:  
smc_tcp_listen_work+0x0/0xec0 net/smc/af_smc.c:1014
WARNING: CPU: 0 PID: 9815 at lib/debugobjects.c:329  
debug_print_object+0x16a/0x210 lib/debugobjects.c:326
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 9815 Comm: syz-executor7 Not tainted 4.17.0-rc2+ #23
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  panic+0x22f/0x4de kernel/panic.c:184
  __warn.cold.8+0x163/0x1b3 kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1de/0x490 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
RIP: 0010:debug_print_object+0x16a/0x210 lib/debugobjects.c:326
RSP: 0018:ffff88019790ecf0 EFLAGS: 00010082
RAX: 0000000000000061 RBX: 0000000000000003 RCX: ffffffff818433e8
RDX: 0000000000000000 RSI: ffffffff8160f561 RDI: 0000000000000001
RBP: ffff88019790ed30 R08: ffff8801aced62c0 R09: ffffed003b5c3eb2
R10: ffffed003b5c3eb2 R11: ffff8801dae1f597 R12: 0000000000000001
R13: ffffffff88d5f700 R14: ffffffff87fa3340 R15: ffffffff814ccec0
  __debug_check_no_obj_freed lib/debugobjects.c:783 [inline]
  debug_check_no_obj_freed+0x3a6/0x584 lib/debugobjects.c:815
  kmem_cache_free+0x216/0x2d0 mm/slab.c:3755
  sk_prot_free net/core/sock.c:1512 [inline]
  __sk_destruct+0x6fe/0xa40 net/core/sock.c:1596
  sk_destruct+0x78/0x90 net/core/sock.c:1604
  __sk_free+0x22e/0x340 net/core/sock.c:1615
  sk_free+0x42/0x50 net/core/sock.c:1626
  sock_put include/net/sock.h:1664 [inline]
  smc_release+0x459/0x610 net/smc/af_smc.c:162
  sock_release+0x96/0x1b0 net/socket.c:594
  sock_close+0x16/0x20 net/socket.c:1149
  __fput+0x34d/0x890 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1e4/0x290 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1aee/0x2730 kernel/exit.c:865
  do_group_exit+0x16f/0x430 kernel/exit.c:968
  get_signal+0x886/0x1960 kernel/signal.c:2469
  do_signal+0x98/0x2040 arch/x86/kernel/signal.c:810
  exit_to_usermode_loop+0x28a/0x310 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
  do_syscall_64+0x6ac/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455979
RSP: 002b:00007f6e1a1b9ce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 000000000072bec8 RCX: 0000000000455979
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000072bec8
RBP: 000000000072bec8 R08: 0000000000000000 R09: 000000000072bea0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000a3e81f R14: 00007f6e1a1ba9c0 R15: 0000000000000000

======================================================
WARNING: possible circular locking dependency detected
4.17.0-rc2+ #23 Not tainted
------------------------------------------------------
syz-executor7/9815 is trying to acquire lock:
         (ptrval) ((console_sem).lock){-.-.}, at: down_trylock+0x13/0x70  
kernel/locking/semaphore.c:136

but task is already holding lock:
         (ptrval) (&obj_hash[i].lock){-.-.}, at: __debug_check_no_obj_freed  
lib/debugobjects.c:774 [inline]
         (ptrval) (&obj_hash[i].lock){-.-.}, at:  
debug_check_no_obj_freed+0x159/0x584 lib/debugobjects.c:815

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&obj_hash[i].lock){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
        __debug_object_init+0x11f/0x12c0 lib/debugobjects.c:381
        debug_object_init+0x16/0x20 lib/debugobjects.c:429
        debug_hrtimer_init kernel/time/hrtimer.c:400 [inline]
        debug_init kernel/time/hrtimer.c:448 [inline]
        hrtimer_init+0x8f/0x460 kernel/time/hrtimer.c:1296
        init_dl_task_timer+0x1b/0x50 kernel/sched/deadline.c:1056
        __sched_fork+0x2ae/0xc20 kernel/sched/core.c:2163
        init_idle+0x75/0x7a0 kernel/sched/core.c:5406
        sched_init+0xbeb/0xd10 kernel/sched/core.c:6104
        start_kernel+0x475/0x92d init/main.c:601
        x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:445
        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:426
        secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242

-> #2 (&rq->lock){-.-.}:
        __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
        _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:144
        rq_lock kernel/sched/sched.h:1799 [inline]
        task_fork_fair+0x8a/0x660 kernel/sched/fair.c:9967
        sched_fork+0x43e/0xb30 kernel/sched/core.c:2379
        copy_process.part.38+0x1c13/0x6e90 kernel/fork.c:1764
        copy_process kernel/fork.c:1607 [inline]
        _do_fork+0x291/0x12a0 kernel/fork.c:2088
        kernel_thread+0x34/0x40 kernel/fork.c:2147
        rest_init+0x22/0xe4 init/main.c:407
        start_kernel+0x906/0x92d init/main.c:737
        x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:445
        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:426
        secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242

-> #1 (&p->pi_lock){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
        try_to_wake_up+0xca/0x1190 kernel/sched/core.c:1963
        wake_up_process+0x10/0x20 kernel/sched/core.c:2126
        __up.isra.1+0x1b8/0x290 kernel/locking/semaphore.c:262
        up+0x12f/0x1b0 kernel/locking/semaphore.c:187
        __up_console_sem+0xbe/0x1b0 kernel/printk/printk.c:242
        console_unlock+0x7d6/0x1100 kernel/printk/printk.c:2417
        vprintk_emit+0x6ad/0xdd0 kernel/printk/printk.c:1907
        vprintk_default+0x28/0x30 kernel/printk/printk.c:1947
        vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:379
        printk+0x9e/0xba kernel/printk/printk.c:1980
        regdb_fw_cb.cold.35+0x18/0x89 net/wireless/reg.c:1074
        request_firmware_work_func+0x154/0x2c0  
drivers/base/firmware_loader/main.c:749
        process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
        worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
        kthread+0x345/0x410 kernel/kthread.c:238
        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

-> #0 ((console_sem).lock){-.-.}:
        lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
        down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
        __down_trylock_console_sem+0xae/0x200 kernel/printk/printk.c:225
        console_trylock+0x15/0xa0 kernel/printk/printk.c:2229
        console_trylock_spinning kernel/printk/printk.c:1643 [inline]
        vprintk_emit+0x694/0xdd0 kernel/printk/printk.c:1906
        vprintk_default+0x28/0x30 kernel/printk/printk.c:1947
        vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:379
        printk+0x9e/0xba kernel/printk/printk.c:1980
        __warn_printk+0x83/0xd0 kernel/panic.c:590
        debug_print_object+0x16a/0x210 lib/debugobjects.c:326
        __debug_check_no_obj_freed lib/debugobjects.c:783 [inline]
        debug_check_no_obj_freed+0x3a6/0x584 lib/debugobjects.c:815
        kmem_cache_free+0x216/0x2d0 mm/slab.c:3755
        sk_prot_free net/core/sock.c:1512 [inline]
        __sk_destruct+0x6fe/0xa40 net/core/sock.c:1596
        sk_destruct+0x78/0x90 net/core/sock.c:1604
        __sk_free+0x22e/0x340 net/core/sock.c:1615
        sk_free+0x42/0x50 net/core/sock.c:1626
        sock_put include/net/sock.h:1664 [inline]
        smc_release+0x459/0x610 net/smc/af_smc.c:162
        sock_release+0x96/0x1b0 net/socket.c:594
        sock_close+0x16/0x20 net/socket.c:1149
        __fput+0x34d/0x890 fs/file_table.c:209
        ____fput+0x15/0x20 fs/file_table.c:243
        task_work_run+0x1e4/0x290 kernel/task_work.c:113
        exit_task_work include/linux/task_work.h:22 [inline]
        do_exit+0x1aee/0x2730 kernel/exit.c:865
        do_group_exit+0x16f/0x430 kernel/exit.c:968
        get_signal+0x886/0x1960 kernel/signal.c:2469
        do_signal+0x98/0x2040 arch/x86/kernel/signal.c:810
        exit_to_usermode_loop+0x28a/0x310 arch/x86/entry/common.c:162
        prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
        syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
        do_syscall_64+0x6ac/0x800 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
   (console_sem).lock --> &rq->lock --> &obj_hash[i].lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&obj_hash[i].lock);
                                lock(&rq->lock);
                                lock(&obj_hash[i].lock);
   lock((console_sem).lock);

  *** DEADLOCK ***

1 lock held by syz-executor7/9815:
  #0:         (ptrval) (&obj_hash[i].lock){-.-.}, at:  
__debug_check_no_obj_freed lib/debugobjects.c:774 [inline]
  #0:         (ptrval) (&obj_hash[i].lock){-.-.}, at:  
debug_check_no_obj_freed+0x159/0x584 lib/debugobjects.c:815

stack backtrace:
CPU: 0 PID: 9815 Comm: syz-executor7 Not tainted 4.17.0-rc2+ #23
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_circular_bug.isra.36.cold.54+0x1bd/0x27d  
kernel/locking/lockdep.c:1223
  check_prev_add kernel/locking/lockdep.c:1863 [inline]
  check_prevs_add kernel/locking/lockdep.c:1976 [inline]
  validate_chain kernel/locking/lockdep.c:2417 [inline]
  __lock_acquire+0x343e/0x5140 kernel/locking/lockdep.c:3431
  lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
  down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
  __down_trylock_console_sem+0xae/0x200 kernel/printk/printk.c:225
  console_trylock+0x15/0xa0 kernel/printk/printk.c:2229
  console_trylock_spinning kernel/printk/printk.c:1643 [inline]
  vprintk_emit+0x694/0xdd0 kernel/printk/printk.c:1906
  vprintk_default+0x28/0x30 kernel/printk/printk.c:1947
  vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:379
  printk+0x9e/0xba kernel/printk/printk.c:1980
  __warn_printk+0x83/0xd0 kernel/panic.c:590
  debug_print_object+0x16a/0x210 lib/debugobjects.c:326
  __debug_check_no_obj_freed lib/debugobjects.c:783 [inline]
  debug_check_no_obj_freed+0x3a6/0x584 lib/debugobjects.c:815
  kmem_cache_free+0x216/0x2d0 mm/slab.c:3755
  sk_prot_free net/core/sock.c:1512 [inline]
  __sk_destruct+0x6fe/0xa40 net/core/sock.c:1596
  sk_destruct+0x78/0x90 net/core/sock.c:1604
  __sk_free+0x22e/0x340 net/core/sock.c:1615
  sk_free+0x42/0x50 net/core/sock.c:1626
  sock_put include/net/sock.h:1664 [inline]
  smc_release+0x459/0x610 net/smc/af_smc.c:162
  sock_release+0x96/0x1b0 net/socket.c:594
  sock_close+0x16/0x20 net/socket.c:1149
  __fput+0x34d/0x890 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1e4/0x290 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1aee/0x2730 kernel/exit.c:865
  do_group_exit+0x16f/0x430 kernel/exit.c:968
  get_signal+0x886/0x1960 kernel/signal.c:2469
  do_signal+0x98/0x2040 arch/x86/kernel/signal.c:810
  ? lock_dow
Lost 26 message(s)!
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a dumb bot. It may contain errors.
See https://goo.gl/tpsmEJ for details.
Direct all questions to syzkaller@googlegroups.com.

syzbot will keep track of this bug report.
If you forgot to add the Reported-by tag, once the fix for this bug is  
merged
into any tree, please reply to this email with:
#syz fix: exact-commit-title
To mark this as a duplicate of another syzbot report, please reply with:
#syz dup: exact-subject-of-another-report
If it's a one-off invalid bug report, please reply with:
#syz invalid
Note: if the crash happens again, it will cause creation of a new bug  
report.
Note: all commands must start from beginning of the line in the email body.
