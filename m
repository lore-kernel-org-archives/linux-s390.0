From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 2/5] KVM: s390: SIE considerations for AP Queue
 virtualization
Date: Thu, 9 Nov 2017 09:59:17 +0100
Message-ID: <c1e6bed6-cf90-347b-2890-ad21a058d0bf@de.ibm.com>
References: <20171108084143.78654-1-borntraeger@de.ibm.com>
 <20171108084143.78654-3-borntraeger@de.ibm.com>
 <a9b92e42-35c4-1fff-571c-68397cb0d758@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <a9b92e42-35c4-1fff-571c-68397cb0d758@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 11/08/2017 10:29 AM, David Hildenbrand wrote:
> On 08.11.2017 09:41, Christian Borntraeger wrote:
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
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/include/asm/kvm_host.h | 25 +++++++++++++++++++++----
>>  1 file changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>> index fd006a2..646e1fe 100644
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
> 
> Do these really have to be arrays? Also, size usually specifies bytes
> and not double words (applies also to the one definition below).

This is later used with bit operations (e.g. see [RFC 16/19] KVM: s390: interface to configure KVM guest's AP matrix)
which operate on "long *", so I think its better than a char array.


> 
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
>> +	__u8    reserved20[40];			/* 0x0020 */
> 
> Not sure if should turn this into [0x0048 - 0x0020], just like we do for
> e.g. lowcore. But maybe the specification explicitly states "40 bytes
> reserved". The 40 makes sense.

Yes [0x0048 - 0x0020] looks better, will change.

> 
>> +	__u8    dea_wrapping_key_mask[24];	/* 0x0048 */
>> +	__u8    aes_wrapping_key_mask[32];	/* 0x0060 */
>> +	struct kvm_s390_apcb1 apcb1;		/* 0x0080 */
>>  };
> 
> While touching all lines, can we get rid of the strange indentation
> after __u8?

yes, will also fix.

Thanks
