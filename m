Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-ej1-f65.google.com ([209.85.218.65]:37776 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgEZO5r (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 26 May 2020 10:57:47 -0400
Date: Tue, 26 May 2020 16:57:42 +0200
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH 8/8] net/iucv: Use the new device_to_pm() helper to
 access struct dev_pm_ops
Message-ID: <20200526145742.GA75990@rocinante>
References: <20200525182608.1823735-1-kw@linux.com>
 <20200525182608.1823735-9-kw@linux.com>
 <55c3d2eb-feff-bf33-235d-b89c0abef7b1@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55c3d2eb-feff-bf33-235d-b89c0abef7b1@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ursula Braun <ubraun@linux.ibm.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Felipe Balbi <balbi@kernel.org>, Julian Wiedmann <jwi@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, John Stultz <john.stultz@linaro.org>, "David S. Miller" <davem@davemloft.net>, greybus-dev@lists.linaro.org, netdev@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org

Hi Ursula,

On 20-05-26 09:07:27, Ursula Braun wrote:
> 
> 
> On 5/25/20 8:26 PM, Krzysztof Wilczyński wrote:
> > Use the new device_to_pm() helper to access Power Management callbacs
> > (struct dev_pm_ops) for a particular device (struct device_driver).
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> 
> pm support is going to be removed (for s390 in general and) for
> net/iucv/iucv.c with this net-next patch:
[...]

Good to know!  Thank you for letting me know.  I appreciate that.

Krzysztof
