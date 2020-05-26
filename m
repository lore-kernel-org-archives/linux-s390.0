Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33144 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgEZQGh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 26 May 2020 12:06:37 -0400
MIME-Version: 1.0
References: <20200525182608.1823735-1-kw@linux.com> <20200525182608.1823735-9-kw@linux.com>
 <20200526063521.GC2578492@kroah.com> <20200526150744.GC75990@rocinante>
 <CAJZ5v0grVQhmk=q9_=CbBa8y_8XbTOeqv-Hb6Hivi6ffKsVHmQ@mail.gmail.com> <20200526152844.GA5809@rowland.harvard.edu>
In-Reply-To: <20200526152844.GA5809@rowland.harvard.edu>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 May 2020 18:06:24 +0200
Message-ID: <CAJZ5v0gTWaE_ehFg+JDpPEANiD-jr5P5D4LL2XpSiVzHZoZ-_g@mail.gmail.com>
Subject: Re: [PATCH 8/8] net/iucv: Use the new device_to_pm() helper to access
 struct dev_pm_ops
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@oracle.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Felipe Balbi <balbi@kernel.org>, Julian Wiedmann <jwi@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, John Stultz <john.stultz@linaro.org>, "David S. Miller" <davem@davemloft.net>, greybus-dev@lists.linaro.org, netdev <netdev@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, linux-s390@vger.kernel.org, "open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>, "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" <linux-usb@vger.kernel.org>

On Tue, May 26, 2020 at 5:28 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Tue, May 26, 2020 at 05:19:07PM +0200, Rafael J. Wysocki wrote:
> > On Tue, May 26, 2020 at 5:07 PM Krzysztof Wilczyński <kw@linux.com> wrote:
> > >
> > > Hello Greg,
> > >
> > > [...]
> > > > It's "interesting" how using your new helper doesn't actually make the
> > > > code smaller.  Perhaps it isn't a good helper function?
> > >
> > > The idea for the helper was inspired by the comment Dan made to Bjorn
> > > about Bjorn's change, as per:
> > >
> > >   https://lore.kernel.org/driverdev-devel/20191016135002.GA24678@kadam/
> > >
> > > It looked like a good idea to try to reduce the following:
> > >
> > >   dev->driver && dev->driver->pm && dev->driver->pm->prepare
> > >
> > > Into something more succinct.  Albeit, given the feedback from yourself
> > > and Rafael, I gather that this helper is not really a good addition.
> >
> > IMO it could be used for reducing code duplication like you did in the
> > PCI code, but not necessarily in the other places where the code in
> > question is not exactly duplicated.
>
> The code could be a little more succinct, although it wouldn't fit every
> usage.  For example,
>
> #define pm_do_callback(dev, method) \
>         (dev->driver && dev->driver->pm && dev->driver->pm->callback ? \
>         dev->driver->pm->callback(dev) : 0)
>
> Then the usage is something like:
>
>         ret = pm_do_callback(dev, prepare);
>
> Would this be an overall improvement?

It wouldn't cover all of the use cases.

For example, PCI does other things in addition to running a callback
when it is present.

Something like this might be enough though:

#define pm_driver_callback_is_present(dev, method) \
        (dev->driver && dev->driver->pm && dev->driver->pm->method)

#define pm_run_driver_callback(dev, method) \
        (pm_driver_callback_is_present(dev, method) ?
dev->driver->pm->method(dev) : 0)

#define pm_get_driver_callback(dev, method) \
        (pm_driver_callback_is_present(dev, method) ?
dev->driver->pm->method : NULL)

so whoever needs the callback pointer can use pm_get_driver_callback()
and whoever only needs to run the callback can use
pm_run_driver_callback().

Cheers!
