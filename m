From: Farhan Ali <alifm@linux.ibm.com>
Date: Thu, 04 Apr 2019 13:32:53 +0000
Subject: Re: [RFC v1 3/3] vfio-ccw: Release any channel program when releasing/removing vfio-ccw mdev
Message-Id: <ded8a0ee-da3d-e0dc-a5b1-a865cfdda4c5@linux.ibm.com>
In-Reply-To: <20190404110037.000ba88b.cohuck@redhat.com>
References: <20190404110037.000ba88b.cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 04/04/2019 05:00 AM, Cornelia Huck wrote:
> On Wed, 3 Apr 2019 11:17:00 -0400
> Farhan Ali <alifm@linux.ibm.com> wrote:
> 
>> On 04/03/2019 04:15 AM, Cornelia Huck wrote:
>>> On Tue,  2 Apr 2019 12:44:35 -0400
>>> Farhan Ali <alifm@linux.ibm.com> wrote:
>>>    
>>>> When releasing the vfio-ccw mdev, we currently do not release
>>>> any existing channel program and it's pinned pages. This can
>>>> lead to the following warning:
>>>>
>>>> [1038876.561565] WARNING: CPU: 2 PID: 144727 at drivers/vfio/vfio_iommu_type1.c:1494 vfio_sanity_check_pfn_list+0x40/0x70 [vfio_iommu_type1]
>>>>
>>>> ....
>>>>
>>>> 1038876.561921] Call Trace:
>>>> [1038876.561935] ([<00000009897fb870>] 0x9897fb870)
>>>> [1038876.561949]  [<000003ff8013bf62>] vfio_iommu_type1_detach_group+0xda/0x2f0 [vfio_iommu_type1]
>>>> [1038876.561965]  [<000003ff8007b634>] __vfio_group_unset_container+0x64/0x190 [vfio]
>>>> [1038876.561978]  [<000003ff8007b87e>] vfio_group_put_external_user+0x26/0x38 [vfio]
>>>> [1038876.562024]  [<000003ff806fc608>] kvm_vfio_group_put_external_user+0x40/0x60 [kvm]
>>>> [1038876.562045]  [<000003ff806fcb9e>] kvm_vfio_destroy+0x5e/0xd0 [kvm]
>>>> [1038876.562065]  [<000003ff806f63fc>] kvm_put_kvm+0x2a4/0x3d0 [kvm]
>>>> [1038876.562083]  [<000003ff806f655e>] kvm_vm_release+0x36/0x48 [kvm]
>>>> [1038876.562098]  [<00000000003c2dc4>] __fput+0x144/0x228
>>>> [1038876.562113]  [<000000000016ee82>] task_work_run+0x8a/0xd8
>>>> [1038876.562125]  [<000000000014c7a8>] do_exit+0x5d8/0xd90
>>>> [1038876.562140]  [<000000000014d084>] do_group_exit+0xc4/0xc8
>>>> [1038876.562155]  [<000000000015c046>] get_signal+0x9ae/0xa68
>>>> [1038876.562169]  [<0000000000108d66>] do_signal+0x66/0x768
>>>> [1038876.562185]  [<0000000000b9e37e>] system_call+0x1ea/0x2d8
>>>> [1038876.562195] 2 locks held by qemu-system-s39/144727:
>>>> [1038876.562205]  #0: 00000000537abaf9 (&container->group_lock){++++}, at: __vfio_group_unset_container+0x3c/0x190 [vfio]
>>>> [1038876.562230]  #1: 00000000670008b5 (&iommu->lock){+.+.}, at: vfio_iommu_type1_detach_group+0x36/0x2f0 [vfio_iommu_type1]
>>>> [1038876.562250] Last Breaking-Event-Address:
>>>> [1038876.562262]  [<000003ff8013aa24>] vfio_sanity_check_pfn_list+0x3c/0x70 [vfio_iommu_type1]
>>>> [1038876.562272] irq event stamp: 4236481
>>>> [1038876.562287] hardirqs last  enabled at (4236489): [<00000000001cee7a>] console_unlock+0x6d2/0x740
>>>> [1038876.562299] hardirqs last disabled at (4236496): [<00000000001ce87e>] console_unlock+0xd6/0x740
>>>> [1038876.562311] softirqs last  enabled at (4234162): [<0000000000b9fa1e>] __do_softirq+0x556/0x598
>>>> [1038876.562325] softirqs last disabled at (4234153): [<000000000014e4cc>] irq_exit+0xac/0x108
>>>> [1038876.562337] ---[ end trace 6c96d467b1c3ca06 ]---
>>>>
>>>> Similarly we do not free the channel program when we are removing
>>>> the vfio-ccw device. Let's fix this by resetting the device and freeing
>>>> the channel program and pinned pages in both the release and remove
>>>> path.
>>>>
>>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>>> ---
>>>>    drivers/s390/cio/vfio_ccw_ops.c | 9 +++++++++
>>>>    1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
>>>> index ec2f796c..763c350 100644
>>>> --- a/drivers/s390/cio/vfio_ccw_ops.c
>>>> +++ b/drivers/s390/cio/vfio_ccw_ops.c
>>>> @@ -138,6 +138,7 @@ static int vfio_ccw_mdev_remove(struct mdev_device *mdev)
>>>>    		/* The state will be NOT_OPER on error. */
>>>>    	}
>>>>    
>>>> +	cp_free(&private->cp);
>>>>    	private->mdev = NULL;
>>>>    	atomic_inc(&private->avail);
>>>>    
>>>> @@ -171,6 +172,14 @@ static void vfio_ccw_mdev_release(struct mdev_device *mdev)
>>>>    		dev_get_drvdata(mdev_parent_dev(mdev));
>>>>    	int i;
>>>>    
>>>> +	if ((private->state != VFIO_CCW_STATE_NOT_OPER) &&
>>>> +	    (private->state != VFIO_CCW_STATE_STANDBY)) {
>>>> +		if (!vfio_ccw_mdev_reset(mdev))
>>>> +			private->state = VFIO_CCW_STATE_STANDBY;
>>>> +		/* The state will be NOT_OPER on error. */
>>>> +	}
>>>
>>> Ok, now I have gotten lost in that maze of unregister, release, remove,
>>> and whatever functions. Does it even make sense here to do the
>>> disable/enable reset, or is disabling the subchannel the more sensible
>>> approach? Isn't the device going away anyway?
>>
>>
>> If it helps, we enter the release path when we either do a device hot
>> unplug, or the guest dies, shuts down or I believe closes the mediated
>> device file descriptor. For example a stacktrace for release would be
>> something like this:
>>
>> [  389.970906]  [<000003ff8033583e>] vfio_ccw_mdev_release+0x36/0xd0
>> [vfio_ccw]
>> [  389.970910]  [<000003ff8031e1d8>] vfio_mdev_release+0x38/0x58
>> [vfio_mdev]
>> [  389.970915]  [<000003ff80074832>] vfio_device_fops_release+0x3a/0x60
>> [vfio]
>> [  389.970919]  [<00000000003c2dc4>] __fput+0x144/0x228
>> [  389.970924]  [<000000000016ee82>] task_work_run+0x8a/0xd8
>> [  389.970928]  [<00000000001094ae>] do_notify_resume+0x46/0x88
>> [  389.970932]  [<0000000000b9e276>] system_call+0xe2/0x2d8
>>
>>
>> OTOH remove is called when we write to remove file for the mediated
>> device and an example stacktrace would look like this:
>>
>> [  285.190391]  [<000003ff802458b0>] vfio_ccw_mdev_remove+0x40/0x78
>> [vfio_ccw]
>> [  285.190397]  [<000003ff801a499c>] mdev_device_remove_ops+0x3c/0x80
>> [mdev]
>> [  285.190402]  [<000003ff801a4d5c>] mdev_device_remove+0xc4/0x130 [mdev]
>> [  285.190407]  [<000003ff801a5074>] remove_store+0x6c/0xa8 [mdev]
>> [  285.190412]  [<000000000046f494>] kernfs_fop_write+0x14c/0x1f8
>> [  285.190417]  [<00000000003c1530>] __vfs_write+0x38/0x1a8
>> [  285.190421]  [<00000000003c187c>] vfs_write+0xb4/0x198
>> [  285.190425]  [<00000000003c1af2>] ksys_write+0x5a/0xb0
>> [  285.190430]  [<0000000000b9e270>] system_call+0xdc/0x2d8
>>
>>
>> Now trying to answer your question, I think reseting the device on a
>> release makes more sense. This is because the mediated device still
>> exists but there is no user using the device.
>>
>> On the remove case the mediated device is going away for good and so
>> maybe just disabling the subchannel makes more sense in that case.
> 
> Thanks for the backtraces; and yes, I agree that reset on release and
> quiesce on remove look reasonable.
> 

I will update and spin a v2 soon. I just want to wait and see if there 
are any other comments.


>>
>> Thanks
>> Farhan
>>
>>
>>>    
>>>> +
>>>> +	cp_free(&private->cp);
>>>>    	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>>>>    				 &private->nb);
>>>>      
>>>
>>>    
>>
> 
> 
