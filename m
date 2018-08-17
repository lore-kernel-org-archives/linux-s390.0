From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v9 09/22] s390: vfio-ap: register matrix device with VFIO
 mdev framework
Date: Fri, 17 Aug 2018 15:02:02 -0400
Message-ID: <1966e474-abc9-33a2-8846-17daf4fb3a8d@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-10-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180814131929.37d4b530.cohuck@redhat.com>
 <5b77a5e9-6d91-c7a3-5ada-d888735f0488@linux.ibm.com>
 <20180817104331.378fa130.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180817104331.378fa130.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 08/17/2018 04:43 AM, Cornelia Huck wrote:
> On Thu, 16 Aug 2018 12:24:16 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> On 08/14/2018 07:19 AM, Cornelia Huck wrote:
>>> On Mon, 13 Aug 2018 17:48:06 -0400
>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>> +static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
>>>> +{
>>>> +	struct ap_matrix_mdev *matrix_mdev;
>>>> +
>>>> +	matrix_mdev = kzalloc(sizeof(*matrix_mdev), GFP_KERNEL);
>>>> +	if (!matrix_mdev)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	matrix_mdev->name = dev_name(mdev_dev(mdev));
>>>> +	vfio_ap_matrix_init(&matrix_dev.info, &matrix_mdev->matrix);
>>>> +	mdev_set_drvdata(mdev, matrix_mdev);
>>>> +
>>>> +	if (atomic_dec_if_positive(&matrix_dev.available_instances) < 0) {
>>>> +		kfree(matrix_mdev);
>>>> +		return -EPERM;
>>>> +	}
>>> Maybe move this check to the top of the function?
>> Please ignore my previous response to your comment. I can't move the call to
>> atomic_dec_if_positive() to the top of the function because it
>> decrements the
>> available_instances and if the kzalloc() of matrix_mdev fails, then the
>> value
>> would have to then be incremented to remain valid. What I can do is this:
>>
>> 1. Check the value of available_instances using atomic_read() at the top of
>>      the function and if it is zero, return an error.
>>
>> 2. Replace the call to atomic_dec_if_positive() with a call to atomic_dec()
>>      to decrement the available_instances.
>>
>> I agree that it makes sense to return before attempting to allocate the
>> matrix_mdev if available_instances is zero.
> Wouldn't that be racy, though?
>
> I don't think re-incrementing the counter is too bad, and it's
> certainly better than going through allocation/freeing of structures.

I'll make it happen.

>
>>>   
>>>> +
>>>> +	mutex_lock(&matrix_dev.lock);
>>>> +	list_add(&matrix_mdev->list, &matrix_dev.mdev_list);
>>>> +	mutex_unlock(&matrix_dev.lock);
>>>> +
>>>> +	return 0;
>>>> +}
>>
