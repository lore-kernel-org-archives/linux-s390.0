Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1519734229.2699.6.camel@redhat.com>
References: <001a114fa99028d2a10565e33df4@google.com> <1519734229.2699.6.camel@redhat.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 8 Jun 2018 09:53:12 +0200
Message-ID: <CACT4Y+byLAh+RoGc-a_b446jMmR2kwkWcnDVzCB6msKeS1yZXA@mail.gmail.com>
Subject: Re: WARNING in smc_unhash_sk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Davide Caratti <dcaratti@redhat.com>
Cc: syzbot <syzbot+3a0748c8f2f210c0ef9b@syzkaller.appspotmail.com>, David Miller <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, netdev <netdev@vger.kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, Feb 27, 2018 at 1:23 PM, Davide Caratti <dcaratti@redhat.com> wrote:
> On Fri, 2018-02-23 at 07:59 -0800, syzbot wrote:
>> Hello,
>>
>> syzbot hit the following crash on upstream commit
>> af3e79d29555b97dd096e2f8e36a0f50213808a8 (Tue Feb 20 18:05:02 2018 +0000)
>> Merge tag 'leds_for-4.16-rc3' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds
>>
>> So far this crash happened 27 times on
>> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/master,
>> net-next, upstream.
>> C reproducer is attached.
>> syzkaller reproducer is attached.
>> Raw console output is attached.
>> compiler: gcc (GCC) 7.1.1 20170620
>> .config is attached.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+3a0748c8f2f210c0ef9b@syzkaller.appspotmail.com
>> It will help syzbot understand when the bug is fixed. See footer for
>> details.
>> If you forward the report, please keep this part and the footer.
>>
>> WARNING: CPU: 1 PID: 9921 at ./include/net/sock.h:638 sk_del_node_init
>> include/net/sock.h:638 [inline]
>> WARNING: CPU: 1 PID: 9921 at ./include/net/sock.h:638
>> smc_unhash_sk+0x335/0x450 net/smc/af_smc.c:90
>> Kernel panic - not syncing: panic_on_warn set ...
>>
>> CPU: 1 PID: 9921 Comm: syzkaller089677 Not tainted 4.16.0-rc2+ #324
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Call Trace:
>>   __dump_stack lib/dump_stack.c:17 [inline]
>>   dump_stack+0x194/0x24d lib/dump_stack.c:53
>>   panic+0x1e4/0x41c kernel/panic.c:183
>>   __warn+0x1dc/0x200 kernel/panic.c:547
>>   report_bug+0x211/0x2d0 lib/bug.c:184
>>   fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
>>   fixup_bug arch/x86/kernel/traps.c:247 [inline]
>>   do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
>>   do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
>>   invalid_op+0x58/0x80 arch/x86/entry/entry_64.S:957
>> RIP: 0010:sk_del_node_init include/net/sock.h:638 [inline]
>> RIP: 0010:smc_unhash_sk+0x335/0x450 net/smc/af_smc.c:90
>> RSP: 0018:ffff8801b639f198 EFLAGS: 00010293
>> RAX: ffff8801b684a340 RBX: 1ffff10036c73e37 RCX: ffffffff85a3f1f5
>> RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 1ffff10036c73e3b
>> RBP: ffff8801b639f280 R08: dffffc0000000000 R09: 0000000000000004
>> R10: ffff8801b639f050 R11: 0000000000000004 R12: ffff8801b639f258
>> R13: ffffffff87669b40 R14: ffff8801c08d57c0 R15: 1ffff10036c73e3b
>>   smc_release+0x321/0x580 net/smc/af_smc.c:148
>>   sock_release+0x8d/0x1e0 net/socket.c:595
>>   sock_close+0x16/0x20 net/socket.c:1149
>>   __fput+0x327/0x7e0 fs/file_table.c:209
>>   ____fput+0x15/0x20 fs/file_table.c:243
>>   task_work_run+0x199/0x270 kernel/task_work.c:113
>>   exit_task_work include/linux/task_work.h:22 [inline]
>>   do_exit+0x9bb/0x1ad0 kernel/exit.c:865
>>   do_group_exit+0x149/0x400 kernel/exit.c:968
>>   get_signal+0x73a/0x16d0 kernel/signal.c:2469
>>   do_signal+0x90/0x1e90 arch/x86/kernel/signal.c:809
>>   exit_to_usermode_loop+0x258/0x2f0 arch/x86/entry/common.c:162
>>   prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
>>   syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
>>   do_syscall_64+0x6e5/0x940 arch/x86/entry/common.c:292
>>   entry_SYSCALL_64_after_hwframe+0x42/0xb7
>> RIP: 0033:0x44cad9
>> RSP: 002b:00007fbf24687ce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000007
>> RAX: 0000000000000001 RBX: 0000000000700024 RCX: 000000000044cad9
>> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000020000080
>> RBP: 0000000000700020 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>> R13: 000000000080ef3f R14: 00007fbf246889c0 R15: 0000000000000005
>> Dumping ftrace buffer:
>>     (ftrace buffer empty)
>> Kernel Offset: disabled
>> Rebooting in 86400 seconds..
>>
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git master


Hi Davide,

Any progress on this?

This is syzbot top crasher at the moment with 86000+ machines crashed:
https://syzkaller.appspot.com/bug?id=004b0f7b61d4901cbfecfc33de7996e8cbe0a278
