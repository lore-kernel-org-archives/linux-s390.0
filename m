Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgBRQCs (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 11:02:48 -0500
Date: Tue, 18 Feb 2020 16:02:42 +0000
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 01/42] mm:gup/writeback: add callbacks for
 inaccessible pages
Message-ID: <20200218160242.GB1133@willie-the-truck>
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-2-borntraeger@de.ibm.com>
 <107a8a72-b745-26f2-5805-c4d99ce77b35@redhat.com>
 <dd33cc1a-214d-b949-8f5e-9c2d40a8e518@de.ibm.com>
 <a8f8786e-1ed0-0c44-08d0-ebc58f43ae40@redhat.com>
 <20200218154610.GB27565@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218154610.GB27565@linux.intel.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org

On Tue, Feb 18, 2020 at 07:46:10AM -0800, Sean Christopherson wrote:
> On Tue, Feb 18, 2020 at 09:27:20AM +0100, David Hildenbrand wrote:
> > On 17.02.20 12:10, Christian Borntraeger wrote:
> > > So yes, if everything is setup properly this should not fail in real life
> > > and only we have a kernel (or firmware) bug.
> > > 
> > 
> > Then, without feedback from other possible users, this should be a void
> > function. So either introduce error handling or convert it to a void for
> > now (and add e.g., BUG_ON and a comment inside the s390x implementation).
> 
> My preference would also be for a void function (versus ignoring an int
> return).

The gup code could certainly handle the error value, although the writeback
is a lot less clear (so a BUG_ON() would seem to be sufficient for now).

Will
