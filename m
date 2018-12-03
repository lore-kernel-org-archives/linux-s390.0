From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 03 Dec 2018 09:46:12 +0000
Subject: Re: [PATCH v4 03/10] KVM: s390: add the GIB and its related life-cyle functions
Message-Id: <20181203104612.407a5baf.cohuck@redhat.com>
In-Reply-To: <a019e461-f187-8808-df08-520c7447976e@linux.ibm.com>
References: <a019e461-f187-8808-df08-520c7447976e@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 3 Dec 2018 10:31:00 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> On 03.12.18 10:00, Cornelia Huck wrote:
> > On Fri, 30 Nov 2018 15:32:08 +0100
> > Michael Mueller <mimu@linux.ibm.com> wrote:
> >   
> >> The GIB (Guest Information Block) links the GISA of all guests
> >> that have adapter interrupts pending. These interrupts cannot be
> >> delivered because no vcpu of these guests is currently running in
> >> SIE context. Instead, a GIB alert is issued on the host to schedule
> >> these guests to run.
> >>
> >> This mechanism allows to process adapter interrupts for currently
> >> not running guests.
> >>
> >> The GIB is created during host initialization and associated with
> >> the Adapter Interruption Facility in case an Adapter Interruption
> >> Virtualization Facility is available.
> >>
> >> The GIB initialization and thus the activation of the related code
> >> will be done in an upcoming patch of this series.
> >>
> >> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> >> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> >> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >> ---
> >>   arch/s390/include/asm/kvm_host.h | 10 ++++++++++
> >>   arch/s390/kvm/interrupt.c        | 37 +++++++++++++++++++++++++++++++++++++
> >>   arch/s390/kvm/kvm-s390.c         |  1 +
> >>   arch/s390/kvm/kvm-s390.h         |  2 ++
> >>   4 files changed, 50 insertions(+)
> >>  
> >   
> >> +int kvm_s390_gib_init(u8 nisc)
> >> +{
> >> +	if (!css_general_characteristics.aiv) {
> >> +		KVM_EVENT(3, "%s", "gib not initialized, no AIV facility");
> >> +		return 0;
> >> +	}
> >> +
> >> +	gib = (struct kvm_s390_gib *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
> >> +	if (!gib) {
> >> +		KVM_EVENT(3, "gib 0x%pK memory allocation failed", gib);
> >> +		return -ENOMEM;
> >> +	}
> >> +
> >> +	gib->nisc = nisc;
> >> +	if (chsc_sgib((u32)(u64)gib)) {
> >> +		KVM_EVENT(3, "gib 0x%pK AIV association failed", gib);  
> > 
> > I think that's the one place where a message in addition to the dbf
> > event makes sense (if kvm is built as a module), as mentioned last time.  
> 
> The message is printed when kvm_s390_gib_init() fails. See last patch of 
> series.

But that only logs the rc (-EIO), not the extra information here? I'm
worried that we might end up with non-unique rcs for different problems.
> 
> >   
> >> +		free_page((unsigned long)gib);
> >> +		gib = NULL;
> >> +		return -EIO;
> >> +	}
> >> +
> >> +	KVM_EVENT(3, "gib 0x%pK (nisc=%d) initialized", gib,
> >> gib->nisc);
> >> +	return 0;
> >> +}  
> > 
> > Otherwise, looks good to me.
> >   
> 
