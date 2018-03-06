From: David Hildenbrand <david@redhat.com>
Date: Tue, 06 Mar 2018 13:30:56 +0000
Subject: Re: [PATCH v1] KVM: s390x: fix memory overwrites when not using SCA entries
Message-Id: <0f7bd6b5-043b-ac6e-614f-85893fac670f@redhat.com>
In-Reply-To: <564cc278-404e-5890-1070-7d53ab9fac00@de.ibm.com>
References: <564cc278-404e-5890-1070-7d53ab9fac00@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 06.03.2018 14:29, Cornelia Huck wrote:
> On Tue,  6 Mar 2018 14:27:58 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Even if we don't have extended SCA support, we can have more than 64 CPUs
>> if we don't enable any HW features that might use the SCA entries.
>>
>> Now, this works just fine, but we missed a return, which is why we
>> would actually store the SCA entries. If we have more than 64 CPUs, this
>> means writing outside of the basic SCA - bad.
>>
>> Let's fix this. This allows > 64 CPUs when running nested (under vSIE)
>> without random crashes.
>>
>> Fixes: a6940674c384 ("KVM: s390: allow 255 VCPUs when sca entries aren't used")
> 
> cc: stable?

Think so!

If whoever picks this up can also fix the subject s/s390x/s390/, that
would be nice.

> 
>> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  arch/s390/kvm/kvm-s390.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 77d7818130db..321bfbc67d3d 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -2146,6 +2146,7 @@ static void sca_add_vcpu(struct kvm_vcpu *vcpu)
>>  		/* we still need the basic sca for the ipte control */
>>  		vcpu->arch.sie_block->scaoh = (__u32)(((__u64)sca) >> 32);
>>  		vcpu->arch.sie_block->scaol = (__u32)(__u64)sca;
>> +		return;
>>  	}
>>  	read_lock(&vcpu->kvm->arch.sca_lock);
>>  	if (vcpu->kvm->arch.use_esca) {
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 


-- 

Thanks,

David / dhildenb
