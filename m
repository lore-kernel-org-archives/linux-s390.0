From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v6 21/21] s390: doc: detailed specifications for AP
 virtualization
Date: Tue, 10 Jul 2018 10:49:08 +0200
Message-ID: <fa82b7e9-b6c5-440e-422d-cf3ad8c08757@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-22-git-send-email-akrowiak@linux.vnet.ibm.com>
 <753c5e17-c241-580d-6e3a-a3c3159d44a8@linux.ibm.com>
 <0580735b-8813-f860-a2ac-654d82203b35@linux.ibm.com>
 <2e30976a-a2d0-c407-c491-acde565b63f1@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2e30976a-a2d0-c407-c491-acde565b63f1@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 09/07/2018 17:50, Halil Pasic wrote:
>
>
> On 07/09/2018 05:21 AM, Pierre Morel wrote:
>> On 03/07/2018 01:10, Halil Pasic wrote:
>>>
>>>
>>> On 06/29/2018 11:11 PM, Tony Krowiak wrote:
>>>> This patch provides documentation describing the AP architecture and
>>>> design concepts behind the virtualization of AP devices. It also
>>>> includes an example of how to configure AP devices for exclusive
>>>> use of KVM guests.
>>>>
>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>>
>>> I don't like the design of external interfaces except for:
>>> * cpu model features, and
>>> * reset handling.
>>>
>>> In particular:
>>>
>>>
>> ...snip...
>>
>>> 4) If I were to act out the role of the administrator, I would 
>>> prefer to think of
>>> specifying or changing the access controls of a guest in respect to 
>>> AP (that is
>>> setting the AP matrix) as a single atomic operation -- which either 
>>> succeeds or fails.
>>>
>>> The operation should succeed for any valid configuration, and fail 
>>> for any invalid
>>> on.
>>>
>>> The current piecemeal approach seems even less fitting if we 
>>> consider changing the
>>> access controls of a running guest. AFAIK changing access controls 
>>> for a running
>>> guest is possible, and I don't see a reason why should we 
>>> artificially prohibit this.
>>>
>>> I think the current sysfs interface for manipulating the matrix is 
>>> good for
>>> manual playing around, but I would prefer having an interface that 
>>> is better
>>> suited for programs (e.g. ioctl).
>>
>> I disagree with using ioctl.
>
> Why? What speaks against ioctl?

Using a sysfs interface is easy and can be done using any interpreted 
language.
It has become the standard way to configure drivers.
Even the existing interface must be consolidated, it exist and is 
functional.


For what I understood, the problem is to have an atomic update of the 
matrix to avoid possible dead-lock
when two admin tasks try to configure a matrix for a guest.

The problematic is a userland problem it is not a kernel problem.

We have several possibilities to avoid this problem but  still keep a 
sysfs interface:
- the admin tasks may use a lock
- the admin task may use a policy like freeing owned resources if they 
can not get all resources.

Using a step by step configuration allows to easily know the missing 
resource in case of failure.

Regards,

Pierre


>
>> I agree that the current implementation is not right.
>> The configuration of APM and AQM should always be guarantied as coherent
>> within the host but it can be done doing the right checks when using 
>> the sysfs.
>>
>
> I'm glad we agree on this one at least.
>
> Regards,
> Halil


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
