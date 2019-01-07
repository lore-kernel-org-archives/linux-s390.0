Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: general protection fault in __smc_diag_dump
References: <00000000000060600e057e7748dc@google.com>
 <2ffacbe4-a33a-8e82-a492-711c00b25754@gmail.com>
From: Ursula Braun <ubraun@linux.ibm.com>
Date: Mon, 7 Jan 2019 17:38:06 +0100
MIME-Version: 1.0
In-Reply-To: <2ffacbe4-a33a-8e82-a492-711c00b25754@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <5a0268c3-5f48-9c48-3d0b-422a3a2d81cd@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Eric Dumazet <eric.dumazet@gmail.com>, syzbot <syzbot+5dd1f9327a9ee760048c@syzkaller.appspotmail.com>, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, Cong Wang <xiyou.wangcong@gmail.com>
List-ID: <linux-s390.vger.kernel.org>



On 01/02/2019 12:29 PM, Eric Dumazet wrote:
> 
> 
> On 01/02/2019 02:41 AM, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    28e8c4bc8eb4 Merge tag 'rtc-4.21' of git://git.kernel.org/..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=10c040d3400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c2ab9708c613a224
>> dashboard link: https://syzkaller.appspot.com/bug?extid=5dd1f9327a9ee760048c
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d17880c00000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+5dd1f9327a9ee760048c@syzkaller.appspotmail.com
>>
>> IPv6: ADDRCONF(NETDEV_CHANGE): team0: link becomes ready
>> IPv6: ADDRCONF(NETDEV_UP): vxcan1: link is not ready
>> 8021q: adding VLAN 0 to HW filter on device batadv0
>> kasan: CONFIG_KASAN_INLINE enabled
>> kasan: GPF could be caused by NULL-ptr deref or user memory access
>> general protection fault: 0000 [#1] PREEMPT SMP KASAN
>> CPU: 1 PID: 7982 Comm: syz-executor0 Not tainted 4.20.0+ #4
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:43 [inline]
>> RIP: 0010:__smc_diag_dump.isra.0+0x32a/0x2ba0 net/smc/smc_diag.c:93
>> Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 26 25 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 7f 20 49 8d 7f 0e 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 d2
>> RSP: 0018:ffff88808a29f120 EFLAGS: 00010203
>> RAX: dffffc0000000000 RBX: ffff88807f4d7240 RCX: 0000000000000000
>> RDX: 0000000000000001 RSI: ffffffff87b4e7c2 RDI: 000000000000000e
>> RBP: ffff88808a29f3e8 R08: ffff88808d5721c0 R09: ffff888098960e90
>> R10: fffffbfff14a0020 R11: ffffffff8a500103 R12: ffff88808878d760
>> R13: ffff888098960e40 R14: ffff88807f4d76a0 R15: 0000000000000000
>> FS:  00007f6b83b40700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000000000000 CR3: 0000000095561000 CR4: 00000000001406e0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>  smc_diag_dump_proto.isra.0+0x2e7/0x3c0 net/smc/smc_diag.c:211
>>  smc_diag_dump+0x27/0x80 net/smc/smc_diag.c:225
>>  netlink_dump+0x5f2/0x1070 net/netlink/af_netlink.c:2244
>>  __netlink_dump_start+0x5b4/0x7e0 net/netlink/af_netlink.c:2352
>>  netlink_dump_start include/linux/netlink.h:225 [inline]
>>  smc_diag_handler_dump+0x2a7/0x350 net/smc/smc_diag.c:242
>>  __sock_diag_cmd net/core/sock_diag.c:232 [inline]
>>  sock_diag_rcv_msg+0x322/0x410 net/core/sock_diag.c:263
>>  netlink_rcv_skb+0x17d/0x410 net/netlink/af_netlink.c:2477
>>  sock_diag_rcv+0x2b/0x40 net/core/sock_diag.c:274
>>  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
>>  netlink_unicast+0x574/0x770 net/netlink/af_netlink.c:1336
>>  netlink_sendmsg+0xa05/0xf90 net/netlink/af_netlink.c:1917
>>  sock_sendmsg_nosec net/socket.c:621 [inline]
>>  sock_sendmsg+0xdd/0x130 net/socket.c:631
>>  ___sys_sendmsg+0x7ec/0x910 net/socket.c:2116
>>  __sys_sendmsg+0x112/0x270 net/socket.c:2154
>>  __do_sys_sendmsg net/socket.c:2163 [inline]
>>  __se_sys_sendmsg net/socket.c:2161 [inline]
>>  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
>>  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> RIP: 0033:0x457ec9
>> Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
>> RSP: 002b:00007f6b83b3fc78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
>> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
>> RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000006
>> RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6b83b406d4
>> R13: 00000000004c5188 R14: 00000000004d8a10 R15: 00000000ffffffff
>> Modules linked in:
>> ---[ end trace db4e074cdaa51579 ]---
>> RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:43 [inline]
>> RIP: 0010:__smc_diag_dump.isra.0+0x32a/0x2ba0 net/smc/smc_diag.c:93
>> Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 26 25 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 7f 20 49 8d 7f 0e 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 d2
>> RSP: 0018:ffff88808a29f120 EFLAGS: 00010203
>> RAX: dffffc0000000000 RBX: ffff88807f4d7240 RCX: 0000000000000000
>> RDX: 0000000000000001 RSI: ffffffff87b4e7c2 RDI: 000000000000000e
>> RBP: ffff88808a29f3e8 R08: ffff88808d5721c0 R09: ffff888098960e90
>> R10: fffffbfff14a0020 R11: ffffffff8a500103 R12: ffff88808878d760
>> R13: ffff888098960e40 R14: ffff88807f4d76a0 R15: 0000000000000000
>> FS:  00007f6b83b40700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000000000000 CR3: 0000000095561000 CR4: 00000000001406e0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>
>>
>> ---
>> This bug is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this bug report. See:
>> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
>> syzbot can test patches for this bug, for details see:
>> https://goo.gl/tpsmEJ#testing-patches
> 
> 
> Probable fix would be :
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index c4da4a78d369e359f237772090ff0890a1782c5b..afa1e24fb935281219016c339b15939312f2c89c 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -165,12 +165,12 @@ static int smc_release(struct socket *sock)
>  
>         /* detach socket */
>         sock_orphan(sk);
> -       sock->sk = NULL;
>         if (!smc->use_fallback && sk->sk_state == SMC_CLOSED)
>                 smc_conn_free(&smc->conn);
>         release_sock(sk);
>  
>         sk->sk_prot->unhash(sk);
> +       sock->sk = NULL;
>         sock_put(sk); /* final sock_put */
>  out:
>         return rc;
> 

Cong Wang now comes up with a different patch proposal, which makes sense in my eyes.
