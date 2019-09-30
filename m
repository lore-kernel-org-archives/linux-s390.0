Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27216 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729664AbfI3Hos (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Sep 2019 03:44:48 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8U7g92c099070
        for <linux-s390@vger.kernel.org>; Mon, 30 Sep 2019 03:44:45 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vb9fm8jym-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 30 Sep 2019 03:44:44 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Mon, 30 Sep 2019 08:44:42 +0100
Date: Mon, 30 Sep 2019 09:44:37 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] mm/page_alloc: fix a crash in free_pages_prepare()
References: <1569613623-16820-1-git-send-email-cai@lca.pw>
 <20190927134859.95a2f4908bdcea30df0184ed@linux-foundation.org>
 <1569618908.5576.240.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569618908.5576.240.camel@lca.pw>
Message-Id: <20190930074437.GB5604@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Qian Cai <cai@lca.pw>, Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, gor@linux.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 05:15:08PM -0400, Qian Cai wrote:
> On Fri, 2019-09-27 at 13:48 -0700, Andrew Morton wrote:
> > On Fri, 27 Sep 2019 15:47:03 -0400 Qian Cai <cai@lca.pw> wrote:
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -1175,11 +1175,11 @@ static __always_inline bool free_pages_prepare(struct page *page,
> > >  		debug_check_no_obj_freed(page_address(page),
> > >  					   PAGE_SIZE << order);
> > >  	}
> > > -	arch_free_page(page, order);
> > >  	if (want_init_on_free())
> > >  		kernel_init_free_pages(page, 1 << order);
> > >  
> > >  	kernel_poison_pages(page, 1 << order, 0);
> > > +	arch_free_page(page, order);
> > >  	if (debug_pagealloc_enabled())
> > >  		kernel_map_pages(page, 1 << order, 0);
> > 
> > This is all fairly mature code, isn't it?  What happened to make this
> > problem pop up now?
> 
> In the past, there is only kernel_poison_pages() would trigger it but it needs
> "page_poison=on" kernel cmdline, and I suspect nobody tested that on s390 in the
> past.

Yes. Peter Oberparleiter reported this also before my short vacation,
but I didn't have time to look into this. Thanks for fixing!

Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
