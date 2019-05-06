Return-Path: <SRS0=l9rD=TG=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH v2 2/7] s390: vfio-ap: maintain a shadow of the guest's
 CRYCB
References: <1556918073-13171-1-git-send-email-akrowiak@linux.ibm.com>
 <1556918073-13171-3-git-send-email-akrowiak@linux.ibm.com>
 <2f980dbc-4765-aba8-46fc-848ee66854d6@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Mon, 6 May 2019 15:53:09 -0400
MIME-Version: 1.0
In-Reply-To: <2f980dbc-4765-aba8-46fc-848ee66854d6@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <a47e980e-95e5-f44c-b8fd-e8a7d3d9b625@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pmorel@linux.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com
List-ID: <linux-s390.vger.kernel.org>

On 5/6/19 2:49 AM, Pierre Morel wrote:
> On 03/05/2019 23:14, Tony Krowiak wrote:
>> This patch introduces a shadow of the CRYCB being used by a guest. This
>> will enable to more effectively manage dynamic changes to the AP
>> resources installed on the host that may be assigned to an mdev device
>> and being used by a guest. For example:
>>
>> * AP adapter cards can be dynamically added to and removed from the AP
>>    configuration via the SE or an SCLP command.
>>
>> * AP resources that disappear and reappear due to hardware malfunctions.
>>
>> * AP queues bound to and unbound from the vfio_ap device driver by a
>>    root user.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c     | 91 
>> ++++++++++++++++++++++++++++++++---
>>   drivers/s390/crypto/vfio_ap_private.h |  2 +
>>   2 files changed, 87 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>> b/drivers/s390/crypto/vfio_ap_ops.c
>> index b88a2a2ba075..44a04b4aa9ae 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -297,6 +297,45 @@ static void vfio_ap_mdev_wait_for_qempty(unsigned 
>> long apid, unsigned long apqi)
>>       } while (--retry);
>>   }
>> +/*
>> + * vfio_ap_mdev_update_crycb
>> + *
>> + * @matrix_mdev: the mediated matrix device
>> + *
>> + * Updates the AP matrix in the guest's CRYCB from it's shadow masks.
>> + *
>> + * Returns zero if the guest's CRYCB is successfully updated; otherwise,
>> + * returns -ENODEV if a guest is not running or does not have a CRYCB.
>> + */
>> +static int vfio_ap_mdev_update_crycb(struct ap_matrix_mdev *matrix_mdev)
>> +{
>> +    if (!matrix_mdev->kvm || !matrix_mdev->kvm->arch.crypto.crycbd)
>> +        return -ENODEV;
>> +
>> +    kvm_arch_crypto_set_masks(matrix_mdev->kvm,
>> +                  matrix_mdev->shadow_crycb->apm,
>> +                  matrix_mdev->shadow_crycb->aqm,
>> +                  matrix_mdev->shadow_crycb->adm);
>> +
>> +    return 0;
>> +}
>> +
>> +static int match_apqn(struct device *dev, void *data)
>> +{
>> +    struct ap_queue *apq = to_ap_queue(dev);
>> +
>> +    return (apq->qid == *(unsigned long *)(data)) ? 1 : 0;
>> +}
>> +
>> +static struct device *vfio_ap_get_queue_dev(unsigned long apid,
>> +                         unsigned long apqi)
>> +{
>> +    unsigned long apqn = AP_MKQID(apid, apqi);
>> +
>> +    return driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL,
>> +                  &apqn, match_apqn);
>> +}
>> +
>>   /**
>>    * assign_adapter_store
>>    *
>> @@ -805,14 +844,9 @@ static int vfio_ap_mdev_group_notifier(struct 
>> notifier_block *nb,
>>       if (ret)
>>           return NOTIFY_DONE;
>> -    /* If there is no CRYCB pointer, then we can't copy the masks */
>> -    if (!matrix_mdev->kvm->arch.crypto.crycbd)
>> +    if (vfio_ap_mdev_update_crycb(matrix_mdev))
>>           return NOTIFY_DONE;
>> -    kvm_arch_crypto_set_masks(matrix_mdev->kvm, matrix_mdev->matrix.apm,
>> -                  matrix_mdev->matrix.aqm,
>> -                  matrix_mdev->matrix.adm);
>> -
>>       return NOTIFY_OK;
>>   }
>> @@ -867,12 +901,55 @@ static int vfio_ap_mdev_reset_queues(struct 
>> mdev_device *mdev)
>>       return rc;
>>   }
>> +static int vfio_ap_mdev_create_shadow_crycb(struct ap_matrix_mdev 
>> *matrix_mdev)
>> +{
>> +    unsigned long apid, apqi, domid;
>> +    struct device *dev;
>> +
>> +    matrix_mdev->shadow_crycb = 
>> kzalloc(sizeof(*matrix_mdev->shadow_crycb),
>> +                        GFP_KERNEL);
>> +    if (!matrix_mdev->shadow_crycb)
>> +        return -ENOMEM;
>> +
>> +    vfio_ap_matrix_init(&matrix_dev->info, matrix_mdev->shadow_crycb);
>> +
>> +    /*
>> +     * Examine each APQN assigned to the mdev device. Set the APID 
>> and APQI
>> +     * in the shadow CRYCB if and only if the queue device identified by
>> +     * the APQN is in the configuration.
>> +     */
>> +    for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
>> +                 matrix_mdev->matrix.apm_max + 1) {
>> +        for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
>> +                     matrix_mdev->matrix.aqm_max + 1) {
>> +            dev = vfio_ap_get_queue_dev(apid, apqi);
>> +            if (dev) {
>> +                set_bit_inv(apid,
>> +                        matrix_mdev->shadow_crycb->apm);
>> +                set_bit_inv(apqi,
>> +                        matrix_mdev->shadow_crycb->aqm);
>> +                put_device(dev);
>> +            }
> 
> I think that if we do not find a device here we have a problem.
> Don't we?

Other than the fact that the guest will not have any AP devices,
what would be the problem? What would you suggest?

> 
> 
>> +        }
>> +    }
>> +
>> +    /* Set all control domains assigned to the mdev in the shadow 
>> CRYCB */
>> +    for_each_set_bit_inv(domid, matrix_mdev->matrix.adm,
>> +                 matrix_mdev->matrix.adm_max + 1)
>> +        set_bit_inv(domid, matrix_mdev->shadow_crycb->adm);
>> +
>> +    return 0;
>> +}
>> +
>>   static int vfio_ap_mdev_open(struct mdev_device *mdev)
>>   {
>>       struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>>       unsigned long events;
>>       int ret;
>> +    ret = vfio_ap_mdev_create_shadow_crycb(matrix_mdev);
>> +    if (ret)
>> +        return ret;
>>       if (!try_module_get(THIS_MODULE))
>>           return -ENODEV;
>> @@ -902,6 +979,8 @@ static void vfio_ap_mdev_release(struct 
>> mdev_device *mdev)
>>                    &matrix_mdev->group_notifier);
>>       matrix_mdev->kvm = NULL;
>>       module_put(THIS_MODULE);
>> +    kfree(matrix_mdev->shadow_crycb);
>> +    matrix_mdev->shadow_crycb = NULL;
>>   }
>>   static int vfio_ap_mdev_get_device_info(unsigned long arg)
>> diff --git a/drivers/s390/crypto/vfio_ap_private.h 
>> b/drivers/s390/crypto/vfio_ap_private.h
>> index 76b7f98e47e9..e8457aa61976 100644
>> --- a/drivers/s390/crypto/vfio_ap_private.h
>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>> @@ -72,6 +72,7 @@ struct ap_matrix {
>>    * @list:    allows the ap_matrix_mdev struct to be added to a list
>>    * @matrix:    the adapters, usage domains and control domains 
>> assigned to the
>>    *        mediated matrix device.
>> + * @shadow_crycb: a shadow copy of the crycb in use by a guest
>>    * @group_notifier: notifier block used for specifying callback 
>> function for
>>    *            handling the VFIO_GROUP_NOTIFY_SET_KVM event
>>    * @kvm:    the struct holding guest's state
>> @@ -79,6 +80,7 @@ struct ap_matrix {
>>   struct ap_matrix_mdev {
>>       struct list_head node;
>>       struct ap_matrix matrix;
>> +    struct ap_matrix *shadow_crycb;
>>       struct notifier_block group_notifier;
>>       struct kvm *kvm;
>>   };
>>
> 
> 
