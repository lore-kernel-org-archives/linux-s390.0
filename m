Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792888538;
	b=Zgaj+pSQ23s5234uuNnZFaRH80hwzw/+/k6GlNE/E6ZwQVM5rE8A35yI72f3V8GYW9XH
	 qDaUAFTNzV7Fdw4nnCuCa3MDA/pzMSoP6UVFve7hhAfSuAks//GbiCb6ubhUAyk+H9LQT
	 LGmOHOXGEhURTmnDJ/eh3dOVcM70D+EtiMvkfiVTYfSWDEFkHm0Fn2gyeE6zDyRJIWY4q
	 Dlq89vgV9cJ3ZBTHqsnlsaphnqZV2U8OmDawoZXO9798vhSap8r3ZyanWO5sD9hXwVEWm
	 MUJygixysz/UIv34HlMdSk5XxFcr37lM/2WyNQ0ugzRnEKnslFDq65L+Jqw6IOFjb6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792888538;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=XSpvoJJOnlwRIHqeOURy97S0PX5mhHQN8lVWg3MejC8=;
	b=DS1N5SReXXu5VE69OHqkuYej/wSu5GW1tzmvQmS/ii6cPaJETLxsv49moIvFG2KQ1GY+
	 58vNs4q2Gu1jpDERaZs3uSamGZ/mylVxyPH4t+Pca1aEC37FBEgx/2XEwcX0rjKoNskDA
	 lgHUbXtW42Ppr+mPI5F4r5eIuJp/w7Ub9FHBhaCIOCHgQVdl1LZ0JFfMJ2Vk85OIRUvqW
	 vdBP5IPJh0JuBkgZXesqnWwIrJ8fB9XmnjODVNcC2TaDgUvxPUdThdUV0oq71qqu8hetf
	 mRd9ns0zxnlK0CjFeUwzmf++E4w0f/8qY/Pw7ebt51DyOu5Yw2HVUHgQsgEslO8r8Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F798606A31A
	for <linux-s390@vger.kernel.org>; Sun, 25 Oct 2026 00:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F798606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4f9b643ae53so1741342b6e.3
        for <linux-s390@vger.kernel.org>; Sat, 24 Oct 2026 17:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792888537; x=1793493337;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XSpvoJJOnlwRIHqeOURy97S0PX5mhHQN8lVWg3MejC8=;
        b=ZwAfeeWIiPBfxTYPcgGpM7eH99utF8vaFDZ24X8L9erlBLkXk/n86OT0wa7rEw2fQl
         6Ikx1lzmRvJD5ISPPUBZUb5Cku/YDg+Il6WhXhBL5vUKhHrt2J2OenEfsciF9OeD9niX
         Shi3wwBzMNNuV1JIr2Gld7g0Q5SSSbE5MpPrzCtJKr7gkMkq+BdEcriPJ527YRdLU8WI
         lbUgo9SsEcKbgSi0csB6fWVUT4TN7Ir5LiQA6nWBPqxlIlAVYxPqL6drBYlu3OTN2Tze
         Gm5TJMtrpqVA38Y2/zg6cg/Tn1ymK7drONCwElCWQR81257yJHp2slCyowNhtEO30Q71
         3NHg==
X-Forwarded-Encrypted: i=1; AKwUvBx0GvIOhxGz6HAUyyEmiXdOBIWup76tARE/s1rNW3cnNEFZKSR0nDSwOfueiRdUTNjnLFdy4Q/B73GO@vger.kernel.org
X-Gm-Message-State: AFq9FYJjQsfI8i2Hj95xGoMUNbJmy44BjgblDGV55VfM0QmZWfSdFmWQ
	nCuQZRrtVqCfQGZUENaVHct1dp7kqmMvu0B0bzrq6+UZf/OzEa2XWlB0c5aWR63QAh06gz8U/y9
	5vhUGewYam3DVGTcZXL6r8CrgygoCHY7wz5+TEHw2nxdjslsLjEzcl09RSC8=
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4f5e:b0:4d6:9232:b3be with SMTP id
 5614622812f47-55c003118a5mr2285739b6e.53.1792888537264; Sat, 24 Oct 2026
 17:35:37 -0700 (PDT)
Date: Sat, 24 Oct 2026 17:35:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6add4ed9.67317f00.38c4bc.0066.GAE@google.com>
Subject: [syzbot] [smc?] possible deadlock in __smc_lgr_terminate
From: syzbot <syzbot+7ea1f5efd5de7e24f1de@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, davem@davemloft.net, dust.li@linux.alibaba.com, 
	edumazet@kernel.org, guwen@linux.alibaba.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, mjambigi@linux.ibm.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sidraya@linux.ibm.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f47d223627f8 Merge tag 'vfs-7.4-rc1.sync_close' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1413290d580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8fd4ba7675545d0
dashboard link: https://syzkaller.appspot.com/bug?extid=7ea1f5efd5de7e24f1de
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/54bd1c4ffe03/disk-f47d2236.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7c7d29f96e65/vmlinux-f47d2236.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6342fb551ce8/bzImage-f47d2236.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7ea1f5efd5de7e24f1de@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
kworker/0:2/7972 is trying to acquire lock:
ffff8880419c3118 (sk_lock-AF_SMC){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1715 [inline]
ffff8880419c3118 (sk_lock-AF_SMC){+.+.}-{0:0}, at: __smc_lgr_terminate+0x19e/0x6a0 net/smc/smc_core.c:1580

but task is already holding lock:
ffff8880326f9298 (sk_lock-AF_SMC){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1715 [inline]
ffff8880326f9298 (sk_lock-AF_SMC){+.+.}-{0:0}, at: smc_listen_work+0x5e/0x1410 net/smc/af_smc.c:2463

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(sk_lock-AF_SMC);
  lock(sk_lock-AF_SMC);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

locks held by kworker/0:2/7972: 3, last CPU#0:
 #0: ffff8880344a4938 ((wq_completion)smc_hs_wq){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff8880344a4938 ((wq_completion)smc_hs_wq){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff8880344a4938 ((wq_completion)smc_hs_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff8880344a4938 ((wq_completion)smc_hs_wq){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc900045ffc40 ((work_completion)(&new_smc->smc_listen_work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc900045ffc40 ((work_completion)(&new_smc->smc_listen_work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc900045ffc40 ((work_completion)(&new_smc->smc_listen_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc900045ffc40 ((work_completion)(&new_smc->smc_listen_work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffff8880326f9298 (sk_lock-AF_SMC){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1715 [inline]
 #2: ffff8880326f9298 (sk_lock-AF_SMC){+.+.}-{0:0}, at: smc_listen_work+0x5e/0x1410 net/smc/af_smc.c:2463

stack backtrace:
CPU: 0 UID: 0 PID: 7972 Comm: kworker/0:2 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/07/2026
Workqueue: smc_hs_wq smc_listen_work
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_deadlock_bug+0x27a/0x290 kernel/locking/lockdep.c:3085
 check_deadlock kernel/locking/lockdep.c:3137 [inline]
 validate_chain kernel/locking/lockdep.c:3939 [inline]
 __lock_acquire+0x25db/0x2de0 kernel/locking/lockdep.c:5288
 lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
 lock_sock_nested+0x41/0x130 net/core/sock.c:3865
 lock_sock include/net/sock.h:1715 [inline]
 __smc_lgr_terminate+0x19e/0x6a0 net/smc/smc_core.c:1580
 smc_conn_abort net/smc/af_smc.c:1019 [inline]
 smc_listen_decline net/smc/af_smc.c:1978 [inline]
 smc_listen_work+0x69e/0x1410 net/smc/af_smc.c:2588
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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
