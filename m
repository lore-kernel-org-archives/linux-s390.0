Return-Path: <SRS0=KhOk=TH=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v2 2/7] s390: vfio-ap: maintain a shadow of the guest's
 CRYCB
References: <1556918073-13171-1-git-send-email-akrowiak@linux.ibm.com>
 <1556918073-13171-3-git-send-email-akrowiak@linux.ibm.com>
 <2f980dbc-4765-aba8-46fc-848ee66854d6@linux.ibm.com>
 <a47e980e-95e5-f44c-b8fd-e8a7d3d9b625@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 7 May 2019 10:22:06 +0200
MIME-Version: 1.0
In-Reply-To: <a47e980e-95e5-f44c-b8fd-e8a7d3d9b625@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <9d467999-21db-e362-0b65-f0826c6b485d@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com
List-ID: <linux-s390.vger.kernel.org>

On 06/05/2019 21:53, Tony Krowiak wrote:
> On 5/6/19 2:49 AM, Pierre Morel wrote:
>> On 03/05/2019 23:14, Tony Krowiak wrote:
>>> This patch introduces a shadow of the CRYCB being used by a guest. This
>>> will enable to more effectively manage dynamic changes to the AP
>>> resources installed on the host that may be assigned to an mdev device
>>> and being used by a guest. For example:
>>>
>>> * AP adapter cards can be dynamically added to and removed from the AP
>>>    configuration via the SE or an SCLP command.
>>>
>>> * AP resources that disappear and reappear due to hardware malfunctions.
>>>
>>> * AP queues bound to and unbound from the vfio_ap device driver by a
>>>    root user.
>>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>> ---
>>>   drivers/s390/crypto/vfio_ap_ops.c     | 91 
>>> ++++++++++++++++++++++++++++++++---
>>>   drivers/s390/crypto/vfio_ap_private.h |  2 +
>>>   2 files changed, 87 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>>> b/drivers/s390/crypto/vfio_ap_ops.c
>>> index b88a2a2ba075..44a04b4aa9ae 100644
>>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>>> @@ -297,6 +297,45 @@ static void 
>>> vfio_ap_mdev_wait_for_qempty(unsigned long apid, unsigned long apqi)
>>>       } while (--retry);
>>>   }
>>> +/*
>>> + * vfio_ap_mdev_update_crycb
>>> + *
>>> + * @matrix_mdev: the mediated matrix device
>>> + *
>>> + * Updates the AP matrix in the guest's CRYCB from it's shadow masks.
>>> + *
>>> + * Returns zero if the guest's CRYCB is successfully updated; 
>>> otherwise,
>>> + * returns -ENODEV if a guest is not running or does not have a CRYCB.
>>> + */
>>> +static int vfio_ap_mdev_update_crycb(struct ap_matrix_mdev 
>>> *matrix_mdev)
>>> +{
>>> +    if (!matrix_mdev->kvm || !matrix_mdev->kvm->arch.crypto.crycbd)
>>> +        return -ENODEV;
>>> +
>>> +    kvm_arch_crypto_set_masks(matrix_mdev->kvm,
>>> +                  matrix_mdev->shadow_crycb->apm,
>>> +                  matrix_mdev->shadow_crycb->aqm,
>>> +                  matrix_mdev->shadow_crycb->adm);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int match_apqn(struct device *dev, void *data)
>>> +{
>>> +    struct ap_queue *apq = to_ap_queue(dev);
>>> +
>>> +    return (apq->qid == *(unsigned long *)(data)) ? 1 : 0;
>>> +}
>>> +
>>> +static struct device *vfio_ap_get_queue_dev(unsigned long apid,
>>> +                         unsigned long apqi)
>>> +{
>>> +    unsigned long apqn = AP_MKQID(apid, apqi);
>>> +
>>> +    return driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL,
>>> +                  &apqn, match_apqn);
>>> +}
>>> +
>>>   /**
>>>    * assign_adapter_store
>>>    *
>>> @@ -805,14 +844,9 @@ static int vfio_ap_mdev_group_notifier(struct 
>>> notifier_block *nb,
>>>       if (ret)
>>>           return NOTIFY_DONE;
>>> -    /* If there is no CRYCB pointer, then we can't copy the masks */
>>> -    if (!matrix_mdev->kvm->arch.crypto.crycbd)
>>> +    if (vfio_ap_mdev_update_crycb(matrix_mdev))
>>>           return NOTIFY_DONE;
>>> -    kvm_arch_crypto_set_masks(matrix_mdev->kvm, 
>>> matrix_mdev->matrix.apm,
>>> -                  matrix_mdev->matrix.aqm,
>>> -                  matrix_mdev->matrix.adm);
>>> -
>>>       return NOTIFY_OK;
>>>   }
>>> @@ -867,12 +901,55 @@ static int vfio_ap_mdev_reset_queues(struct 
>>> mdev_device *mdev)
>>>       return rc;
>>>   }
>>> +static int vfio_ap_mdev_create_shadow_crycb(struct ap_matrix_mdev 
>>> *matrix_mdev)
>>> +{
>>> +    unsigned long apid, apqi, domid;
>>> +    struct device *dev;
>>> +
>>> +    matrix_mdev->shadow_crycb = 
>>> kzalloc(sizeof(*matrix_mdev->shadow_crycb),
>>> +                        GFP_KERNEL);
>>> +    if (!matrix_mdev->shadow_crycb)
>>> +        return -ENOMEM;
>>> +
>>> +    vfio_ap_matrix_init(&matrix_dev->info, matrix_mdev->shadow_crycb);
>>> +
>>> +    /*
>>> +     * Examine each APQN assigned to the mdev device. Set the APID 
>>> and APQI
>>> +     * in the shadow CRYCB if and only if the queue device 
>>> identified by
>>> +     * the APQN is in the configuration.
>>> +     */
>>> +    for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
>>> +                 matrix_mdev->matrix.apm_max + 1) {
>>> +        for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
>>> +                     matrix_mdev->matrix.aqm_max + 1) {
>>> +            dev = vfio_ap_get_queue_dev(apid, apqi);
>>> +            if (dev) {
>>> +                set_bit_inv(apid,
>>> +                        matrix_mdev->shadow_crycb->apm);
>>> +                set_bit_inv(apqi,
>>> +                        matrix_mdev->shadow_crycb->aqm);
>>> +                put_device(dev);
>>> +            }
>>
>> I think that if we do not find a device here we have a problem.
>> Don't we?
> 
> Other than the fact that the guest will not have any AP devices,
> what would be the problem? What would you suggest?
> 

Suppose we have in matrix_mdev->matrix:
1-2
1-3
2-2
2-3

We set the shadow_crycb with:
we find 1-2 we set 1 2
we find 1-3 we se 1 3
we find 2-2 we set 2 2
we do not find 2-3

we have set apm(1,2) aqm(2,3)
the guest can access 2-3 but we do not have the device.

Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
