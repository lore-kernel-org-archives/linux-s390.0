Return-Path: <SRS0=UIqJ=SO=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH 1/7] s390: zcrypt: driver callback to indicate resource in
 use
References: <1555016604-2008-1-git-send-email-akrowiak@linux.ibm.com>
 <1555016604-2008-2-git-send-email-akrowiak@linux.ibm.com>
 <223c82c7-6a75-7209-3652-c2341c83878f@linux.ibm.com>
 <20190412114313.0156c01b.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Fri, 12 Apr 2019 15:38:21 -0400
MIME-Version: 1.0
In-Reply-To: <20190412114313.0156c01b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <89f09e58-eab6-94d4-c5aa-937162d60744@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Reinhard Buendgen <buendgen@de.ibm.com>, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com
List-ID: <linux-s390.vger.kernel.org>

On 4/12/19 5:43 AM, Cornelia Huck wrote:
> On Fri, 12 Apr 2019 08:54:54 +0200
> Harald Freudenberger <freude@linux.ibm.com> wrote:
> 
>> On 11.04.19 23:03, Tony Krowiak wrote:
>>> Introduces a new driver callback to prevent a root user from unbinding
>>> an AP queue from its device driver if the queue is in use. This prevents
>>> a root user from inadvertently taking a queue away from a guest and
>>> giving it to the host, or vice versa. The callback will be invoked
>>> whenever a change to the AP bus's apmask or aqmask sysfs interfaces may
>>> result in one or more AP queues being removed from its driver. If the
>>> callback responds in the affirmative for any driver queried, the change
>>> to the apmask or aqmask will be rejected with a device in use error.
>>>
>>> For this patch, only non-default drivers will be queried. Currently,
>>> there is only one non-default driver, the vfio_ap device driver. The
>>> vfio_ap device driver manages AP queues passed through to one or more
>>> guests and we don't want to unexpectedly take AP resources away from
>>> guests which are most likely independently administered.
>>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Hello Tony
>>
>> you are going out with your patches but ... what is the result of the discussions
>> we had in the past ? Do we have a common understanding that we want to have
>> it this way ? A driver which is able to claim resources and the bus code
>> has lower precedence ?

This is what Reinhard suggested and what we agreed to as a team quite
some time ago. I submitted three versions of this patch to our
internal mailing list, all of which you reviewed, so I'm not sure
why you are surprised by this now.

> 
> I don't know about previous discussions, but I'm curious how you
> arrived at this design. A driver being able to override the bus code
> seems odd. Restricting this to 'non-default' drivers looks even more
> odd.
> 
> What is this trying to solve? Traditionally, root has been able to
> shoot any appendages of their choice. I would rather expect that in a
> supported setup you'd have some management software keeping track of
> device usage and making sure that only unused queues can be unbound. Do
> we need to export more information to user space so that management
> software can make better choices?

Is there a reason other than tradition to prevent root from accidentally
shooting himself in the foot or any other appendage? At present,
sysfs is the only supported setup, so IMHO it makes sense to prevent as
much accidentally caused damage as possible in the kernel.

> 
>>
>>> ---
>>>   drivers/s390/crypto/ap_bus.c | 138 +++++++++++++++++++++++++++++++++++++++++--
>>>   drivers/s390/crypto/ap_bus.h |   3 +
>>>   2 files changed, 135 insertions(+), 6 deletions(-)
> 
