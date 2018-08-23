From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] KVM: s390: vsie: copy wrapping keys to right place
Date: Thu, 23 Aug 2018 13:41:40 +0200
Message-ID: <bffd3862-856f-4f9a-6f27-d91ca8a0b5ec@linux.ibm.com>
References: <1535019956-23539-1-git-send-email-pmorel@linux.ibm.com>
 <1535019956-23539-2-git-send-email-pmorel@linux.ibm.com>
 <853c73ab-3221-e0ee-af30-8e11fefbebd7@de.ibm.com>
 <d2e4bed0-666d-24b4-cc57-84a4c9f1f93b@redhat.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d2e4bed0-666d-24b4-cc57-84a4c9f1f93b@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 23/08/2018 13:19, David Hildenbrand wrote:
> On 23.08.2018 13:07, Christian Borntraeger wrote:
>>
>>
>> On 08/23/2018 12:25 PM, Pierre Morel wrote:
>>> Copy the key mask to the right offset inside the shadow CRYCB
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
>>
>> This should be cc stable I guess?
>>
> 
> Yes, g3 guests will be run with same wrapping keys.
> 

OK I do send it separated from the other patches.

regard,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
