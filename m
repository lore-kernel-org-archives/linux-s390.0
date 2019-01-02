Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
Date: Wed, 02 Jan 2019 02:41:04 -0800
Message-ID: <000000000000644f7e057e7748d6@google.com>
Subject: KASAN: use-after-free Read in __smc_diag_dump
From: syzbot <syzbot+fbd1e5476e4c94c7b34e@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Hello,

syzbot found the following crash on:

HEAD commit:    195303136f19 Merge tag 'kconfig-v4.21-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17fd7ae7400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7dc790609552d7
dashboard link: https://syzkaller.appspot.com/bug?extid=fbd1e5476e4c94c7b34e
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171c1ffb400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fbd1e5476e4c94c7b34e@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): hsr0: link becomes ready
IPv6: ADDRCONF(NETDEV_UP): vxcan1: link is not ready
8021q: adding VLAN 0 to HW filter on device batadv0
==================================================================
BUG: KASAN: use-after-free in smc_diag_msg_common_fill  
net/smc/smc_diag.c:43 [inline]
BUG: KASAN: use-after-free in __smc_diag_dump.isra.4+0x2792/0x2ae0  
net/smc/smc_diag.c:93
Read of size 8 at addr ffff888088679a60 by task syz-executor0/8285

CPU: 0 PID: 8285 Comm: syz-executor0 Not tainted 4.20.0+ #175
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  print_address_description.cold.5+0x9/0x1ff mm/kasan/report.c:187
  kasan_report.cold.6+0x1b/0x39 mm/kasan/report.c:317
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
  smc_diag_msg_common_fill net/smc/smc_diag.c:43 [inline]
  __smc_diag_dump.isra.4+0x2792/0x2ae0 net/smc/smc_diag.c:93
  smc_diag_dump_proto.isra.5+0x2e8/0x3c0 net/smc/smc_diag.c:211
  smc_diag_dump+0x26/0x70 net/smc/smc_diag.c:225
  netlink_dump+0x600/0x1080 net/netlink/af_netlink.c:2244
  __netlink_dump_start+0x59a/0x7c0 net/netlink/af_netlink.c:2352
  netlink_dump_start include/linux/netlink.h:225 [inline]
  smc_diag_handler_dump+0x2a3/0x350 net/smc/smc_diag.c:242
  __sock_diag_cmd net/core/sock_diag.c:232 [inline]
  sock_diag_rcv_msg+0x31d/0x410 net/core/sock_diag.c:263
  netlink_rcv_skb+0x16c/0x430 net/netlink/af_netlink.c:2477
  sock_diag_rcv+0x2a/0x40 net/core/sock_diag.c:274
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x59f/0x750 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457ec9
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f81513c5c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000007
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f81513c66d4
R13: 00000000004c5188 R14: 00000000004d8a10 R15: 00000000ffffffff

Allocated by task 8285:
  save_stack+0x43/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  kasan_kmalloc+0xcb/0xd0 mm/kasan/common.c:482
  kasan_slab_alloc+0x12/0x20 mm/kasan/common.c:397
  kmem_cache_alloc+0x130/0x730 mm/slab.c:3541
  sock_alloc_inode+0x1d/0x260 net/socket.c:244
  alloc_inode+0x63/0x190 fs/inode.c:210
  new_inode_pseudo+0x71/0x1a0 fs/inode.c:906
  sock_alloc+0x41/0x270 net/socket.c:547
  __sock_create+0x175/0x930 net/socket.c:1241
  sock_create_kern+0x3b/0x50 net/socket.c:1323
  smc_create+0x17c/0x3b0 net/smc/af_smc.c:1921
  __sock_create+0x536/0x930 net/socket.c:1277
  sock_create net/socket.c:1317 [inline]
  __sys_socket+0x106/0x260 net/socket.c:1347
  __do_sys_socket net/socket.c:1356 [inline]
  __se_sys_socket net/socket.c:1354 [inline]
  __x64_sys_socket+0x73/0xb0 net/socket.c:1354
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 8284:
  save_stack+0x43/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:444
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:452
  __cache_free mm/slab.c:3485 [inline]
  kmem_cache_free+0x83/0x290 mm/slab.c:3747
  sock_destroy_inode+0x51/0x60 net/socket.c:272
  destroy_inode+0x159/0x200 fs/inode.c:267
  evict+0x5e0/0x980 fs/inode.c:575
  iput_final fs/inode.c:1550 [inline]
  iput+0x679/0xa90 fs/inode.c:1576
  __sock_release+0x1ec/0x250 net/socket.c:590
  sock_release+0x17/0x20 net/socket.c:598
  smc_release+0x297/0x9a0 net/smc/af_smc.c:155
  __sock_release+0xd7/0x250 net/socket.c:579
  sock_close+0x19/0x20 net/socket.c:1141
  __fput+0x385/0xa50 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff888088679a40
  which belongs to the cache sock_inode_cache(17:syz0) of size 976
The buggy address is located 32 bytes inside of
  976-byte region [ffff888088679a40, ffff888088679e10)
The buggy address belongs to the page:
page:ffffea0002219e40 count:1 mapcount:0 mapping:ffff8880a4e00840  
index:0xffff888088679ffd
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea0002218808 ffffea000259adc8 ffff8880a4e00840
raw: ffff888088679ffd ffff888088679140 0000000100000003 ffff88809b2c8580
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff88809b2c8580

Memory state around the buggy address:
  ffff888088679900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff888088679980: 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff888088679a00: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                                        ^
  ffff888088679a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888088679b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
