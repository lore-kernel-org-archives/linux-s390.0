Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 07 May 2018 08:47:02 -0700
Message-ID: <000000000000b15fb3056b9f94e7@google.com>
Subject: INFO: task hung in flush_work
From: syzbot <syzbot+2e7b6af5956e05e5cff7@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Hello,

syzbot found the following crash on:

HEAD commit:    8fb11a9a8d51 net/ipv6: rename rt6_next to fib6_next
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12ca275b800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c416c61f3cd96be
dashboard link: https://syzkaller.appspot.com/bug?extid=2e7b6af5956e05e5cff7
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2e7b6af5956e05e5cff7@syzkaller.appspotmail.com

netlink: 4 bytes leftover after parsing attributes in process  
`syz-executor7'.
netlink: 4 bytes leftover after parsing attributes in process  
`syz-executor7'.
INFO: task syz-executor4:17145 blocked for more than 120 seconds.
       Not tainted 4.17.0-rc3+ #33
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor4   D21736 17145   4542 0x80000002
Call Trace:
  context_switch kernel/sched/core.c:2848 [inline]
  __schedule+0x801/0x1e30 kernel/sched/core.c:3490
  schedule+0xef/0x430 kernel/sched/core.c:3549
  schedule_timeout+0x1b5/0x240 kernel/time/timer.c:1777
  do_wait_for_common kernel/sched/completion.c:83 [inline]
  __wait_for_common kernel/sched/completion.c:104 [inline]
  wait_for_common kernel/sched/completion.c:115 [inline]
  wait_for_completion+0x3e7/0x870 kernel/sched/completion.c:136
  flush_work+0x531/0x900 kernel/workqueue.c:2903
  smc_close_active+0x618/0x9c0 net/smc/smc_close.c:189
  smc_release+0x46b/0x610 net/smc/af_smc.c:141
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
RSP: 002b:00007f4181b74ce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 000000000072bf78 RCX: 0000000000455979
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000072bf78
RBP: 000000000072bf78 R08: 0000000000000000 R09: 000000000072bf50
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000a3e81f R14: 00007f4181b759c0 R15: 0000000000000001

Showing all locks held in the system:
2 locks held by khungtaskd/894:
  #0: 000000002a4a1b2a (rcu_read_lock){....}, at:  
check_hung_uninterruptible_tasks kernel/hung_task.c:175 [inline]
  #0: 000000002a4a1b2a (rcu_read_lock){....}, at: watchdog+0x1ff/0xf60  
kernel/hung_task.c:249
  #1: 00000000472c3276 (tasklist_lock){.+.+}, at:  
debug_show_all_locks+0xde/0x34a kernel/locking/lockdep.c:4470
2 locks held by getty/4468:
  #0: 0000000065ad3d93 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000bfe7ad12 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4469:
  #0: 000000006f6b456f (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000d44cbfd2 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4470:
  #0: 0000000039a0b4b8 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000422d9092 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4471:
  #0: 0000000049ab501c (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000b1883d82 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4472:
  #0: 00000000e473e0f9 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000d6a5f6ee (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4473:
  #0: 00000000af39adc0 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 000000005b852d11 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4474:
  #0: 00000000b68f2084 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 0000000034e0241f (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by kworker/0:3/4924:
  #0: 0000000053ed24fb ((wq_completion)"events"){+.+.}, at:  
__write_once_size include/linux/compiler.h:215 [inline]
  #0: 0000000053ed24fb ((wq_completion)"events"){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 0000000053ed24fb ((wq_completion)"events"){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:40 [inline]
  #0: 0000000053ed24fb ((wq_completion)"events"){+.+.}, at: atomic_long_set  
include/asm-generic/atomic-long.h:57 [inline]
  #0: 0000000053ed24fb ((wq_completion)"events"){+.+.}, at: set_work_data  
kernel/workqueue.c:617 [inline]
  #0: 0000000053ed24fb ((wq_completion)"events"){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
  #0: 0000000053ed24fb ((wq_completion)"events"){+.+.}, at:  
process_one_work+0xaef/0x1b50 kernel/workqueue.c:2116
  #1: 000000008a2387f6 ((work_completion)(&smc->tcp_listen_work)){+.+.}, at:  
process_one_work+0xb46/0x1b50 kernel/workqueue.c:2120
2 locks held by kworker/1:5/15372:
  #0: 0000000053ed24fb ((wq_completion)"events"){+.+.}, at:  
__write_once_size include/linux/compiler.h:215 [inline]
  #0: 0000000053ed24fb ((wq_completion)"events"){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 0000000053ed24fb ((wq_completion)"events"){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:40 [inline]
  #0: 0000000053ed24fb ((wq_completion)"events"){+.+.}, at: atomic_long_set  
include/asm-generic/atomic-long.h:57 [inline]
  #0: 0000000053ed24fb ((wq_completion)"events"){+.+.}, at: set_work_data  
kernel/workqueue.c:617 [inline]
  #0: 0000000053ed24fb ((wq_completion)"events"){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
  #0: 0000000053ed24fb ((wq_completion)"events"){+.+.}, at:  
process_one_work+0xaef/0x1b50 kernel/workqueue.c:2116
  #1: 00000000c29cd536 ((work_completion)(&smc->tcp_listen_work)){+.+.}, at:  
process_one_work+0xb46/0x1b50 kernel/workqueue.c:2120
1 lock held by syz-executor5/18174:
  #0: 00000000fe93fbb2 (sk_lock-AF_INET6){+.+.}, at: lock_sock  
include/net/sock.h:1474 [inline]
  #0: 00000000fe93fbb2 (sk_lock-AF_INET6){+.+.}, at:  
tls_sw_sendmsg+0x1b9/0x12b0 net/tls/tls_sw.c:384

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 894 Comm: khungtaskd Not tainted 4.17.0-rc3+ #33
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.4+0x19/0xce lib/nmi_backtrace.c:103
  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:138 [inline]
  check_hung_task kernel/hung_task.c:132 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:190 [inline]
  watchdog+0xc10/0xf60 kernel/hung_task.c:249
  kthread+0x345/0x410 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.17.0-rc3+ #33
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:activate_task+0x0/0x2e0 kernel/sched/core.c:704
RSP: 0018:ffff8801dae07570 EFLAGS: 00000007
RAX: 0000000000000000 RBX: ffff8801d9a9e240 RCX: ffff8801dae07728
RDX: 0000000000000009 RSI: ffff8801d9a9e240 RDI: ffff8801dae2c680
RBP: ffff8801dae07598 R08: ffff88021fff8018 R09: 0000000000000000
R10: ffffed0043fff001 R11: ffff88021fff8017 R12: ffff8801dae2c680
R13: 0000000000000000 R14: ffff8801dae07728 R15: ffff8801dae07728
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000001b5403000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  ttwu_queue kernel/sched/core.c:1840 [inline]
  try_to_wake_up+0x870/0x1190 kernel/sched/core.c:2053
  wake_up_process+0x10/0x20 kernel/sched/core.c:2126
  process_timeout+0x31/0x40 kernel/time/timer.c:1730
  call_timer_fn+0x230/0x940 kernel/time/timer.c:1326
  expire_timers kernel/time/timer.c:1363 [inline]
  __run_timers+0x79e/0xc50 kernel/time/timer.c:1666
  run_timer_softirq+0x4c/0x70 kernel/time/timer.c:1692
  __do_softirq+0x2e0/0xaf5 kernel/softirq.c:285
  invoke_softirq kernel/softirq.c:365 [inline]
  irq_exit+0x1d1/0x200 kernel/softirq.c:405
  exiting_irq arch/x86/include/asm/apic.h:525 [inline]
  smp_apic_timer_interrupt+0x17e/0x710 arch/x86/kernel/apic/apic.c:1052
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
  </IRQ>
RIP: 0010:native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:54
RSP: 0018:ffffffff88c07bc0 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: dffffc0000000000 RBX: 1ffffffff1180f7b RCX: 0000000000000000
RDX: 1ffffffff11a3170 RSI: 0000000000000001 RDI: ffffffff88d18b80
RBP: ffffffff88c07bc0 R08: ffffed003b5c46c3 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff88c07c78 R14: ffffffff897c2260 R15: 0000000000000000
  arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
  default_idle+0xc2/0x440 arch/x86/kernel/process.c:354
  arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:345
  default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
  cpuidle_idle_call kernel/sched/idle.c:153 [inline]
  do_idle+0x395/0x560 kernel/sched/idle.c:262
  cpu_startup_entry+0x104/0x120 kernel/sched/idle.c:368
  rest_init+0xe1/0xe4 init/main.c:441
  start_kernel+0x906/0x92d init/main.c:737
  x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:445
  x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:426
  secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242
Code: 89 45 d0 e8 33 d1 63 00 48 8b 4d c8 4c 8b 45 d0 e9 2f ff ff ff 66 0f  
1f 44 00 00 55 48 89 e5 e8 a7 51 ff ff 5d c3 0f 1f 44 00 00 <48> b8 00 00  
00 00 00 fc ff df 55 48 89 e5 41 56 41 55 4c 8d 6e


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

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
