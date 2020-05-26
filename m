Return-Path: <netdev-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20200525182608.1823735-1-kw@linux.com> <20200525182608.1823735-6-kw@linux.com>
In-Reply-To: <20200525182608.1823735-6-kw@linux.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 May 2020 10:38:56 +0200
Message-ID: <CAJZ5v0i-RnP7RycZ3GqOZuEYqrX_+r5-VS7DqtNCyHDwp1sPKg@mail.gmail.com>
Subject: Re: [PATCH 5/8] usb: phy: fsl: Use the new device_to_pm() helper to
 access struct dev_pm_ops
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: netdev-owner@vger.kernel.org
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
>  drivers/usb/phy/phy-fsl-usb.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/usb/phy/phy-fsl-usb.c b/drivers/usb/phy/phy-fsl-usb.c
> index b451f4695f3f..3b9ad5db8380 100644
> --- a/drivers/usb/phy/phy-fsl-usb.c
> +++ b/drivers/usb/phy/phy-fsl-usb.c
> @@ -460,6 +460,7 @@ int fsl_otg_start_host(struct otg_fsm *fsm, int on)
>         struct device *dev;
>         struct fsl_otg *otg_dev =
>                 container_of(otg->usb_phy, struct fsl_otg, phy);
> +       const struct dev_pm_ops *pm;
>         u32 retval = 0;
>
>         if (!otg->host)
> @@ -479,8 +480,9 @@ int fsl_otg_start_host(struct otg_fsm *fsm, int on)
>                 else {
>                         otg_reset_controller();
>                         VDBG("host on......\n");
> -                       if (dev->driver->pm && dev->driver->pm->resume) {
> -                               retval = dev->driver->pm->resume(dev);
> +                       pm = driver_to_pm(dev->driver);
> +                       if (pm && pm->resume) {
> +                               retval = pm->resume(dev);

And why is the new version better this time?

>                                 if (fsm->id) {
>                                         /* default-b */
>                                         fsl_otg_drv_vbus(fsm, 1);
> @@ -504,8 +506,9 @@ int fsl_otg_start_host(struct otg_fsm *fsm, int on)
>                 else {
>                         VDBG("host off......\n");
>                         if (dev && dev->driver) {
> -                               if (dev->driver->pm && dev->driver->pm->suspend)
> -                                       retval = dev->driver->pm->suspend(dev);
> +                               pm = driver_to_pm(dev->driver);
> +                               if (pm && pm->suspend)
> +                                       retval = pm->suspend(dev);
>                                 if (fsm->id)
>                                         /* default-b */
>                                         fsl_otg_drv_vbus(fsm, 0);
> --
> 2.26.2
>
