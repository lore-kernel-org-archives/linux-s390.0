From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v6 13/21] s390: vfio-ap: sysfs interface to view matrix
 mdev matrix
Date: Fri, 13 Jul 2018 14:24:47 +0200
Message-ID: <2ebe297c-79e7-1cfd-05a9-1ab8943a0203@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-14-git-send-email-akrowiak@linux.vnet.ibm.com>
 <ef3d480b-29b3-d184-4fb2-14f88961d97d@linux.ibm.com>
 <d105f5a6-b555-bc8d-6a1f-cc3cf57b9f35@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d105f5a6-b555-bc8d-6a1f-cc3cf57b9f35@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pmorel@linux.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 07/09/2018 04:38 PM, Pierre Morel wrote:
> On 09/07/2018 14:20, Pierre Morel wrote:
>> On 29/06/2018 23:11, Tony Krowiak wrote:
>>> Provides a sysfs interface to view the AP matrix configured for the
>>> mediated matrix device.
>>>
>>> The relevant sysfs structures are:
>>>
>>> /sys/devices/vfio_ap
>>> ... [matrix]
>>> ...... [mdev_supported_types]
>>> ......... [vfio_ap-passthrough]
>>> ............ [devices]
>>> ...............[$uuid]
>>> .................. matrix
>>>
>>> To view the matrix configured for the mediated matrix device,
>>> print the matrix file:
>>>
>>>     cat matrix
>>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>> ---
>>>   drivers/s390/crypto/vfio_ap_ops.c |   31 
>>> +++++++++++++++++++++++++++++++
>>>   1 files changed, 31 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>>> b/drivers/s390/crypto/vfio_ap_ops.c
>>> index c8f31f3..bc7398d 100644
>>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>>> @@ -697,6 +697,36 @@ static ssize_t control_domains_show(struct 
>>> device *dev,
>>>   }
>>>   DEVICE_ATTR_RO(control_domains);
>>>
>>> +static ssize_t matrix_show(struct device *dev, struct 
>>> device_attribute *attr,
>>> +               char *buf)
>>> +{
>>> +    struct mdev_device *mdev = mdev_from_dev(dev);
>>> +    struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>>> +    char *bufpos = buf;
>>> +    unsigned long apid;
>>> +    unsigned long apqi;
>>> +    unsigned long napm = matrix_mdev->matrix.apm_max + 1;
>>> +    unsigned long naqm = matrix_mdev->matrix.aqm_max + 1;
>>> +    int nchars = 0;
>>> +    int n;
>>> +
>>> +    for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, napm) {
>>> +        n = sprintf(bufpos, "%02lx\n", apid);
>>> +        bufpos += n;
>>> +        nchars += n;
>>> +
>>> +        for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, naqm) {
>>> +            n = sprintf(bufpos, "%02lx.%04lx\n", apid, apqi);
>>> +            bufpos += n;
>>> +            nchars += n;
>>> +        }
>>> +    }
>>> +
>>> +    return nchars;
>>> +}
>>> +DEVICE_ATTR_RO(matrix);
>>> +
>>> +
>>>   static struct attribute *vfio_ap_mdev_attrs[] = {
>>>       &dev_attr_assign_adapter.attr,
>>>       &dev_attr_unassign_adapter.attr,
>>> @@ -705,6 +735,7 @@ static ssize_t control_domains_show(struct 
>>> device *dev,
>>>       &dev_attr_assign_control_domain.attr,
>>>       &dev_attr_unassign_control_domain.attr,
>>>       &dev_attr_control_domains.attr,
>>> +    &dev_attr_matrix.attr,
>>>       NULL,
>>>   };
>>>
>>
>> I have still the same remark: what you show here is not what is 
>> currently
>> used by the SIE.
>> It is not irrelevant but what the guest really use may be more 
>> interesting
>> for the admin.
>>
>>
> OK, you implement the right view it in patch 16/21.
>
> Still, what is the purpose of showing this view?

I find it to have great value when configuring the mdev. It provides a 
view of
what has been configured thus far.

>
>
>
