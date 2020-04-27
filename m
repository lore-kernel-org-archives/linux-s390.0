Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v7 03/15] s390/zcrypt: driver callback to indicate
 resource in use
References: <20200407192015.19887-1-akrowiak@linux.ibm.com>
 <20200407192015.19887-4-akrowiak@linux.ibm.com>
 <75bcbc06-f38f-1aff-138f-5d2a2dd3f7b6@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <162f7dbc-9dd0-0a42-0d1a-8412a9a848e7@linux.ibm.com>
Date: Mon, 27 Apr 2020 18:24:19 -0400
MIME-Version: 1.0
In-Reply-To: <75bcbc06-f38f-1aff-138f-5d2a2dd3f7b6@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com, fiuczy@linux.ibm.com



On 4/27/20 4:20 AM, Pierre Morel wrote:
>
>
> On 2020-04-07 21:20, Tony Krowiak wrote:
>> Introduces a new driver callback to prevent a root user from unbinding
>> an AP queue from its device driver if the queue is in use. The intent of
>> this callback is to provide a driver with the means to prevent a root 
>> user
>> from inadvertently taking a queue away from a guest and giving it to the
>> host while the guest is still using it.
>
> How can we know, at this point if the guest uses or not the queue?

The struct ap_matrix_mdev has a field, struct kvm *kvm, which holds a 
pointer to KVM when
the matrix mdev is in use by a guest. This patch series also introduces 
a shadow_crycb (soon to
be shadow_apcb) which holds the AP configuration for the guest. Between 
those two things,
the driver can detect when a queue is in use by a guest.

> Do you want to say that this prevents to take away a queue when it is 
> currently assigned to a VFIO device?
> and with a guest currently using this VFIO device?

No, I do not. The intent here is to enforce the proper procedure for 
giving up a queue so it is done
deliberately. Before taking a queue away from the matrix mdev, its APQN 
should be unassigned
from the matrix mdev. That is not to say that if there are major 
objections to this that we can't
base in_use upon the queue being in use by a guest at the time. Maybe 
that is preferable to
the community. I'll leave it to them to state their case.

>
>> The callback will
>> be invoked whenever a change to the AP bus's sysfs apmask or aqmask
>> attributes would result in one or more AP queues being removed from its
>> driver. If the callback responds in the affirmative for any driver
>> queried, the change to the apmask or aqmask will be rejected with a 
>> device
>> in use error.
>
> AFAIU you mean that Linux's driver's binding and unbinding mechanism 
> is not sufficient to avoid this issue because unbind can not be 
> refused by the driver.

Correct!

>
>
> The reason why we do not want a single queue to be removed from the 
> VFIO driver is because the VFIO drivers works on a matrix, not on 
> queues, and for the matrix to be consistent it needs to acquire all 
> queues defined by the cross product of all APID and AQID assigned to 
> the matrix.

Not correct. The reason why is because we do not want a queue to be 
surreptitiously removed
without the guest administrator being aware of its removal.

>
> This functionality is valid for the host as for the guests and is 
> handled automatically by the firmware with the CRYCB.
> The AP bus uses QCI to retrieve the host CRYCB and build the hosts AP 
> queues.
>
> If instead to mix VFIO CRYCB matrix handling and queues at the same 
> level inside the AP bus we separate these different firmware entities 
> in two different software entities.
>
> If we make the AP bus sit above a CRYCB/Matrix bus, and in the way 
> virtualize the QCI and test AP queue instructions:
> - we can directly pass a matrix device to the guest though a VFIO 
> matrix device
> - the consistence will be automatic
> - the VFIO device and parent device will be of the same kind which 
> would make the design much more clearer.
> - there will be no need for these callback because the consistence of 
> the matrix will be guaranteed by firmware

As stated in my response above, the issue here is not consistency. While 
the design you describe
may be reasonable, it is a major departure from what is out in the 
field. In other words, that ship
has sailed.

>
>
>>
>> For this patch, only non-default drivers will be queried. Currently,
>> there is only one non-default driver, the vfio_ap device driver.
>
> You mean that the admin may take queues away from the "default 
> driver", while the queue is in use, to give it to an other driver?
> Why is it to avoid in one way and not in the other way?

Because the default drivers have direct control over the queues and can 
ensure they are empty
and reset before giving up control. The vfio driver does not have direct 
control over the queues
because they have been passed through to the guest.

>
>> The
>> vfio_ap device driver manages AP queues passed through to one or more
>> guests
>
> I read this as if a queue may be passed to several guest...
> please, rephrase or explain.

AP queues is plural, so it is true that AP queues can be passed through
to more than one guest. I see your point, however, so I'll reword that
to be more clear.

>
>> and we don't want to unexpectedly take AP resources away from
>> guests which are most likely independently administered.
>
> When you say "independently administered", you mean as a second admin 
> inside the host, don't you?

I mean that a guest can be administered by a different person than the 
host administrator.
Again, I'll try to clarify this.

>
>
> Regards,
> Pierre
>
