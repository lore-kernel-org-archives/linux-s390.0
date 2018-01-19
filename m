From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 04/12] KVM: s390: implement GISA IPM related primitives
Date: Fri, 19 Jan 2018 11:16:10 +0100
Message-ID: <c952d37f-82cf-d0da-4bf4-9818c508d0aa@redhat.com>
References: <20180116200217.211897-1-borntraeger@de.ibm.com>
 <20180116200217.211897-5-borntraeger@de.ibm.com>
 <249b3566-b8f3-5825-1f2b-6e0662874ca0@redhat.com>
 <bcc245f6-c29d-4ee7-2050-9e2f29be7b94@linux.vnet.ibm.com>
 <28160f0a-4056-626e-2b83-0e6f039f27fc@redhat.com>
 <2e96491f-c73e-2782-17b0-5d9764ecf5d7@linux.vnet.ibm.com>
 <46713077-a46c-c3e3-45d7-ad4dc4cbce2e@redhat.com>
 <20180119101132.GA4519@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180119101132.GA4519@osiris>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: mimu@linux.vnet.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 19.01.2018 11:11, Heiko Carstens wrote:
> On Thu, Jan 18, 2018 at 09:45:03PM +0100, David Hildenbrand wrote:
>> Actually, the problem is there are no atomic byte-based operations on
>> s390x without Interlocked-Access-Facility 2.
>>
>> Even __sync_fetch_and_or(&gisa->ipm, value) falls back to a
>> Compare-And-Swap loop. And Compare-And-Swap also operates at least on 32bit.
>>
>> So I assume there isn't too much we can do about it. As storage
>> locations following the u8 are also written - but in an atomic matter,
>> it should in general not matter.
>>
>> But can we avoid starting the bitmap at the beginning of the gisa?
>>
>> What about something like this:
>>
>> +void kvm_s390_gisa_set_ipm_gisc(struct kvm_s390_gisa *gisa, u8 gisc)
>> +{
>> +       set_bit_inv(gisc, (unsigned long *) &gisa->ipm);
>> +}
> 
> set_bit_inv() may use a csg instruction which requires an 8 byte alignment
> of the operand. What you propose would crash immediately.
> 
> The code written by Michael is fine as-is.
> 

That's unfortunate... and still looks hacky to me :) But if it works ...

-- 

Thanks,

David / dhildenb
