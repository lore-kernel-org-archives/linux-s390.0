Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725840AbgLQArV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 16 Dec 2020 19:47:21 -0500
Subject: Re: [PATCH v3] s390/vfio-ap: clean up vfio_ap resources when KVM
 pointer invalidated
References: <20201214165617.28685-1-akrowiak@linux.ibm.com>
 <20201215115746.3552e873.pasic@linux.ibm.com>
 <44ffb312-964a-95c3-d691-38221cee2c0a@de.ibm.com>
 <20201216022140.02741788.pasic@linux.ibm.com>
 <ae6e5c7a-0159-035e-2bd3-0a749f81a7c0@de.ibm.com>
 <1039a56a-f8d7-15f7-d6a6-cb126468bdff@de.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <b763a147-5122-5342-30b8-8ddbbbe0696f@linux.ibm.com>
Date: Wed, 16 Dec 2020 19:46:34 -0500
MIME-Version: 1.0
In-Reply-To: <1039a56a-f8d7-15f7-d6a6-cb126468bdff@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, cohuck@redhat.com, kwankhede@nvidia.com, pbonzini@redhat.com, alex.williamson@redhat.com, pasic@linux.vnet.ibm.com



On 12/16/20 11:05 AM, Christian Borntraeger wrote:
>
> On 16.12.20 10:58, Christian Borntraeger wrote:
>> On 16.12.20 02:21, Halil Pasic wrote:
>>> On Tue, 15 Dec 2020 19:10:20 +0100
>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>>
>>>>
>>>> On 15.12.20 11:57, Halil Pasic wrote:
>>>>> On Mon, 14 Dec 2020 11:56:17 -0500
>>>>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>>>>
>>>>>> The vfio_ap device driver registers a group notifier with VFIO when the
>>>>>> file descriptor for a VFIO mediated device for a KVM guest is opened to
>>>>>> receive notification that the KVM pointer is set (VFIO_GROUP_NOTIFY_SET_KVM
>>>>>> event). When the KVM pointer is set, the vfio_ap driver takes the
>>>>>> following actions:
>>>>>> 1. Stashes the KVM pointer in the vfio_ap_mdev struct that holds the state
>>>>>>     of the mediated device.
>>>>>> 2. Calls the kvm_get_kvm() function to increment its reference counter.
>>>>>> 3. Sets the function pointer to the function that handles interception of
>>>>>>     the instruction that enables/disables interrupt processing.
>>>>>> 4. Sets the masks in the KVM guest's CRYCB to pass AP resources through to
>>>>>>     the guest.
>>>>>>
>>>>>> In order to avoid memory leaks, when the notifier is called to receive
>>>>>> notification that the KVM pointer has been set to NULL, the vfio_ap device
>>>>>> driver should reverse the actions taken when the KVM pointer was set.
>>>>>>
>>>>>> Fixes: 258287c994de ("s390: vfio-ap: implement mediated device open callback")
>>>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>>>>> ---
>>>>>>   drivers/s390/crypto/vfio_ap_ops.c | 29 ++++++++++++++++++++---------
>>>>>>   1 file changed, 20 insertions(+), 9 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>>>>>> index e0bde8518745..cd22e85588e1 100644
>>>>>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>>>>>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>>>>>> @@ -1037,8 +1037,6 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
>>>>>>   {
>>>>>>   	struct ap_matrix_mdev *m;
>>>>>>
>>>>>> -	mutex_lock(&matrix_dev->lock);
>>>>>> -
>>>>>>   	list_for_each_entry(m, &matrix_dev->mdev_list, node) {
>>>>>>   		if ((m != matrix_mdev) && (m->kvm == kvm)) {
>>>>>>   			mutex_unlock(&matrix_dev->lock);
>>>>>> @@ -1049,7 +1047,6 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
>>>>>>   	matrix_mdev->kvm = kvm;
>>>>>>   	kvm_get_kvm(kvm);
>>>>>>   	kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
>>>>>> -	mutex_unlock(&matrix_dev->lock);
>>>>>>
>>>>>>   	return 0;
>>>>>>   }
>>>>>> @@ -1083,35 +1080,49 @@ static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
>>>>>>   	return NOTIFY_DONE;
>>>>>>   }
>>>>>>
>>>>>> +static void "(struct ap_matrix_mdev *matrix_mdev)
>>>>>> +{
>>>>>> +	kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>>>>>> +	matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
>>>>>
>>>>> This patch LGTM. The only concern I have with it is whether a
>>>>> different cpu is guaranteed to observe the above assignment as
>>>>> an atomic operation. I think we didn't finish this discussion
>>>>> at v1, or did we?
>>>> You mean just this assigment:
>>>>>> +	matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
>>>> should either have the old or the new value, but not halve zero halve old?
>>>>
>>> Yes that is the assignment I was referring to. Old value will work as well because
>>> kvm holds a reference to this module while in the pqap_hook.
>>>   
>>>> Normally this should be ok (and I would consider this a compiler bug if
>>>> this is split into 2 32 bit zeroes) But if you really want to be sure then we
>>>> can use WRITE_ONCE.
>>> Just my curiosity: what would make this a bug? Is it the s390 elf ABI,
>>> or some gcc feature, or even the C standard? Also how exactly would
>>> WRITE_ONCE, also access via volatile help in this particular situation?
>> I think its a tricky things and not strictly guaranteed, but there is a lot
>> of code that relies on the atomicity of word sizes. see for example the discussion
>> here
>> https://lore.kernel.org/lkml/CAHk-=wgC4+kV9AiLokw7cPP429rKCU+vjA8cWAfyOjC3MtqC4A@mail.gmail.com/
>>
>> WRITE_ONCE will not change the guarantees a lot, but it is mostly a documentation
>> that we assume atomic access here.
> After looking again at the code, I think I have to correct myself.
> WRITE_ONCE does not look necessary.
>
>
> Another thing, though:
> Shouldnt we also replace this code
>
> [...]
> static void vfio_ap_mdev_release(struct mdev_device *mdev)
> {
>          struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>
>          mutex_lock(&matrix_dev->lock);
>          if (matrix_mdev->kvm) {
> --->          kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
> --->          matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
> --->          vfio_ap_mdev_reset_queues(mdev);
> --->          kvm_put_kvm(matrix_mdev->kvm);
> --->          matrix_mdev->kvm = NULL;
> [...]
>
> with vfio_ap_mdev_unset_kvm ?

I had that in the v2 patches, but mistakenly removed it
because of a misinterpretation of the docs on posting a
patch for a stable release. I'll restore it since I have to
remove the unlock from the vfio_ap_mdev_unset_kvm
function.
