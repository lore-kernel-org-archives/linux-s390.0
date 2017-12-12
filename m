From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 11/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_set_guest_debug
Date: Tue, 12 Dec 2017 17:36:34 +0100
Message-ID: <b9380125-a226-0df1-2724-d957b9c05b42@redhat.com>
References: <20171204203538.8370-1-cdall@kernel.org>
 <20171204203538.8370-12-cdall@kernel.org>
 <20171211133943.236f18be.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171211133943.236f18be.cohuck@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Christoffer Dall <cdall@kernel.org>
Cc: linux-mips@linux-mips.org, kvm@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, James Hogan <jhogan@kernel.org>, kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, kvmarm@lists.cs.columbia.edu
List-ID: <linux-s390.vger.kernel.org>

On 11/12/2017 13:39, Cornelia Huck wrote:
>> +	ret = -EINVAL;
>>  	for (n = 0; n < (KVMPPC_BOOKE_IAC_NUM + KVMPPC_BOOKE_DAC_NUM); n++) {
>>  		uint64_t addr = dbg->arch.bp[n].addr;
>>  		uint32_t type = dbg->arch.bp[n].type;
>> @@ -2067,21 +2071,24 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>>  		if (type & ~(KVMPPC_DEBUG_WATCH_READ |
>>  			     KVMPPC_DEBUG_WATCH_WRITE |
>>  			     KVMPPC_DEBUG_BREAKPOINT))
>> -			return -EINVAL;
>> +			goto out;
>>  
>>  		if (type & KVMPPC_DEBUG_BREAKPOINT) {
>>  			/* Setting H/W breakpoint */
>>  			if (kvmppc_booke_add_breakpoint(dbg_reg, addr, b++))
>> -				return -EINVAL;
>> +				goto out;
>>  		} else {
>>  			/* Setting H/W watchpoint */
>>  			if (kvmppc_booke_add_watchpoint(dbg_reg, addr,
>>  							type, w++))
>> -				return -EINVAL;
>> +				goto out;
>>  		}
>>  	}
>>  
>> -	return 0;
>> +	ret = 0;
> 
> I would probably set the -EINVAL in the individual branches (so it is
> clear that something is wrong, and it is not just a benign exit as in
> the cases above), but your code is correct as well. Let the powerpc
> folks decide.

The idiom that Christoffer used is found elsewhere in KVM, so I'm
accepting his version.  Thanks for the review!

Paolo
