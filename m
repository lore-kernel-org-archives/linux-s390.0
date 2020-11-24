Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22360 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387663AbgKXNCa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Nov 2020 08:02:30 -0500
Date: Tue, 24 Nov 2020 14:02:20 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 1/1] s390/cio: Remove uevent-suppress from css driver
Message-ID: <20201124140220.77c65539.cohuck@redhat.com>
In-Reply-To: <20201124093407.23189-2-vneethv@linux.ibm.com>
References: <20201124093407.23189-1-vneethv@linux.ibm.com>
        <20201124093407.23189-2-vneethv@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Vineeth Vijayan <vneethv@linux.ibm.com>
Cc: oberpar@linux.ibm.com, linux-s390@vger.kernel.org, farman@linux.ibm.com, fiuczy@linux.ibm.com

On Tue, 24 Nov 2020 10:34:07 +0100
Vineeth Vijayan <vneethv@linux.ibm.com> wrote:

> 'commit fa1a8c23eb7d ("s390: cio: Delay uevents for subchannels")'
> introduced the uevent suppression of subchannels. Even though there
> are reasons for wanting to delay the uevent, it also introduces
> problems. i.e On some platforms (qemu), where the udev-rule for the
> subchannel needs to do driver_override to bind the vfio-ccw driver
> instead of io_subchannel driver, but the suppressed uevent is
> generated only when the device is found on the subchannel. By the
> time it generates the uevent, it makes it difficult for the vfio-ccw
> udev-rules to work.
> This patch removes the uevent-suppress logic from the css driver.
> The ADD uevent will be generated when there is a valid subchannel
> and not after binding the valid device. The uevent generates while
> device_add() during css_sch_device_register() function.
> 
> Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
> ---
>  drivers/s390/cio/chsc_sch.c     |  5 -----
>  drivers/s390/cio/css.c          | 19 -------------------
>  drivers/s390/cio/device.c       | 18 ------------------
>  drivers/s390/cio/eadm_sch.c     |  5 -----
>  drivers/s390/cio/vfio_ccw_drv.c |  5 -----
>  5 files changed, 52 deletions(-)

While I really like that diffstat, I hope that this is actually safe
for userspace programs processing uevents. Previously, we generated the
ADD uevent only when all parts were setup and ready to use (including a
child ccw_device, for example). Now, the ADD uevent is created earlier,
before drivers have done their setup. Do existing udev rules still work
as expected?

(...)

> @@ -1055,16 +1047,6 @@ static int io_subchannel_probe(struct subchannel *sch)
>  				      "attributes for subchannel "
>  				      "0.%x.%04x (rc=%d)\n",
>  				      sch->schid.ssid, sch->schid.sch_no, rc);
> -		/*
> -		 * The console subchannel already has an associated ccw_device.
> -		 * Throw the delayed uevent for the subchannel, register
> -		 * the ccw_device and exit.

I would keep the comment that we already have a ccw_device here. I.e.

/*
 * The console subchannel already has an associated ccw_device.
 * Register it and exit.
 */

> -		 */
> -		if (dev_get_uevent_suppress(&sch->dev)) {
> -			/* should always be the case for the console */
> -			dev_set_uevent_suppress(&sch->dev, 0);
> -			kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
> -		}
>  		cdev = sch_get_cdev(sch);
>  		rc = ccw_device_add(cdev);
>  		if (rc) {

(...)
