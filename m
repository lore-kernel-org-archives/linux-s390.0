From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v5 10/15] KVM: s390: add functions to (un)register GISC
 with GISA
Date: Tue, 8 Jan 2019 14:35:27 +0100
Message-ID: <20190108143527.7a727521.cohuck@redhat.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
        <20181219191756.57973-11-mimu@linux.ibm.com>
        <bd1a6082-cb73-5ef7-f2b6-8cbd7d8c7136@linux.ibm.com>
        <20190104141836.0ca98a77.cohuck@redhat.com>
        <b001fc9b-c174-644f-a9fa-e60ff5b4aa58@linux.ibm.com>
        <20190108113444.56e76f13.cohuck@redhat.com>
        <d845b44f-b06d-47ca-220c-ffe546342a5e@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d845b44f-b06d-47ca-220c-ffe546342a5e@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 8 Jan 2019 14:07:06 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> On 08.01.19 11:34, Cornelia Huck wrote:
> > On Mon, 7 Jan 2019 18:38:02 +0100
> > Michael Mueller <mimu@linux.ibm.com> wrote:
> >   
> >> On 04.01.19 14:19, Cornelia Huck wrote:  
> >>> On Wed, 2 Jan 2019 18:29:00 +0100
> >>> Pierre Morel <pmorel@linux.ibm.com> wrote:
> >>>      
> >>>> On 19/12/2018 20:17, Michael Mueller wrote:  
> >>>>> Add the IAM (Interruption Alert Mask) to the architecture specific
> >>>>> kvm struct. This mask in the GISA is used to define for which ISC
> >>>>> a GIB alert can be issued.
> >>>>>
> >>>>> The functions kvm_s390_gisc_register() and kvm_s390_gisc_unregister()
> >>>>> are used to (un)register a GISC (guest ISC) with a virtual machine and
> >>>>> its GISA.
> >>>>>
> >>>>> Upon successful completion, kvm_s390_gisc_register() returns the
> >>>>> ISC to be used for GIB alert interruptions. A negative return code
> >>>>> indicates an error during registration.
> >>>>>
> >>>>> Theses functions will be used by other adapter types like AP and PCI to
> >>>>> request pass-through interruption support.
> >>>>>
> >>>>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> >>>>> ---
> >>>>>     arch/s390/include/asm/kvm_host.h |  9 ++++++
> >>>>>     arch/s390/kvm/interrupt.c        | 66 ++++++++++++++++++++++++++++++++++++++++
> >>>>>     2 files changed, 75 insertions(+)
> >>>>>     
> >>>      
> >>>>> +int kvm_s390_gisc_register(struct kvm *kvm, u32 gisc)
> >>>>> +{
> >>>>> +	if (!kvm->arch.gib_in_use)
> >>>>> +		return -ENODEV;
> >>>>> +	if (gisc > MAX_ISC)
> >>>>> +		return -ERANGE;
> >>>>> +
> >>>>> +	spin_lock(&kvm->arch.iam_ref_lock);
> >>>>> +	if (kvm->arch.iam_ref_count[gisc] == 0)
> >>>>> +		kvm->arch.iam |= 0x80 >> gisc;
> >>>>> +	kvm->arch.iam_ref_count[gisc]++;
> >>>>> +	if (kvm->arch.iam_ref_count[gisc] == 1)
> >>>>> +		set_iam(kvm->arch.gisa, kvm->arch.iam);  
> >>>>
> >>>> testing the set_iam return value?
> >>>> Even it should be fine if the caller works correctly, this is done
> >>>> before GISA is ever used.  
> >>
> >> There is a rc but a check here is not required.
> >>
> >> There are three cases:
> >>
> >> a) This is the first ISC that gets registered, then the GISA is
> >>      not in use and IAM is set in the GISA.
> >>
> >> b) A second ISC gets registered and the GISA is *not* in the
> >>      alert list. Then the IAM is set here as well.
> >>
> >> c) A second ISC gets registered and the GISA is in the
> >>      alert list. Then the IAM is intentionally not set here
> >>      by set_iam(). It will be restored by get_ipm() with
> >>      the new IAM value by the gib alert processing code.
> >>
> >>  
> >>>
> >>> My feeling is that checking the return code is a good idea, even if it
> >>> Should Never Fail(tm).
> >>>      
> >>>>     
> >>>>> +	spin_unlock(&kvm->arch.iam_ref_lock);
> >>>>> +
> >>>>> +	return gib->nisc;
> >>>>> +}
> >>>>> +EXPORT_SYMBOL_GPL(kvm_s390_gisc_register);
> >>>>> +
> >>>>> +int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc)
> >>>>> +{
> >>>>> +	int rc = 0;
> >>>>> +
> >>>>> +	if (!kvm->arch.gib_in_use)
> >>>>> +		return -ENODEV;
> >>>>> +	if (gisc > MAX_ISC)
> >>>>> +		return -ERANGE;
> >>>>> +
> >>>>> +	spin_lock(&kvm->arch.iam_ref_lock);
> >>>>> +	if (kvm->arch.iam_ref_count[gisc] == 0) {
> >>>>> +		rc = -EINVAL;
> >>>>> +		goto out;
> >>>>> +	}
> >>>>> +	kvm->arch.iam_ref_count[gisc]--;
> >>>>> +	if (kvm->arch.iam_ref_count[gisc] == 0) {
> >>>>> +		kvm->arch.iam &= ~(0x80 >> gisc);
> >>>>> +		set_iam(kvm->arch.gisa, kvm->arch.iam);  
> >>>
> >>> Any chance of this function failing here? If yes, would there be any
> >>> implications?  
> >>
> >> It is the same here.  
> > 
> > I'm not sure that I follow: This is the reverse operation
> > (unregistering the gisc). Can we rely on get_ipm() to do any fixup
> > later? Is that a problem for the caller?
> > 
> > Apologies if I sound confused (well, that's because I probably am);
> > this is hard to review without access to the hardware specification.  
> 
> I think nothing will happen because the AP CLR IRQ call (Pierre?)
> has already taken offline the last AP device.

But doesn't that rely on behaviour by the caller?

If the caller does weird and broken stuff, this function should return
an error, shouldn't it?

> 
> 
> >   
> >>  
> >>>      
> >>>>> +	}
> >>>>> +out:
> >>>>> +	spin_unlock(&kvm->arch.iam_ref_lock);
> >>>>> +
> >>>>> +	return rc;
> >>>>> +}
> >>>>> +EXPORT_SYMBOL_GPL(kvm_s390_gisc_unregister);
> >>>>> +
> >>>>>     void kvm_s390_gib_destroy(void)
> >>>>>     {
> >>>>>     	if (!gib)
> >>>>>         
> >>>>
> >>>>     
> >>>      
> >>  
> >   
> 
