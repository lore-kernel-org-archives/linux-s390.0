Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730739AbgDQNyZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 17 Apr 2020 09:54:25 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03HDY0Y8062460
        for <linux-s390@vger.kernel.org>; Fri, 17 Apr 2020 09:54:24 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30fdf00n5w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 17 Apr 2020 09:54:24 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <freude@linux.ibm.com>;
        Fri, 17 Apr 2020 14:53:43 +0100
Subject: Re: [PATCH v7 03/15] s390/zcrypt: driver callback to indicate
 resource in use
References: <20200407192015.19887-1-akrowiak@linux.ibm.com>
 <20200407192015.19887-4-akrowiak@linux.ibm.com>
 <20200414145851.562867ae.cohuck@redhat.com>
 <82675d5c-4901-cbd8-9287-79133aa3ee68@linux.ibm.com>
 <20200416113356.28fcef8c.cohuck@redhat.com>
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Fri, 17 Apr 2020 15:54:15 +0200
MIME-Version: 1.0
In-Reply-To: <20200416113356.28fcef8c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <c0e3cca2-8683-7034-3b41-cd04fcdfa2ce@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com, fiuczy@linux.ibm.com

On 16.04.20 11:33, Cornelia Huck wrote:
> On Wed, 15 Apr 2020 08:08:24 +0200
> Harald Freudenberger <freude@linux.ibm.com> wrote:
>
>> On 14.04.20 14:58, Cornelia Huck wrote:
>>> On Tue,  7 Apr 2020 15:20:03 -0400
>>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>>> +	/* The non-default driver's module must be loaded */
>>>> +	if (!try_module_get(drv->owner))
>>>> +		return 0;  
>>> Is that really needed? I would have thought that the driver core's
>>> klist usage would make sure that the callback would not be invoked for
>>> drivers that are not registered anymore. Or am I missing a window?  
>> The try_module_get() and module_put() is a result of review feedback from
>> my side. The ap bus core is static in the kernel whereas the
>> vfio dd is a kernel module. So there may be a race condition between
>> calling the callback function and removal of the vfio dd module.
>> There is similar code in zcrypt_api which does the same for the zcrypt
>> device drivers before using some variables or functions from the modules.
>> Help me, it this is outdated code and there is no need to adjust the
>> module reference counter any more, then I would be happy to remove
>> this code :-)
> I think the driver core already should keep us safe. A built-in bus
> calling a driver in a module is a very common pattern, and I think
> ->owner was introduced exactly for that case.
>
> Unless I'm really missing something obvious?
Hm. I tested a similar code (see zcrypt_api.c where try_module_get() and module_put()
is called surrounding use of functions related to the implementing driver.
The driver module has a reference count of 0 when not used and can get removed
- because refcount is 0 - at any time when there is nothing related to the driver pending.

As soon as the driver is actually used the try_module_get(...driver.owner) increases
the reference counter and makes it impossible to remove the module. After use the
module_put() reduces the reference count.
When I now remove the try_module_get() and module_put() calls and run this modified
code I immediately face a crash when the module is removed during use.

I see code in the kernel which does an initial try_module_get() on the driver to increase
the reference count, for example when the driver registers. However, I see no clear
way to remove such a driver module any more.

I know I had a fight with a tester some years ago where he stated that it is a valid
testcase to remove a device driver module 'during use of the driver'. So I'd like
to have the try_module_get() and module_put() invokations in the ap bus code
until you convince me there are other maybe better ways to make sure the
driver and it's functions are available at the time of the call.

Maybe we can discuss this offline if you wish :-)
