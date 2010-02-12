From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: mmotm 2010-02-10 - BUG at fs/dcache.c:677!
Date: Thu, 11 Feb 2010 19:14:27 -0800
Message-ID: <20100211191427.6ff9aec6.akpm@linux-foundation.org>
References: <201002110043.o1B0hKxW008835@imap1.linux-foundation.org>
	<8576.1265942657@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <8576.1265942657@localhost>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-fsdevel/>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, linux-s390@vger.kernel.org, linux-next@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 11 Feb 2010 21:44:17 -0500 Valdis.Kletnieks@vt.edu wrote:

> On Wed, 10 Feb 2010 16:17:41 PST, akpm@linux-foundation.org said:
> > The mm-of-the-moment snapshot 2010-02-10-16-17 has been uploaded to
> > 
> >    http://userweb.kernel.org/~akpm/mmotm/
> 
> Hit this at shutdown. ext4 filesystems.  Brought it up to single-user
> mode, then 'shutdown -h now'.
> 
> [   58.311786] ------------[ cut here ]------------
> [   58.312261] kernel BUG at fs/dcache.c:677!
> [   58.312261] invalid opcode: 0000 [#1] PREEMPT SMP 
> [   58.312261] last sysfs file: /sys/devices/virtual/block/dm-10/dm/name
> [   58.312261] CPU 1 
> [   58.312261] Pid: 3007, comm: umount Not tainted 2.6.33-rc7-mmotm0210 #1 0X564R/Latitude E6500                  
> [   58.312261] RIP: 0010:[<ffffffff810e7ce8>]  [<ffffffff810e7ce8>] shrink_dcache_for_umount_subtree+0x19b/0x27e
> [   58.312261] RSP: 0018:ffff88011bafde08  EFLAGS: 00010292
> [   58.312261] RAX: 000000000000006b RBX: ffff88011be58160 RCX: ffffffff81a2b070
> [   58.312261] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff81aa3fe8
> [   58.312261] RBP: ffff88011bafde38 R08: 0000000000000002 R09: 0000000000000000
> [   58.312261] R10: 0000000000000005 R11: 0000000000000000 R12: ffff88011be58160
> [   58.312261] R13: 0000000000000088 R14: ffff88011be824c0 R15: ffff88011bafdf18
> [   58.312261] FS:  00007f1348f7e740(0000) GS:ffff880100300000(0000) knlGS:0000000000000000
> [   58.312261] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   58.312261] CR2: 00007f1348642c40 CR3: 000000011ce86000 CR4: 00000000000406e0
> [   58.312261] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   58.312261] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> [   58.312261] Process umount (pid: 3007, threadinfo ffff88011bafc000, task ffff88011d88c640)
> [   58.312261] Stack:
> [   58.312261]  ffff88010f7e9418 ffff88010f7e9248 ffff88010f7e9000 ffffffff816270b0
> [   58.312261] <0> ffff88010f7e9000 ffffffff81b08d28 ffff88011bafde58 ffffffff810e7e02
> [   58.312261] <0> ffffffff81a37ed0 ffff88010f7e9000 ffff88011bafde78 ffffffff810d8785
> [   58.312261] Call Trace:
> [   58.312261]  [<ffffffff810e7e02>] shrink_dcache_for_umount+0x37/0x47
> [   58.312261]  [<ffffffff810d8785>] generic_shutdown_super+0x1a/0xc9
> [   58.312261]  [<ffffffff810d8856>] kill_block_super+0x22/0x3a
> [   58.312261]  [<ffffffff810d8ff5>] deactivate_super+0x68/0x7f
> [   58.312261]  [<ffffffff810eda94>] mntput_no_expire+0x10d/0x150
> [   58.312261]  [<ffffffff810ee04c>] sys_umount+0x2be/0x2ed
> [   58.312261]  [<ffffffff81062361>] ? trace_hardirqs_on_caller+0x16/0x13c
> [   58.312261]  [<ffffffff8100252b>] system_call_fastpath+0x16/0x1b
> [   58.312261] Code: 0a 48 8b 4b 68 31 d2 48 85 f6 74 04 48 8b 56 40 48 05 18 04 00 00 48 89 de 48 89 04 24 48 c7 c7 48 b0 80 81 31 c0 e8 3e fa 47 00 <0f> 0b eb fe 4c 8b 63 58 4c 39 e3 75 05 45 31 e4 eb 05 f0 41 ff 
> [   58.312261] RIP  [<ffffffff810e7ce8>] shrink_dcache_for_umount_subtree+0x19b/0x27e

Yeah, Sachin reported that against linux-next too (I think - need to
check the exact line numbers):
http://permalink.gmane.org/gmane.linux.file-systems/38148

It seems to have been met with shrugs thus far.
