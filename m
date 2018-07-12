From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v6 14/21] s390: vfio-ap: implement mediated device open
 callback
Date: Thu, 12 Jul 2018 18:03:46 +0200
Message-ID: <9c7ef696-79e5-ef51-be1a-3402a9bb6749@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-15-git-send-email-akrowiak@linux.vnet.ibm.com>
 <c8dbb517-88e6-6976-f754-64e3597d0e71@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c8dbb517-88e6-6976-f754-64e3597d0e71@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 07/12/2018 02:47 PM, Halil Pasic wrote:
>
>
> On 06/29/2018 11:11 PM, Tony Krowiak wrote:
>> Implements the open callback on the mediated matrix device.
>> The function registers a group notifier to receive notification
>> of the VFIO_GROUP_NOTIFY_SET_KVM event. When notified,
>> the vfio_ap device driver will get access to the guest's
>> kvm structure. The open callback must ensure that only one
>> mediated device shall be opened per guest.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c     |  128 
>> +++++++++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_private.h |    2 +
>>   2 files changed, 130 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>> b/drivers/s390/crypto/vfio_ap_ops.c
>> index bc7398d..58be495 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -11,6 +11,10 @@
>>   #include <linux/device.h>
>>   #include <linux/list.h>
>>   #include <linux/ctype.h>
>> +#include <linux/bitops.h>
>> +#include <linux/kvm_host.h>
>> +#include <linux/module.h>
>> +#include <asm/kvm.h>
>>     #include "vfio_ap_private.h"
>>   @@ -748,12 +752,136 @@ static ssize_t matrix_show(struct device 
>> *dev, struct device_attribute *attr,
>>       NULL
>>   };
>>   +/**
>> + * Verify that the AP instructions are available on the guest and 
>> are to be
>> + * interpreted by the firmware. The former is indicated via the
>> + * KVM_S390_VM_CPU_FEAT_AP CPU model feature and the latter by apie 
>> crypto
>> + * flag.
>> + */
>> +static int kvm_ap_validate_crypto_setup(struct kvm *kvm)
>> +{
>> +    if (test_bit_inv(KVM_S390_VM_CPU_FEAT_AP, kvm->arch.cpu_feat) &&
>> +        kvm->arch.crypto.apie)
>> +        return 0;
>> +
>> +    pr_err("%s: interpretation of AP instructions not available",
>> +           VFIO_AP_MODULE_NAME);
>> +
>> +    return -EOPNOTSUPP;
>> +}
>> +
>> +static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>> +                       unsigned long action, void *data)
>> +{
>> +    struct ap_matrix_mdev *matrix_mdev;
>> +
>> +    if (action == VFIO_GROUP_NOTIFY_SET_KVM) {
>> +        matrix_mdev = container_of(nb, struct ap_matrix_mdev,
>> +                       group_notifier);
>> +        matrix_mdev->kvm = data;
>> +    }
>> +
>> +    return NOTIFY_OK;
>> +}
>> +
>
> [..]
>
>> +
>> +static int vfio_ap_mdev_open(struct mdev_device *mdev)
>> +{
>> +    struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>> +    struct ap_matrix_dev *matrix_dev =
>> +        to_ap_matrix_dev(mdev_parent_dev(mdev));
>> +    unsigned long events;
>> +    int ret;
>> +
>> +    if (!try_module_get(THIS_MODULE))
>> +        return -ENODEV;
>> +
>> +    ret = vfio_ap_verify_queues_reserved(matrix_dev, matrix_mdev->name,
>> +                         &matrix_mdev->matrix);
>> +    if (ret)
>> +        goto out_err;
>> +
>> +    matrix_mdev->group_notifier.notifier_call = 
>> vfio_ap_mdev_group_notifier;
>> +    events = VFIO_GROUP_NOTIFY_SET_KVM;
>> +
>> +    ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>> +                     &events, &matrix_mdev->group_notifier);
>> +    if (ret)
>> +        goto out_err;
>> +
>> +    ret = kvm_ap_validate_crypto_setup(matrix_mdev->kvm);
>
> At this point you assume that your vfio_ap_mdev_group_notifier callback
> was called with VFIO_GROUP_NOTIFY_SET_KVM and that you do have
> matrix_mdev->kvm set up properly.
>
> Based on how callbacks usually work this seems rather strange. It's
> probably cleaner to set up he cyrcb (including all the validation
> that needs to be done immediately before) in the callback
> (vfio_ap_mdev_group_notifier).
>
> If that is not viable I think we need a comment here explaining why is 
> this
> OK (at least).

This was originally in the callback and moved out, to the best of my 
recollection,
because the validation at that time was done on the CRYCB and if that 
validation
failed, there was no way to notify the client (QEMU) that configuration 
of the
guest's CRYCB failed from the notification callback. This works - at 
least as far
as I can tell from testing - because the registration of the notifier 
invokes the
notification callback if KVM has already been set and that appears to be 
the case.
You are correct, however; we probably shouldn't bank on that given that
I don't think we can guarantee that to be the case 100% of the time. 
Consequently,
I will move this back into the notification callback and since 
consistency checking
is now being done on the mdev devices instead of the CRYCB, we don't 
need KVM at open
time.

>
>
> Regards,
> Halil
>
>> +    if (ret)
>> +        goto out_kvm_err;
>> +
>> +    ret = vfio_ap_mdev_open_once(matrix_mdev);
>> +    if (ret)
>> +        goto out_kvm_err;
>> +
>> +    return 0;
>> +
>> +out_kvm_err:
>> +    vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>> +                 &matrix_mdev->group_notifier);
>> +    matrix_mdev->kvm = NULL;
>> +out_err:
>> +    module_put(THIS_MODULE);
>> +
>> +    return ret;
>> +}
>> +
>>
>
> [..]
