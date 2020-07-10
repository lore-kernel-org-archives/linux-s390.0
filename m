Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26866 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728212AbgGJN6f (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 Jul 2020 09:58:35 -0400
Date: Fri, 10 Jul 2020 15:57:09 +0200
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v1 0/9] s390: implement and optimize vmemmap_free()
Message-ID: <20200710135709.GB14845@osiris>
References: <20200703133917.39045-1-david@redhat.com>
 <20200707120849.GB12303@osiris>
 <f4a87c47-4987-e3f8-8c06-ff6dd60f6a39@redhat.com>
 <51813747-a2d6-03a4-fe61-b8d62dbca05b@redhat.com>
 <13549874-c33b-c47a-adbd-d625c83cc87d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13549874-c33b-c47a-adbd-d625c83cc87d@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, Christian Borntraeger <borntraeger@de.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On Wed, Jul 08, 2020 at 02:16:39PM +0200, David Hildenbrand wrote:
> >>> Hmm.. I really would like to see if there would be only a single page
> >>> table walker left in vmem.c, which handles both adding and removing
> >>> things.
> >>> Now we end up with two different page table walk implementations
> >>> within the same file. However not sure if it is worth the effort to
> >>> unify them though.
> >>
> >> I tried to unify vmemmap_populate() and vmem_add_range() already and
> >> didn't like the end result ... so, unifying these along with the removal
> >> part won't be any better - most probably. Open for suggestions :)
> >>
> >> (at least arm64 and x86-64 handle it similarly)
> >>
> > 
> > I'll play with something like
> > 
> > static void modify_pagetable(unsigned long start, unsigned long end,
> > 			     bool direct, bool add)
> > 
> > and see how it turns out.
> > 
> 
> Did a quick hack. With a single walker (modify_pagetable) I get
> 
>  arch/s390/mm/vmem.c | 628 ++++++++++++++++++++++++++++++--------------
>  1 file changed, 434 insertions(+), 194 deletions(-)
> 
> Overall looks cleaner, only modify_pte_table() and modify_pmd_table()
> are a little more involved ...

Would you mind to resend the series with this integrated?
