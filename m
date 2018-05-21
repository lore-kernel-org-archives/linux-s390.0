From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 05/13] s390: vfio-ap: register matrix device with VFIO
 mdev framework
Date: Mon, 21 May 2018 11:13:58 -0400
Message-ID: <b45ba36a-0451-56b8-c038-410441bb8bd4@linux.vnet.ibm.com>
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-6-git-send-email-akrowiak@linux.vnet.ibm.com>
 <5471b194-d7ca-c9c6-132e-fa9539fe44f0@linux.ibm.com>
 <4688078d-3e13-5201-582f-52576b25defa@linux.vnet.ibm.com>
 <20180517094454.6afae7ba.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180517094454.6afae7ba.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 05/17/2018 03:44 AM, Cornelia Huck wrote:
> On Mon, 14 May 2018 15:42:18 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> On 05/11/2018 01:18 PM, Halil Pasic wrote:
>>>
>>> On 05/07/2018 05:11 PM, Tony Krowiak wrote:
>>>> Registers the matrix device created by the VFIO AP device
>>>> driver with the VFIO mediated device framework.
>>>> Registering the matrix device will create the sysfs
>>>> structures needed to create mediated matrix devices
>>>> each of which will be used to configure the AP matrix
>>>> for a guest and connect it to the VFIO AP device driver.
>>>> +static int vfio_ap_mdev_create(struct kobject *kobj, struct
>>>> mdev_device *mdev)
>>>> +{
>>>> +    struct ap_matrix *ap_matrix = to_ap_matrix(mdev_parent_dev(mdev));
>>>> +
>>>> +    ap_matrix->available_instances--;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int vfio_ap_mdev_remove(struct mdev_device *mdev)
>>>> +{
>>>> +    struct ap_matrix *ap_matrix = to_ap_matrix(mdev_parent_dev(mdev));
>>>> +
>>>> +    ap_matrix->available_instances++;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>> The above functions seem to be called with the lock of this
>>> auto-generated
>>> mdev parent device held. That's why we don't have to care about
>>> synchronization
>>> ourselves, right?
>> I would assume as much. The comments for the 'struct mdev_parent_ops' in
>> include/linux/mdev.h do not mention anything about synchronization, nor
>> did I
>> see any locking or synchronization in the vfio_ccw implementation after
>> which
>> I modeled my code, so frankly it is something I did not consider.
>>
>>>
>>> A small comment in the code could be helpful for mdev non-experts.
>>> Hell, I would
>>> even consider documenting it for all mdev -- took me some time to
>>> figure out.
>> You may want to bring this up with the VFIO mdev maintainers, but I'd be
>> happy to
>> include a comment in the functions in question if you think it important.
> Important note: There's currently a patch on list that removes the mdev
> parent mutex, and it seems there was never intended to be any
> serialization in that place by the mdev core. (Look for "vfio/mdev:
> Check globally for duplicate devices".)

The patch on the list holds the mdev_list_lock during create and remove
of an mdev device, so it looks like no synchronization is necessary on the
part of the vendor code in the create/remove callbacks; does that sound
about right?

>
