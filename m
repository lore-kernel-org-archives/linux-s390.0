Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AB242AF95
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114943; cv=none; b=lWIex3r+sScrT2Z436jBvsQf4/F3VRausbIj7M3i75Ss00O/UgCADcY2un7uJy4YEGKSVomeigp98PR+ebVT/5OQ/sR1anvHH6HyyA9wp3qNepwKIWqZOFtkwTcIziD+VTlr/ri+HpaYNpZxgRVWzwOzGF3trQuuEpxZ1AWBD/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114943; c=relaxed/simple;
	bh=e+81dOHvj0So3RON92CFdhhmQ3xPUfPVWFr2uruoMWA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=R10e6k2ml3cAfmFskqzTve8HBC0Ae4LNZZ/csRkF3gpAdBr2k6t6v5zaFsu2OnI2LRhSNqYNE9T4GI68kzCVZxxEuTGBtxaJyHvBrFUxTzBPwQAdMyfpxaPyWH32r0EAFT2KvX4/LRjDCDxb74JlUhGZQmPK02ym+O9m8ltgkcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-455e3cdda0dso2969950fac.1
        for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 08:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786114941; x=1786719741;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lqEEJEDiXR1euy6HrUWyog1UErAU/b24emNmEVqWzFU=;
        b=EjsEX5NRfrUxYI3ge5VQdOIifKMcK6v2VXj2hHm0XjFU076keU/7bxx/nshGheyrt0
         HKPtnb6jI4FTqXd7poeWR92a/uHq5j0GM1nkUDXm9t73xDT9CUsGXZlV7N3uSQiOYOSP
         HLzX3y8kmMn1ayrlz8TXOAR7hd5pbVju8vRSnJ7+mqw6cCO49Yzty2pTE73vVmmNns6p
         Glro4QHPITDsVOhxLkVpQ6WFb/u5kfPsb1QirOAlE9GIdujXsLAxFfES4t1eVBBh2Rsb
         HsCwWI++SfI0VW2ddtWGB7m0Da9klufMUCN43QIWTA/HvXey7bAy6YE4dQycs40G6oHi
         h/Bg==
X-Forwarded-Encrypted: i=1; AHgh+Ro3cS5fWAQmyEh1iB5S1BreqSwAGrVyQ9SsoJb3UG8l5XwPhZtwLMnwYGgJ8/wLknECGOU/9CCmI1zu@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/HYB0ApjFmqLRJBAIgxFrvlwPVXjDRhSythia9czGFRsA0+Jc
	RuKEBJRJ2Q4v66QgPPZ3C04zkYCQ/8oImSgQYoQG7UujxNT8RYqaNpAzBfszN47Cjv8mDNpmTYp
	Xhy7oLIh697t5IHFoA3zNY4fhFxve1rEgLPQj3mZKxCbagKYMXmhIaLz/BnQ=
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2083:b0:6aa:9be1:484a with SMTP id
 006d021491bc7-6ae96c10158mr12840974eaf.7.1786114941023; Fri, 07 Aug 2026
 08:02:21 -0700 (PDT)
Date: Fri, 07 Aug 2026 08:02:21 -0700
In-Reply-To: <20260807081606.3200128-1-mjambigi@linux.ibm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a75f37d.b50370da.49fe0.001c.GAE@google.com>
Subject: [syzbot ci] Re: net/smc: fix clcsock and lgr/lnk races in smc_diag
 dump path
From: syzbot ci <syzbot+cia7ddf4f17dfab266@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, andrew@lunn.ch, davem@davemloft.net, 
	dust.li@linux.alibaba.com, edumazet@google.com, guwen@linux.alibaba.com, 
	horms@kernel.org, kuba@kernel.org, linux-s390@vger.kernel.org, 
	mjambigi@linux.ibm.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	pasic@linux.ibm.com, sidraya@linux.ibm.com, tonylu@linux.alibaba.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v3] net/smc: fix clcsock and lgr/lnk races in smc_diag dump path
https://lore.kernel.org/all/20260807081606.3200128-1-mjambigi@linux.ibm.com
* [PATCH net v3] net/smc: fix clcsock and lgr/lnk races in smc_diag dump path

and found the following issue:
WARNING in smc_diag_dump_proto

Full report is available here:
https://ci.syzbot.org/series/ab0d12fd-741a-4a0f-9f49-e52b84e94f4a

***

WARNING in smc_diag_dump_proto

tree:      net
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net.git
base:      594d905195024b228c962627ae5ae7c17bd582a4
arch:      amd64
compiler:  Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
config:    https://ci.syzbot.org/builds/0c4d246f-d098-4afe-b6bc-0f0ad52f55f8/config
syz repro: https://ci.syzbot.org/findings/fa5564b8-8db6-4f76-9d75-dbd796435d87/syz_repro

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: kernel/locking/mutex.c:625 at __mutex_lock_common kernel/locking/mutex.c:625 [inline], CPU#0: syz.0.161/6326
WARNING: kernel/locking/mutex.c:625 at __mutex_lock+0x12d8/0x1550 kernel/locking/mutex.c:821, CPU#0: syz.0.161/6326
Modules linked in:
CPU: 0 UID: 0 PID: 6326 Comm: syz.0.161 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:625 [inline]
RIP: 0010:__mutex_lock+0x12df/0x1550 kernel/locking/mutex.c:821
Code: de 57 90 48 c1 e8 03 0f b6 04 18 84 c0 0f 85 47 02 00 00 83 3d 45 cc 83 04 00 75 13 48 8d 3d a8 1b 87 04 48 c7 c6 40 f7 ec 8b <67> 48 0f b9 3a 90 e9 75 ee ff ff 90 0f 0b 90 e9 48 f2 ff ff 90 0f
RSP: 0018:ffffc900068c6e40 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffff888170ffd940
RDX: 0000000000000000 RSI: ffffffff8becf740 RDI: ffffffff905b2db0
RBP: ffffc900068c6fd0 R08: ffffffff9057de43 R09: 1ffffffff20afbc8
R10: dffffc0000000000 R11: fffffbfff20afbc9 R12: ffff8881b1006648
R13: 0000000000000000 R14: 1ffff92000d18ddc R15: 0000000000000000
FS:  00007f4dacd826c0(0000) GS:ffff88818d945000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000020000000e000 CR3: 0000000171350000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 smc_diag_msg_common_fill net/smc/smc_diag.c:50 [inline]
 __smc_diag_dump net/smc/smc_diag.c:101 [inline]
 smc_diag_dump_proto+0x6d2/0x2620 net/smc/smc_diag.c:255
 smc_diag_dump+0x59/0xa0 net/smc/smc_diag.c:278
 netlink_dump+0x711/0xee0 net/netlink/af_netlink.c:2331
 __netlink_dump_start+0x589/0x7b0 net/netlink/af_netlink.c:2446
 netlink_dump_start include/linux/netlink.h:341 [inline]
 smc_diag_handler_dump+0x199/0x240 net/smc/smc_diag.c:293
 sock_diag_rcv_msg+0x4b0/0x5f0 net/core/sock_diag.c:-1
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x7bb/0x940 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:775
 __sock_sendmsg net/socket.c:790 [inline]
 ____sys_sendmsg+0x54e/0x850 net/socket.c:2684
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2738
 __sys_sendmsg net/socket.c:2770 [inline]
 __do_sys_sendmsg net/socket.c:2775 [inline]
 __se_sys_sendmsg net/socket.c:2773 [inline]
 __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2773
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4dabf9e019
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4dacd82028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f4dac226090 RCX: 00007f4dabf9e019
RDX: 0000000000000600 RSI: 0000200000000540 RDI: 0000000000000003
RBP: 00007f4dac03500c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4dac226128 R14: 00007f4dac226090 R15: 00007ffe0de8ec98
 </TASK>
----------------
Code disassembly (best guess):
   0:	de 57 90             	ficoms -0x70(%rdi)
   3:	48 c1 e8 03          	shr    $0x3,%rax
   7:	0f b6 04 18          	movzbl (%rax,%rbx,1),%eax
   b:	84 c0                	test   %al,%al
   d:	0f 85 47 02 00 00    	jne    0x25a
  13:	83 3d 45 cc 83 04 00 	cmpl   $0x0,0x483cc45(%rip)        # 0x483cc5f
  1a:	75 13                	jne    0x2f
  1c:	48 8d 3d a8 1b 87 04 	lea    0x4871ba8(%rip),%rdi        # 0x4871bcb
  23:	48 c7 c6 40 f7 ec 8b 	mov    $0xffffffff8becf740,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	90                   	nop
  30:	e9 75 ee ff ff       	jmp    0xffffeeaa
  35:	90                   	nop
  36:	0f 0b                	ud2
  38:	90                   	nop
  39:	e9 48 f2 ff ff       	jmp    0xfffff286
  3e:	90                   	nop
  3f:	0f                   	.byte 0xf


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a patch for this bug, please reply with `#syz test`
(should be on a separate line).

The patch should be attached to the email.
Note: arguments like custom git repos and branches are not supported.
