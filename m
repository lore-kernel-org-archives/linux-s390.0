Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDC31EE026
	for <linux-s390@vger.kernel.org>; Thu,  7 Nov 2024 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975970; cv=none; b=PPufhdh7VZNfGEQHbP/yiWO04E1VqgbN8Dp8qR4Zqcjveg4OMphaoT/3ecKBzbzbxEBEJwa+ait+DNDaqf24MdF83hinKGi15ULeCfWmQg3IUxtZvIh7cko9X9UppSNsdvcH5Q5B/aZTJKvG+bxn6NEOF+VyGWCUOgi5t5El2YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975970; c=relaxed/simple;
	bh=MLzx+JeDnin4KjxS0XNHZkKWERWQzXA1Qplg6nmUjsA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UAc0RKkoMJTYpvB1Kyywj9s6IYASUncYxlrNIrI89+H325NQcNxnMD7pZ1cNDrLzQHdi/Urze00WuehrAM+2EYaGoLMfqi94XbzYvDUn6d7P1ghFdUWdFo9RrThYWvWn2f/QyMgfJn2H3sX2AVRqhQ/Of7oOMBoHLAfeXZ5XMqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6b3808522so9738265ab.3
        for <linux-s390@vger.kernel.org>; Thu, 07 Nov 2024 02:39:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730975967; x=1731580767;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQN9lckoQb3NanDRzLgjFs/UoV1SQc1q4bFo9NwFNCY=;
        b=VhvlJPjH6+PIdBGbc4JE2QoN7xH42TGTw+957mphp8gYAXioXTX1zEcCy7VimFjqjr
         yM/gACc/Wxm/cMiyeAktGvCCfdK4rToXhsEIGRtK2A53R1G5SeHRtv03cmlqp+aDbBdE
         zCpvH6TLri4br8FcAjaJRqyfgLd9O1f60UATU8fjTNK3PtcCNq4zv090xgqYCRkm640x
         FjcIBfdCdi7jiELQX4rwmc14E+bUJNr8vU6mTX4Bz7I8PjhRxZlBrjC1E/ow1oJV739O
         P8XWq+pU6zoa36qus84cLIFzhen4aNcgixkl/LE74NEyY4N2MKU3qqvxVE46lfOAsCgR
         X77A==
X-Forwarded-Encrypted: i=1; AJvYcCWJz8BXSxHGFyttO9noPUWaQaJjS9KhQwCSvip6XrQnJqSWhj/TKsbopYnwEB1fsDRbEDYbWE3pstW7@vger.kernel.org
X-Gm-Message-State: AOJu0YxnYdRbslo8+ICfl8rScKHvo1LcMyw+Qt7qkitLb6gHj2BAtDgV
	NB57YsVAvXz8TzvWHEccVGpw6Sp7PK6EMqE7miQ3saRdRPtISslZV28Qsk0iJ0GHYW2IVlRojBS
	LkByuQclw2Cuj7PTpIzhbin+jWc8rEopvjJ7QdWTRDlGkOn2y7RQ1Ih0=
X-Google-Smtp-Source: AGHT+IHXaOZQZEvJJxDXNWHD5YbuTtZWS+RP0YvgGZ6VJKm9wcb0bTO22O92QApZGdYv2RmOVvM0xtff5GF2h4Fc5oGxnfdKznEd
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd86:0:b0:3a3:a307:6851 with SMTP id
 e9e14a558f8ab-3a6b036d665mr261106185ab.22.1730975967624; Thu, 07 Nov 2024
 02:39:27 -0800 (PST)
Date: Thu, 07 Nov 2024 02:39:27 -0800
In-Reply-To: <00000000000060ef65061f8cb3d4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672c98df.050a0220.2dcd8c.0026.GAE@google.com>
Subject: Re: [syzbot] [net?] [s390?] Unable to handle kernel execute from
 non-executable memory at virtual address ADDR
From: syzbot <syzbot+8798e95c2e5511646dac@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, alibuda@linux.alibaba.com, bfoster@redhat.com, 
	davem@davemloft.net, edumazet@google.com, guwen@linux.alibaba.com, 
	horms@kernel.org, jaka@linux.ibm.com, kent.overstreet@linux.dev, 
	kuba@kernel.org, linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, tonylu@linux.alibaba.com, 
	wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    8936d33c1f69 Merge remote-tracking branch 'tip/irq/core' i..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16aaae30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=163d7426d94ed7f
dashboard link: https://syzkaller.appspot.com/bug?extid=8798e95c2e5511646dac
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11aaae30580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1289cd87980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c58cd818af34/disk-8936d33c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c0e687204404/vmlinux-8936d33c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/efc94fae8d41/Image-8936d33c.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8798e95c2e5511646dac@syzkaller.appspotmail.com

netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
Unable to handle kernel execute from non-executable memory at virtual address ffff0000d1080b80
KASAN: maybe wild-memory-access in range [0xfffc000688405c00-0xfffc000688405c07]
Mem abort info:
  ESR = 0x000000008600000f
  EC = 0x21: IABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x0f: level 3 permission fault
swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000001bd31d000
[ffff0000d1080b80] pgd=0000000000000000, p4d=180000023ffff403, pud=180000023f41b403, pmd=180000023f392403, pte=0068000111080707
Internal error: Oops: 000000008600000f [#1] PREEMPT SMP
Modules linked in:
CPU: 1 UID: 0 PID: 6416 Comm: syz-executor278 Not tainted 6.12.0-rc6-syzkaller-g8936d33c1f69 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : 0xffff0000d1080b80
lr : smc_fback_forward_wakeup+0x1dc/0x514 net/smc/af_smc.c:822
sp : ffff8000a3b97140
x29: ffff8000a3b97210 x28: 1fffe00019a901c8 x27: ffff8000a3b97160
x26: dfff800000000000 x25: ffff700014772e2c x24: ffff8000a3b97190
x23: ffff0000cd480e40 x22: ffff0000cd480cc0 x21: ffff0000d1080b80
x20: ffff8000a3b97180 x19: ffff0000dde73040 x18: ffff8000a3b96da0
x17: 000000000000fc8e x16: ffff8000802ae4a0 x15: 0000000000000001
x14: 1fffe0001bbce608 x13: ffff8000a3b98000 x12: 0000000000000003
x11: 0000000000000202 x10: 0000000000000000 x9 : 1fffe000185b0001
x8 : 0000000100000201 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000020 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000003 x1 : ffff80008b626000 x0 : ffff0000cd480cc0
Call trace:
 0xffff0000d1080b80 (P)
 smc_fback_forward_wakeup+0x1dc/0x514 net/smc/af_smc.c:822 (L)
 smc_fback_data_ready+0x88/0xac net/smc/af_smc.c:850
 tcp_data_ready+0x22c/0x44c net/ipv4/tcp_input.c:5220
 tcp_data_queue+0x18a4/0x4eb8 net/ipv4/tcp_input.c:5310
 tcp_rcv_established+0xe10/0x2018 net/ipv4/tcp_input.c:6264
 tcp_v4_do_rcv+0x3b8/0xc44 net/ipv4/tcp_ipv4.c:1915
 sk_backlog_rcv include/net/sock.h:1115 [inline]
 __release_sock+0x1a8/0x3d8 net/core/sock.c:3072
 __sk_flush_backlog+0x38/0xa4 net/core/sock.c:3092
 sk_flush_backlog include/net/sock.h:1178 [inline]
 tcp_sendmsg_locked+0x3118/0x3eb8 net/ipv4/tcp.c:1163
 tcp_sendmsg+0x40/0x64 net/ipv4/tcp.c:1357
 inet_sendmsg+0x15c/0x290 net/ipv4/af_inet.c:853
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg net/socket.c:744 [inline]
 __sys_sendto+0x374/0x4f4 net/socket.c:2214
 __do_sys_sendto net/socket.c:2226 [inline]
 __se_sys_sendto net/socket.c:2222 [inline]
 __arm64_sys_sendto+0xd8/0xf8 net/socket.c:2222
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
Code: 00000000 00000000 00000000 00000000 (00000000) 
---[ end trace 0000000000000000 ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
