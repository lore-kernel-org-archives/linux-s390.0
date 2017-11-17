From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [RFC 00/19] KVM: s390/crypto/vfio: guest dedicated crypto
 adapters
Date: Fri, 17 Nov 2017 15:28:16 -0500
Message-ID: <a4b3c3d1-0806-6ba3-4739-c2a1677b9bfd@linux.vnet.ibm.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171117110742.1d416435.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 11/17/2017 05:07 AM, Cornelia Huck wrote:
> On Fri, 17 Nov 2017 08:07:15 +0100
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>
>> On 17/11/2017 00:35, Tony Krowiak wrote:
>>> On 11/16/2017 03:25 PM, Pierre Morel wrote:
>>>> On 16/11/2017 18:03, Cornelia Huck wrote:
>>>>> On Thu, 16 Nov 2017 17:06:58 +0100
>>>>> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>>>>>   
>>>>>> On 16/11/2017 16:23, Tony Krowiak wrote:
>>>>>>> On 11/14/2017 08:57 AM, Cornelia Huck wrote:
>>>>>>>> On Tue, 31 Oct 2017 15:39:09 -0400
>>>>>>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>>>>>>> On 10/13/2017 01:38 PM, Tony Krowiak wrote:
>>>>>>>>> Ping
>>>>>>>>>> Tony Krowiak (19):
>>>>>>>>>>       KVM: s390: SIE considerations for AP Queue virtualization
>>>>>>>>>>       KVM: s390: refactor crypto initialization
>>>>>>>>>>       s390/zcrypt: new AP matrix bus
>>>>>>>>>>       s390/zcrypt: create an AP matrix device on the AP matrix bus
>>>>>>>>>>       s390/zcrypt: base implementation of AP matrix device driver
>>>>>>>>>>       s390/zcrypt: register matrix device with VFIO mediated device
>>>>>>>>>>         framework
>>>>>>>>>>       KVM: s390: introduce AP matrix configuration interface
>>>>>>>>>>       s390/zcrypt: support for assigning adapters to matrix mdev
>>>>>>>>>>       s390/zcrypt: validate adapter assignment
>>>>>>>>>>       s390/zcrypt: sysfs interfaces supporting AP domain assignment
>>>>>>>>>>       s390/zcrypt: validate domain assignment
>>>>>>>>>>       s390/zcrypt: sysfs support for control domain assignment
>>>>>>>>>>       s390/zcrypt: validate control domain assignment
>>>>>>>>>>       KVM: s390: Connect the AP mediated matrix device to KVM
>>>>>>>>>>       s390/zcrypt: introduce ioctl access to VFIO AP Matrix driver
>>>>>>>>>>       KVM: s390: interface to configure KVM guest's AP matrix
>>>>>>>>>>       KVM: s390: validate input to AP matrix config interface
>>>>>>>>>>       KVM: s390: New ioctl to configure KVM guest's AP matrix
>>>>>>>>>>       s390/facilities: enable AP facilities needed by guest
>>>>>>>> I think the approach is fine, and the code also looks fine for the
>>>>>>>> most
>>>>>>>> part. Some comments:
>>>>>>>>
>>>>>>>> - various patches can be squashed together to give a better
>>>>>>>>      understanding at a glance
>>>>>>> Which patches would you squash?
>>>>>>>> - this needs documentation (as I already said)
>>>>>>> My plan is to take the cover letter patch and incorporate that into
>>>>>>> documentation,
>>>>>>> then replace the cover letter patch with a more concise summary.
>>>>>>>> - some of the driver/device modelling feels a bit awkward
>>>>>>>> (commented in
>>>>>>>>      patches) -- I'm not sure that my proposal is better, but I
>>>>>>>> think we
>>>>>>>>      should make sure the interdependencies are modeled correctly
>>>>>>> I am responding to each patch review individually.
>>>>>> I think that instead of responding to each patch individually we should
>>>>>> have a discussion on the design because I think a lot could change and
>>>>>> discussing about each patch as they may be completely redesigned for
>>>>>> the
>>>>>> next version may not be very useful.
>>> How do you suggest this discussion should be structured? Aren't the patches
>>> themselves an ultimate expression of the design? A lot could change, but
>>> can't those issues can be dealt with and discussed as we move forward?
> FWIW, I think the basic design is already fine, and I don't think many
> of the points raised would become useless. For one, if something looks
> a bit strange in detail, it might be a pointer to something bigger that
> should be reshuffled (like where to anchor information).
I agree.
>
>>>    
>>>>>>
>>>>>> So I totally agree with Conny on that we should stabilize the
>>>>>> bus/device/driver modeling.
>>>>>>
>>>>>> I think it would be here a good place to start the discussion on things
>>>>>> like we started to discuss, Harald and I, off-line:
>>>>>> - why a matrix bus, in which case we can avoid it
>>>>> I thought it had been agreed that we should be able to ditch it?
>>>> I have not see any comment on the matrix bus.
>>> As stated in a previous email responding to Connie, I decided to scrap the
>>> AP matrix bus. There will only ever be one matrix device that serves two
>>> purposes: To hold the APQNs of the queue devices bound to the VFIO AP
>>> matrix
>>> device driver; to serve as a parent of the mediated devices created for
>>> guests requiring access to the APQNs reserved for their use. So, instead
>>> of an AP matrix bus creating the matrix device, it will be created by the
>>> VFIO AP matrix driver in /sys/devices/ap_matrix/ during driver
>>> initialization.
>> Sorry, I did not see the mail, this of course change a lot of things...
> One thing that would be useful for the next iteration is some ascii-art
> representation that shows how the different parts (matrix, ap driver,
> mdev, ...) tie together. That also would be useful to have in the
> documentation.
I plan on including some drawings with the documentation and will include it
in the cover letter as well.
>
>>>>   
>>>>>   
>>>>>> - which kind of devices we need
>>>>> What is still unclear? Which card generations to support?
>>>> No, I mean the relation bus/device/driver/mdev...
>>> I think that is pretty well spelled out in the cover letter
>>> patch and in the descriptions of the patches themselves. What is it
>>> you don't understand?
>> If we have no matrix bus anymore I prefer to wait for the cover letter
>> of V2 to discuss this.
>>
>>>>   
>>>>>   
>>>>>> - how to handle the repartition of queues on boot, reset and hotplug
>>> What do you mean by repartition of queues on boot?
>>>>> That's something I'd like to see a writeup for.
>>>> yes, and it may have an influence on the bus/device/driver/mdev design
>>> I don't understand the need to avoid implementation details. If you recall,
>>> the original design was modeled on AP queue devices. It was only after
>>> implementing that design that the shortcomings were revealed which is
>>> why we decided to base the model on the AP matrix. Keep in mind, this is
>>> an RFC, not a final patch set. I would expect some change from the
>>> implementation herein. In fact, I've already made many changes based on
>>> Connie's and Christian's review comments, none of which resulted in an
>>> overhaul of the design.
> I expect that any of the above can be accommodated by the design. A
> short writeup of what we may want to do for that would certainly help
> to validate that, though.
I have spent some time thinking about hotplug implementation and I
believe it can be accommodated within this design. I haven't looked
at the implications for reset yet and I don't really know what is
meant by "repartition of queues". I will include a write-up in the
next submission.
>
>>>>   
>>>>>   
>>>>>> - interaction with the host drivers
>>>>> The driver model should already handle that, no?
>>>> yes it should, but it is not clear for me.
>>> What is it that is not clear? This cover letter seeks to describe the
>>> patch set, so why not annotate those areas that are not clear? I'm don't
>>> understand what it is you are expecting. I thought the purpose of
>>> submitting these patches here was to generate discussion.
> The simple fact of unbinding from the normal drivers and rebinding to
> the specialized ones should already take care of interactions,
> shouldn't it? Combined with the validation we should be all set.
Unbinding from the host drivers and binding to the VFIO AP matrix driver
reserves the APQNs (adapter ID and queue index tuple) for use by guests.
The APQNs reserved are stored with the AP matrix device. Mediated matrix
devices can be created for the matrix device, one for each guest that
will be using the reserved APQNs. When a mediated matrix device
is created, sysfs attribute files are created to assign adapters, domains
and control domains to the mediated matrix device to configure the AP
matrix for a guest. Validation is done at the time of assignment to insure
that APQNs that can be derived from the matrix have in fact been reserved.

The mediated device file descriptor provides a communication pathway 
between
QEMU and the VFIO AP matrix device driver. Communication between QEMU
and the device driver is established by opening the file descriptor.
The device driver provides mediated device ioctl to configure the
the APM, AQM and ADM of the KVM guest's CRYCB from the AP matrix
configured via the mediated matrix device's attribute files. Validation
is performed by the ioctl to ensure no other guest is using any APQN
that can be derived from matrix.

The interception of AP instructions will be handled via an ioctl call
on the same communication pathway.

I believe that about covers it.
>
>>>>   
>>>>>   
>>>>>> - validation of the matrix for guests and host views
>>>>> I saw validation code in the patches, although I have not reviewed it.
>>> Patches 9, 11, and 13 validate the adapters, domains and control domains
>>> configured for the mdev matrix device and patch 17 verifies that the
>>> KVM guest's matrix does not define any APQNs in use by other guests.
>>>>>   
>>>>>> or even features we need to add like
>>>>>> - interruptions
>>>>> My understanding is that interrupts are optional so they can be left
>>>>> out in the first shot. With the gisa (that has not yet been posted), it
>>>>> should not be too difficult, no?
>>>> you are right I forgot that it is optional
>>> If the facilities bit (STFLE.65) indicating interrupts are available is not
>>> set for the guest, then the AP bus running on the guest will poll and
>>> interrupts will not have to be handled. This patch set does not enable
>>> interrupts, so it is not relevant at this time. We will not be able to
>>> handle interrupts for the guest until the GISA for passthrough patches
>>> are available. This will be addressed at that time.
> If you think it can be easily added later on, that would be fine for
> me. (I cannot comment on gisa details until it has been posted,
> obviously.)
Enabling AP interrupts is accomplished using the PQAP(AQIC) instruction
which is a mandatory interception. The instruction will be forwarded to
the VFIO AP device driver via an ioctl call on the mediated matrix
device file descriptor. There will be some GISA set up needed and code
to feed the interrupt back to user space, but I believe that will be
provided by the forthcoming GISA passthrough patches. The bottom line is,
I don't anticipate any major design change to handle interrupt processing.
>
>>>>   
>>>>>   
>>>>>> - PAPQ/TAPQ-t and APQI interception
>>>>> I can't say anything about that, as this is not documented :(
>>>> Right we can live without these too.
>>> I have implemented interception of the PQAP(TAPQ) instruction and will
>>> include it in the next set of patches. It was not documented here
>>> because this patch set was submitted as an RFC for the purpose of
>>> determining if we are on the right track with regard to the overall
>>> AP matrix design. >>
>>>>   
>>>>>   
>>>>>> - virtualization of the AP
>>>>> Is this really needed? It would complicate everything a lot.
>>>> Concern has no sens without interception.
>>> Virtualization of AP is not on the table right now.
>> If we implement interception, we must speak about this, even to say how
>> we do not implement virtualization.
> A note that we do not plan to virtualize it right now would be
> sensible, yes.
Will do.
>
>  From what I remember, this would mean opening a huge can of worms for
> something that might be only of limited use. I'd prefer a simplistic
> but usable approach first. If virtualization should really become a
> requirement in the future, it might be better served by a different
> mechanism anyway.
I have done a little proof of concept code to get an idea if the AP matrix
design will be extensible to handle virtualization. I modeled the
proof of concept on the AP matrix model by creating a second mediated
matrix device type for virtualization. Of course, virtual and passthrough
matrix device types would have to be mutually exclusive; the admin would 
have
to choose one or the other. The sysfs model looked like this:

/sys/devices/ap_matrix
... [matrix]
...... [mdev_supported_types]
......... [vfio_ap_matrix-virtual]
............ create
............... [devices]
.................. [$uuid]
..................... assign_adapter
..................... assign_domain

Using the a assign_adapter file, one can assign a virtual adapter
ID to one or more real adapter IDs. For example, to assign virtual adapter
4 to real adapters 3, 22 and 254:

echo 4:3,22,254 > assign_adapter

Using the a assign_domain file, one can assign a virtual domain
ID to one or more real domain IDs. For example, to assign virtual domain
0 to real domains 8 and 71:

echo 0:8,0x47 > assign_domain

All AP instructions would be intercepted for a virtual matrix. The 
intercepted
instructions would be forwarded to the VFIO AP matrix device driver by QEMU
using an ioctl implemented by the VFIO AP matrix driver. If the mediated 
matrix
device is vfio_ap_matrix-passthrough type, things would work as they do now.
If the type is vfio_ap_matrix-virtual, the the driver would:

1. Calculate all of the real APQNs that can be used by:
    * Retrieving the adapter IDs mapped to the APID specified in the APQN
      contained in the AP instruction
    * Retrieving the domain IDs mapped to the APQI specified in the APQN
      contained in the AP instruction
    * Combining all of the permutations of APID/APQI
2. Determine which APQN would be best to use.
3. Execute the instruction
4. Return the result to the caller

In other words, I think the current design is extensible; but even if not,
I see no reason we can't design a completely different mechanism for
virtualization.




>
>>>>   
>>>>>   
>>>>>> - CPU model and KVM capabilities
>>>>> That already has been discussed with the individual patches.
>>>> Well, if there are no interceptions the individual patches discussions
>>>> are enough.
>>> As I stated above, these patches were submitted as an RFC for the
>>> purpose of
>>> getting a stamp of approval for the general design. Additional functions
>>> such as
>>> hot plug and interception will be introduced in phases in the near
>>> future. As
>>> I stated above, I already have the implementation of PQAP(TAPQ) and will
>>> include
>>> it in the next submission. It does not change the general design one iota.
> The intersection was mainly with things like the cpu model. A different
> part of the interface that does not really have an impact on the rest
> of the design.
>
> (That does not mean that we don't need to figure it out, of course.)
Of course.
>
>>>>   
>>>>>   
>>>>>> In my understanding these points must be cleared before we really start
>>>>>> to discuss the details of the implementation.
>>>>> The general design already looks fine to me. Do you really expect that
>>>>> a major redesign is needed?
>>> I thought the point of submitting this RFC was to get a sanity check of the
>>> design concepts. According to Christian, he discussed the design with
>>> several maintainers at the KVM forum and they agreed this design was sane.
>>>>>   
>>>> I am worry about the following:
>>>> - Will the matrix bus be accepted
>>> I am eliminating the matrix bus - based on comments made by Connie for an
>>> individual patch - so no need to worry;-)
>>>> - What happens on host reset and hot plug/unplug in host
>>> TBD, but I don't anticipate a major overhaul of the design to accommodate
>>> these eventualities, particularly hot plug which I considered while
>>> creating this design.
>>>> - What happens with the queues on guest start/halt/restart
>>> TBD
>> AFAIU These two points are crucials for device driver design.
> A writeup for these two points would be most welcome. I think the base
> design is sane; it does not hurt to validate, though.
Will do.
>
