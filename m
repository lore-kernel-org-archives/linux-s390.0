Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42626 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbgD3UDo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 16:03:44 -0400
Subject: Re: [PATCH v1 1/1] fs/splice: add missing callback for inaccessible
 pages
References: <20200428225043.3091359-1-imbrenda@linux.ibm.com>
 <2a1abf38-d321-e3c7-c3b1-53b6db6da310@intel.com>
 <d77d1e86-ac99-8c18-658c-d8150a71b11e@de.ibm.com>
 <540f483f-5e58-f342-e771-9d90c4d3fb6a@intel.com>
 <f32fa7f8-a259-80cc-ec70-d9cd690a8430@de.ibm.com>
 <fe1a2ecd-78ff-9bc6-717c-bdb55479b703@intel.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <5173673f-9aeb-4753-1e74-4ef442e06e6a@de.ibm.com>
Date: Thu, 30 Apr 2020 22:03:23 +0200
MIME-Version: 1.0
In-Reply-To: <fe1a2ecd-78ff-9bc6-717c-bdb55479b703@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, akpm@linux-foundation.org, jack@suse.cz, kirill@shutemov.name
Cc: david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, peterz@infradead.org, sean.j.christopherson@intel.com



On 30.04.20 22:01, Dave Hansen wrote:
> On 4/30/20 12:38 PM, Christian Borntraeger wrote:
>>>
>>>> What do you see when you also do the  SetPageAccessible(page);
>>>> in the else page of prep_new_page (order == 0).
>>>> (I do get > 10000 of these non compound page allocs just during boot).
>>> Yes, I see the same thing.
>>>
>>> I updated the patch and double-checked that it triggers properly with a
>>> socket-based sendfile().
>> Do you have a calltrace? 
> 
> It triggers with the thread from this patch _not_ applied.  I just
> wanted to point out that it was able to find the real bug and that the
> patch in question squashed this instance.


Ah now it makes sense. Thanks. 
> 
> Here's the call trace I see:
> 
>> [  199.566150] WARNING: CPU: 0 PID: 878 at mm/page_alloc.c:8860 check_page_accessible+0x5f/0xb0
>> [  199.567813] Modules linked in:
>> [  199.568447] CPU: 0 PID: 878 Comm: server Not tainted 5.7.0-rc3-dirty #6544
>> [  199.569948] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
>> [  199.571980] RIP: 0010:check_page_accessible+0x5f/0xb0
>> [  199.572737] Code: 4c 01 48 85 db 74 18 48 8b 03 48 8b 7b 08 48 83 c3 18 48 89 ee ff d0 48 8b 03 48 85 c0 75 eb 48 8b 45 00 a9 00 00 20 00 75 bb <0f> 0b 0f 1f 44 00 00 3e 80 4d 02 20 5b 5d c3 65 8b 05 db 72 d3 7e
>> [  199.576514] RSP: 0018:ffffc900003f7810 EFLAGS: 00010246
>> [  199.577556] RAX: 000ffff800020016 RBX: ffff88800ff5b068 RCX: 0000000000000000
>> [  199.578964] RDX: 0000000000000003 RSI: 0000000000000008 RDI: ffff88800fc18400
>> [  199.580352] RBP: ffffea0001d5ca40 R08: 00000000000001b5 R09: ffff88800fe74000
>> [  199.581784] R10: ffff88800fe74170 R11: ffff88800fc18400 R12: 0000000000001000
>> [  199.583179] R13: 0000000000000000 R14: 0000000000000000 R15: ffffc900005e52d0
>> [  199.584587] FS:  00007ffff7fe8700(0000) GS:ffff88807ce00000(0000) knlGS:0000000000000000
>> [  199.586045] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  199.587200] CR2: 00007ffff7b042b0 CR3: 000000007ab5a000 CR4: 00000000003406f0
>> [  199.588655] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [  199.591784] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [  199.593217] Call Trace:
>> [  199.593755]  ? e1000_xmit_frame+0x50c/0x1040
>> [  199.594626]  ? dev_hard_start_xmit+0x8d/0x1e0
>> [  199.596126]  ? sch_direct_xmit+0xe8/0x220
>> [  199.597676]  ? __qdisc_run+0x13a/0x4e0
>> [  199.598476]  ? __dev_queue_xmit+0x2d7/0x710
>> [  199.599767]  ? ip_finish_output2+0x2a8/0x550
>> [  199.601195]  ? skb_gso_validate_network_len+0x11/0x70
>> [  199.602272]  ? ip_output+0x6d/0xe0
>> [  199.602955]  ? ip_forward_options.cold.9+0x27/0x27
>> [  199.603918]  ? __ip_queue_xmit+0x14f/0x370
>> [  199.604734]  ? __tcp_transmit_skb+0x54b/0xad0
>> [  199.605608]  ? tcp_write_xmit+0x379/0x10c0
>> [  199.606354]  ? do_tcp_sendpages+0x2bc/0x5f0
>> [  199.607206]  ? tcp_sendpage_locked+0x44/0x60
>> [  199.608066]  ? tcp_sendpage+0x37/0x50
>> [  199.608801]  ? inet_sendpage+0x4f/0x80
>> [  199.609554]  ? kernel_sendpage+0x17/0x20
>> [  199.610341]  ? sock_sendpage+0x20/0x30
>> [  199.610989]  ? pipe_to_sendpage+0x60/0xa0
>> [  199.611658]  ? __splice_from_pipe+0x9f/0x180
>> [  199.612567]  ? generic_pipe_buf_nosteal+0x10/0x10
>> [  199.613509]  ? generic_pipe_buf_nosteal+0x10/0x10
>> [  199.614452]  ? splice_from_pipe+0x5d/0x90
>> [  199.615258]  ? direct_splice_actor+0x32/0x40
>> [  199.616102]  ? splice_direct_to_actor+0x101/0x220
>> [  199.617054]  ? pipe_to_sendpage+0xa0/0xa0
>> [  199.617858]  ? do_splice_direct+0x9a/0xd0
>> [  199.618660]  ? do_sendfile+0x1ce/0x3d0
>> [  199.619411]  ? __x64_sys_sendfile64+0x5c/0xc0
>> [  199.620343]  ? do_syscall_64+0x4a/0x130
>> [  199.621042]  ? entry_SYSCALL_64_after_hwframe+0x49/0xb3
>> [  199.622119] ---[ end trace 19796ac5d41cc1f4 ]---
