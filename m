From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v6 10/21] s390: vfio-ap: sysfs interfaces to configure
 adapters
Date: Fri, 13 Jul 2018 14:20:26 +0200
Message-ID: <a58aee39-4ce4-7cf9-85f8-bc1eb440404c@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-11-git-send-email-akrowiak@linux.vnet.ibm.com>
 <3ec78f60-e1b3-79fc-5592-c53520703bc7@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3ec78f60-e1b3-79fc-5592-c53520703bc7@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pmorel@linux.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 07/09/2018 02:11 PM, Pierre Morel wrote:
> On 29/06/2018 23:11, Tony Krowiak wrote:
>> Provides the sysfs interfaces for assigning AP adapters to
>> and unassigning AP adapters from a mediated matrix device.
>>
>> The IDs of the AP adapters assigned to the mediated matrix
>> device are stored in an AP mask (APM). The bits in the APM,
>> from most significant to least significant bit, correspond to
>> AP adapter ID (APID) 0 to 255. When an adapter is assigned, the
>> bit corresponding the APID will be set in the APM.
>> Likewise, when an adapter is unassigned, the bit corresponding
>> to the APID will be cleared from the APM.
>>
>> The relevant sysfs structures are:
>>
>> /sys/devices/vfio_ap
>> ... [matrix]
>> ...... [mdev_supported_types]
>> ......... [vfio_ap-passthrough]
>> ............ [devices]
>> ...............[$uuid]
>> .................. assign_adapter
>> .................. unassign_adapter
>>
>> To assign an adapter to the $uuid mediated matrix device's APM,
>> write the APID to the assign_adapter file. To unassign an adapter,
>> write the APID to the unassign_adapter file. The APID is specified
>> using conventional semantics: If it begins with 0x the number will
>> be parsed as a hexadecimal number; if it begins with a 0 the number
>> will be parsed as an octal number; otherwise, it will be parsed as a
>> decimal number.
>>
>> For example, to assign adapter 173 (0xad) to the mediated matrix
>> device $uuid:
>>
>>     echo 173 > assign_adapter
>>
>>     or
>>
>>     echo 0xad > assign_adapter
>>
>>     or
>>
>>     echo 0255 > assign_adapter
>>
>> To unassign adapter 173 (0xad):
>>
>>     echo 173 > unassign_adapter
>>
>>     or
>>
>>     echo 0xad > unassign_adapter
>>
>>     or
>>
>>     echo 0255 > unassign_adapter
>>
>> The assignment will be rejected:
>>
>> * If the APID exceeds the maximum value for an AP adapter:
>>    * If the AP Extended Addressing (APXA) facility is
>>      installed, the max value is 255
>>    * Else the max value is 64
>>
>> * If no AP domains have yet been assigned and there are
>>    no AP queues bound to the VFIO AP driver that have an APQN
>>    with an APID matching that of the AP adapter being assigned.
>>
>> * If any of the APQNs that can be derived from the cross product
>>    of the APID being assigned and the AP queue index (APQI) of
>>    each of the AP domains previously assigned can not be matched
>>    with an APQN of an AP queue device reserved by the VFIO AP
>>    driver.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>

snip [...]

>> +/**
>> + * assign_adapter_store
>> + *
>> + * @dev: the matrix device
>> + * @attr: a mediated matrix device attribute
>> + * @buf: a buffer containing the adapter ID (APID) to be assigned
>> + * @count: the number of bytes in @buf
>> + *
>> + * Parses the APID from @buf and assigns it to the mediated matrix 
>> device. The
>> + * APID must be a valid value:
>> + *    * The APID value must not exceed the maximum allowable AP 
>> adapter ID
>> + *
>> + *    * If there are no AP domains assigned, then there must be at 
>> least
>> + *      one AP queue device reserved by the VFIO AP device driver 
>> with an
>> + *      APQN containing @apid.
>
> I do not understand the reason here.
> Can you develop?

We forbid assignment of an adapter:

* If any APQNs that can be derived from the cross product of the input
   adapter number and the domain numbers already assigned are not bound
   to the VFIO AP driver.

* Or, if the APID of at least one APQN bound to the VFIO AP device driver
   does not match the input adapter number.

>
>
> I suppose that by reserved you mean bound. (then use bound)
> But I still can not understand the reason why.

Yes, I mean bound. The reason why is because we don't want to allow
a guest to use an AP queue that is not bound to the VFIO AP driver
because it will then be shared with the zcrypt driver and that
would be a breach of security. That may, however, not be what you
are really asking. Are you suggesting that we should allow assignment
of any APQN since this same check is done in the mdev open callback?

>
>
> Beside if I understand correctly what you do it forbid the automatic
> assignment of a new card plugged into the host.

Not necessarily; the same logic I described in my first answer above will
be applied if a new card is assigned.

>
>
>> + *
>> + *    * Else each APQN that can be derived from the intersection of 
>> @apid and
>> + *      the IDs of the AP domains already assigned must identify an 
>> AP queue
>> + *      that has been reserved by the VFIO AP device driver.
>> + *
>> + * Returns the number of bytes processed if the APID is valid; 
>> otherwise returns
>> + * an error.
>> + */
>> +static ssize_t assign_adapter_store(struct device *dev,
>> +                    struct device_attribute *attr,
>> +                    const char *buf, size_t count)
>> +{
>> +    int ret;
>> +    unsigned long apid;
>> +    struct mdev_device *mdev = mdev_from_dev(dev);
>> +    struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>> +    unsigned long max_apid = matrix_mdev->matrix.apm_max;
>> +
>> +    ret = kstrtoul(buf, 0, &apid);
>> +    if (ret || (apid > max_apid)) {
>> +        pr_err("%s: %s: adapter id '%s' not a value from 0 to 
>> %02lu(%#04lx)",
>> +               VFIO_AP_MODULE_NAME, __func__, buf, max_apid, max_apid);
>> +
>> +        return ret ? ret : -EINVAL;
>> +    }
>> +
>> +    ret = vfio_ap_validate_apid(mdev, matrix_mdev, apid);
>> +    if (ret)
>> +        return ret;
>> +
>> +    /* Set the bit in the AP mask (APM) corresponding to the AP adapter
>> +     * number (APID). The bits in the mask, from most significant to 
>> least
>> +     * significant bit, correspond to APIDs 0-255.
>> +     */
>> +    set_bit_inv(apid, matrix_mdev->matrix.apm);
>> +
>> +    return count;
>> +}
>> +static DEVICE_ATTR_WO(assign_adapter);
>> +
>> +/**
>> + * unassign_adapter_store
>> + *
>> + * @dev: the matrix device
>> + * @attr: a mediated matrix device attribute
>> + * @buf: a buffer containing the adapter ID (APID) to be assigned
>> + * @count: the number of bytes in @buf
>> + *
>> + * Parses the APID from @buf and unassigns it from the mediated 
>> matrix device.
>> + * The APID must be a valid value
>> + *
>> + * Returns the number of bytes processed if the APID is valid; 
>> otherwise returns
>> + * an error.
>> + */
>> +static ssize_t unassign_adapter_store(struct device *dev,
>> +                      struct device_attribute *attr,
>> +                      const char *buf, size_t count)
>> +{
>> +    int ret;
>> +    unsigned long apid;
>> +    struct mdev_device *mdev = mdev_from_dev(dev);
>> +    struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>> +    unsigned long max_apid = matrix_mdev->matrix.apm_max;
>> +
>> +    ret = kstrtoul(buf, 0, &apid);
>> +    if (ret || (apid > max_apid)) {
>> +        pr_err("%s: %s: adapter id '%s' must be a value from 0 to 
>> %02lu(%#04lx)",
>> +               VFIO_AP_MODULE_NAME, __func__, buf, max_apid, max_apid);
>> +
>> +        return ret ? ret : -EINVAL;
>> +    }
>> +
>> +    if (!test_bit_inv(apid, matrix_mdev->matrix.apm)) {
>> +        pr_err("%s: %s: adapter id %02lu(%#04lx) not assigned",
>> +               VFIO_AP_MODULE_NAME, __func__, apid, apid);
>> +
>> +        return -ENODEV;
>> +    }
>> +
>> +    clear_bit_inv((unsigned long)apid, matrix_mdev->matrix.apm);
>> +
>> +    return count;
>> +}
>> +DEVICE_ATTR_WO(unassign_adapter);
>> +
>> +static struct attribute *vfio_ap_mdev_attrs[] = {
>> +    &dev_attr_assign_adapter.attr,
>> +    &dev_attr_unassign_adapter.attr,
>> +    NULL
>> +};
>> +
>> +static struct attribute_group vfio_ap_mdev_attr_group = {
>> +    .attrs = vfio_ap_mdev_attrs
>> +};
>> +
>> +static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
>> +    &vfio_ap_mdev_attr_group,
>> +    NULL
>> +};
>> +
>>   static const struct mdev_parent_ops vfio_ap_matrix_ops = {
>>       .owner            = THIS_MODULE,
>>       .supported_type_groups    = vfio_ap_mdev_type_groups,
>> +    .mdev_attr_groups    = vfio_ap_mdev_attr_groups,
>>       .create            = vfio_ap_mdev_create,
>>       .remove            = vfio_ap_mdev_remove,
>>   };
>
>
