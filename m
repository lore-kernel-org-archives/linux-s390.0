From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 31 Oct 2018 16:39:54 +0000
Subject: Re: [PATCH 08/10] KVM: s390: add functions to (un)register GISC with GISA
Message-Id: <20181031173954.14ca1483.cohuck@redhat.com>
In-Reply-To: <2bf1ebcc-cf08-48b7-5fc7-66865b7faffc@linux.ibm.com>
References: <2bf1ebcc-cf08-48b7-5fc7-66865b7faffc@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 31 Oct 2018 17:35:11 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 31/10/2018 15:21, Cornelia Huck wrote:
> > On Wed, 31 Oct 2018 15:05:09 +0100
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> >   
> >> On 25/10/2018 14:37, Michael Mueller wrote:  

> > The isc space is very limited and has on top of that priority ordering;
> > I don't know if the gisa firmware code does have isc-specific semantics
> > as well.  
> 
> Yes it does.
> 
> >   
> >>
> >> Not having it will simplify the code.
> >>  
> >>> +
> >>> +	return gib->nisc;
> >>> +}  
> >>
> >> hum.
> >> Will nisc change ?
> >> It is hard coded in the call to kvm_s390_gib_init(GAL_ISC)  
> > 
> > Should the nisc maybe be explicitly tied to the adapter type? Or is
> > that a global thing? If yes, does this need any differentiation?  
> 
> It is global and do not need differentiation pro adapter.
> 
> > 
> > IIRC, the aiv is a general "adapter interrupt virtualization" facility,
> > so different adapter types may be present.  
> 
> Yes, and it is easier if the host use the same host ISC value for all of 
> them.
> After all the type of adapter is not important for the GIB

OK, thanks for clearing that up. I believe we should just go with
GAL_ISC directly in that case.

> 
> >   
> >>
> >> the NISC is a global value, if the only way to retrieve it is to
> >> register we need to keep it local in the space of the registering caller.
> >> I mean, registering to the GIB alert and registering an interruption are
> >> two different things and can be done in different functions.
> >>
> >> Shouldn't we just need the GAL_ISC definition?  
> >   
> 
> 
