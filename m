From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v1 1/2] KVM: s390: Tracing APCB changes
Date: Fri, 5 Oct 2018 11:30:53 +0200
Message-ID: <20181005113053.7a3e1f72.cohuck@redhat.com>
References: <7d147350-4284-8e01-d1fa-0795d2da85c1@de.ibm.com>
        <1538728270-10340-1-git-send-email-pmorel@linux.ibm.com>
        <1538728270-10340-2-git-send-email-pmorel@linux.ibm.com>
        <20181005104925.04a1f3ef.cohuck@redhat.com>
        <f06ad8c4-2f59-b693-aec8-b93fac9c2177@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f06ad8c4-2f59-b693-aec8-b93fac9c2177@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, david@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 5 Oct 2018 10:57:22 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 05/10/2018 10:49, Cornelia Huck wrote:
> > On Fri,  5 Oct 2018 10:31:09 +0200
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> >   
> >> kvm_arch_crypto_set_masks is a new function to centralize
> >> the setup the APCB masks inside the CRYCB SIE satelite.  
> > 
> > s/satelite/satellite/
> >   
> >>
> >> To trace APCB mask changes, we add KVM_EVENT() tracing to
> >> both kvm_arch_crypto_set_masks and kvm_arch_crypto_clear_masks.
> >>
> >> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> >> ---
> >>   arch/s390/include/asm/kvm_host.h |  2 ++
> >>   arch/s390/kvm/kvm-s390.c         | 41 ++++++++++++++++++++++++++++++++++++++++
> >>   2 files changed, 43 insertions(+)

(...)

> > The locking and requests makes me wonder if we missed them before...
> > were they simply not needed for the prior use case (mdev group
> > notifier)?  
> 
> Before we used to set the mask before creating the vcpu.
> In fact since we still call this function from the initialization
> of VFIO AP we still do.
> 
> But since this function is more generic we need to be more careful
> if it is called when vcpu are running.
> We do the same locking mechanism in the kvm_arch_crypto_clear_mask().

Yes, that makes sense.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
