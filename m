From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v5 10/15] KVM: s390: add functions to (un)register GISC
 with GISA
Date: Tue, 8 Jan 2019 14:36:13 +0100
Message-ID: <20190108143613.2ca1a9d3@oc2783563651>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
        <20181219191756.57973-11-mimu@linux.ibm.com>
        <bd1a6082-cb73-5ef7-f2b6-8cbd7d8c7136@linux.ibm.com>
        <20190104141836.0ca98a77.cohuck@redhat.com>
        <b001fc9b-c174-644f-a9fa-e60ff5b4aa58@linux.ibm.com>
        <20190108113444.56e76f13.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108113444.56e76f13.cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Michael Mueller <mimu@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 8 Jan 2019 11:34:44 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> > >>    
> > >>> +	spin_unlock(&kvm->arch.iam_ref_lock);
> > >>> +
> > >>> +	return gib->nisc;
> > >>> +}
> > >>> +EXPORT_SYMBOL_GPL(kvm_s390_gisc_register);
> > >>> +
> > >>> +int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc)
> > >>> +{
> > >>> +	int rc = 0;
> > >>> +
> > >>> +	if (!kvm->arch.gib_in_use)
> > >>> +		return -ENODEV;
> > >>> +	if (gisc > MAX_ISC)
> > >>> +		return -ERANGE;
> > >>> +
> > >>> +	spin_lock(&kvm->arch.iam_ref_lock);
> > >>> +	if (kvm->arch.iam_ref_count[gisc] == 0) {
> > >>> +		rc = -EINVAL;
> > >>> +		goto out;
> > >>> +	}
> > >>> +	kvm->arch.iam_ref_count[gisc]--;
> > >>> +	if (kvm->arch.iam_ref_count[gisc] == 0) {
> > >>> +		kvm->arch.iam &= ~(0x80 >> gisc);
> > >>> +		set_iam(kvm->arch.gisa, kvm->arch.iam);    
> > > 
> > > Any chance of this function failing here? If yes, would there be any
> > > implications?    
> > 
> > It is the same here.  
> 
> I'm not sure that I follow: This is the reverse operation
> (unregistering the gisc). Can we rely on get_ipm() to do any fixup
> later? Is that a problem for the caller?

IMHO gib alerts are all about not loosing initiative. I.e. avoiding
substantially delayed delivery of interrupts due to vCPUs in wait
state.

Thus we must avoid letting go before setting up stuff (gisa.iam under
consideration of gisa ipm, gisa.next_alert, and gib.alert_list_origin)
so that we can react on the next interrupt (if necessary).

On the other hand, getting more gisa alerts than necessary is not
fatal -- better avoided if not too much hassle of course.

Bottom line is, while it may be critical that the IAM changes implied
by register take place immediately, unregister is a different story.

Regards,
Halil

> 
> Apologies if I sound confused (well, that's because I probably am);
> this is hard to review without access to the hardware specification.
