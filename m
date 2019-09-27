Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34627 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfI0VPO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 27 Sep 2019 17:15:14 -0400
Received: by mail-qk1-f195.google.com with SMTP id q203so3177301qke.1
        for <linux-s390@vger.kernel.org>; Fri, 27 Sep 2019 14:15:11 -0700 (PDT)
Message-ID: <1569618908.5576.240.camel@lca.pw>
Subject: Re: [PATCH] mm/page_alloc: fix a crash in free_pages_prepare()
From: Qian Cai <cai@lca.pw>
Date: Fri, 27 Sep 2019 17:15:08 -0400
In-Reply-To: <20190927134859.95a2f4908bdcea30df0184ed@linux-foundation.org>
References: <1569613623-16820-1-git-send-email-cai@lca.pw>
         <20190927134859.95a2f4908bdcea30df0184ed@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Fri, 2019-09-27 at 13:48 -0700, Andrew Morton wrote:
> On Fri, 27 Sep 2019 15:47:03 -0400 Qian Cai <cai@lca.pw> wrote:
> 
> > On architectures like s390, arch_free_page() could mark the page unused
> > (set_page_unused()) and any access later would trigger a kernel panic.
> > Fix it by moving arch_free_page() after all possible accessing calls.
> > 
> >  Hardware name: IBM 2964 N96 400 (z/VM 6.4.0)
> >  Krnl PSW : 0404e00180000000 0000000026c2b96e
> > (__free_pages_ok+0x34e/0x5d8)
> >             R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
> >  Krnl GPRS: 0000000088d43af7 0000000000484000 000000000000007c
> >  000000000000000f
> >             000003d080012100 000003d080013fc0 0000000000000000
> >  0000000000100000
> >             00000000275cca48 0000000000000100 0000000000000008
> >  000003d080010000
> >             00000000000001d0 000003d000000000 0000000026c2b78a
> >  000000002717fdb0
> >  Krnl Code: 0000000026c2b95c: ec1100b30659 risbgn %r1,%r1,0,179,6
> >             0000000026c2b962: e32014000036 pfd 2,1024(%r1)
> >            #0000000026c2b968: d7ff10001000 xc 0(256,%r1),0(%r1)
> >            >0000000026c2b96e: 41101100  la %r1,256(%r1)
> >             0000000026c2b972: a737fff8  brctg %r3,26c2b962
> >             0000000026c2b976: d7ff10001000 xc 0(256,%r1),0(%r1)
> >             0000000026c2b97c: e31003400004 lg %r1,832
> >             0000000026c2b982: ebff1430016a asi 5168(%r1),-1
> >  Call Trace:
> >  __free_pages_ok+0x16a/0x5d8)
> >  memblock_free_all+0x206/0x290
> >  mem_init+0x58/0x120
> >  start_kernel+0x2b0/0x570
> >  startup_continue+0x6a/0xc0
> >  INFO: lockdep is turned off.
> >  Last Breaking-Event-Address:
> >  __free_pages_ok+0x372/0x5d8
> >  Kernel panic - not syncing: Fatal exception: panic_on_oops
> > 00: HCPGIR450W CP entered; disabled wait PSW 00020001 80000000 00000000
> > 26A2379C
> > 
> > ...
> > 
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1175,11 +1175,11 @@ static __always_inline bool free_pages_prepare(struct page *page,
> >  		debug_check_no_obj_freed(page_address(page),
> >  					   PAGE_SIZE << order);
> >  	}
> > -	arch_free_page(page, order);
> >  	if (want_init_on_free())
> >  		kernel_init_free_pages(page, 1 << order);
> >  
> >  	kernel_poison_pages(page, 1 << order, 0);
> > +	arch_free_page(page, order);
> >  	if (debug_pagealloc_enabled())
> >  		kernel_map_pages(page, 1 << order, 0);
> 
> This is all fairly mature code, isn't it?  What happened to make this
> problem pop up now?

In the past, there is only kernel_poison_pages() would trigger it but it needs
"page_poison=on" kernel cmdline, and I suspect nobody tested that on s390 in the
past.

Recently, kernel_init_free_pages() (the commit 6471384af2a6) was added to the
kernel and could trigger it as well.

> 
> IOW, is a -stable backport needed?

Since kernel_init_free_pages() was added in v5.3, I think it does not hurt to
backport to -stable there.
