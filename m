From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v4 6/7] s390: ap: Cleanup on removing the AP device
Date: Wed, 13 Mar 2019 11:15:20 +0100
Message-ID: <85f772b4-0b62-701d-c3e5-e55e88c3fb4e@linux.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-7-git-send-email-pmorel@linux.ibm.com>
 <3956ad4c-55c9-e42c-4ab2-00ddae05b317@linux.ibm.com>
 <94904df0-42b6-51f8-6440-68722ef5419d@linux.ibm.com>
 <cf148acb-1a07-ffa3-f728-0f6b02aa914d@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cf148acb-1a07-ffa3-f728-0f6b02aa914d@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 12/03/2019 22:53, Tony Krowiak wrote:
> On 3/11/19 4:31 AM, Pierre Morel wrote:
>> On 08/03/2019 23:43, Tony Krowiak wrote:
>>> On 2/22/19 10:29 AM, Pierre Morel wrote:
>>>> When the device is remove, we must make sure to
>>>> clear the interruption and reset the AP device.
>>>>
>>>> We also need to clear the CRYCB of the guest.
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>> ---
>>>>   drivers/s390/crypto/vfio_ap_drv.c     | 35 
>>>> +++++++++++++++++++++++++++++++++++
>>>>   drivers/s390/crypto/vfio_ap_ops.c     |  3 ++-
>>>>   drivers/s390/crypto/vfio_ap_private.h |  3 +++
>>>>   3 files changed, 40 insertions(+), 1 deletion(-)
>>>>

...snip...

>>>> + * vfio_ap_update_crycb
>>>> + * @q: A pointer to the queue being removed
>>>> + *
>>>> + * We clear the APID of the queue, making this queue unusable for 
>>>> the guest.
>>>> + * After this function we can reset the queue without to fear a 
>>>> race with
>>>> + * the guest to access the queue again.
>>>> + * We do not fear race with the host as we still get the devic
>>>> + */
>>>> +static void vfio_ap_update_crycb(struct vfio_ap_queue *q)
>>>> +{
>>>> +    struct ap_matrix_mdev *matrix_mdev = q->matrix_mdev;
>>>> +
>>>> +    if (!matrix_mdev)
>>>> +        return;
>>>> +
> 
> You should probably check whether the APID has been cleared before
> proceeding. Take the case where an AP with multiple queues is removed
> from the configuration via the SE or SCLP. The AP bus is going to invoke
> the vfio_ap_queue_dev_remove() function for each of the queues. The APID
> will get cleared on the first remove, so it is not only unnecessary to
> clear it on subsequent removes, it is kind of nasty to keep resetting
> the masks in the guest's CRYCB (below) each time the remove callback is
> invoked.

This can not happen.
The only way to clear the APM is when the matrix is not associated with KVM.

This case is tested and the masks are not changed.

> 
>>>> +    clear_bit_inv(AP_QID_CARD(q->apqn), matrix_mdev->matrix.apm);
>>>> +
>>>> +    if (!matrix_mdev->kvm)
>>>> +        return;
>>>> +
>>>> +    kvm_arch_crypto_set_masks(matrix_mdev->kvm,
>>>> +                  matrix_mdev->matrix.apm,
>>>> +                  matrix_mdev->matrix.aqm,
>>>> +                  matrix_mdev->matrix.adm);
>>>> +}




-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
