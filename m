Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728006AbgDPQen (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Apr 2020 12:34:43 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03GGXVk5133325
        for <linux-s390@vger.kernel.org>; Thu, 16 Apr 2020 12:34:43 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30escs3p2p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 16 Apr 2020 12:34:43 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Thu, 16 Apr 2020 17:34:03 +0100
Date: Thu, 16 Apr 2020 18:34:31 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v4 2/2] mm/gup/writeback: add callbacks for inaccessible
 pages
In-Reply-To: <a6b8728d-7382-9316-412d-dd48b5e7c41a@intel.com>
References: <20200306132537.783769-1-imbrenda@linux.ibm.com>
        <20200306132537.783769-3-imbrenda@linux.ibm.com>
        <3ae46945-0c7b-03cd-700a-a6fe8003c6ab@intel.com>
        <20200415221754.GM2483@worktop.programming.kicks-ass.net>
        <a7c2eb84-94c2-a608-4b04-a740fa9a389d@intel.com>
        <20200416141547.29be5ea0@p-imbrenda>
        <de56aa8e-9035-4b68-33cb-15682d073e26@intel.com>
        <20200416165900.68bd4dba@p-imbrenda>
        <a6b8728d-7382-9316-412d-dd48b5e7c41a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20200416183431.7216e1d1@p-imbrenda>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, linux-next@vger.kernel.org, akpm@linux-foundation.org, jack@suse.cz, kirill@shutemov.name, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Sean Christopherson <sean.j.christopherson@intel.com>, borntraeger@de.ibm.com, david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Will Deacon <will@kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>

On Thu, 16 Apr 2020 08:36:50 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> On 4/16/20 7:59 AM, Claudio Imbrenda wrote:
> > On Thu, 16 Apr 2020 07:20:48 -0700
> > Dave Hansen <dave.hansen@intel.com> wrote:  
> >> On 4/16/20 5:15 AM, Claudio Imbrenda wrote:  
> >>>> I assumed that this was all anonymous-only so it's always dirty
> >>>> before writeback starts.    
> >>> it could also be mmapped    
> >>
> >> Let's say you have a mmap()'d ramfs file.  Another process calls
> >> which doesn't have it mapped calls sys_write() and writes to the
> >> file.  
> ...
> >> Where is the arch_make_page_accessible() in this case on the ramfs
> >> page?  
> > 
> > it's in the fault handler for the exception the CPU will get when
> > attempting to write the data to the protected page  
> 
> Ahh, so this is *just* intended to precede I/O done on the page, when
> a non-host entity is touching the memory?

yep

> That seems inconsistent with the process_vm_readv/writev() paths which
> set FOLL_PIN on their pin_remote_user_pages() requests, but don't do
> I/O to the memory.

FOLL_PIN simply indicates potential access to the content of the page,
not just for I/O.

so yes, we are overdoing arch_make_page_accessible() in some cases,
because we can't tell when a page will be used for I/O and when not.

In most cases this will boil down to checking a flag and doing nothing,
for example in case the page was already accessible.

Also note that making the page accessible because of a FOLL_PIN in
absence of I/O will probably later on spare us from triggering and
handling the exception that would have caused us to make the page
accessible anyway.
