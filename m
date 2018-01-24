From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2] KVM: s390: add vcpu stat counters for many instruction
Date: Wed, 24 Jan 2018 17:18:46 +0100
Message-ID: <4d9e1fe2-62e8-3047-d08e-6f3e02138e02@de.ibm.com>
References: <20180124155054.9477-1-borntraeger@de.ibm.com>
 <20180124171526.76598068.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180124171526.76598068.cohuck@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>



On 01/24/2018 05:15 PM, Cornelia Huck wrote:
> On Wed, 24 Jan 2018 16:50:54 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> The overall instruction counter is larger than the sum of the
>> single counters. We should try to catch all instruction handlers
>> to make this match the summary counter.
>> Let us add sck,tb,sske,iske,rrbe,tb,tpi,tsch,lpsw,pswe....
>> and remove other unused ones.
> 
> This is rebased on top of the diagnose patch, right?

Yes, I did not wanted to change both patches.
> 
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Acked-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> ---
>>  arch/s390/include/asm/kvm_host.h | 21 +++++++++++++++++----
>>  arch/s390/kvm/diag.c             |  1 +
>>  arch/s390/kvm/kvm-s390.c         | 21 +++++++++++++++++----
>>  arch/s390/kvm/priv.c             | 32 ++++++++++++++++++++++++++++++--
>>  4 files changed, 65 insertions(+), 10 deletions(-)
>>
> 
>> @@ -527,6 +544,7 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
>>  		if (vcpu->arch.sie_block->ipa == 0xb235)
>>  			return handle_tsch(vcpu);
>>  		/* Handle in userspace. */
>> +		vcpu->stat.instruction_io_other++;
>>  		return -EOPNOTSUPP;
>>  	} else {
>>  		/*
> 
> As an aside, we don't count I/O instructions if userspace did not
> enable css support. But nobody does that with modern kernels anyway :)
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Thanks
