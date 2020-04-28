Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25636 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726180AbgD1IJR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 28 Apr 2020 04:09:17 -0400
Subject: Re: [PATCH v7 03/15] s390/zcrypt: driver callback to indicate
 resource in use
References: <20200407192015.19887-1-akrowiak@linux.ibm.com>
 <20200407192015.19887-4-akrowiak@linux.ibm.com>
 <75bcbc06-f38f-1aff-138f-5d2a2dd3f7b6@linux.ibm.com>
 <162f7dbc-9dd0-0a42-0d1a-8412a9a848e7@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <3f7f57fb-c137-4854-3cb0-b234196a9f1e@linux.ibm.com>
Date: Tue, 28 Apr 2020 10:09:09 +0200
MIME-Version: 1.0
In-Reply-To: <162f7dbc-9dd0-0a42-0d1a-8412a9a848e7@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com, fiuczy@linux.ibm.com



On 2020-04-28 00:24, Tony Krowiak wrote:
> 
> 
> On 4/27/20 4:20 AM, Pierre Morel wrote:
>>
>>
>> On 2020-04-07 21:20, Tony Krowiak wrote:
>>> Introduces a new driver callback to prevent a root user from unbinding
>>> an AP queue from its device driver if the queue is in use. The intent of
>>> this callback is to provide a driver with the means to prevent a root 
>>> user
>>> from inadvertently taking a queue away from a guest and giving it to the
>>> host while the guest is still using it.

...snip...

>>
>> This functionality is valid for the host as for the guests and is 
>> handled automatically by the firmware with the CRYCB.
>> The AP bus uses QCI to retrieve the host CRYCB and build the hosts AP 
>> queues.
>>
>> If instead to mix VFIO CRYCB matrix handling and queues at the same 
>> level inside the AP bus we separate these different firmware entities 
>> in two different software entities.
>>
>> If we make the AP bus sit above a CRYCB/Matrix bus, and in the way 
>> virtualize the QCI and test AP queue instructions:
>> - we can directly pass a matrix device to the guest though a VFIO 
>> matrix device
>> - the consistence will be automatic
>> - the VFIO device and parent device will be of the same kind which 
>> would make the design much more clearer.
>> - there will be no need for these callback because the consistence of 
>> the matrix will be guaranteed by firmware
> 
> As stated in my response above, the issue here is not consistency. While 
> the design you describe
> may be reasonable, it is a major departure from what is out in the 
> field. In other words, that ship
> has sailed.


The current VFIO-AP driver works as before, without any change, above 
the Matrix device I suggest.

Aside the old scheme which can continue, the Matrix device can be used 
directly to build a VFIO Matrix device, usable by QEMU without any 
modification.

Once the dynamic extensions proposed in this series and the associated 
tools are out on the field, then yes the ship is really far.
For now, the existing user's API do not change, the existing tools do 
not need modifications and we can repair the ship for its long journey.

The inconsistency between device and VFIO device and the resulting 
complexity is not going to ease future enhancement.

Regards,
Pierre



-- 
Pierre Morel
IBM Lab Boeblingen
