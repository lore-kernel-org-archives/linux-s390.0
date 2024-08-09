Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01321870
	for <linux-s390@vger.kernel.org>; Fri,  9 Aug 2024 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220841; cv=none; b=I4kq+yDIKHIDUurbmP1BJUuYQ09p4N/Et2LcvFKwkV3OPNY5yHDtCSt3uXMUVhQlEsMWN6h5pc5OctVKusi5psAQxPVyLWO7OYQSVwQhDrZiUacDFUGmMujItnhnDnfiqRQ0pbXO55GCTZmlgKCc341weS0Esiu4OBh91um9+cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220841; c=relaxed/simple;
	bh=KmT9S6YnjdLEKW1Btglbp6RJ7wlkQVh3zDswSu2nS0M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QFg9y1d8ouWOivZZl8QmwIq14Uf3169qqWeOOn8Kw6eNrDyneoCO9rHMiLQJOgyNokZ71al4niLvJBDP8y0nsMROga03T/zTm/uyNtk/X5bHNpxfGmYD7JBDT4NAv1azYoF3dNOiMT2BeRXRdSRcETOSP3pFPj3WjqY9jDq8omI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f8d1720ebso261575439f.2
        for <linux-s390@vger.kernel.org>; Fri, 09 Aug 2024 09:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723220839; x=1723825639;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8IoWvVemz5fRuzPVv+MJCIjU8SsZaaUaeY1frfcjMFQ=;
        b=WNTeaWK+Yz52NgRZhU7X+zsAWWR9fnVh5fmGmvF/LI5f1efMUx6grLDIA7mrvJ3ywj
         ZIjeVY3bpQOA00o5gybVLXu79bJBJ9JK9vmrajx30du72+9TiDXwBP+4rdWIXvRlZX66
         Lm2jObqK5LNRTp431kOTyqURSIwl7kNiWJZkIvLARzeCrWa7j+VAfZy4IjSjzgWA31Ts
         P+0rOT2L6Rsi/W/93mt3DR/aJuRshyTwsldSDk6AgzLFKGwR8erMs1FunRPlrPlDHEOu
         mKFF1rJ2F7JYJySSQrmYsAhIPGGTalnMjvBAUIoTjr5v53njwjMe5tcaweR+nOIp4R9a
         Gl9g==
X-Forwarded-Encrypted: i=1; AJvYcCUZ6ZtkPA4w9XD+hcqLQq8H8Rpq5y96oCEiKIpZWlNCUcTjcnXmfvV33majQnax148AssyhMlq+z2zXSfFcUv14f56hq0e8/Vhyow==
X-Gm-Message-State: AOJu0YxYhDlfL8AFphSj9HraL+q3GA042GYfhMC9gnEJ4NIM4IrytKhw
	bYlJSL1t+G2Y99MBU7ro8mdb3B+/Rw5kko826KoW3B54C75sTQvbW+/2n+g/Z1VVB1t0Fj/pa6A
	uXkpiUg6ivES8CWxEQgraG/QisDEt+8iPkUSShjKtfk7x9eOVV7ElYjU=
X-Google-Smtp-Source: AGHT+IEYPB0NcLXMa8rZp5vk5+VX7bqLAv2iGd98rafYrCk99iBVDa/r7lQb6Wz/oPTUODYIbP4PyAhPUr/VcZ6kZANB8tIckK79
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a86:b0:381:c14:70cf with SMTP id
 e9e14a558f8ab-39b7484a7famr1619015ab.1.1723220839017; Fri, 09 Aug 2024
 09:27:19 -0700 (PDT)
Date: Fri, 09 Aug 2024 09:27:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fabef5061f429db7@google.com>
Subject: [syzbot] [net?] [s390?] general protection fault in smc_diag_dump_proto
From: syzbot <syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, guwen@linux.alibaba.com, jaka@linux.ibm.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d7e78951a8b8 Merge tag 'net-6.11-rc0' of git://git.kernel...
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=173cfd3d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6f4e2cb79bdcd45
dashboard link: https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15900a9d980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1008b645980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6b22bae2c3c1/disk-d7e78951.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/37db35e4bb64/vmlinux-d7e78951.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3e489cf2c28e/bzImage-d7e78951.xz

Bisection is inconclusive: the first bad commit could be any of:

5bcd9a0a5995 wifi: brcm80211: remove unused structs
f29dcae96ec8 Merge tag 'rtw-next-2024-06-04' of https://github.com/pkshih/rtw

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17196f19980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 1 PID: 6338 Comm: syz-executor175 Not tainted 6.10.0-syzkaller-09703-gd7e78951a8b8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
RIP: 0010:__smc_diag_dump net/smc/smc_diag.c:89 [inline]
RIP: 0010:smc_diag_dump_proto+0x709/0x3270 net/smc/smc_diag.c:217
Code: 08 48 89 df e8 f8 0d 9d f6 48 8b 44 24 28 4c 8d 68 14 48 8b 1b 48 83 c3 0e 48 89 d8 48 c1 e8 03 49 bf 00 00 00 00 00 fc ff df <42> 0f b6 04 38 84 c0 0f 85 46 1b 00 00 0f b7 1b 66 c1 c3 08 4c 89
RSP: 0018:ffffc90009d56b00 EFLAGS: 00010203
RAX: 0000000000000001 RBX: 000000000000000e RCX: ffff88807c439e00
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: ffffc90009d56f90 R08: ffffffff8990c562 R09: 1ffff11005a1084b
R10: dffffc0000000000 R11: ffffed1005a1084c R12: 1ffff11005a108e0
R13: ffff88801f600014 R14: ffff88802d084200 R15: dffffc0000000000
FS:  00007f92fcb0b6c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f92fcb0bd58 CR3: 000000002290e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 smc_diag_dump+0x59/0xa0 net/smc/smc_diag.c:236
 netlink_dump+0x647/0xd80 net/netlink/af_netlink.c:2325
 __netlink_dump_start+0x59f/0x780 net/netlink/af_netlink.c:2440
 netlink_dump_start include/linux/netlink.h:339 [inline]
 smc_diag_handler_dump+0x1ab/0x250 net/smc/smc_diag.c:251
 sock_diag_rcv_msg+0x3dc/0x5f0
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f0/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 sock_sendmsg+0x134/0x200 net/socket.c:768
 splice_to_socket+0xa13/0x10b0 fs/splice.c:889
 do_splice_from fs/splice.c:941 [inline]
 do_splice+0xd77/0x1900 fs/splice.c:1354
 __do_splice fs/splice.c:1436 [inline]
 __do_sys_splice fs/splice.c:1652 [inline]
 __se_sys_splice+0x331/0x4a0 fs/splice.c:1634
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f92fcb924d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f92fcb0b218 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00007f92fcb0b6c0 RCX: 00007f92fcb924d9
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f92fcc1c348 R08: 0000000080000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f92fcc1c340
R13: 00007f92fcbe9074 R14: 00007ffd7bd61c20 R15: 00007ffd7bd61d08
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
RIP: 0010:__smc_diag_dump net/smc/smc_diag.c:89 [inline]
RIP: 0010:smc_diag_dump_proto+0x709/0x3270 net/smc/smc_diag.c:217
Code: 08 48 89 df e8 f8 0d 9d f6 48 8b 44 24 28 4c 8d 68 14 48 8b 1b 48 83 c3 0e 48 89 d8 48 c1 e8 03 49 bf 00 00 00 00 00 fc ff df <42> 0f b6 04 38 84 c0 0f 85 46 1b 00 00 0f b7 1b 66 c1 c3 08 4c 89
RSP: 0018:ffffc90009d56b00 EFLAGS: 00010203
RAX: 0000000000000001 RBX: 000000000000000e RCX: ffff88807c439e00
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: ffffc90009d56f90 R08: ffffffff8990c562 R09: 1ffff11005a1084b
R10: dffffc0000000000 R11: ffffed1005a1084c R12: 1ffff11005a108e0
R13: ffff88801f600014 R14: ffff88802d084200 R15: dffffc0000000000
FS:  00007f92fcb0b6c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f92fcb0bd58 CR3: 000000002290e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	08 48 89             	or     %cl,-0x77(%rax)
   3:	df e8                	fucomip %st(0),%st
   5:	f8                   	clc
   6:	0d 9d f6 48 8b       	or     $0x8b48f69d,%eax
   b:	44 24 28             	rex.R and $0x28,%al
   e:	4c 8d 68 14          	lea    0x14(%rax),%r13
  12:	48 8b 1b             	mov    (%rbx),%rbx
  15:	48 83 c3 0e          	add    $0xe,%rbx
  19:	48 89 d8             	mov    %rbx,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	49 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%r15
  27:	fc ff df
* 2a:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 46 1b 00 00    	jne    0x1b7d
  37:	0f b7 1b             	movzwl (%rbx),%ebx
  3a:	66 c1 c3 08          	rol    $0x8,%bx
  3e:	4c                   	rex.WR
  3f:	89                   	.byte 0x89


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
