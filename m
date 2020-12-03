Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] s390/vfio-ap: Clean up vfio_ap resources when KVM pointer
 invalidated
References: <20201202234101.32169-1-akrowiak@linux.ibm.com>
 <20201203111907.72a89884.cohuck@redhat.com>
 <20201203180141.19425931.pasic@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <3299bd03-f0b8-39ac-4f0e-04bd198633fa@linux.ibm.com>
Date: Thu, 3 Dec 2020 14:14:52 -0500
MIME-Version: 1.0
In-Reply-To: <20201203180141.19425931.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com



On 12/3/20 12:01 PM, Halil Pasic wrote:
> On Thu, 3 Dec 2020 11:19:07 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
>
>>> @@ -1095,7 +1106,7 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>>>   	matrix_mdev = container_of(nb, struct ap_matrix_mdev, group_notifier);
>>>   
>>>   	if (!data) {
>>> -		matrix_mdev->kvm = NULL;
>>> +		vfio_ap_mdev_put_kvm(matrix_mdev);
>> Hm. I'm wondering whether you need to hold the maxtrix_dev lock here as
>> well?
> In v12 we eventually did come along and patch "s390/vfio-ap: allow hot
> plug/unplug of AP resources using mdev device" made this a part of a
> critical section protected by the matrix_dev->lock.
>
> IMHO the cleanup should definitely happen with the matrix_dev->lock held.

Agreed!

>
> Regards,
> Halil
