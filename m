From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 02/15] KVM: s390: reset crypto attributes for all
 vcpus
Date: Tue, 17 Apr 2018 16:09:20 +0200
Message-ID: <20180417160920.7c5756d7.cohuck@redhat.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1523827345-11600-3-git-send-email-akrowiak@linux.vnet.ibm.com>
        <20180417133403.6fd7627a.cohuck@redhat.com>
        <0a3d569e-4328-364f-6df7-17de4f28833a@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0a3d569e-4328-364f-6df7-17de4f28833a@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, 17 Apr 2018 09:47:58 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> On 04/17/2018 07:34 AM, Cornelia Huck wrote:
> > On Sun, 15 Apr 2018 17:22:12 -0400
> > Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> >  
> >> Introduces a new function to reset the crypto attributes for all
> >> vcpus whether they are running or not. Each vcpu in KVM will
> >> be removed from SIE prior to resetting the crypto attributes in its
> >> SIE state description. After all vcpus have had their crypto attributes
> >> reset the vcpus will be restored to SIE.
> >>
> >> This function will be used in a later patch to set the ECA.28
> >> bit in the SIE state description to enable interpretive execution of
> >> AP instructions. It will also be incorporated into the
> >> kvm_s390_vm_set_crypto(kvm) function to fix an issue whereby the crypto
> >> key wrapping attributes could potentially get out of synch for running
> >> vcpus.  
> > So, this description leads me to think it would make sense to queue
> > this patch (fixing the key wrapping) independently of this series,
> > wouldn't it?  
> I considered that because I figured there might be objections, but
> since separating them would create dependency issues I didn't see
> any harm in including it here. I can remove this from the explanation
> above and the code below and create a separate patch for the key
> wrapping if you'd prefer.

Well, I think this makes sense as an individual patch, but I'll leave
that to the maintainers to decide.

> >  
> >> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> >> ---
> >>   arch/s390/kvm/kvm-s390.c |   19 +++++++++++++------
> >>   arch/s390/kvm/kvm-s390.h |   14 ++++++++++++++
> >>   2 files changed, 27 insertions(+), 6 deletions(-)

> >> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
> >> index 1b5621f..76324b7 100644
> >> --- a/arch/s390/kvm/kvm-s390.h
> >> +++ b/arch/s390/kvm/kvm-s390.h
> >> @@ -410,4 +410,18 @@ static inline int kvm_s390_use_sca_entries(void)
> >>   }
> >>   void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
> >>   				     struct mcck_volatile_info *mcck_info);
> >> +
> >> +/**
> >> + * kvm_s390_vcpu_crypto_reset_all
> >> + *
> >> + * Reset the crypto attributes for each vcpu. This can be done while the vcpus
> >> + * are running as each vcpu will be removed from SIE before resetting the crypto
> >> + * attributes and restored to SIE afterward.
> >> + *
> >> + * Note: The kvm->lock mutex must be locked prior to calling this function and
> >> + *	 unlocked after it returns.  
> > "Must be called with kvm->lock held"?  
> Yes. The kvm->lock must be held to set the crypto attributes that will be
> copied to the vcpus via the kvm_s390_vcpu_crypto_reset_all() function,
> so it made sense to hold the lock across the entire operation.

This was intended as a suggestion for a more compact usage note :)
