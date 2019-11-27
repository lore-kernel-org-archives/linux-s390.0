Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39680 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726530AbfK0MFU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 27 Nov 2019 07:05:20 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARC2f1L016509
        for <linux-s390@vger.kernel.org>; Wed, 27 Nov 2019 07:05:20 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2whmsy9p9m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 27 Nov 2019 07:05:19 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Wed, 27 Nov 2019 12:05:17 -0000
Subject: Re: memory leak in new_inode_pseudo (2)
References: <000000000000111cbe058dc7754d@google.com>
 <000000000000ed664f058dc82773@google.com>
 <20191119051350.GK163020@sol.localdomain>
From: Ursula Braun <ubraun@linux.ibm.com>
Date: Wed, 27 Nov 2019 13:05:14 +0100
MIME-Version: 1.0
In-Reply-To: <20191119051350.GK163020@sol.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <27dff6d8-b4f2-6940-355a-4bcb47464e71@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Biggers <ebiggers@kernel.org>, Karsten Graul <kgraul@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, syzbot <syzbot+e682cca30bc101a4d9d9@syzkaller.appspotmail.com>



On 11/19/19 6:13 AM, Eric Biggers wrote:
> Ursula and Karsten,
> 
> On Tue, Jul 16, 2019 at 01:28:06AM -0700, syzbot wrote:
>> syzbot has found a reproducer for the following crash on:
>>
>> HEAD commit:    be8454af Merge tag 'drm-next-2019-07-16' of git://anongit...
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=13d5f750600000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=d23a1a7bf85c5250
>> dashboard link: https://syzkaller.appspot.com/bug?extid=e682cca30bc101a4d9d9
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155c5800600000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1738f800600000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+e682cca30bc101a4d9d9@syzkaller.appspotmail.com
>>
>> executing program
>> executing program
>> executing program
>> executing program
>> BUG: memory leak
>> unreferenced object 0xffff888128ea0980 (size 768):
>>   comm "syz-executor303", pid 7044, jiffies 4294943526 (age 13.490s)
>>   hex dump (first 32 bytes):
>>     01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<000000005ba542b8>] kmemleak_alloc_recursive
>> include/linux/kmemleak.h:43 [inline]
>>     [<000000005ba542b8>] slab_post_alloc_hook mm/slab.h:522 [inline]
>>     [<000000005ba542b8>] slab_alloc mm/slab.c:3319 [inline]
>>     [<000000005ba542b8>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>>     [<000000006532a1e9>] sock_alloc_inode+0x1c/0xa0 net/socket.c:238
>>     [<0000000014ddc967>] alloc_inode+0x2c/0xe0 fs/inode.c:227
>>     [<0000000056541455>] new_inode_pseudo+0x18/0x70 fs/inode.c:916
>>     [<000000003b5b5444>] sock_alloc+0x1c/0x90 net/socket.c:554
>>     [<00000000e623b353>] __sock_create+0x8f/0x250 net/socket.c:1378
>>     [<000000000e094708>] sock_create_kern+0x3b/0x50 net/socket.c:1483
>>     [<000000009fe4f64f>] smc_create+0xae/0x160 net/smc/af_smc.c:1975
>>     [<0000000056be84a7>] __sock_create+0x164/0x250 net/socket.c:1414
>>     [<000000005915e5fe>] sock_create net/socket.c:1465 [inline]
>>     [<000000005915e5fe>] __sys_socket+0x69/0x110 net/socket.c:1507
>>     [<00000000afa837b2>] __do_sys_socket net/socket.c:1516 [inline]
>>     [<00000000afa837b2>] __se_sys_socket net/socket.c:1514 [inline]
>>     [<00000000afa837b2>] __x64_sys_socket+0x1e/0x30 net/socket.c:1514
>>     [<00000000d0addad1>] do_syscall_64+0x76/0x1a0
>> arch/x86/entry/common.c:296
>>     [<000000004e8e7c22>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> BUG: memory leak
>> unreferenced object 0xffff88811faeeab8 (size 56):
>>   comm "syz-executor303", pid 7044, jiffies 4294943526 (age 13.490s)
>>   hex dump (first 32 bytes):
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>     00 0a ea 28 81 88 ff ff d0 ea ae 1f 81 88 ff ff  ...(............
>>   backtrace:
>>     [<000000005ba542b8>] kmemleak_alloc_recursive
>> include/linux/kmemleak.h:43 [inline]
>>     [<000000005ba542b8>] slab_post_alloc_hook mm/slab.h:522 [inline]
>>     [<000000005ba542b8>] slab_alloc mm/slab.c:3319 [inline]
>>     [<000000005ba542b8>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>>     [<000000008ca63096>] kmem_cache_zalloc include/linux/slab.h:738 [inline]
>>     [<000000008ca63096>] lsm_inode_alloc security/security.c:522 [inline]
>>     [<000000008ca63096>] security_inode_alloc+0x33/0xb0
>> security/security.c:875
>>     [<00000000b335d930>] inode_init_always+0x108/0x200 fs/inode.c:169
>>     [<0000000015dcffb3>] alloc_inode+0x49/0xe0 fs/inode.c:234
>>     [<0000000056541455>] new_inode_pseudo+0x18/0x70 fs/inode.c:916
>>     [<000000003b5b5444>] sock_alloc+0x1c/0x90 net/socket.c:554
>>     [<00000000e623b353>] __sock_create+0x8f/0x250 net/socket.c:1378
>>     [<000000000e094708>] sock_create_kern+0x3b/0x50 net/socket.c:1483
>>     [<000000009fe4f64f>] smc_create+0xae/0x160 net/smc/af_smc.c:1975
>>     [<0000000056be84a7>] __sock_create+0x164/0x250 net/socket.c:1414
>>     [<000000005915e5fe>] sock_create net/socket.c:1465 [inline]
>>     [<000000005915e5fe>] __sys_socket+0x69/0x110 net/socket.c:1507
>>     [<00000000afa837b2>] __do_sys_socket net/socket.c:1516 [inline]
>>     [<00000000afa837b2>] __se_sys_socket net/socket.c:1514 [inline]
>>     [<00000000afa837b2>] __x64_sys_socket+0x1e/0x30 net/socket.c:1514
>>     [<00000000d0addad1>] do_syscall_64+0x76/0x1a0
>> arch/x86/entry/common.c:296
>>     [<000000004e8e7c22>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
> 
> Do you think this was fixed by:
> 
> 	commit 6d6dd528d5af05dc2d0c773951ed68d630a0c3f1
> 	Author: Ursula Braun <ubraun@linux.ibm.com>
> 	Date:   Tue Nov 12 16:03:41 2019 +0100
> 
> 	    net/smc: fix refcount non-blocking connect() -part 2
> 
> ?
> 

No, I don't think so. This patch changes the SMC connect() code, but I do not
see any connect() call in the syzbot C-reproducer.

Regards, Ursula

> Thanks!
> 
> - Eric
> 
