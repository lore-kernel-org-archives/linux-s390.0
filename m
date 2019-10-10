Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:22761 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfJJCgX (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 9 Oct 2019 22:36:23 -0400
Date: Thu, 10 Oct 2019 10:36:01 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: "reuse mergeable anon_vma as parent when fork" causes a crash on
 s390
Message-ID: <20191010023601.GA4793@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <1570656570.5937.24.camel@lca.pw>
 <CALvZod4psOEyYwPOF1UcJoK96LbYBccYhsG0DrKD+CCf8Sc-Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4psOEyYwPOF1UcJoK96LbYBccYhsG0DrKD+CCf8Sc-Yg@mail.gmail.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Shakeel Butt <shakeelb@google.com>
Cc: Qian Cai <cai@lca.pw>, Wei Yang <richardw.yang@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Rik van Riel <riel@surriel.com>, Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

Hi, Qian, Shakeel

Thanks for testing.

Sounds I missed some case to handle. anon_vma_clone() now would be called in
vma_adjust, which is a different case when it is introduced.

BTW, do you have the specific test case? So that I could verify my change. The
kernel build test doesn't trigger this.

Thanks a lot :-)

On Wed, Oct 09, 2019 at 03:21:11PM -0700, Shakeel Butt wrote:
>On Wed, Oct 9, 2019 at 2:30 PM Qian Cai <cai@lca.pw> wrote:
>>
>> The linux-next commit "mm/rmap.c: reuse mergeable anon_vma as parent when fork"
>> [1] causes a crash on s390 while compiling some C code. Reverted it fixes the
>> issue.
>>
>> [1] https://lore.kernel.org/lkml/20191004160632.30251-1-richardw.yang@linux.intel.com/
>>
>> 00: [  330.681233] vma 0000000049a08008 start 000003ff8ee7f000 end 000003ff8eee4
>> 00: 000
>> 00: [  330.681233] next 000000004f272008 prev 0000000065c84230 mm 0000000037d1c1
>> 00: 00
>> 00: [  330.681233] prot 711 anon_vma 000000001f4e4a80 vm_ops 0000000000000000
>> 00: [  330.681233] pgoff 3ff8ee7f file 0000000000000000 private_data 00000000000
>> 00: 00000
>> 00: [  330.681233] flags: 0x8100073(read|write|mayread|maywrite|mayexec|account|
>> 00: softdirty)
>> 00: [  330.681344] ------------[ cut here ]------------
>> 00: [  330.681357] kernel BUG at include/linux/rmap.h:159!
>> 00: [  330.681442] illegal operation: 0001 ilc:1 [#1] SMP DEBUG_PAGEALLOC
>> 00: [  330.681460] Modules linked in: ip_tables x_tables xfs dasd_fba_mod dasd_e
>> 00: ckd_mod dm_mirror dm_region_hash dm_log dm_mod
>> 00: [  330.681502] CPU: 0 PID: 7651 Comm: cc1 Not tainted 5.4.0-rc2-next-2019100
>> 00: 9+ #4
>> 00: [  330.681516] Hardware name: IBM 2964 N96 400 (z/VM 6.4.0)
>> 00: [  330.681530] Krnl PSW : 0704c00180000000 00000000531d9cac (__vma_adjust+0x
>> 00: cf4/0xf30)
>> 00: [  330.681561]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0
>> 00:  RI:0 EA:3
>> 00: [  330.681579] Krnl GPRS: 0000000000000001 0000030000000000 0000000000000146
>> 00:  000000006cc03da4
>> 00: [  330.681595]            0000030000000000 000000005304378c 00000000513de008
>> 00:  0000000000000000
>> 00: [  330.681611]            0000000049a08008 0000000049a08080 0000000000000000
>> 00:  000000005a178438
>> 00: [  330.681627]            0000000053bae3b0 0000000037d1c100 00000000531d9ca8
>> 00:  00000000235ef880
>> 01: HCPGSP2629I The virtual machine is placed in CP mode due to a SIGP stop from
>>  CPU 01.
>> 01: HCPGSP2629I The virtual machine is placed in CP mode due to a SIGP stop from
>>  CPU 00.
>> 00: [  330.681668] Krnl Code: 00000000531d9c9c: fae0b9040028        ap      2308
>> 00: (15,%r11),40(1,%r0)
>> 00: [  330.681668]            00000000531d9ca2: c0e5ffff145f        brasl   %r14
>> 00: ,531bc560
>> 00: [  330.681668]           #00000000531d9ca8: a7f40001            brc     15,5
>> 00: 31d9caa
>> 00: [  330.681668]           >00000000531d9cac: c020005f1a5a        larl    %r2,
>> 00: 53dbd160
>> 00: [  330.681668]            00000000531d9cb2: c0e50015ec2b        brasl   %r14
>> 00: ,53497508
>> 00: [  330.681668]            00000000531d9cb8: e320f0d80004        lg      %r2,
>> 00: 216(%r15)
>> 00: [  330.681668]            00000000531d9cbe: c0e500040de1        brasl   %r14
>> 00: ,5325b880
>> 00: [  330.681668]            00000000531d9cc4: 4120d038            la      %r2,
>> 00: 56(%r13)
>> 00: [  330.682579] Call Trace:
>> 00: [  330.682665] ([<00000000531d9ca8>] __vma_adjust+0xcf0/0xf30)
>> 00: [  330.682684]  [<00000000531da4f0>] vma_merge+0x608/0x6b8
>> 00: [  330.682699]  [<00000000531de3b8>] mmap_region+0x1e0/0x9b0
>> 00: [  330.682713]  [<00000000531defec>] do_mmap+0x464/0x650
>> 00: [  330.682730]  [<00000000531930ba>] vm_mmap_pgoff+0x132/0x1c0
>> 00: [  330.682745]  [<00000000531da7b4>] ksys_mmap_pgoff+0xd4/0x458
>> 00: [  330.682761]  [<00000000531dac54>] __s390x_sys_old_mmap+0xdc/0x108
>> 00: [  330.682779]  [<00000000537dcdd0>] system_call+0xd8/0x2b4
>> 00: [  330.682791] INFO: lockdep is turned off.
>> 00: [  330.682801] Last Breaking-Event-Address:
>> 00: [  330.682815]  [<00000000531d9ca8>] __vma_adjust+0xcf0/0xf30
>> 00: [  330.682833] Kernel panic - not syncing: Fatal exception: panic_on_oops
>
>Our internal syzbot instance also hit this bug and bisected to the same patch.
>
>Report:
>
>[   74.249839][ T8601] vma ffff88808c0f7eb0 start 0000000020000000 end
>0000000021000000
>[   74.249839][ T8601] next ffff888095f5e568 prev ffff888091279318 mm
>ffff8880894555c0
>[   74.249839][ T8601] prot 25 anon_vma ffff88809a9c4b40 vm_ops 0000000000000000
>[   74.249839][ T8601] pgoff 20000 file 0000000000000000 private_data
>0000000000000000
>[   74.249839][ T8601] flags:
>0x8100077(read|write|exec|mayread|maywrite|mayexec|account|softdirty)
>[   74.289454][ T8601] ------------[ cut here ]------------
>[   74.294941][ T8601] kernel BUG at include/linux/rmap.h:159!
>[   74.301474][ T8601] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>[   74.307549][ T8601] CPU: 0 PID: 8601 Comm: syz-executor.0 Not
>tainted 5.4.0-rc2-next-20191008 #0
>[   74.316453][ T8601] Hardware name: Google Google Compute
>Engine/Google Compute Engine, BIOS Google 01/01/2011
>[   74.327161][ T8601] RIP: 0010:__vma_adjust+0x151c/0x1cc0
>[   74.332604][ T8601] Code: 4c 89 ee 4c 89 f7 e8 b3 01 d2 ff 4d 39 ee
>0f 82 1b fe ff ff 45 31 ed e9 1b fe ff ff e8 7d 00 d2 ff 48 8b 7d c8
>e8 76 62 fc ff <0f> 0b e8 6d 00 d2 ff 48 8b 85 68 ff ff ff 80 38 00 0f
>85 20 07 00
>[   74.352189][ T8601] RSP: 0018:ffff8880a0e9f9c0 EFLAGS: 00010286
>[   74.358232][ T8601] RAX: 0000000000000147 RBX: dffffc0000000000
>RCX: 0000000000000000
>[   74.366180][ T8601] RDX: 0000000000000000 RSI: ffffffff815cb676
>RDI: ffffed10141d3f12
>[   74.374126][ T8601] RBP: ffff8880a0e9fa88 R08: 0000000000000147
>R09: ffffed1015d06161
>[   74.382076][ T8601] R10: ffffed1015d06160 R11: ffff8880ae830b07
>R12: ffff888095f28e10
>[   74.390054][ T8601] R13: ffff88808c0f7f18 R14: 0000000000000000
>R15: 0000000000000001
>[   74.398014][ T8601] FS:  0000000000c57940(0000)
>GS:ffff8880ae800000(0000) knlGS:0000000000000000
>[   74.406918][ T8601] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>[   74.413491][ T8601] CR2: 0000000020d06000 CR3: 0000000090f89000
>CR4: 00000000001406f0
>[   74.421447][ T8601] DR0: 0000000000000000 DR1: 0000000000000000
>DR2: 0000000000000000
>[   74.429403][ T8601] DR3: 0000000000000000 DR6: 00000000fffe0ff0
>DR7: 0000000000000400
>[   74.437348][ T8601] Call Trace:
>[   74.440625][ T8601]  vma_merge+0xb8a/0xe60
>[   74.444848][ T8601]  ? __vma_adjust+0x1cc0/0x1cc0
>[   74.449677][ T8601]  ? __sanitizer_cov_trace_cmp8+0x18/0x20
>[   74.455369][ T8601]  ? __vm_enough_memory+0x1b7/0x390
>[   74.460542][ T8601]  mmap_region+0x3e0/0x1760
>[   74.465025][ T8601]  ? __x64_sys_brk+0x760/0x760
>[   74.469766][ T8601]  ? __sanitizer_cov_trace_const_cmp8+0x18/0x20
>[   74.475991][ T8601]  ? get_unmapped_area+0x2ad/0x3d0
>[   74.481075][ T8601]  do_mmap+0x853/0x1190
>[   74.485216][ T8601]  vm_mmap_pgoff+0x1c5/0x230
>[   74.489784][ T8601]  ? randomize_stack_top+0x110/0x110
>[   74.495044][ T8601]  ? __kasan_check_read+0x11/0x20
>[   74.500042][ T8601]  ? _copy_to_user+0x118/0x160
>[   74.504782][ T8601]  ? __sanitizer_cov_trace_const_cmp8+0x18/0x20
>[   74.511007][ T8601]  ksys_mmap_pgoff+0xf7/0x630
>[   74.515662][ T8601]  ? find_mergeable_anon_vma+0x2e0/0x2e0
>[   74.521295][ T8601]  ? trace_hardirqs_on_thunk+0x1a/0x20
>[   74.526735][ T8601]  ? trace_hardirqs_on_thunk+0x1a/0x20
>[   74.532181][ T8601]  ? do_syscall_64+0x26/0x760
>[   74.536835][ T8601]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
>[   74.542881][ T8601]  __x64_sys_mmap+0xe9/0x1b0
>[   74.547448][ T8601]  do_syscall_64+0xfa/0x760
>[   74.551928][ T8601]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>[   74.557796][ T8601] RIP: 0033:0x459a59
>[   74.561682][ T8601] Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
>00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
>4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84
>00 00 00 00
>[   74.581261][ T8601] RSP: 002b:00007ffcc91b5068 EFLAGS: 00000246
>ORIG_RAX: 0000000000000009
>[   74.589731][ T8601] RAX: ffffffffffffffda RBX: 0000000000000006
>RCX: 0000000000459a59
>[   74.597685][ T8601] RDX: ffffffffefffffff RSI: 0000000000004000
>RDI: 0000000020196000
>[   74.605632][ T8601] RBP: 000000000075bf20 R08: ffffffffffffffff
>R09: 0000000000000000
>[   74.613580][ T8601] R10: 0000000000008032 R11: 0000000000000246
>R12: 0000000000c57914
>[   74.621527][ T8601] R13: 00000000004c6176 R14: 00000000004db118
>R15: 00000000ffffffff
>[   74.629486][ T8601] Modules linked in:
>[   74.636716][ T8601] ---[ end trace aa2e499bc1c6fb5e ]---
>[   74.642235][ T8601] RIP: 0010:__vma_adjust+0x151c/0x1cc0
>[   74.647787][ T8601] Code: 4c 89 ee 4c 89 f7 e8 b3 01 d2 ff 4d 39 ee
>0f 82 1b fe ff ff 45 31 ed e9 1b fe ff ff e8 7d 00 d2 ff 48 8b 7d c8
>e8 76 62 fc ff <0f> 0b e8 6d 00 d2 ff 48 8b 85 68 ff ff ff 80 38 00 0f
>85 20 07 00
>[   74.667752][ T8601] RSP: 0018:ffff8880a0e9f9c0 EFLAGS: 00010286
>[   74.673806][ T8601] RAX: 0000000000000147 RBX: dffffc0000000000
>RCX: 0000000000000000
>[   74.681794][ T8601] RDX: 0000000000000000 RSI: ffffffff815cb676
>RDI: ffffed10141d3f12
>[   74.689779][ T8601] RBP: ffff8880a0e9fa88 R08: 0000000000000147
>R09: ffffed1015d06161
>[   74.698081][ T8601] R10: ffffed1015d06160 R11: ffff8880ae830b07
>R12: ffff888095f28e10
>[   74.706052][ T8601] R13: ffff88808c0f7f18 R14: 0000000000000000
>R15: 0000000000000001
>[   74.714061][ T8601] FS:  0000000000c57940(0000)
>GS:ffff8880ae800000(0000) knlGS:0000000000000000
>[   74.723209][ T8601] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>[   74.729820][ T8601] CR2: 0000000020d06000 CR3: 0000000090f89000
>CR4: 00000000001406f0
>[   74.738021][ T8601] DR0: 0000000000000000 DR1: 0000000000000000
>DR2: 0000000000000000
>[   74.745972][ T8601] DR3: 0000000000000000 DR6: 00000000fffe0ff0
>DR7: 0000000000000400
>[   74.753968][ T8601] Kernel panic - not syncing: Fatal exception
>
>
>Syzbot reproducer:
>mmap(&(0x7f0000196000/0x4000)=nil, 0x4000, PROT_NONE, 0x4032 /* flags=
>MAP_NORESERVE|MAP_ANONYMOUS|MAP_FIXED|PROT_WRITE*/, -1, 0x0)
>mmap(&(0x7f0000196000/0x4000)=nil, 0x4000, 0xffffffffefffffff, 0x8032
>/* flags= MAP_POPULATE|MAP_ANONYMOUS|MAP_FIXED|PROT_WRITE*/, -1, 0x0)
>
>Shakeel

-- 
Wei Yang
Help you, Help me
