Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 Apr 2018 23:40:01 -0700
In-Reply-To: <94eb2c030cc4d2be530566a62109@google.com>
Message-ID: <000000000000fbb72c056a5612fc@google.com>
Subject: Re: general protection fault in smc_getsockopt
From: syzbot <syzbot+28a2c86cf19c81d871fa@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, ubraun@linux.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

syzbot has found reproducer for the following crash on upstream commit
83beed7b2b26f232d782127792dd0cd4362fdc41 (Fri Apr 20 17:56:32 2018 +0000)
Merge branch 'fixes' of  
git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=28a2c86cf19c81d871fa

So far this crash happened 59 times on net-next, upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6375334488309760
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=6112997885870080
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5942131738804224
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=1808800213120130118
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+28a2c86cf19c81d871fa@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed.

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 4492 Comm: syzkaller771634 Not tainted 4.17.0-rc1+ #10
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:smc_getsockopt+0x8b/0x120 net/smc/af_smc.c:1298
RSP: 0018:ffff8801d90b7cc0 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000020000000
RDX: 0000000000000005 RSI: ffffffff873e3d16 RDI: 0000000000000028
RBP: ffff8801d90b7cf0 R08: 0000000020000040 R09: ffffed0036a05800
R10: ffffed0036a05800 R11: ffff8801b502c003 R12: ffff8801d90b7d40
R13: 0000000000000000 R14: 0000000000000008 R15: 0000000020000000
FS:  0000000002017880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 00000001ac552000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __sys_getsockopt+0x1a5/0x370 net/socket.c:1940
  __do_sys_getsockopt net/socket.c:1951 [inline]
  __se_sys_getsockopt net/socket.c:1948 [inline]
  __x64_sys_getsockopt+0xbe/0x150 net/socket.c:1948
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x43fcf9
RSP: 002b:00007ffcb16b9c58 EFLAGS: 00000217 ORIG_RAX: 0000000000000037
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043fcf9
RDX: 0000000000000008 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000020000040 R09: 00000000004002c8
R10: 0000000020000000 R11: 0000000000000217 R12: 0000000000401620
R13: 00000000004016b0 R14: 0000000000000000 R15: 0000000000000000
Code: fa 48 c1 ea 03 80 3c 02 00 0f 85 93 00 00 00 48 8b 9b 50 04 00 00 48  
b8 00 00 00 00 00 fc ff df 48 8d 7b 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00  
75 62 48 b8 00 00 00 00 00 fc ff df 4c 8b 63 28 49
RIP: smc_getsockopt+0x8b/0x120 net/smc/af_smc.c:1298 RSP: ffff8801d90b7cc0
---[ end trace 7e67761582d7c7ee ]---
