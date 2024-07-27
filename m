Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB03186E34
	for <linux-s390@vger.kernel.org>; Sat, 27 Jul 2024 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722102384; cv=none; b=EorxkOljOVOg7WdWHX+aRgvb8BW3TS7TZowgI0egQgtt1SB++2BHQ2YGJgxuYODAwygkPl5cQlr4M6+2KkDsE3U8bcH6+975ZfqeSJzTopq1BW9TVEiaY2cEjuYs9cSE+8+2YSkRMnSHOEvIbsjXjaciTqsZrQG3zsxGUiO4gP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722102384; c=relaxed/simple;
	bh=H1n8/FUosp5p8anYXvKh+X7UEiNvge/fearvUY8uZvc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JHsYuakGSI45xNzkVMw3ZZFraJqkDhj5JPH5feD3OCsmNWQ11v7oGT5kVJjkLinu3uxOSOhFHbT2xpzx+o2s0dOa3ZE6I7Rs9CVBYMEYBRjCIXA2TVcqFwXFBNt3TBgpLnt/S8swemQNxynQK0GnZx0UqCX05O4qb42/p573V7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f901cd3b5so219386339f.1
        for <linux-s390@vger.kernel.org>; Sat, 27 Jul 2024 10:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722102382; x=1722707182;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMdMeoV8Gkz/QuASMOSnjC0t99+ftL/4/W9YdtqQFaw=;
        b=n6f6bbJMWong+qoTjivUSl2paLVHaqs98IhstgN6IbTmkOQmka+SEQjonpZaHCiTGj
         ro5i8NR7N2KXstQANtUCiguC+J+ZdnJ7Njowz7U8QzACuDmWDzuNVupbWN1z47gsQp+3
         3iyEs2h2vSbVphIUYCtHDsNGTpuxR5X18UXt4UuonT3Q0Hua/J5HLcsNjZMAEz4B/khW
         3k06J7zZpHmXb3E0SoiUaGgMTiGmJHCGIeacFfXvilKr159ZROKb3uUnoa9WleJTVRxK
         a43VQZIDZpqwgtPiwSXSLksG/j+ivuG4QxnQ2GyEBVeld/dWtKN6erVBJSQjXeYEqx4W
         JeYg==
X-Forwarded-Encrypted: i=1; AJvYcCWFFRT8J+w+2ABP1fU0aIab2LJJ2moESTxR7Q69hLBUtL+2Ipn5ayN7CD6RNCxb6Xm+V5QVlFd3ZUMViQczYuqF5PLxt7w6nblpEw==
X-Gm-Message-State: AOJu0YxzjY0Yz0KrxUT657CJFCsqLFuuZK/Ta2PCsulhgSlL9rjzbt/7
	XeCpA8yI2rCVu4HVoS0WAX/ZZC18ua1QXIfj/sRf98RUVfADgHVQyFSJmrWFpoKL9BIXTigpmPv
	jHknRMkkSxB90kQqkGLY04BKpug65dJkuovZPbZFeX6Hb7JkcFspjJ7w=
X-Google-Smtp-Source: AGHT+IGo7hg5BZF6IfBarGDUtYjlUa5DsQAHNitfc10BNTuK4WVC5nTkeF+T0N5CIwlD/NIbr3fsboLYPjplyN54HvIT+8Q9pvY2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1452:b0:4c0:838e:9fd1 with SMTP id
 8926c6da1cb9f-4c64c59da0fmr341572173.5.1722102382300; Sat, 27 Jul 2024
 10:46:22 -0700 (PDT)
Date: Sat, 27 Jul 2024 10:46:22 -0700
In-Reply-To: <000000000000ec1f6b061ba43f7d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3a37d061e3e3452@google.com>
Subject: Re: [syzbot] [net?] [s390?] possible deadlock in smc_switch_to_fallback
 (2)
From: syzbot <syzbot+bef85a6996d1737c1a2f@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, guwen@linux.alibaba.com, jaka@linux.ibm.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    1722389b0d86 Merge tag 'net-6.11-rc1' of git://git.kernel...
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10affabd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5efb917b1462a973
dashboard link: https://syzkaller.appspot.com/bug?extid=bef85a6996d1737c1a2f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d70365980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17565655980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f6e80669686a/disk-1722389b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ee658b141f49/vmlinux-1722389b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/35cfa877b1af/bzImage-1722389b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bef85a6996d1737c1a2f@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.10.0-syzkaller-12562-g1722389b0d86 #0 Not tainted
------------------------------------------------------
syz-executor383/5226 is trying to acquire lock:
ffff888022c58a50 (&smc->clcsock_release_lock){+.+.}-{3:3}, at: smc_switch_to_fallback+0x35/0xd00 net/smc/af_smc.c:902

but task is already holding lock:
ffff888022c58258 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1607 [inline]
ffff888022c58258 (sk_lock-AF_INET){+.+.}-{0:0}, at: smc_sendmsg+0x55/0x530 net/smc/af_smc.c:2773

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sk_lock-AF_INET){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       lock_sock_nested+0x48/0x100 net/core/sock.c:3543
       do_ip_setsockopt+0x1a2d/0x3cd0 net/ipv4/ip_sockglue.c:1078
       ip_setsockopt+0x63/0x100 net/ipv4/ip_sockglue.c:1417
       do_sock_setsockopt+0x3af/0x720 net/socket.c:2324
       __sys_setsockopt+0x1ae/0x250 net/socket.c:2347
       __do_sys_setsockopt net/socket.c:2356 [inline]
       __se_sys_setsockopt net/socket.c:2353 [inline]
       __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2353
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (rtnl_mutex){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       start_sync_thread+0xdc/0x2dc0 net/netfilter/ipvs/ip_vs_sync.c:1761
       do_ip_vs_set_ctl+0x442/0x13d0 net/netfilter/ipvs/ip_vs_ctl.c:2732
       nf_setsockopt+0x295/0x2c0 net/netfilter/nf_sockopt.c:101
       smc_setsockopt+0x275/0xe50 net/smc/af_smc.c:3072
       do_sock_setsockopt+0x3af/0x720 net/socket.c:2324
       __sys_setsockopt+0x1ae/0x250 net/socket.c:2347
       __do_sys_setsockopt net/socket.c:2356 [inline]
       __se_sys_setsockopt net/socket.c:2353 [inline]
       __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2353
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&smc->clcsock_release_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
       __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       smc_switch_to_fallback+0x35/0xd00 net/smc/af_smc.c:902
       smc_sendmsg+0x11f/0x530 net/smc/af_smc.c:2779
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:745
       __sys_sendto+0x3a4/0x4f0 net/socket.c:2204
       __do_sys_sendto net/socket.c:2216 [inline]
       __se_sys_sendto net/socket.c:2212 [inline]
       __x64_sys_sendto+0xde/0x100 net/socket.c:2212
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &smc->clcsock_release_lock --> rtnl_mutex --> sk_lock-AF_INET

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sk_lock-AF_INET);
                               lock(rtnl_mutex);
                               lock(sk_lock-AF_INET);
  lock(&smc->clcsock_release_lock);

 *** DEADLOCK ***

1 lock held by syz-executor383/5226:
 #0: ffff888022c58258 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1607 [inline]
 #0: ffff888022c58258 (sk_lock-AF_INET){+.+.}-{0:0}, at: smc_sendmsg+0x55/0x530 net/smc/af_smc.c:2773

stack backtrace:
CPU: 1 UID: 0 PID: 5226 Comm: syz-executor383 Not tainted 6.10.0-syzkaller-12562-g1722389b0d86 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 smc_switch_to_fallback+0x35/0xd00 net/smc/af_smc.c:902
 smc_sendmsg+0x11f/0x530 net/smc/af_smc.c:2779
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 __sys_sendto+0x3a4/0x4f0 net/socket.c:2204
 __do_sys_sendto net/socket.c:2216 [inline]
 __se_sys_sendto net/socket.c:2212 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2212
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1c3ca27ab9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffe06c23b8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1c3ca27ab9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007f1c3ca9a5f0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000200007fd R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
