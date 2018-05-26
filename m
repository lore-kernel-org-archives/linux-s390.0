Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 26 May 2018 00:52:02 -0700
In-Reply-To: <000000000000451f9d056aff4397@google.com>
Message-ID: <000000000000f6f641056d172825@google.com>
Subject: Re: WARNING: ODEBUG bug in __sk_destruct
From: syzbot <syzbot+92209502e7aab127c75f@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

syzbot has found a reproducer for the following crash on:

HEAD commit:    e52cde717093 net: dsa: dsa_loop: Make dynamic debugging he..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1424a4b7800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4078980b886800c
dashboard link: https://syzkaller.appspot.com/bug?extid=92209502e7aab127c75f
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1071bc2f800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b51cb7800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+92209502e7aab127c75f@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: work_struct hint:  
smc_tx_work+0x0/0x350 include/linux/compiler.h:188
WARNING: CPU: 0 PID: 5254 at lib/debugobjects.c:329  
debug_print_object+0x16a/0x210 lib/debugobjects.c:326
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 5254 Comm: syz-executor351 Not tainted 4.17.0-rc6+ #64
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
RSP: 0018:ffff8801c6f67158 EFLAGS: 00010082
RAX: 0000000000000059 RBX: 0000000000000003 RCX: ffffffff818435f8
RDX: 0000000000000000 RSI: ffffffff8160f2c1 RDI: 0000000000000001
RBP: ffff8801c6f67198 R08: ffff8801cb640580 R09: ffffed003b5c3eb2
R10: ffffed003b5c3eb2 R11: ffff8801dae1f597 R12: 0000000000000001
R13: ffffffff88d5f040 R14: ffffffff87fa2a00 R15: ffffffff814ccb10
  __debug_check_no_obj_freed lib/debugobjects.c:783 [inline]
  debug_check_no_obj_freed+0x3a6/0x584 lib/debugobjects.c:815
  kmem_cache_free+0x216/0x2d0 mm/slab.c:3755
  sk_prot_free net/core/sock.c:1516 [inline]
  __sk_destruct+0x6fe/0xa40 net/core/sock.c:1600
  sk_destruct+0x78/0x90 net/core/sock.c:1608
  __sk_free+0xcf/0x300 net/core/sock.c:1619
  sk_free+0x42/0x50 net/core/sock.c:1630
  sock_put include/net/sock.h:1669 [inline]
  smc_release+0x459/0x610 net/smc/af_smc.c:156
  sock_release+0x96/0x1b0 net/socket.c:594
  sock_close+0x16/0x20 net/socket.c:1149
  __fput+0x34d/0x890 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1e4/0x290 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1aee/0x2730 kernel/exit.c:865
  do_group_exit+0x16f/0x430 kernel/exit.c:968
  __do_sys_exit_group kernel/exit.c:979 [inline]
  __se_sys_exit_group kernel/exit.c:977 [inline]
  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:977
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4424f9
RSP: 002b:00007ffcbea55c78 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00000000000002c0 RCX: 00000000004424f9
RDX: 00000000004424f9 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 00007ffcbea55db0 R08: 0000000300000000 R09: 00007ffcbea55cc0
R10: 0000000000000004 R11: 0000000000000202 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000001380 R15: 00007ffcbea55dd8

======================================================
WARNING: possible circular locking dependency detected
4.17.0-rc6+ #64 Not tainted
------------------------------------------------------
syz-executor351/5254 is trying to acquire lock:
         (ptrval) ((console_sem).lock){-...}, at: down_trylock+0x13/0x70  
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
        debug_hrtimer_init kernel/time/hrtimer.c:410 [inline]
        debug_init kernel/time/hrtimer.c:458 [inline]
        hrtimer_init+0x8f/0x460 kernel/time/hrtimer.c:1308
        init_dl_task_timer+0x1b/0x50 kernel/sched/deadline.c:1056
        __sched_fork+0x2ae/0xc20 kernel/sched/core.c:2166
        init_idle+0x75/0x7a0 kernel/sched/core.c:5402
        sched_init+0xbeb/0xd10 kernel/sched/core.c:6100
        start_kernel+0x475/0x92d init/main.c:601
        x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:453
        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:434
        secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242

-> #2 (&rq->lock){-.-.}:
        __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
        _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:144
        rq_lock kernel/sched/sched.h:1799 [inline]
        task_fork_fair+0x8a/0x660 kernel/sched/fair.c:9912
        sched_fork+0x43e/0xb30 kernel/sched/core.c:2382
        copy_process.part.38+0x1c18/0x6e90 kernel/fork.c:1764
        copy_process kernel/fork.c:1607 [inline]
        _do_fork+0x291/0x12a0 kernel/fork.c:2088
        kernel_thread+0x34/0x40 kernel/fork.c:2147
        rest_init+0x22/0xe4 init/main.c:407
        start_kernel+0x906/0x92d init/main.c:737
        x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:453
        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:434
        secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242

-> #1 (&p->pi_lock){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
        try_to_wake_up+0xca/0x1190 kernel/sched/core.c:1966
        wake_up_process+0x10/0x20 kernel/sched/core.c:2129
        __up.isra.1+0x1b8/0x290 kernel/locking/semaphore.c:262
        up+0x12f/0x1b0 kernel/locking/semaphore.c:187
        __up_console_sem+0xbe/0x1b0 kernel/printk/printk.c:242
        console_unlock+0x7d6/0x1100 kernel/printk/printk.c:2417
        do_con_write+0x12b2/0x2280 drivers/tty/vt/vt.c:2437
        con_write+0x25/0xc0 drivers/tty/vt/vt.c:2786
        process_output_block drivers/tty/n_tty.c:579 [inline]
        n_tty_write+0x6b9/0x1180 drivers/tty/n_tty.c:2308
        do_tty_write drivers/tty/tty_io.c:958 [inline]
        tty_write+0x3f1/0x880 drivers/tty/tty_io.c:1042
        __vfs_write+0x10b/0x960 fs/read_write.c:485
        vfs_write+0x1f8/0x560 fs/read_write.c:549
        ksys_write+0xf9/0x250 fs/read_write.c:598
        __do_sys_write fs/read_write.c:610 [inline]
        __se_sys_write fs/read_write.c:607 [inline]
        __x64_sys_write+0x73/0xb0 fs/read_write.c:607
        do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 ((console_sem).lock){-...}:
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
        sk_prot_free net/core/sock.c:1516 [inline]
        __sk_destruct+0x6fe/0xa40 net/core/sock.c:1600
        sk_destruct+0x78/0x90 net/core/sock.c:1608
        __sk_free+0xcf/0x300 net/core/sock.c:1619
        sk_free+0x42/0x50 net/core/sock.c:1630
        sock_put include/net/sock.h:1669 [inline]
        smc_release+0x459/0x610 net/smc/af_smc.c:156
        sock_release+0x96/0x1b0 net/socket.c:594
        sock_close+0x16/0x20 net/socket.c:1149
        __fput+0x34d/0x890 fs/file_table.c:209
        ____fput+0x15/0x20 fs/file_table.c:243
        task_work_run+0x1e4/0x290 kernel/task_work.c:113
        exit_task_work include/linux/task_work.h:22 [inline]
        do_exit+0x1aee/0x2730 kernel/exit.c:865
        do_group_exit+0x16f/0x430 kernel/exit.c:968
        __do_sys_exit_group kernel/exit.c:979 [inline]
        __se_sys_exit_group kernel/exit.c:977 [inline]
        __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:977
        do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
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

1 lock held by syz-executor351/5254:
  #0:         (ptrval) (&obj_hash[i].lock){-.-.}, at:  
__debug_check_no_obj_freed lib/debugobjects.c:774 [inline]
  #0:         (ptrval) (&obj_hash[i].lock){-.-.}, at:  
debug_check_no_obj_freed+0x159/0x584 lib/debugobjects.c:815

stack backtrace:
CPU: 0 PID: 5254 Comm: syz-executor351 Not tainted 4.17.0-rc6+ #64
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
  sk_prot_free net/core/sock.c:1516 [inline]
  __sk_destruct+0x6fe/0xa40 net/core/sock.c:1600
  sk_destruct+0x78/0x90 net/core/sock.c:1608
  __sk_free+0xcf/0x300 net/core/sock.c:1619
  sk_free+0x42/0x50 net/core/sock.c:1630
  sock_put include/net/sock.h:1669 [inline]
  smc_release+0x459/0x610 net/smc/af_smc.c:156
  sock_release+0x96/0x1b0 net/socket.c:594
  sock_close+0x16/0x20 net/socket.c:1149
  __fput+0x34d/0x890 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1e4/0x290 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1aee/0x2730 kernel/exit.c:865
  do_group_exit+0x16f/0x430 kernel/exit.c:968
  __do_sys_exit_group kernel/exit.c:979 [inline]
  __se_sys_exit_group kernel/exit.c:977 [inline]
  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:977
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4424f9
RSP: 002b:00007ffcbea55c78 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00000000000002c0 RCX: 00000000004424f9
RDX: 00000000004424f9 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 00007ffcbea55db0 R08: 000000030
Lost 2 message(s)!
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..
