From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v3 2/3] KVM: s390: vsie: Do the CRYCB validation first
Date: Thu, 23 Aug 2018 13:42:13 +0200
Message-ID: <c4a38dfb-6c78-268c-54b9-4581a292ee1a@linux.ibm.com>
References: <1535019956-23539-1-git-send-email-pmorel@linux.ibm.com>
 <1535019956-23539-3-git-send-email-pmorel@linux.ibm.com>
 <b7c0b0eb-c750-caeb-41b5-d6593791a6ef@de.ibm.com>
 <cb8adf11-2bb3-4e00-ceab-f9d55c4d4f44@redhat.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cb8adf11-2bb3-4e00-ceab-f9d55c4d4f44@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 23/08/2018 13:19, David Hildenbrand wrote:
> On 23.08.2018 13:17, Christian Borntraeger wrote:
>>
>>
>> On 08/23/2018 12:25 PM, Pierre Morel wrote:
>>> When entering the SIE the CRYCB validation better
>>> be done independently of the instruction's
>>> availability.
>>
>> Maybe something like
>>
>> We need to handle the validity checks for the crycb, no matter what the
>> settings for the keywrappings are. So lets move the keywrapping checks
>> after we have done the validy checks.
>>
>> ?
> 
> With that
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> 

Thanks, I use the description proposed by Christian.

regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
