Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AE118661A
	for <linux-s390@vger.kernel.org>; Fri, 23 Aug 2024 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724424992; cv=none; b=VeumpOCrF8gAfHsyuqPnF8Mj7Ou+dCj+A5sZMpWpUwBgExLjs1N4q91IkHhtlQIs1m6ytyfwUoS2NPDTeVt0wkg4KsKf+A9Mpa3j4h3O6CoKo8zd3DG9hGrd8vKEXFQ59L4A9m7uRiPSNiHI/mrhPQj7+hsZJt9P2Lo841Tgcmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724424992; c=relaxed/simple;
	bh=PBG/fo/ZzuMN2obgec6R7ccTSjN3rmwSudlkDK5vw3U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lmhAYVNQODxApVh+R1eh9SPsm4j67mR74vPLeBOixDU3VC/NV+WMsF0WFVbIMXLET47L6E1A96W+DRinhhdkNP7GIUNnkKBvYSGWynigj1Zxa7InfQKVuY5D0vO0Xk+XJ41nSuXR7LEvKVZCqs34l1eSXuxPquTsbOdygGiCEao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f8c780fe7so206892639f.1
        for <linux-s390@vger.kernel.org>; Fri, 23 Aug 2024 07:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724424989; x=1725029789;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kWakmjeUKbsCGQWpaHQf09Zozzn9KCzbYPaKAkT/nnY=;
        b=OREa+yrHdT5BTvheZLnSmsl06XH8EU3it8T+Sl+vlPJc3GZiG0jzSosXoXWPc0d1sI
         5yIcsRwVUAomf2Jw2kHB8jvIuRqHhoeLrTy5FBX61Ac0vc3uIIqdy+x4r/S/5djv95Fz
         W+/n6NOozx6Uj+L9j/Yrsm3NWel7a1S4CaGa/WW5Yx4tH4xXe5sT2dmQozR6JouKgOHb
         uFQ45ahVXPbqh8SSRzhvqwDX7XRL/BbYhATg1ky9F2ziDuZ2MG3LmgWhNLxG/3ZgzR+E
         4vJB44uQ3Gz8cdV87GjtK5ADTbdMUzS7a5vxxHWnSPGrCagZC10/KmHwDKu0WUEElf27
         4iJg==
X-Forwarded-Encrypted: i=1; AJvYcCXjRWHm1bKrc/G3ipEMWEpWbflQOP/qJ1zd0xv/tz9j9KGS0k7klOyar2vZRGjiDdNfxb+Hu72RljJk@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsh6p6L9XQdmeDcgCqBK0B47y2aERoDKzZj1MLWCwdeJCfRWGO
	2s5SgNnw44NDUdVS+jjADnND5clDKEUUhKT+FHiAS8NcSCJ0kh7ruz4eV7l9O1wGmVvIJGg/2mv
	+HJLijQs5uw67gRkqIpFEpevm/YnBQrOF860t3iOIRRC5jkpHy2A7d8k=
X-Google-Smtp-Source: AGHT+IErRZjvLvqWdw2ATMI4Nop2JjEZFBrYOYTWhW2bOcfGsKSO01RLDuAVMfiVbZWoVbSuPkfwbJuEgAU0skX2kce5jrdQsJMc
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:60ca:b0:81f:7d7d:89fd with SMTP id
 ca18e2360f4ac-82787310ae9mr8906239f.1.1724424989274; Fri, 23 Aug 2024
 07:56:29 -0700 (PDT)
Date: Fri, 23 Aug 2024 07:56:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed857006205afadd@google.com>
Subject: [syzbot] [net?] [s390?] KASAN: slab-use-after-free Read in __pnet_find_base_ndev
From: syzbot <syzbot+609cda1781277a925661@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, guwen@linux.alibaba.com, jaka@linux.ibm.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0005b2dc43f9 dsa: lan9303: Fix mapping between DSA port nu..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=134be569980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=864caee5f78cab51
dashboard link: https://syzkaller.appspot.com/bug?extid=609cda1781277a925661
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1b9bdee41205/disk-0005b2dc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1a1afb356bc/vmlinux-0005b2dc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/760d9e480146/bzImage-0005b2dc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+609cda1781277a925661@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __pnet_find_base_ndev+0x1ec/0x200 net/smc/smc_pnet.c:929
Read of size 1 at addr ffff88802480035a by task syz.2.421/6341

CPU: 0 PID: 6341 Comm: syz.2.421 Not tainted 6.10.0-rc6-syzkaller-00158-g0005b2dc43f9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __pnet_find_base_ndev+0x1ec/0x200 net/smc/smc_pnet.c:929
 pnet_find_base_ndev net/smc/smc_pnet.c:949 [inline]
 smc_pnet_find_ism_by_pnetid net/smc/smc_pnet.c:1106 [inline]
 smc_pnet_find_ism_resource+0xe9/0x510 net/smc/smc_pnet.c:1157
 smc_find_ism_device net/smc/af_smc.c:1001 [inline]
 smc_find_proposal_devices net/smc/af_smc.c:1086 [inline]
 __smc_connect+0x3b9/0x1890 net/smc/af_smc.c:1523
 smc_connect+0x868/0xde0 net/smc/af_smc.c:1693
 __sys_connect_file net/socket.c:2049 [inline]
 __sys_connect+0x2df/0x310 net/socket.c:2066
 __do_sys_connect net/socket.c:2076 [inline]
 __se_sys_connect net/socket.c:2073 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2073
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3521375bd9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f35221ee048 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f3521503f60 RCX: 00007f3521375bd9
RDX: 000000000000001c RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00007f35213e4aa1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f3521503f60 R15: 00007ffe0c1edc28
 </TASK>

Allocated by task 5093:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4123 [inline]
 __kmalloc_node_noprof+0x22a/0x440 mm/slub.c:4130
 kmalloc_node_noprof include/linux/slab.h:681 [inline]
 kvmalloc_node_noprof+0x72/0x190 mm/util.c:634
 alloc_netdev_mqs+0x9d/0xf80 net/core/dev.c:10949
 rtnl_create_link+0x2f9/0xc20 net/core/rtnetlink.c:3374
 rtnl_newlink_create net/core/rtnetlink.c:3500 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3730 [inline]
 rtnl_newlink+0x1421/0x20a0 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x89b/0x1180 net/core/rtnetlink.c:6635
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 __sys_sendto+0x3a4/0x4f0 net/socket.c:2192
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6345:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4438 [inline]
 kfree+0x149/0x360 mm/slub.c:4559
 device_release+0x99/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 netdev_run_todo+0xe79/0x1000 net/core/dev.c:10700
 vlan_ioctl_handler+0x74f/0x9d0 net/8021q/vlan.c:654
 sock_ioctl+0x683/0x8e0 net/socket.c:1305
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888024800000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 858 bytes inside of
 freed 4096-byte region [ffff888024800000, ffff888024801000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x24800
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff88801504f500 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000001ffffefff 0000000000000000
head: 00fff00000000040 ffff88801504f500 dead000000000122 0000000000000000
head: 0000000000000000 0000000000040004 00000001ffffefff 0000000000000000
head: 00fff00000000003 ffffea0000920001 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd60c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5093, tgid 5093 (syz-executor), ts 82773715896, free_ts 82277130142
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1473
 prep_new_page mm/page_alloc.c:1481 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3425
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4683
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2265
 allocate_slab+0x5a/0x2f0 mm/slub.c:2428
 new_slab mm/slub.c:2481 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3667
 __slab_alloc+0x58/0xa0 mm/slub.c:3757
 __slab_alloc_node mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3990 [inline]
 __do_kmalloc_node mm/slub.c:4122 [inline]
 __kmalloc_node_noprof+0x286/0x440 mm/slub.c:4130
 kmalloc_node_noprof include/linux/slab.h:681 [inline]
 kvmalloc_node_noprof+0x72/0x190 mm/util.c:634
 alloc_netdev_mqs+0x9d/0xf80 net/core/dev.c:10949
 rtnl_create_link+0x2f9/0xc20 net/core/rtnetlink.c:3374
 rtnl_newlink_create net/core/rtnetlink.c:3500 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3730 [inline]
 rtnl_newlink+0x1421/0x20a0 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x89b/0x1180 net/core/rtnetlink.c:6635
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
page last free pid 5102 tgid 5102 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1093 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2588
 discard_slab mm/slub.c:2527 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:2995
 put_cpu_partial+0x17c/0x250 mm/slub.c:3070
 __slab_free+0x2ea/0x3d0 mm/slub.c:4308
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3940 [inline]
 slab_alloc_node mm/slub.c:4002 [inline]
 kmalloc_trace_noprof+0x132/0x2c0 mm/slub.c:4149
 kmalloc_noprof include/linux/slab.h:660 [inline]
 netdevice_queue_work drivers/infiniband/core/roce_gid_mgmt.c:642 [inline]
 netdevice_event+0x37d/0x950 drivers/infiniband/core/roce_gid_mgmt.c:801
 notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
 __netdev_upper_dev_link+0x4c3/0x670 net/core/dev.c:7888
 netdev_master_upper_dev_link+0xb1/0x100 net/core/dev.c:7958
 batadv_hardif_enable_interface+0x26e/0x9f0 net/batman-adv/hard-interface.c:734
 batadv_softif_slave_add+0x79/0xf0 net/batman-adv/soft-interface.c:844
 do_set_master net/core/rtnetlink.c:2701 [inline]
 do_setlink+0xe70/0x41f0 net/core/rtnetlink.c:2907
 __rtnl_newlink net/core/rtnetlink.c:3696 [inline]
 rtnl_newlink+0x180b/0x20a0 net/core/rtnetlink.c:3743

Memory state around the buggy address:
 ffff888024800200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888024800280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888024800300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff888024800380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888024800400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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
