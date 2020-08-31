Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728748AbgHaSeX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 31 Aug 2020 14:34:23 -0400
Subject: Re: [PATCH v10 16/16] s390/vfio-ap: update docs to include dynamic
 config support
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
 <20200821195616.13554-17-akrowiak@linux.ibm.com>
 <20200825124529.7b51d825.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <cb4d43b9-bfe1-b2a0-179c-a6362a5f1380@linux.ibm.com>
Date: Mon, 31 Aug 2020 14:34:16 -0400
MIME-Version: 1.0
In-Reply-To: <20200825124529.7b51d825.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com



On 8/25/20 6:45 AM, Cornelia Huck wrote:
> On Fri, 21 Aug 2020 15:56:16 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> Update the documentation in vfio-ap.rst to include information about the
>> AP dynamic configuration support (i.e., hot plug of adapters, domains
>> and control domains via the matrix mediated device's sysfs assignment
>> attributes).
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   Documentation/s390/vfio-ap.rst | 362 ++++++++++++++++++++++++++-------
>>   1 file changed, 285 insertions(+), 77 deletions(-)
>>
>> diff --git a/Documentation/s390/vfio-ap.rst b/Documentation/s390/vfio-ap.rst
>> index e15436599086..8907aeca8fb7 100644
>> --- a/Documentation/s390/vfio-ap.rst
>> +++ b/Documentation/s390/vfio-ap.rst
>> @@ -253,7 +253,7 @@ The process for reserving an AP queue for use by a KVM guest is:
>>   1. The administrator loads the vfio_ap device driver
>>   2. The vfio-ap driver during its initialization will register a single 'matrix'
>>      device with the device core. This will serve as the parent device for
>> -   all mediated matrix devices used to configure an AP matrix for a guest.
>> +   all matrix mediated devices used to configure an AP matrix for a guest.
> This (and many other changes here) seems to be unrelated to the new
> feature. Split that out into a separate patch that can be applied right
> away? That would make this patch smaller and easier to review; it's
> hard to figure out which parts deal with the new feature, and which parts
> simply got an update.
>
> Also, do you want to do similar wording changes in the QEMU
> documentation for vfio-ap?

Will do.

>
>>   3. The /sys/devices/vfio_ap/matrix device is created by the device core
>>   4. The vfio_ap device driver will register with the AP bus for AP queue devices
>>      of type 10 and higher (CEX4 and newer). The driver will provide the vfio_ap
> (...)
>
>> @@ -435,6 +481,10 @@ available to a KVM guest via the following CPU model features:
>>      can be made available to the guest only if it is available on the host (i.e.,
>>      facility bit 12 is set).
>>   
>> +4. apqi: Indicates AP queue interrupts are available on the guest. This facility
>> +   can be made available to the guest only if it is available on the host (i.e.,
>> +   facility bit 65 is set).
>> +
>>   Note: If the user chooses to specify a CPU model different than the 'host'
>>   model to QEMU, the CPU model features and facilities need to be turned on
>>   explicitly; for example::
>> @@ -444,7 +494,7 @@ explicitly; for example::
>>   A guest can be precluded from using AP features/facilities by turning them off
>>   explicitly; for example::
>>   
>> -     /usr/bin/qemu-system-s390x ... -cpu host,ap=off,apqci=off,apft=off
>> +     /usr/bin/qemu-system-s390x ... -cpu host,ap=off,apqci=off,apft=off,apqi=off
> Isn't that an already existing facility that was simply lacking
> documentation? If yes, split it off?

Yes and will do.

>
>>   
>>   Note: If the APFT facility is turned off (apft=off) for the guest, the guest
>>   will not see any AP devices. The zcrypt device drivers that register for type 10
> (...)
>
