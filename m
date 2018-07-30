From: Pierre Morel <pmorel@linux.ibm.com>
Date: Mon, 30 Jul 2018 11:28:47 +0000
Subject: Re: [PATCH v7 17/22] s390: vfio-ap: implement VFIO_DEVICE_GET_INFO ioctl
Message-Id: <31cddf5c-0eec-6e58-7c77-193e242570a3@linux.ibm.com>
In-Reply-To: <20180730132338.2db59233.cohuck@redhat.com>
References: <20180730132338.2db59233.cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 30/07/2018 13:23, Cornelia Huck wrote:
> On Fri, 27 Jul 2018 17:29:07 +0200
> Thomas Huth <thuth@redhat.com> wrote:
>
>> On 07/26/2018 09:54 PM, Christian Borntraeger wrote:
>>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>>
>>> Introduces ioctl access to the VFIO AP Matrix device driver
>>> by implementing the VFIO_DEVICE_GET_INFO ioctl. This ioctl
>>> provides the VFIO AP Matrix device driver information to the
>>> guest machine.
>>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
>>> Acked-by: Halil Pasic <pasic@linux.ibm.com>
>>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>>> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>>   drivers/s390/crypto/vfio_ap_ops.c | 43 +++++++++++++++++++++++++++++++
>>>   1 file changed, 43 insertions(+)
>>>
>>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>>> index d06067a23000..01c429cb51d5 100644
>>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>>> @@ -867,6 +867,48 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
>>>   	module_put(THIS_MODULE);
>>>   }
>>>   
>>> +static int vfio_ap_mdev_get_device_info(unsigned long arg)
>>> +{
>>> +	unsigned long minsz;
>>> +	struct vfio_device_info info;
>>> +
>>> +	minsz = offsetofend(struct vfio_device_info, num_irqs);
>>> +
>>> +	if (copy_from_user(&info, (void __user *)arg, minsz))
>>> +		return -EFAULT;
>>> +
>>> +	if (info.argsz < minsz) {
>>> +		pr_warn("%s: Argument size %u less than min size %li\n",
>>> +			VFIO_AP_MODULE_NAME, info.argsz, minsz);
>> Do you really need this pr_warn here? The -EINVAL should give a clear
>> indication about the problem already. (and in the worst case, a
>> malicious userspace program could use it to flood the kernel log)
> Agreed, that pr_warn should be dropped. FWIW, the other vfio drivers
> don't do this, either.
yes, done,

Thanks

Pierre

>
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	info.flags = VFIO_DEVICE_FLAGS_AP;
>>> +	info.num_regions = 0;
>>> +	info.num_irqs = 0;
>>> +
>>> +	return copy_to_user((void __user *)arg, &info, minsz);
>>> +}


-- 
Pierre Morel
Linux/KVM/QEMU in B�blingen - Germany
