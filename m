From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v1 4/7] vfio: ap: AP Queue Interrupt Control VFIO ioctl
 calls
Date: Thu, 8 Nov 2018 19:00:37 +0100
Message-ID: <29392872-d8a0-3ddd-77fe-342202ed1d2a@linux.ibm.com>
References: <1541009577-29656-1-git-send-email-pmorel@linux.ibm.com>
 <1541009577-29656-5-git-send-email-pmorel@linux.ibm.com>
 <20181107104624.36707cca.cohuck@redhat.com>
 <97094e1c-f74c-7b90-8439-5177301d3189@linux.ibm.com>
 <20181108101435.023e835d.cohuck@redhat.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181108101435.023e835d.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 08/11/2018 10:14, Cornelia Huck wrote:
> On Wed, 7 Nov 2018 23:23:40 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> On 07/11/2018 10:46, Cornelia Huck wrote:
>>> On Wed, 31 Oct 2018 19:12:54 +0100
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>    
>>>> This is the implementation of the VFIO ioctl calls to handle
>>>> the AQIC interception and use GISA to handle interrupts.
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>> ---
>>>>    drivers/s390/crypto/vfio_ap_ops.c | 95 +++++++++++++++++++++++++++++++
>>>>    1 file changed, 95 insertions(+)
>>>>
>>>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>>>> index 272ef427dcc0..f68102163bf4 100644
>>>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>>>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>>>> @@ -895,12 +895,107 @@ static int vfio_ap_mdev_get_device_info(unsigned long arg)
>>>>    	return copy_to_user((void __user *)arg, &info, minsz);
>>>>    }
>>>>    
>>>> +static int ap_ioctl_setirq(struct ap_matrix_mdev *matrix_mdev,
>>>> +			   struct vfio_ap_aqic *parm)
>>>> +{
>>>> +	struct aqic_gisa aqic_gisa = reg2aqic(0);
>>>> +	struct kvm_s390_gisa *gisa = matrix_mdev->kvm->arch.gisa;
>>>> +	struct ap_status ap_status = reg2status(0);
>>>> +	unsigned long p;
>>>> +	int ret = -1;
>>>> +	int apqn;
>>>> +	uint32_t gd;
>>>> +
>>>> +	apqn = (int)(parm->cmd & 0xffff);
>>>
>>> It seems you always use cmd & 0xffff only. What if there is other stuff
>>> in the remaining bits of cmd? Do you plan to ignore it in any case, or
>>> should you actively check that there is nothing in it?
>>>    
>>
>> I do not think that the ioctl interface should reflect the hardware
>> interface.
>> The ioctl interface ignores the remaining bits.
>> We ignore the FC because we obviously want to make a AQIC FC=3
>> We ignore the T bit.
>>
>> But we receive the information from the intercepting software, i.e. QEMU
>> which should I think do the checks before using the ioctl interface.
> 
> Yes, it should; but you still can't know whether it actually did...

I do not care, I just ignore these bits.

> 
>>
>> It seemed easier to me to pass the complete registers and to ignore some
>> bits in them. In case we get any change in the future
>> But we could also only pass the APQN
> 
> I'd prefer to use a well-defined structure that explicitly handles the
> userspace<->kernel communication. Not that we start relying on implicit
> assumptions and then things break when userspace does something
> different...
> 

OK, I can pass a u16 in the ioctl parameters and explicitly reserve the 
ignored bits.

Thanks for the review.

Regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
