From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 15/15] s390: doc: detailed specifications for AP
 virtualization
Date: Tue, 17 Apr 2018 12:37:19 -0400
Message-ID: <c15ce906-70b9-0462-e6e0-0bd3b77387d0@linux.vnet.ibm.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1523827345-11600-16-git-send-email-akrowiak@linux.vnet.ibm.com>
 <04a0cf49-71a1-214a-7261-d8e55adee1de@linux.vnet.ibm.com>
 <65d3b123-7a0a-4de3-687f-5b6707e797f7@linux.vnet.ibm.com>
 <53283f8e-52b5-5653-044c-843b5b033a1e@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53283f8e-52b5-5653-044c-843b5b033a1e@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 04/17/2018 12:25 PM, Pierre Morel wrote:
> On 17/04/2018 18:14, Tony Krowiak wrote:
>> On 04/16/2018 09:13 AM, Pierre Morel wrote:
>>> On 15/04/2018 23:22, Tony Krowiak wrote:
>>>> This patch provides documentation describing the AP architecture and
>>>> design concepts behind the virtualization of AP devices. It also
>>>>
> ...snip...
>>>> +The process for reserving an AP queue for use by a KVM guest is:
>>>> +
>>>> +* The vfio-ap driver during its initialization will perform the 
>>>> following:
>>>> +  * Create the 'vfio_ap' root device - /sys/devices/vfio_ap
>>>> +  * Create the 'matrix' device in the 'vfio_ap' root
>>>> +  * Register the matrix device with the device core
>>>> +* Register with the ap_bus for AP queue devices of type CEX4, CEX5 
>>>> and
>>>> +  CEX6 and to provide the vfio_ap driver's probe and remove 
>>>> callback interfaces.
>>>
>>> I wonder why the type of card has anything to do with this driver.
>>> It should be transparent, the driver should be able to provide the 
>>> matrix (APM/AQM/ADM)
>>> independently from the type of card in the slot.
>>
>> We've been down this road several times before. We are only 
>> supporting virtualization of
>> CEX4 and newer cards. Also, the AP bus requires registering for 
>> specific card types.
>
> Yes I know, but the AP BUS design may be not the optimal for the AP 
> Matrix.
> The AP Matrix is device independent.
> We just write/clear bits in a matrix and we do not care what is plugged.
>
> So may be make clear that this device dependence is due to the actual 
> AP BUS interface design.

Okay, will do.

>
>>
>>>
>>>
>>> Regards,
>>>
>>> Pierre
>>>
>>
>
