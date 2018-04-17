From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 13/15] KVM: s390: configure the guest's AP devices
Date: Tue, 17 Apr 2018 18:18:50 +0200
Message-ID: <105bce81-9359-6096-88ce-01ec1aef523e@linux.vnet.ibm.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1523827345-11600-14-git-send-email-akrowiak@linux.vnet.ibm.com>
 <2e7387b9-ceb4-cdca-56ac-f5344084e10a@linux.vnet.ibm.com>
 <c81ae786-1f37-e9b0-1f1a-1bb00180784c@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c81ae786-1f37-e9b0-1f1a-1bb00180784c@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 17/04/2018 18:08, Tony Krowiak wrote:
> On 04/16/2018 09:05 AM, Pierre Morel wrote:
>> On 15/04/2018 23:22, Tony Krowiak wrote:
>>> Registers a group notifier during the open of the mediated
>>> matrix device to get information on KVM presence through the
>>> VFIO_GROUP_NOTIFY_SET_KVM event. When notified, the pointer
>>> to the kvm structure is saved inside the mediated matrix
>>> device. Once the VFIO AP device driver has access to KVM,
>>> access to the APs can be configured for the guest.
>>>
>>> Access to APs is configured when the file descriptor for the
>>> mediated matrix device is opened by userspace. The items to be
>>> configured are:
>>>
>>> 1. The ECA.28 bit in the SIE state description determines whether
>>>     AP instructions are interpreted by the hardware or intercepted.
>>>     The VFIO AP device driver relies interpretive execution of
>>>     AP instructions so the ECA.28 bit will be set
>>>
>>> 2. Guest access to AP adapters, usage domains and control domains
>>>     is controlled by three bit masks referenced from the
>>>     Crypto Control Block (CRYCB) referenced from the guest's SIE state
>>>     description:
>>>
>>>     * The AP Mask (APM) controls access to the AP adapters. Each bit
>>>       in the APM represents an adapter number - from most significant
>>>       to least significant bit - from 0 to 255. The bits in the APM
>>>       are set according to the adapter numbers assigned to the mediated
>>>       matrix device via its 'assign_adapter' sysfs attribute file.
>>>
>>>     * The AP Queue (AQM) controls access to the AP queues. Each bit
>>>       in the AQM represents an AP queue index - from most significant
>>>       to least significant bit - from 0 to 255. A queue index 
>>> references
>>>       a specific domain and is synonymous with the domian number. The
>>>       bits in the AQM are set according to the domain numbers assigned
>>>       to the mediated matrix device via its 'assign_domain' sysfs
>>>       attribute file.
>>>
>>>     * The AP Domain Mask (ADM) controls access to the AP control 
>>> domains.
>>>       Each bit in the ADM represents a control domain - from most
>>>       significant to least significant bit - from 0-255. The
>>>       bits in the ADM are set according to the domain numbers assigned
>>>       to the mediated matrix device via its 'assign_control_domain'
>>>       sysfs attribute file.
>>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>>> ---
>>>   drivers/s390/crypto/vfio_ap_ops.c     |   50 
>>> +++++++++++++++++++++++++++++++++
>>>   drivers/s390/crypto/vfio_ap_private.h |    2 +
>>>   2 files changed, 52 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>>> b/drivers/s390/crypto/vfio_ap_ops.c
>>> index bc2b05e..e3ff5ab 100644
>>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>>> @@ -53,6 +53,54 @@ static int vfio_ap_mdev_remove(struct mdev_device 
>>> *mdev)
>>>       return 0;
>>>   }
>>>
>>> +static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>>> +                       unsigned long action, void *data)
>>> +{
>>> +    struct ap_matrix_mdev *matrix_mdev;
>>> +
>>> +    if (action == VFIO_GROUP_NOTIFY_SET_KVM) {
>>> +        matrix_mdev = container_of(nb, struct ap_matrix_mdev,
>>> +                       group_notifier);
>>> +        matrix_mdev->kvm = data;
>>> +    }
>>> +
>>> +    return NOTIFY_OK;
>>> +}
>>> +
>>> +static int vfio_ap_mdev_open(struct mdev_device *mdev)
>>> +{
>>> +    struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>>> +    unsigned long events;
>>> +    int ret;
>>> +
>>> +    matrix_mdev->group_notifier.notifier_call = 
>>> vfio_ap_mdev_group_notifier;
>>> +    events = VFIO_GROUP_NOTIFY_SET_KVM;
>>> +
>>> +    ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>>> +                     &events, &matrix_mdev->group_notifier);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = kvm_ap_interpret_instructions(matrix_mdev->kvm, true);
>>
>> Do you need this call ?
>> apie is always enabled in KVM if AP instructions are available.
>
> I suppose we don't, in which case we don't need the 
> kvm_ap_interpret_instructions()
> function either ... at least not until we implement interception.
>
>>
>>
>> Setting or not the interpretation is done for the VM in a all.
>> It is not the right place to do it here since open is device dependent.
>
> As I stated above, at this time we probably do not need this, however;
> that will not always be the case. The setting is and always will be 
> for the
> VM in all - unless the architecture changes - because it is controlled 
> by a
> single bit (ECA.28). If you recall, I originally set interpretation in 
> the
> vfio_ap device driver when notified of the VFIO_GROUP_NOTIFY_SET_KVM 
> event.
> I believe ultimately that it is the device driver that should set the 
> value
> for apie.
>
>
>
>>
>>
>> Or we only have one device in the VM at a time.
>> In this case, shouldn't we make it official by returning -EEXIST for 
>> the second call?
>
> We do allow only one vfio-ap device at a time. QEMU will allow only 
> one vfio-ap device
> to be configured for a guest. Should we also put a check in here?

QEMU is not the only possible user of this interface.

>
>>
>>
>>
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = kvm_ap_configure_matrix(matrix_mdev->kvm,
>>> +                      matrix_mdev->matrix);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static void vfio_ap_mdev_release(struct mdev_device *mdev)
>>> +{
>>> +    struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>>> +
>>> +    kvm_ap_deconfigure_matrix(matrix_mdev->kvm);
>>> +    kvm_ap_interpret_instructions(matrix_mdev->kvm, false);
>>
>> This call clears the apie in KVM.
>> This is only OK if we have a single device present until the end of 
>> the VM,
>> otherwise AP instructions in the guest will fail after the release 
>> until the end of the VM
>> or until a new device is plugged.
>
> See Message ID: 
> <1523819244-29954-5-git-send-email-akrowiak@linux.vnet.ibm.com> on the
> qemu mailing list. There will be only one vfio-ap device allowed for 
> the MVP model.

dito.
Anyone can write a userland application using this interface.

>
>>
>>
>>
>>> + vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>>> +                 &matrix_mdev->group_notifier);
>>> +}
>>> +
>>>   static ssize_t name_show(struct kobject *kobj, struct device *dev, 
>>> char *buf)
>>>   {
>>>       return sprintf(buf, "%s\n", VFIO_AP_MDEV_NAME_HWVIRT);
>>> @@ -754,6 +802,8 @@ static ssize_t matrix_show(struct device *dev, 
>>> struct device_attribute *attr,
>>>       .mdev_attr_groups    = vfio_ap_mdev_attr_groups,
>>>       .create            = vfio_ap_mdev_create,
>>>       .remove            = vfio_ap_mdev_remove,
>>> +    .open            = vfio_ap_mdev_open,
>>> +    .release        = vfio_ap_mdev_release,
>>>   };
>>>
>>>   int vfio_ap_mdev_register(struct ap_matrix *ap_matrix)
>>> diff --git a/drivers/s390/crypto/vfio_ap_private.h 
>>> b/drivers/s390/crypto/vfio_ap_private.h
>>> index f248faf..48e2806 100644
>>> --- a/drivers/s390/crypto/vfio_ap_private.h
>>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>>> @@ -31,6 +31,8 @@ struct ap_matrix {
>>>
>>>   struct ap_matrix_mdev {
>>>       struct kvm_ap_matrix *matrix;
>>> +    struct notifier_block group_notifier;
>>> +    struct kvm *kvm;
>>>   };
>>>
>>>   static inline struct ap_matrix *to_ap_matrix(struct device *dev)
>>
>>
>

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
