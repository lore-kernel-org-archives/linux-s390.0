Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 25 Mar 2018 17:01:02 -0700
Message-ID: <001a113f9bb83e4d560568457853@google.com>
Subject: BUG: unable to handle kernel paging request in smc_ib_remember_port_attr
From: syzbot <syzbot+5cd61039dc9b8bfa6e47@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Hello,

syzbot hit the following crash on upstream commit
bcfc1f4554662d8f2429ac8bd96064a59c149754 (Sat Mar 24 16:50:12 2018 +0000)
Merge tag 'pinctrl-v4.16-3' of  
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=5cd61039dc9b8bfa6e47

So far this crash happened 5 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=4566822275776512
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5414431521505280
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5642358322364416
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-5034017172441945317
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5cd61039dc9b8bfa6e47@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

BUG: unable to handle kernel paging request at fffffc0000000000
IP: bytes_is_nonzero mm/kasan/kasan.c:166 [inline]
IP: memory_is_nonzero mm/kasan/kasan.c:184 [inline]
IP: memory_is_poisoned_n mm/kasan/kasan.c:210 [inline]
IP: memory_is_poisoned mm/kasan/kasan.c:241 [inline]
IP: check_memory_region_inline mm/kasan/kasan.c:257 [inline]
IP: check_memory_region+0x83/0x190 mm/kasan/kasan.c:267
PGD 0 P4D 0
Oops: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 4138 Comm: syzkaller407129 Not tainted 4.16.0-rc6+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bytes_is_nonzero mm/kasan/kasan.c:166 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/kasan.c:184 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/kasan.c:210 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/kasan.c:241 [inline]
RIP: 0010:check_memory_region_inline mm/kasan/kasan.c:257 [inline]
RIP: 0010:check_memory_region+0x83/0x190 mm/kasan/kasan.c:267
RSP: 0018:ffff8801b8c472e0 EFLAGS: 00010282
RAX: fffffc0000000000 RBX: 0000000000000017 RCX: ffffffff85a53701
RDX: 0000000000000001 RSI: 0000000000000040 RDI: ffffffffffffffd8
RBP: ffff8801b8c472f0 R08: fffffc0000000001 R09: dffffc0000000003
R10: e000000000000008 R11: dffffc0000000002 R12: dffffc0000000003
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffffffffffd8
FS:  0000000000a75880(0000) GS:ffff8801db200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffc0000000000 CR3: 00000001ceb8a001 CR4: 00000000001606f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  memset+0x23/0x40 mm/kasan/kasan.c:285
  memset include/linux/string.h:330 [inline]
  smc_ib_remember_port_attr+0x91/0x340 net/smc/smc_ib.c:419
  smc_pnet_add+0xb43/0xde0 net/smc/smc_pnet.c:354
  genl_family_rcv_msg+0x7b7/0xfb0 net/netlink/genetlink.c:599
  genl_rcv_msg+0xb2/0x140 net/netlink/genetlink.c:624
  netlink_rcv_skb+0x14b/0x380 net/netlink/af_netlink.c:2444
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:635
  netlink_unicast_kernel net/netlink/af_netlink.c:1308 [inline]
  netlink_unicast+0x4c4/0x6b0 net/netlink/af_netlink.c:1334
  netlink_sendmsg+0xa4a/0xe60 net/netlink/af_netlink.c:1897
  sock_sendmsg_nosec net/socket.c:630 [inline]
  sock_sendmsg+0xca/0x110 net/socket.c:640
  ___sys_sendmsg+0x767/0x8b0 net/socket.c:2046
  __sys_sendmsg+0xe5/0x210 net/socket.c:2080
  SYSC_sendmsg net/socket.c:2091 [inline]
  SyS_sendmsg+0x2d/0x50 net/socket.c:2087
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x43fda9
RSP: 002b:00007ffd35aa5268 EFLAGS: 00000213 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043fda9
RDX: 0000000000040004 RSI: 0000000020a87fc8 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000213 R12: 00000000004016d0
R13: 0000000000401760 R14: 0000000000000000 R15: 0000000000000000
Code: fa 10 7f 3d 4d 85 d2 74 33 41 80 39 00 75 21 48 b8 01 00 00 00 00 fc  
ff df 4d 01 d1 49 01 c0 4d 39 c1 4c 89 c0 74 15 49 83 c0 01 <80> 38 00 74  
ef 48 85 c0 49 89 c0 0f 85 89 00 00 00 5b 41 5c 5d
RIP: bytes_is_nonzero mm/kasan/kasan.c:166 [inline] RSP: ffff8801b8c472e0
RIP: memory_is_nonzero mm/kasan/kasan.c:184 [inline] RSP: ffff8801b8c472e0
RIP: memory_is_poisoned_n mm/kasan/kasan.c:210 [inline] RSP:  
ffff8801b8c472e0
RIP: memory_is_poisoned mm/kasan/kasan.c:241 [inline] RSP: ffff8801b8c472e0
RIP: check_memory_region_inline mm/kasan/kasan.c:257 [inline] RSP:  
ffff8801b8c472e0
RIP: check_memory_region+0x83/0x190 mm/kasan/kasan.c:267 RSP:  
ffff8801b8c472e0
CR2: fffffc0000000000
---[ end trace 327b8c6e0903b0d7 ]---


---
This bug is generated by a dumb bot. It may contain errors.
See https://goo.gl/tpsmEJ for details.
Direct all questions to syzkaller@googlegroups.com.

syzbot will keep track of this bug report.
If you forgot to add the Reported-by tag, once the fix for this bug is  
merged
into any tree, please reply to this email with:
#syz fix: exact-commit-title
If you want to test a patch for this bug, please reply with:
#syz test: git://repo/address.git branch
and provide the patch inline or as an attachment.
To mark this as a duplicate of another syzbot report, please reply with:
#syz dup: exact-subject-of-another-report
If it's a one-off invalid bug report, please reply with:
#syz invalid
Note: if the crash happens again, it will cause creation of a new bug  
report.
Note: all commands must start from beginning of the line in the email body.
