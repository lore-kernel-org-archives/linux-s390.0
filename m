From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 11/13] KVM: s390: implement mediated device open
 callback
Date: Wed, 23 May 2018 10:45:36 -0400
Message-ID: <7bb480ac-5723-83ff-c797-53c1ab0458c1@linux.vnet.ibm.com>
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-12-git-send-email-akrowiak@linux.vnet.ibm.com>
 <98ea7ce2-2539-e2ff-4bb4-297e784d87bd@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <98ea7ce2-2539-e2ff-4bb4-297e784d87bd@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pmorel@linux.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: akrowiak@linux.vnet.ibm.com, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 05/16/2018 04:03 AM, Pierre Morel wrote:
> On 07/05/2018 17:11, Tony Krowiak wrote:
>> Implements the open callback on the mediated matrix device.
>> The function registers a group notifier to receive notification
>> of the VFIO_GROUP_NOTIFY_SET_KVM event. When notified,
>> the vfio_ap device driver will get access to the guest's
>> kvm structure. With access to this structure the driver will:
>>
>> 1. Ensure that only one mediated device is opened for the guest
>>
>> 2. Configure access to the AP devices for the guest.
>>
>>     Access to AP adapters, usage domains and control domains
>>     is controlled by three bit masks contained in the Crypto Control
>>     Block (CRYCB) referenced from the guest's SIE state description:
>>
>>     * The AP Mask (APM) controls access to the AP adapters. Each bit
>>       in the APM represents an adapter number - from most significant
>>       to least significant bit - from 0 to 255. The bits in the APM
>>       are set according to the adapter numbers assigned to the mediated
>>       matrix device via its 'assign_adapter' sysfs attribute file.
>>
>>     * The AP Queue Mask (AQM) controls access to the AP queues. Each bit
>>       in the AQM represents an AP queue index - from most significant
>>       to least significant bit - from 0 to 255. A queue index references
>>       a specific domain and is synonymous with the domian number. The
>>       bits in the AQM are set according to the domain numbers assigned
>>       to the mediated matrix device via its 'assign_domain' sysfs
>>       attribute file.
>>
>>     * The AP Domain Mask (ADM) controls access to the AP control 
>> domains.
>>       Each bit in the ADM represents a control domain - from most
>>       significant to least significant bit - from 0-255. The
>>       bits in the ADM are set according to the domain numbers assigned
>>       to the mediated matrix device via its 'assign_control_domain'
>>       sysfs attribute file.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm-ap.h        |   21 ++++++++++
>>   arch/s390/include/asm/kvm_host.h      |    1 +
>>   arch/s390/kvm/kvm-ap.c                |   19 +++++++++
>>   drivers/s390/crypto/vfio_ap_ops.c     |   68 
>> +++++++++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_private.h |    2 +
>>   5 files changed, 111 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/kvm-ap.h 
>> b/arch/s390/include/asm/kvm-ap.h
>> index 21fe9f2..68c5a67 100644
>> --- a/arch/s390/include/asm/kvm-ap.h
>> +++ b/arch/s390/include/asm/kvm-ap.h
>> @@ -83,6 +83,27 @@ struct kvm_ap_matrix {
>>   bool kvm_ap_instructions_available(void);
>>
>>   /**
>> + * kvm_ap_refcount_read
>> + *
>> + * Read the AP reference count and return it.
>> + */
>> +int kvm_ap_refcount_read(struct kvm *kvm);
>> +
>> +/**
>> + * kvm_ap_refcount_inc
>> + *
>> + * Increment the AP reference count.
>> + */
>> +void kvm_ap_refcount_inc(struct kvm *kvm);
>> +
>> +/**
>> + * kvm_ap_refcount_dec
>> + *
>> + * Decrement the AP reference count
>> + */
>> +void kvm_ap_refcount_dec(struct kvm *kvm);
>> +
>> +/**
>>    * kvm_ap_configure_matrix
>>    *
>>    * Configure the AP matrix for a KVM guest.
>> diff --git a/arch/s390/include/asm/kvm_host.h 
>> b/arch/s390/include/asm/kvm_host.h
>> index 8736cde..5f1ad02 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -717,6 +717,7 @@ struct kvm_s390_crypto {
>>       __u8 aes_kw;
>>       __u8 dea_kw;
>>       __u8 apie;
>> +    atomic_t aprefs;
>>   };
>>
>>   #define APCB0_MASK_SIZE 1
>> diff --git a/arch/s390/kvm/kvm-ap.c b/arch/s390/kvm/kvm-ap.c
>> index 98b53c7..848fb37 100644
>> --- a/arch/s390/kvm/kvm-ap.c
>> +++ b/arch/s390/kvm/kvm-ap.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/bitops.h>
>>   #include <asm/kvm-ap.h>
>> +#include <asm/atomic.h>
>>
>>   #include "kvm-s390.h"
>>
>> @@ -218,6 +219,24 @@ static int kvm_ap_validate_queue_sharing(struct 
>> kvm *kvm,
>>       return 0;
>>   }
>>
>> +int kvm_ap_refcount_read(struct kvm *kvm)
>> +{
>> +    return atomic_read(&kvm->arch.crypto.aprefs);
>> +}
>> +EXPORT_SYMBOL(kvm_ap_refcount_read);
>> +
>> +void kvm_ap_refcount_inc(struct kvm *kvm)
>> +{
>> +    atomic_inc(&kvm->arch.crypto.aprefs);
>> +}
>> +EXPORT_SYMBOL(kvm_ap_refcount_inc);
>> +
>> +void kvm_ap_refcount_dec(struct kvm *kvm)
>> +{
>> +    atomic_dec(&kvm->arch.crypto.aprefs);
>> +}
>> +EXPORT_SYMBOL(kvm_ap_refcount_dec);
>
> Why are these functions inside kvm-ap ?
> Will anyone use this outer of vfio-ap ?

As I've stated before, I made the choice to contain all interfaces that
access KVM in kvm-ap because I don't think it is appropriate for the device
driver to have to have "knowledge" of the inner workings of KVM. Why does
it matter whether any entity outside of the vfio_ap device driver calls
these functions? I could ask a similar question if the interfaces were
contained in vfio-ap; what if another device driver needs access to these
interfaces?

>
>
>> +
>>   int kvm_ap_configure_matrix(struct kvm *kvm, struct kvm_ap_matrix 
>> *matrix)
>>   {
>>       int ret = 0;
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>> b/drivers/s390/crypto/vfio_ap_ops.c
>> index 81e03b8..8866b0e 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -11,6 +11,8 @@
>>   #include <linux/device.h>
>>   #include <linux/list.h>
>>   #include <linux/ctype.h>
>> +#include <linux/module.h>
>> +#include <asm/kvm-ap.h>
>>
>>   #include "vfio_ap_private.h"
>>
>> @@ -47,6 +49,70 @@ static int vfio_ap_mdev_remove(struct mdev_device 
>> *mdev)
>>       return 0;
>>   }
>>
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
>> +static int vfio_ap_mdev_open(struct mdev_device *mdev)
>> +{
>> +    struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>> +    unsigned long events;
>> +    int ret;
>> +
>> +    if (!try_module_get(THIS_MODULE))
>> +        return -ENODEV;
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
>> +    /* Only one mediated device allowed per guest */
>> +    if (kvm_ap_refcount_read(matrix_mdev->kvm) != 0) {
>> +        ret = -EEXIST;
>> +        goto out_err;
>> +    }
>
> Testing the existence should be the first thing to do.

That would be better but access to KVM is not available until the
notifier runs.

>
>
>> +
>> +    kvm_ap_refcount_inc(matrix_mdev->kvm);
>> +
>> +    ret = kvm_ap_configure_matrix(matrix_mdev->kvm, 
>> &matrix_mdev->matrix);
>> +    if (ret)
>> +        goto config_err;
>> +
>> +    return 0;
>> +
>> +config_err:
>> +    kvm_ap_refcount_dec(matrix_mdev->kvm);
>> +out_err:
>> +    module_put(THIS_MODULE);
>> +
>> +    return ret;
>> +}
>> +
>> +static void vfio_ap_mdev_release(struct mdev_device *mdev)
>> +{
>> +    struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>> +
>> +    kvm_ap_deconfigure_matrix(matrix_mdev->kvm);
>> +    vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>> +                 &matrix_mdev->group_notifier);
>> +    kvm_ap_refcount_dec(matrix_mdev->kvm);
>> +    module_put(THIS_MODULE);
>> +}
>> +
>>   static ssize_t name_show(struct kobject *kobj, struct device *dev, 
>> char *buf)
>>   {
>>       return sprintf(buf, "%s\n", VFIO_AP_MDEV_NAME_HWVIRT);
>> @@ -773,6 +839,8 @@ static ssize_t matrix_show(struct device *dev, 
>> struct device_attribute *attr,
>>       .mdev_attr_groups    = vfio_ap_mdev_attr_groups,
>>       .create            = vfio_ap_mdev_create,
>>       .remove            = vfio_ap_mdev_remove,
>> +    .open            = vfio_ap_mdev_open,
>> +    .release        = vfio_ap_mdev_release,
>>   };
>>
>>   int vfio_ap_mdev_register(struct ap_matrix *ap_matrix)
>> diff --git a/drivers/s390/crypto/vfio_ap_private.h 
>> b/drivers/s390/crypto/vfio_ap_private.h
>> index 8b6ad66..ab072e9 100644
>> --- a/drivers/s390/crypto/vfio_ap_private.h
>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>> @@ -32,6 +32,8 @@ struct ap_matrix {
>>
>>   struct ap_matrix_mdev {
>>       struct kvm_ap_matrix matrix;
>> +    struct notifier_block group_notifier;
>> +    struct kvm *kvm;
>>   };
>>
>>   static inline struct ap_matrix *to_ap_matrix(struct device *dev)
>
>
