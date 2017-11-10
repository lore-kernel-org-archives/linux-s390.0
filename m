From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [GIT PULL 5/9] KVM: s390: SIE considerations for AP Queue
 virtualization
Date: Fri, 10 Nov 2017 14:45:10 +0100
Message-ID: <dfd9c1a5-59b5-69c9-8ffd-0a3b790c057e@de.ibm.com>
References: <20171110080013.111004-1-borntraeger@de.ibm.com>
 <20171110080013.111004-6-borntraeger@de.ibm.com>
 <d31ed97d-1e72-d188-7934-c7568578f22f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <d31ed97d-1e72-d188-7934-c7568578f22f@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 11/10/2017 01:46 PM, David Hildenbrand wrote:
> On 10.11.2017 09:00, Christian Borntraeger wrote:
>> From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>>
>> The Crypto Control Block (CRYCB) is referenced by the SIE state
>> description and controls KVM guest access to the Adjunct
>> Processor (AP) adapters, usage domains and control domains.
>> This patch defines the AP control blocks to be used for
>> controlling guest access to the AP adapters and domains.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> Message-Id: <1507916344-3896-2-git-send-email-akrowiak@linux.vnet.ibm.com>
>> Acked-by: Cornelia Huck <cohuck@redhat.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/include/asm/kvm_host.h | 25 +++++++++++++++++++++----
>>  1 file changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>> index fd006a2..f3a9b5a 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -685,11 +685,28 @@ struct kvm_s390_crypto {
>>  	__u8 dea_kw;
>>  };
>>  
>> +#define APCB0_MASK_SIZE 1
>> +struct kvm_s390_apcb0 {
>> +	__u64 apm[APCB0_MASK_SIZE];		/* 0x0000 */
>> +	__u64 aqm[APCB0_MASK_SIZE];		/* 0x0008 */
>> +	__u64 adm[APCB0_MASK_SIZE];		/* 0x0010 */
>> +	__u64 reserved18;			/* 0x0018 */
>> +};
>> +
>> +#define APCB1_MASK_SIZE 4
>> +struct kvm_s390_apcb1 {
>> +	__u64 apm[APCB1_MASK_SIZE];		/* 0x0000 */
>> +	__u64 aqm[APCB1_MASK_SIZE];		/* 0x0020 */
>> +	__u64 adm[APCB1_MASK_SIZE];		/* 0x0040 */
>> +	__u64 reserved60[4];			/* 0x0060 */
>> +};
>> +
>>  struct kvm_s390_crypto_cb {
>> -	__u8    reserved00[72];                 /* 0x0000 */
>> -	__u8    dea_wrapping_key_mask[24];      /* 0x0048 */
>> -	__u8    aes_wrapping_key_mask[32];      /* 0x0060 */
>> -	__u8    reserved80[128];                /* 0x0080 */
>> +	struct kvm_s390_apcb0 apcb0;		/* 0x0000 */
>> +	__u8   reserved20[0x0048 - 0x0020];	/* 0x0020 */
>> +	__u8   dea_wrapping_key_mask[24];	/* 0x0048 */
>> +	__u8   aes_wrapping_key_mask[32];	/* 0x0060 */
>> +	struct kvm_s390_apcb1 apcb1;		/* 0x0080 */
> 
> Thought you wanted to fix the indentation?

I did, reserved starts now in the same column as kvm_s390_apcb* and *_wrapping_key_mask,
instead of at a different column as v1.
So you would have preferred only _one_ space between __u8 and reserver*, I guess?

Could do, but I would prefer to not respin the tag and the branch just for that.
