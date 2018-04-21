Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 21 Apr 2018 04:55:01 -0700
In-Reply-To: <001a1145ecc48d1438056655dcd9@google.com>
Message-ID: <000000000000862602056a5a7937@google.com>
Subject: Re: general protection fault in smc_getname
From: syzbot <syzbot+9605e6cace1b5efd4a0a@syzkaller.appspotmail.com>
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
https://syzkaller.appspot.com/bug?extid=9605e6cace1b5efd4a0a

So far this crash happened 6 times on net-next, upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=4803108223844352
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=6277384739225600
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5836548759093248
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=1808800213120130118
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9605e6cace1b5efd4a0a@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed.

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 4548 Comm: syzkaller769662 Not tainted 4.17.0-rc1+ #10
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:smc_getname+0x124/0x1c0 net/smc/af_smc.c:1089
RSP: 0018:ffff8801ad1d7c20 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff873e3a58
RDX: 0000000000000005 RSI: ffffffff873e3af6 RDI: 0000000000000028
RBP: ffff8801ad1d7c48 R08: ffff8801b10ae280 R09: ffffed0036321370
R10: ffffed0036321370 R11: ffff8801b1909b83 R12: 0000000000000000
R13: ffff8801ad1d7d10 R14: ffff8801a866e0c0 R15: dffffc0000000000
FS:  0000000001a42880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 00000001ac8b3000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __sys_getsockname+0x184/0x380 net/socket.c:1699
  __do_sys_getsockname net/socket.c:1714 [inline]
  __se_sys_getsockname net/socket.c:1711 [inline]
  __x64_sys_getsockname+0x73/0xb0 net/socket.c:1711
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x43fce9
RSP: 002b:00007fff2eba2418 EFLAGS: 00000217 ORIG_RAX: 0000000000000033
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043fce9
RDX: 0000000020000080 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000217 R12: 0000000000401610
R13: 00000000004016a0 R14: 0000000000000000 R15: 0000000000000000
Code: fa 48 c1 ea 03 80 3c 02 00 0f 85 99 00 00 00 48 8b 9b 50 04 00 00 48  
b8 00 00 00 00 00 fc ff df 48 8d 7b 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00  
75 70 48 b8 00 00 00 00 00 fc ff df 4c 8b 73 28 49
RIP: smc_getname+0x124/0x1c0 net/smc/af_smc.c:1089 RSP: ffff8801ad1d7c20
---[ end trace 9f5c3169466d9443 ]---
