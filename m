From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 2/9] s390: ap: kvm: setting a hook for PQAP
 instructions
Date: Fri, 15 Feb 2019 10:26:27 +0100
Message-ID: <20190215102627.6e300e28.cohuck@redhat.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
        <1550152269-6317-3-git-send-email-pmorel@linux.ibm.com>
        <20190214165407.335b4ec0.cohuck@redhat.com>
        <2609f072-ab16-429e-8aba-e1af20757c25@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2609f072-ab16-429e-8aba-e1af20757c25@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 14 Feb 2019 17:45:06 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 14/02/2019 16:54, Cornelia Huck wrote:
> > On Thu, 14 Feb 2019 14:51:02 +0100
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> >   
> >> This patch adds interception code for the PQAP instructions,
> >> and a callback inside the KVM arch structure for s390.
> >>
> >> If a VFIO-AP drivers needs to intercept PQAP/AQIC or PQAP/TAPQ  
> > 
> > s/drivers/driver/  
> 
> thanks. OK
> 

> >> + *
> >> + * This callback only handles PQAP/AQIC instruction and  
> > 
> > Here you only talk about PQAP/AQIC, what about PQAP/TAPQ mentioned in
> > the patch description?  
> 
> I can add "for now" or "in this patch" or suppress the reference to 
> PAPQ/TAPQ

I'd just add a note to the patch description that this patch only
handles PQAP/AQCI and that handling PQAP/TAPQ is something for a
follow-on patch.

> 
> >   
> >> + * calls a dedicated callback for this instruction if
> >> + * a driver did register one in the CRYPTO satellite of the
> >> + * SIE block.
> >> + *
> >> + * Do not change the behavior if, return -EOPNOTSUPP if:
> >> + * - the hook is not used do not change the behavior.  
> > 
> > The hook is not used? Or not set?  
> 
> I think "is not set" is better.

Ok.

> 
> > (I don't think you need to repeat "do
> > not change the behavior".)  
> 
> OK
> 
> >   
> >> + * - AP instructions are not available or not available to the guest
> >> + * - the instruction is not PQAP with function code indicating
> >> + *   AQIC do not change the previous behavior.
> >> + *
> >> + * For PQAP/AQIC instruction, verify privilege and specifications
> >> + *
> >> + * return the value returned by the callback.
> >> + */
> >> +static int handle_pqap(struct kvm_vcpu *vcpu)
> >> +{
> >> +	uint8_t fc;
> >> +
> >> +	/* Verify that the hook callback is registered */
> >> +	if (!vcpu->kvm->arch.crypto.pqap_hook)
> >> +		return -EOPNOTSUPP;
> >> +	/* Verify that the AP instruction are available */
> >> +	if (!ap_instructions_available())
> >> +		return -EOPNOTSUPP;
> >> +	/* Verify that the guest is allowed to use AP instructions */
> >> +	if (!(vcpu->arch.sie_block->eca & ECA_APIE))
> >> +		return -EOPNOTSUPP;
> >> +	/* Verify that the function code is AQIC */
> >> +	fc = vcpu->run->s.regs.gprs[0] >> 24;
> >> +	if (fc != 0x03)
> >> +		return -EOPNOTSUPP;
> >> +
> >> +	/* PQAP instructions are allowed for guest kernel only */
> >> +	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
> >> +		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
> >> +	/* AQIC instruction is allowed only if facility 65 is available */
> >> +	if (!test_kvm_facility(vcpu->kvm, 65))
> >> +		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> >> +	/* All right, call the callback */
> >> +	return vcpu->kvm->arch.crypto.pqap_hook(vcpu);  
> > 
> > Can that callback also return -EOPNOTSUPP to order to drop to user
> > space?  
> 
> Yes.
> Why not?

Maybe also mention that in the function description?
