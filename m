Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbgEZGdi (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 26 May 2020 02:33:38 -0400
Date: Tue, 26 May 2020 08:33:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/8] driver core: Add helper for accessing Power
 Management callbacs
Message-ID: <20200526063334.GB2578492@kroah.com>
References: <20200525182608.1823735-1-kw@linux.com>
 <20200525182608.1823735-2-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200525182608.1823735-2-kw@linux.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Felipe Balbi <balbi@kernel.org>, Julian Wiedmann <jwi@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, John Stultz <john.stultz@linaro.org>, "David S. Miller" <davem@davemloft.net>, greybus-dev@lists.linaro.org, netdev@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org

On Mon, May 25, 2020 at 06:26:01PM +0000, Krzysztof Wilczyński wrote:
> Add driver_to_pm() helper allowing for accessing the Power Management
> callbacs for a particular device.  Access to the callbacs (struct
> dev_pm_ops) is normally done through using the pm pointer that is
> embedded within the device_driver struct.
> 
> Helper allows for the code required to reference the pm pointer and
> access Power Management callbas to be simplified.  Changing the
> following:
> 
>   struct device_driver *drv = dev->driver;
>   if (dev->driver && dev->driver->pm && dev->driver->pm->prepare) {
>       int ret = dev->driver->pm->prepare(dev);
> 
> To:
> 
>   const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
>   if (pm && pm->prepare) {
>       int ret = pm->prepare(dev);
> 
> Or, changing the following:
> 
>      const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> 
> To:
>      const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> ---
>  include/linux/device/driver.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
> index ee7ba5b5417e..ccd0b315fd93 100644
> --- a/include/linux/device/driver.h
> +++ b/include/linux/device/driver.h
> @@ -236,6 +236,21 @@ driver_find_device_by_acpi_dev(struct device_driver *drv, const void *adev)
>  }
>  #endif
>  
> +/**
> + * driver_to_pm - Return Power Management callbacs (struct dev_pm_ops) for
> + *                a particular device.
> + * @drv: Pointer to a device (struct device_driver) for which you want to access
> + *       the Power Management callbacks.
> + *
> + * Returns a pointer to the struct dev_pm_ops embedded within the device (struct
> + * device_driver), or returns NULL if Power Management is not present and the
> + * pointer is not valid.
> + */
> +static inline const struct dev_pm_ops *driver_to_pm(struct device_driver *drv)
> +{
> +	return drv && drv->pm ? drv->pm : NULL;

I hate ? : lines with a passion, as they break normal pattern mattching
in my brain.  Please just spell this all out:
	if (drv && drv->pm)
		return drv->pm;
	return NULL;

Much easier to read, and the compiler will do the exact same thing.

Only place ? : are ok to use in my opinion, are as function arguments.

thanks,

greg k-h
