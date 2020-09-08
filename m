Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728350AbgIHSyu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Sep 2020 14:54:50 -0400
Subject: Re: [PATCH v10 02/16] s390/vfio-ap: use new AP bus interface to
 search for queue devices
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
 <20200821195616.13554-3-akrowiak@linux.ibm.com>
 <37cd9b7e-a619-6603-7e47-f5e85814d673@de.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <34c10327-8640-24e8-b882-96962cae5050@linux.ibm.com>
Date: Tue, 8 Sep 2020 14:54:42 -0400
MIME-Version: 1.0
In-Reply-To: <37cd9b7e-a619-6603-7e47-f5e85814d673@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, kernel test robot <lkp@intel.com>



On 9/4/20 4:11 AM, Christian Borntraeger wrote:
>
> On 21.08.20 21:56, Tony Krowiak wrote:
>> This patch refactor's the vfio_ap device driver to use the AP bus's
>> ap_get_qdev() function to retrieve the vfio_ap_queue struct containing
>> information about a queue that is bound to the vfio_ap device driver.
>> The bus's ap_get_qdev() function retrieves the queue device from a
>> hashtable keyed by APQN. This is much more efficient than looping over
>> the list of devices attached to the AP bus by several orders of
>> magnitude.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reported-by: kernel test robot <lkp@intel.com>
> I think this can go. No need to mark that an earlier version of this patch had an issue.

I was just following the instructions in the robot comments. I'll get 
rid of it.

>
>
> [...]
>
>> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
>> index f46dde56b464..a2aa05bec718 100644
>> --- a/drivers/s390/crypto/vfio_ap_private.h
>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>> @@ -18,6 +18,7 @@
>>   #include <linux/delay.h>
>>   #include <linux/mutex.h>
>>   #include <linux/kvm_host.h>
>> +#include <linux/hashtable.h>
> I dont think that this header file needs it. Any user of it will now include this.
> Can you move this include into the respective C file when the hash stuff is
> used?

I can.

>
>
> Other than that this looks good.
