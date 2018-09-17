From: David Hildenbrand <david@redhat.com>
Date: Mon, 17 Sep 2018 07:58:03 +0000
Subject: Re: [PATCH 3/3] s390/kvm: set host program identifier
Message-Id: <e3a0a9ba-980f-12e3-785c-35d7341ac23b@redhat.com>
In-Reply-To: <ea5ade54-3281-a35f-b78b-181bbd017b67@de.ibm.com>
References: <ea5ade54-3281-a35f-b78b-181bbd017b67@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Am 17.09.18 um 09:54 schrieb Christian Borntraeger:
> 
> 
> On 09/17/2018 09:46 AM, David Hildenbrand wrote:
>> Am 04.09.18 um 13:16 schrieb Christian Borntraeger:
>>> Changed subject to KVM: s390: .... and modified the commit message.
>>>
>>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>
>>> Patch 3 applied and scheduled for >4.19 (kvm/next).
>>>
>>
>> Christian, is it okay to set this field even without HW support?
>>
>> (I slightly remember that certain reserved fields should remain
>> untouched if there is no HW support for them, maybe I am wrong or this
>> does not apply here)
> 
> Yes, there is no scp bit for this, it can be set unconditionally.
> 

Thanks, feel free to add

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
