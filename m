From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 10 Dec 2018 14:51:51 +0000
Subject: Re: [PATCH v4 08/10] KVM: s390: add functions to (un)register GISC with GISA
Message-Id: <20181210155151.327fbf9c.cohuck@redhat.com>
In-Reply-To: <481805e7-f654-e726-f64f-c661fd0744b0@linux.ibm.com>
References: <481805e7-f654-e726-f64f-c661fd0744b0@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 10 Dec 2018 15:37:47 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 10/12/2018 13:15, Michael Mueller wrote:
> > 
> > 
> > On 10.12.18 10:44, Cornelia Huck wrote:  
> >> On Mon, 10 Dec 2018 10:27:54 +0100
> >> Pierre Morel <pmorel@linux.ibm.com> wrote:
> >>  
> >>> On 03/12/2018 10:48, Michael Mueller wrote:  
> >>>>
> >>>>
> >>>> On 03.12.18 10:21, Cornelia Huck wrote:  
> >>>>> On Fri, 30 Nov 2018 15:32:13 +0100
> >>>>> Michael Mueller <mimu@linux.ibm.com> wrote:  
> >>>>>> +int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc)
> >>>>>> +{
> >>>>>> +��� int rc = 0;
> >>>>>> +
> >>>>>> +��� if (!kvm->arch.gib_in_use)
> >>>>>> +������� return -ENODEV;
> >>>>>> +��� if (gisc > MAX_ISC)
> >>>>>> +������� return -EINVAL;
> >>>>>> +
> >>>>>> +��� spin_lock(&kvm->arch.iam_ref_lock);
> >>>>>> +��� if (kvm->arch.iam_ref_count[gisc] == 0) {
> >>>>>> +������� rc = -EFAULT;  
> >>>>> -EFAULT looks odd. -EINVAL?  
> >>>> sure  
> >>>
> >>> Can we find some errno return value which is not already used in this
> >>> function?  
> >>
> >> I'm not sure what would be a better fit here (-EINVAL if you try to
> >> unregister something that has never been registered seems reasonable).
> >>
> >> Also, I think it is quite reasonable if a function returns the same
> >> error for different reasons, as long as they are all the same class of
> >> error. In this case, both the caller using an out-of-rage gisc or a
> >> gisc that has never been registered indicate some internal mixup in how
> >> the caller handles the gisc.  
> > 
> > I think -EPERM is the right choice here. It is not permitted to
> > decrease the ref counter below zero.
> >   
> >>  
> >   
> To be anoying I would prefer
> -ERANGE if gisc > MAX_ISC
> 
> -EINVAL in the second case is OK for me

If you want different return codes, this one makes more sense to me.

> 
> and I also can agree with the argumentation of Conny.
> 
> 
