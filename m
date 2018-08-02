Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
Date: Thu, 02 Aug 2018 05:48:02 -0700
Message-ID: <000000000000b9af090572733800@google.com>
Subject: general protection fault in smc_tx_prepared_sends
From: syzbot <syzbot+5b2cece1a8ecb2ca77d8@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Hello,

syzbot found the following crash on:

HEAD commit:    6b4703768268 Merge branch 'fixes' of git://git.armlinux.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d53fc2400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2dc0cd7c2eefb46f
dashboard link: https://syzkaller.appspot.com/bug?extid=5b2cece1a8ecb2ca77d8
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=119fea72400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1775828c400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5b2cece1a8ecb2ca77d8@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
TCP: request_sock_TCP: Possible SYN flooding on port 20002. Sending  
cookies.  Check SNMP counters.
TCP: request_sock_TCP: Possible SYN flooding on port 20002. Sending  
cookies.  Check SNMP counters.
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 0 PID: 6281 Comm: syz-executor186 Not tainted 4.18.0-rc7+ #173
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:smc_tx_prepared_sends+0x2c3/0x550 net/smc/smc_tx.h:27
Code: 48 89 f8 48 c1 e8 03 80 3c 10 00 0f 85 11 02 00 00 48 b8 00 00 00 00  
00 fc ff df 4d 8b 76 38 49 8d 7e 20 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84  
c0 74 08 3c 03 0f 8e de 01 00 00 41 8b 46 20 49 8d
RSP: 0018:ffff8801c8447560 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 1ffff10039088eae RCX: dffffc0000000000
RDX: 0000000000000004 RSI: 1ffff10039088eba RDI: 0000000000000020
RBP: ffff8801c8447738 R08: ffffed0039088ebb R09: ffffed0039088eba
R10: ffffed0039088eba R11: ffff8801c84475d7 R12: ffff8801c8447710
R13: ffff8801c84475d0 R14: 0000000000000000 R15: ffff8801c8447590
FS:  00007fada0c46700(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
TCP: request_sock_TCP: Possible SYN flooding on port 20002. Sending  
cookies.  Check SNMP counters.
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdba80dc7c CR3: 00000001ae829000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
TCP: request_sock_TCP: Possible SYN flooding on port 20002. Sending  
cookies.  Check SNMP counters.
Call Trace:
kasan: CONFIG_KASAN_INLINE enabled
  smc_ioctl+0x36c/0xd90 net/smc/af_smc.c:1565
kasan: GPF could be caused by NULL-ptr deref or user memory access
  sock_do_ioctl+0xe4/0x3e0 net/socket.c:970
  sock_ioctl+0x30d/0x680 net/socket.c:1094
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:684
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  __do_sys_ioctl fs/ioctl.c:708 [inline]
  __se_sys_ioctl fs/ioctl.c:706 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446a09
Code: e8 4c e7 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fada0c45db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006dcc38 RCX: 0000000000446a09
RDX: 0000000020000140 RSI: 000000000000894b RDI: 0000000000000004
RBP: 00000000006dcc30 R08: 00007fada0c46700 R09: 0000000000000000
R10: 00007fada0c46700 R11: 0000000000000246 R12: 00000000006dcc3c
R13: 00007ffdba80e09f R14: 00007fada0c469c0 R15: 00000000006dcc30
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
general protection fault: 0000 [#2] SMP KASAN
---[ end trace 7a16431e05ebb360 ]---
CPU: 1 PID: 6317 Comm: syz-executor186 Tainted: G      D            
4.18.0-rc7+ #173
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:smc_tx_prepared_sends+0x2c3/0x550 net/smc/smc_tx.h:27
RIP: 0010:smc_tx_prepared_sends+0x2c3/0x550 net/smc/smc_tx.h:27
Code: 48 89 f8
Code:
48 c1 e8 03 80
48
3c 10 00 0f 85
89
11 02 00 00
f8
48 b8 00 00
48
00 00 00 fc ff
c1
df 4d 8b 76
e8
38 49 8d 7e 20
03
48 89 fa 48
80
c1 ea 03 <0f>
3c
b6 04 02 84
10
c0 74 08 3c 03
00
0f 8e de 01 00
0f
00 41 8b 46 20
85
49 8d
RSP: 0018:ffff8801c4c0f560 EFLAGS: 00010202
11
RAX: dffffc0000000000 RBX: 1ffff10038981eae RCX: dffffc0000000000
RDX: 0000000000000004 RSI: 1ffff10038981eba RDI: 0000000000000020
RBP: ffff8801c4c0f738 R08: ffffed0038981ebb R09: ffffed0038981eba
02
R10: ffffed0038981eba R11: ffff8801c4c0f5d7 R12: ffff8801c4c0f710
R13: ffff8801c4c0f5d0 R14: 0000000000000000 R15: ffff8801c4c0f590
FS:  00007fada0c46700(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
00
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f723479f9d4 CR3: 00000001b24d0000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
00
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
48
b8
00
00
00
00
00
  smc_ioctl+0x36c/0xd90 net/smc/af_smc.c:1565
fc
  sock_do_ioctl+0xe4/0x3e0 net/socket.c:970
ff
df
4d
8b
  sock_ioctl+0x30d/0x680 net/socket.c:1094
76
38
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:684
49
8d
7e
20
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  __do_sys_ioctl fs/ioctl.c:708 [inline]
  __se_sys_ioctl fs/ioctl.c:706 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
48
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
89
fa
48
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446a09
c1
Code: e8 4c
ea
e7 ff ff 48
03
83 c4 18 c3 0f
<0f>
1f 80 00 00
b6
00 00 48 89
04
f8 48 89 f7
02
48 89 d6 48 89
84
ca 4d 89 c2
c0
4d 89 c8 4c 8b
74
4c 24 08 0f
08
05 <48> 3d 01
3c
f0 ff ff 0f
03
83 3b 08 fc
0f
ff c3 66 2e
8e
0f 1f 84 00 00
de
00 00
RSP: 002b:00007fada0c45db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
01
RAX: ffffffffffffffda RBX: 00000000006dcc38 RCX: 0000000000446a09
RDX: 0000000020000140 RSI: 000000000000894b RDI: 0000000000000004
RBP: 00000000006dcc30 R08: 00007fada0c46700 R09: 0000000000000000
00
R10: 00007fada0c46700 R11: 0000000000000246 R12: 00000000006dcc3c
R13: 00007ffdba80e09f R14: 00007fada0c469c0 R15: 00000000006dcc30
Modules linked in:
00
Dumping ftrace buffer:
    (ftrace buffer empty)
41
---[ end trace 7a16431e05ebb361 ]---
8b
RIP: 0010:smc_tx_prepared_sends+0x2c3/0x550 net/smc/smc_tx.h:27
46 20
Code:
49 8d
48
RSP: 0018:ffff8801c8447560 EFLAGS: 00010202
89
RAX: dffffc0000000000 RBX: 1ffff10039088eae RCX: dffffc0000000000
RDX: 0000000000000004 RSI: 1ffff10039088eba RDI: 0000000000000020
f8
RBP: ffff8801c8447738 R08: ffffed0039088ebb R09: ffffed0039088eba
R10: ffffed0039088eba R11: ffff8801c84475d7 R12: ffff8801c8447710
48
R13: ffff8801c84475d0 R14: 0000000000000000 R15: ffff8801c8447590
FS:  00007fada0c46700(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
c1
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdba80dc7c CR3: 00000001ae829000 CR4: 00000000001406f0
e8
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
03


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
