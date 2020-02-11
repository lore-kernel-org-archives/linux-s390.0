Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21357 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727885AbgBKI11 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 Feb 2020 03:27:27 -0500
Date: Tue, 11 Feb 2020 09:27:12 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 24/35] KVM: s390: protvirt: disallow one_reg
Message-ID: <20200211092712.43064a10.cohuck@redhat.com>
In-Reply-To: <df4805f2-0c51-6ee9-2082-42d0f2276bd3@de.ibm.com>
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
        <20200207113958.7320-25-borntraeger@de.ibm.com>
        <20200210185307.73b45f78.cohuck@redhat.com>
        <df4805f2-0c51-6ee9-2082-42d0f2276bd3@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On Mon, 10 Feb 2020 19:34:56 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 10.02.20 18:53, Cornelia Huck wrote:
> > On Fri,  7 Feb 2020 06:39:47 -0500
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >   
> >> From: Janosch Frank <frankja@linux.ibm.com>
> >>
> >> A lot of the registers are controlled by the Ultravisor and never
> >> visible to KVM. Some fields in the sie control block are overlayed,
> >> like gbea. As no userspace uses the ONE_REG interface on s390 it is safe
> >> to disable this for protected guests.  
> > 
> > Last round, I suggested
> > 
> > "As no known userspace uses the ONE_REG interface on s390 if sync regs
> > are available, no functionality is lost if it is disabled for protected
> > guests."  
> 
> If you think this variant is better I can use this, I am fine with either. 

Well, yes :) I was afraid that it fell through the cracks.

> > 
> > Any opinion on that?
> >   
> >>
> >> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >> Reviewed-by: Thomas Huth <thuth@redhat.com>
> >> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> >> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> >> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >> ---
> >>  Documentation/virt/kvm/api.txt | 6 ++++--
> >>  arch/s390/kvm/kvm-s390.c       | 3 +++
> >>  2 files changed, 7 insertions(+), 2 deletions(-)  
> >   
> 
