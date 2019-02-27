From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v4 5/7] s390: ap: implement PAPQ AQIC interception in
 kernel
Date: Wed, 27 Feb 2019 13:17:52 -0500
Message-ID: <019192eb-c13e-052f-6ff1-fa30710cafdf@linux.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-6-git-send-email-pmorel@linux.ibm.com>
 <d8eead83-6d93-4213-c702-c7e684142ff2@linux.ibm.com>
 <57819262-9e59-6f81-b8c4-22bbb1f952c7@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57819262-9e59-6f81-b8c4-22bbb1f952c7@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pmorel@linux.ibm.com, borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 2/27/19 4:54 AM, Pierre Morel wrote:
> On 26/02/2019 19:23, Tony Krowiak wrote:
>> On 2/22/19 10:29 AM, Pierre Morel wrote:
>>> We register the AP PQAP instruction hook during the open
>>> of the mediated device. And unregister it on release.
>>>
>>> In the AP PQAP instruction hook, if we receive a demand to
>>> enable IRQs,
>>> - we retrieve the vfio_ap_queue based on the APQN we receive
>>>    in REG1,
>>> - we retrieve the page of the guest address, (NIB), from
>>>    register REG2
>>> - we the mediated device to use the VFIO pinning infratrsucture
>>>    to pin the page of the guest address,
>>> - we retrieve the pointer to KVM to register the guest ISC
>>>    and retrieve the host ISC
>>> - finaly we activate GISA
>>>
>>> If we receive a demand to disable IRQs,
>>> - we deactivate GISA
>>> - unregister from the GIB
>>> - unping the NIB
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>>>   arch/s390/include/asm/kvm_host.h      |   1 +
>>>   drivers/s390/crypto/ap_bus.h          |   1 +
>>>   drivers/s390/crypto/vfio_ap_ops.c     | 199 
>>> +++++++++++++++++++++++++++++++++-
>>>   drivers/s390/crypto/vfio_ap_private.h |   1 +
>>>   4 files changed, 199 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/s390/include/asm/kvm_host.h 
>>> b/arch/s390/include/asm/kvm_host.h
>>> index 49cc8b0..5f3bb8c 100644
>>> --- a/arch/s390/include/asm/kvm_host.h
>>> +++ b/arch/s390/include/asm/kvm_host.h
>>> @@ -720,6 +720,7 @@ struct kvm_s390_cpu_model {
>>>   struct kvm_s390_crypto {
>>>       struct kvm_s390_crypto_cb *crycb;
>>>       int (*pqap_hook)(struct kvm_vcpu *vcpu);
>>> +    void *vfio_private;
> 
> ...snip...
> 
> 
>>> + *
>>> + * Return 0 if we could handle the request inside KVM.
>>> + * otherwise, returns -EOPNOTSUPP to let QEMU handle the fault.
>>> + */
>>> +static int handle_pqap(struct kvm_vcpu *vcpu)
>>
>> Change this function name to handle_pqap_aqic
> 
> Since we only intercept AQIC, why not.
> 
>>
>>> +{
>>> +}
>>
>> Add this function:
>>
>> static int handle_pqap(struct kvm_vcpu *vcpu)
>> {
>>      int ret;
>>      uint8_t fc;
>>
>>      fc = vcpu->run->s.regs.gprs[0] >> 24;
>>      switch (fc) {
>>      case 0x03:
>>          ret = handle_pqap_aqic(vcpu);
>>          break;
>>      default:
>>          ret = -EOPNOTSUPP;
>>          break;
>>      }
>>
>>      return ret;
>> }
> 
> It is of no use for now, we only intercept AQIC, why introduce this now?
> 
> We can introduce a trampoline when we intercept TAPQ. If we do.

It simplifies adding additional functions down the road, makes the
code much clearer and there is no good reason not to do it.

> 
> 
>>
>>> +
>>> + /*
>>>    * vfio_ap_mdev_iommu_notifier: IOMMU notifier callback
>>>    *
>>>    * @nb: The notifier block
>>> @@ -767,9 +950,10 @@ static int vfio_ap_mdev_iommu_notifier(struct 
>>> notifier_block *nb,
>>>       if (action == VFIO_IOMMU_NOTIFY_DMA_UNMAP) {
>>>           struct vfio_iommu_type1_dma_unmap *unmap = data;
>>> -        unsigned long g_pfn = unmap->iova >> PAGE_SHIFT;
>>> +        unsigned long pfn = unmap->iova >> PAGE_SHIFT;
>>> -        vfio_unpin_pages(mdev_dev(matrix_mdev->mdev), &g_pfn, 1);
>>> +        if (matrix_mdev->mdev)
>>> +            vfio_unpin_pages(mdev_dev(matrix_mdev->mdev), &pfn, 1);
>>>           return NOTIFY_OK;
>>>       }
>>> @@ -879,6 +1063,11 @@ static int vfio_ap_mdev_open(struct mdev_device 
>>> *mdev)
>>>       if (ret)
>>>           goto err_group;
>>> +    if (!matrix_mdev->kvm) {
>>> +        ret = -ENODEV;
>>> +        goto err_iommu;
>>> +    }
>>> +
>>>       matrix_mdev->iommu_notifier.notifier_call = 
>>> vfio_ap_mdev_iommu_notifier;
>>>       events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
>>> @@ -887,6 +1076,8 @@ static int vfio_ap_mdev_open(struct mdev_device 
>>> *mdev)
>>>       if (ret)
>>>           goto err_iommu;
>>> +    matrix_mdev->kvm->arch.crypto.pqap_hook = handle_pqap;
>>> +    matrix_mdev->kvm->arch.crypto.vfio_private = matrix_mdev;
>>
>> I do not see this used anywhere, why do we need it?
> 
> In handle_papq to retrieve the associated mediated device

I don't think this is necessary and IMHO is indicative of a
design flaw. If all vfio_ap_queue objects identifying queues
bound to the vfio_ap driver were maintained in a single list
(i.e., not moved back and forth from the free_list to the qlist)
then there would be no need for this vfio_private field. See
my comments in response to patch 5/7 for the reasons.

> 
>>
>>>       return 0;
>>>   err_iommu:
>>> @@ -905,6 +1096,8 @@ static void vfio_ap_mdev_release(struct 
>>> mdev_device *mdev)
>>>           kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>>>       vfio_ap_mdev_reset_queues(mdev);
>>> +    matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
>>> +    matrix_mdev->kvm->arch.crypto.vfio_private = NULL;
>>
>> Ditto
> 
> ditto
> 
>>
>>>       vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>>>                    &matrix_mdev->group_notifier);
>>>       vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>>> diff --git a/drivers/s390/crypto/vfio_ap_private.h 
>>> b/drivers/s390/crypto/vfio_ap_private.h
>>> index e535735..e2fd2c0 100644
>>> --- a/drivers/s390/crypto/vfio_ap_private.h
>>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>>> @@ -94,6 +94,7 @@ struct vfio_ap_queue {
>>>       struct list_head list;
>>>       struct ap_matrix_mdev *matrix_mdev;
>>>       unsigned long nib;
>>> +    unsigned long g_pfn;
>>
>> Can't this be calculated from the nib?
> 
> It is.
> It is initialized during the IRQ enabling with the current pinned NIB.
> While the nib is initialised with the NIB to be use.
> 
> This allows to unpin the previous pinned NIB in the case the guest reset 
> the queue, which automatically disable interrupt, because in this case 
> the guest will not explicitely disable IRQ by using AQIC.

I'm sorry, I don't understand the point you are making.

> 
> 
> Regards,
> Pierre
> 
> 
