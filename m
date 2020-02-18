Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgBRQCH (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 11:02:07 -0500
Date: Tue, 18 Feb 2020 16:02:00 +0000
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 01/35] mm:gup/writeback: add callbacks for inaccessible
 pages
Message-ID: <20200218160159.GA1133@willie-the-truck>
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-2-borntraeger@de.ibm.com>
 <28792269-e053-ac70-a344-45612ee5c729@de.ibm.com>
 <20200211112611.GD8560@willie-the-truck>
 <618384fa-fa5e-66e8-221a-726e7dcf1d8c@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <618384fa-fa5e-66e8-221a-726e7dcf1d8c@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org, kvm-ppc@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, mark.rutland@arm.com, qperret@google.com, palmerdabbelt@google.com

On Thu, Feb 13, 2020 at 03:48:16PM +0100, Christian Borntraeger wrote:
> 
> 
> On 11.02.20 12:26, Will Deacon wrote:
> > On Mon, Feb 10, 2020 at 06:27:04PM +0100, Christian Borntraeger wrote:
> >> CC Marc Zyngier for KVM on ARM.  Marc, see below. Will there be any
> >> use for this on KVM/ARM in the future?
> > 
> > I can't speak for Marc, but I can say that we're interested in something
> > like this for potentially isolating VMs from a KVM host in Android.
> > However, we've currently been working on the assumption that the memory
> > removed from the host won't usually be touched by the host (i.e. no
> > KSM or swapping out), so all we'd probably want at the moment is to be
> > able to return an error back from arch_make_page_accessible(). Its return
> > code is ignored in this patch :/
> 
> I think there are two ways at the moment. One is to keep the memory away from
> Linux, e.g. by using the memory as device driver memory like kmalloc. This is
> kind of what Power does. And I understand you as you want to follow that model
> and do not want to use paging, file backing or so.

Correct.

> Our approach tries to fully integrate into the existing Linux LRU methods.
> 
> Back to your approach. What happens when a malicious QEMU would start direct I/O
> on such isolated memory? Is that what you meant by adding error checking in these
> hooks. For the gup.c code returning an error seems straightforward.

Yes, it would be nice if the host could avoid even trying to access the
page if it's inaccessible and so returning an error from
arch_make_page_accessible() would be a good way to achieve that. If the
access goes ahead anyway, then the hypervisor will have to handle the
fault and effectively ignore the host access (writes will be lost, reads
will return poison).

> I have no idea what to do in writeback. When somebody managed to trigger writeback
> on such a page, it already seems too late.

For now, we could just have a BUG_ON().

Will
