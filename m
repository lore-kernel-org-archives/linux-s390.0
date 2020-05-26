Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-ej1-f65.google.com ([209.85.218.65]:43297 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbgEZPHt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 26 May 2020 11:07:49 -0400
Date: Tue, 26 May 2020 17:07:44 +0200
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH 8/8] net/iucv: Use the new device_to_pm() helper to
 access struct dev_pm_ops
Message-ID: <20200526150744.GC75990@rocinante>
References: <20200525182608.1823735-1-kw@linux.com>
 <20200525182608.1823735-9-kw@linux.com>
 <20200526063521.GC2578492@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200526063521.GC2578492@kroah.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Felipe Balbi <balbi@kernel.org>, Julian Wiedmann <jwi@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, John Stultz <john.stultz@linaro.org>, "David S. Miller" <davem@davemloft.net>, greybus-dev@lists.linaro.org, netdev@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org

Hello Greg,

[...]
> It's "interesting" how using your new helper doesn't actually make the
> code smaller.  Perhaps it isn't a good helper function?

The idea for the helper was inspired by the comment Dan made to Bjorn
about Bjorn's change, as per:

  https://lore.kernel.org/driverdev-devel/20191016135002.GA24678@kadam/

It looked like a good idea to try to reduce the following:

  dev->driver && dev->driver->pm && dev->driver->pm->prepare

Into something more succinct.  Albeit, given the feedback from yourself
and Rafael, I gather that this helper is not really a good addition.

Thank you everyone and sorry for the commotion!

Krzysztof
