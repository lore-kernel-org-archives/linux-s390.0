From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v5 1/7] s390: ap: kvm: add PQAP interception for AQIC
Date: Fri, 15 Mar 2019 11:20:32 +0100
Message-ID: <20190315112032.13b259c2.cohuck@redhat.com>
References: <1552493104-30510-1-git-send-email-pmorel@linux.ibm.com>
        <1552493104-30510-2-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552493104-30510-2-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 13 Mar 2019 17:04:58 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

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
> + * For PQAP/AQIC instructions only, verify privilege and specifications.
> + *
> + * If no callback available, the queues are not available, return this to
> + * the caller.
> + * Else return the value returned by the callback.
> + */
> +static int handle_pqap(struct kvm_vcpu *vcpu)
> +{
> +	uint8_t fc;
> +	struct ap_queue_status status = {};
> +	int ret;
> +	/* Verify that the AP instruction are available */
> +	if (!ap_instructions_available())
> +		return -EOPNOTSUPP;
> +	/* Verify that the guest is allowed to use AP instructions */
> +	if (!(vcpu->arch.sie_block->eca & ECA_APIE))
> +		return -EOPNOTSUPP;
> +	/* Verify that the function code is AQIC */
> +	fc = vcpu->run->s.regs.gprs[0] >> 24;
> +	/* We do not want to change the behavior we had before this patch*/
> +	if (fc != 0x03)
> +		return -EOPNOTSUPP;
> +
> +	/* PQAP instructions are allowed for guest kernel only */
> +	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
> +		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
> +	/* AQIC instruction is allowed only if facility 65 is available */
> +	if (!test_kvm_facility(vcpu->kvm, 65))
> +		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> +	/* Verify that the hook callback is registered and call it */
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
> +	status.response_code = 0x01;

I'm still confused here, sorry. From previous discussions I recall that
this indicates "no crypto device" (please correct me if I'm wrong.)

Before this patch, we had:
- guest issues PQAP/AQIC -> drop to userspace

With a correct implementation, we get:
- guest issues PQAP/AQIC -> callback does what needs to be done

With an incorrect implementation (no callback), we get:
- guest issues PQAP/AQIC -> guest gets response code 0x01

Why not drop to userspace in that case?


> +	memcpy(&vcpu->run->s.regs.gprs[1], &status, sizeof(status));
> +	return 0;
> +}
> +
