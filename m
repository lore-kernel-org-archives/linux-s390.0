From: Frank Blaschka <blaschka@linux.vnet.ibm.com>
Subject: Re: [RFC][patch 3/6] KVM: s390: Add GISA support
Date: Fri, 5 Sep 2014 12:52:33 +0200
Message-ID: <20140905105233.GA17325@tuxmaker.boeblingen.de.ibm.com>
References: <20140904105223.336503578@de.ibm.com> <20140904105337.081387456@de.ibm.com> <54097466.2090502@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54097466.2090502@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: frank.blaschka@de.ibm.com, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, aik@ozlabs.ru, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, Sep 05, 2014 at 10:29:26AM +0200, Alexander Graf wrote:
> 
> 
> On 04.09.14 12:52, frank.blaschka@de.ibm.com wrote:
> > From: Frank Blaschka <frank.blaschka@de.ibm.com>
> > 
> > This patch adds GISA (Guest Interrupt State Area) support
> > to s390 kvm. GISA can be used for exitless interrupts. The
> > patch provides a set of functions for GISA related operations
> > like accessing GISA fields or registering ISCs for alert.
> > Exploiters of GISA will follow with additional patches.
> > 
> > Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
> 
> That's a nice feature. However, please make sure that you maintain the
> abstraction levels.
> 
> What should happen is that you request an irqfd from FLIC. Then you
> associate that irqfd with the PCI device.
> 
> Thanks to that association, both parties can now talk to each other and
> negotiate their GISA number space and make sure things are connected.
> 
> However, it should always be possible to do things without this direct
> IRQ injection.
> 
> So you should be able to receive an irqfd event when an IRQ happened, so
> that VFIO user space applications can also handle interrupts for example.
> 
> And the same applies for interrupt injection. We also need to be able to
> inject an adapter interrupt from QEMU for emulated devices ;).
>

OK, assuming we are doing the vfio solution expoiting GISA would be a
second step. Will take your feedback into account. THX!
> 
> Alex
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
