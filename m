Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44340 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726039AbgKYJky (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Nov 2020 04:40:54 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AP9Wwq7181432
        for <linux-s390@vger.kernel.org>; Wed, 25 Nov 2020 04:40:53 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 351ddb4cfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 25 Nov 2020 04:40:53 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AP9Xb9e187699
        for <linux-s390@vger.kernel.org>; Wed, 25 Nov 2020 04:40:52 -0500
Subject: Re: [RFC 1/1] s390/cio: Remove uevent-suppress from css driver
References: <20201124093407.23189-1-vneethv@linux.ibm.com>
 <20201124093407.23189-2-vneethv@linux.ibm.com>
 <20201124140220.77c65539.cohuck@redhat.com>
From: Vineeth Vijayan <vneethv@linux.vnet.ibm.com>
Message-ID: <4be7e163-1118-d365-7d25-df39ba78181f@linux.vnet.ibm.com>
Date: Wed, 25 Nov 2020 10:40:46 +0100
MIME-Version: 1.0
In-Reply-To: <20201124140220.77c65539.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Vineeth Vijayan <vneethv@linux.ibm.com>
Cc: oberpar@linux.ibm.com, linux-s390@vger.kernel.org, farman@linux.ibm.com, fiuczy@linux.ibm.com

Thank you for looking in to this.

On 11/24/20 2:02 PM, Cornelia Huck wrote:
> On Tue, 24 Nov 2020 10:34:07 +0100
> Vineeth Vijayan <vneethv@linux.ibm.com> wrote:
>
>> 'commit fa1a8c23eb7d ("s390: cio: Delay uevents for subchannels")'
>> introduced the uevent suppression of subchannels. Even though there
>> are reasons for wanting to delay the uevent, it also introduces
>> problems. i.e On some platforms (qemu), where the udev-rule for the
>> subchannel needs to do driver_override to bind the vfio-ccw driver
>> instead of io_subchannel driver, but the suppressed uevent is
>> generated only when the device is found on the subchannel. By the
>> time it generates the uevent, it makes it difficult for the vfio-ccw
>> udev-rules to work.
>> This patch removes the uevent-suppress logic from the css driver.
>> The ADD uevent will be generated when there is a valid subchannel
>> and not after binding the valid device. The uevent generates while
>> device_add() during css_sch_device_register() function.
>>
>> Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
>> ---
>>   drivers/s390/cio/chsc_sch.c     |  5 -----
>>   drivers/s390/cio/css.c          | 19 -------------------
>>   drivers/s390/cio/device.c       | 18 ------------------
>>   drivers/s390/cio/eadm_sch.c     |  5 -----
>>   drivers/s390/cio/vfio_ccw_drv.c |  5 -----
>>   5 files changed, 52 deletions(-)
> While I really like that diffstat, I hope that this is actually safe 
> for userspace programs processing uevents. Previously, we generated 
> the ADD uevent only when all parts were setup and ready to use 
> (including a child ccw_device, for example). Now, the ADD uevent is 
> created earlier, before drivers have done their setup. Do existing 
> udev rules still work as expected? (...)

I am still working on this. I have done minimal tests as of now. Mostly 
with the available LPARs/zVMs. And it looks ok. But, i know there are 
many fragile setups out there and the change in the "timing" (The 
uevents generated earlier) could be a potential issue on that. I will 
keep you updated on my findings.

About this RFC, i just wanted make sure that we are on same page with 
regards to the RFD that you shared.
>> @@ -1055,16 +1047,6 @@ static int io_subchannel_probe(struct subchannel *sch)
>>   				      "attributes for subchannel "
>>   				      "0.%x.%04x (rc=%d)\n",
>>   				      sch->schid.ssid, sch->schid.sch_no, rc);
>> -		/*
>> -		 * The console subchannel already has an associated ccw_device.
>> -		 * Throw the delayed uevent for the subchannel, register
>> -		 * the ccw_device and exit.
> I would keep the comment that we already have a ccw_device here. I.e.
>
> /*
>   * The console subchannel already has an associated ccw_device.
>   * Register it and exit.
>   */
>
>> -		 */
>> -		if (dev_get_uevent_suppress(&sch->dev)) {
>> -			/* should always be the case for the console */
>> -			dev_set_uevent_suppress(&sch->dev, 0);
>> -			kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
>> -		}
>>   		cdev = sch_get_cdev(sch);
>>   		rc = ccw_device_add(cdev);
>>   		if (rc) {
> (...)
>
