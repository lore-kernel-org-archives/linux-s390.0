Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3820 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726440AbgD3RUJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 13:20:09 -0400
Date: Thu, 30 Apr 2020 19:19:42 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] fs/splice: add missing callback for inaccessible
 pages
Message-ID: <20200430191942.3ae9155f@p-imbrenda>
In-Reply-To: <172c51f7-7dd6-7dd0-153f-aedd4b10a9f3@intel.com>
References: <20200428225043.3091359-1-imbrenda@linux.ibm.com>
        <2a1abf38-d321-e3c7-c3b1-53b6db6da310@intel.com>
        <b077744e-65be-f89c-55bb-4fc0f712eb76@de.ibm.com>
        <609afef2-43c2-d048-1c01-448a53a54d4e@intel.com>
        <20200430005310.7b25efab@p-imbrenda>
        <172c51f7-7dd6-7dd0-153f-aedd4b10a9f3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, akpm@linux-foundation.org, jack@suse.cz, kirill@shutemov.name, david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, peterz@infradead.org, sean.j.christopherson@intel.com, Ulrich.Weigand@de.ibm.com

On Wed, 29 Apr 2020 16:52:46 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> On 4/29/20 3:53 PM, Claudio Imbrenda wrote:
> >> Actually, that's the problem.  You've gone through all these
> >> careful checks and made the page inaccessible.  *After* that
> >> process, how do you keep the page from being hit by an I/O device
> >> before it's made accessible again?  My patch just assumes that
> >> *all* pages have gone through that process and passed those
> >> checks.  
> > I don't understand what you are saying here.
> > 
> > we start with all pages accessible, we mark pages as inaccessible
> > when they are imported in the secure guest (we use the PG_arch_1
> > bit in struct page). we then try to catch all I/O on inaccessible
> > pages and make them accessible so that I/O devices are happy.   
> 
> The catching mechanism is incomplete, that's all I'm saying.

well, sendto in the end does a copy_from_user or a get_user_pages_fast,
both are covered (once we fix the make_accessible to work on FOLL_GET
too). 

> Without looking too hard, and not even having the hardware, I've found
> two paths where the "catching" was incomplete:
> 
> 	1. sendfile(), which you've patched
> 	2. sendto(), which you haven't patched
> 
> > either your quick and dirty patch was too dirty (e.g. not accounting
> > for possible races between make_accessible/make_inaccessible), or
> > some of the functions in the trace you provided should do
> > pin_user_page instead of get_user_page (or both)  
> 
> I looked in the traces for any races.  For sendto(), at least, the
> make_accessible() never happened before the process exited.  That's
> entirely consistent with the theory that it entirely missed being
> caught.  I can't find any evidence that there were races.
> 
> Go ahead and try it.  You have the patch!  I mean, I found a bug in
> about 10 minutes in one tiny little VM.

I tried your patch, but I could not reproduce the problem. I have a
Debian 10 x86_64 with the latest kernel from master and your patch on
top. is there anything I'm missing? which virtual devices are you using?
any particular .config options?

I could easily get the mm_make_accessible tracepoints, but I never
manage to trigger the mm_accessible_error ones.

are you using transparent hugepages by any chance? the
infrastructure for inaccessible pages is meant only for small pages,
since on s390x only small pages can ever be used for secure
guests and therefore become inaccessible.

> And, yes, you need to get rid of the FOLL_PIN check unless you want to
> go change a big swath of the remaining get_user_pages*() sites.
