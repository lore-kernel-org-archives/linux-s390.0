Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-il1-f199.google.com ([209.85.166.199]:37669 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfLAEhL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 30 Nov 2019 23:37:11 -0500
Received: by mail-il1-f199.google.com with SMTP id t19so3920453ila.4
        for <linux-s390@vger.kernel.org>; Sat, 30 Nov 2019 20:37:09 -0800 (PST)
MIME-Version: 1.0
Date: Sat, 30 Nov 2019 20:37:09 -0800
In-Reply-To: <0000000000007cace40598282858@google.com>
Message-ID: <00000000000011c9b105989d0489@google.com>
Subject: Re: WARNING: refcount bug in smc_release (2)
From: syzbot <syzbot+96d3f9ff6a86d37e44c8@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net, kgraul@linux.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, ubraun@linux.ibm.com

syzbot has found a reproducer for the following crash on:

HEAD commit:    32ef9553 Merge tag 'fsnotify_for_v5.5-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f6d82ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff560c3de405258c
dashboard link: https://syzkaller.appspot.com/bug?extid=96d3f9ff6a86d37e44c8
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b57336e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149e357ae00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+96d3f9ff6a86d37e44c8@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 1 PID: 9807 at lib/refcount.c:28  
refcount_warn_saturate+0x1dc/0x1f0 lib/refcount.c:28
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 9807 Comm: syz-executor293 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  panic+0x2e3/0x75c kernel/panic.c:221
  __warn.cold+0x2f/0x3e kernel/panic.c:582
  report_bug+0x289/0x300 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  fixup_bug arch/x86/kernel/traps.c:169 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:267
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:286
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:refcount_warn_saturate+0x1dc/0x1f0 lib/refcount.c:28
Code: e9 d8 fe ff ff 48 89 df e8 c1 5a 24 fe e9 85 fe ff ff e8 e7 08 e7 fd  
48 c7 c7 a0 6f 4f 88 c6 05 60 b8 a4 06 01 e8 53 bd b7 fd <0f> 0b e9 ac fe  
ff ff 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 55 48
RSP: 0018:ffff888093c97998 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815e4316 RDI: ffffed1012792f25
RBP: ffff888093c979a8 R08: ffff8880a04d4380 R09: ffffed1015d26621
R10: ffffed1015d26620 R11: ffff8880ae933107 R12: 0000000000000003
R13: 0000000000000000 R14: ffff8880a118d380 R15: ffff88809427e558
  refcount_sub_and_test include/linux/refcount.h:261 [inline]
  refcount_dec_and_test include/linux/refcount.h:281 [inline]
  sock_put include/net/sock.h:1728 [inline]
  smc_release+0x445/0x520 net/smc/af_smc.c:202
  __sock_release+0xce/0x280 net/socket.c:591
  sock_close+0x1e/0x30 net/socket.c:1269
  __fput+0x2ff/0x890 fs/file_table.c:280
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x8e7/0x2ef0 kernel/exit.c:797
  do_group_exit+0x135/0x360 kernel/exit.c:895
  get_signal+0x47c/0x24f0 kernel/signal.c:2734
  do_signal+0x87/0x1700 arch/x86/kernel/signal.c:815
  exit_to_usermode_loop+0x286/0x380 arch/x86/entry/common.c:160
  prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
  do_syscall_32_irqs_on arch/x86/entry/common.c:352 [inline]
  do_fast_syscall_32+0xbbd/0xe16 arch/x86/entry/common.c:408
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f69a39
Code: Bad RIP value.
RSP: 002b:00000000f7f441ec EFLAGS: 00000296 ORIG_RAX: 00000000000000f0
RAX: fffffffffffffe00 RBX: 00000000080fb018 RCX: 0000000000000080
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
RBP: 0000000020000040 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..
