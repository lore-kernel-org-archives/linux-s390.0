Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97584212D08
	for <linux-s390@vger.kernel.org>; Thu,  7 Nov 2024 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730989048; cv=none; b=O30bnUGCjFrCqEKWNmXvBrsqjxMA1vuXBVeDLvniSLgFSWPjCupl/GgyuLya3K9tNAjXgb7D5AadW25V6PeqeACrlSGuq5Pe216UNzNeegiTSKzWMfnEACtvZ8M09d4K5/M1EXCdayrbxA+wq5fiX9i9RLz9vH2nos1g9AOGKZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730989048; c=relaxed/simple;
	bh=Jmsjnvo/mYhQC6p51aohBQRVSe8tJbufYbklqjr+kb4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Bcd2BwD+NHEOZSBkYugCFvGdMfLWowdetU5at1bFgWT5nvcNqMBg3VGbVT8yl6vcImhGtK8YSC975kJeyohsGcXidPP0ZJblUqk9x/V3KMIWr2q0CbdbfeA2g+oBV+VAxMrkpJIYFml8E2qNjoXbfIh5oB0YrDtUAChgv09kCtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6bce8a678so11060015ab.1
        for <linux-s390@vger.kernel.org>; Thu, 07 Nov 2024 06:17:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730989046; x=1731593846;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PxSOewJNrcE57wGsLs4ZbSOd88D1xzAGk/SbXSI7wJ8=;
        b=NJnmY7eEVJILaonqyZHONgZz9xU+PGZ3rERx8l7HB7ffi9CZpDzolEsHiKEioMU/xM
         Bs5TFhjqbGdX7Dp//A+j7Uy0/qb4wKLPZtzTW0hVVC1RxwT7UjEiWD2pMgclQT3wL2rz
         m7iNYCQ0zq1F1XqZIJPNY1RNY/NQljzwoTWl7n1LpWTrx+9rJSqtQ0zMwmYFqPt0rjb0
         SCxPMyqrQ20NJE37mb43OzFQzIVtt2719B9px4sxiiJVDmikSrgwIDpsRUSQrTeEKrFT
         hGU3bQgYOcHaLYlQHsBevs0jtjr2c9zRVvVJcOVwHOPuGqLeXXAicEUb3XErWo4c9he4
         wGeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL6580VuhW+g9vLjPBcM9lOABrIMzlyUadFMfpjyxwRl6Fq8cv4G3T0JC4CDTVcVGRoKJXXkNlnusK@vger.kernel.org
X-Gm-Message-State: AOJu0YwMIJhCjvGeXEJuTpVPqQCZpcitiuXmrbZ08/4em48vy6Fi3Ydw
	DMeaLVjipnzkeaRguNbTSvkFxzKYqlH7YL7W+qksPDuE2dk4Ci77VUDg4jrR2BRUdIGRpD3Sn7g
	VHjUKqd3fLHYNL3GVcUSRv8abtcW9lY3o3rDhU/LrXsgTF1QbZjvUKNo=
X-Google-Smtp-Source: AGHT+IGhyMeR1NYKxyYHUkVYHHSy5c8l2ZIoxS9lnMoGNm6PPCmWmfWStIRg7+4grNGm1xsAFSNLjgagDhcLL2kcLC9Ytb9+8Oox
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148e:b0:3a6:b0d0:ee2d with SMTP id
 e9e14a558f8ab-3a6f0945f80mr1451815ab.9.1730989045710; Thu, 07 Nov 2024
 06:17:25 -0800 (PST)
Date: Thu, 07 Nov 2024 06:17:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672ccbf5.050a0220.35fcc6.0034.GAE@google.com>
Subject: [syzbot] [net?] [s390?] general protection fault in __smc_diag_dump (3)
From: syzbot <syzbot+271fed3ed6f24600c364@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, guwen@linux.alibaba.com, jaka@linux.ibm.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c2ee9f594da8 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1480ca5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1673a5aaa7e19b23
dashboard link: https://syzkaller.appspot.com/bug?extid=271fed3ed6f24600c364
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c38287980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b0d0a7980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/df7d94abc0db/disk-c2ee9f59.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1945eac19921/vmlinux-c2ee9f59.xz
kernel image: https://storage.googleapis.com/syzbot-assets/19b610273055/bzImage-c2ee9f59.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+271fed3ed6f24600c364@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000002c03: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: probably user-memory-access in range [0x0000000000016018-0x000000000001601f]
CPU: 1 UID: 0 PID: 5244 Comm: syz-executor189 Not tainted 6.12.0-rc4-syzkaller-00047-gc2ee9f594da8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
RIP: 0010:__smc_diag_dump.constprop.0+0x3e2/0x2500 net/smc/smc_diag.c:89
Code: 4c 8b b3 58 05 00 00 4d 85 f6 0f 84 f6 02 00 00 e8 63 55 d2 f6 49 8d 7e 18 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 86 1c 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
RSP: 0018:ffffc90003467160 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff88802f600000 RCX: ffffffff88fe4534
RDX: 0000000000002c03 RSI: ffffffff8aba62ed RDI: 0000000000016018
RBP: ffff88802f13c5e0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000001 R11: 00000000000a2001 R12: 0000000000000000
R13: ffff888011d50000 R14: 0000000000016000 R15: 0000000000000002
FS:  00007f3a23bc56c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000140 CR3: 0000000029904000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 smc_diag_dump_proto+0x26d/0x420 net/smc/smc_diag.c:217
 smc_diag_dump+0x27/0x90 net/smc/smc_diag.c:234
 netlink_dump+0x552/0xcc0 net/netlink/af_netlink.c:2326
 __netlink_dump_start+0x6d9/0x980 net/netlink/af_netlink.c:2441
 netlink_dump_start include/linux/netlink.h:339 [inline]
 smc_diag_handler_dump+0x1fb/0x240 net/smc/smc_diag.c:251
 __sock_diag_cmd net/core/sock_diag.c:249 [inline]
 sock_diag_rcv_msg+0x437/0x790 net/core/sock_diag.c:287
 netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2551
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg net/socket.c:744 [inline]
 ____sys_sendmsg+0x9ae/0xb40 net/socket.c:2607
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2661
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2690
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3a23c170d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 1f 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3a23bc5238 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f3a23c9b408 RCX: 00007f3a23c170d9
RDX: 000000000400c000 RSI: 0000000020000140 RDI: 0000000000000003
RBP: 00007f3a23c9b400 R08: 00007f3a23bc56c0 R09: 00007f3a23bc56c0
R10: 00007f3a23bc56c0 R11: 0000000000000246 R12: 00007f3a23c9b40c
R13: 0000000000000010 R14: 00007ffe883f4f60 R15: 00007ffe883f5048
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
RIP: 0010:__smc_diag_dump.constprop.0+0x3e2/0x2500 net/smc/smc_diag.c:89
Code: 4c 8b b3 58 05 00 00 4d 85 f6 0f 84 f6 02 00 00 e8 63 55 d2 f6 49 8d 7e 18 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 86 1c 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
RSP: 0018:ffffc90003467160 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff88802f600000 RCX: ffffffff88fe4534
RDX: 0000000000002c03 RSI: ffffffff8aba62ed RDI: 0000000000016018
RBP: ffff88802f13c5e0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000001 R11: 00000000000a2001 R12: 0000000000000000
R13: ffff888011d50000 R14: 0000000000016000 R15: 0000000000000002
FS:  00007f3a23bc56c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000140 CR3: 0000000029904000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	4c 8b b3 58 05 00 00 	mov    0x558(%rbx),%r14
   7:	4d 85 f6             	test   %r14,%r14
   a:	0f 84 f6 02 00 00    	je     0x306
  10:	e8 63 55 d2 f6       	call   0xf6d25578
  15:	49 8d 7e 18          	lea    0x18(%r14),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 86 1c 00 00    	jne    0x1cba
  34:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  3b:	fc ff df
  3e:	4d                   	rex.WRB
  3f:	8b                   	.byte 0x8b


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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
