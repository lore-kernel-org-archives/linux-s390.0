From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [GIT PULL 9/9] KVM: s390: Inject machine check into the nested
 guest
Date: Wed, 28 Jun 2017 20:59:08 +0200
Message-ID: <d4351d31-569e-4257-8b9d-b24c426fde58@de.ibm.com>
References: <1498671044-81240-1-git-send-email-borntraeger@de.ibm.com>
 <1498671044-81240-10-git-send-email-borntraeger@de.ibm.com>
 <9ec0f700-c686-44ce-c633-01f2b0ec46c0@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <9ec0f700-c686-44ce-c633-01f2b0ec46c0@redhat.com>
Content-Language: en-IE
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, QingFeng Hao <haoqf@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 06/28/2017 08:06 PM, David Hildenbrand wrote:
> On 28.06.2017 19:30, Christian Borntraeger wrote:
>> From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
>>
>> With vsie feature enabled, kvm can support nested guests (guest-3).
>> So inject machine check to the guest-2 if it happens when the nested
>> guest is running. And guest-2 will detect the machine check belongs
>> to guest-3 and reinject it into guest-3.
>> The host (guest-1) tries to inject the machine check to the picked
>> destination vcpu if it's a floating machine check.
> 
> The subject is confusing. We don't inject anything into the nested guest
> here. We just catch machine checks during vsie and inject it into the
> ordinary kvm guest.

Agreed, it is confusing and maybe a leftover from an early rework due to internal
feedback. We inject in guest-2 and rely on guest-2 to reinject to guest-3 would
be a better wording.

 


> Are there any SIE specific things to consider here, that may have to be
> translated?

As HW exits SIE before delivering the machine check, the SIE control block 
contains all saved guest3 registers and the host (guest1) registers contain
the lazy registers (as we have already restored them) just like a normal exit.
> 
>>
>> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/kvm/vsie.c | 23 +++++++++++++++++++----
>>  1 file changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>> index e947657..715c19c 100644
>> --- a/arch/s390/kvm/vsie.c
>> +++ b/arch/s390/kvm/vsie.c
>> @@ -26,13 +26,18 @@
>>  
>>  struct vsie_page {
>>  	struct kvm_s390_sie_block scb_s;	/* 0x0000 */
>> +	/*
>> +	 * the backup info for machine check. ensure it's at
>> +	 * the same offset as that in struct sie_page!
>> +	 */
>> +	struct mcck_volatile_info mcck_info;    /* 0x0200 */
>>  	/* the pinned originial scb */
>> -	struct kvm_s390_sie_block *scb_o;	/* 0x0200 */
>> +	struct kvm_s390_sie_block *scb_o;	/* 0x0218 */
>>  	/* the shadow gmap in use by the vsie_page */
>> -	struct gmap *gmap;			/* 0x0208 */
>> +	struct gmap *gmap;			/* 0x0220 */
>>  	/* address of the last reported fault to guest2 */
>> -	unsigned long fault_addr;		/* 0x0210 */
>> -	__u8 reserved[0x0700 - 0x0218];		/* 0x0218 */
>> +	unsigned long fault_addr;		/* 0x0228 */
>> +	__u8 reserved[0x0700 - 0x0230];		/* 0x0230 */
>>  	struct kvm_s390_crypto_cb crycb;	/* 0x0700 */
>>  	__u8 fac[S390_ARCH_FAC_LIST_SIZE_BYTE];	/* 0x0800 */
>>  };
>> @@ -801,6 +806,8 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>  {
>>  	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
>>  	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
>> +	struct mcck_volatile_info *mcck_info;
>> +	struct sie_page *sie_page;
>>  	int rc;
>>  
>>  	handle_last_fault(vcpu, vsie_page);
>> @@ -822,6 +829,14 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>  	local_irq_enable();
>>  	vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
>>  
>> +	if (rc == -EINTR) {
>> +		VCPU_EVENT(vcpu, 3, "%s", "machine check");
> 
> We directly have a pointer to vsie_page, why do we need to go back from
> scb_s?

> 
> Am I missing anything important?
> 
> 
> 
>> +		sie_page = container_of(scb_s, struct sie_page, sie_block);
>> +		mcck_info = &sie_page->mcck_info;
>> +		kvm_s390_reinject_machine_check(vcpu, mcck_info);
> 
> This could be a simple
> 
> kvm_s390_reinject_machine_check(vcpu, &vsie_page->mcck_info);
> 
> no?

Yes that would be simpler, I guess. Looks like  is just a "do it like the low
level handler". The code in nmi.c has to go back from the sie control block into
SIE page. 

Do you want a respin of this patch?

> 
>> +		return 0;
>> +	}
>> +
>>  	if (rc > 0)
>>  		rc = 0; /* we could still have an icpt */
>>  	else if (rc == -EFAULT)
>>
> 
> 
