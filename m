From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 13/15] KVM: s390: Configure the guest's CRYCB
Date: Wed, 28 Feb 2018 15:45:56 -0500
Message-ID: <fdb264da-dd74-f380-78dc-7abc61f1484b@linux.vnet.ibm.com>
References: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1519741693-17440-14-git-send-email-akrowiak@linux.vnet.ibm.com>
 <99b24fc7-3df9-6620-d1df-917214fbdda2@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <99b24fc7-3df9-6620-d1df-917214fbdda2@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 02/28/2018 04:49 AM, David Hildenbrand wrote:
>> +static int vfio_ap_mdev_open(struct mdev_device *mdev)
>> +{
>> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>> +	unsigned long events;
>> +	int ret;
>> +
>> +	matrix_mdev->group_notifier.notifier_call = vfio_ap_mdev_group_notifier;
>> +	events = VFIO_GROUP_NOTIFY_SET_KVM;
>> +	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>> +				     &events, &matrix_mdev->group_notifier);
>> +
>> +	ret = kvm_ap_configure_matrix(matrix_mdev->kvm,
>> +				      matrix_mdev->matrix);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = kvm_ap_enable_ie_mode(matrix_mdev->kvm);
> Can't this happen while the guest is already running? Or what hinders us
> from doing that?
I'm not sure exactly what you're asking here. Are you asking if the 
vfio_ap_mdev_open()
function can be called multiple times while the guest is running? AFAIK 
this will be
called only once when the mediated device's file descriptor is opened. 
This happens in
QEMU when the -device vfio-ap device is realized.

>
>> +
>> +	return ret;
>> +}
>> +
>> +static void vfio_ap_mdev_release(struct mdev_device *mdev)
> Thanks,
>
> David / dhildenb
>
