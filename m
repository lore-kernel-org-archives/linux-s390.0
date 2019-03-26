From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v6 1/7] s390: ap: kvm: add PQAP interception for AQIC
Date: Tue, 26 Mar 2019 14:57:40 -0400
Message-ID: <66abb1f6-425a-df94-cc7c-f1fdec0ece9c@linux.ibm.com>
References: <1553265828-27823-1-git-send-email-pmorel@linux.ibm.com>
 <1553265828-27823-2-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553265828-27823-2-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 3/22/19 10:43 AM, Pierre Morel wrote:
> We prepare the interception of the PQAP/AQIC instruction for
> the case the AQIC facility is enabled in the guest.
> 
> First of all we do not want to change existing behavior when
> intercepting AP instructions without the SIE allowing the guest
> to use AP instructions.
> 
> In this patch we only handle the AQIC interception allowed by
> facility 65 which will be enabled when the complete interception
> infrastructure will be present.
> 
> We add a callback inside the KVM arch structure for s390 for
> a VFIO driver to handle a specific response to the PQAP
> instruction with the AQIC command and only this command.
> 
> But we want to be able to return a correct answer to the guest
> even there is no VFIO AP driver in the kernel.
> Therefor, we inject the correct exceptions from inside KVM for the
> case the callback is not initialized, which happens when the vfio_ap
> driver is not loaded.
> 
> We do consider the responsability of the driver to always initialize
> the PQAP callback if it defines queues by initializing the CRYCB for
> a guest.
> If the callback has been setup we call it.
> If not we setup an answer considering that no queue is available
> for the guest when no callback has been setup.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host.h      |  8 ++++
>   arch/s390/kvm/priv.c                  | 90 +++++++++++++++++++++++++++++++++++
>   drivers/s390/crypto/vfio_ap_private.h |  2 +
>   3 files changed, 100 insertions(+)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index a496276..624460b 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -18,6 +18,7 @@
>   #include <linux/kvm_host.h>
>   #include <linux/kvm.h>
>   #include <linux/seqlock.h>
> +#include <linux/module.h>
>   #include <asm/debug.h>
>   #include <asm/cpu.h>
>   #include <asm/fpu/api.h>
> @@ -721,8 +722,15 @@ struct kvm_s390_cpu_model {
>   	unsigned short ibc;
>   };
>   
> +struct kvm_s390_module_hook {
> +	int (*hook)(struct kvm_vcpu *vcpu);
> +	void *data;
> +	struct module *owner;
> +};
> +
>   struct kvm_s390_crypto {
>   	struct kvm_s390_crypto_cb *crycb;
> +	struct kvm_s390_module_hook *pqap_hook;
>   	__u32 crycbd;
>   	__u8 aes_kw;
>   	__u8 dea_kw;
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index 8679bd7..793e48a 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -27,6 +27,7 @@
>   #include <asm/io.h>
>   #include <asm/ptrace.h>
>   #include <asm/sclp.h>
> +#include <asm/ap.h>
>   #include "gaccess.h"
>   #include "kvm-s390.h"
>   #include "trace.h"
> @@ -592,6 +593,93 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
>   	}
>   }
>   
> +/*
> + * handle_pqap: Handling pqap interception
> + * @vcpu: the vcpu having issue the pqap instruction
> + *
> + * We now support PQAP/AQIC instructions and we need to correctly
> + * answer the guest even if no dedicated driver's hook is available.
> + *
> + * The intercepting code calls a dedicated callback for this instruction
> + * if a driver did register one in the CRYPTO satellite of the
> + * SIE block.
> + *
> + * For PQAP AQIC and TAPQ instructions, verify privilege and specifications.

The two paragraphs above should be described via the comments embedded
in the code and is not necessary here.

> + *
> + * If no callback available, the queues are not available, return this to
> + * the caller.

This implies it is specified via the return code when it is in fact
the response code in the status word.

> + * Else return the value returned by the callback.
> + */

Given this handler may be called for any PQAP instruction sub-function,
I think the function doc should be more generic, providing:

* A general description of what the function does
* A description of each input parameter
* A description of the value returned. If the return value is a return
   code, the possible rc values can be enumerated with a description for
   of the reason each particular value may be returned.

> +static int handle_pqap(struct kvm_vcpu *vcpu)
> +{
> +	struct ap_queue_status status = {};
> +	unsigned long reg0;
> +	int ret;
> +	uint8_t fc;
> +
> +	/* Verify that the AP instruction are available */
> +	if (!ap_instructions_available())
> +		return -EOPNOTSUPP;
> +	/* Verify that the guest is allowed to use AP instructions */
> +	if (!(vcpu->arch.sie_block->eca & ECA_APIE))
> +		return -EOPNOTSUPP;
> +	/*
> +	 * The only possibly intercepted instructions when AP instructions are
> +	 * available for the guest are AQIC and TAPQ with the t bit set
> +	 * since we do not set IC.3 (FIII) we currently will not intercept
> +	 * TAPQ.
> +	 * The following code will only treat AQIC function code.
> +	 */

Simplify to:

/* The only supported PQAP function is AQIC (0x03) */

> +	reg0 = vcpu->run->s.regs.gprs[0];
> +	fc = reg0 >> 24;
> +	if (fc != 0x03) {
> +		pr_warn("%s: Unexpected interception code 0x%02x\n",
> +			__func__, fc);
> +		return -EOPNOTSUPP;
> +	}
> +	/* All PQAP instructions are allowed for guest kernel only */

There is only one PQAP instruction with multiple sub-functions.
/* PQAP instruction is allowed for guest kernel only */
                         or
/* PQAP instruction is privileged */

> +	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
> +		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
> +	/*
> +	 * Common tests for PQAP instructions to generate a specification
> +	 * exception
> +	 */

This comment is unnecessary as the individual comments below adequately
do the job.

> +	/* Zero bits overwrite produce a specification exception */

This comment has no meaning unless you intimately know the architecture.
The following would make more sense:

	/* Bits 41-47 must all be zeros */

It's probably not a big deal, but since we don't support PQAP(TAPQ),
would it make more sense to make sure bits 40-47 are zeros (i.e.,
the 't' bit is not set)?

> +	if (reg0 & 0x007f0000UL)
> +		goto specification_except;
> +	/* If APXA is not installed APQN is limited */

Wouldn't it be better to state how the APQN is limited?
For example:

	/*
	 * If APXA is not installed, then the maximum APID is
	 * 63 (bits 48-49 of reg0 must be zero) and the maximum
	 * APQI is 15 (bits 56-59 must be zero)
	 */

> +	if (!(vcpu->kvm->arch.crypto.crycbd & 0x02))
> +		if (reg0 & 0x000030f0UL)

If APXA is not installed, then bits 48-49 and 56-59 must all be
zeros. Shouldn't this mask be 0x0000c0f0UL?

> +			goto specification_except;
> +	/* AQIC needs facility 65 */
> +	if (!test_kvm_facility(vcpu->kvm, 65))
> +		goto specification_except;
> +
> +	/*
> +	 * Verify that the hook callback is registered, lock the owner
> +	 * and call the hook.
> +	 */
> +	if (vcpu->kvm->arch.crypto.pqap_hook) {
> +		if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
> +			return -EOPNOTSUPP;
> +		ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);
> +		module_put(vcpu->kvm->arch.crypto.pqap_hook->owner);
> +		return ret;
> +	}
> +	/*
> +	 * It is the duty of the vfio_driver to register a hook
> +	 * If it does not and we get an exception on AQIC we must
> +	 * guess that there is no vfio_ap_driver at all and no one
> +	 * to handle the guests's CRYCB and the CRYCB is empty.
> +	 */

The comment above does not make sense to me. If there is no pqap
hook registered, then we need to handle that case for sure. But why
mention getting an exception? Why even mention whose responsibility
it is to set the hook when all we need to know is whether a hook is
set or not?

I am wondering whether merely setting a response code indicating the
APQN is invalid is the correct thing to do here. First of all, if the
guest's CRYCB is empty, then the AP bus running in the guest would not
create any AP devices or any AP queues bound to any zcrypt driver. In
that case, I don't think the PQAP(AQIC) would ever be issued. If a
PQAP is intercepted, wouldn't we want to return -EOPNOTSUPP?



> +	status.response_code = 0x01;
> +	memcpy(&vcpu->run->s.regs.gprs[1], &status, sizeof(status));
> +	return 0;
> +
> +specification_except:
> +	return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> +}
> +
>   static int handle_stfl(struct kvm_vcpu *vcpu)
>   {
>   	int rc;
> @@ -878,6 +966,8 @@ int kvm_s390_handle_b2(struct kvm_vcpu *vcpu)
>   		return handle_sthyi(vcpu);
>   	case 0x7d:
>   		return handle_stsi(vcpu);
> +	case 0xaf:
> +		return handle_pqap(vcpu);
>   	case 0xb1:
>   		return handle_stfl(vcpu);
>   	case 0xb2:
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 76b7f98..a910be1 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.hhttps://www.linuxmint.com/start/sylvia/
> @@ -16,6 +16,7 @@
>   #include <linux/mdev.h>
>   #include <linux/delay.h>
>   #include <linux/mutex.h>
> +#include <linux/kvm_host.h>
>   
>   #include "ap_bus.h"
>   
> @@ -81,6 +82,7 @@ struct ap_matrix_mdev {
>   	struct ap_matrix matrix;
>   	struct notifier_block group_notifier;
>   	struct kvm *kvm;
> +	struct kvm_s390_module_hook pqap_hook;
>   };
>   
>   extern int vfio_ap_mdev_register(void);
> 
