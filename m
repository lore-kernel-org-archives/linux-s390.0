Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40832 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgEZIhu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 26 May 2020 04:37:50 -0400
MIME-Version: 1.0
References: <20200525182608.1823735-1-kw@linux.com> <20200525182608.1823735-3-kw@linux.com>
In-Reply-To: <20200525182608.1823735-3-kw@linux.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 May 2020 10:37:36 +0200
Message-ID: <CAJZ5v0jQUmdDYmJsP43Ja3urpVLUxe-yD_Hm_Jd2LtCoPiXsrQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] ACPI: PM: Use the new device_to_pm() helper to access
 struct dev_pm_ops
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Felipe Balbi <balbi@kernel.org>, Julian Wiedmann <jwi@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, John Stultz <john.stultz@linaro.org>, "David S. Miller" <davem@davemloft.net>, greybus-dev@lists.linaro.org, netdev <netdev@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, linux-s390@vger.kernel.org, "open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>, "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" <linux-usb@vger.kernel.org>

On Mon, May 25, 2020 at 8:26 PM Krzysztof Wilczyński <kw@linux.com> wrote:
>
> Use the new device_to_pm() helper to access Power Management callbacs
> (struct dev_pm_ops) for a particular device (struct device_driver).
>
> No functional change intended.
>
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> ---
>  drivers/acpi/device_pm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 5832bc10aca8..b98a32c48fbe 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -1022,9 +1022,10 @@ static bool acpi_dev_needs_resume(struct device *dev, struct acpi_device *adev)
>  int acpi_subsys_prepare(struct device *dev)
>  {
>         struct acpi_device *adev = ACPI_COMPANION(dev);
> +       const struct dev_pm_ops *pm = driver_to_pm(dev->driver);

I don't really see a reason for this change.

What's wrong with the check below?

>
> -       if (dev->driver && dev->driver->pm && dev->driver->pm->prepare) {
> -               int ret = dev->driver->pm->prepare(dev);
> +       if (pm && pm->prepare) {
> +               int ret = pm->prepare(dev);
>
>                 if (ret < 0)
>                         return ret;
> --
> 2.26.2
>
