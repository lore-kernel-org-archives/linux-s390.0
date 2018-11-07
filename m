From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 07 Nov 2018 09:22:07 +0000
Subject: Re: [PATCH 08/10] KVM: s390: add functions to (un)register GISC with GISA
Message-Id: <20181107102207.2a1be7b2.cohuck@redhat.com>
In-Reply-To: <3911abab-321c-5a36-8553-7d5137f54bf4@linux.ibm.com>
References: <3911abab-321c-5a36-8553-7d5137f54bf4@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 6 Nov 2018 16:53:37 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> On 31.10.18 17:39, Cornelia Huck wrote:
> > On Wed, 31 Oct 2018 17:35:11 +0100
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> >  
> >> On 31/10/2018 15:21, Cornelia Huck wrote:  
> >>> On Wed, 31 Oct 2018 15:05:09 +0100
> >>> Pierre Morel <pmorel@linux.ibm.com> wrote:
> >>>      
> >>>> On 25/10/2018 14:37, Michael Mueller wrote:  
> >>> The isc space is very limited and has on top of that priority ordering;
> >>> I don't know if the gisa firmware code does have isc-specific semantics
> >>> as well.  
> >> Yes it does.
> >>  
> >>>      
> >>>> Not having it will simplify the code.
> >>>>     
> >>>>> +
> >>>>> +	return gib->nisc;
> >>>>> +}  
> >>>> hum.
> >>>> Will nisc change ?
> >>>> It is hard coded in the call to kvm_s390_gib_init(GAL_ISC)  
> >>> Should the nisc maybe be explicitly tied to the adapter type? Or is
> >>> that a global thing? If yes, does this need any differentiation?  
> >> It is global and do not need differentiation pro adapter.
> >>  
> >>> IIRC, the aiv is a general "adapter interrupt virtualization" facility,
> >>> so different adapter types may be present.  
> >> Yes, and it is easier if the host use the same host ISC value for all of
> >> them.
> >> After all the type of adapter is not important for the GIB  
> > OK, thanks for clearing that up. I believe we should just go with
> > GAL_ISC directly in that case.  
> 
> So, you both want me to git rid of the nisc parameter during gib 
> initialization as well?
> I'm not convinced. Here is an example how it will be used:
> 
> static int ap_ioctl_setirq(struct ap_matrix_mdev *matrix_mdev, struct 
> vfio_ap_aqic *parm)
> {
>  ��� ...
> 
>  ��� gal_isc = kvm_s390_gisc_register(matrix_mdev->kvm, matrix_mdev->gisc);
>  ��� if (gal_isc < 0)
>  ��� ��� return -EIO;
>  ��� ...
>  ��� aqic_gisa.isc = gal_isc;
>  ��� ...
>  ��� ret = ap_host_aqic((uint64_t)apqn, aqic2reg(aqic_gisa), p);
>  ��� ...
>  ��� return (ap_status.rc) ? -EIO : 0;
> }

So, we're calling kvm_s390_gisc_register() and will obtain the isc to
add in the gisa on success. But won't that isc always be the same (as
discussed above)?

> 
> 
> >>>      
> >>>> the NISC is a global value, if the only way to retrieve it is to
> >>>> register we need to keep it local in the space of the registering caller.
> >>>> I mean, registering to the GIB alert and registering an interruption are
> >>>> two different things and can be done in different functions.
> >>>>
> >>>> Shouldn't we just need the GAL_ISC definition?  
> 
> Pierre,
> 
> kvm_s390_gisc_register() is always required to get an GAL interruption 
> on the host
> and to be able to reload the mechanism. The function manages the IAM 
> restore mask.
> May the function name is missleading?
> 
> >>>      
> >>  
> 
