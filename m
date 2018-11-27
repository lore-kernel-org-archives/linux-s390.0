From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 27 Nov 2018 19:06:42 +0000
Subject: Re: [PATCH v2 03/12] KVM: s390: add the GIB and its related life-cyle functions
Message-Id: <20181127200642.743fa762.cohuck@redhat.com>
In-Reply-To: <655b9f37-a9ff-b193-5719-a1278aec4395@linux.ibm.com>
References: <655b9f37-a9ff-b193-5719-a1278aec4395@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 27 Nov 2018 19:05:44 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> On 27.11.18 18:21, Cornelia Huck wrote:
> > On Tue, 27 Nov 2018 18:12:07 +0100
> > Michael Mueller <mimu@linux.ibm.com> wrote:
> >   
> >> On 26.11.18 17:32, Cornelia Huck wrote:  
> >>> On Mon, 19 Nov 2018 18:25:27 +0100
> >>> Michael Mueller <mimu@linux.ibm.com> wrote:  
> >   
> >>>> @@ -2895,6 +2897,7 @@ void kvm_s390_gisa_init(struct kvm *kvm)
> >>>>    		kvm->arch.gisa = &kvm->arch.sie_page2->gisa;
> >>>>    		VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
> >>>>    		kvm_s390_gisa_clear(kvm);
> >>>> +		kvm->arch.gib_in_use = !!gib;  
> >>>
> >>> So, that's basically gib && aiv?
> >>>      
> >>>>    	}
> >>>>    }
> >>>>    
> >>>> @@ -2904,3 +2907,37 @@ void kvm_s390_gisa_destroy(struct kvm *kvm)
> >>>>    		return;
> >>>>    	kvm->arch.gisa = NULL;
> >>>>    }
> >>>> +
> >>>> +void kvm_s390_gib_destroy(void)
> >>>> +{
> >>>> +	if (!gib)
> >>>> +		return;
> >>>> +	chsc_sgib(0);
> >>>> +	free_page((unsigned long)gib);
> >>>> +	gib = NULL;
> >>>> +}
> >>>> +
> >>>> +int kvm_s390_gib_init(u8 nisc)
> >>>> +{
> >>>> +	if (!css_general_characteristics.aiv) {
> >>>> +		KVM_EVENT(3, "%s", "gib not initialized, no AIV facility");
> >>>> +		return 0;
> >>>> +	}
> >>>> +
> >>>> +	gib = (struct kvm_s390_gib *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
> >>>> +	if (!gib) {
> >>>> +		KVM_EVENT(3, "gib 0x%pK memory allocation failed", gib);
> >>>> +		return -ENOMEM;
> >>>> +	}
> >>>> +
> >>>> +	gib->nisc = nisc;
> >>>> +	if (chsc_sgib((u32)(u64)gib)) {
> >>>> +		KVM_EVENT(3, "gib 0x%pK AIV association failed", gib);
> >>>> +		free_page((unsigned long)gib);
> >>>> +		gib = NULL;
> >>>> +		return -EIO;
> >>>> +	}
> >>>> +
> >>>> +	KVM_EVENT(3, "gib 0x%pK (nisc=%d) initialized", gib, gib->nisc);
> >>>> +	return 0;
> >>>> +}  
> >>>
> >>> And given that you now fail initializing the vm if aiv is present but
> >>> you could not setup the gib (which makes sense), isn't it enough to
> >>> either check for aiv or gib, instead of adding gib_in_use? (There's
> >>> always a pointer to a valid gisa if aiv.) What am I missing?  
> >>
> >> In addition there is the vSIE case where I have no AIV and thus no GISA.  
> > 
> > Yes, but that should be covered by a !aiv check, shouldn't it?  
> 
> Both checks are already there and the information is stored in:
> 
> kvm->arch.gisa != NULL
> 
> But it works only because a failing gib_init() drags everything down.
> 
> The functions where the test is used are semantically related to the
> GIB, thus using (kvm->arch.gisa) as test might be confusing.
> 
> I will prepare and see how the codes reads...

If it becomes too mushy, just leave it as it is now and I'll stop
complaining ;)

> 
> Thanks a lot for your comments today!
> 
> Michael
> 
> 
> >   
> 
