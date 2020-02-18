Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgBRQd3 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 11:33:29 -0500
Date: Tue, 18 Feb 2020 16:33:23 +0000
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 39/42] example for future extension: mm:gup/writeback:
 add callbacks for inaccessible pages: error cases
Message-ID: <20200218163322.GD1133@willie-the-truck>
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-40-borntraeger@de.ibm.com>
 <20200218162546.GC1133@willie-the-truck>
 <e7f91b4f-455f-5fc7-19ab-51362dec4e62@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7f91b4f-455f-5fc7-19ab-51362dec4e62@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org, Sean Christopherson <sean.j.christopherson@intel.com>

On Tue, Feb 18, 2020 at 05:30:40PM +0100, Christian Borntraeger wrote:
> On 18.02.20 17:25, Will Deacon wrote:
> > On Fri, Feb 14, 2020 at 05:26:55PM -0500, Christian Borntraeger wrote:
> >> From: Claudio Imbrenda <imbrenda@linux.ibm.com>
> >>
> >> This is a potential extension to do error handling if we fail to
> >> make the page accessible if we know what others need.
> >>
> >> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> >> ---
> >>  mm/gup.c            | 17 ++++++++++++-----
> >>  mm/page-writeback.c |  6 +++++-
> >>  2 files changed, 17 insertions(+), 6 deletions(-)
> > 
> > Sorry, I missed this when replying elsewhere in the thread!
> > Anyway, looks good to me:
> > 
> > Acked-by: Will Deacon <will@kernel.org>
> 
> I can use that for a combined patch (this one merged into the first) ? Correct?

Fine by me!

Will
