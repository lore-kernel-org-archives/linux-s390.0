Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 4 Jul 2018 13:01:39 -0700
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: WARNING in smc_unhash_sk
Message-ID: <20180704200139.GB725@sol.localdomain>
References: <001a114fa99028d2a10565e33df4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a114fa99028d2a10565e33df4@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ursula Braun <ubraun@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: syzbot <syzbot+3a0748c8f2f210c0ef9b@syzkaller.appspotmail.com>, davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
List-ID: <linux-s390.vger.kernel.org>

Hi Ursula,

On Fri, Feb 23, 2018 at 07:59:01AM -0800, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on upstream commit
> af3e79d29555b97dd096e2f8e36a0f50213808a8 (Tue Feb 20 18:05:02 2018 +0000)
> Merge tag 'leds_for-4.16-rc3' of
> git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds
> 
> So far this crash happened 27 times on
> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/master,
> net-next, upstream.
> C reproducer is attached.
> syzkaller reproducer is attached.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+3a0748c8f2f210c0ef9b@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> WARNING: CPU: 1 PID: 9921 at ./include/net/sock.h:638 sk_del_node_init
> include/net/sock.h:638 [inline]
> WARNING: CPU: 1 PID: 9921 at ./include/net/sock.h:638
> smc_unhash_sk+0x335/0x450 net/smc/af_smc.c:90
> Kernel panic - not syncing: panic_on_warn set ...

This is still happening and it can be easily reproduced with:

	#include <sys/socket.h>

	int main()
	{
		char buf[64] = { 0 };
		struct iovec iov  = { .iov_base = buf, .iov_len = sizeof(buf) };
		struct msghdr msg = { .msg_iov = &iov, .msg_iovlen = 1 };
		int fd;

		fd = socket(AF_SMC, SOCK_STREAM, 0);
		sendmsg(fd, &msg, MSG_FASTOPEN);
	}

It seems the following sock_put() in smc_release() is done without any previous
sock_hold(), causing a use-after-free:

        if (smc->use_fallback) {
                sock_put(sk); /* passive closing */
                sk->sk_state = SMC_CLOSED;
                sk->sk_state_change(sk);
        }

This is the output on latest Linus tree (commit fc36def997cfd6cb):

	WARNING: CPU: 2 PID: 216 at include/net/sock.h:644 smc_unhash_sk+0x74/0x80 net/smc/af_smc.c:89
	CPU: 2 PID: 216 Comm: syz_smc_unhash Not tainted 4.18.0-rc3-00113-gfc36def997cfd #20
	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-20171110_100015-anatol 04/01/2014
	RIP: 0010:smc_unhash_sk+0x74/0x80 net/smc/af_smc.c:89
	Code: 8d bb 80 00 00 00 e8 9b 4a bc ff 48 8b 73 28 ba ff ff ff ff 48 8b 7b 30 e8 d9 a6 d4 ff 4c 89 e7 e8 e1 5b 02 00 5b 41 5c 5d c3 <0f> 0b eb d1 0f 1f 84 00 00 00 00 00 55 48 89 e5 41 57 49 89 cf 41 
	RSP: 0018:ffffc900007cfd58 EFLAGS: 00010246
	RAX: 0000000000000001 RBX: ffff8800792df7c0 RCX: 0000000000000000
	RDX: 0000000000000000 RSI: ffffffff8270dda0 RDI: ffffffff81e92da0
	RBP: ffffc900007cfd68 R08: ffffffff8270dda0 R09: 0000000000000001
	R10: ffff88007933cbb8 R11: 0000000000000002 R12: ffffffff81e92da0
	R13: 0000000000000000 R14: ffff8800792dfb20 R15: ffff8800792df840
	FS:  00007ff24690e740(0000) GS:ffff88007fd00000(0000) knlGS:0000000000000000
	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	CR2: 00007ff245fe3eb0 CR3: 0000000001e0f000 CR4: 00000000003406e0
	Call Trace:
	 smc_release+0x10a/0x1c0 net/smc/af_smc.c:162
	 __sock_release+0x31/0x80 net/socket.c:599
	 sock_close+0x10/0x20 net/socket.c:1150
	 __fput+0xb4/0x1f0 fs/file_table.c:209
	 ____fput+0x9/0x10 fs/file_table.c:243
	 task_work_run+0x86/0xc0 kernel/task_work.c:113
	 exit_task_work include/linux/task_work.h:22 [inline]
	 do_exit+0x27a/0xa30 kernel/exit.c:865
	 do_group_exit+0x3c/0xc0 kernel/exit.c:968
	 __do_sys_exit_group kernel/exit.c:979 [inline]
	 __se_sys_exit_group kernel/exit.c:977 [inline]
	 __x64_sys_exit_group+0x13/0x20 kernel/exit.c:977
	 do_syscall_64+0x4a/0x180 arch/x86/entry/common.c:290
	 entry_SYSCALL_64_after_hwframe+0x49/0xbe
	RIP: 0033:0x7ff245fe3ee8
	Code: Bad RIP value.
	RSP: 002b:00007ffcd2bdcae8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
	RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff245fe3ee8
	RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
	RBP: 00007ff2462cd6d8 R08: 00000000000000e7 R09: ffffffffffffff80
	R10: 00007ff2464da100 R11: 0000000000000246 R12: 00007ff2462cd6d8
	R13: 00007ff2462d2be0 R14: 0000000000000000 R15: 0000000000000000
	irq event stamp: 1821
	hardirqs last  enabled at (1819): [<ffffffff81053a5a>] __local_bh_enable_ip+0x7a/0xd0 kernel/softirq.c:190
	hardirqs last disabled at (1821): [<ffffffff81800f23>] error_entry+0x73/0xc0 arch/x86/entry/entry_64.S:1262
	softirqs last  enabled at (1818): [<ffffffff8144f8ad>] spin_unlock_bh include/linux/spinlock.h:355 [inline]
	softirqs last  enabled at (1818): [<ffffffff8144f8ad>] release_sock+0x7d/0xb0 net/core/sock.c:2862
	softirqs last disabled at (1820): [<ffffffff81706e0d>] smc_unhash_sk+0x1d/0x80 net/smc/af_smc.c:85
	---[ end trace f41d8ae31daf1115 ]---
	------------[ cut here ]------------
	refcount_t: decrement hit 0; leaking memory.
	WARNING: CPU: 2 PID: 216 at lib/refcount.c:228 refcount_dec+0x33/0x40 lib/refcount.c:228
	CPU: 2 PID: 216 Comm: syz_smc_unhash Tainted: G        W         4.18.0-rc3-00113-gfc36def997cfd #20
	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-20171110_100015-anatol 04/01/2014
	RIP: 0010:refcount_dec+0x33/0x40 lib/refcount.c:228
	Code: 48 89 e5 e8 6f ff ff ff 84 c0 75 02 5d c3 80 3d 85 94 bc 00 00 75 f5 48 c7 c7 40 43 d8 81 c6 05 75 94 bc 00 01 e8 d3 3f d8 ff <0f> 0b 5d c3 66 0f 1f 84 00 00 00 00 00 55 b8 01 00 00 00 31 d2 48 
	RSP: 0018:ffffc900007cfd48 EFLAGS: 00010286
	RAX: 0000000000000000 RBX: ffff8800792df7c0 RCX: 0000000000000006
	RDX: 0000000000000007 RSI: ffff88007933cbe0 RDI: ffff88007fd15410
	RBP: ffffc900007cfd48 R08: 0000000000000001 R09: 0000000000000000
	R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff81e92da0
	R13: 0000000000000000 R14: ffff8800792dfb20 R15: ffff8800792df840
	FS:  00007ff24690e740(0000) GS:ffff88007fd00000(0000) knlGS:0000000000000000
	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	CR2: 00007ff245fe3ebe CR3: 0000000001e0f000 CR4: 00000000003406e0
	Call Trace:
	 __sock_put include/net/sock.h:635 [inline]
	 sk_del_node_init include/net/sock.h:645 [inline]
	 smc_unhash_sk+0x55/0x80 net/smc/af_smc.c:86
	 smc_release+0x10a/0x1c0 net/smc/af_smc.c:162
	 __sock_release+0x31/0x80 net/socket.c:599
	 sock_close+0x10/0x20 net/socket.c:1150
	 __fput+0xb4/0x1f0 fs/file_table.c:209
	 ____fput+0x9/0x10 fs/file_table.c:243
	 task_work_run+0x86/0xc0 kernel/task_work.c:113
	 exit_task_work include/linux/task_work.h:22 [inline]
	 do_exit+0x27a/0xa30 kernel/exit.c:865
	 do_group_exit+0x3c/0xc0 kernel/exit.c:968
	 __do_sys_exit_group kernel/exit.c:979 [inline]
	 __se_sys_exit_group kernel/exit.c:977 [inline]
	 __x64_sys_exit_group+0x13/0x20 kernel/exit.c:977
	 do_syscall_64+0x4a/0x180 arch/x86/entry/common.c:290
	 entry_SYSCALL_64_after_hwframe+0x49/0xbe
	RIP: 0033:0x7ff245fe3ee8
	Code: Bad RIP value.
	RSP: 002b:00007ffcd2bdcae8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
	RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff245fe3ee8
	RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
	RBP: 00007ff2462cd6d8 R08: 00000000000000e7 R09: ffffffffffffff80
	R10: 00007ff2464da100 R11: 0000000000000246 R12: 00007ff2462cd6d8
	R13: 00007ff2462d2be0 R14: 0000000000000000 R15: 0000000000000000
	irq event stamp: 1841
	hardirqs last  enabled at (1840): [<ffffffff810a4297>] console_unlock+0x407/0x520 kernel/printk/printk.c:2422
	hardirqs last disabled at (1841): [<ffffffff81800f23>] error_entry+0x73/0xc0 arch/x86/entry/entry_64.S:1262
	softirqs last  enabled at (1818): [<ffffffff8144f8ad>] spin_unlock_bh include/linux/spinlock.h:355 [inline]
	softirqs last  enabled at (1818): [<ffffffff8144f8ad>] release_sock+0x7d/0xb0 net/core/sock.c:2862
	softirqs last disabled at (1820): [<ffffffff81706e0d>] smc_unhash_sk+0x1d/0x80 net/smc/af_smc.c:85
	---[ end trace f41d8ae31daf1116 ]---
	------------[ cut here ]------------
	refcount_t: underflow; use-after-free.
	WARNING: CPU: 2 PID: 216 at lib/refcount.c:187 refcount_sub_and_test+0x4c/0x60 lib/refcount.c:187
	CPU: 2 PID: 216 Comm: syz_smc_unhash Tainted: G        W         4.18.0-rc3-00113-gfc36def997cfd #20
	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-20171110_100015-anatol 04/01/2014
	RIP: 0010:refcount_sub_and_test+0x4c/0x60 lib/refcount.c:187
	Code: 5d 0f 94 c0 c3 83 f8 ff 75 df 31 c0 5d c3 80 3d ed 94 bc 00 00 75 f3 48 c7 c7 18 43 d8 81 c6 05 dd 94 bc 00 01 e8 3a 40 d8 ff <0f> 0b 31 c0 eb dc 31 c0 c3 90 66 2e 0f 1f 84 00 00 00 00 00 55 48 
	RSP: 0018:ffffc900007cfd58 EFLAGS: 00010282
	RAX: 0000000000000000 RBX: ffff8800792df7c0 RCX: 0000000000000006
	RDX: 0000000000000007 RSI: ffff88007933cbb8 RDI: ffff88007fd15410
	RBP: ffffc900007cfd58 R08: 0000000000000001 R09: 0000000000000000
	R10: 0000000000000000 R11: 0000000000000000 R12: ffff88007cf16b80
	R13: 0000000000000000 R14: ffff8800792dfb20 R15: ffff8800792df840
	FS:  00007ff24690e740(0000) GS:ffff88007fd00000(0000) knlGS:0000000000000000
	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	CR2: 00007ff245fe3ebe CR3: 0000000001e0f000 CR4: 00000000003406e0
	Call Trace:
	 refcount_dec_and_test+0x11/0x20 lib/refcount.c:212
	 sock_put include/net/sock.h:1666 [inline]
	 smc_release+0x112/0x1c0 net/smc/af_smc.c:163
	 __sock_release+0x31/0x80 net/socket.c:599
	 sock_close+0x10/0x20 net/socket.c:1150
	 __fput+0xb4/0x1f0 fs/file_table.c:209
	 ____fput+0x9/0x10 fs/file_table.c:243
	 task_work_run+0x86/0xc0 kernel/task_work.c:113
	 exit_task_work include/linux/task_work.h:22 [inline]
	 do_exit+0x27a/0xa30 kernel/exit.c:865
	 do_group_exit+0x3c/0xc0 kernel/exit.c:968
	 __do_sys_exit_group kernel/exit.c:979 [inline]
	 __se_sys_exit_group kernel/exit.c:977 [inline]
	 __x64_sys_exit_group+0x13/0x20 kernel/exit.c:977
	 do_syscall_64+0x4a/0x180 arch/x86/entry/common.c:290
	 entry_SYSCALL_64_after_hwframe+0x49/0xbe
	RIP: 0033:0x7ff245fe3ee8
	Code: Bad RIP value.
	RSP: 002b:00007ffcd2bdcae8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
	RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff245fe3ee8
	RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
	RBP: 00007ff2462cd6d8 R08: 00000000000000e7 R09: ffffffffffffff80
	R10: 00007ff2464da100 R11: 0000000000000246 R12: 00007ff2462cd6d8
	R13: 00007ff2462d2be0 R14: 0000000000000000 R15: 0000000000000000
	irq event stamp: 1880
	hardirqs last  enabled at (1879): [<ffffffff810a4297>] console_unlock+0x407/0x520 kernel/printk/printk.c:2422
	hardirqs last disabled at (1880): [<ffffffff81800f23>] error_entry+0x73/0xc0 arch/x86/entry/entry_64.S:1262
	softirqs last  enabled at (1862): [<ffffffff81a001b2>] __do_softirq+0x1b2/0x23f kernel/softirq.c:314
	softirqs last disabled at (1847): [<ffffffff81800caa>] do_softirq_own_stack+0x2a/0x40 arch/x86/entry/entry_64.S:1046
	---[ end trace f41d8ae31daf1117 ]---
