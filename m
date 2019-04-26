Return-Path: <SRS0=JTmC=S4=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH] KVM: s390: vsie: Return correct values for Invalid CRYCB
 format
References: <1556269201-22918-1-git-send-email-pmorel@linux.ibm.com>
 <0fa39d6a-f74e-e0b7-ded9-948d1576a2b9@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 26 Apr 2019 12:54:06 +0200
MIME-Version: 1.0
In-Reply-To: <0fa39d6a-f74e-e0b7-ded9-948d1576a2b9@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <024bb479-a731-5372-2832-108e0670950d@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 26/04/2019 11:07, David Hildenbrand wrote:
> On 26.04.19 11:00, Pierre Morel wrote:
>> Let's use the correct validity number.
>>
>> Fixes: 55ded154b43 "KVM: s390: vsie: Allow CRYCB FORMAT-2"
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   arch/s390/kvm/vsie.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>> index ac411e9..076090f 100644
>> --- a/arch/s390/kvm/vsie.c
>> +++ b/arch/s390/kvm/vsie.c
>> @@ -344,7 +344,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>   end:
>>   	switch (ret) {
>>   	case -EINVAL:
>> -		return set_validity_icpt(scb_s, 0x0020U);
>> +		return set_validity_icpt(scb_s, 0x0022U);
>>   	case -EFAULT:
>>   		return set_validity_icpt(scb_s, 0x0035U);
>>   	case -EACCES:
>>
> 
> Can't verify
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 

Thanks.

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
