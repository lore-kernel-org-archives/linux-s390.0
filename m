From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [RFC 00/19] KVM: s390/crypto/vfio: guest dedicated crypto
 adapters
Date: Thu, 16 Nov 2017 18:35:22 -0500
Message-ID: <1476b0a4-a2a3-2c48-107a-ab7b39b0e93e@linux.vnet.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <5baf5f90-6cac-3c09-7b66-1bc8b30b8093@linux.vnet.ibm.com>
 <20171114145722.4ab850a5.cohuck@redhat.com>
 <fcfd6a27-662b-9a30-8bad-adaac4cf0ce1@linux.vnet.ibm.com>
 <8a492b07-3d3b-f4cf-e139-7de345ea8188@linux.vnet.ibm.com>
 <20171116180308.289e5eed.cohuck@redhat.com>
 <c8f6768f-b916-fb29-f166-9ca41916e4c3@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <c8f6768f-b916-fb29-f166-9ca41916e4c3@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 11/16/2017 03:25 PM, Pierre Morel wrote:
> On 16/11/2017 18:03, Cornelia Huck wrote:
>> On Thu, 16 Nov 2017 17:06:58 +0100
>> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>>
>>> On 16/11/2017 16:23, Tony Krowiak wrote:
>>>> On 11/14/2017 08:57 AM, Cornelia Huck wrote:
>>>>> On Tue, 31 Oct 2017 15:39:09 -0400
>>>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>>>> On 10/13/2017 01:38 PM, Tony Krowiak wrote:
>>>>>> Ping
>>>>>>> Tony Krowiak (19):
>>>>>>>      KVM: s390: SIE considerations for AP Queue virtualization
>>>>>>>      KVM: s390: refactor crypto initialization
>>>>>>>      s390/zcrypt: new AP matrix bus
>>>>>>>      s390/zcrypt: create an AP matrix device on the AP matrix bus
>>>>>>>      s390/zcrypt: base implementation of AP matrix device driver
>>>>>>>      s390/zcrypt: register matrix device with VFIO mediated device
>>>>>>>        framework
>>>>>>>      KVM: s390: introduce AP matrix configuration interface
>>>>>>>      s390/zcrypt: support for assigning adapters to matrix mdev
>>>>>>>      s390/zcrypt: validate adapter assignment
>>>>>>>      s390/zcrypt: sysfs interfaces supporting AP domain assignment
>>>>>>>      s390/zcrypt: validate domain assignment
>>>>>>>      s390/zcrypt: sysfs support for control domain assignment
>>>>>>>      s390/zcrypt: validate control domain assignment
>>>>>>>      KVM: s390: Connect the AP mediated matrix device to KVM
>>>>>>>      s390/zcrypt: introduce ioctl access to VFIO AP Matrix driver
>>>>>>>      KVM: s390: interface to configure KVM guest's AP matrix
>>>>>>>      KVM: s390: validate input to AP matrix config interface
>>>>>>>      KVM: s390: New ioctl to configure KVM guest's AP matrix
>>>>>>>      s390/facilities: enable AP facilities needed by guest
>>>>> I think the approach is fine, and the code also looks fine for the 
>>>>> most
>>>>> part. Some comments:
>>>>>
>>>>> - various patches can be squashed together to give a better
>>>>>     understanding at a glance
>>>> Which patches would you squash?
>>>>> - this needs documentation (as I already said)
>>>> My plan is to take the cover letter patch and incorporate that into
>>>> documentation,
>>>> then replace the cover letter patch with a more concise summary.
>>>>> - some of the driver/device modelling feels a bit awkward 
>>>>> (commented in
>>>>>     patches) -- I'm not sure that my proposal is better, but I 
>>>>> think we
>>>>>     should make sure the interdependencies are modeled correctly
>>>> I am responding to each patch review individually.
>>>
>>> I think that instead of responding to each patch individually we should
>>> have a discussion on the design because I think a lot could change and
>>> discussing about each patch as they may be completely redesigned for 
>>> the
>>> next version may not be very useful.
How do you suggest this discussion should be structured? Aren't the patches
themselves an ultimate expression of the design? A lot could change, but
can't those issues can be dealt with and discussed as we move forward?

>>>
>>>
>>> So I totally agree with Conny on that we should stabilize the
>>> bus/device/driver modeling.
>>>
>>> I think it would be here a good place to start the discussion on things
>>> like we started to discuss, Harald and I, off-line:
>>> - why a matrix bus, in which case we can avoid it
>>
>> I thought it had been agreed that we should be able to ditch it?
>
> I have not see any comment on the matrix bus.
As stated in a previous email responding to Connie, I decided to scrap the
AP matrix bus. There will only ever be one matrix device that serves two
purposes: To hold the APQNs of the queue devices bound to the VFIO AP matrix
device driver; to serve as a parent of the mediated devices created for
guests requiring access to the APQNs reserved for their use. So, instead
of an AP matrix bus creating the matrix device, it will be created by the
VFIO AP matrix driver in /sys/devices/ap_matrix/ during driver 
initialization.
>
>
>>
>>> - which kind of devices we need
>>
>> What is still unclear? Which card generations to support?
>
> No, I mean the relation bus/device/driver/mdev...
I think that is pretty well spelled out in the cover letter
patch and in the descriptions of the patches themselves. What is it
you don't understand?
>
>
>>
>>> - how to handle the repartition of queues on boot, reset and hotplug
What do you mean by repartition of queues on boot?
>>
>> That's something I'd like to see a writeup for.
>
> yes, and it may have an influence on the bus/device/driver/mdev design
I don't understand the need to avoid implementation details. If you recall,
the original design was modeled on AP queue devices. It was only after
implementing that design that the shortcomings were revealed which is
why we decided to base the model on the AP matrix. Keep in mind, this is
an RFC, not a final patch set. I would expect some change from the
implementation herein. In fact, I've already made many changes based on
Connie's and Christian's review comments, none of which resulted in an
overhaul of the design.
>
>
>>
>>> - interaction with the host drivers
>>
>> The driver model should already handle that, no?
>
> yes it should, but it is not clear for me.
What is it that is not clear? This cover letter seeks to describe the
patch set, so why not annotate those areas that are not clear? I'm don't
understand what it is you are expecting. I thought the purpose of
submitting these patches here was to generate discussion.
>
>
>>
>>> - validation of the matrix for guests and host views
>>
>> I saw validation code in the patches, although I have not reviewed it.
Patches 9, 11, and 13 validate the adapters, domains and control domains
configured for the mdev matrix device and patch 17 verifies that the
KVM guest's matrix does not define any APQNs in use by other guests.
>>
>>
>>>
>>> or even features we need to add like
>>> - interruptions
>>
>> My understanding is that interrupts are optional so they can be left
>> out in the first shot. With the gisa (that has not yet been posted), it
>> should not be too difficult, no?
>
> you are right I forgot that it is optional
If the facilities bit (STFLE.65) indicating interrupts are available is not
set for the guest, then the AP bus running on the guest will poll and
interrupts will not have to be handled. This patch set does not enable
interrupts, so it is not relevant at this time. We will not be able to
handle interrupts for the guest until the GISA for passthrough patches
are available. This will be addressed at that time.
>
>
>>
>>> - PAPQ/TAPQ-t and APQI interception
>>
>> I can't say anything about that, as this is not documented :(
>
> Right we can live without these too.
I have implemented interception of the PQAP(TAPQ) instruction and will
include it in the next set of patches. It was not documented here
because this patch set was submitted as an RFC for the purpose of
determining if we are on the right track with regard to the overall
AP matrix design.
>
>
>>
>>> - virtualization of the AP
>>
>> Is this really needed? It would complicate everything a lot.
>
> Concern has no sens without interception.
Virtualization of AP is not on the table right now.
>
>>
>>> - CPU model and KVM capabilities
>>
>> That already has been discussed with the individual patches.
>
> Well, if there are no interceptions the individual patches discussions 
> are enough.
As I stated above, these patches were submitted as an RFC for the 
purpose of
getting a stamp of approval for the general design. Additional functions 
such as
hot plug and interception will be introduced in phases in the near 
future. As
I stated above, I already have the implementation of PQAP(TAPQ) and will 
include
it in the next submission. It does not change the general design one iota.
>
>
>>
>>>
>>> In my understanding these points must be cleared before we really start
>>> to discuss the details of the implementation.
>>
>> The general design already looks fine to me. Do you really expect that
>> a major redesign is needed?
I thought the point of submitting this RFC was to get a sanity check of the
design concepts. According to Christian, he discussed the design with
several maintainers at the KVM forum and they agreed this design was sane.
>>
>
> I am worry about the following:
> - Will the matrix bus be accepted
I am eliminating the matrix bus - based on comments made by Connie for an
individual patch - so no need to worry;-)
>
> - What happens on host reset and hot plug/unplug in host
TBD, but I don't anticipate a major overhaul of the design to accommodate
these eventualities, particularly hot plug which I considered while
creating this design.
>
> - What happens with the queues on guest start/halt/restart
TBD
>
> Regards,
>
> Pierre
>
