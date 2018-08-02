From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 02 Aug 2018 15:14:00 +0000
Subject: Re: [PATCH v7 00/22] vfio-ap: guest dedicated crypto adapters
Message-Id: <fbdd1beb-317d-acf7-1416-9c21684bdc82@linux.ibm.com>
In-Reply-To: <20180801105638.2bef0189@t450s.home>
References: <20180801105638.2bef0189@t450s.home>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 01/08/2018 18:56, Alex Williamson wrote:
> On Wed, 1 Aug 2018 10:40:57 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>
>> On 30/07/2018 18:10, Alex Williamson wrote:
>>> On Mon, 30 Jul 2018 08:05:32 +0200
>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>>   
>>>> On 07/27/2018 06:53 PM, Alex Williamson wrote:
>>>>> On Fri, 27 Jul 2018 12:59:50 +0200
>>>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>>>>       
>>>>>> On 07/27/2018 10:38 AM, Cornelia Huck wrote:
>>>>>>> On Thu, 26 Jul 2018 21:54:07 +0200
>>>>>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>>>>>>          
>>>>>>>> * The mediated device gained an 'activate' attribute. Sharing conflicts are
>>>>>>>>     checked on activation now. If the device was not activated, the mdev
>>>>>>>>     open still implies activation. An active ap_matrix_mdev device claims
>>>>>>>>     it's resources -- an inactive does not.
>>>>>>> This means we have a 'commit' workflow?
>>>>>> Yes. We want to be able to "overcommit" definitions. For example when you
>>>>>> have 2 guests that you never start at the same time. Then you can give both
>>>>>> guests the same disks. If you start at the same time, libvirt will complain.
>>>>>> Now: you want to do the same for matrixes. Allocation at definition time
>>>>>> would limit that flexibility. When we check at "commit" this allows overcommit.
>>>>> I raised an eyebrow to this 'activate' attribute as well and I think we
>>>>> struggled through the same sort of thing when defining mdev initially
>>>>> with NVIDIA.  IIRC there was a proposal that mdev devices could
>>>>> effectively be overcommitted on the parent and only when they were
>>>>> opened, would the allocation count against the available instances.
>>>>> The trouble is then that libvirt has no guarantee that a given mdev
>>>>> device is usable.  I believe we decided that the creation of the mdev
>>>>> device is the point at which we want to reserve resources because it
>>>>> provides a better synchronization point.  I don't really see what
>>>>> advantage we have by having these matrices on 'standby', shouldn't
>>>>> userspace be able to manipulate these dynamically and on-demand of
>>>>> starting a VM?  Thanks,
>>>> We had this discussion as well and there is a case where not-predefining
>>>> things might complicate matters:
>>>> Daniel, please correct me if this is not so:
>>>> As far as I understand the libvirt folks want to have host devices and guest
>>>> instances decoupled. So a guest startup will not trigger a define of the mdev
>>>> instance. (instead it has to be a separate step). This might work with virsh
>>>> (but it now requires two steps as you can not predefine instances) but it
>>>> might break things like virt-manager.
>>> If this is a libvirt requirement, then it's creating a different model
>>> for AP mdev devices since existing mdev devices do not allow
>>> overcommit.  libvirt currently does no mdev lifecycle management, it's
>>> entirely left to the user to decide on a static configuration or
>>> dynamic creation.  Dynamic creation can be done via qemu hooks  until
>>> libvirt decides how/if they'll take on creation.  So I don't think it
>>> makes sense to make AP mdev devices behave different from others in
>>> this respect.  Thanks,
>>>
>>> Alex
>>>   
>>
>> The problem we have with the AP matrix is that we have a complex entity,
>> APCB (part of CRYCB) which defines 2 masks, cards and card's access queues
>> which cross product produces a matrix in which each point is a AP device.
>>
>> The firmware policies has restrictions about the concurrent access to these
>> devices and it is much simpler for us to pass a subset of the matrix to
>> a guest instead of passing the AP devices.
>>
>> To handle security issues we want to use mediated devices.
>>
>> Two architectures can be build to achieve this.
>>
>> The first one uses a single host device representing the matrix
>> and multiple mediated device.
>> In this case the matrix subset we want to configure for a guest
>> can only be configured inside the mediated device and
>> therefore the configuration can only happen after the creation
>> of the mediated device.
>>
>> The second one uses one host devices per configuration
>> and creates the mediated device on it once
>> the configuration is done.
>>
>>
>> This patch set presents the first architecture.
>> Do you have any advice how to make this architecture more
>> conform to the current mdev device behavior?
>>
>> Would the second architecture be more acceptable?
> I don't think I'm suggesting the second approach though perhaps it does
> have some things in common with the notion of aggregated devices that
> Intel is proposing.  I don't know if there's some way that we can
> create a sane common approach to vendor specific create parameters.
>
> But I don't think this problem requires that.  The available_instances
> for this vfio-ap mdev device is sort of meaningless, creating the mdev
> is not the point at which resources are committed to the device, it's
> just a container for the resources which are later added as adapters
> and domains, aiui.  So the question then is are those resources
> committed when they are configured into the mdev device or at
> activate/open.  I argue that committing resources as they are added is
> more similar to existing mdev devices.  Committing resources at
> open/activate means that resources can be over-committed across
> multiple mdev devices and there's no guarantee that a user that owns an
> mdev device will have resources available to use the device at a given
> point in time.  This is fundamentally a different behavior for libvirt
> level consumers of the mdev device vs other mdev devices as we're
> effectively asking the management layer to understand the resource
> constraints of a given mdev device such that they can manage which VMs
> can be run concurrently.  That's not just a vendor specific mdev
> attribute, that's a difference in the core behavior of the device.
>
> I also still don't see what advantage this behavioral change provides.
> With it we can have mdevs configured with overlapping resources which
> can be activated on demand (and with no clear recourse should
> management layers attempt to activate conflicting devices
> simultaneously), without it, we can use things like libvirt hooks to
> create the mdev device and attach compatible resources on demand.  We
> have the latter already and regardless of the former, so why introduce
> a conflicting usage model?  Thanks,
>
> Alex
>

Thanks Alex,

we will work in this direction.

Best regards,

Pierre




-- 
Pierre Morel
Linux/KVM/QEMU in B�blingen - Germany
