From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v11 26/26] s390: doc: detailed specifications for AP
 virtualization
Date: Thu, 27 Sep 2018 09:12:39 -0400
Message-ID: <0c036788-9d0e-90b2-8708-98f7ff4036ad@linux.ibm.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
 <20180925231641.4954-27-akrowiak@linux.vnet.ibm.com>
 <20180926164222.74731b74@t450s.home>
 <c4caf272-f9ef-ce61-bb0d-0b94bbf3ea84@linux.ibm.com>
 <20180927135141.0fa87f2c.cohuck@redhat.com>
 <c18dbe70-63eb-1f6d-8470-124e967b0bfa@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c18dbe70-63eb-1f6d-8470-124e967b0bfa@de.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 09/27/2018 07:59 AM, Christian Borntraeger wrote:
> 
> 
> On 09/27/2018 01:51 PM, Cornelia Huck wrote:
>> On Thu, 27 Sep 2018 13:29:43 +0200
>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>
>>> On 09/27/2018 12:42 AM, Alex Williamson wrote:
>>>> On Tue, 25 Sep 2018 19:16:41 -0400
>>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>>> +   This is how the matrix is configured for Guest2:
>>>>> +
>>>>> +      echo 5 > assign_adapter
>>>>> +      echo 0x47 > assign_domain
>>>>> +      echo 0xff > assign_domain
>>>>> +
>>>>> +   This is how the matrix is configured for Guest3:
>>>>> +
>>>>> +      echo 6 > assign_adapter
>>>>> +      echo 0x47 > assign_domain
>>>>> +      echo 0xff > assign_domain
>>>>> +
>>>>
>>>> I'm curious why this interface didn't adopt the +/- notation invented
>>>> above for consistency.  Too difficult to do rollbacks with a string on
>>>> entries?
>>>>    
>>>
>>> I remember that we did discuss that possibility around v9, but I can't
>>> tell why did we decide to not implement it. Maybe Tony has an answer.
>>
>> IIRC, that was a discussion on the base ap driver interfaces rather
>> than vfio-ap.
>>
>>>
>>> Anyway, if we were to do that, we would use different attribute names
>>> (e.g. just domain_mask, or something similar instead of
>>> (assign|unassign)_xxx). So I think such an interface can still be added
>>> on top of the existing one. Having that said having multiple interfaces
>>> for the very same thing is usually not so nice IMHO.
>>
>> Nod to all of your points.
>>
>> As we do the configuration while the guest is not running anyway, the
>> different interfaces probably do not make that much difference in
>> practice. It should be fine to stick to the current interface for now
>> and only add a new one if we really think it is significantly better.
> 
> Tony, can you maybe provide a quick on-top patch that clarifies Alex
> comments regarding the documentation? (State that is is big endian,
> fixup the small things etc).
> I can then either fold it in or provide it as an on top patch depending
> on how much has changed.

Will do.

> 
