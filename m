Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbgEZLxZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 26 May 2020 07:53:25 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51095C03E979
        for <linux-s390@vger.kernel.org>; Tue, 26 May 2020 04:53:25 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id s18so7646338ioe.2
        for <linux-s390@vger.kernel.org>; Tue, 26 May 2020 04:53:25 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH 1/8] driver core: Add helper for accessing
 Power Management callbacs
References: <20200525182608.1823735-1-kw@linux.com>
 <20200525182608.1823735-2-kw@linux.com> <20200526063334.GB2578492@kroah.com>
From: Alex Elder <elder@linaro.org>
Message-ID: <41c42552-0f4f-df6a-d587-5c62333aa6a8@linaro.org>
Date: Tue, 26 May 2020 06:53:22 -0500
MIME-Version: 1.0
In-Reply-To: <20200526063334.GB2578492@kroah.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pci@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Pavel Machek <pavel@ucw.cz>, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Julian Wiedmann <jwi@linux.ibm.com>, linux-acpi@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, "James E.J. Bottomley" <jejb@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Johan Hovold <johan@kernel.org>, greybus-dev@lists.linaro.org, John Stultz <john.stultz@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Felipe Balbi <balbi@kernel.org>, Alex Elder <elder@kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Karsten Graul <kgraul@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>

On 5/26/20 1:33 AM, Greg Kroah-Hartman wrote:
> On Mon, May 25, 2020 at 06:26:01PM +0000, Krzysztof Wilczyński wrote:
>> Add driver_to_pm() helper allowing for accessing the Power Management
>> callbacs for a particular device.  Access to the callbacs (struct
>> dev_pm_ops) is normally done through using the pm pointer that is
>> embedded within the device_driver struct.
>>
>> Helper allows for the code required to reference the pm pointer and
>> access Power Management callbas to be simplified.  Changing the
>> following:
>>
>>    struct device_driver *drv = dev->driver;
>>    if (dev->driver && dev->driver->pm && dev->driver->pm->prepare) {
>>        int ret = dev->driver->pm->prepare(dev);
>>
>> To:
>>
>>    const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
>>    if (pm && pm->prepare) {
>>        int ret = pm->prepare(dev);
>>
>> Or, changing the following:
>>
>>       const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>>
>> To:
>>       const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
>>
>> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
>> ---
>>   include/linux/device/driver.h | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
>> index ee7ba5b5417e..ccd0b315fd93 100644
>> --- a/include/linux/device/driver.h
>> +++ b/include/linux/device/driver.h
>> @@ -236,6 +236,21 @@ driver_find_device_by_acpi_dev(struct device_driver *drv, const void *adev)
>>   }
>>   #endif
>>   
>> +/**
>> + * driver_to_pm - Return Power Management callbacs (struct dev_pm_ops) for
>> + *                a particular device.
>> + * @drv: Pointer to a device (struct device_driver) for which you want to access
>> + *       the Power Management callbacks.
>> + *
>> + * Returns a pointer to the struct dev_pm_ops embedded within the device (struct
>> + * device_driver), or returns NULL if Power Management is not present and the
>> + * pointer is not valid.
>> + */
>> +static inline const struct dev_pm_ops *driver_to_pm(struct device_driver *drv)
>> +{
>> +	return drv && drv->pm ? drv->pm : NULL;

This could just be:

	if (drv)
		return drv->pm;

	return NULL;

Or if you want to evoke passion in Greg:

	return drv ? drv->pm : NULL;

					-Alex

> I hate ? : lines with a passion, as they break normal pattern mattching
> in my brain.  Please just spell this all out:
> 	if (drv && drv->pm)
> 		return drv->pm;
> 	return NULL;
> 
> Much easier to read, and the compiler will do the exact same thing.
> 
> Only place ? : are ok to use in my opinion, are as function arguments.
> 
> thanks,
> 
> greg k-h
> _______________________________________________
> greybus-dev mailing list
> greybus-dev@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/greybus-dev
> 
