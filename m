Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61940 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726360AbgD1Kq5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 28 Apr 2020 06:46:57 -0400
Subject: Re: [PATCH v7 01/15] s390/vfio-ap: store queue struct in hash table
 for quick access
References: <20200407192015.19887-1-akrowiak@linux.ibm.com>
 <20200407192015.19887-2-akrowiak@linux.ibm.com>
 <20200424055732.7663896d.pasic@linux.ibm.com>
 <d15b4a8e-66eb-e4ce-c8ac-6885519940aa@linux.ibm.com>
 <20200427171739.76291a74.pasic@linux.ibm.com>
From: Harald Freudenberger <freude@linux.ibm.com>
Message-ID: <30c824a4-2b3c-984d-406e-1791f7725914@linux.ibm.com>
Date: Tue, 28 Apr 2020 12:46:47 +0200
MIME-Version: 1.0
In-Reply-To: <20200427171739.76291a74.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com, fiuczy@linux.ibm.com

On 27.04.20 17:17, Halil Pasic wrote:
> On Mon, 27 Apr 2020 15:05:23 +0200
> Harald Freudenberger <freude@linux.ibm.com> wrote:
>
>> On 24.04.20 05:57, Halil Pasic wrote:
>>> On Tue,  7 Apr 2020 15:20:01 -0400
>>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>>  
>>>> Rather than looping over potentially 65535 objects, let's store the
>>>> structures for caching information about queue devices bound to the
>>>> vfio_ap device driver in a hash table keyed by APQN.  
>>> @Harald:
>>> Would it make sense to make the efficient lookup of an apqueue base
>>> on its APQN core AP functionality instead of each driver figuring it out
>>> on it's own?
>>>
>>> If I'm not wrong the zcrypt device/driver(s) must the problem of
>>> looking up a queue based on its APQN as well.
>>>
>>> For instance struct ep11_cprb has a target_id filed
>>> (arch/s390/include/uapi/asm/zcrypt.h).
>>>
>>> Regards,
>>> Halil  
>> Hi Halil
>>
>> no, the zcrypt drivers don't have this problem. They build up their own device object which
>> includes a pointer to the base ap device.
> I'm a bit confused. Doesn't your code loop first trough the ap_card
> objects to find the APID portion of the APQN, and then loop the queue
> list of the matching card to find the right ap_queue object? Or did I
> miss something? Isn't that what _zcrypt_send_ep11_cprb() does? Can you
> point me to the code that avoids the lookup (by apqn) for zcrypt?
No. The code is looping through zcrypt_card and zcrypt_queue objects which
are build up and held by the zcrypt api and the zcrypt driver(s).
It does not deal with ap_card and ap_queue devices.

>
>
> If you look at the new function of vfio_ap_get_queue(unsigned long apqn)
> it basically about finding the queue based on the apqn, with the
> difference that it is vfio specific.
>
> Regards,
> Halil
>
>> However, this is not a big issue, as the ap_bus holds a list of ap_card objects and within each
>> ap_card object there exists a list of ap_queues.
>
>
>
