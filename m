From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 3/3] KVM: s390: vsie: Make use of CRYCB FORMAT2 clear
Date: Thu, 23 Aug 2018 14:03:44 +0200
Message-ID: <b77da080-fed2-6ef1-ed35-f648b25da95a@redhat.com>
References: <1535019956-23539-1-git-send-email-pmorel@linux.ibm.com>
 <1535019956-23539-4-git-send-email-pmorel@linux.ibm.com>
 <912d013c-c925-fb3e-ed1d-2d778a60c189@linux.ibm.com>
 <f4c9634d-f442-447a-9eed-7d0f4e72c34f@redhat.com>
 <58427761-072c-e420-a881-4decbe9088bb@linux.ibm.com>
 <e0b80820-b4cd-5f51-bd57-ea6e2e638a40@linux.ibm.com>
 <6fb830bb-0241-dd3c-6356-6b9d4ce676ee@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6fb830bb-0241-dd3c-6356-6b9d4ce676ee@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, pmorel@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 23.08.2018 13:53, Janosch Frank wrote:
> On 8/23/18 1:47 PM, Pierre Morel wrote:
>> On 23/08/2018 13:33, Janosch Frank wrote:
>>> On 8/23/18 1:21 PM, David Hildenbrand wrote:
>>>> On 23.08.2018 13:05, Janosch Frank wrote:
>>>>> On 8/23/18 12:25 PM, Pierre Morel wrote:
>>>>>> The comment preceding the shadow_crycb function is
>>>>>> misleading, we effectively accept FORMAT2 CRYCB in the
>>>>>> guest.
>>>>>
>>>>> I beg to differ:
>>>>>
>>>>> if (!(crycbd_o & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
>>>>> 		return 0;
>>>>
>>>> FORMAT2 includes bit FORMAT1 (backwards compatible)
>>>
>>> Right, this check is very misleading because of the constant, we
>>> effectively test against Format 0 and Format 2.
>>>
>>> Can we make this clearer by explicitly ANDing 0x01 or adding a comment?
>>
>> yes, done, I modified the comment in front of the function.
> 
> Which is not what I want, what I want is:
> 
> /* CRYCB_FORMAT2 includes the bit for CRYCB_FORMAT1, so we allow both
> formats here */
> if (!(crycbd_o & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
> 	return 0;

While it's not wrong, it is also not required. And it might soon be
obsolete again (with APXA, as you said, there we always have to check).

But I'll leave that to you

-- 

Thanks,

David / dhildenb
