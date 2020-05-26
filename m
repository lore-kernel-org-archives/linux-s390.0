Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732029AbgEZLxf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 26 May 2020 07:53:35 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39F1C03E97A
        for <linux-s390@vger.kernel.org>; Tue, 26 May 2020 04:53:34 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id a14so20033823ilk.2
        for <linux-s390@vger.kernel.org>; Tue, 26 May 2020 04:53:34 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH 3/8] greybus: Use the new device_to_pm()
 helper to access struct dev_pm_ops
References: <20200525182608.1823735-1-kw@linux.com>
 <20200525182608.1823735-4-kw@linux.com>
From: Alex Elder <elder@linaro.org>
Message-ID: <91707da0-86a8-9e87-efdc-c5a01d259beb@linaro.org>
Date: Tue, 26 May 2020 06:53:32 -0500
MIME-Version: 1.0
In-Reply-To: <20200525182608.1823735-4-kw@linux.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pci@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Pavel Machek <pavel@ucw.cz>, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Julian Wiedmann <jwi@linux.ibm.com>, linux-acpi@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, "James E.J. Bottomley" <jejb@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Johan Hovold <johan@kernel.org>, greybus-dev@lists.linaro.org, John Stultz <john.stultz@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Felipe Balbi <balbi@kernel.org>, Alex Elder <elder@kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Karsten Graul <kgraul@linux.ibm.com>, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

On 5/25/20 1:26 PM, Krzysztof Wilczyński wrote:
> Use the new device_to_pm() helper to access Power Management callbacs
> (struct dev_pm_ops) for a particular device (struct device_driver).
> 
> No functional change intended.

Looks fine to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> ---
>   drivers/greybus/bundle.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/greybus/bundle.c b/drivers/greybus/bundle.c
> index 84660729538b..d38d3a630812 100644
> --- a/drivers/greybus/bundle.c
> +++ b/drivers/greybus/bundle.c
> @@ -108,7 +108,7 @@ static void gb_bundle_enable_all_connections(struct gb_bundle *bundle)
>   static int gb_bundle_suspend(struct device *dev)
>   {
>   	struct gb_bundle *bundle = to_gb_bundle(dev);
> -	const struct dev_pm_ops *pm = dev->driver->pm;
> +	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
>   	int ret;
>   
>   	if (pm && pm->runtime_suspend) {
> @@ -135,7 +135,7 @@ static int gb_bundle_suspend(struct device *dev)
>   static int gb_bundle_resume(struct device *dev)
>   {
>   	struct gb_bundle *bundle = to_gb_bundle(dev);
> -	const struct dev_pm_ops *pm = dev->driver->pm;
> +	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
>   	int ret;
>   
>   	ret = gb_control_bundle_resume(bundle->intf->control, bundle->id);
> 
