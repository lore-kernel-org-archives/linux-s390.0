From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 1/2] KVM: s390: add vcpu stat counters for many
 instruction
Date: Wed, 24 Jan 2018 13:31:16 +0100
Message-ID: <c795505a-8416-bc5c-0bfc-228c59b417c4@de.ibm.com>
References: <20180124113235.31485-1-borntraeger@de.ibm.com>
 <20180124113235.31485-2-borntraeger@de.ibm.com>
 <12d2bcbd-e2e3-c029-2b7f-b4cc22a6f193@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <12d2bcbd-e2e3-c029-2b7f-b4cc22a6f193@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>



On 01/24/2018 01:27 PM, Janosch Frank wrote:
> On 24.01.2018 12:32, Christian Borntraeger wrote:
>> The overall instruction counter is larger than the sum of the
>> single counters. We should try to catch all instruction handlers
>> to make this match the summary counter.
>> Let us add sck,tb,sske,iske,rrbe,tb,tpi,tsch,lpsw,pswe.....
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> Acked-by: Janosch Frank <frankja@linux.vnet.ibm.com>

Thanks
> 
> [...]
>>
>>  static int handle_io_inst(struct kvm_vcpu *vcpu)
>>  {
>> +
>>  	VCPU_EVENT(vcpu, 4, "%s", "I/O instruction");
> 
> Whitespace damage

fixed.

> 
>>
>>  	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
>> @@ -527,6 +545,7 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
>>  		if (vcpu->arch.sie_block->ipa == 0xb235)
>>  			return handle_tsch(vcpu);
>>  		/* Handle in userspace. */
>> +		vcpu->stat.instruction_io++;
>>  		return -EOPNOTSUPP;
>>  	} else {
>>  		/*
> 
