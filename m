Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
Date: Wed, 08 Aug 2018 00:39:02 -0700
Message-ID: <000000000000bb46000572e79a0f@google.com>
Subject: general protection fault in smc_ioctl (3)
From: syzbot <syzbot+19557374321ca3710990@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Hello,

syzbot found the following crash on:

HEAD commit:    455f05ecd2b2 vsock: split dwork to avoid reinitializations
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=12c50b52400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=152cb8ccd35b1f70
dashboard link: https://syzkaller.appspot.com/bug?extid=19557374321ca3710990
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=11a37822400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c5ebb4400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+19557374321ca3710990@syzkaller.appspotmail.com

TCP: request_sock_TCP: Possible SYN flooding on port 20002. Sending  
cookies.  Check SNMP counters.
TCP: request_sock_TCP: Possible SYN flooding on port 20002. Sending  
cookies.  Check SNMP counters.
TCP: request_sock_TCP: Possible SYN flooding on port 20002. Sending  
cookies.  Check SNMP counters.
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
TCP: request_sock_TCP: Possible SYN flooding on port 20002. Sending  
cookies.  Check SNMP counters.
CPU: 1 PID: 6358 Comm: syz-executor598 Not tainted 4.18.0-rc8+ #47
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:smc_ioctl+0x84c/0xd90 net/smc/af_smc.c:1582
Code: 48 c1 e9 03 80 3c 11 00 0f 85 e8 04 00 00 4c 8b bb a0 04 00 00 48 ba  
00 00 00 00 00 fc ff df 49 8d 7f 20 48 89 f9 48 c1 e9 03 <0f> b6 14 11 84  
d2 74 09 80 fa 03 0f 8e 55 04 00 00 49 8d 7e 02 41
TCP: request_sock_TCP: Possible SYN flooding on port 20002. Sending  
cookies.  Check SNMP counters.
RSP: 0018:ffff8801ca2ef748 EFLAGS: 00010202
RAX: ffff8801ca2ef7c8 RBX: ffff8801c331d100 RCX: 0000000000000004
RDX: dffffc0000000000 RSI: 1ffff1003945def9 RDI: 0000000000000020
RBP: ffff8801ca2ef9b0 R08: ffffed003945defa R09: ffffed003945def9
R10: ffffed003945def9 R11: ffff8801ca2ef7cf R12: 1ffff1003945deed
R13: 0000000020000100 R14: ffff8801ca2ef788 R15: 0000000000000000
FS:  00007f558c065700(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f558c085e78 CR3: 00000001aecfe000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
TCP: request_sock_TCP: Possible SYN flooding on port 20002. Sending  
cookies.  Check SNMP counters.
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
kasan: CONFIG_KASAN_INLINE enabled
  sock_do_ioctl+0xe4/0x3e0 net/socket.c:970
kasan: GPF could be caused by NULL-ptr deref or user memory access
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
RIP: 0033:0x447099
Code: e8 ac e7 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 02 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f558c064db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006dcc38 RCX: 0000000000447099
RDX: 0000000020000100 RSI: 0000000000008905 RDI: 0000000000000004
RBP: 00000000006dcc30 R08: 00007f558c065700 R09: 0000000000000000
R10: 00007f558c065700 R11: 0000000000000246 R12: 00000000006dcc3c
R13: 00007ffd1c69c09f R14: 00007f558c0659c0 R15: 00000000006dcc30
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
general protection fault: 0000 [#2] SMP KASAN
---[ end trace bd327834dcbd920c ]---
CPU: 0 PID: 6373 Comm: syz-executor598 Tainted: G      D            
4.18.0-rc8+ #47
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:smc_ioctl+0x84c/0xd90 net/smc/af_smc.c:1582
RIP: 0010:smc_ioctl+0x84c/0xd90 net/smc/af_smc.c:1582
Code: 48 c1 e9 03 80 3c 11 00
Code:
0f 85 e8 04 00 00 4c
48
8b bb a0 04 00 00
c1
48 ba 00 00 00 00 00
e9
fc ff df 49 8d 7f 20
03
48 89 f9 48 c1 e9 03
80
<0f> b6 14 11 84 d2 74
3c
09 80 fa 03 0f 8e 55
11
04 00 00 49 8d 7e 02
00
41
RSP: 0018:ffff8801ac33f748 EFLAGS: 00010202
RAX: ffff8801ac33f7c8 RBX: ffff8801c331c8c0 RCX: 0000000000000004
RDX: dffffc0000000000 RSI: 1ffff10035867ef9 RDI: 0000000000000020
0f
RBP: ffff8801ac33f9b0 R08: ffffed0035867efa R09: ffffed0035867ef9
R10: ffffed0035867ef9 R11: ffff8801ac33f7cf R12: 1ffff10035867eed
R13: 0000000020000100 R14: ffff8801ac33f788 R15: 0000000000000000
FS:  00007f558c065700(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
85
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004cd8f0 CR3: 00000001ad8e4000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
e8
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  sock_do_ioctl+0xe4/0x3e0 net/socket.c:970
04
00
00
  sock_ioctl+0x30d/0x680 net/socket.c:1094
4c
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:684
8b
bb
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
a0
  __do_sys_ioctl fs/ioctl.c:708 [inline]
  __se_sys_ioctl fs/ioctl.c:706 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
04
00
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
00
RIP: 0033:0x447099
Code: e8 ac e7
48
ff ff 48 83 c4 18 c3 0f 1f 80 00
ba
00 00 00 48 89 f8 48
00
89 f7 48 89 d6 48 89 ca
00
4d 89 c2 4d 89 c8 4c 8b
00
4c 24 08 0f 05 <48> 3d 01 f0
00
ff ff 0f 83 bb 02 fc ff
00
c3 66 2e 0f 1f 84 00 00 00
fc
00
RSP: 002b:00007f558c064db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006dcc38 RCX: 0000000000447099
RDX: 0000000020000100 RSI: 0000000000008905 RDI: 0000000000000004
RBP: 00000000006dcc30 R08: 00007f558c065700 R09: 0000000000000000
ff
R10: 00007f558c065700 R11: 0000000000000246 R12: 00000000006dcc3c
R13: 00007ffd1c69c09f R14: 00007f558c0659c0 R15: 00000000006dcc30
Modules linked in:
df
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace bd327834dcbd920d ]---
49
RIP: 0010:smc_ioctl+0x84c/0xd90 net/smc/af_smc.c:1582
8d
Code:
7f
48
20
c1
48
e9
89
03
f9
80
48
3c
c1
11
e9
00
03
0f
<0f>
85
b6
e8
14
04
11
00
84
00
d2
4c
74
8b
09
bb
80
a0
fa
04
03
00
0f
00
8e
48
55
ba
04
00
00
00
00
00
49
00
8d
00
7e
fc
02
ff
41
df
49
RSP: 0018:ffff8801ca2ef748 EFLAGS: 00010202
8d
7f
RAX: ffff8801ca2ef7c8 RBX: ffff8801c331d100 RCX: 0000000000000004
20 48
RDX: dffffc0000000000 RSI: 1ffff1003945def9 RDI: 0000000000000020
89
RBP: ffff8801ca2ef9b0 R08: ffffed003945defa R09: ffffed003945def9
f9
R10: ffffed003945def9 R11: ffff8801ca2ef7cf R12: 1ffff1003945deed
48
R13: 0000000020000100 R14: ffff8801ca2ef788 R15: 0000000000000000
c1
FS:  00007f558c065700(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
e9
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
03
CR2: 00007f558c085e78 CR3: 00000001aecfe000 CR4: 00000000001406e0
<0f>
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
b6
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
14


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
