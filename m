Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4790 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729048AbgKWTXV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Nov 2020 14:23:21 -0500
Subject: Re: [PATCH v11 05/14] s390/vfio-ap: implement in-use callback for
 vfio_ap driver
References: <20201022171209.19494-1-akrowiak@linux.ibm.com>
 <20201022171209.19494-6-akrowiak@linux.ibm.com>
 <20201027142711.1b57825e.pasic@linux.ibm.com>
 <6a5feb16-46b5-9dca-7e85-7d344b0ffa24@linux.ibm.com>
 <20201114004722.76c999e0.pasic@linux.ibm.com>
 <20201123180316.79273751.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <62a22a99-3485-353c-b4e5-e04fcec57778@linux.ibm.com>
Date: Mon, 23 Nov 2020 14:23:06 -0500
MIME-Version: 1.0
In-Reply-To: <20201123180316.79273751.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com



On 11/23/20 12:03 PM, Cornelia Huck wrote:
> On Sat, 14 Nov 2020 00:47:22 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
>
>> On Fri, 13 Nov 2020 12:14:22 -0500
>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>> [..]
>>>>>    }
>>>>>    
>>>>> +#define MDEV_SHARING_ERR "Userspace may not re-assign queue %02lx.%04lx " \
>>>>> +			 "already assigned to %s"
>>>>> +
>>>>> +static void vfio_ap_mdev_log_sharing_err(const char *mdev_name,
>>>>> +					 unsigned long *apm,
>>>>> +					 unsigned long *aqm)
>>>>> +{
>>>>> +	unsigned long apid, apqi;
>>>>> +
>>>>> +	for_each_set_bit_inv(apid, apm, AP_DEVICES)
>>>>> +		for_each_set_bit_inv(apqi, aqm, AP_DOMAINS)
>>>>> +			pr_err(MDEV_SHARING_ERR, apid, apqi, mdev_name);
>>>> Isn't error rather severe for this? For my taste even warning would be
>>>> severe for this.
>>> The user only sees a EADDRINUSE returned from the sysfs interface,
>>> so Conny asked if I could log a message to indicate which APQNs are
>>> in use by which mdev. I can change this to an info message, but it
>>> will be missed if the log level is set higher. Maybe Conny can put in
>>> her two cents here since she asked for this.
>>>    
>> I'm looking forward to Conny's opinion. :)
> (only just saw this; -ETOOMANYEMAILS)
>
> It is probably not an error in the sense of "things are broken, this
> cannot work"; but I'd consider this at least a warning "this does not
> work as you intended".

Okay then, I'll make it a warning.

>
