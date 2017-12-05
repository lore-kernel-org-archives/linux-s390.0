From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [RFC 00/19] KVM: s390/crypto/vfio: guest dedicated crypto
 adapters
Date: Tue, 5 Dec 2017 10:09:25 -0500
Message-ID: <9c26da66-2d78-0e0f-a4cd-a943ec6283b0@linux.vnet.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <5baf5f90-6cac-3c09-7b66-1bc8b30b8093@linux.vnet.ibm.com>
 <20171114145722.4ab850a5.cohuck@redhat.com>
 <fcfd6a27-662b-9a30-8bad-adaac4cf0ce1@linux.vnet.ibm.com>
 <8a492b07-3d3b-f4cf-e139-7de345ea8188@linux.vnet.ibm.com>
 <20171116180308.289e5eed.cohuck@redhat.com>
 <c8f6768f-b916-fb29-f166-9ca41916e4c3@linux.vnet.ibm.com>
 <1476b0a4-a2a3-2c48-107a-ab7b39b0e93e@linux.vnet.ibm.com>
 <0b40cee7-78d3-f96b-ab46-1f40b31251cb@linux.vnet.ibm.com>
 <20171117110742.1d416435.cohuck@redhat.com>
 <a4b3c3d1-0806-6ba3-4739-c2a1677b9bfd@linux.vnet.ibm.com>
 <20171120181345.3fbda311.cohuck@redhat.com>
 <c95a906b-a174-0643-4013-906a1e4b9307@linux.vnet.ibm.com>
 <20171122144750.1ceffe41.cohuck@redhat.com>
 <e1e1f8e1-e274-fde0-4358-4ba89d034c1e@linux.vnet.ibm.com>
 <20171205150657.371a6e04.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171205150657.371a6e04.cohuck@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 12/05/2017 09:06 AM, Cornelia Huck wrote:
> On Mon, 27 Nov 2017 19:39:32 -0500
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> On 11/22/2017 08:47 AM, Cornelia Huck wrote:
>>> On Tue, 21 Nov 2017 11:08:01 -0500
>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>
>>>   
>>>> I am not quite sure what you are asking, but I'll attempt to answer
>>>> what I think you're asking. A new type of mediated matrix device
>>>> will be introduced to configure a virtual matrix for a guest that
>>>> provides the interfaces to map a virtual adapter/domain ID to one
>>>> or more real adapter/domain IDs. If by virtualization facility,
>>>> you are talking about the VFIO AP matrix driver, then yes,
>>>> the driver will handle ioctl requests based on the type of the
>>>> mediated matrix device through which the request was submitted:
>>>>
>>>> If the request is to configure the KVM guest's matrix:
>>>>
>>>> * If the mediated matrix device type is passthrough:
>>>>      * Do validation of matrix
>>>>      * Configure the APM, AQM and ADM in the KVM guest's CRYCB
>>>>        according to the configuration specified via the mediated
>>>>        device's sysfs attribute files.
>>>> * If the mediated matrix device type is virtual:
>>>>      * Do validation of matrix
>>>>      * No need to configure CRYCB since all instructions will be
>>>>        intercepted
>>> Ok, so we would have two distinct paths here...
>> It depends upon what you mean by two distinct paths. Configuring the
>> mediated device would require a new mediated device type for virtualized
>> AP matrices. The ioctl for configuring the KVM guest's CRYCB would
>> require an additional check to determine whether the CRYCB need be
>> configured or not.
> Yes, the new type makes this distinct enough so that we can think about
> this later.
>
>>>   
>>>> If the request is to execute an intercepted AP instruction:
>>>>
>>>> * If the mediated matrix device type is passthrough:
>>>>      * Forward the instruction to the AP device and return the
>>>>        result to QEMU.
>>>>
>>>> * If the mediated matrix device type is virtual:
>>>>
>>>>      * Retrieve all of the real APQNs mapped to the virtual
>>>>        adapter and domain IDs configured in the mediated matrix
>>>>        device's sysfs attribute files
>>>>      * If there is more than one APQN mapping, then determine
>>>>        which would be best to use - algorithm TBD
>>>>      * Forward the instruction to the AP device and return the
>>>>        result.
>>> ...and two distinct paths for most instructions here as well.
>> The driver would require additional ioctls to handle
>> interception of all AP instructions for virtual matrices and additional
>> code to remap virtual APQNs to real APQNs and determine which real APQN
>> to which intercepted instructions should be forwarded.
>>>   
>>>> Of course, these are just preliminary ideas at this time.
>>>> I've only prototyped the sysfs configuration interfaces. No
>>>> back end prototyping has been undertaken yet. If the ideas do
>>>> not pan out, however; I think virtualization can be introduced
>>>> as an independent design.
>>> Yes, let's cross that bridge when we get to it.
>> That is the plan. Given Pierre's objections, I thought it might help
>> to touch on this.
> OK, so I admit that I lost track a bit. Are there any remaining issues
> beyond the feature handling? Would it make sense to post a v2?
I was planning on posting a V2 once the features issue is settled.
>
