From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v10 13/26] s390: vfio-ap: zeroize the AP queues
Date: Mon, 24 Sep 2018 12:42:38 -0400
Message-ID: <6f04d759-7bc8-cf96-30ba-81621572e7d3@linux.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-14-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180924133611.01fef50e.cohuck@redhat.com>
 <b2eae775-0917-8c71-4ecf-6ef921ac9b0b@linux.ibm.com>
 <113e07ba-370e-bdcf-4e85-412834947552@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <113e07ba-370e-bdcf-4e85-412834947552@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 09/24/2018 09:22 AM, Harald Freudenberger wrote:
> On 24.09.2018 14:16, Halil Pasic wrote:
>>
>> On 09/24/2018 01:36 PM, Cornelia Huck wrote:

(...)

>>> ...and here, we return the last error of any of the resets. Two
>>> questions:
>>>
>>> - Does it make sense to continue if we get -EIO? IOW, does "really
>>>    broken" only refer to a certain tuple and other tuples still can/need
>>>    to be reset?
>> I think it does make sense to continue, because IMHO "things are really
>> broken" is an overstatement (I mean the APQN invalid case). One could
>> argue would skipping the current card (adapter) be justified or not.
>>
>> IMHO the current code is good enough for the first shot, and we can think
>> about fine-tuning it later.
> Absolutely. The -EIO case is reached for example when the APQN
> is 'deconfigured' which means the crypto adapter is logically unplugged.
> So the -EIO case should NOT lead to some fatal actions like panic()
> or cause a KVM guest to shut down or so.
>>> - Is the return code useful in any way, as we don't know which tuple it
>>>    refers to?
>>>
>> Well, good question. It conveys that the operation can 'fail'. AFAIR -EBUSY
>> is mostly fine given what the architecture say if we are satisfied with just
>> reset. And the cases behind -EIO might actually be OK too in the same sense.
>> My guess is, that based on the return value client code can tell if we have
>> zeroize for all queues or basically just reset (like rapq). We could log that
>> to some debug facility or whatever -- I guess, but at the moment we don't care.
>>
>> In the end I think the code is good enough as is, and if we want we can
>> improve on it later.
>>
>> Regards,
>> Halil
>>

I'll note that in v7 a message was logged to indicate for which APQN the 
error occurred, but I was asked to remove the printk log messsages. I 
agree with Halil and Harald confirmed that the code is probably okay as 
it stands. I can definitely see enhancing all of AP virtualization down 
the road with some type of debug logging.

> 
