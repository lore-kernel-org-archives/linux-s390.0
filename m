From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v6 3/7] s390: ap: setup relation betwen KVM and mediated
 device
Date: Fri, 29 Mar 2019 09:58:42 +0100
Message-ID: <cce25d53-9076-d54f-10d7-46526b5f7e54@linux.ibm.com>
References: <1553265828-27823-1-git-send-email-pmorel@linux.ibm.com>
 <1553265828-27823-4-git-send-email-pmorel@linux.ibm.com>
 <1ea236d1-ca0b-03c0-3699-0c0deb435785@linux.ibm.com>
 <3cd496d0-3eec-78e8-9ea5-4d62fe0cff1c@linux.ibm.com>
 <eaac369f-132b-b83f-fa14-8749819388ba@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <eaac369f-132b-b83f-fa14-8749819388ba@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 28/03/2019 18:25, Tony Krowiak wrote:
> On 3/28/19 12:27 PM, Pierre Morel wrote:
>> On 28/03/2019 17:12, Tony Krowiak wrote:
>>> On 3/22/19 10:43 AM, Pierre Morel wrote:
>>>> When the mediated device is open we setup the relation with KVM 
>>>> unset it
>>>> when the mediated device is released.
>>>
>>> s/open we setup/open, we set up/
>>> s/with KVM unset/with KVM and unset/
>>>
>>>>
>>>> We lock the matrix mediated device to avoid any change until the
>>>> open is done.
>>>> We make sure that KVM is present when opening the mediated device
>>>> otherwise we return an error.
>>>
>>> s/mediated device/mediated device,/
>>>
>>>>
>>>> Increase kvm's refcount to ensure the KVM structures are still 
>>>> available
>>>> during the use of the mediated device by the guest.
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>> ---
>>>>   drivers/s390/crypto/vfio_ap_ops.c | 143 
>>>> +++++++++++++++++++++-----------------
>>>>   1 file changed, 79 insertions(+), 64 deletions(-)
>>>>
>>>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>>>> b/drivers/s390/crypto/vfio_ap_ops.c
>>>> index 77f7bac..bdb36e0 100644
>>>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>>>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>>>> @@ -787,74 +787,24 @@ static const struct attribute_group 
>>>> *vfio_ap_mdev_attr_groups[] = {
>>>>       NULL
>>>>   };
>>>> -/**
>>>> - * vfio_ap_mdev_set_kvm
>>>> - *
>>>> - * @matrix_mdev: a mediated matrix device
>>>> - * @kvm: reference to KVM instance
>>>> - *
>>>> - * Verifies no other mediated matrix device has @kvm and sets a 
>>>> reference to
>>>> - * it in @matrix_mdev->kvm.
>>>> - *
>>>> - * Return 0 if no other mediated matrix device has a reference to 
>>>> @kvm;
>>>> - * otherwise, returns an -EPERM.
>>>> - */
>>>> -static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
>>>> -                struct kvm *kvm)
>>>> -{
>>>> -    struct ap_matrix_mdev *m;
>>>> -
>>>> -    mutex_lock(&matrix_dev->lock);
>>>> -
>>>> -    list_for_each_entry(m, &matrix_dev->mdev_list, node) {
>>>> -        if ((m != matrix_mdev) && (m->kvm == kvm)) {
>>>> -            mutex_unlock(&matrix_dev->lock);
>>>> -            return -EPERM;
>>>> -        }
>>>> -    }
>>>> -
>>>> -    matrix_mdev->kvm = kvm;
>>>> -    mutex_unlock(&matrix_dev->lock);
>>>> -
>>>> -    return 0;
>>>> -}
>>>> -
>>>>   static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>>>>                          unsigned long action, void *data)
>>>>   {
>>>> -    int ret;
>>>>       struct ap_matrix_mdev *matrix_mdev;
>>>>       if (action != VFIO_GROUP_NOTIFY_SET_KVM)
>>>>           return NOTIFY_OK;
>>>>       matrix_mdev = container_of(nb, struct ap_matrix_mdev, 
>>>> group_notifier);
>>>> -
>>>> -    if (!data) {
>>>> -        matrix_mdev->kvm = NULL;
>>>> -        return NOTIFY_OK;
>>>> -    }
>>>> -
>>>> -    ret = vfio_ap_mdev_set_kvm(matrix_mdev, data);
>>>> -    if (ret)
>>>> -        return NOTIFY_DONE;
>>>> -
>>>> -    /* If there is no CRYCB pointer, then we can't copy the masks */
>>>> -    if (!matrix_mdev->kvm->arch.crypto.crycbd)
>>>> -        return NOTIFY_DONE;
>>>> -
>>>> -    kvm_arch_crypto_set_masks(matrix_mdev->kvm, 
>>>> matrix_mdev->matrix.apm,
>>>> -                  matrix_mdev->matrix.aqm,
>>>> -                  matrix_mdev->matrix.adm);
>>>> +    matrix_mdev->kvm = data;
>>>>       return NOTIFY_OK;
>>>>   }
>>>> -static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
>>>> +static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev 
>>>> *matrix_mdev)
>>>>   {
>>>>       int ret;
>>>>       int rc = 0;
>>>> -    struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>>>>       struct vfio_ap_queue *q;
>>>>       list_for_each_entry(q, &matrix_mdev->qlist, list) {
>>>> @@ -871,41 +821,106 @@ static int vfio_ap_mdev_reset_queues(struct 
>>>> mdev_device *mdev)
>>>>       return rc;
>>>>   }
>>>> +/**
>>>> + * vfio_ap_mdev_set_kvm
>>>> + *
>>>> + * @matrix_mdev: a mediated matrix device
>>>> + *
>>>> + * - Verifies that the hook is free and install the PQAP hook
>>>> + * - Copy the matrix masks inside the CRYCB
>>>> + * - Increment the KVM rerference count
>>>> + *
>>>> + * Return 0 if no other mediated matrix device has a reference to 
>>>> @kvm;
>>>> + * otherwise, returns an -EPERM.
>>>> + */
>>>> +static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev)
>>>> +{
>>>> +    if (matrix_mdev->kvm->arch.crypto.pqap_hook)
>>>> +        return -EPERM;
>>>
>>> How would this happen; in other words, why are we checking this?
>>
>> I check this to verify that no other AP mediated device is already in 
>> use by this VM.
> 
> Maybe you should insert a comment to that effect.

Please notice that there is already a comment on this in the description 
of the function.

Regards,
Pierre



-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
