From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v5 10/13] s390: vfio-ap: sysfs interface to view matrix
 mdev matrix
Date: Tue, 5 Jun 2018 14:40:44 +0200
Message-ID: <32340d2a-bea6-bdb1-38a6-76afe3d54672@linux.ibm.com>
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-11-git-send-email-akrowiak@linux.vnet.ibm.com>
 <a6bba129-8a3c-a848-65aa-b67816bf2d25@linux.ibm.com>
 <53275110-45fb-d50f-c97e-93141378f094@linux.vnet.ibm.com>
 <89bda651-d465-af50-a737-1900a54b01c8@linux.ibm.com>
 <6f67a282-773d-3fca-5b36-cc23ad49ba5b@linux.vnet.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6f67a282-773d-3fca-5b36-cc23ad49ba5b@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 30/05/2018 16:28, Tony Krowiak wrote:
> On 05/24/2018 05:10 AM, Pierre Morel wrote:
>> On 23/05/2018 16:38, Tony Krowiak wrote:
>>> On 05/16/2018 03:55 AM, Pierre Morel wrote:
>>>> On 07/05/2018 17:11, Tony Krowiak wrote:
>>>>> Provides a sysfs interface to view the AP matrix configured for the
>>>>> mediated matrix device.
>>>>>
>>>>> The relevant sysfs structures are:
>>>>>
>>>>> /sys/devices/vfio_ap
>>>>> ... [matrix]
>>>>> ...... [mdev_supported_types]
>>>>> ......... [vfio_ap-passthrough]
>>>>> ............ [devices]
>>>>> ...............[$uuid]
>>>>> .................. matrix
>>>>>
>>>>> To view the matrix configured for the mediated matrix device,
>>>>> print the matrix file:
>>>>
>>>> This is the configured matrix, not the one used by the guest.
>>>> Nothing in the patches protect against binding a queue and assigning
>>>> a new AP when the guest runs.
>>>> The card and queue will be showed by this entry.
>>>
>>> Of course, as stated above, this is the matrix configured for the
>>> mediated matrix device. Are you suggesting here that the driver
>>> should prevent assigning a new adapter or domain while a guest is
>>> running? Couldn't this be a step in the process for hot (un)plugging
>>> AP queues?
>>
>> No, I mean what is the point to show this?
>> It is not what the guest sees.
>> Has it any use case?
>
> The point is to display the matrix so one can view the AP queues that
> have been assigned to the mediated matrix device. This is the only way
> to view the matrix. Do you not find value in being able to see what
> has been assigned to the mediated matrix device?

Two things:
1) I think it is better to retrieve the individual masks
2) As I said above, what you show is not the effective mask used by the 
guest




-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
