From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v8 17/22] s390: vfio-ap: zeroize the AP queues.
Date: Fri, 10 Aug 2018 12:24:47 -0400
Message-ID: <14983b58-f53b-8bd9-179e-29b9a69c21d8@linux.ibm.com>
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1533739472-7172-18-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180810111445.015fcf2a.cohuck@redhat.com>
 <fa85257e-fda1-8f1d-aa7c-c98e74196d37@linux.ibm.com>
 <20180810131648.4fab1d7a.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180810131648.4fab1d7a.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 08/10/2018 07:16 AM, Cornelia Huck wrote:
> On Fri, 10 Aug 2018 12:49:08 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>
>> On 10/08/2018 11:14, Cornelia Huck wrote:
>>> On Wed,  8 Aug 2018 10:44:27 -0400
>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>   
>>>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>>>
>>>> Let's call PAPQ(ZAPQ) to zeroize a queue:
>>>>
>>>> * For each queue configured for a mediated matrix device
>>>>     when it is released.
>>>>
>>>> Zeroizing a queue resets the queue, clears all pending
>>>> messages for the queue entries and disables adapter interruptions
>>>> associated with the queue.
>>>>
>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>>>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>>>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>> ---
>>>>    drivers/s390/crypto/vfio_ap_ops.c     |   29 ++++++++++++++++++++++++++++-
>>>>    drivers/s390/crypto/vfio_ap_private.h |   25 +++++++++++++++++++++++++
>>>>    2 files changed, 53 insertions(+), 1 deletions(-)
>>>>
>>>> @@ -788,7 +812,10 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
>>>>    {
>>>>    	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>>>>    
>>>> -	kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>>>> +	if (matrix_mdev->kvm)
>>>> +		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>>> Confused. Why is the check for matrix_mdev->kvm added here?
>> When using the KVM notifier we can get two notifications:
>> -> KVM is here / is comming
>> -> KVM is not here / disappearing
>>
>> In the first case we initialize matrix_mdev->kvm with a pointer to KVM
>> In the second case we nullify the pointer.
>>
>> During the open of the mediated device, the guest should have been started
>> or we refuse to start.
>>
>> During the close of the mediated device, the guest should be there, but
>> we have no certitude that the guest did not disappear before the VFIO
>> file being closed.
>> Since we do not allow multiple guests using the same mediated device
>> this case should not happen with QEMU. But I am not sure that
>> a rogue user program could not stop KVM before closing the VFIO
>> mediated device.
> I'm not sure why the check is introduced in this patch, though. But
> maybe I just need weekend :)

Good catch, it belongs in patch 15 where the function is introduced.
Is that the only reason for your objection?

>
>> Maybe Alex can confirm this point, if not we can remove the test.
