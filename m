From: Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH v5 06/15] KVM: s390: remove prefix kvm_s390_gisa_ from
 static inline functions
Date: Thu, 20 Dec 2018 15:37:01 +0100
Message-ID: <49e2b16f-23a3-73a8-75b1-b03d5c9ad8a2@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
 <20181219191756.57973-7-mimu@linux.ibm.com>
 <20181220132430.7cea69d3.cohuck@redhat.com>
Reply-To: mimu@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181220132430.7cea69d3.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 20.12.18 13:24, Cornelia Huck wrote:
> On Wed, 19 Dec 2018 20:17:47 +0100
> Michael Mueller <mimu@linux.ibm.com> wrote:
> 
>> This will shorten the length of code lines.
>> All GISA related static inline functions are local to interrupt.c
>>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> ---
>>   arch/s390/kvm/interrupt.c | 26 +++++++++++++-------------
>>   1 file changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>> index 4ab20d2eb180..9b1fa39b6f90 100644
>> --- a/arch/s390/kvm/interrupt.c
>> +++ b/arch/s390/kvm/interrupt.c
>> @@ -224,22 +224,22 @@ static inline u8 int_word_to_isc(u32 int_word)
>>    */
>>   #define IPM_BIT_OFFSET (offsetof(struct kvm_s390_gisa, ipm) * BITS_PER_BYTE)
>>   
>> -static inline void kvm_s390_gisa_set_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
>> +static inline void set_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
>>   {
>>   	set_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
>>   }
>>   
>> -static inline u8 kvm_s390_gisa_get_ipm(struct kvm_s390_gisa *gisa)
>> +static inline u8 get_ipm(struct kvm_s390_gisa *gisa)
>>   {
>>   	return READ_ONCE(gisa->ipm);
>>   }
>>   
>> -static inline void kvm_s390_gisa_clear_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
>> +static inline void clear_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
>>   {
>>   	clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
>>   }
>>   
>> -static inline int kvm_s390_gisa_tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
>> +static inline int tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
>>   {
>>   	return test_and_clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
>>   }
> 
> I don't disagree with making them shorter, but I think the code would
> be more readable if you only dropped the kvm_s390_ prefix and kept
> annotating the functions as gisa_.

applied

> 
