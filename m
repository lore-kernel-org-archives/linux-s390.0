Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0246F288BD
	for <linux-s390@vger.kernel.org>; Sat,  6 Jul 2024 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720256429; cv=none; b=uDrCnqMN58Pz2FoUou5jM0w7RRHCJZauol5S0QQxB+0+bvHDF2mihtGDKi+hG2FTgsHcOtREbjT1RqHJnclF+5n/gyyo8lLYMNP+G5jgkl+Ej3kK/72XjZJ/i3nXMGdTdi96Ne5CQA1hii6rB2CdkxGDMCZ8yBIQT1IWo9WWHKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720256429; c=relaxed/simple;
	bh=AJFLYaaJwOeMzUWQvlijq7TxFq7HpFwyW4acO7iwA6c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BkfTqSoKrJClAABnL2D7GXWf2qqNOtQu+mbk6U64lgGnTv4i8zoHoR1O5V0CaW94tQxXdYZa6T/AB9+bM1+sLrSak2uyCYercVIhwK0kGksgPLmjLsjZFL26VRHj7cDyxJHbY8d5DXSJqyCMusyra3Rv4S3a6XfqMkykefFc5m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f66b3d69a8so274952239f.2
        for <linux-s390@vger.kernel.org>; Sat, 06 Jul 2024 02:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720256427; x=1720861227;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SRN0lsVUKVhkXUVTNtpdp4+tgBywPGNX0lahnUfn+h8=;
        b=gzLP+KK6U7qTG0WkKkuJNbPtDDU/I2Gv9OsUINRgicShoJi72g/285d0DLxO3L5EET
         1AKcc+rwPcu64id0UXROUoxbUnKHowCPNzVaMf6qe0Kehrlkb7LevfUOP+HgZbY8GIHT
         eoVpjhKsDU6KVI6cIBJU91Ie+JQK3SaIOtRZTgvGeJVAVOpRWwA/zY9iHHldOUvUpcmq
         7Ig7S74UWaAFF4K1ULcEcnE8MmJcntAUIj4BqRZIRVKJYgAG0PWNoszmXWEvuho7pyig
         py+3OEtVsIqPL5/Y9qqysu2DeS7C8d6+aKPZXAxQOgEe3bAK+xnuXRALfc7nlmc1K/dL
         BbzA==
X-Forwarded-Encrypted: i=1; AJvYcCWP+4bIcLtozX3DBtnHw5lCNFrb+U6YEYaGUvFWmQTB2hmcVvS5MV1YpE5Gw/1+ckp527aK3BA6TTI9NwN/49SGv81Cs50u9EfuPQ==
X-Gm-Message-State: AOJu0YwX5Z/5YksZAhGxe3PaOkcEQI5h9vYynbOiSWYMZWrI7PINMmoR
	ymFxtfVLvY+kNOGHuDzx5K52lwPHEHWSJESuRmvUmm4U/vJVXzo3hFv2fkQsf5zWCQU/07kqPiV
	rIqqpBoUbFfhUQFwY4adptaA0CZrgzCRJVoi1P17zNj6TiZRtspW+KGE=
X-Google-Smtp-Source: AGHT+IFstf9W+jGuKjVCziRFwbqkUc0e7I8JgWQLMILX0dzIxieT1A8ljIHLXwLN0mqTuAgl8bnHFkGI23WThbhzrYYPcMtYvZIg
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9825:b0:4b9:26f5:3632 with SMTP id
 8926c6da1cb9f-4bf622c0508mr352305173.6.1720256422322; Sat, 06 Jul 2024
 02:00:22 -0700 (PDT)
Date: Sat, 06 Jul 2024 02:00:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9b248061c90680c@google.com>
Subject: [syzbot] [net?] [s390?] possible deadlock in smc_shutdown
From: syzbot <syzbot+60e37f9e2f4575eab889@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, guwen@linux.alibaba.com, jaka@linux.ibm.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1dfe225e9af5 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14202469980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de2d4dc103148cd6
dashboard link: https://syzkaller.appspot.com/bug?extid=60e37f9e2f4575eab889
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-1dfe225e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a8b8f1ba6ff/vmlinux-1dfe225e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/615b64310209/bzImage-1dfe225e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+60e37f9e2f4575eab889@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc6-syzkaller-00051-g1dfe225e9af5 #0 Not tainted
------------------------------------------------------
syz.1.5756/20250 is trying to acquire lock:
ffff888043bbf058 (sk_lock-AF_SMC){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1602 [inline]
ffff888043bbf058 (sk_lock-AF_SMC){+.+.}-{0:0}, at: smc_shutdown+0x65/0x800 net/smc/af_smc.c:2912

but task is already holding lock:
ffff8880210a2970 (&nsock->tx_lock){+.+.}-{3:3}, at: sock_shutdown+0x16f/0x280 drivers/block/nbd.c:395

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 (&nsock->tx_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       send_disconnects drivers/block/nbd.c:1312 [inline]
       nbd_disconnect+0x321/0x540 drivers/block/nbd.c:1328
       nbd_disconnect_and_put+0x2c/0x170 drivers/block/nbd.c:2155
       nbd_genl_disconnect+0x398/0x570 drivers/block/nbd.c:2200
       genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
       genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
       genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
       netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2564
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
       netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
       netlink_unicast+0x542/0x820 net/netlink/af_netlink.c:1361
       netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1905
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg net/socket.c:745 [inline]
       ____sys_sendmsg+0xab5/0xc90 net/socket.c:2585
       ___sys_sendmsg+0x135/0x1e0 net/socket.c:2639
       __sys_sendmsg+0x117/0x1f0 net/socket.c:2668
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #6 (&nbd->config_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       refcount_dec_and_mutex_lock+0x51/0xe0 lib/refcount.c:118
       nbd_config_put+0x31/0x750 drivers/block/nbd.c:1341
       nbd_release+0xb7/0x190 drivers/block/nbd.c:1653
       blkdev_put_whole+0xad/0xf0 block/bdev.c:673
       bdev_release+0x496/0x6f0 block/bdev.c:1096
       blkdev_release+0x15/0x20 block/fops.c:623
       __fput+0x408/0xbb0 fs/file_table.c:422
       __fput_sync+0x47/0x50 fs/file_table.c:507
       __do_sys_close fs/open.c:1563 [inline]
       __se_sys_close fs/open.c:1548 [inline]
       __x64_sys_close+0x86/0x100 fs/open.c:1548
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&disk->open_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       bdev_open+0x41a/0xe50 block/bdev.c:897
       bdev_file_open_by_dev block/bdev.c:1011 [inline]
       bdev_file_open_by_dev+0x17d/0x210 block/bdev.c:986
       disk_scan_partitions+0x1ed/0x320 block/genhd.c:367
       device_add_disk+0xe97/0x1250 block/genhd.c:510
       pmem_attach_disk+0x9fe/0x1400 drivers/nvdimm/pmem.c:578
       nd_pmem_probe+0x1a9/0x1f0 drivers/nvdimm/pmem.c:651
       nvdimm_bus_probe+0x169/0x5d0 drivers/nvdimm/bus.c:91
       call_driver_probe drivers/base/dd.c:578 [inline]
       really_probe+0x23e/0xa90 drivers/base/dd.c:656
       __driver_probe_device+0x1de/0x440 drivers/base/dd.c:798
       driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:828
       __driver_attach+0x283/0x580 drivers/base/dd.c:1214
       bus_for_each_dev+0x13c/0x1d0 drivers/base/bus.c:368
       bus_add_driver+0x2e9/0x690 drivers/base/bus.c:673
       driver_register+0x15c/0x4b0 drivers/base/driver.c:246
       __nd_driver_register+0x103/0x1a0 drivers/nvdimm/bus.c:619
       do_one_initcall+0x128/0x700 init/main.c:1267
       do_initcall_level init/main.c:1329 [inline]
       do_initcalls init/main.c:1345 [inline]
       do_basic_setup init/main.c:1364 [inline]
       kernel_init_freeable+0x69d/0xca0 init/main.c:1578
       kernel_init+0x1c/0x2b0 init/main.c:1467
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #4 (&nvdimm_namespace_key){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       device_lock include/linux/device.h:1009 [inline]
       uevent_show+0x188/0x3b0 drivers/base/core.c:2743
       dev_attr_show+0x53/0xe0 drivers/base/core.c:2437
       sysfs_kf_seq_show+0x23e/0x410 fs/sysfs/file.c:59
       seq_read_iter+0x4fa/0x12c0 fs/seq_file.c:230
       kernfs_fop_read_iter+0x41a/0x590 fs/kernfs/file.c:279
       new_sync_read fs/read_write.c:395 [inline]
       vfs_read+0x869/0xbd0 fs/read_write.c:476
       ksys_read+0x12f/0x260 fs/read_write.c:619
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (kn->active#5){++++}-{0:0}:
       kernfs_drain+0x48f/0x590 fs/kernfs/dir.c:500
       __kernfs_remove+0x281/0x670 fs/kernfs/dir.c:1486
       kernfs_remove_by_name_ns+0xb2/0x130 fs/kernfs/dir.c:1694
       sysfs_remove_file include/linux/sysfs.h:773 [inline]
       device_remove_file drivers/base/core.c:3061 [inline]
       device_remove_file drivers/base/core.c:3057 [inline]
       device_del+0x381/0x9f0 drivers/base/core.c:3866
       unregister_netdevice_many_notify+0xc8a/0x19f0 net/core/dev.c:11249
       unregister_netdevice_many net/core/dev.c:11277 [inline]
       unregister_netdevice_queue+0x307/0x3f0 net/core/dev.c:11156
       unregister_netdevice include/linux/netdevice.h:3119 [inline]
       unregister_netdev+0x1c/0x30 net/core/dev.c:11295
       gprs_attach+0x4ce/0x5e0 net/phonet/pep-gprs.c:291
       pep_setsockopt+0x419/0x510 net/phonet/pep.c:1031
       do_sock_setsockopt+0x222/0x480 net/socket.c:2312
       __sys_setsockopt+0x1a4/0x270 net/socket.c:2335
       __do_sys_setsockopt net/socket.c:2344 [inline]
       __se_sys_setsockopt net/socket.c:2341 [inline]
       __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2341
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (rtnl_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       do_ipv6_setsockopt+0x2162/0x47b0 net/ipv6/ipv6_sockglue.c:567
       ipv6_setsockopt+0xe3/0x1a0 net/ipv6/ipv6_sockglue.c:994
       tcp_setsockopt+0xa4/0x100 net/ipv4/tcp.c:3765
       smc_setsockopt+0x1b4/0xa00 net/smc/af_smc.c:3063
       do_sock_setsockopt+0x222/0x480 net/socket.c:2312
       __sys_setsockopt+0x1a4/0x270 net/socket.c:2335
       __do_sys_setsockopt net/socket.c:2344 [inline]
       __se_sys_setsockopt net/socket.c:2341 [inline]
       __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2341
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&smc->clcsock_release_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       smc_switch_to_fallback+0x2d/0xa00 net/smc/af_smc.c:893
       smc_sendmsg+0x13d/0x520 net/smc/af_smc.c:2770
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg net/socket.c:745 [inline]
       ____sys_sendmsg+0xab5/0xc90 net/socket.c:2585
       ___sys_sendmsg+0x135/0x1e0 net/socket.c:2639
       __sys_sendmmsg+0x1a1/0x450 net/socket.c:2725
       __do_sys_sendmmsg net/socket.c:2754 [inline]
       __se_sys_sendmmsg net/socket.c:2751 [inline]
       __x64_sys_sendmmsg+0x9c/0x100 net/socket.c:2751
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sk_lock-AF_SMC){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       lock_sock_nested+0x3a/0xf0 net/core/sock.c:3534
       lock_sock include/net/sock.h:1602 [inline]
       smc_shutdown+0x65/0x800 net/smc/af_smc.c:2912
       nbd_mark_nsock_dead+0xae/0x5d0 drivers/block/nbd.c:303
       sock_shutdown+0x17c/0x280 drivers/block/nbd.c:396
       nbd_clear_sock drivers/block/nbd.c:1334 [inline]
       nbd_clear_sock_ioctl drivers/block/nbd.c:1472 [inline]
       __nbd_ioctl drivers/block/nbd.c:1500 [inline]
       nbd_ioctl+0x49b/0xfd0 drivers/block/nbd.c:1560
       blkdev_ioctl+0x27c/0x6e0 block/ioctl.c:676
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:907 [inline]
       __se_sys_ioctl fs/ioctl.c:893 [inline]
       __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  sk_lock-AF_SMC --> &nbd->config_lock --> &nsock->tx_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&nsock->tx_lock);
                               lock(&nbd->config_lock);
                               lock(&nsock->tx_lock);
  lock(sk_lock-AF_SMC);

 *** DEADLOCK ***

2 locks held by syz.1.5756/20250:
 #0: ffff888021dd2198 (&nbd->config_lock){+.+.}-{3:3}, at: nbd_ioctl+0x151/0xfd0 drivers/block/nbd.c:1553
 #1: ffff8880210a2970 (&nsock->tx_lock){+.+.}-{3:3}, at: sock_shutdown+0x16f/0x280 drivers/block/nbd.c:395

stack backtrace:
CPU: 0 PID: 20250 Comm: syz.1.5756 Not tainted 6.10.0-rc6-syzkaller-00051-g1dfe225e9af5 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 lock_sock_nested+0x3a/0xf0 net/core/sock.c:3534
 lock_sock include/net/sock.h:1602 [inline]
 smc_shutdown+0x65/0x800 net/smc/af_smc.c:2912
 nbd_mark_nsock_dead+0xae/0x5d0 drivers/block/nbd.c:303
 sock_shutdown+0x17c/0x280 drivers/block/nbd.c:396
 nbd_clear_sock drivers/block/nbd.c:1334 [inline]
 nbd_clear_sock_ioctl drivers/block/nbd.c:1472 [inline]
 __nbd_ioctl drivers/block/nbd.c:1500 [inline]
 nbd_ioctl+0x49b/0xfd0 drivers/block/nbd.c:1560
 blkdev_ioctl+0x27c/0x6e0 block/ioctl.c:676
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc301975ed9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc302792048 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fc301b04038 RCX: 00007fc301975ed9
RDX: 0000000000000000 RSI: 000000000000ab04 RDI: 0000000000000003
RBP: 00007fc3019e49e5 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fc301b04038 R15: 00007ffc819d5788
 </TASK>
block nbd1: shutting down sockets


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
