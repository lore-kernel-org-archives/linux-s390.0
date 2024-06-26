Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96024149C57
	for <linux-s390@vger.kernel.org>; Wed, 26 Jun 2024 19:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719429328; cv=none; b=kqIKU1Lsyij9oGAtaS/d7FuxJ1Lz+CJYPS6qUegqM2hexCcgiILs9MQZbRT/edWcZ4rf+wTdrxPW+7wCyZTkuW0+HD5BEtTd2CIJLDh9o/QrSqQ/OeFki9mYCtsMgoZ6qMBZI0UXpiggE/S+GIl8oXdUyRkvfjhOGSetJ4zT8i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719429328; c=relaxed/simple;
	bh=LSm1xCieSMiIpu0qWWa37+RueD6pwC0mznN1HsrfFl0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Cx0T4jxlk39zOR18P8SGMvNNWRnfPj+LAj1HHXfXniSYZ3lZQ/o0B+V9k0AuwVrIYgULrdIwzl12eol6G7ogFeiBJ0PH3PcPIapHXG2+hi7tsAsSNfeHTqkAHqTOK9gXe5C9joongLMkLzfqrk7uqHC2gLCH+Q8pO3yfwy3oWlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7f3d5b154f5so71271539f.2
        for <linux-s390@vger.kernel.org>; Wed, 26 Jun 2024 12:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719429326; x=1720034126;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7AYGNY2o7m6l6JhY1sXVIqDWW+rOk3/4SHLTa2tENMw=;
        b=ZcvHmNHMPjPtAm0GqhUtQlxL5ddjsR6q1uPPU5R3H4+xQxmM4F6xdYLgWac5O7jeJK
         uQXtISU4PLygK7mNOiyLk9f7h92v6Rtru4WSaxfBR9tQm/qEQtkWxYSiwZufzJbwbO0H
         joS3w/M4Z31q1nqtc+dkzmM4hwagPehsNAjkOdZXXwf+3Ge8Im0o2hv8VmMiX9S6ZD9n
         mlNNSO+9qTXVbWR2lNMudl436KuVU5/3CvUsCswMCX5e6xxq7ioaCZGUuuql13GBY3TH
         en1qvMCEQrVRkYga8oEZ0irZry30Ac9vcYrV+RTXtfNMniiqiyrnomdIqod3niJvBJ3k
         3EgA==
X-Forwarded-Encrypted: i=1; AJvYcCV56xrG1rcFOduMGNwtiWxMzhp6aW1/UvJ7Vvx69w3/1KwSTDoP15zRu6w8mtrf3Enh2uICkWBzM53aTFXkZZPSMXNh9uK6Fl2pPA==
X-Gm-Message-State: AOJu0YyySfEZoGrrrCh87/l02Kr0tVtIpZwY4BuqfR6PFXgkd68vEmv2
	obyAL+Lydayi8BT+o6mRgwBQ87QeA7+hRkLXEB4yhUT009CQIbZrnhgiUweDbvmHd8Z7wz9+1F6
	FoBEZSiEMogjOcWSB5ktfOnYz47VPs3ODEK9JjNycRAskbY/NhzIbslQ=
X-Google-Smtp-Source: AGHT+IEy4fFZ3c38YV4ociSNyl0fCnmv7SIi92tjC0Fzsyes+Yn1LT+VsHt0eoZWIIHfDM9Qt1mkTNV28Z5QIIEVjZLRmyjgHf3H
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2710:b0:4b9:7607:f7f8 with SMTP id
 8926c6da1cb9f-4b9efd7de6fmr244817173.3.1719429325815; Wed, 26 Jun 2024
 12:15:25 -0700 (PDT)
Date: Wed, 26 Jun 2024 12:15:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002e944b061bcfd65f@google.com>
Subject: [syzbot] [net?] [s390?] possible deadlock in smc_vlan_by_tcpsk
From: syzbot <syzbot+c75d1de73d3b8b76272f@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, guwen@linux.alibaba.com, jaka@linux.ibm.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    185d72112b95 net: xilinx: axienet: Enable multicast by def..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13e0ec8e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=c75d1de73d3b8b76272f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e84f50e44254/disk-185d7211.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/df64b575cc01/vmlinux-185d7211.xz
kernel image: https://storage.googleapis.com/syzbot-assets/16ad5d1d433b/bzImage-185d7211.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c75d1de73d3b8b76272f@syzkaller.appspotmail.com

syz-executor.2[7759] is installing a program with bpf_probe_write_user helper that may corrupt user memory!
syz-executor.2[7759] is installing a program with bpf_probe_write_user helper that may corrupt user memory!
======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc4-syzkaller-00869-g185d72112b95 #0 Not tainted
------------------------------------------------------
syz-executor.2/7759 is trying to acquire lock:
ffffffff8f5e6f48 (rtnl_mutex){+.+.}-{3:3}, at: smc_vlan_by_tcpsk+0x399/0x4e0 net/smc/smc_core.c:1853

but task is already holding lock:
ffff88801bed0258 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1602 [inline]
ffff88801bed0258 (sk_lock-AF_INET6){+.+.}-{0:0}, at: smc_connect+0xb7/0xde0 net/smc/af_smc.c:1650

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (sk_lock-AF_INET6){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       lock_sock_nested+0x48/0x100 net/core/sock.c:3543
       do_ipv6_setsockopt+0xbf3/0x3630 net/ipv6/ipv6_sockglue.c:567
       ipv6_setsockopt+0x5c/0x1a0 net/ipv6/ipv6_sockglue.c:993
       do_sock_setsockopt+0x3af/0x720 net/socket.c:2312
       __sys_setsockopt+0x1ae/0x250 net/socket.c:2335
       __do_sys_setsockopt net/socket.c:2344 [inline]
       __se_sys_setsockopt net/socket.c:2341 [inline]
       __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2341
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (rtnl_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       smc_vlan_by_tcpsk+0x399/0x4e0 net/smc/smc_core.c:1853
       __smc_connect+0x2a4/0x1890 net/smc/af_smc.c:1522
       smc_connect+0x868/0xde0 net/smc/af_smc.c:1702
       __sys_connect_file net/socket.c:2049 [inline]
       __sys_connect+0x2df/0x310 net/socket.c:2066
       __do_sys_connect net/socket.c:2076 [inline]
       __se_sys_connect net/socket.c:2073 [inline]
       __x64_sys_connect+0x7a/0x90 net/socket.c:2073
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sk_lock-AF_INET6);
                               lock(rtnl_mutex);
                               lock(sk_lock-AF_INET6);
  lock(rtnl_mutex);

 *** DEADLOCK ***

1 lock held by syz-executor.2/7759:
 #0: ffff88801bed0258 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1602 [inline]
 #0: ffff88801bed0258 (sk_lock-AF_INET6){+.+.}-{0:0}, at: smc_connect+0xb7/0xde0 net/smc/af_smc.c:1650

stack backtrace:
CPU: 1 PID: 7759 Comm: syz-executor.2 Not tainted 6.10.0-rc4-syzkaller-00869-g185d72112b95 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 smc_vlan_by_tcpsk+0x399/0x4e0 net/smc/smc_core.c:1853
 __smc_connect+0x2a4/0x1890 net/smc/af_smc.c:1522
 smc_connect+0x868/0xde0 net/smc/af_smc.c:1702
 __sys_connect_file net/socket.c:2049 [inline]
 __sys_connect+0x2df/0x310 net/socket.c:2066
 __do_sys_connect net/socket.c:2076 [inline]
 __se_sys_connect net/socket.c:2073 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2073
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0b3687d0a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0b3764b0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f0b369b3f80 RCX: 00007f0b3687d0a9
RDX: 000000000000001c RSI: 00000000200000c0 RDI: 000000000000000a
RBP: 00007f0b368ec074 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f0b369b3f80 R15: 00007fff165a7738
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
