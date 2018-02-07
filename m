From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 2/6] KVM: s390: provide only a single function for
 setting the tod
Date: Wed, 7 Feb 2018 15:15:54 -0500
Message-ID: <60c33583-2f28-1a3b-457a-b5a987e36054@linux.vnet.ibm.com>
References: <20180207114647.6220-1-david@redhat.com>
 <20180207114647.6220-3-david@redhat.com>
 <58ec2151-e95d-1286-e2ab-a958e6afcd2d@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <58ec2151-e95d-1286-e2ab-a958e6afcd2d@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 02/07/2018 03:13 PM, Collin L. Walling wrote:
> On 02/07/2018 06:46 AM, David Hildenbrand wrote:
>> [...]
>>
>> @@ -3021,8 +3019,8 @@ static int kvm_s390_handle_requests(struct 
>> kvm_vcpu *vcpu)
>>       return 0;
>>   }
>>
>> -void kvm_s390_set_tod_clock_ext(struct kvm *kvm,
>> -                 const struct kvm_s390_vm_tod_clock *gtod)
>> +void kvm_s390_set_tod_clock(struct kvm *kvm,
>> +                const struct kvm_s390_vm_tod_clock *gtod)
> Nit: off by one space --------^
or perhaps my email client is lying to me? ignore my comment if it looks 
fine on your end.



-- 
- Collin L Walling
