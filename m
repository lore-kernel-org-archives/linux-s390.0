From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v6 14/21] s390: vfio-ap: implement mediated device open
 callback
Date: Fri, 13 Jul 2018 12:48:49 +0200
Message-ID: <3c9a3de0-4c03-606b-72f1-0afb462844a7@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-15-git-send-email-akrowiak@linux.vnet.ibm.com>
 <c8dbb517-88e6-6976-f754-64e3597d0e71@linux.ibm.com>
 <9c7ef696-79e5-ef51-be1a-3402a9bb6749@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9c7ef696-79e5-ef51-be1a-3402a9bb6749@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 07/12/2018 06:03 PM, Tony Krowiak wrote:
>>> +static int vfio_ap_mdev_open(struct mdev_device *mdev)
>>> +{
>>> +    struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>>> +    struct ap_matrix_dev *matrix_dev =
>>> +        to_ap_matrix_dev(mdev_parent_dev(mdev));
>>> +    unsigned long events;
>>> +    int ret;
>>> +
>>> +    if (!try_module_get(THIS_MODULE))
>>> +        return -ENODEV;
>>> +
>>> +    ret = vfio_ap_verify_queues_reserved(matrix_dev, matrix_mdev->name,
>>> +                         &matrix_mdev->matrix);
>>> +    if (ret)
>>> +        goto out_err;
>>> +
>>> +    matrix_mdev->group_notifier.notifier_call = vfio_ap_mdev_group_notifier;
>>> +    events = VFIO_GROUP_NOTIFY_SET_KVM;
>>> +
>>> +    ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>>> +                     &events, &matrix_mdev->group_notifier);
>>> +    if (ret)
>>> +        goto out_err;
>>> +
>>> +    ret = kvm_ap_validate_crypto_setup(matrix_mdev->kvm);
>>
>> At this point you assume that your vfio_ap_mdev_group_notifier callback
>> was called with VFIO_GROUP_NOTIFY_SET_KVM and that you do have
>> matrix_mdev->kvm set up properly.
>>
>> Based on how callbacks usually work this seems rather strange. It's
>> probably cleaner to set up he cyrcb (including all the validation
>> that needs to be done immediately before) in the callback
>> (vfio_ap_mdev_group_notifier).
>>
>> If that is not viable I think we need a comment here explaining why is this
>> OK (at least).
> 
> This was originally in the callback and moved out, to the best of my recollection,
> because the validation at that time was done on the CRYCB and if that validation
> failed, there was no way to notify the client (QEMU) that configuration of the
> guest's CRYCB failed from the notification callback. This works - at least as far
> as I can tell from testing - because the registration of the notifier invokes the
> notification callback if KVM has already been set and that appears to be the case.
> You are correct, however; we probably shouldn't bank on that given that
> I don't think we can guarantee that to be the case 100% of the time. Consequently,
> I will move this back into the notification callback and since consistency checking
> is now being done on the mdev devices instead of the CRYCB, we don't need KVM at open
> time.

Sounds good to me. Making the open fail was not a good way to communicate this
error condition to userspace anyway.


Regards,
Halil
