From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 0/2] KVM: s390: fixups for cmma migration (kvm/master)
Date: Thu, 21 Dec 2017 17:43:56 +0100
Message-ID: <20171221174356.3ee7cc4a.cohuck@redhat.com>
References: <20171221090416.17351-1-borntraeger@de.ibm.com>
        <bcf68339-9e90-8d5a-0e77-2a0b72fbbc6c@redhat.com>
        <36afdadb-994b-22b8-70fd-ff99efb859a3@redhat.com>
        <32605f3e-b533-d059-88a7-f49380215cf8@de.ibm.com>
        <47241caa-9e66-7b1e-bdc5-af1d52fc8407@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <47241caa-9e66-7b1e-bdc5-af1d52fc8407@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 21 Dec 2017 13:26:45 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 12/21/2017 01:12 PM, Christian Borntraeger wrote:

> > If there is a bug in a piece of code it is certainly a good idea to look deeper....
> > I think we can prevent both bugs by something like
> > 
> > diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> > index 8951ad4d33be..6ee12afced5a 100644
> > --- a/arch/s390/kvm/kvm-s390.c
> > +++ b/arch/s390/kvm/kvm-s390.c
> > @@ -841,6 +841,7 @@ static int kvm_s390_vm_stop_migration(struct kvm *kvm)
> >  
> >         if (kvm->arch.use_cmma) {
> >                 kvm_s390_sync_request_broadcast(kvm, KVM_REQ_STOP_MIGRATION);
> > +               synchronize_srcu(&kvm->srcu);
> >                 vfree(mgs->pgste_bitmap);
> >         }
> >         kfree(mgs);
> > 
> > 
> > Need to have a look.  
> 
> It needs a bit more changes for the get_cmma case.

Given that Christmas is approaching quickly: Get out the two fixes we
have now, worry about the rest later?
