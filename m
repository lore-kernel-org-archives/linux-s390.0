Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46455 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729043AbgCPLph (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 16 Mar 2020 07:45:37 -0400
Date: Mon, 16 Mar 2020 12:45:25 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2] KVM: s390: Also reset registers in sync regs for
 initial cpu reset
Message-ID: <20200316124525.3bc099f9.cohuck@redhat.com>
In-Reply-To: <8bdef3aa-01b5-93a1-c54a-46768d47dfa4@redhat.com>
References: <20200310131223.10287-1-borntraeger@de.ibm.com>
        <8bdef3aa-01b5-93a1-c54a-46768d47dfa4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, stable@vger.kernel.org

On Tue, 10 Mar 2020 14:21:23 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 10.03.20 14:12, Christian Borntraeger wrote:
> > When we do the initial CPU reset we must not only clear the registers
> > in the internal data structures but also in kvm_run sync_regs. For
> > modern userspace sync_regs is the only place that it looks at.
> > 
> > Cc: stable@vger.kernel.org  
> 
> # v?
> 
> > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > ---
> >  arch/s390/kvm/kvm-s390.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)

> However, I do wonder if that ioctl *originally* was designed for that -
> IOW if this is rally a stable patch or just some change that makes
> sense. IIRC, userspace/QEMU always did the right thing, no? There was no
> documentation about the guarantees AFAIK.

The documentation only refers to the PoP for what is actually reset...
should it also mention the sync regs?
